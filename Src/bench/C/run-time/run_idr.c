/*

    #    #####   #####           #####   #    #  #    #          ####
    #    #    #  #    #          #    #  #    #  ##   #         #    #
    #    #    #  #    #          #    #  #    #  # #  #         #
    #    #    #  #####           #####   #    #  #  # #  ###    #
    #    #    #  #   #           #   #   #    #  #   ##  ###    #    #
    #    #####   #    # #######  #    #   ####   #    #  ###     ####

	Internal data representation.

*/

#include "config.h"
#include "portable.h"
#include <stdio.h>
#include "err_msg.h"
#include <sys/types.h>
#ifdef I_NETINET_IN
#include <netinet/in.h>
#else
#ifdef I_SYS_IN
#include <sys/in.h>
#endif
#endif
#ifdef EIF_WIN32
#include <io.h>		/* %%ss added for read, write */
#include "winsock.h"
#endif
#include "eiffel.h"
#include "bits.h"
#include "retrieve.h"
#include "store.h"
#include "error.h"
#include "run_idr.h"
#include "../idrs/idrf.h"
#ifdef EIF_OS2
#include <io.h>
#endif


#define IDRF_SIZE 1024

rt_private IDRF idrf;

rt_shared char *idr_temp_buf;	/* This is shared so it can be freed
							 * if an exception occurs.
							 */

rt_private int amount_read = 0;	/* Amount read into buffer (see check_capacity) */


rt_public bool_t run_idr_setpos(IDR *idrs, int pos)
{
	/* Set the position of the stream to pos and return true if it is possible,
	 * false otherwise.
	 */

	if (pos >= idrs->i_size || pos < 0)
		return FALSE;
	
	idrs->i_ptr = idrs->i_buf + pos;
	return TRUE;
}


rt_public void run_mem_destroy(IDR *idrs)
{
	/* Release the memory used by the IDR stream */

	idrs->i_size = 0;
	if (idrs->i_buf != (char *) 0) {
		xfree(idrs->i_buf);
		idrs->i_buf = idrs->i_ptr = (char *) 0;
	}
}

rt_public void run_idrmem_create(IDR *idrs, char *addr, int len, int i_op)
          			/* The IDR structure managing the stream */
           			/* Address of the serializing buffer */
        			/* Length of the serializing buffer */
         			/* Operation wanted */
{
	/* Initialize a memory stream, where the (de)serialization is done in the
	 * provided buffer pointed to by addr.
	 */

	idrs->i_op = i_op;
	idrs->i_size = len;
	idrs->i_buf = addr;
	idrs->i_ptr = addr;
}


rt_public int run_idrf_create(int size)
         		/* Size of IDR buffers */
{
	/* Initializes memory for IDR operations. We create memory streams for
	 * input and output. Thus, all the input requests will have the same length,
	 * regardless of their type. The same applies for output request, although
	 * the size may not be the same. Return 0 if ok, -1 for failure.
	 */
	
	char *out_addr;			/* IDR output data buffer */
	char *in_addr;			/* IDR input data buffer */

	/* Create input IDR memory stream (decode mode) */
	if ((char *) 0 == (in_addr = (char *) xmalloc(size, C_T, GC_OFF)))
		return -1;

	/* Create output IDR memory stream (encode mode) */
	if ((char *) 0 == (out_addr = (char *) xmalloc(size, C_T, GC_OFF))) {
		xfree(in_addr);
		return -1;
	}

	run_idrmem_create(&idrf.i_decode, in_addr, size, IDR_DECODE);
	run_idrmem_create(&idrf.i_encode, out_addr, size, IDR_ENCODE);
	return 0;
}


rt_public void run_idr_init (void)
{
	if (-1 == run_idrf_create (IDRF_SIZE))
		eraise ("cannot allocate idrf", EN_MEM);

		/* Reset amount_read */
	amount_read = 0;
}

rt_public void run_idr_destroy (void)
{
	run_mem_destroy(&idrf.i_encode);
	run_mem_destroy(&idrf.i_decode);
}


