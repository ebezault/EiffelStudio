-- Extern declarations for final mode generation

class EXTERN_DECLARATIONS

creation

	make

feature

	routine_tables: SEARCH_TABLE [STRING];
			-- Hash table of routine tables

	attribute_tables: SEARCH_TABLE [STRING];
			-- Attribute offset table ids

	type_tables: SEARCH_TABLE [STRING];
			-- Type table name

	routines: EXTEND_TABLE [TYPE_C, STRING];
			-- Routine names

	make is
			-- Initialization
		do
			!!routine_tables.make (100);
			!!attribute_tables.make (100);
			!!routines.make (100);
			!!type_tables.make (100);
		end;

	add_routine_table (rout_table: STRING) is
			-- Add one routine table to the current extern declarations.
		require	
			rout_table_exists: rout_table /= Void;
		do
			routine_tables.put (rout_table);
		end;

	add_attribute_table (attr_table: STRING) is
			-- Add one attribute offset table to the current extern declarations.
		require
			attr_table_exists: attr_table /= Void
		do
			attribute_tables.put (attr_table);
		end;

	add_type_table (type_table: STRING) is
			-- Add one type table to the current extenr declarations.
		require
			type_table_exists: type_table /= Void
		do
			type_tables.put (type_table);
		end;

	add_routine (type: TYPE_C; rout_name: STRING) is
			-- Add one routine of name `rout_name' and C type `type`.
		require
			rout_name_exists: rout_name /= Void;
			type_exists: type /= Void;
		do
			routines.put (type, rout_name);
		end;

	wipe_out is
			-- Wipe out current structure
		do
			routines.clear_all;
			routine_tables.clear_all;
			attribute_tables.clear_all;
			type_tables.clear_all;
		end;

	generate (file_name: STRING) is
			-- Generate declarations in a file of name `file_name'.
		require
			file_name_exists: file_name /= Void;
		local
			f: UNIX_FILE;
		do	
			!!f.make (file_name);
			f.open_write;

			f.putstring ("#include %"portable.h%"%N%N");
			from
				routines.start
			until
				routines.offright
			loop
				f.putstring ("extern ");
				routines.item_for_iteration.generate (f);
				f.putstring (routines.key_for_iteration);
				f.putstring ("();%N");
				routines.forth;
			end;
			from
				routine_tables.start
			until
				routine_tables.offright
			loop
				f.putstring ("extern fnptr ");
                f.putstring (routine_tables.item_for_iteration);
                f.putstring ("[];%N");
                routine_tables.forth;
            end;
			from
                attribute_tables.start
            until
                attribute_tables.offright
            loop
                f.putstring ("extern long ");
                f.putstring (attribute_tables.item_for_iteration);
                f.putstring ("[];%N");
                attribute_tables.forth;
            end;
			from
				type_tables.start
			until
				type_tables.offright
			loop
				f.putstring ("extern int16 ");
                f.putstring (type_tables.item_for_iteration);
                f.putstring ("[];%N");
                type_tables.forth;
            end;

			f.close;
		end;
	
end	
