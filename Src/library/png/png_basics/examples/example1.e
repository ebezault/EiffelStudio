indexing
	description: "First example of utilisation"
	author: "pascalf"
	date: "$Date$" 
	revision: "$Revision$"

class
	EXAMPLE1
 
inherit
	EXAMPLE_FRAME

feature -- drawing

	build is
			-- Build figures on the images.
		local
			pt1,pt2,pt3,pt4: EV_COORDINATES
			ang,ang2,ang3: EV_ANGLE
		do
			drawable.set_foreground_color(0,0,255)
			
			-- Draw a rectangle.
			drawable.draw_rectangle(100,100,40,50)
			
			-- Draw an ellipse and fill it.
			drawable.fill_ellipse(300,300,30,20)

			drawable.set_foreground_color(255,0,0)
	
			-- Draw a polyline
			drawable.draw_polyline(<<[300,10],
						[380,5],
						[300,40],
						[300,10]>>,TRUE)

			-- Draw a point
			drawable.draw_point(200,250)

			--Fill a slice
			drawable.fill_arc(100,350,60,70,0,90,0,1)

			--draw a text
			drawable.set_font(1)
			drawable.draw_text(50,50,"Hello")

			drawable.set_font(3)
			drawable.draw_text(50,80,"How are you ?")	
	end

feature -- Access
	
	suffix: STRING is "_1"

end -- class EXAMPLE1
