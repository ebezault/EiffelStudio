indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.TreeNodeCollection"

external class
	SYSTEM_WINDOWS_FORMS_TREENODECOLLECTION

inherit
	ANY
		redefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end
	SYSTEM_COLLECTIONS_ILIST
		rename
			remove as system_collections_ilist_remove,
			insert as system_collections_ilist_insert,
			index_of as system_collections_ilist_index_of,
			has as system_collections_ilist_contains,
			extend as system_collections_ilist_add,
			get_is_fixed_size as system_collections_ilist_get_is_fixed_size,
			get_is_synchronized as system_collections_icollection_get_is_synchronized,
			get_sync_root as system_collections_icollection_get_sync_root,
			put_i_th as system_collections_ilist_set_item,
			get_item as system_collections_ilist_get_item
		end
	SYSTEM_COLLECTIONS_IENUMERABLE
	SYSTEM_COLLECTIONS_ICOLLECTION
		rename
			get_is_synchronized as system_collections_icollection_get_is_synchronized,
			get_sync_root as system_collections_icollection_get_sync_root
		end

create {NONE}

feature -- Access

	get_item (index: INTEGER): SYSTEM_WINDOWS_FORMS_TREENODE is
		external
			"IL signature (System.Int32): System.Windows.Forms.TreeNode use System.Windows.Forms.TreeNodeCollection"
		alias
			"get_Item"
		end

	frozen get_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.TreeNodeCollection"
		alias
			"get_Count"
		end

	frozen get_is_read_only: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.TreeNodeCollection"
		alias
			"get_IsReadOnly"
		end

feature -- Element Change

	set_item (index: INTEGER; value: SYSTEM_WINDOWS_FORMS_TREENODE) is
		external
			"IL signature (System.Int32, System.Windows.Forms.TreeNode): System.Void use System.Windows.Forms.TreeNodeCollection"
		alias
			"set_Item"
		end

feature -- Basic Operations

	to_string: STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.TreeNodeCollection"
		alias
			"ToString"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Windows.Forms.TreeNodeCollection"
		alias
			"Equals"
		end

	insert (index: INTEGER; node: SYSTEM_WINDOWS_FORMS_TREENODE) is
		external
			"IL signature (System.Int32, System.Windows.Forms.TreeNode): System.Void use System.Windows.Forms.TreeNodeCollection"
		alias
			"Insert"
		end

	add_tree_node (node: SYSTEM_WINDOWS_FORMS_TREENODE): INTEGER is
		external
			"IL signature (System.Windows.Forms.TreeNode): System.Int32 use System.Windows.Forms.TreeNodeCollection"
		alias
			"Add"
		end

	frozen copy_to (dest: SYSTEM_ARRAY; index: INTEGER) is
		external
			"IL signature (System.Array, System.Int32): System.Void use System.Windows.Forms.TreeNodeCollection"
		alias
			"CopyTo"
		end

	frozen get_enumerator: SYSTEM_COLLECTIONS_IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.Windows.Forms.TreeNodeCollection"
		alias
			"GetEnumerator"
		end

	clear is
		external
			"IL signature (): System.Void use System.Windows.Forms.TreeNodeCollection"
		alias
			"Clear"
		end

	frozen contains (node: SYSTEM_WINDOWS_FORMS_TREENODE): BOOLEAN is
		external
			"IL signature (System.Windows.Forms.TreeNode): System.Boolean use System.Windows.Forms.TreeNodeCollection"
		alias
			"Contains"
		end

	add_range (nodes: ARRAY [SYSTEM_WINDOWS_FORMS_TREENODE]) is
		external
			"IL signature (System.Windows.Forms.TreeNode[]): System.Void use System.Windows.Forms.TreeNodeCollection"
		alias
			"AddRange"
		end

	add (text: STRING): SYSTEM_WINDOWS_FORMS_TREENODE is
		external
			"IL signature (System.String): System.Windows.Forms.TreeNode use System.Windows.Forms.TreeNodeCollection"
		alias
			"Add"
		end

	frozen index_of (node: SYSTEM_WINDOWS_FORMS_TREENODE): INTEGER is
		external
			"IL signature (System.Windows.Forms.TreeNode): System.Int32 use System.Windows.Forms.TreeNodeCollection"
		alias
			"IndexOf"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.TreeNodeCollection"
		alias
			"GetHashCode"
		end

	frozen remove (node: SYSTEM_WINDOWS_FORMS_TREENODE) is
		external
			"IL signature (System.Windows.Forms.TreeNode): System.Void use System.Windows.Forms.TreeNodeCollection"
		alias
			"Remove"
		end

	remove_at (index: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Windows.Forms.TreeNodeCollection"
		alias
			"RemoveAt"
		end

feature {NONE} -- Implementation

	frozen system_collections_ilist_set_item (index: INTEGER; value: ANY) is
		external
			"IL signature (System.Int32, System.Object): System.Void use System.Windows.Forms.TreeNodeCollection"
		alias
			"System.Collections.IList.set_Item"
		end

	frozen system_collections_icollection_get_sync_root: ANY is
		external
			"IL signature (): System.Object use System.Windows.Forms.TreeNodeCollection"
		alias
			"System.Collections.ICollection.get_SyncRoot"
		end

	frozen system_collections_ilist_index_of (node: ANY): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.Windows.Forms.TreeNodeCollection"
		alias
			"System.Collections.IList.IndexOf"
		end

	frozen system_collections_ilist_remove (node: ANY) is
		external
			"IL signature (System.Object): System.Void use System.Windows.Forms.TreeNodeCollection"
		alias
			"System.Collections.IList.Remove"
		end

	frozen system_collections_ilist_add (node: ANY): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.Windows.Forms.TreeNodeCollection"
		alias
			"System.Collections.IList.Add"
		end

	frozen system_collections_ilist_get_item (index: INTEGER): ANY is
		external
			"IL signature (System.Int32): System.Object use System.Windows.Forms.TreeNodeCollection"
		alias
			"System.Collections.IList.get_Item"
		end

	frozen system_collections_icollection_get_is_synchronized: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.TreeNodeCollection"
		alias
			"System.Collections.ICollection.get_IsSynchronized"
		end

	frozen system_collections_ilist_contains (node: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Windows.Forms.TreeNodeCollection"
		alias
			"System.Collections.IList.Contains"
		end

	frozen system_collections_ilist_get_is_fixed_size: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.TreeNodeCollection"
		alias
			"System.Collections.IList.get_IsFixedSize"
		end

	finalize is
		external
			"IL signature (): System.Void use System.Windows.Forms.TreeNodeCollection"
		alias
			"Finalize"
		end

	frozen system_collections_ilist_insert (index: INTEGER; node: ANY) is
		external
			"IL signature (System.Int32, System.Object): System.Void use System.Windows.Forms.TreeNodeCollection"
		alias
			"System.Collections.IList.Insert"
		end

end -- class SYSTEM_WINDOWS_FORMS_TREENODECOLLECTION