rt_private int run_idr_read (IDR *bu)
{
        register char * ptr = bu->i_buf;
        short read_size, amount_left;
        register int part_read = 0, total_read = 0;

#ifdef EIF_WIN32
	if (r_fstoretype == 'F')
		{
		if ((read (r_fides, (char *)(&read_size), sizeof (short))) < sizeof (short))
			eio();
		}
	else
		if ((recv (r_fides, (char *)(&read_size), sizeof (short), 0)) < sizeof (short))
			eio();
#else
        if ((read (r_fides, (char *)(&read_size), sizeof (short))) < sizeof (short))
                eio();
#endif

	read_size = ntohs (read_size);
#ifdef DEBUG
	if (read_size > idrs_size (bu))
		print_err_msg(stderr, "Too large %d info for %d buffer\n", read_size, idrs_size (bu));
#endif

	amount_left = read_size;
	while (total_read < read_size) {
#ifdef EIF_WIN32
		if (r_fstoretype == 'F')
			{
			if ((part_read = read (r_fides, ptr, amount_left)) < 0)
				eio();
			}
		else
			if ((part_read = recv (r_fides, ptr, amount_left, 0)) < 0)
				eio();
#else
		if ((part_read = read (r_fides, ptr, amount_left)) < 0)
			eio();
#endif
		total_read += part_read;
		ptr += part_read;
		amount_left -= part_read;
		}
	return total_read;
}

rt_private void run_idr_write (IDR *bu)
{
        register char * ptr = idrs_buf (bu);
        short host_send, send_size = (short) (bu->i_ptr - idrs_buf (bu));
        register int number_writen;

#ifdef DEBUG
	if (send_size == 0)
		print_err_msg(stderr, "send size equal zero");
#endif

	host_send = htons (send_size);

#ifdef EIF_WIN32
	if (fstoretype == 'F')
		{
		if ((write (fides, (char *)(&host_send), sizeof (short))) < sizeof (short))
			eio();
		}
	else
		if ((send (fides,(char *)(&host_send), sizeof (short), 0)) < sizeof (short))
			eio();
#else
	if ((write (fides, &host_send, sizeof (short))) < sizeof (short))
		eio();
#endif

	while (send_size > 0) {
#ifdef EIF_WIN32
		if (fstoretype == 'F')
			{
			if ((number_writen = write (fides, ptr, (int) send_size)) <= 0)
				eio();
			}
		else
			if ((number_writen = send (fides, ptr, (int) send_size, 0)) <= 0)
				eio();
#else
		if ((number_writen = write (fides, ptr, (int) send_size)) <= 0)
			eio();
#endif
		send_size -= number_writen;
		ptr += number_writen;
		}
}

rt_public void check_capacity (IDR *bu, int size)
{

	if (idrs_op (bu)) {
		if ((bu->i_ptr + size) > (bu->i_buf + amount_read)) {
			amount_read = run_idr_read (bu);
			(void) run_idr_setpos (bu, 0);
		}
	} else {
		if ((bu->i_ptr + size) > (bu->i_buf + bu->i_size)) {
			run_idr_write (bu);
			(void) run_idr_setpos (bu, 0);
		}
	}
}

rt_public void idr_flush (void)
{
	check_capacity (&idrf.i_encode, IDRF_SIZE);
}

