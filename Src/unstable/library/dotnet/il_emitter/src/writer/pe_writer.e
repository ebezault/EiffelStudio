note
	description: "This is the main class for generating a PE file"
	date: "$Date$"
	revision: "$Revision$"

class
	PE_WRITER

inherit

	PE_TABLE_CONSTANTS

	REFACTORING_HELPER

create
	make

feature {NONE} -- Initialization

		--  the maximum number of PE objects we will generate
		--  this includes the following:
		--  	.text / cildata
		--   	.reloc (for the single necessary reloc entry)
		--    	.rsrc (not implemented yet, will hold version info record)

	make (is_exe: BOOLEAN; is_gui: BOOLEAN; a_snk_file: STRING_32)
			--
		do
			dll := not is_exe
			gui := is_gui
			file_align := 0x200
			object_align := 0x2000
			image_base := 0x400000
			language := 0x4b0
			create snk_file.make_from_string (a_snk_file)
			create meta_header.make_from_other (meta_header1)
			create string_map.make (0)
			create tables.make_filled (create {DNL_TABLE}.make, 1, Max_tables)
			create {ARRAYED_LIST [PE_METHOD]} methods.make (0)
			create rva.make
			create guid.make
			create blob.make
			create us.make
			create strings.make
			create rsa_encoder
			create stream_headers.make_filled (0, 5, 2)
		ensure
			dll_set: dll = not is_exe
			gui_set: gui = is_gui
			object_base_zero: object_base = 0
			value_base_zero: value_base = 0
			enum_base_zero: enum_base = 0
			system_index_zero: system_index = 0
			entry_point_zero: entry_point = 0
			param_attribute_type_zero: param_attribute_type = 0
			param_attribute_data_zero: param_attribute_data = 0
			file_align_set: file_align = 0x200
			object_align_set: object_align = 0x2000
			image_base_set: image_base = 0x400000
			language_set: language = 0x4b0
			pe_header_void: pe_header = Void
			pe_object_void: pe_objects = Void
			cor20_header_void: cor20_header = Void
			tables_header_void: tables_header = Void
			snk_file_set: snk_file.same_string_general (a_snk_file)
			snk_len_zero: snk_len = 0
			output_file_vooid: output_file = Void
			pe_base_zero: pe_base = 0
			cor_base_zero: cor_base = 0
			snk_base = 0
			string_map_empty: string_map.is_empty
			methods_empty: methods.is_empty
		end

feature -- Constant

	RTV_STRING: STRING = "v4.0.30319"
			--this is a CUSTOM version string for microsoft.
			--standard CIL differs

feature -- Access

	snk_base: NATURAL assign set_snk_base
			-- `snk_base'

	cor_base: NATURAL assign set_cor_base
			-- `cor_base'

	pe_base: NATURAL assign set_pe_base
			-- `pe_base'

	snk_len: NATURAL assign set_snk_len
			-- `snk_len'

	snk_file: STRING_32
			-- `snk_file'

	tables_header: detachable PE_DOTNET_META_TABLES_HEADER
			-- `tables_header'

	cor20_header: detachable PE_DOTNET_COR20_HEADER
			-- `cor20_header'

	pe_objects: detachable LIST [PE_OBJECT]
			-- `pe_objects'

	pe_header: detachable PE_HEADER
			-- `pe_header'

	language: NATURAL_32
			-- `language'
			-- C++ defined as four bytes
			-- DWord language_;

	image_base: NATURAL assign set_image_base
			-- `image_base'

	object_align: NATURAL assign set_object_align
			-- `object_align'

	file_align: NATURAL assign set_file_align
			-- `file_align'

	param_attribute_data: NATURAL_64 assign set_param_attribute_data
			-- `param_attribute_data'

	param_attribute_type: NATURAL_64 assign set_param_attribute_type
			-- `param_attribute_type'

	entry_point: NATURAL_64 assign set_entry_point
			-- `entry_point'

	system_index: NATURAL_64 assign set_system_index
			-- `system_index'

	enum_base: NATURAL_64 assign set_enum_base
			-- `enum_base'

	value_base: NATURAL_64 assign set_value_base
			-- `value_base'

	object_base: NATURAL_64 assign set_object_base
			-- `object_base'

	gui: BOOLEAN assign set_gui
			-- `gui'

	dll: BOOLEAN assign set_dll
			-- `dll'

	output_file: detachable FILE_STREAM

	assembly_version: detachable ARRAY [NATURAL_16]
			--| C++ defined as Word assemblyVersion_[4];
			--| Word is two bytes.

	file_version: detachable ARRAY [NATURAL_16]

	product_version: detachable ARRAY [NATURAL_16]

	stream_headers: ARRAY2 [NATURAL_64]

	rsa_encoder: CIL_RSA_ENCODER

	mzh_header: ARRAY [NATURAL_8]
			-- MS-DOS header
		do
			Result :={ARRAY [NATURAL_8]} <<
					0x4d, 0x5a, 0x90, 0x00, 0x03, 0x00, 0x00, 0x00,
					0x04, 0x00, 0x00, 0x00, 0xFF, 0xFF, 0x00, 0x00,
					0xb8, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
					0x40, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
					0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
					0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
					0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
					0x00, 0x00, 0x00, 0x00, 0x80, 0x00, 0x00, 0x00,

					0x0e, 0x1f, 0xba, 0x0e, 0x00, 0xb4, 0x09, 0xcd,
					0x21, 0xb8, 0x01, 0x4c, 0xcd, 0x21, 0x54, 0x68,
					0x69, 0x73, 0x20, 0x70, 0x72, 0x6f, 0x67, 0x72,
					0x61, 0x6d, 0x20, 0x63, 0x61, 0x6e, 0x6e, 0x6f,
					0x74, 0x20, 0x62, 0x65, 0x20, 0x72, 0x75, 0x6e,
					0x20, 0x69, 0x6e, 0x20, 0x44, 0x4f, 0x53, 0x20,
					0x6d, 0x6f, 0x64, 0x65, 0x2e, 0x0d, 0x0d, 0x0a,
					0x24, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00>>
		ensure
			instance_free: class
		end

	meta_header: DOTNET_META_HEADER

	stream_names: ARRAY [STRING_32]
		do
			Result := {ARRAY [STRING_32]}<<"#~", "#Strings", "#US", "#GUID", "#Blob">>
		ensure
			instance_free: class
		end

	default_us: ARRAY [NATURAL_8]
			-- defined as static Byte defaultUS_[];
			--| Byte defined as 1 byte.
		do
			Result := {ARRAY [NATURAL_8]}<<0, 3, 0x20, 0, 0>>
			Result.conservative_resize_with_default (0, 1, 8)
		end

	string_map: STRING_TABLE [NATURAL_64]
			-- reflection of the String stream so that we can keep from doing duplicates.
			-- right now we don't check duplicates on any of the other streams...

	tables: ARRAY [DNL_TABLE]
			-- tables that can appear in a PE file.

	methods: LIST [PE_METHOD]

	strings: PE_POOL

	us: PE_POOL

	blob: PE_POOL

	guid: PE_POOL

	rva: PE_POOL

