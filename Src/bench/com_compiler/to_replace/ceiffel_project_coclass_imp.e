indexing
  description: "CEIFFEL_PROJECT_COCLASS Implementation."
  Note: "Automatically generated by the EiffelCOM Wizard."

class
  CEIFFEL_PROJECT_COCLASS_IMP

inherit
  CEIFFEL_PROJECT_COCLASS

creation
  make,
  make_from_pointer

feature {NONE}  -- Initialization

  make is
      -- Creation. Implement if needed.
    do
      create compiler_kernel.make
    end

  make_from_pointer (cpp_obj: POINTER) is
      -- Creation.
    do
      set_item (cpp_obj)
      make
    end

feature -- Access

  compiler_kernel: PROJECT_MANAGER
      -- Implementation.

  project_file_name: STRING is
      -- Full path to .epr file.
    do
      Result := compiler_kernel.project_file_name
    end

  ace_file_name: STRING is
      -- Full path to Ace file.
    do
      Result := compiler_kernel.ace_file_name
    end

  project_directory: STRING is
      -- Project directory.
    do
      Result := compiler_kernel.project_directory
    end
    
  valid_project: BOOLEAN is
      -- Is project valid?
    do
      Result := compiler_kernel.valid_project
    end

  is_compiled: BOOLEAN is
      -- Has system been compiled?
    do
      Result := compiler_kernel.is_compiled
    end
    
  project_has_updated: BOOLEAN is
      -- Has project been updated since last compilation?
    do
      Result := compiler_kernel.project_has_updated
    end
  
  last_exception: IEIFFEL_EXCEPTION_INTERFACE is
      -- Last exception raised
    do
      Result := compiler_kernel.last_exception
    end

  compiler: IEIFFEL_COMPILER_INTERFACE is
      -- Compiler.
    do
      Result := compiler_kernel.compiler
    end

  system_browser: IEIFFEL_SYSTEM_BROWSER_INTERFACE is
      -- System Browser.
    do
      Result := compiler_kernel.system_browser
    end

  project_properties: IEIFFEL_PROJECT_PROPERTIES_INTERFACE is
      -- Project Properties.
    do
      Result := compiler_kernel.project_properties
    end

  completion_information: IEIFFEL_COMPLETION_INFO_INTERFACE is
      -- Completion information
    do
      Result := compiler_kernel.completion_information
    end
    
  html_doc_generator: IEIFFEL_HTMLDOC_GENERATOR_INTERFACE is
      -- html documentation generator
    do
      Result := compiler_kernel.html_doc_generator
    end

feature -- Basic Operations

  create_item is
      -- Initialize `item'
    do
      item := ccom_create_item (Current)
    end

  retrieve_eiffel_project (a_project_file_name: STRING) is
      -- Retrieve Eiffel Project
      -- `a_project_file_name' [in].  
    do
      compiler_kernel.retrieve_eiffel_project (a_project_file_name)
    end

  create_eiffel_project (a_ace_file_name: STRING; a_project_directory_path: STRING) is
      -- Create new Eiffel project.
      -- `a_ace_file_name' [in].  
      -- `a_project_directory_path' [in].  
    do
      compiler_kernel.create_eiffel_project (a_ace_file_name, a_project_directory_path)
    end
    
feature {NONE}  -- Externals

  ccom_create_item (eif_object: like Current): POINTER is
      -- Initialize `item'
    external
      "C++ [new ecom_eiffel_compiler::CEiffelProject %"ecom_eiffel_compiler_CEiffelProject_s.h%"](EIF_OBJECT)"
    end

end -- CEIFFEL_PROJECT_COCLASS_IMP