rt_public bool_t run_long(IDR *idrs, long int *lp, int len, int size)
{
	/* Serialize a long byte */

	uint32 value;		/* Value in network byte order */
	int i = 0;

	check_capacity (idrs, len * size);

	if (idrs->i_op == IDR_ENCODE) {
		while (len > i) {
#if LNGSIZ == 4
					/*encode for long = 4 bytes */
			value = htonl((uint32)(*(lp + (i++))));
			bcopy(&value, idrs->i_ptr, size);
			idrs->i_ptr += size;
#else
							/*encode for long = 8bytes */
			uint32 upper, lower;
			unsigned long temp;
		
			temp = (unsigned long) *(lp + (i++));	/*split long into upper and */
							/*lower 4 bytes */
			lower = (uint32) (temp & 0x00000000ffffffff);
			upper = (uint32) ((temp >> 32) & 0x00000000ffffffff);
			value = htonl((uint32)(lower));
			bcopy(&value, idrs->i_ptr, 4);
			idrs->i_ptr += 4;

			value = htonl((uint32)(upper));
			bcopy(&value, idrs->i_ptr, 4);
			idrs->i_ptr += 4;

#endif
		}
	} else {
		if (size == 4) {				/* decode a 4 byte long */
			while (len > i) {
				bcopy(idrs->i_ptr, &value, size);
#if LNGSIZ > 4
				*(lp + i) = (long) ntohl(value);
				idrs->i_ptr += size;
				if (*(lp + i) & 0x80000000) {
					*(lp + i) &= 0xffffffff7fffffff;
					*(lp + (i++)) |= 0x8000000000000000;
				}
				else
					i++;
#else
				*(lp + (i++)) = (long) ntohl(value);
				idrs->i_ptr += size;
#endif
			}
		} else {				/*decode an 8 byte long */
			while (len > i) {
				long upper, lower; /* %%ss removed , temp;*/

				bcopy(idrs->i_ptr, &value, 4);
				lower = (long) ntohl(value);
				idrs->i_ptr += 4;
				bcopy(idrs->i_ptr, &value, 4);
				upper = (long) ntohl(value);
				idrs->i_ptr += 4;
#if PTRSIZ == 4
						/*if the data has come from a 8 byte */
				*(lp + i) = lower;		/* long machine and we are only a 4 byte*/
				if (upper & 0x80000000){
					if (lower & 0x80000000)
						print_err_msg(stderr, "64 bit int truncated to 32 bit \n");
					*(lp + (i++)) |= 0x80000000;
				} else {
					i++;
					if (upper)
						print_err_msg(stderr, "64 bit int truncated to 32 bit \n");
				}
							/*long machine only take the lower 4 bytes*/
							/* This will cause lost of data but l am */
						/* assuming we do not send any longs between*/
						/* 64 bit to 32 bit that are larger than 2^32 */

#else
						/* rejoin the upper and lower parts */ 

				*(lp + (i++)) = (lower & 0x00000000ffffffff) | (upper << 32);
#endif
			}
		}
	}
	return TRUE;
}

rt_public bool_t run_ulong(IDR *idrs, long unsigned int *lp, int len, int size)
{
	/* Serialize a long byte */

	uint32 value;		/* Value in network byte order */
	int i = 0;

	check_capacity (idrs, len * size);

	if (idrs->i_op == IDR_ENCODE) {
		while (len > i) {
#if LNGSIZ == 4
					/*encode for long = 4 bytes */
			value = htonl((uint32)(*(lp + (i++))));
			bcopy(&value, idrs->i_ptr, size);
			idrs->i_ptr += size;
#else
							/*encode for long = 8bytes */
			uint32 upper, lower;
			unsigned long temp;
		
			temp = *(lp + (i++));		/*split long into upper and */
							/*lower 4 bytes */
			lower = (uint32) (temp & 0x00000000ffffffff);
			upper = (uint32) ((temp >> 32) & 0x00000000ffffffff);
			value = htonl((uint32)(lower));
			bcopy(&value, idrs->i_ptr, 4);
			idrs->i_ptr += 4;

			value = htonl((uint32)(upper));
			bcopy(&value, idrs->i_ptr, 4);
			idrs->i_ptr += 4;
#endif
		}
	} else {
		if (size == 4) {				/* decode a 4 byte long */
			while (len > i) {
				bcopy(idrs->i_ptr, &value, size);
				*(lp + (i++)) = (unsigned long) ntohl(value);
				idrs->i_ptr += size;
			}
		} else {						/*decode an 8 byte long */
			while (len > i) {
				unsigned long upper, lower;
	
				bcopy(idrs->i_ptr, &value, 4);
				lower = (unsigned long) ntohl(value);
				idrs->i_ptr += 4;
				bcopy(idrs->i_ptr, &value, 4);
				upper = (unsigned long) ntohl(value);
				idrs->i_ptr += 4;
#if LNGSIZ == 4
						/*if the data has come from a 8 byte */
				*(lp + (i++)) = lower;		/* long machine and we are only a 4 byte*/
						/*long machine only take the lower 4 bytes*/
						/* This will cause lost of data but l am */
						/* assuming we do not send any longs between*/
						/* 64 bit to 32 bit that are larger than 2^32 */
#else
						/* rejoin the upper and lower parts */ 

				*(lp + (i++)) = (lower & 0x00000000ffffffff) | (upper << 32);
#endif
			}
		}
	}
	return TRUE;
}

