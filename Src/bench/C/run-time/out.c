/*

  ####   #    #   #####           ####
 #    #  #    #     #            #    #
 #    #  #    #     #            #
 #    #  #    #     #     ###    #
 #    #  #    #     #     ###    #    #
  ####    ####      #     ###     ####

		Routines for printing an Eiffel object.
*/

#include <stdio.h>
#include "eif_project.h"
#include "eif_config.h"
#include "eif_eiffel.h"
#include "eif_out.h"
#include "eif_plug.h"
#include "eif_struct.h"
#include "eif_hashin.h"
#include "eif_except.h"		/* For `eraise' */
#include "eif_sig.h"
#include "eif_hector.h"
#include "eif_bits.h"
#include "eif_globals.h"
#include "x2c.h"			 /* For macro LNGPAD */

/*
 * Private declarations
 */

#ifndef EIF_THREADS
rt_private char buffero[TAG_SIZE];		/* Buffer for printing an object in a string */
rt_private char *tagged_out = (char *) 0;	/* String where the tagged out is written */
rt_private int tagged_max = 0;			/* Actual maximum size of `tagged_out' */
rt_private int tagged_len = 0;			/* Actual length of `tagged_out' */
#endif /* EIF_THREADS */

rt_private void write_string(char *str);	/* Write a string in `tagged_out' */
rt_private void write_char(EIF_CHARACTER c, char *buf);		/* Write a character */
rt_private void write_out(void);		/* Write in `tagged_out' */
rt_private void write_tab(register int tab);		/* Print tabulations */
rt_private void rec_write(register char *object, int tab);		/* Write object print in `tagged_out' */
rt_private void rec_swrite(register char *object, int tab);		/* Write special object */
rt_private void buffer_allocate(void);	/* Allocate initial buffer */
rt_shared char *build_out(EIF_OBJ object);		/* Build `tagged_out' string */

#ifndef lint
rt_private char *rcsid =
	"$Id$";
#endif

/*
 * Routine for printing representation
 */

rt_public char *c_generator(register char *Current)
{
	/* Class name from which the Eiffel object is an instance.
	 * Return a reference on an Eiffel instance of STRING.
	 */

	register2 uint32 flags = HEADER(Current)->ov_flags; /* Object flags */
	char *generator;

	if (flags & EO_SPEC)
		return makestr("SPECIAL", 7);
	
	generator = System(flags & EO_TYPE).cn_generator;

	return makestr(generator, strlen(generator));
}

rt_public char *c_tagged_out(EIF_CONTEXT EIF_OBJ object)
{
	/* Write a tagged out printing in an string.
	 * Return a pointer on an Eiffel string object.
	 */
	EIF_GET_CONTEXT
	char *result;		/* The Eiffel string returned */

	build_out(object);	/* Build tagged out string for object */
	result = makestr(tagged_out, strlen(tagged_out));
	xfree(tagged_out);	/* Buffer not needed anymore */

	return result;		/* An Eiffel string */

	EIF_END_GET_CONTEXT
}

rt_public char *build_out(EIF_CONTEXT EIF_OBJ object)
{
	/* Build up tagged out representation in a private global buffer */
	EIF_GET_CONTEXT
	uint32 flags;		/* Object flags */

	buffer_allocate();	/* Allocation of `tagged_out' */

	flags = HEADER(eif_access(object))->ov_flags;

	if (flags & EO_SPEC) {
		/* Special object */
		sprintf(buffero, "SPECIAL [0x%lX]\n", eif_access(object));
		write_out();
		/* Print recursively in `tagged_out' */
		rec_swrite(eif_access(object), 0);
	} else {
		/* Print instance class name and object id */
		sprintf(buffero, "%s [0x%lX]\n", System(flags & EO_TYPE).cn_generator,
			eif_access(object));
		write_out();
		/* Print recursively in `tagged_out' */
		rec_write(eif_access(object), 0);
	}

	*buffero = '\0';
	write_out();

	return tagged_out;		/* This arena must be freed manually */

	EIF_END_GET_CONTEXT
}

rt_private void buffer_allocate(EIF_CONTEXT_NOARG)
{
	EIF_GET_CONTEXT
	/* Allocates initial tagged out buffer */

	tagged_out = (char *) xcalloc(TAG_SIZE, sizeof(char));
	if (tagged_out == (char *) 0)
		enomem(MTC_NOARG);
	tagged_max = TAG_SIZE;
	tagged_len = 0;

	EIF_END_GET_CONTEXT
}

