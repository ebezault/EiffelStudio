#!/usr/bin/python
from os import *
from string import Template
import string
import re
import urllib2
import sgmllib
import traceback, sys

# Features:
# - Automatically generates a Eiffel wrapper functions for each Objective-C message
#   -> Converts CamalCase to underscore_names
# - Type are mapped:
#   -> basic C types to the corresponding Eiffel (expanded) type
#   -> Automatically box/unbox pointers to Objective-C objects with references to an Eiffel wrapper object
# - Special treatment for handling C arguments which are passed by value in (NSRect, NSSize and NSPoint)
# - Fetch the documentation from Apple.com and extract feature documentation

# TODO:
# - Handling of objective C routine returning a struct was not properly handled.
# - If a .h contains the declaration of different classes/protocols then they are all packed for the same class which is not correct.
# - Recognize delegate methods and treat them accordingly

### Config

dirname = "/System/Library/Frameworks/AppKit.framework/Headers"
classname = "NSColor"
#classname = "NSImage"
#dirname = "/System/Library/Frameworks/Foundation.framework/Headers"
#classname = "NSData"

# URL schema:
url = "http://developer.apple.com/documentation/Cocoa/Reference/ApplicationKit/Classes/" + classname + "_Class/Reference/Reference.html"
#url = "http://developer.apple.com/documentation/Cocoa/Reference/ApplicationKit/Classes/" + classname + "_Class/Reference/" + classname + ".html"

###

class Type:
	name = "" # String representation
	
	def __init__(self, name):
		self.name = name
		
	def canDereference(self):
		return False
	
	def Dereference(self):
		return self

class CType(Type):
	def toEiffelType(self):
		return EiffelType(EiffelTypeN(self.name))

class EiffelType(Type):
	def canDereference(self):
		if self.name.startswith("POINTER[") and self.name.endswith("]"):
			return True
		else:
			return False
	
	def Dereference(self):
		#require: canDereference()
		if self.canDereference():
		   return EiffelType(self.name[8:-1])
		raise "Can't dereference type: " + type
	
	def isExpanded(self):
		 return self.name in expandedTypes

# Represents a C or Eiffel argument to a method
class Argument:
	name = ""
	type = Type("")

	def __init__(self, name, type):
		self.name = name
		self.type = type

class CArgument(Argument):
	def to_eiffel_argument(self):
		eif_arg_name = EiffelName(self.name)
		if not eif_arg_name.startswith("a_"):
				eif_arg_name = "a_" + eif_arg_name
		return Argument(eif_arg_name, self.type.toEiffelType())

