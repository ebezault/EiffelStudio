/*
	Object id externals
*/

#include "eif_config.h"
#include "eif_portable.h"
#include "eif_macros.h"
#include "eif_garcol.h"
#include "eif_except.h"
#include "eif_hector.h"
#include "eif_sig.h"
#include "eif_garcol.h"
#include "eif_object_id.h"


/*#define DEBUG 2		/* Debug level */

#define dprintf(n)	if (DEBUG & (n)) printf

rt_private EIF_INTEGER private_object_id(EIF_REFERENCE object, struct stack *a_set, EIF_INTEGER *max_value_ptr);
rt_private EIF_INTEGER private_general_object_id(EIF_REFERENCE object, struct stack *a_set, EIF_INTEGER *max_value_ptr, EIF_BOOLEAN reuse_free);
rt_private EIF_REFERENCE private_id_object(EIF_INTEGER id, struct stack *a_set, EIF_INTEGER max_value);
rt_private void private_object_id_free(EIF_INTEGER id, struct stack *a_set, EIF_INTEGER max_value);
/* Class IDENTIFIED_CONTROLLER */
rt_private EIF_INTEGER eif_private_object_id_stack_size (struct stack *a_set);
rt_private void eif_private_extend_object_id (EIF_INTEGER nb_chunks, struct stack *a_set);
rt_private void p_print_object_id_stack (struct stack *a_set) ;

/* The following stack records the addresses of objects for which
 * `object_id' has been called.
 */

rt_public struct stack object_id_stack = {
        (struct stchunk *) 0,   /* st_hd */
        (struct stchunk *) 0,   /* st_tl */
        (struct stchunk *) 0,   /* st_cur */
        (char **) 0,                    /* st_top */
        (char **) 0,                    /* st_end */
};


rt_private EIF_INTEGER max_object_id = 0;	/* Max object_id allocated */
/* This needs to be done as the chunks of memory are not cleared after
 * allocation and we do not want to consider some garbage as a valid
 * descendant of IDENTIFIED and then call `object_id' on it
 */

rt_public EIF_INTEGER eif_object_id(EIF_REFERENCE object)
{
	return private_object_id(object, &object_id_stack, &max_object_id);
}
 
rt_public EIF_INTEGER eif_general_object_id(EIF_REFERENCE object)
{
	return private_general_object_id(object, &object_id_stack, &max_object_id, EIF_FALSE);
}
 
rt_public EIF_REFERENCE eif_id_object(EIF_INTEGER id)
{
		/* Returns the object associated with `id' */
	return private_id_object (id, &object_id_stack, max_object_id);
}
 
rt_public void eif_object_id_free(EIF_INTEGER id)
{
	private_object_id_free(id, &object_id_stack, max_object_id);
}


/* Externals for class IDENTIFIED_CONTROLLER */

rt_public EIF_INTEGER eif_object_id_stack_size (void)
	/* returns the number of chunks allocated in `object_id_stack' */
{
	return eif_private_object_id_stack_size (&object_id_stack);
}

rt_private EIF_INTEGER eif_private_object_id_stack_size (struct stack *a_set)
	/* returns the number of chunks allocated in `object_id_stack' */
{
	EIF_INTEGER result = 0;
	struct stchunk *c, *cn;
	for (c = a_set->st_hd; c != (struct stchunk *) 0; c = cn) {
		/* count the number of chunks in stack */
		cn = c->sk_next;
		result++;
		}
	return result;
} /* eif_private_object_id_stack_size */


rt_public void eif_extend_object_id_stack (EIF_INTEGER nb_chunks)
{
	eif_private_extend_object_id (nb_chunks, &object_id_stack);
}

rt_private void eif_private_extend_object_id (EIF_INTEGER nb_chunks, struct stack *a_set)
	/* extends of `nb_chunks the size of `object_id_stack' */
{
	
	EIF_GET_CONTEXT

	register3 char **top;
	

	if (a_set->st_top == (char **) 0) {
		top = st_alloc(a_set, STACK_CHUNK);	/* Create stack */
		if (top == (char **) 0)
			eraise ("Couldn't allocate object id stack", EN_MEM);
				/* No memory */
		a_set->st_top = top; /* Update new top */
	} 
	 /* extend an existing stack */
	{
		register4 struct stchunk * current;
		register3 char **end;
		current = a_set->st_cur;	/* save previous current stchunk */
		top = a_set->st_top;		/* save previous top of stack */
		end = a_set->st_end;		/*save previous st_end of stack */ 
		SIGBLOCK;		/* Critical section */
			while (--nb_chunks) {
			if (-1 == st_extend(a_set, STACK_CHUNK))
			eraise ("Couldn't allocate object id stack", EN_MEM);
					/* No memory */
			}	
		a_set->st_cur = current;	/* keep previous Current */
		a_set->st_top = top;		/* keep previous top */
		a_set->st_end = end;
		
		SIGRESUME;		/* End of critical section */
	
	}


	EIF_END_GET_CONTEXT
} /* eif_private_extend_object_id */

#ifdef CONCURRENT_EIFFEL

/* `separate_object_id_set' keeps track of objects referenced from other processors
 * Objects in the set are alive (the GC considers them as roots
 * Free locations are reused
 */

rt_public struct stack separate_object_id_set = {
	(struct stchunk *) 0,	/* st_hd */
	(struct stchunk *) 0,	/* st_tl */
	(struct stchunk *) 0,	/* st_cur */
	(char **) 0,			/* st_top */
	(char **) 0,			/* st_end */
};

rt_private EIF_INTEGER max_separate_object_id = 0;