rt_private void rec_write(EIF_CONTEXT register char *object, int tab)
{
	/* Print recursively `object' in `tagged_out' */
	EIF_GET_CONTEXT
	register2 struct cnode *obj_desc;	   /* Object type description */
	register3 long nb_attr;				 /* Attribute number */
	register4 uint32 *types;                /* Attribute types */
#ifndef WORKBENCH
	register6 long **offsets;			   /* Attribute offsets table */
#else
	register4 int32 *cn_attr;			   /* Attribute keys */
	long offset;
#endif
	register5 int16 dyn_type;			   /* Object dynamic type */
	char *o_ref;
	register7 char **names;				 /* Attribute names */
	char *reference;						/* Reference attribute */
	long i;
	uint32 type, ref_flags;

	dyn_type = Dtype(object);
	obj_desc = &System(dyn_type);
	nb_attr = obj_desc->cn_nbattr;
	names = obj_desc->cn_names;
	types = obj_desc->cn_types;

#ifndef WORKBENCH
	offsets = obj_desc->cn_offsets;
#else
	cn_attr = obj_desc->cn_attr;
#endif

	/* Print attributes */
	for (i = 0; i < nb_attr; i++) {

		/* Print attribute name */
		write_tab(tab+1);
		sprintf(buffero, "%s: ", names[i]);
		write_out();

		/* Print attribute value */
		type = types[i];
#ifndef WORKBENCH
		o_ref = object + (offsets[i])[dyn_type];
#else
		CAttrOffs(offset,cn_attr[i],dyn_type);
		o_ref = object + offset;
#endif
		switch(type & SK_HEAD) {
		case SK_POINTER:
			/* Pointer attribute */
			sprintf(buffero, "POINTER =  C pointer 0x%lX\n", *(fnptr *)o_ref);
			write_out();
			break;
		case SK_BOOL:
			/* Boolean attribute */
			sprintf(buffero, "BOOLEAN = ");
			write_out();
			if (*o_ref)
				sprintf(buffero, "True\n");
			else
				sprintf(buffero, "False\n");
			write_out();
			break;
		case SK_CHAR:
			/* Character attribute */
			write_char(*o_ref, buffero);
			write_out();
			break;
		case SK_INT:
			/* Integer attribute */
			sprintf(buffero, "INTEGER = %ld\n", *(long *)o_ref);
			write_out();
			break;
		case SK_FLOAT:
			/* Real attribute */
			sprintf(buffero, "REAL = %g\n", *(float *)o_ref);
			write_out();
			break;
		case SK_DOUBLE:
			/* Double attribute */
			sprintf(buffero, "DOUBLE = %.17g\n", *(double *)o_ref);
			write_out();
			break;	
		case SK_BIT:
			{		
				char *str = b_out(o_ref);

				sprintf(buffero, "BIT %ld = ", LENGTH(o_ref));
				write_out();
				write_string(str);
				sprintf(buffero, "\n");
				write_out();
				xfree(str);	/* Allocated by `b_out' */
			}
			break;
		case SK_EXP:
			/* Expanded attribute */
			sprintf(buffero, "expanded %s\n", System(Dtype(o_ref)).cn_generator);
			write_out();
			write_tab (tab + 2);
			sprintf(buffero, "-- begin sub-object --\n");
			write_out();

			rec_write((char *)o_ref, tab + 3);

			write_tab(tab + 2);
			sprintf(buffero, "-- end sub-object --\n");
			write_out();
			break;
		default: 
			/* Object reference */
			reference = *(char **)o_ref;
			if (0 != reference) {
				ref_flags = HEADER(reference)->ov_flags;
				if (ref_flags & EO_C) {
					/* C reference */
					sprintf(buffero, "POINTER = C pointer 0x%lX\n", reference);
					write_out();
				} else if (ref_flags & EO_SPEC) {
					/* Special object */
					sprintf(buffero, "SPECIAL [0x%lX]\n", reference);
					write_out();
					write_tab(tab + 2);
					sprintf(buffero, "-- begin special object --\n");
					write_out();

					rec_swrite(reference, tab + 3);

					write_tab(tab + 2);
					sprintf(buffero, "-- end special object --\n");
					write_out();
				} else {
					sprintf(buffero, "%s [0x%lX]\n",
						System(Dtype(reference)).cn_generator, reference);
					write_out();
				}
			} else {
				sprintf(buffero, "Void\n");
				write_out();
			}
		}
	}
	EIF_END_GET_CONTEXT
}