rt_public bool_t run_int(IDR *idrs, uint32 *ip, int len)
{
	/* Serialize a int byte */

	uint32 value;		/* Value in network byte order */
	int i = 0;

	check_capacity (idrs, len * sizeof (uint32));

	if (idrs->i_op == IDR_ENCODE) {
		while (len > i) {
			value = htonl(*(ip + (i++)));
			bcopy(&value, idrs->i_ptr, sizeof (uint32));
			idrs->i_ptr += sizeof (uint32);
		}
	} else {
		while (len > i) {
			bcopy(idrs->i_ptr, &value, sizeof (uint32));
			*(ip + (i++)) = ntohl(value);
			idrs->i_ptr += sizeof (uint32);
		}
	}
	return TRUE;
}


rt_public void ridr_multi_char (char *obj, int num)
{
	int cap = IDRF_SIZE / sizeof (char);

	if ((num - cap) <= 0) {
		check_capacity (&idrf.i_decode, num);
		bcopy (idrf.i_decode.i_ptr, obj, num);
		idrf.i_decode.i_ptr += num;
	} else {
		int count = num / cap;
		int left_over = num % cap;

		while (count) {
			check_capacity (&idrf.i_decode, cap);
                	bcopy (idrf.i_decode.i_ptr, obj, cap);
			obj += cap;
                	idrf.i_decode.i_ptr += cap;
			count--;
		}
		check_capacity (&idrf.i_decode, left_over);
                bcopy (idrf.i_decode.i_ptr, obj, left_over);
                idrf.i_decode.i_ptr += left_over;

	}
}

rt_public void widr_multi_char (char *obj, int num)
{
	int cap = IDRF_SIZE / sizeof (char);

	if ((num - cap) <= 0) {
		check_capacity (&idrf.i_encode, num);
		bcopy (obj, idrf.i_encode.i_ptr, num);
		idrf.i_encode.i_ptr += num;
	} else {
		int count = num / cap;
		int left_over = num % cap;

		while (count) {
			check_capacity (&idrf.i_encode, cap);
                	bcopy (obj, idrf.i_encode.i_ptr, cap);
			obj += cap;
                	idrf.i_encode.i_ptr += cap;
			count--;
		}
		check_capacity (&idrf.i_encode, left_over);
                bcopy (obj, idrf.i_encode.i_ptr, left_over);
                idrf.i_encode.i_ptr += left_over;

	}
}


rt_public void ridr_multi_any (char *obj, int num)
{
	int cap;
	char s;

	check_capacity (&idrf.i_decode, sizeof (char));
	bcopy (idrf.i_decode.i_ptr, &s, sizeof (char));
	idrf.i_decode.i_ptr += sizeof (char);
	cap = IDRF_SIZE / s;

	if ((num - cap) <= 0) {
		run_ulong (&idrf.i_decode, (long unsigned int *) obj, num, s);
	} else {
		int count = num / cap;
		int left_over = num % cap;
		long *lptr = (long *) obj;

		while (count) {
                	run_ulong (&idrf.i_decode, (long unsigned int *) lptr, cap, s);
			lptr += cap;
			count--;
		}
                run_ulong (&idrf.i_decode, (long unsigned int *) lptr, left_over, s);
	}
}

