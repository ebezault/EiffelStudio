using System;
using System.Text;
using System.IO;
using System.Collections.Generic;
using System.Reflection;
using System.Runtime.InteropServices;
using System.Linq;
using System.Diagnostics;


namespace md_consumer
{

    class SHARED_ASSEMBLY_MAPPING
    {
        static public Dictionary<string,int> assembly_mapping_table = new Dictionary<string,int>();
        // static public int none;

        public SHARED_ASSEMBLY_MAPPING()
        {
            // assembly_mapping_cell = (new Dictionary<string,int>(), 0);
        }
        public Dictionary<string, int> assembly_mapping()
        {
            return assembly_mapping_table;
        }

        public int index_for_assembly(string? a_full_name)
        {
            if (a_full_name == null) {
                return -1;
            } else {
                if (assembly_mapping_table.ContainsKey(a_full_name)) {
                    return assembly_mapping_table[a_full_name];
                } else {
                    return -1;
                }
            }
        }
        public bool is_assembly_mapped(string? a_full_name)
        {
            if (a_full_name == null) {
                return false;
            } else {
                return assembly_mapping_table.ContainsKey(a_full_name);
            }
        }
        public void record_assembly_mapping (int index, string a_full_name)
        {
            assembly_mapping_table.Add(a_full_name, index);
        }
        public void reset_assembly_mapping()
        {
            assembly_mapping_table = new Dictionary<string,int>();
        }

        public CONSUMED_REFERENCED_TYPE referenced_type_from_type (Type t)
            // Consumed type from `t'
        {
    //     require
    //         non_void_type: t /= Void
    //         is_visible: t.is_visible
            CONSUMED_REFERENCED_TYPE? res = null;
            if (t.IsByRef) {
                Type? l_type = t.GetElementType();
                if (l_type != null) { 
                    res = referenced_type_from_type (l_type);
                    if (res != null) {
                        res.set_is_by_ref();
                    }
                } else {
                    Debug.Assert(false, "from doc");
                }
            } else {
                Dictionary<string, int> am = assembly_mapping();
                Assembly l_assembly = t.Assembly;
                string? l_full_name = l_assembly.FullName;
                string? l_name = t.FullName;

                if (l_full_name != null && l_name != null) {
                    if (am.ContainsKey (l_full_name)) {
                        int id = am[l_full_name];
                        if (t.IsArray) {
                            Type? l_type = t.GetElementType();
                            if (l_type != null) {
                                return new CONSUMED_ARRAY_TYPE(l_name, id, referenced_type_from_type (l_type));
                            } else {
                                Debug.Assert(false, "from doc");
                            }
                        } else {
                            return new CONSUMED_REFERENCED_TYPE(l_name, id);
                        }
                    } else {
                        Debug.Assert(false, "found");
                    }
                } else {
                    // Debug.Assert(false, "from doc");
                }
            }
            if (res == null) {
                // Debug.Assert (false, "has result");
                res = new CONSUMED_REFERENCED_TYPE(t.Name, -1);
            }
            return res;
        }    
    }
}
