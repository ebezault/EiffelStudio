indexing
	description: "Specifies a condition."
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_CONDITION

inherit
	CONF_VALIDITY

create
	make

feature {NONE} -- Initialization

	make is
			-- Create.
		do
			create platform.make (1)
			create build.make (1)
			create version.make (1)
			create custom.make (1)
		end

feature -- Access

	platform: ARRAYED_LIST [TUPLE [value: INTEGER; invert: BOOLEAN]]
			-- Platform where it is enabled or for which it is disabled (if `invert' is true)

	build: ARRAYED_LIST [TUPLE [value: INTEGER; invert: BOOLEAN]]
			-- Build where it is is enabled or for which it is disabled (if `invert' is true)

	multithreaded: CELL [BOOLEAN]
			-- Enabled for multithreaded?

	dotnet: CELL [BOOLEAN]
			-- Enabled for dotnet?

	version: HASH_TABLE [TUPLE [min: CONF_VERSION; max: CONF_VERSION], STRING]
			-- Enabled for a certain version number? Indexed by the type of the version number.

	custom: HASH_TABLE [TUPLE [value: STRING; invert: BOOLEAN], STRING]
			-- Custom variables that have to be fullfilled indexed by the variable name.

feature -- Queries

	satisfied (a_state: CONF_STATE): BOOLEAN is
			-- Does `a_state' satisfy `Current'?
		require
			a_state_not_void: a_state /= Void
		local
			l_pf, l_build: INTEGER
			l_pf_cond, l_build_cond: TUPLE [value: INTEGER; invert: BOOLEAN]
			l_cust_cond: TUPLE [value: STRING; invert: BOOLEAN]
			l_vars: CONF_HASH_TABLE [STRING, STRING]
			l_version: HASH_TABLE [CONF_VERSION, STRING]
			l_ver_cond: TUPLE [min: CONF_VERSION; max: CONF_VERSION]
			l_ver_state: CONF_VERSION
		do
			Result := True
				-- multithreaded
			if Result and multithreaded /= Void then
				Result := a_state.is_multithreaded = multithreaded.item
			end

				-- dotnet
			if Result and dotnet /= Void then
				Result := a_state.is_dotnet = dotnet.item
			end

				-- platform
			if Result and not platform.is_empty then
				from
					l_pf := a_state.platform
					platform.start
				until
					not Result or platform.after
				loop
					l_pf_cond := platform.item
					Result := l_pf = l_pf_cond.value xor l_pf_cond.invert
					platform.forth
				end
			end

				-- build
			if Result and not build.is_empty then
				from
					l_build := a_state.build
					build.start
				until
					not Result or build.after
				loop
					l_build_cond := build.item
					Result := l_build = l_build_cond.value xor l_build_cond.invert
					build.forth
				end
			end

				-- Version
			if Result and not version.is_empty then
				from
					l_version := a_state.version
					version.start
				until
					not Result or version.after
				loop
					l_ver_cond := version.item_for_iteration
					l_ver_state := l_version.item (version.key_for_iteration)
					Result := l_ver_state /= Void and then (l_ver_cond.min = Void or else l_ver_cond.min <= l_ver_state) and
						(l_ver_cond.max = Void or else l_ver_cond.max >= l_ver_state)
					version.forth
				end
			end

				-- custom
			if Result and not custom.is_empty then
				from
					l_vars := a_state.custom_variables
					custom.start
				until
					not Result or custom.after
				loop
					l_cust_cond := custom.item_for_iteration
					Result := equal (l_vars.item (custom.key_for_iteration), l_cust_cond.value) xor l_cust_cond.invert
					custom.forth
				end
			end
		end

feature -- Update

	add_platform (a_platform: INTEGER) is
			-- Add requirement on `a_platform'.
		require
			valid_platform: valid_platform (a_platform)
		do
			platform.force ([a_platform, False])
		end

	exclude_platform (a_platform: INTEGER) is
			-- Add an exclude requirement on `a_platform'.
		require
			valid_platform: valid_platform (a_platform)
		do
			platform.force ([a_platform, True])
		end

	wipe_out_platform is
			-- Wipe out platforms.
		do
			platform.wipe_out
		ensure
			platform_empty: platform.is_empty
		end

	add_build (a_build: INTEGER) is
			-- Add requirement on `a_build'.
		require
			valid_buidl: valid_build (a_build)
		do
			build.force ([a_build, False])
		end

	exclude_build (a_build: INTEGER) is
			-- Add an exclude requirement on `a_build'.
		require
			valid_build: valid_build (a_build)
		do
			build.force ([a_build, True])
		end

	wipe_out_build is
			-- Wipe out builds.
		do
			build.wipe_out
		ensure
			build_empty: build.is_empty
		end

	set_multithreaded (a_value: BOOLEAN) is
			-- Set `multithreaded' to `a_value'.
		do
			create multithreaded.put (a_value)
		end

	set_dotnet (a_value: BOOLEAN) is
			-- Set `dotnet' to `a_value'.
		do
			create dotnet.put (a_value)
		end

	add_custom (a_name, a_value: STRING) is
			-- Add requirement that `a_name'=`a_value'.
		require
			a_name_not_void: a_name /= Void
			a_value_not_void: a_value /= Void
		do
			custom.force ([a_value, False], a_name)
		end

	exclude_custom (a_name, a_value: STRING) is
			-- Add exclude requirement that `a_name'=`a_value'.
		require
			a_name_not_void: a_name /= Void
			a_value_not_void: a_value /= Void
		do
			custom.force ([a_value, True], a_name)
		end

	wipe_out_custom is
			-- Wipe out custom.
		do
			custom.clear_all
		ensure
			custom_empty: custom.is_empty
		end

	add_version (a_min, a_max: CONF_VERSION; a_type: STRING) is
			-- Set version constraint.
		require
			min_or_max: a_min /= Void or a_max /= Void
			min_less_max: a_min /= Void and a_max /= Void implies a_min <= a_max
			valid_type: valid_version_type (a_type)
		local
			l_vers: TUPLE [min: CONF_VERSION; max: CONF_VERSION]
		do
			create l_vers
			l_vers.min := a_min
			l_vers.max := a_max
			version.force (l_vers, a_type)
		ensure
			version_added: version.has (a_type)
		end


invariant
	platform_not_void: platform /= Void
	build_not_void: build /= Void
	version_not_void: version /= Void
	custom_not_void: custom /= Void
end
