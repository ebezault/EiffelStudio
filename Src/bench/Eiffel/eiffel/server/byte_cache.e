-- Cache for byte code routine

class BYTE_CACHE 

inherit

	CACHE [BYTE_CODE, BODY_ID]

creation

	make

	
feature 

	Cache_size: INTEGER is 50;
			-- Size of cache

end