class Signature:
	def __init__(self, sig, is_static):
		self.method_name = []
		self.arguments = []
		self.is_static = is_static
		self.return_type = sig[0]
		i = 2
		while i < len(sig):
			self.arguments.append( CArgument(sig[i+1], CType(sig[i])) )
			i += 3
		self.method_name.append(sig[1])
		i = 4
		while i < len(sig):
			self.method_name.append(sig[i])
			i += 3
		
	def __str__(self):
		string = "(" + self.return_type + ")" + self.method_name[0]
		return string
		
	def isFunction(self):
		return (self.EiffelReturnType().name != "")
			
	def isStatic(self):
		return self.is_static

	def EiffelArguments(self):
		e_sig = []
		for arg in self.arguments:
			e_sig.append (arg.to_eiffel_argument())
		return e_sig
		
	def EiffelReturnType(self):
		return EiffelType(EiffelTypeN(self.return_type))
	
	def FeatureName(self):
		name = ""
		for n in self.method_name:
			name += "_" + n
		return EiffelName(name[1:])

	def InternalFeatureName(self):
		return (self.FeatureName())
		
	def MessageName(self):
		string = self.method_name[0]
		if len(self.arguments) > 0:
			string += ":"
			i = 1
			while i < len(self.arguments):
				string += self.method_name[i] + ":"
				i = i + 1
		return string

	
	def EiffelFeature(self, abstract):
		def CallInternalFeature():
			args = ["item"]
			for arg in self.EiffelArguments():
				if arg.type.canDereference():
					args.append(arg.name + ".item")
				else:
					if arg.type in expandedTypes:
						args.append(arg.name)
					else: # A non expanded type that is passed by value
						args.append(arg.name + ".item")
			if self.isFunction() and (not self.EiffelReturnType().canDereference() and not self.EiffelReturnType().isExpanded()):
				# Special treatment for non expanded types that are passed by value as a return type
				args.append("Result.item")
			result = "{" + EiffelTypeN(classname) + "_API}." + self.InternalFeatureName() + " (" + ', '.join(args) +  ")"

			if self.isFunction():
				if self.EiffelReturnType().canDereference():
					result = "create Result.share_from_pointer (" + result + ")"
				else:
					if self.EiffelReturnType().isExpanded():
						result = "Result := " + result
					else:
						result = "create Result.make\n\t\t\t" + result
					
			return result

		def Arguments():
			arguments = ""
			for arg in self.EiffelArguments():
				if arg.type.canDereference():
					arguments +=  arg.name + ": " + arg.type.Dereference().name + "; "
				else:
					arguments +=  arg.name + ": " + arg.type.name + "; "
			if arguments != "":
				arguments = " (" + arguments[0:-2] + ")"
			return arguments
		
		def Return():
			return_type = self.EiffelReturnType()
			if return_type.name == "":
				return ""
			else:
				if return_type.canDereference():
					return ": " + return_type.Dereference().name
				else:
					return ": " + return_type.name
			
		return Template('''
	$name$args$ret
			-- $comment
		do
			$body
		end''').substitute(name = self.FeatureName(),
						   args = Arguments(),
						   ret  = Return(),
						   body = CallInternalFeature(),
						   comment = abstract)

	def InternalEiffelFeature(self):
		def CallCocoa():
			string = ""
			if self.isFunction():
				string += "return "
			if self.isStatic():
				string += "[" + classname + " "
			else:
				string += "[(" + classname + "*)" + "$a_" + EiffelName(classname) + " "
			string += self.method_name[0]
			if len(self.arguments) > 0:
				arg = self.arguments[0]
				eiffelArg = self.EiffelArguments()[0]
				if eiffelArg.type.canDereference() or eiffelArg.type.isExpanded():
					string += ": " + "$" + eiffelArg.name
				else:
				    string += ": *(" + arg.type.name + "*)$" + eiffelArg.name
				i = 1
				while i < len(self.arguments):
					arg = self.arguments[i]
					eiffelArg = self.EiffelArguments()[i]
					if eiffelArg.type.canDereference() or eiffelArg.type.isExpanded():					   
						string += " " + self.method_name[i] + ": $" + eiffelArg.name
					else:
					    string += " " + self.method_name[i] + ": *(" + arg.type.name + "*)$" + eiffelArg.name
					i = i + 1
			string += "];"
			return string

		def InternalEiffelArguments():
			arguments = []
			if not self.isStatic():
				arguments.append ("a_" + EiffelName(classname) + ": " + InternalEiffelTypeName(classname))
			for i in range(len(self.arguments)):
				arguments.append (self.EiffelArguments()[i].name + ": " + InternalEiffelTypeName(self.arguments[i].type.name))
		
			ret = "; ".join(arguments)
			if len (arguments) > 0:
				return "(" + ret + ")"
			else:
				return ret

		def InternalEiffelReturn():
			if self.isFunction():
				return ": " + InternalEiffelTypeName(self.return_type)
			else:
				return ""
			
		def CocoaSignature():
			if self.isStatic():
				string = "+ "
			else:
				string = "- "
			string += "(" + self.return_type + ")"
			string += self.method_name[0]
			if len(self.arguments) > 0:
				string += ": (" + self.arguments[0].type.name + ") " + self.arguments[0].name
				i = 1
				while i < len(self.arguments):
					string += " " + self.method_name[i] + ": (" + self.arguments[0].type.name + ") " + self.arguments[i].name
					i = i + 1
			return string
	
		return Template('''
	frozen $name $args$ret
			-- $comment
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"$body"
		end''').substitute(name = self.InternalFeatureName(),
						   args = InternalEiffelArguments(),
						   ret  = InternalEiffelReturn(),
						   body = CallCocoa(),
						   comment = CocoaSignature())
	
