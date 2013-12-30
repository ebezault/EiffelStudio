note
	description: "Contains an object alongside lots of metadata used during store and retrieve operations."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	PS_OBJECT_DATA

inherit
	PS_ABEL_EXPORT

	REFLECTED_REFERENCE_OBJECT
		export
		{NONE}
			all
		{PS_ABEL_EXPORT}
			set_object, physical_offset
		end

feature {PS_ABEL_EXPORT} -- Access: General information

	reflector: REFLECTED_OBJECT
			-- A reflection wrapper to the actual object.
		require
			initialized: is_object_initialized
		attribute
		end

	index: INTEGER
			-- The index of the current object.

	referer_count: INTEGER
			-- The number of referers to this object.

	last_referer: INTEGER
			-- The last referer found during object graph traversal.

	type: PS_TYPE_METADATA
			-- Some information about the runtime type of the current object.

	level: INTEGER
			-- The level of the current object in the object graph.
		obsolete
			"Only used for debugging, will be removed."
		attribute
		end

feature {PS_ABEL_EXPORT} -- Status report

	is_persistent: BOOLEAN
			-- Is the current object already stored in the database?
			-- I.e. is there a mapping to a primary key?

	is_ignored: BOOLEAN
			-- Is the current object ignored for further processing?

	is_handler_initialized: BOOLEAN
			-- Is there a handler for the current object?
		do
			Result := attached internal_handler
		end

	is_object_initialized: BOOLEAN
			-- Is the actual object set?
		do
			Result := reflector.object /= Current
		end

feature {PS_ABEL_EXPORT} -- Access: ABEL internals

	identifier: NATURAL_64
			-- The unique ABEL identifier.

	primary_key: INTEGER
			-- The primary key of the current object, as used by the backend.

	handler: PS_HANDLER
			-- The handler for the current object.
		require
			initialized: is_handler_initialized
		do
			check attached internal_handler as res then
				Result := res
			end
		ensure
			correct: Result = internal_handler
		end

	backend_representation: detachable PS_BACKEND_ENTITY
			-- The representation of the current object in the backend.
--		note
--			option: stable
--		attribute
--		end

	backend_object: PS_BACKEND_OBJECT
			-- The representation of current as a backend object.
		require
			is_backend_object: attached {PS_BACKEND_OBJECT} backend_representation
		do
			check attached {PS_BACKEND_OBJECT} backend_representation as res then
				Result := res
			end
		end

	backend_collection: PS_BACKEND_COLLECTION
			-- The representation of current as a backend collection.
		require
			is_backend_object: attached {PS_BACKEND_COLLECTION} backend_representation
		do
			check attached {PS_BACKEND_COLLECTION} backend_representation as res then
				Result := res
			end
		end

feature {PS_ABEL_EXPORT} -- Element change

	set_is_persistent (persistent: like is_persistent)
			-- Assign `is_persistent' with `persistent'
		do
			is_persistent := persistent
		ensure
			is_persistent_assigned: is_persistent = persistent
		end

	set_identifier (an_identifier: like identifier)
			-- Assign `identifier' with `an_identifier'.
		do
			identifier := an_identifier
		ensure
			identifier_assigned: identifier = an_identifier
		end

	set_handler (a_handler: like handler)
			-- Assign `handler' with `a_handler'.
		do
			internal_handler := a_handler
		ensure
			initialized: is_handler_initialized
			handler_assigned: handler = a_handler
		end

	ignore
			-- Set `is_ignored' to `True'
		do
			is_ignored := True
		ensure
			correct: is_ignored
		end

	set_backend_representation (a_backend_representation: PS_BACKEND_ENTITY)
			-- Assign `backend_representation' with `a_backend_representation'.
		require
--			same_type: a_backend_representation.metadata.is_equal (type)
		do
			backend_representation := a_backend_representation
		ensure
			backend_representation_assigned: backend_representation = a_backend_representation
			backend_object_correct: attached {PS_BACKEND_OBJECT} a_backend_representation implies backend_object = a_backend_representation
			backend_collection_correct: attached {PS_BACKEND_COLLECTION} a_backend_representation implies backend_collection = a_backend_representation
		end

	set_reflector (an_object: like reflector)
			-- Assign `object' with `an_object'.
		do
			reflector := an_object
		ensure
			initialized: is_object_initialized
			object_assigned: an_object = reflector
		end

	set_referer (referer_index: INTEGER)
			-- Set the referer.
		do
			last_referer := referer_index
			referer_count := referer_count + 1
		end

feature {NONE} -- Implementation

	internal_handler: detachable like handler
			-- The detachable but stable reference to the handler.
--		note
--			option: stable
--		attribute
--		end
end