feature {NONE} -- Implemenation

	meta_header1: DOTNET_META_HEADER
		do
			create Result
			Result.set_signature (1)
			Result.set_major (1)
			Result.set_minor (0)
		ensure
			instance_free: class
		end

feature -- Element change

	set_snk_base (a_snk_base: like snk_base)
			-- Assign `snk_base' with `a_snk_base'.
		do
			snk_base := a_snk_base
		ensure
			snk_base_assigned: snk_base = a_snk_base
		end

	set_cor_base (a_cor_base: like cor_base)
			-- Assign `cor_base' with `a_cor_base'.
		do
			cor_base := a_cor_base
		ensure
			cor_base_assigned: cor_base = a_cor_base
		end

	set_pe_base (a_pe_base: like pe_base)
			-- Assign `pe_base' with `a_pe_base'.
		do
			pe_base := a_pe_base
		ensure
			pe_base_assigned: pe_base = a_pe_base
		end

	set_snk_len (a_snk_len: like snk_len)
			-- Assign `snk_len' with `a_snk_len'.
		do
			snk_len := a_snk_len
		ensure
			snk_len_assigned: snk_len = a_snk_len
		end

	set_snk_file (a_snk_file: like snk_file)
			-- Assign `snk_file' with `a_snk_file'.
		do
			snk_file := a_snk_file
		ensure
			snk_file_assigned: snk_file = a_snk_file
		end

	set_tables_header (a_tables_header: like tables_header)
			-- Assign `tables_header' with `a_tables_header'.
		do
			tables_header := a_tables_header
		ensure
			tables_header_assigned: tables_header = a_tables_header
		end

	set_cor20_header (a_cor20_header: like cor20_header)
			-- Assign `cor20_header' with `a_cor20_header'.
		do
			cor20_header := a_cor20_header
		ensure
			cor20_header_assigned: cor20_header = a_cor20_header
		end

	set_pe_object (a_pe_object: like pe_objects)
			-- Assign `pe_objects' with `a_pe_object'.
		do
			pe_objects := a_pe_object
		ensure
			pe_object_assigned: pe_objects = a_pe_object
		end

	set_pe_header (a_pe_header: like pe_header)
			-- Assign `pe_header' with `a_pe_header'.
		do
			pe_header := a_pe_header
		ensure
			pe_header_assigned: pe_header = a_pe_header
		end

	set_language (a_language: like language)
			-- Assign `language' with `a_language'.
		do
			language := a_language
		ensure
			language_assigned: language = a_language
		end

	set_image_base (an_image_base: like image_base)
			-- Assign `image_base' with `an_image_base'.
		do
			image_base := an_image_base
		ensure
			image_base_assigned: image_base = an_image_base
		end

	set_object_align (an_object_align: like object_align)
			-- Assign `object_align' with `an_object_align'.
		do
			object_align := an_object_align
		ensure
			object_align_assigned: object_align = an_object_align
		end

	set_file_align (a_file_align: like file_align)
			-- Assign `file_align' with `a_file_align'.
		do
			file_align := a_file_align
		ensure
			file_align_assigned: file_align = a_file_align
		end

	set_param_attribute_data (a_param_attribute_data: like param_attribute_data)
			-- Assign `param_attribute_data' with `a_param_attribute_data'.
		do
			param_attribute_data := a_param_attribute_data
		ensure
			param_attribute_data_assigned: param_attribute_data = a_param_attribute_data
		end

	set_param_attribute_type (a_param_attribute_type: like param_attribute_type)
			-- Assign `param_attribute_type' with `a_param_attribute_type'.
		do
			param_attribute_type := a_param_attribute_type
		ensure
			param_attribute_type_assigned: param_attribute_type = a_param_attribute_type
		end

	set_entry_point (an_entry_point: like entry_point)
			-- Assign `entry_point' with `an_entry_point'.
		do
			entry_point := an_entry_point
		ensure
			entry_point_assigned: entry_point = an_entry_point
		end

	set_system_index (a_system_index: like system_index)
			-- Assign `system_index' with `a_system_index'.
		do
			system_index := a_system_index
		ensure
			system_index_assigned: system_index = a_system_index
		end

	set_enum_base (an_enum_base: like enum_base)
			-- Assign `enum_base' with `an_enum_base'.
		do
			enum_base := an_enum_base
		ensure
			enum_base_assigned: enum_base = an_enum_base
		end

	set_value_base (a_value_base: like value_base)
			-- Assign `value_base' with `a_value_base'.
		do
			value_base := a_value_base
		ensure
			value_base_assigned: value_base = a_value_base
		end

	set_object_base (an_object_base: like object_base)
			-- Assign `object_base' with `an_object_base'.
		do
			object_base := an_object_base
		ensure
			object_base_assigned: object_base = an_object_base
		end

	set_gui (a_gui: like gui)
			-- Assign `gui' with `a_gui'.
		do
			gui := a_gui
		ensure
			gui_assigned: gui = a_gui
		end

	set_dll (a_dll: like dll)
			-- Assign `dll' with `a_dll'.
		do
			dll := a_dll
		ensure
			dll_assigned: dll = a_dll
		end