rt_private void rec_swrite(EIF_CONTEXT register char *object, int tab)
{
	/* Print special object */
	EIF_GET_CONTEXT
	union overhead *zone;		/* Object header */
	register5 uint32 flags;		/* Object flags */
	register3 long count;		/* Element count */
	register4 long elem_size;	/* Element size */
	char *o_ref;
	char *reference;
	long old_count;
	int dt_type;

	zone = HEADER(object);
	o_ref = (char *) (object + (zone->ov_size & B_SIZE) - LNGPAD_2);
	count = *(long *) o_ref;
	old_count = count;
	elem_size = *(long *) (o_ref + sizeof(long));
	flags = zone->ov_flags;
	dt_type = (int) (flags & EO_TYPE);

	if (!(flags & EO_REF)) 
		if (flags & EO_COMP) 
			for (o_ref = object + OVERHEAD; count > 0; count--,
						o_ref += elem_size) {
				write_tab(tab + 1);
				sprintf(buffero, "%ld: expanded ", old_count - count);
				write_out();
				sprintf(buffero, "%s\n", System(Dtype(o_ref)).cn_generator);
				write_out();
				write_tab(tab + 2);
				sprintf(buffero, "-- begin sub-object --\n");
				write_out();
		
				rec_write(o_ref, tab + 3);
	
				write_tab(tab + 2);
				sprintf(buffero, "-- end sub-object --\n");
				write_out();
			}
		else
			for (o_ref = object; count > 0; count--,
						o_ref += elem_size) {
				write_tab(tab + 1);
				sprintf(buffero, "%ld: ", old_count - count);
				write_out();
				if (dt_type == egc_sp_char) {
					write_char(*o_ref, buffero);
					write_out();
				} else if (dt_type == egc_sp_int) {
					sprintf(buffero, "INTEGER = %ld\n", *(long *)o_ref);
					write_out();
				} else if (dt_type == egc_sp_bool) {
					sprintf(buffero, "BOOLEAN = %s\n", (*o_ref ? "True" : "False"));
					write_out();
				} else if (dt_type == egc_sp_real) {
					sprintf(buffero, "REAL = %g\n", *(float *)o_ref);
					write_out();
				} else if (dt_type == egc_sp_double) {
					sprintf(buffero, "DOUBLE = %.17g\n", *(double *)o_ref);
					write_out();
				} else if (dt_type == egc_sp_pointer) {
					sprintf(buffero, "POINTER = C pointer 0x%lX\n", *(fnptr *)o_ref);
					write_out();
				} else {
					/* Must be bit */
					char *str = b_out(o_ref);

					sprintf(buffero, "BIT %ld = ", LENGTH(o_ref));
					write_out();
					write_string(str);
					sprintf(buffero, "\n");
					write_out();
					xfree(str);	/* Allocated by `b_out' */
				}
			}
	else 
		for (o_ref = object; count > 0; count--,
					o_ref = (char *) ((char **)o_ref + 1)) {
			write_tab(tab + 1);
			sprintf(buffero, "%ld: ", old_count - count);
			write_out();
			reference = *(char **)o_ref;
			if (0 == reference)
				sprintf(buffero, "Void\n");
			else if (HEADER(reference)->ov_flags & EO_C)
				sprintf(buffero, "POINTER = C pointer 0x%lX\n", reference);
			else
				sprintf(buffero, "%s [0x%lX]\n",
					System(Dtype(reference)).cn_generator, reference);
			write_out();
		}

	EIF_END_GET_CONTEXT
}

rt_private void write_tab(EIF_CONTEXT register int tab)
{
	EIF_GET_CONTEXT
	register1 int i = 0;

	for (; i < tab; i++) {
		sprintf(buffero,"  ");
		write_out();
	}

	EIF_END_GET_CONTEXT
}

rt_private void write_char (EIF_CHARACTER c, char *buf)
                			/* The character */
          		/* Where it should be written */
{
	/* Write a character in `buffer' */
		
	if (c < ' ')
		sprintf(buf, "CHARACTER = Ctrl-%c\n", c + '@');
	else if (c > 127) {
		c -= 128;
		if (c < ' ')
			sprintf(buf, "CHARACTER = Ext-Ctrl-%c\n", c + '@');
		else
			sprintf(buf, "CHARACTER = Ext-%c\n", c);
	} else
		sprintf(buf, "CHARACTER = '%c'\n", c);
}