typeMap = {
	"void": "",
	"char": "CHARACTER",
	"int": "INTEGER",
	"float": "REAL",
	"double": "REAL_64",
	"BOOL": "BOOLEAN",
	"id": "NS_OBJECT",
	"SEL": "SELECTOR",
	"NSInteger": "INTEGER",
	"NSUInteger": "INTEGER",
	"IBAction": "",
	"CGFloat" : "REAL",
	"void * /* WindowRef */": "WINDOW_REF",
	"id <NSCopying>": "NS_COPYING",
	"IconRef": "ICON_REF",
	"unsigned char": "NATURAL_8",
	"bitmapFormat": "BITMAP_FORMAT",
	"bytesPerRow": "BYTES_PER_ROW",
	"NSToolbarDisplayMode": "INTEGER",
	"NSToolbarSizeMode": "INTEGER"
	}
	
expandedTypes = ["REAL", "REAL_64", "CHARACTER", "BOOLEAN", "INTEGER"]

def EiffelTypeN(CTypeName):
	if CTypeName.endswith("*"):
		return "POINTER[" + EiffelTypeN(CTypeName[:-1].rstrip()) + "]"
	if CTypeName.startswith("const"):
		return EiffelTypeN(CTypeName[6:])
		
	if typeMap.has_key(CTypeName):
		return typeMap[CTypeName]
	else:
		if CTypeName[:2] in ["NS", "CG", "CA", "CI", "UI"]:
			return EiffelTypeName(CTypeName)
		else:
			raise "Type not found: " + CTypeName

def InternalEiffelTypeName(CTypeName):
	et = EiffelTypeN(CTypeName)
	if et in expandedTypes:
		return et
	else:
		return "POINTER"

def EiffelTypeName(name):
    return CamelCase2spaced_out(name).upper()
	
def EiffelName(name):
	return CamelCase2spaced_out(name).lower()

def CamelCase2spaced_out(stringAsCamelCase):
    """Converts a camel case string to a string separated by underscores.
    >>> CamelCase2spaced_out('TabViewItem')
    'Tab_View_Item'
    """
    
    if stringAsCamelCase is None:
        return None

    pattern = re.compile('([A-Z][A-Z][a-z])|([a-z][A-Z])')
    return pattern.sub(lambda m: m.group()[:1] + "_" + m.group()[1:], stringAsCamelCase)

def CNames2EiffelNames(name):
	i = 3
	while i < len(sig):
		sig[i] = EiffelName(sig[i])
		i += 3
	return sig


class Task:
	def __init__(self, name):
		self.name = name
		self.messages = []

	def __repr__(self):
		return "%s %r" % (self.name, self.messages)

class Message:
	def __init__(self, name):
		self.name = name
		self.abstract = ""
		self.signature = False

	def set_abstract(self, abstract):
		self.abstract = abstract.encode('utf8')

	def get_abstract(self):
		return self.abstract
		
	def get_name(self):
		return self.name
	
	def set_signature(self, signature):
		self.signature = signature
	
	def get_eiffel_wrapper_feature(self):
		if self.signature:
			return self.signature.EiffelFeature(self.abstract)
		else:
			return "-- Error generating " + self.name + ": Message signature for feature not set"
	
	def get_eiffel_api_feature(self):
		if self.signature:
			return self.signature.InternalEiffelFeature()
		else:
			return "-- Error generating " + self.name + ": Message signature for feature not set"

	
	def __repr__(self):
		return name

