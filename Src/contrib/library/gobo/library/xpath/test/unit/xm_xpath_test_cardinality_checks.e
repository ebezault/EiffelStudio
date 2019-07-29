note

	description:

		"Test XPath zero-or-one(), exactly-one() and one-or-more() functions."

	library: "Gobo Eiffel XPath Library"
	copyright: "Copyright (c) 2005-2018, Colin Adams and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

class XM_XPATH_TEST_CARDINALITY_CHECKS

inherit

	TS_TEST_CASE
		redefine
			set_up
		end

	XM_XPATH_TYPE

	XM_XPATH_ERROR_TYPES

	XM_XPATH_SHARED_CONFORMANCE

	KL_IMPORTED_STRING_ROUTINES

	KL_SHARED_STANDARD_FILES

	KL_SHARED_FILE_SYSTEM
		export {NONE} all end

	UT_SHARED_FILE_URI_ROUTINES
		export {NONE} all end

create

	make_default

feature -- Test

	test_zero_or_one_no_error
			-- Test fn:zero-or-one ('a') returns 'a'.
		local
			an_evaluator: XM_XPATH_EVALUATOR
			evaluated_items: detachable DS_LINKED_LIST [XM_XPATH_ITEM]
		do
			create an_evaluator.make (18, False)
			an_evaluator.set_string_mode_ascii
			an_evaluator.build_static_context (languages_xml_uri.full_reference, False, False, False, True)
			assert ("Build successful", not an_evaluator.was_build_error)
			an_evaluator.evaluate ("zero-or-one ('a')")
			assert ("No evaluation error", not an_evaluator.is_error)
			evaluated_items := an_evaluator.evaluated_items
			assert ("One value", evaluated_items /= Void and then evaluated_items.count = 1)
			check asserted_above: evaluated_items /= Void then end
			if not attached {XM_XPATH_STRING_VALUE} evaluated_items.item (1) as a_string_value then
				assert ("First value is string", False)
			else
				assert ("First value is a", STRING_.same_string (a_string_value.string_value, "a"))
			end
		end

	test_zero_or_one_error
			-- Test fn:zero-or-one (('a', 'b')) is an error.
		local
			an_evaluator: XM_XPATH_EVALUATOR
		do
			create an_evaluator.make (18, False)
			an_evaluator.set_string_mode_ascii
			an_evaluator.build_static_context (languages_xml_uri.full_reference, False, False, False, True)
			assert ("Build successful", not an_evaluator.was_build_error)
			an_evaluator.evaluate ("zero-or-one (('a', 'b'))")
			assert ("Evaluation error", an_evaluator.is_error)
			assert ("Error FORG0003", STRING_.same_string (an_evaluator.error_value.code, "FORG0003"))
		end

	test_exactly_one_no_error
			-- Test fn:exactly-one ('a') returns 'a'.
		local
			an_evaluator: XM_XPATH_EVALUATOR
			evaluated_items: detachable DS_LINKED_LIST [XM_XPATH_ITEM]
		do
			create an_evaluator.make (18, False)
			an_evaluator.set_string_mode_ascii
			an_evaluator.build_static_context (languages_xml_uri.full_reference, False, False, False, True)
			assert ("Build successful", not an_evaluator.was_build_error)
			an_evaluator.evaluate ("exactly-one ('a')")
			assert ("No evaluation error", not an_evaluator.is_error)
			evaluated_items := an_evaluator.evaluated_items
			assert ("One value", evaluated_items /= Void and then evaluated_items.count = 1)
			check asserted_above: evaluated_items /= Void then end
			if not attached {XM_XPATH_STRING_VALUE} evaluated_items.item (1) as a_string_value then
				assert ("First value is string", False)
			else
				assert ("First value is a", STRING_.same_string (a_string_value.string_value, "a"))
			end
		end

	test_exactly_one_error
			-- Test fn:exactly-one (('a', 'b')) is an error.
		local
			an_evaluator: XM_XPATH_EVALUATOR
		do
			create an_evaluator.make (18, False)
			an_evaluator.set_string_mode_ascii
			an_evaluator.build_static_context (languages_xml_uri.full_reference, False, False, False, True)
			assert ("Build successful", not an_evaluator.was_build_error)
			an_evaluator.evaluate ("exactly-one (('a', 'b'))")
			assert ("Evaluation error", an_evaluator.is_error)
			assert ("Error FORG0004", STRING_.same_string (an_evaluator.error_value.code, "FORG0005"))
		end

	test_one_or_more_no_error
			-- Test fn:one-or-more ('a') returns 'a'.
		local
			an_evaluator: XM_XPATH_EVALUATOR
			evaluated_items: detachable DS_LINKED_LIST [XM_XPATH_ITEM]
		do
			create an_evaluator.make (18, False)
			an_evaluator.set_string_mode_ascii
			an_evaluator.build_static_context (languages_xml_uri.full_reference, False, False, False, True)
			assert ("Build successful", not an_evaluator.was_build_error)
			an_evaluator.evaluate ("one-or-more ('a')")
			assert ("No evaluation error", not an_evaluator.is_error)
			evaluated_items := an_evaluator.evaluated_items
			assert ("One value", evaluated_items /= Void and then evaluated_items.count = 1)
			check asserted_above: evaluated_items /= Void then end
			if not attached {XM_XPATH_STRING_VALUE} evaluated_items.item (1) as a_string_value then
				assert ("First value is string", False)
			else
				assert ("First value is a", STRING_.same_string (a_string_value.string_value, "a"))
			end
		end

	test_one_or_more_error
			-- Test fn:one-or-more (()) is an error.
		local
			an_evaluator: XM_XPATH_EVALUATOR
		do
			create an_evaluator.make (18, False)
			an_evaluator.set_string_mode_ascii
			an_evaluator.build_static_context (languages_xml_uri.full_reference, False, False, False, True)
			assert ("Build successful", not an_evaluator.was_build_error)
			an_evaluator.evaluate ("one-or-more (())")
			assert ("Evaluation error", an_evaluator.is_error)
			assert ("Error FORG0005", STRING_.same_string (an_evaluator.error_value.code, "FORG0004"))
		end

	set_up
		do
			conformance.set_basic_xslt_processor
		end

feature {NONE} -- Implementation

	data_dirname: STRING
			-- Name of directory containing data files
		once
			Result := file_system.nested_pathname ("${GOBO}", <<"library", "xpath", "test", "unit", "data">>)
			Result := Execution_environment.interpreted_string (Result)
		ensure
			data_dirname_not_void: Result /= Void
			data_dirname_not_empty: not Result.is_empty
		end

	languages_xml_uri: UT_URI
			-- URI of file 'languages.xml'
		local
			a_path: STRING
		once
			a_path := file_system.pathname (data_dirname, "languages.xml")
			Result := File_uri.filename_to_uri (a_path)
		ensure
			languages_xml_uri_not_void: Result /= Void
		end

end