rt_private void write_out(EIF_CONTEXT_NOARG)
{
	EIF_GET_CONTEXT

	/* Print private string `buffer' in `tagged_out'. */
	write_string(buffero);

	EIF_END_GET_CONTEXT
}

rt_private void write_string(EIF_CONTEXT char *str)
{
	/* Print `str' in `tagged_out'. */
	EIF_GET_CONTEXT
	int buffer_len = strlen(str);	/* Length of `str' */

	tagged_len += buffer_len;
	if (tagged_len >= tagged_max) {
		/* Reallocation of C string `tagged_out' */
		do 
			tagged_max *= 2;
		while (tagged_len >= tagged_max);
		tagged_out = xrealloc(tagged_out, tagged_max, GC_OFF);
		if (tagged_out == (char *) 0)
			enomem(MTC_NOARG);
	}
	/* Append `str' to `tagged_out' */
	strcat(tagged_out, str);

	EIF_END_GET_CONTEXT
}

/*
 * Building `out' representation for various data types.
 */

rt_public char *c_outb(EIF_BOOLEAN b)
{
	if (b)
		return makestr("true", 4);
	else
		return makestr("false", 5);
}

rt_public char *c_outi(EIF_CONTEXT EIF_INTEGER i)
{
	EIF_GET_CONTEXT

	sprintf(buffero, "%ld", i);
	return makestr(buffero, strlen(buffero));

	EIF_END_GET_CONTEXT
}

rt_public char *c_outr(EIF_CONTEXT EIF_REAL f)
{
	EIF_GET_CONTEXT

	sprintf(buffero, "%g", f);
	return makestr(buffero, strlen(buffero));

	EIF_END_GET_CONTEXT
}

rt_public char *c_outd(EIF_CONTEXT EIF_DOUBLE d)
{
	EIF_GET_CONTEXT

	sprintf(buffero, "%.17g", d);
	return makestr(buffero, strlen(buffero));

	EIF_END_GET_CONTEXT
}

rt_public char *c_outc(EIF_CONTEXT EIF_CHARACTER c)
{
	EIF_GET_CONTEXT

	buffero[0] = c;
	buffero[1] = '\0';
	return makestr(buffero, 1);

	EIF_END_GET_CONTEXT
}

rt_public char *c_outp(EIF_CONTEXT EIF_POINTER p)
{
	EIF_GET_CONTEXT

	sprintf(buffero, "0x%lX", p);
	return makestr(buffero, strlen(buffero));

	EIF_END_GET_CONTEXT
}

#ifdef WORKBENCH

#include "eif_interp.h"

/* The following routine builds a tagged out string out of simple types.
 * The reason for this is that the debugger can request the value of, say,
 * local #2, and this might be an integer for instance... We cannot call
 * build_out, as it expects a true object, not a simple type...
 */

rt_shared char *simple_out(EIF_CONTEXT struct item *val) 
    /* Interpreter value cell */
{
	/* Hand build a tagged out representation for simple types. The
	 * representation should be kept in sync with those defined above.
	 * NB: this whole file needs a clean rewriting--RAM.
	 */
	EIF_GET_CONTEXT
	buffer_allocate();		/* Allocate initial `tagged_out' buffer */

	switch (val->type & SK_HEAD) {
	case SK_EXP:
	case SK_REF:
		xfree(tagged_out);							/* What a waste of CPU cycles */
		return build_out((EIF_OBJ)(&val->it_ref));	/* Only for the beauty of it */
	case SK_VOID:
		sprintf(tagged_out, "Not an object!");
		break;
	case SK_BOOL:
		sprintf(tagged_out, "BOOLEAN = %s", val->it_char ? "True" : "False");
		break;
	case SK_CHAR:
		write_char(val->it_char, tagged_out);
		break;
	case SK_INT:
		sprintf(tagged_out, "INTEGER = %ld", val->it_long);
		break;
	case SK_FLOAT:
		sprintf(tagged_out, "REAL = %g", val->it_float);
		break;
	case SK_DOUBLE:
		sprintf(tagged_out, "DOUBLE = %.17g", val->it_double);
	case SK_BIT:
		sprintf(tagged_out, "Bit object");
		break;
	case SK_POINTER:
		sprintf(tagged_out, "POINTER = C pointer 0x%lX", val->it_ref);
		break;
	default:
		sprintf(tagged_out, "Not an object?");
		break;
	}

	return tagged_out;

	EIF_END_GET_CONTEXT
}

#endif

