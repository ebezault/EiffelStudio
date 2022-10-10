note
	description: "[
		This program calls a function 'Start(57)' in namespace 'nmspc' and class 'cls'
		start calls printf("%d", arg1) via pinvoke.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_5


feature -- Test

	test
		local
			lib_entry: PE_LIB
			working: DATA_CONTAINER
			nmspc, nspc0: NAMESPACE

			cls: CLS_CLASS
			i8_cls: CLS_CLASS

			ps: FIELD
			str: FIELD

			ps_init: ARRAY [NATURAL_8]
			str_init: ARRAY [NATURAL_8]

			signature_ex, signature_ep: METHOD_SIGNATURE
			signature_m, signature_es: METHOD_SIGNATURE

			tp1: CLS_TYPE
			param1: PARAM

			start, main: METHOD
			op: OPERAND
			ins: INSTRUCTION
			method_name: METHOD_NAME

		do
			create lib_entry.make ("test5", {PE_LIB}.il_only | {PE_LIB}.bits32)

			working := lib_entry.working_assembly

			create nmspc.make ("nmspc")
			working.add (nmspc)


			create cls.make ("cls", create {QUALIFIERS}.make_with_flags (
							{QUALIFIERS_ENUM}.ansi |
							{QUALIFIERS_ENUM}.sealed)
							, -1, -1)
			nmspc.add (cls)

			create i8_cls.make ("int8[]", create {QUALIFIERS}.make_with_flags (
					{QUALIFIERS_ENUM}.public |
					{QUALIFIERS_ENUM}.explicit |
					{QUALIFIERS_ENUM}.ansi |
					{QUALIFIERS_ENUM}.sealed |
					{QUALIFIERS_ENUM}.value)
					, 1, 1)


			create ps.make ("pS", create {CLS_TYPE}.make_with_container (i8_cls), create {QUALIFIERS}.make_with_flags ({QUALIFIERS_ENUM}.public | {QUALIFIERS_ENUM}.static))

			cls.add (i8_cls)
			cls.add (ps)

			ps_init := <<0x25, 0x64, 0x0a, 0>> --%d
			ps.add_initializer (ps_init)

			create signature_ex.make ("printf", {METHOD_SIGNATURE_ATTRIBUTES}.vararg, Void)
			signature_ex.set_return_type (create {CLS_TYPE}.make ({BASIC_TYPE}.i32))
			signature_ex.add_parameter (create {PARAM}.make ("format", create {CLS_TYPE}.make_with_pointer_level ({BASIC_TYPE}.Void_, 1)))
			lib_entry.add_pinvoke_reference (signature_ex, "msvcrt.dll", true)

			create signature_ep.make ("printf", {METHOD_SIGNATURE_ATTRIBUTES}.vararg, Void)
			signature_ep.set_return_type (create {CLS_TYPE}.make ({BASIC_TYPE}.i32))
			signature_ep.add_parameter (create {PARAM}.make ("format", create {CLS_TYPE}.make_with_pointer_level ({BASIC_TYPE}.Void_, 1)))
			signature_ep.add_vararg_param (create {PARAM}.make ("A_1", create {CLS_TYPE}.make_with_pointer_level ({BASIC_TYPE}.Void_, 1)))
			signature_ep.signature_parent (signature_ex)

			create signature_es.make ("Start", {QUALIFIERS_ENUM}.managed, cls)
			signature_es.set_return_type (create {CLS_TYPE}.make ({BASIC_TYPE}.Void_) )
			create param1.make ("val", create {CLS_TYPE}.make ({BASIC_TYPE}.i32))
			signature_es.add_parameter (param1)

			create start.make (signature_es,
											create {QUALIFIERS}.make_with_flags ({QUALIFIERS_ENUM}.Public |
													{QUALIFIERS_ENUM}.Static |
													{QUALIFIERS_ENUM}.hidebysig |
													{QUALIFIERS_ENUM}.Cil |
													{QUALIFIERS_ENUM}.managed), False)


			create ins.make ({CIL_OPCODES}.i_ldsflda,{OPERAND_FACTORY}.complex_operand (create {FIELD_NAME}.make (ps)))
			start.add_instruction (ins)
			create ins.make ({CIL_OPCODES}.i_ldarg,{OPERAND_FACTORY}.complex_operand (param1))
			start.add_instruction (ins)
			create ins.make ({CIL_OPCODES}.i_call,{OPERAND_FACTORY}.complex_operand (create {METHOD_NAME}.make (signature_ep)))
			start.add_instruction (ins)
			create ins.make ({CIL_OPCODES}.i_pop, Void)
			start.add_instruction (ins)
			create ins.make ({CIL_OPCODES}.i_ret, Void)
			start.add_instruction (ins)

			start.optimize (lib_entry)

			cls.add (start)

			create signature_m.make ("$Main", {QUALIFIERS_ENUM}.managed, working)
			signature_m.set_return_type (create {CLS_TYPE}.make ({BASIC_TYPE}.Void_))

			create main.make (signature_m,
											create {QUALIFIERS}.make_with_flags ({QUALIFIERS_ENUM}.private |
													{QUALIFIERS_ENUM}.Static |
													{QUALIFIERS_ENUM}.hidebysig |
													{QUALIFIERS_ENUM}.Cil |
													{QUALIFIERS_ENUM}.managed), True)

			working.add (main)

			create ins.make ({CIL_OPCODES}.i_ldc_i4,{OPERAND_FACTORY}.integer64_operand (57, {OPERAND_SIZE}.i32))
			main.add_instruction (ins)
			create ins.make ({CIL_OPCODES}.i_call,{OPERAND_FACTORY}.complex_operand (create {METHOD_NAME}.make (signature_es)))
			main.add_instruction (ins)
			create ins.make ({CIL_OPCODES}.i_ret, Void)
			main.add_instruction (ins)

			main.optimize (lib_entry)



			lib_entry.dump_output_file ("test5.il", {OUTPUT_MODE}.ilasm, False)

		end
end
