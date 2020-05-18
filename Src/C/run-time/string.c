/*
	description:	"Manipulations with strings and string objects."
	date:		"$Date$"
	revision:	"$Revision$"
	copyright:	"Copyright (c) 2020, Eiffel Software."
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"Commercial license is available at http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Runtime.

			Eiffel Software's Runtime is free software; you can
			redistribute it and/or modify it under the terms of the
			GNU General Public License as published by the Free
			Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).

			Eiffel Software's Runtime is distributed in the hope
			that it will be useful,	but WITHOUT ANY WARRANTY;
			without even the implied warranty of MERCHANTABILITY
			or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.

			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Runtime; if not,
			write to the Free Software Foundation, Inc.,
			51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
*/

/*
doc:<file name="string.c" header="rt_string.h" version="$Id$" summary="Manipulations with strings and string objects.">
*/

#include "eif_config.h"
#include "eif_macros.h"
#include "rt_string.h"
#include "rt_malloc.h"

/*
doc:	<routine name="string_32_from_char_8" return_type="EIF_REFERENCE" export="shared">
doc:		<summary>Create a new (mutable) STRING_32 object from a 0-terminated sequence of 8-bit characters. </summary>
doc:		<param name="data" type="char*">C representation to be used for initialization.</param>
doc:		<return>Newly created object on success. NULL if there is not enough memory.</return>
doc:		<synchronization>None.</synchronization>
doc:		<thread_safety>Safe.</thread_safety>
doc:	</routine>
*/
rt_shared EIF_REFERENCE string_32_from_char_8 (const char * data)
{
	EIF_REFERENCE result;		/* The Eiffel string returned. */
	size_t i, n;
	char * data_32;

		/* Get length of 8-bit string in bytes. */
	n = strlen (data);
		/* Allocate buffer to build 32-bit string. */
	data_32 = (char *) eif_rt_xcalloc(n * 4, sizeof(EIF_CHARACTER_32));
		/* Return Void on failure. */
	if (data_32 == (char *) 0)
		return (EIF_REFERENCE) 0;
		/* Copy data from 8-bit to 32-bit string. */
		/* TODO: Handle Unicode, e.g. encoded as UTF-8. */
	for (i = 0; i < n; i++)
	{
		data_32 [i * sizeof(EIF_CHARACTER_32)
#		if BYTEORDER != 0x1234
			+ 3
#		endif
			] = * (data++);
	}
		/* Create Eiffel object. */
	result = RTMS32_EX (data_32, n);
		/* Free the temporary buffer. */
	eif_rt_xfree(data_32);
	return result;
}

/*
doc:</file>
*/