rt_public void widr_multi_any (char *obj, int num)
{
	int cap = IDRF_SIZE / sizeof (char *);
	char s = (char) sizeof (char *);

	check_capacity (&idrf.i_encode, sizeof (char));
	bcopy (&s, idrf.i_encode.i_ptr, sizeof (char));
	idrf.i_encode.i_ptr += sizeof (char);

	if ((num - cap) <= 0) {
		run_ulong (&idrf.i_encode, (long unsigned int *) obj, num, sizeof (char *));
	} else {
		int count = num / cap;
		int left_over = num % cap;
		long *lptr = (long *) obj;

		while (count) {
                	run_ulong (&idrf.i_encode, (long unsigned int *) lptr, cap, sizeof (char *));
			lptr += cap;
			count--;
		}
                run_ulong (&idrf.i_encode, (long unsigned int *) lptr, left_over, sizeof (char *));
	}
}


rt_public void ridr_multi_int (long int *obj, int num)
{
	int cap;
	char s;

	check_capacity (&idrf.i_decode, sizeof (char));
	bcopy (idrf.i_decode.i_ptr, &s, sizeof (char));
	idrf.i_decode.i_ptr += sizeof (char);
	cap = IDRF_SIZE / s;

	if ((num - cap) <= 0) {
		run_ulong (&idrf.i_decode, (long unsigned int *) obj, num, s);
	} else {
		int count = num / cap;
		int left_over = num % cap;

		while (count) {
                	run_ulong (&idrf.i_decode, (long unsigned int *) obj, cap, s);
			obj += cap;
			count--;
		}
                run_ulong (&idrf.i_decode, (long unsigned int *) obj, left_over, s);
	}
}

rt_public void widr_multi_int (long int *obj, int num)
{
	int cap = IDRF_SIZE / sizeof (long);
	char s = (char) sizeof (long);

	check_capacity (&idrf.i_encode, sizeof (char));
	bcopy (&s, idrf.i_encode.i_ptr, sizeof (char));
	idrf.i_encode.i_ptr += sizeof (char);

	if ((num - cap) <= 0) {
		run_ulong (&idrf.i_encode, (long unsigned int *) obj, num, sizeof (long));
	} else {
		int count = num / cap;
		int left_over = num % cap;

		while (count) {
                	run_ulong (&idrf.i_encode, (long unsigned int *) obj, cap, sizeof (long));
			obj += cap;
			count--;
		}
                run_ulong (&idrf.i_encode, (long unsigned int *) obj, left_over, sizeof (long));
	}
}


rt_public void ridr_multi_float (float *obj, int num)
{
	register int i = 0;
	char temp_len;

	while (num > i++) {
		check_capacity (&idrf.i_decode, sizeof (char));
		bcopy (idrf.i_decode.i_ptr, &temp_len, sizeof(char));
		idrf.i_decode.i_ptr += sizeof (char);

		check_capacity (&idrf.i_decode, (int)temp_len);
		bcopy (idrf.i_decode.i_ptr, idr_temp_buf, (int)temp_len);
		idrf.i_decode.i_ptr += (int)temp_len;
		*(idr_temp_buf + temp_len) = '\0';
		sscanf (idr_temp_buf, "%f", (obj++));
	}
}

rt_public void widr_multi_float (float *obj, int num)
{
	register int i = 0;
	char temp_len;

	while (num > i++) {
		sprintf (idr_temp_buf, "%f", *(obj++));
		temp_len = (char) strlen (idr_temp_buf);
		check_capacity (&idrf.i_encode, sizeof (char));
		bcopy (&temp_len, idrf.i_encode.i_ptr, sizeof(char));
		idrf.i_encode.i_ptr += sizeof (char);

		check_capacity (&idrf.i_encode, (int)temp_len);
		bcopy (idr_temp_buf, idrf.i_encode.i_ptr, (int)temp_len);
		idrf.i_encode.i_ptr += (int)temp_len;
	}
}


