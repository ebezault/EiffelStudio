AR = $(ISE_EIFFEL)\BCC55\bin\tlib 
CC = $(ISE_EIFFEL)\BCC55\bin\bcc32
CFLAGS = -O2 -I$(ISE_EIFFEL)\studio\spec\$(ISE_PLATFORM)\include -I$(ISE_EIFFEL)\BCC55\include  -L$(ISE_EIFFEL)\BCC55\lib 
LN = copy
MAKE = make
RANLIB = echo
RM = -del

SOURCES =  $(LSRCS)
OBJECTS =  $(OBJS) $(WOBJS)

all:: clean net.lib

.c.obj:
	$(CC) -c $(CFLAGS) $<

SMODE = network.c network_r.c hostname.c syncpoll.c storable.c

LSRCS = $(SMODE)

OBJS = \
	network.obj \
	network_r.obj \
	hostname.obj \
	syncpoll.obj \
	storable.obj

clean:
	$(RM) *.obj

net.lib: $(OBJS)
	$(RM) $@
	$(AR) $@ +network_r.obj +network.obj +hostname.obj +syncpoll.obj +storable.obj
	$(RANLIB) $@
	if not exist ..\spec mkdir ..\spec
	if not exist ..\spec\bcb mkdir ..\spec\bcb
	if not exist ..\spec\bcb\lib mkdir ..\spec\bcb\lib
	copy net.lib ..\spec\bcb\lib\net.lib