class AppleDocumentationParser(sgmllib.SGMLParser):
    "A simple parser class."

    def parse(self, s):
        "Parse the given string 's'."
        self.feed(s)
        self.close()
        no_messages = 0
        for task in self.tasks:
        	no_messages += len(task.messages)
        print "Parsing ended with " + str(len(self.tasks)) + " Tasks, " + str (no_messages) + " Messages"

    def __init__(self, verbose=0):
        "Initialise an object, passing 'verbose' to the superclass."

        sgmllib.SGMLParser.__init__(self, verbose)
        self.last_task = False
        self.last_message = False
        self.task_coming_up = False
        self.section = "Overview"
        self.tasks = []
        
    def start_h3 (self, attributes):
        for name, value in attributes:
            if name == "class" and value == "tasks":
                self.task_coming_up = True

    def start_a (self, attributes):
    	if self.section == "Tasks" and self.last_task:
	    	for name, value in attributes:
	    		if name == "href" and value.count(".html#//apple_ref/occ/instm/"):
    				self.last_message = Message (re.search(".*/(.*)$", value).group(1))
    				#print self.last_message.name
    				self.last_task.messages.append (self.last_message) 

    
    def start_img (self, attributes):
    	if self.section == "Tasks" and self.last_message:
	    	for name, value in attributes:
	    		if name == "abstract":
    			     self.last_message.set_abstract(value)
    
    def handle_data (self, data):
        if self.task_coming_up == True:
          	self.last_task = Task (data)
          	self.tasks.append (self.last_task)
        if data == "Tasks":
        	self.section = "Tasks"
        if data == "Instance Methods":
        	self.section = "Instance Methods"
            
    def end_h3(self):
        self.task_coming_up = False

    def get_tasks(self):
        "Return the list of Tasks."

        return self.tasks
       
    def print_tasks(self):
   		for task in self.tasks:
   			print task.name
		   	for message in task.messages:
				print "\t" + message.name

class ObjC_Class:
	def __init__(self, name):
		self.name = name
		
	def set_tasks(self, tasks):
		self.tasks = tasks
		
	def get_tasks(self):
		return self.tasks
       
	def get_message_by_name (self, name):
	   for task in self.tasks:
	   	   for message in task.messages:
	   	   	   if (name == message.get_name()):
	   	   	   	   return message
	   raise "Message " + name + " not found." 
       
# Main:
def main():
	my_class = ObjC_Class(classname)
	
	documentation = urllib2.urlopen(url).read().\
	   replace("\xe2\x80\x99", "`").replace("&#8217;", "`").\
	   replace("\xe2\x80\x94", "--").\
	   replace("\xc2", "C2C2C2").\
	   replace("\xa0", "A0A0A0").\
	   replace("\xe2", "XXX").\
	   replace("\x80", "YYY").\
	   replace("\xa6", "QQQ").\
	   replace("\x93", "939393").\
	   replace("\x94", "949494").\
	   replace("\x98", "989898").\
	   replace("\x99", "999999").\
	   replace("\x9c", "9C9C9C").\
	   replace("\x9d", "9D9D9D").\
	   decode("ascii");
	myparser = AppleDocumentationParser()
	myparser.parse (documentation)
	my_class.set_tasks (myparser.get_tasks())


	
	internal_methods = []
	
	lines = file(dirname + "/" + classname + ".h").readlines()
	
	for line in lines:
		if line.find("//") != -1:
			line = line[:line.find("//")];
		line = line.replace("\t", " ");
		for (sign, signature) in re.findall(r"^([+-]) (.*);", line):
			tokens = []
			#print (sign, signature)
			for part in re.split(":", signature):
				for (type, name) in re.findall(r"\(([a-zA-Z0-9 \*]*)\)(.*)", part):
					tokens.append(type)
					if name.count(" ") >= 1:
						tokens.extend(re.split(" ", name))
					else:
						tokens.append(name)
			while tokens.count("AVAILABLE_MAC_OS_X_VERSION_10_5_AND_LATER") > 0:
				tokens.remove("AVAILABLE_MAC_OS_X_VERSION_10_5_AND_LATER")
			while tokens.count ("__OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_3_0)") > 0:
				tokens.remove("__OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_3_0)")
			try:
				isStatic = (sign == "+")
				sig = Signature (tokens, isStatic)
				if isStatic:
					internal_methods.append (sig.InternalEiffelFeature())
				else:
				    my_class.get_message_by_name (sig.MessageName()).set_signature (sig)
			except:
				print "Failed to generate code for " + "|".join(tokens)					
				traceback.print_exc (file=sys.stdout)
				print
	
	# Output:
	for task in my_class.get_tasks():
	   print "feature -- " + task.name
	   for message in task.messages:
	   	   print message.get_eiffel_wrapper_feature()
	   print ""
	   
	print "-- API --"
	for task in my_class.get_tasks():
	   print "feature -- " + task.name
	   for message in task.messages:
	   	   print message.get_eiffel_api_feature()
	   print ""
		
	print "feature -- Static features"
	for task in my_class.get_tasks():
	   for method in internal_methods:
	   	   print method

main()