rt_public EIF_INTEGER eif_separate_object_id(EIF_REFERENCE object)
{
	return private_general_object_id(object, &separate_object_id_set, &max_separate_object_id, EIF_TRUE);
}

rt_public EIF_REFERENCE eif_separate_id_object(EIF_INTEGER id)
{
	return private_id_object (id, &separate_object_id_set, max_separate_object_id);
}

rt_public void eif_separate_object_id_free(EIF_INTEGER id)
{
	private_object_id_free(id, &separate_object_id_set, max_separate_object_id);
}

#endif /* CONCURRENT_EIFFEL */


#define STACK_SIZE (STACK_CHUNK-(sizeof(struct stchunk)/sizeof(char*)))

rt_private EIF_INTEGER private_object_id(EIF_REFERENCE object, struct stack *a_set, EIF_INTEGER *max_value_ptr)
{
	register unsigned int stack_number = 0;
	register struct stchunk *end;
	register EIF_INTEGER Result;
	char *address;
	char *obj = eif_access(object);

	if (-1 == epush(a_set, obj)) {	/* Cannot record object */
		eraise("object id", EN_MEM);			/* No more memory */
		return (EIF_INTEGER) 0;					/* They ignored it */
		}
	address = (char *) (a_set->st_top - 1);	/* Was allocated here */
	eif_access(address) = obj;		/* Record object's physical address */

		/* Get the stack number */
	for(end = a_set->st_hd;
		end != a_set->st_cur;
		stack_number++)
		end = end->sk_next;

	Result = (EIF_INTEGER)
		stack_number*STACK_SIZE+1-(a_set->st_cur->sk_arena-(char **)address);

	if (Result>*max_value_ptr)
		*max_value_ptr = Result;

#ifdef DEBUG
	dprintf (2) ("eif_object_id %d %lx %lx\n", Result, address, obj);
#endif
	return Result;
}

rt_private EIF_INTEGER private_general_object_id(EIF_REFERENCE object, struct stack *a_set, EIF_INTEGER *max_value_ptr, EIF_BOOLEAN reuse_free)
{
		/* Returns a unique identifier for any object, looking in the
		 * stack to see if a value has already been allocated for the object:
		 * a sequential search is done on the stack!!!
		 * Free locations (ids) may be reused
		 */

	register struct stchunk *current_chunk;
	register unsigned int stack_number = 0;
	register char **address;
	register char *obj = eif_access(object);
	register char **free_location = (char**) 0;
	register EIF_INTEGER free_id;

		/* Loop through all the chunks */
	for (current_chunk = a_set->st_hd;
		 current_chunk != (struct stchunk *)0;
		 stack_number++, current_chunk = current_chunk->sk_next){
			/* Inspect each chunk */

			/* Starting address is end of chunk for full chunks and
			 * current insertion position for the last one
			 */
		if (current_chunk == a_set->st_cur)
			address = a_set->st_top - 1;
		else
			address = current_chunk->sk_end - 1;
		for (;
			 address >= current_chunk->sk_arena;
			 address--) {
			if (*address == obj)
					/* Object is in the stack */
				return 
					stack_number*STACK_SIZE+1-(current_chunk->sk_arena-(char **)address);
			else if (reuse_free && (*address == (char *) 0) && (!free_location)) {
				free_location = address;
				free_id = stack_number*STACK_SIZE+1-(current_chunk->sk_arena-(char **)address);
				}
			}
		}

	if (reuse_free && free_location) {
			/* Reuse free location */
		*free_location = obj;
		return free_id;
	} else
			/* Object not found, allocate new value */
		return private_object_id(object, a_set, max_value_ptr);
}

rt_private EIF_REFERENCE private_id_object(EIF_INTEGER id, struct stack *a_set, EIF_INTEGER max_value)
{
	register unsigned int stack_number, i = 0;
	register struct stchunk *end;

	register char *address;

	if (id==0)							/* No object associated with 0 */
		return (EIF_REFERENCE) 0;

	if (id>max_value)
		return (EIF_REFERENCE) 0;

	if ((end = a_set->st_hd) == (struct stchunk *) 0)	/* No stack */
		return (EIF_REFERENCE) 0;

	id --;

	stack_number = id / STACK_SIZE;		/* Get the chunk number */

	for (;stack_number != i; i++)
		if ((end = end->sk_next) == (struct stchunk *) 0)
			return (EIF_REFERENCE) 0;		/* Not that many chunks */

		/* add offset to the end of chunk */
	address = (char *) (end->sk_arena + (id % STACK_SIZE));

#ifdef DEBUG
	if (address)
		dprintf (2) ("id_object %d %lx %lx\n", id+1, address, eif_access(address));
	else
		dprintf (2) ("id_object %d No object\n", id+1);
#endif
	if (address)
			/* Use eif_access to return the "real" object */
		return (eif_access(address));

	return (EIF_REFERENCE) 0;
}

rt_private void private_object_id_free(EIF_INTEGER id, struct stack *a_set, EIF_INTEGER max_value)
{
	/* Free the entry in the table */

	register unsigned int stack_number, i = 0;
	register struct stchunk *end;
	
	if (id==0)							/* No object associated with 0 */
		return;

	if (id>max_value)
		return;

	if ((end = a_set->st_hd) == (struct stchunk *) 0)	/* No stack */
		return;

	id--;

	stack_number = id / STACK_SIZE;		/* Get the chunk number */

	for (;stack_number != i; i++)
		if ((end = end->sk_next) == (struct stchunk *) 0)
			return;		/* Not that many chunks */

		/* add offset to the end of chunk */
	eif_access((char *)((char **)end->sk_arena + (id % STACK_SIZE))) = (EIF_REFERENCE) 0;

}