feature -- Element Change

	add_table_entry (a_entry: PE_TABLE_ENTRY_BASE): NATURAL_64
			-- add an entry to one of the tables
			-- note the data for the table will be a class inherited from TableEntryBase,
			--  and this class will self-report the table index to use
		local
			n: INTEGER
		do
			n := a_entry.table_index
			tables [n].table.force (a_entry)
			debug ("pe_writer")
					-- Check C++ code  PEWriter::AddTableEntry
				to_implement ("Double check if its requried.")
			end
			Result := tables [n].table.count.to_natural_32
		end

	add_method (a_method: PE_METHOD)
			-- add a method entry to the output list.  Note that Index_(D methods won't be added here.
		do
			if a_method.flags & {PE_METHOD_CONSTANTS}.EntryPoint /= 0 then
				if entry_point /= 0 then
					{EXCEPTIONS}.raise (generator + "Multiple entry points")
				else
					entry_point := a_method.method_def | ({PE_TABLES}.tMethodDef.value |<< 24)
				end
			end
			methods.force (a_method)
		end

feature -- Status Report

	is_entry_point: BOOLEAN
		do
			Result := entry_point /= 0
		end

feature -- Stream functions

	hash_string (a_utf8: STRING_32): NATURAL_64
			-- return the stream index
			--| TODO add a precondition to verify a_utf8 is a valid UTF_8
		local
			l_str: STRING_8
			l_converter: BYTE_ARRAY_CONVERTER
		do
			if string_map.has (a_utf8) and then
				attached string_map.item (a_utf8) as l_val then
				Result := l_val
			else
				if strings.size = 0 then
					strings.increment_size
				end
				strings.confirm (strings.size + 1)
				Result := strings.size
				l_str := {UTF_CONVERTER}.utf_32_string_to_utf_8_string_8 (a_utf8)
				create l_converter.make_from_bin_string (l_str)

				strings.copy_data (strings.size.to_integer_32, l_converter.to_natural_8_array, (l_str.count + 1).to_natural_64)
				strings.increment_size_by ((a_utf8.count + 1).to_natural_32)
				string_map.force (Result, a_utf8)
			end
		end

	hash_us (a_str: STRING_32; a_len: INTEGER): NATURAL_64
			-- return the stream index
		local
			l_flag: INTEGER
			l_blob_len: INTEGER
			n: INTEGER
		do
			if us.size = 0 then
				us.increment_size
			end
			us.confirm ((a_len * 2 + 5).to_natural_32)
			Result := us.size
			l_blob_len := a_len * 2 + 1
			if l_blob_len < 0x80 then
				us.base [us.size.to_integer_32] := l_blob_len.to_natural_8
				us.increment_size
			elseif l_blob_len <= 0x3fff then
				us.base[us.size.to_integer_32] := ((l_blob_len |>> 8) | 0x80).to_natural_8
				us.increment_size
        		us.base[us.size.to_integer_32] := l_blob_len.to_natural_8
        		us.increment_size
        	else
		        l_blob_len := l_blob_len & 0x1fffffff
		        us.base[us.size.to_integer_32] := ((l_blob_len |>> 24) | 0xc0).to_natural_8
		        us.increment_size
		        us.base[us.size.to_integer_32] := (l_blob_len |>> 16).to_natural_8
		        us.increment_size
		        us.base[us.size.to_integer_32] := (l_blob_len |>> 8).to_natural_8
		        us.increment_size
		        us.base[us.size.to_integer_32] := (l_blob_len |>> 0).to_natural_8
		    	us.increment_size
		    end

			across a_str as i loop
				n := i.code
		        if (n & 0xff00)/= 0 then
		            l_flag := 1
		        elseif (n <= 8 or else (n >= 0x0e and then n < 0x20) or else n = 0x27 or else n = 0x2d or else n = 0x7f) then
		            l_flag := 1
		        end
		        us.base[us.size.to_integer_32] := (n & 0xff).to_natural_8
		        us.increment_size
		        us.base[us.size.to_integer_32] := (n |>> 8).to_natural_8
		        us.increment_size
		    end
		    us.base [us.size.to_integer_32] := l_flag.to_natural_8
		    us.increment_size
		end

	hash_guid (a_guid: ARRAY [NATURAL_8]): NATURAL_64
			-- return the stream index
		do
			guid.confirm (16) -- 128 // 8
			Result := guid.size
			guid.copy_data (Result.to_integer_32, a_guid, 16)
			guid.increment_size_by (16)
			Result := Result // 16 + 1
		end

	hash_blob (a_blob_data: ARRAY [NATURAL_8]; a_blob_len: NATURAL_64): NATURAL_64
			-- return the stream index.
		local
			l_rv: NATURAL_64
			l_blob_len: NATURAL_64
		do
			l_blob_len := a_blob_len
			if blob.size = 0 then
				blob.increment_size
			end
			blob.confirm (a_blob_len + 4)
			l_rv := blob.size
			if a_blob_len < 0x80 then
				blob.base [blob.size.to_integer_32] := l_blob_len.to_natural_8
				blob.increment_size
			elseif a_blob_len <= 0x3fff then
				blob.base [blob.size.to_integer_32] := ((l_blob_len |>> 8) | 0x80).to_natural_8
				blob.increment_size
				blob.base [blob.size.to_integer_32] := l_blob_len.to_natural_8
				blob.increment_size
			else
				l_blob_len := (l_blob_len & 0x1fffffff).to_natural_8
				blob.base [blob.size.to_integer_32] := ((l_blob_len |>> 24) | 0xc0).to_natural_8
				blob.increment_size
				blob.base [blob.size.to_integer_32] := (l_blob_len |>> 16).to_natural_8
				blob.increment_size
				blob.base [blob.size.to_integer_32] := (l_blob_len |>> 8).to_natural_8
				blob.increment_size
				blob.base [blob.size.to_integer_32] := (l_blob_len |>> 0).to_natural_8
				blob.increment_size
			end
			blob.copy_data ((blob.size).to_integer_32, a_blob_data, l_blob_len)
			blob.increment_size_by (l_blob_len.to_natural_8)
			Result := l_rv
		end

feature -- Various Operations

	RVA_bytes (a_bytes: ARRAY [NATURAL_8]; a_data: NATURAL_64): NATURAL_64
			--  this is the 'cildata' contents.   Again we emit into the cildata and it returns the offset in
			--  the cildata to use.  It does NOT return the rva immediately, that is calculated later
		do
			to_implement ("Add implementation")
		end

	set_base_classes (a_object_index: NATURAL_64; a_value_index: NATURAL_64; a_enum_index: NATURAL_64; a_system_index: NATURAL_64)
			--  Set the indexes of the various classes which can be extended to make new classes
			--  these are typically in the typeref table
			--  Also set the index of the System namespace entry which is t

		do
			{PE_SIGNATURE_GENERATOR_HELPER}.set_object_type (a_object_index)
			object_base := a_object_index
			value_base := a_value_index
			enum_base := a_enum_index
			system_index := a_system_index
		ensure
			object_base_set: object_base = a_object_index
			value_index_set: value_base = a_value_index
			enum_base_set: enum_base = a_enum_index
			system_index_set: system_index = a_system_index
		end

	set_param_attribute (a_param_attribute_type: NATURAL_64; a_param_attribute_data: NATURAL_64)
			-- this sets the data for the paramater attribute we support
			-- we aren't generally supporting attributes in this version but we do need to be able to
			-- set a single attribute that means a function has a variable length argument list
		do
			param_attribute_data := a_param_attribute_data
			param_attribute_type := a_param_attribute_type
		ensure
			param_attribute_data_set: param_attribute_data = a_param_attribute_data
			param_attribute_type_set: param_attribute_type = a_param_attribute_type
		end

	create_guid (a_guid: ARRAY [NATURAL_8])
		local
			l_mp: MANAGED_POINTER
		do
				-- At the moment this code uses a C++ wrapper.
				-- double check how to use UUID.
			create l_mp.make (16)
			c_create_guid (l_mp.item)
			a_guid.make_from_array (l_mp.read_array (0, 16))
		end

	next_table_index (a_table: INTEGER): NATURAL
		do
				-- TODO double check if we need the + 1.
			Result := (tables[a_table].size + 1).to_natural_32
		end

	write_file (a_corFlags: INTEGER; a_out: FILE_STREAM): BOOLEAN
		do
			output_file := a_out
			if not is_entry_point and not dll then
				{EXCEPTIONS}.raise (generator + " Missing Entry Point ")
			end
			calculate_objects (a_corflags)
		end

	hash_part_of_file (a_context: CIL_SHA1_CONTEXT; a_offset: NATURAL; a_len: NATURAL)
		do
			to_implement ("Add implementation")
		end

	cildata_rva: NATURAL_32
			-- TODO double check.
			-- another thing that makes this lib not thread safe, the RVA for
			-- the beginning of the .data section gets put here after it is calculated
			--| defined as
			--|  static DWord cildata_rva_;
			--|  DWord =:: four bytes

feature -- Operations

	calculate_objects (a_cor_flags: INTEGER)
			-- this calculates various addresses and offsets that will be used and referenced
			-- when we actually generate the data.   This must be kept in sync with the code to
			-- generate data
		require
			pe_header_void: pe_header = Void
		local
			l_pe_header: PE_HEADER
			l_pe_objects: like pe_objects
			l_n: INTEGER
			l_current_rva: NATURAL_64
			l_core_20_header: PE_DOTNET_COR20_HEADER
			l_last_rva: NATURAL_64
			l_end: INTEGER
			l_data: CIL_SEH_DATA
			l_edata: CIL_SEH_DATA
			l_exit: BOOLEAN
			l_etiny: BOOLEAN
			l_tables_header: PE_DOTNET_META_TABLES_HEADER
			l_counts: ARRAY [NATURAL_64]
			l_buffer: ARRAY [NATURAL_8]
			l_sect: INTEGER
		do
				-- pe_header setup.
			check pe_header = Void end
			create l_pe_header
			l_pe_header.signature := {PE_HEADER_CONSTANTS}.PESIG
			l_pe_header.cpu_type := {PE_HEADER_CONSTANTS}.pe_intel386.to_integer_16
			l_pe_header.magic := {PE_HEADER_CONSTANTS}.pe_magicnum.to_natural_8
			l_pe_header.nt_hdr_size := 0xe0
				-- optional header size
			l_pe_header.flags := ({PE_HEADER_CONSTANTS}.pe_file_executable + if dll then {PE_HEADER_CONSTANTS}.pe_file_library else 0 end).to_natural_8
			l_pe_header.linker_major_version := 6
			l_pe_header.object_align := object_align.to_integer_32
			l_pe_header.file_align := file_align.to_integer_32
			l_pe_header.image_base := image_base.to_integer_32
			l_pe_header.os_major_version := 4
			l_pe_header.subsys_major_version := 4
			l_pe_header.subsystem := (if gui then {PE_HEADER_CONSTANTS}.PE_SUBSYS_WINDOWS else {PE_HEADER_CONSTANTS}.PE_SUBSYS_CONSOLE end).to_integer_16
			l_pe_header.dll_flags := 0x8540
				-- magic!
			l_pe_header.stack_size := 0x100000
			l_pe_header.stack_commit := 0x1000
			l_pe_header.heap_size := 0x100000
			l_pe_header.heap_commit := 0x1000
			l_pe_header.num_rvas := 16

			l_pe_header.num_objects := 2
			l_pe_header.header_size := mzh_header.count + {PE_HEADER}.size_of + l_pe_header.num_objects * {PE_OBJECT}.size_of

			if (l_pe_header.header_size \\ file_align.to_integer_32) /= 0 then
				l_pe_header.header_size := l_pe_header.header_size + (file_align.to_integer_32 - (l_pe_header.header_size \\ file_align.to_integer_32))
			end

			l_pe_header.time := number_of_seconds_since_epoch

				-- pe_objects setup
			check pe_objects = Void end

			create {ARRAYED_LIST [PE_OBJECT]} l_pe_objects.make_filled (max_pe_objects)

			l_n := 1
			l_pe_objects [l_n].name := ".text"
			l_pe_objects [l_n].flags := {PE_HEADER_CONSTANTS}.winf_execute | {PE_HEADER_CONSTANTS}.winf_code | {PE_HEADER_CONSTANTS}.winf_readable

			l_n := l_n + 1
			l_pe_objects [l_n].name := ".reloc"
			l_pe_objects [l_n].flags := {PE_HEADER_CONSTANTS}.WINF_INITDATA | {PE_HEADER_CONSTANTS}.WINF_READABLE | {PE_HEADER_CONSTANTS}.WINF_DISCARDABLE
			l_current_rva := mzh_header.count.to_natural_32 + {PE_HEADER}.size_of.to_natural_32 + l_pe_header.num_objects.to_natural_32 * {PE_OBJECT}.size_of.to_natural_32
			if (l_current_rva \\ object_align) /= 0 then
				l_current_rva := l_current_rva + object_align - (l_current_rva \\ object_align)
			end

			l_pe_objects [1].virtual_addr := l_current_rva.to_integer_32
			l_pe_objects [1].raw_ptr := l_pe_header.header_size
			l_pe_header.code_base := l_current_rva.to_integer_32
			l_pe_header.iat_rva := l_current_rva.to_integer_32
			l_pe_header.iat_size := 8
			l_pe_header.com_size := {PE_DOTNET_COR20_HEADER}.size_of
			l_current_rva := l_current_rva + l_pe_header.com_size.to_natural_32

				-- cor20_header setup
			check cor20_header = Void end
			create l_core_20_header
			l_core_20_header.cb := {PE_DOTNET_COR20_HEADER}.size_of.to_natural_32
			l_core_20_header.major_runtime_version := 2
			l_core_20_header.minor_runtime_version := 5

				-- standard CIL expects ONLY bit 0, we are using bit 1 as well
				-- for interoperability with the microsoft runtimes.

			l_core_20_header.flags := a_cor_flags.to_natural_32
			l_core_20_header.entry_point_token := entry_point.to_natural_32

			if not snk_file.is_empty then
				to_implement ("Implement snkfile code")
			end

			cildata_rva := l_current_rva.to_natural_32
			if rva.size /= 0 then
				l_current_rva := l_current_rva + rva.size
				if l_current_rva \\ 8 /= 0 then
					l_current_rva := l_current_rva + 8 - (l_current_rva \\ 8)
				end
			end

			l_last_rva := l_current_rva

			across methods as method loop
				if method.flags & {PE_METHOD_CONSTANTS}.cil /= 0 then
					if (method.flags & 3) = {PE_METHOD_CONSTANTS}.tinyformat then
						method.set_rva (l_current_rva)
						l_last_rva := l_current_rva
						l_current_rva := l_current_rva + 1
					else
						if (l_current_rva \\ 4) /= 0 then
							l_current_rva := l_current_rva + 4 - (l_current_rva \\ 4)
						end
						method.set_rva (l_current_rva)
						l_last_rva := l_current_rva
						l_current_rva := l_current_rva + 12
					end
					l_current_rva := l_current_rva + method.code_size
					if not method.seh_data.is_empty then
						if (l_current_rva \\ 4) /= 0 then
							l_current_rva := l_current_rva + 4 - (l_current_rva \\ 4)
						end
						l_end := 1
						l_data := method.seh_data [l_end]
						from
						until
							l_end > method.seh_data.count or else L_exit
						loop
							l_edata := method.seh_data [l_end]

							l_etiny := l_edata.try_offset < 65536 and then l_edata.try_length < 256 and then
								l_edata.handler_offset < 65536 and then l_edata.handler_length < 256

							if not l_etiny then
								l_exit := true
							else
								l_end := l_end + 1
							end
						end
						if l_end > method.seh_data.count and then method.seh_data.count < 21 then
							l_current_rva := l_current_rva + 4 + (method.seh_data.count * 12).to_natural_32
						else
							l_current_rva := l_current_rva + 4 + (method.seh_data.count * 24).to_natural_32
						end
					end
				else
					method.set_rva (0)
				end
			end

			if (l_current_rva \\ 4) /= 0 then
				l_current_rva := l_current_rva + 4 - (l_current_rva \\ 4)
			end

			l_core_20_header.metadata [1] := l_current_rva.to_natural_32
				-- metadata root

			l_current_rva := l_current_rva + 12
				-- metadata header

			l_current_rva := l_current_rva + 4
				-- version size

			l_current_rva := l_current_rva + compute_rtv_string_size

			if (l_current_rva \\ 4) /= 0 then
				l_current_rva := l_current_rva + 4 - (l_current_rva \\ 4)
			end

			l_current_rva := l_current_rva + 2
				-- flags

			l_current_rva := l_current_rva + 2
				-- streams, will be 5 in our implementation
				-- check stream_names feature.

			across stream_names as elem loop
				l_current_rva := l_current_rva + (elem.count + 1).to_natural_32
				if (l_current_rva \\ 4) /= 0 then
					l_current_rva := l_current_rva + 4 - (l_current_rva \\ 4)
				end
			end

			stream_headers [1, 1] := l_current_rva - l_core_20_header.metadata [1]

				-- tables_header set_up
			check tables_header = Void end
			create l_tables_header
			l_tables_header.major_version := 2
			l_tables_header.minor_version := 1
			l_tables_header.mask_sorted := ({INTEGER_64} 0x1600 |<< 32) + 0x3325FA00
			if strings.size >= 65536 then
				l_tables_header.heap_offset_sizes := l_tables_header.heap_offset_sizes | 1
			end
			if guid.size >= 65536 then
				l_tables_header.heap_offset_sizes := l_tables_header.heap_offset_sizes | 2
			end
			if blob.size >= 65536 then
				l_tables_header.heap_offset_sizes := l_tables_header.heap_offset_sizes | 4
			end

			l_n := 0
			create l_counts.make_filled (0, 1, Max_tables + Extra_indexes)
			l_counts [t_string] := strings.size
			l_counts [t_us] := us.size
			l_counts [t_guid] := guid.size
			l_counts [t_blob] := blob.size

			across 0 |..| (max_tables - 1) as ic loop
				if not tables [ic + 1].is_empty then
					l_counts [ic + 1] := tables [ic + 1].size.to_natural_32
					l_tables_header.mask_valid := l_tables_header.mask_valid | ({INTEGER_64} 1 |<< ic)
					l_n := l_n + 1
				end
			end
			l_current_rva := l_current_rva + {PE_DOTNET_META_TABLES_HEADER}.size_of.to_natural_32
				-- tables header
			l_current_rva := l_current_rva + (l_n * {PLATFORM}.natural_32_bytes).to_natural_32
				--table counts
				-- Dword is 4 bytes.

			across 0 |..| (max_tables - 1) as ic loop
				if l_counts [ic + 1] /= 0 then
					create l_buffer.make_filled (0, 1, 512)
					l_n := tables [ic + 1].table [1].render (l_counts, l_buffer).to_integer_32
					l_n := l_n * (l_counts [ic + 1]).to_integer_32
					l_current_rva := l_current_rva + l_n.to_natural_32
				end
			end

			if (l_current_rva \\ 4) /= 0 then
				l_current_rva := l_current_rva + 4 - (l_current_rva \\ 4)
			end

			stream_headers [1, 2] := l_current_rva - stream_headers [1, 1] - l_core_20_header.metadata [1]
			stream_headers [2, 1] := l_current_rva - l_core_20_header.metadata [1]
			l_current_rva := l_current_rva + strings.size

			if (l_current_rva \\ 4) /= 0 then
				l_current_rva := l_current_rva + 4 - (l_current_rva \\ 4)
			end

			stream_headers [2, 2] := l_current_rva - stream_headers [2, 1] - l_core_20_header.metadata [1]
			stream_headers [3, 1] := l_current_rva - l_core_20_header.metadata [1]
			if us.size = 0 then
				l_current_rva := l_current_rva + default_us.count.to_natural_32
					-- US May be empty in our implementation we put an empty string there
			else
				l_current_rva := l_current_rva + us.size
			end

				-- TODO refactor this code into a feature.
			if (l_current_rva \\ 4) /= 0 then
				l_current_rva := l_current_rva + 4 - (l_current_rva \\ 4)
			end

			stream_headers [3, 2] := l_current_rva - stream_headers [3, 1] - l_core_20_header.metadata [1]
			stream_headers [4, 1] := l_current_rva - l_core_20_header.metadata [1]
			l_current_rva := l_current_rva + guid.size

			if (l_current_rva \\ 4) /= 0 then
				l_current_rva := l_current_rva + 4 - (l_current_rva \\ 4)
			end

			stream_headers [4, 2] := l_current_rva - stream_headers [4, 1] - l_core_20_header.metadata [1]
			stream_headers [5, 1] := l_current_rva - l_core_20_header.metadata [1]
			l_current_rva := l_current_rva + blob.size

			if (l_current_rva \\ 4) /= 0 then
				l_current_rva := l_current_rva + 4 - (l_current_rva \\ 4)
			end

			stream_headers [5, 2] := l_current_rva - stream_headers [5, 1] - l_core_20_header.metadata [1]
			l_core_20_header.metadata [2] := l_current_rva.to_natural_32 - l_core_20_header.metadata [1]
			l_pe_header.import_rva := l_current_rva.to_integer_32
			l_current_rva := l_current_rva + ({PE_IMPORT_DIR}.size_of * 2).to_natural_32 + 8

			if (l_current_rva \\ 16) /= 0 then
				l_current_rva := l_current_rva + 16 - (l_current_rva \\ 16).to_natural_32
			end

			l_current_rva := l_current_rva + 2 +
				c_sizeof ((create {C_STRING}.make ("_CorXXXMain")).item).to_natural_32 +
				c_sizeof ((create {C_STRING}.make ("mscoree.dll")).item).to_natural_32 + 1

			l_pe_header.import_size := l_current_rva.to_integer_32 - l_pe_header.import_rva

			if (l_current_rva \\ 4) /= 0 then
				l_current_rva := l_current_rva + 4 - (l_current_rva \\ 4)
			end

			l_current_rva := l_current_rva + 2
			l_pe_header.entry_point := l_current_rva.to_integer_32
			l_current_rva := l_current_rva + 6
			if snk_len /= 0 then
				l_core_20_header.strong_name_signature [1] := l_current_rva.to_natural_32
				l_core_20_header.strong_name_signature [2] := snk_len
				l_current_rva := l_current_rva + snk_len
			end

			l_sect := 1
			l_pe_objects [l_sect].virtual_size := l_current_rva.to_integer_32 - l_pe_objects [l_sect].virtual_addr
			l_n := l_pe_objects [l_sect].virtual_size

			if ((l_n \\ file_align.to_integer_32) /= 0) then
				l_n := l_n + file_align.to_integer_32 - (l_n \\ file_align.to_integer_32)
			end
			l_pe_objects [l_sect].raw_size := l_n
			l_pe_header.code_size := l_n

			if (l_current_rva \\ object_align) /= 0 then
				l_current_rva := l_current_rva + object_align - (l_current_rva \\ object_align)
			end
			l_pe_objects [l_sect + 1].raw_ptr := l_pe_objects [l_sect].raw_ptr + l_pe_objects [l_sect].raw_size
			l_pe_objects [l_sect + 1].virtual_addr := l_current_rva.to_integer_32
			l_pe_header.data_base := l_current_rva.to_integer_32
			l_sect := l_sect + 1

--#if 0
--        peHeader_->resource_rva = currentRVA;
--        currentRVA += (sizeof(PEResourceDirTable) + sizeof(PEResourceDirEntry)) * 3; /* resource dirs */
--        currentRVA += sizeof(PEResourceDataEntry);

--        currentRVA += 2; /* size of version info */
--        currentRVA += 48; /* fixed info */
--        currentRVA += 68; /* VarFileInfo */
--        currentRVA += 368 - 72; /* String file info base */
--        std::string nn = peLib.FileName();
--        n = nn.find_last_of("\\");
--        if (n != std::string::npos)
--            n = nn.size() - n;
--        else
--            n = nn.size();
--        if (n % 4)
--            n += 4 - (n % 4);
--        currentRVA += n * 2;

--        char temp[256];
--        sprintf(temp, "%d.%d.%d.%d", fileVersion[0], fileVersion[1], fileVersion[2], fileVersion[3]);
--        n = strlen(temp);
--        if (n % 4)
--            n += 4 - (n % 4);
--        n *= 2;
--        currentRVA += n;
--        sprintf(temp, "%d.%d.%d.%d", productVersion[0], productVersion[1], productVersion[2], productVersion[3]);
--        n = strlen(temp);
--        if (n % 4)
--            n += 4 - (n % 4);
--        n *= 2;
--        currentRVA += n;
--        sprintf(temp, "%d.%d.%d.%d", assemblyVersion[0], assemblyVersion[1], assemblyVersion[2], assemblyVersion[3]);
--        n = strlen(temp);
--        if (n % 4)
--            n += 4 - (n % 4);
--        n *= 2;
--        currentRVA += n;

--        peObjects_[sect].virtual_size = currentRVA - peObjects_[sect].virtual_addr;
--        peHeader_->resource_size = peObjects_[sect].virtual_size;
--        n = peObjects_[sect].virtual_size;
--        if (n % fileAlign);
--        n += fileAlign - n % fileAlign;
--        peObjects_[sect].raw_size = n;
--        peHeader_->data_size += n;

--        if (currentRVA %objectAlign)
--            currentRVA += objectAlign - currentRVA % objectAlign;
--        peObjects_[sect + 1].raw_ptr = peObjects_[sect].raw_ptr + peObjects_[sect].raw_size;
--        peObjects_[sect + 1].virtual_addr = currentRVA;
--        sect++;
--#endif

			l_pe_header.fixup_rva := l_current_rva.to_integer_32
			l_current_rva := l_current_rva + 12
				-- sizeof relocs

			l_pe_objects [l_sect].virtual_size := l_current_rva.to_integer_32 - l_pe_objects [l_sect].virtual_addr
			l_pe_header.fixup_size := l_pe_objects [l_sect].virtual_size
			l_n := l_pe_objects [l_sect].virtual_size
			if (l_n \\ file_align.to_integer_32) /= 0 then
				l_n := l_n + file_align.to_integer_32 - (l_n \\ file_align.to_integer_32)
			end
			l_pe_objects [l_sect].raw_size := l_n
			l_pe_header.data_size := l_pe_header.data_size + l_n

			if (l_current_rva \\ object_align) /= 0 then
				l_current_rva := l_current_rva + object_align - (l_current_rva \\ object_align)
			end
			l_pe_objects [l_sect + 1].raw_ptr := l_pe_objects [l_sect].raw_ptr + l_pe_objects [l_sect].raw_size
			l_pe_objects [l_sect + 1].virtual_addr := l_current_rva.to_integer_32
			l_pe_header.image_size := l_current_rva.to_integer_32

			pe_header := l_pe_header
			pe_objects := l_pe_objects
			cor20_header := l_core_20_header
			tables_header := l_tables_header
		end

feature {NONE} -- Implementation

	number_of_seconds_since_epoch: INTEGER_32
			-- calculate the number of seconds since epoch in eiffel
		local
			l_date_epoch: DATE_TIME
			l_date_now: DATE_TIME
		do
			create l_date_epoch.make_from_epoch (0)
			create l_date_now.make_now_utc
			Result := l_date_now.definite_duration (l_date_epoch).seconds_count.to_integer
		ensure
			is_class: class
		end

	c_sizeof (a_str: POINTER): INTEGER
		external "C inline"
		alias
			"return (EIF_INTEGER)sizeof($a_str);"
		end

	compute_rtv_string_size: NATURAL
		do
			to_implement ("To double check")
			Result := (rtv_string.count + 1).to_natural_32
		end

feature -- Write operations

	write_mz_data: BOOLEAN
		do
			to_implement ("Add implementation")
		end

	write_pe_header: BOOLEAN
		do
			to_implement ("Add implementation")
		end

	write_pe_objects: BOOLEAN
		do
			to_implement ("Add implementation")
		end

	write_iat: BOOLEAN
		do
			to_implement ("Add implementation")
		end

	write_core_header: BOOLEAN
		do
			to_implement ("Add implementation")
		end

	write_hash_data: BOOLEAN
		do
			to_implement ("Add implementation")
		end

	write_static_data: BOOLEAN
		do
			to_implement ("Add implementation")
		end

	write_methods: BOOLEAN
		do
			to_implement ("Add implementation")
		end

	write_metadata_headers: BOOLEAN
		do
			to_implement ("Add implementation")
		end

	write_tables: BOOLEAN
		do
			to_implement ("Add implementation")
		end

	write_strings: BOOLEAN
		do
			to_implement ("Add implementation")
		end

	write_us: BOOLEAN
		do
			to_implement ("Add implementation")
		end

	write_guid: BOOLEAN
		do
			to_implement ("Add implementation")
		end

	write_blob: BOOLEAN
		do
			to_implement ("Add implementation")
		end

	write_imports: BOOLEAN
		do
			to_implement ("Add implementation")
		end

	write_entry_point: BOOLEAN
		do
			to_implement ("Add implementation")
		end

	write_version_info (a_file_name: STRING_32): BOOLEAN
		do
			to_implement ("Add implementation")
		end

	write_relocs: BOOLEAN
		do
			to_implement ("Add implementation")
		end

	version_string (a_name: STRING_32; a_value: STRING_32)
			-- a helper to put a string into the string area of the version information.
		do
			to_implement ("Add implementation")
		end

feature -- Output Helpers

	put (a_data: ANY; a_size: NATURAL)
		do
			if attached output_file as l_file then
					-- outputFile_->write((char *)data, size)
			end
		end

	offset: NATURAL_64
			-- the output position.
		do
			to_implement ("Add implementation")
		end

	seek (a_offset: NATURAL)
			-- Set the output position.
		do
			to_implement ("Add implementation")
		end

	align (a_offset: NATURAL)
		do
			to_implement ("Add implementation")
		end

feature -- Constants

	MAX_PE_OBJECTS: INTEGER = 4
			-- the maximum number of PE objects we will generate
			-- this includes the following:
			-- 	.text / cildata
			-- 	.reloc (for the single necessary reloc entry)
			-- 	.rsrc (not implemented yet, will hold version info record)

feature {NONE} -- C++ externals

	c_create_guid (a_guid: POINTER)
		external "C++ inline use <random>, <array>, <algorithm>, <functional>"
		alias
			"{
			std::array<unsigned char, 128 / 8> rnd;

		    std::uniform_int_distribution<int> distribution(0, 0xff);
		    // note that this whole thing will fall apart if the C++ lib uses
		    // a prng with constant seed for the random_device implementation.
		    // that shouldn't be a problem on OS we are interested in.
		    std::random_device dev;
		    std::mt19937 engine(dev());
		    auto generator = std::bind(distribution, engine);

		    std::generate(rnd.begin(), rnd.end(), generator);

		    // make it a valid version 4 (random) GUID
		    // remember that on windows GUIDs are native endianness so this may need
		    // work if you port it
		    rnd[7 /*6*/] &= 0xf;
		    rnd[7 /*6*/] |= 0x40;
		    rnd[9 /*8*/] &= 0x3f;
		    rnd[9 /*8*/] |= 0x80;

		    memcpy($a_guid, rnd.data(), rnd.size());
			}"
		end

end
