/*
indexing
	description: "Set of features needed during execution of an Eiffel system for
		a proper implementation of generic conformance."
	date: "$Date$"
	revision: "$Revision$"
*/
	
using System;
using System.Reflection;

namespace ISE.Runtime {

[Serializable]
public class GENERIC_CONFORMANCE {

	public static void compute_type (
		EIFFEL_TYPE_INFO a_target_object,
		TYPE a_type,
		EIFFEL_TYPE_INFO a_current
	)
		// Give an Eiffel generated object type `obj' and its associated type array
		// information `type_array' generate if not yet done a new EIFFEL_DERIVATION
		// object and assign it to `obj'. We use `current' in case some research needs
		// to be done in current context.
	{
		GENERIC_TYPE computed_type;
		EIFFEL_DERIVATION derivation;

		if (a_type is GENERIC_TYPE) {
				// We are handling a generic type.
			computed_type = (GENERIC_TYPE) a_type.evaluated_type (a_current);
			derivation = new EIFFEL_DERIVATION (computed_type, computed_type.nb_generics,
				(CLASS_TYPE []) computed_type.type_array);
			a_target_object.____set_type (derivation);
		} else {
				// Normal class type, nothing special needs to be done.
		}
	}

	public static EIFFEL_TYPE_INFO create_type (
		TYPE a_type,
		EIFFEL_TYPE_INFO a_current
	)
		// Create new instance of `a_type' in context of `a_current' object.
		// Handles creation of class type as well as creation of formal generic parameter.
	{
		CLASS_TYPE type_to_create;
		GENERIC_TYPE computed_type;
		EIFFEL_DERIVATION derivation;
		EIFFEL_TYPE_INFO Result;

			// Evaluate type in context of Current object.
		type_to_create = (CLASS_TYPE) a_type.evaluated_type (a_current);

			// Create new object of type `type_to_create'.
			// Note: We use the `Activator' class because it is much faster than
			// creating an instance by getting the associated `ConstructorInfo'.
		Result = (EIFFEL_TYPE_INFO) Activator.
			CreateInstance (Type.GetTypeFromHandle (type_to_create.type));

			// Properly initializes `Result'.
		computed_type = type_to_create as GENERIC_TYPE;
		if (computed_type != null ) {
			derivation = new EIFFEL_DERIVATION (computed_type, computed_type.nb_generics,
				(CLASS_TYPE []) computed_type.type_array);
			Result.____set_type (derivation);
		}
		return Result;
	}

	public static EIFFEL_TYPE_INFO create_like_object (EIFFEL_TYPE_INFO an_obj)
		// Given an Eiffel object `an_obj' create a new one of same type.
	{
		EIFFEL_DERIVATION der;
		EIFFEL_TYPE_INFO Result;

			// Create a new instance of the same type of `an_obj'
			// Note: We use the `Activator' class because it is much faster than
			// creating an instance by getting the associated `ConstructorInfo'.
		Result = (EIFFEL_TYPE_INFO) Activator.CreateInstance (an_obj.GetType ());

			// If it is a generic type, we also need to set its type.
		der = an_obj.____type ();
		if (der != null) {
			Result.____set_type (der);
		}
		return Result;
	}

	public static object create_like_object (object an_obj)
		// Given an Eiffel object `an_obj' create a new one of same type.
	{
		EIFFEL_DERIVATION der;
		object Result;
		EIFFEL_TYPE_INFO l_obj_info;

			// Create a new instance of the same type of `an_obj'
			// Note: We use the `Activator' class because it is much faster than
			// creating an instance by getting the associated `ConstructorInfo'.
		Result = Activator.CreateInstance (an_obj.GetType ());

		l_obj_info = an_obj as EIFFEL_TYPE_INFO;
		if (l_obj_info != null) {
				// If it is a generic type, we also need to set its type.
			der = l_obj_info.____type ();
			if (der != null) {
				((EIFFEL_TYPE_INFO) Result).____set_type (der);
			}
		}
		return Result;
	}

	public static TYPE load_type_of_object (EIFFEL_TYPE_INFO an_obj)
		// Given an Eiffel object `an_obj' extract its type information.
	{
		EIFFEL_DERIVATION der;
		CLASS_TYPE Result;

		der = an_obj.____type ();

		if (der == null) {
				// It is not a generic type, so we can simply find its type through
				// Reflection and then creates a CLASS_TYPE object.
			Result = new CLASS_TYPE ();
			Result.set_type (an_obj.GetType ().TypeHandle);
		} else {
				// It is a generic type, so we can simply find its type through
				// its EIFFEL_DERIVATION.
			Result = der.type;
		}
		return Result;

	}
}

}