rt_public void ridr_multi_double (double *obj, int num)
{
	register int i = 0;
	char temp_len;

	while (num > i++) {
		check_capacity (&idrf.i_decode, sizeof (char));
		bcopy (idrf.i_decode.i_ptr, &temp_len, sizeof(char));
		idrf.i_decode.i_ptr += sizeof (char);

		check_capacity (&idrf.i_decode, (int)temp_len);
		bcopy (idrf.i_decode.i_ptr, idr_temp_buf, (int)temp_len);
		idrf.i_decode.i_ptr += (int)temp_len;
		*(idr_temp_buf + temp_len) = '\0';
		sscanf (idr_temp_buf, "%lf", obj++);
	}
}

rt_public void widr_multi_double (double *obj, int num)
{
	register int i = 0;
	char temp_len;

	while (num > i++) {
		sprintf (idr_temp_buf, "%lf", *(obj++));
		temp_len = (char) strlen (idr_temp_buf);
		check_capacity (&idrf.i_encode, sizeof (char));
		bcopy (&temp_len, idrf.i_encode.i_ptr, sizeof(char));
		idrf.i_encode.i_ptr += sizeof (char);

		check_capacity (&idrf.i_encode, (int)temp_len);
		bcopy (idr_temp_buf, idrf.i_encode.i_ptr, (int)temp_len);
		idrf.i_encode.i_ptr += (int)temp_len;
	}
}


rt_public void ridr_multi_bit (struct bit *obj, int num, long int elm_siz)
{
	int i = 0;
	int siz, number_of_bits;
	int cap;
	uint32 *iptr = ARENA (obj);


	run_int (&idrf.i_decode, (uint32 *) (&number_of_bits), 1);
	siz = BIT_NBPACK (number_of_bits);
	cap = IDRF_SIZE / (siz * sizeof (uint32));


	if (cap != 0) {
		while (num > i) {
			LENGTH ((((char *)obj) + (elm_siz * i++))) = number_of_bits;
			run_int (&idrf.i_decode, iptr, siz);
			iptr = ARENA ((((char *)obj) + (elm_siz * i)));
		}
	} else {
		int loop_c, count = (siz * sizeof (uint32)) / IDRF_SIZE;
		int left_over = (siz * sizeof (uint32))% IDRF_SIZE;
		int write_size = IDRF_SIZE / sizeof (uint32);

		while (num > i++) {
			loop_c = count;
			while (loop_c) {

				run_int (&idrf.i_decode, iptr, write_size);
				iptr += write_size;
				loop_c--;
			} 
			run_int (&idrf.i_decode, iptr, left_over);
			iptr = ARENA ((((char *)obj) + (elm_siz * i)));
		}
	}
}

rt_public void widr_multi_bit (struct bit *obj, int num, uint32 len, int elm_siz)
{
	int i = 0;
	int siz = BIT_NBPACK (len);
	int cap;
	uint32 *iptr = ARENA (obj);

	cap = IDRF_SIZE / (siz * sizeof (uint32));

	run_int (&idrf.i_encode, &len, 1);
	if (cap != 0) {
		while (num > i++) {
			run_int (&idrf.i_encode, iptr, siz);
			iptr = ARENA ((((char *)obj) + (elm_siz * i)));
		}
	} else {
		int loop_c, count = (siz * sizeof (uint32)) / IDRF_SIZE;
		int left_over = (siz * sizeof (uint32)) % IDRF_SIZE;
		int write_size = IDRF_SIZE / sizeof (uint32);

		while (num > i++) {
			loop_c = count;
			while (loop_c) {

				run_int (&idrf.i_encode, iptr, write_size);
				iptr += write_size;
				loop_c--;
			} 
			run_int (&idrf.i_encode, iptr, left_over);
			iptr = ARENA ((((char *)obj) + (elm_siz * i)));
		}
	}
}

rt_public void ridr_norm_int (uint32 *obj)
{
	run_int (&idrf.i_decode, obj, 1);
}

rt_public void widr_norm_int (uint32 *obj)
{
	run_int (&idrf.i_encode, obj, 1);
}

rt_public int idr_read_line (char *bu, int max_size)
{
	char *ptr = bu;
	register int i;

	for (i = 1; i < max_size; i++) {
		ridr_multi_char (ptr, 1);
		if (*(ptr++) == '\n')
			break;
	}
	*ptr = '\0';
	return (ptr - bu);
}
