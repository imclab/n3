
////////////////////////////////////////////////////////////////////////////////
// LCD
////////////////////////////////////////////////////////////////////////////////

LCD_BOARD_THICKNESS=1.6;
LCD_BOARD_WIDTH=40.0;
LCD_BOARD_HEIGHT=23.2 + 6.8;

LCD_PIN_THICKNESS=13-(1.6+9.0);

LCD_DISPLAY_THICKNESS=9.0;
LCD_DISPLAY_WIDTH=36;
LCD_DISPLAY_HEIGHT=23.2;

LCD_ACTIVE_WIDTH=30.4;
LCD_ACTIVE_HEIGHT=13.9;

LCD_TAB_LENGTH = 35.4 - LCD_BOARD_HEIGHT;
LCD_TAB_RADIUS = 2.5;
LCD_TAB_THICKNESS = 0.6;

LCD_HOLE_RADIUS = 1.5;

LCD_TOP_HOLE_SPACING = 36.0;
LCD_TOP_HOLE_OFFSET = 3.4;

// An ADM0802A 8x2 LCD Module
module lcd() {
	
	difference() {
		union() {
			// Board
			cube([LCD_BOARD_WIDTH, LCD_BOARD_HEIGHT, LCD_BOARD_THICKNESS]);
			
			// Display
			translate([LCD_BOARD_WIDTH/2 - LCD_DISPLAY_WIDTH/2, 0, LCD_BOARD_THICKNESS])
				cube([LCD_DISPLAY_WIDTH, LCD_DISPLAY_HEIGHT, LCD_DISPLAY_THICKNESS]);
			
			// Tabs
			for (x_offset = [0, LCD_BOARD_WIDTH-(LCD_TAB_RADIUS*2)]) {
				translate([x_offset, -(LCD_TAB_LENGTH-LCD_TAB_RADIUS), 0])
					cube([2*LCD_TAB_RADIUS, LCD_TAB_LENGTH-LCD_TAB_RADIUS, LCD_TAB_THICKNESS]);
				translate([x_offset + LCD_TAB_RADIUS, -(LCD_TAB_LENGTH-LCD_TAB_RADIUS), 0])
					cylinder(h=LCD_TAB_THICKNESS, r = LCD_TAB_RADIUS);
			}
			
			// Backing crap
			translate([0,0,-LCD_PIN_THICKNESS])
				% cube([LCD_BOARD_WIDTH, LCD_DISPLAY_HEIGHT, LCD_PIN_THICKNESS]);
		}
		
		// Mounting Holes
		union() {
			// Bottom tabs
			for (x_offset = [0, LCD_BOARD_WIDTH-(LCD_TAB_RADIUS*2)]) {
				translate([x_offset + LCD_TAB_RADIUS, -(LCD_TAB_LENGTH-LCD_TAB_RADIUS), 0])
					cylinder(r = LCD_HOLE_RADIUS, h=LCD_TAB_THICKNESS);
			}
			
			// Top
			for (x_offset = [0.0, 1.0]) {
				translate([ (LCD_BOARD_WIDTH/2) - (LCD_TOP_HOLE_SPACING/2) + (x_offset*LCD_TOP_HOLE_SPACING)
				           , LCD_BOARD_HEIGHT - LCD_TOP_HOLE_OFFSET
				           , 0
				           ])
					cylinder(r = LCD_HOLE_RADIUS, h=LCD_BOARD_THICKNESS);
			}
		}
	}
}

////////////////////////////////////////////////////////////////////////////////
// GPS
////////////////////////////////////////////////////////////////////////////////

GPS_BOARD_WIDTH = 30; 
GPS_BOARD_HEIGHT = 30; 
GPS_BOARD_THICKNESS = 0.8; 

GPS_CHIP_WIDTH = 25; 
GPS_CHIP_HEIGHT = 25; 
GPS_CHIP_THICKNESS = 4.2 + 0.8; 

GPS_PIN_THICKNESS = 2.2;

GPS_HOLE_X_OFFSET = 1.6;
GPS_HOLE_Y_OFFSET = 1.6;
GPS_HOLE_RADIUS = 1.0;

module gps() {
	difference() {
		union() {
			// Board
			cube([GPS_BOARD_WIDTH, GPS_BOARD_HEIGHT, GPS_BOARD_THICKNESS]);
			
			// Chip
			translate([ (GPS_BOARD_WIDTH/2) - (GPS_CHIP_WIDTH/2)
			          , (GPS_BOARD_HEIGHT/2) - (GPS_CHIP_HEIGHT/2)
			          , GPS_BOARD_THICKNESS
			          ])
				cube([GPS_CHIP_WIDTH, GPS_CHIP_HEIGHT, GPS_CHIP_THICKNESS]);
			
			// Pins
			translate([0,0,-GPS_PIN_THICKNESS])
				% cube([GPS_BOARD_WIDTH, GPS_BOARD_HEIGHT, GPS_PIN_THICKNESS]);
		}
		
		// Mounting holes
		union() {
			for (y = [0,1]) {
				for (x = [0,1]) {
					translate([ GPS_HOLE_X_OFFSET + x*(GPS_BOARD_WIDTH-(2*GPS_HOLE_X_OFFSET))
					          , GPS_HOLE_Y_OFFSET + y*(GPS_BOARD_WIDTH-(2*GPS_HOLE_Y_OFFSET))
					          , 0
					          ])
						cylinder(r=GPS_HOLE_RADIUS, h=GPS_BOARD_THICKNESS);
				}
			}
		}
	}
}


////////////////////////////////////////////////////////////////////////////////
// Maple Mini
////////////////////////////////////////////////////////////////////////////////

MPL_BOARD_WIDTH = 18.0;
MPL_BOARD_HEIGHT = 51.0;
MPL_BOARD_THICKNESS = 2; // ??

MPL_USB_WIDTH = 6.0; // ??
MPL_USB_HEIGHT = 7.0; // ??
MPL_USB_THICKNESS = 3.0; // ??
MPL_USB_OFFSET = -1.0; // ??

module maple() {
	union() {
		// Board
		cube([MPL_BOARD_WIDTH, MPL_BOARD_HEIGHT, MPL_BOARD_THICKNESS]);
		
		// USB
		translate([MPL_BOARD_WIDTH/2 - MPL_USB_WIDTH/2, MPL_USB_OFFSET, MPL_BOARD_THICKNESS])
			cube([MPL_USB_WIDTH, MPL_USB_HEIGHT, MPL_USB_THICKNESS]);
	}
}


////////////////////////////////////////////////////////////////////////////////
// Power Convertor
////////////////////////////////////////////////////////////////////////////////

PWR_BOARD_WIDTH = 12; // ??
PWR_BOARD_HEIGHT = 26; // ??
PWR_BOARD_THICKNESS = 2; // ??

PWR_USB_WIDTH = 11; // ??
PWR_USB_HEIGHT = 13; // ??
PWR_USB_THICKNESS = 5; // ??

module power() {
	union() {
		// Board
		cube([PWR_BOARD_WIDTH, PWR_BOARD_HEIGHT, PWR_BOARD_THICKNESS]);
		
		// USB
		translate([PWR_BOARD_WIDTH/2 - PWR_USB_WIDTH/2, 0, PWR_BOARD_THICKNESS])
			cube([PWR_USB_WIDTH, PWR_USB_HEIGHT, PWR_USB_THICKNESS]);
	}
}


////////////////////////////////////////////////////////////////////////////////
// AA Battery Holder
////////////////////////////////////////////////////////////////////////////////

BAT_WIDTH = 32; // ??
BAT_HEIGHT = 57; // ??
BAT_THICKNESS = 15.7; // ??

module batteries() {
	union() {
		// Container
		cube([BAT_WIDTH, BAT_HEIGHT, BAT_THICKNESS]);
	}
}


////////////////////////////////////////////////////////////////////////////////
// Rounded cube things
////////////////////////////////////////////////////////////////////////////////

DISABLE_ROUND_CUBE = false;

module round_cube(s, rs) {
	if (DISABLE_ROUND_CUBE) {
		cube(s);
	} else {
		hull() {
			for (x = [rs[0], s[0]-rs[0]]) {
				for (y = [rs[1], s[1]-rs[1]]) {
					for (z = [rs[2], s[2]-rs[1]]) {
						translate([x,y,z])
							scale([rs[0]/5, rs[1]/5, rs[2]/5])
								sphere(r = 5);
					}
				}
			}
		}
	}
}


////////////////////////////////////////////////////////////////////////////////
// AA-Battery
////////////////////////////////////////////////////////////////////////////////

AA_DIAMETER = 14.0;
AA_LENGTH = 48.5;

AA_NUB_DIAMETER = 5.2;
AA_NUB_LENGTH = 1.5;

AA_BTM_DIAMETER = 10;
AA_BTM_LENGTH = 0.4;

AA_BTM_HOLE_DIAMETER = 1.6;
AA_BTM_HOLE_LENGTH = 0.8;

module aa_bat() {
	
}

////////////////////////////////////////////////////////////////////////////////
// Case
////////////////////////////////////////////////////////////////////////////////

CASE_BAT_LENGTH = AA_LENGTH+AA_NUB_LENGTH+AA_BTM_LENGTH + 8.0;

CASE_WALL = 5.0;
CASE_ROUNDING = [CASE_WALL, CASE_WALL, CASE_WALL];

CASE_SCREEN_COVER_DEPTH = 2.0;
CASE_SCREEN_COVER_MARGIN = 3.0;
CASE_SCREEN_COVER_WIDTH  = LCD_ACTIVE_WIDTH;
CASE_SCREEN_COVER_HEIGHT = LCD_ACTIVE_HEIGHT;
CASE_SCREEN_COVER_THICKNESS = 3.0;

CASE_SCREEN_TOLLERANCE = 1;

CASE_GPS_TOLLERANCE = 0.5;

CASE_SWIRE_HEIGHT = 3.0;
CASE_SWIRE_WIDTH = LCD_BOARD_WIDTH - 10.0;
CASE_SWIRE_THICKNESS = 3.0;

CASE_BAT_DEPTH = 2.5;

CASE_WIDTH     = max(LCD_BOARD_WIDTH, CASE_SCREEN_COVER_WIDTH + 2*CASE_SCREEN_COVER_MARGIN) + 2*CASE_WALL;
CASE_HEIGHT    = LCD_BOARD_HEIGHT + 4*CASE_SCREEN_TOLLERANCE + CASE_SWIRE_HEIGHT + GPS_BOARD_HEIGHT + 2*CASE_GPS_TOLLERANCE + 2*CASE_WALL;
CASE_THICKNESS = BAT_THICKNESS + CASE_BAT_DEPTH
               + LCD_BOARD_THICKNESS + LCD_DISPLAY_THICKNESS
               + CASE_SCREEN_COVER_THICKNESS
               + CASE_SCREEN_COVER_DEPTH
               + CASE_SCREEN_TOLLERANCE*3
               ;

echo("Case size:", CASE_WIDTH, CASE_HEIGHT, CASE_THICKNESS);

module case() {
	difference() {
		// The case itself
		%round_cube([CASE_WIDTH, CASE_HEIGHT, CASE_THICKNESS], CASE_ROUNDING);
		
		// Carve out space inside
		union () {
			
			// -----------------------------------------------------------------------------
			
			// The hole for the screen
			translate([ CASE_WIDTH/2 - CASE_SCREEN_COVER_WIDTH/2
			          , CASE_HEIGHT - CASE_SWIRE_HEIGHT - CASE_WALL - LCD_BOARD_HEIGHT + (LCD_DISPLAY_HEIGHT-LCD_ACTIVE_HEIGHT)/2
			          , CASE_THICKNESS - CASE_SCREEN_COVER_DEPTH
			          ])
				cube([ CASE_SCREEN_COVER_WIDTH
				     , CASE_SCREEN_COVER_HEIGHT
				     , CASE_SCREEN_COVER_DEPTH
				     ]);
			
			// The hole for the perspex screen cover
			translate([ CASE_WIDTH/2 - CASE_SCREEN_COVER_WIDTH/2 - CASE_SCREEN_COVER_MARGIN
			          , CASE_HEIGHT - CASE_SWIRE_HEIGHT - CASE_WALL - LCD_BOARD_HEIGHT + (LCD_DISPLAY_HEIGHT-LCD_ACTIVE_HEIGHT)/2 - CASE_SCREEN_COVER_MARGIN
			          , CASE_THICKNESS - CASE_SCREEN_COVER_DEPTH - CASE_SCREEN_COVER_THICKNESS
			          ])
				cube([ CASE_SCREEN_COVER_WIDTH + 2*CASE_SCREEN_COVER_MARGIN
				     , CASE_SCREEN_COVER_HEIGHT + 2*CASE_SCREEN_COVER_MARGIN
				     , CASE_SCREEN_COVER_THICKNESS
				     ]);
			
			// The gap for the display itself
			translate([ CASE_WIDTH/2 - LCD_DISPLAY_WIDTH/2 - CASE_SCREEN_TOLLERANCE
			          , CASE_HEIGHT - CASE_SWIRE_HEIGHT - CASE_WALL - LCD_BOARD_HEIGHT - CASE_SCREEN_TOLLERANCE
			          , CASE_THICKNESS - CASE_SCREEN_COVER_DEPTH -
			            CASE_SCREEN_COVER_THICKNESS - LCD_DISPLAY_THICKNESS -
			            CASE_SCREEN_TOLLERANCE
			          ])
				cube([ LCD_DISPLAY_WIDTH + 2*CASE_SCREEN_TOLLERANCE
				     , LCD_DISPLAY_HEIGHT + 2*CASE_SCREEN_TOLLERANCE
				     , LCD_DISPLAY_THICKNESS + CASE_SCREEN_TOLLERANCE
				     ]);
			
			// The gap for wires from the display
			translate([ CASE_WIDTH/2 - CASE_SWIRE_WIDTH/2
			          , CASE_HEIGHT - CASE_SWIRE_HEIGHT - CASE_WALL - (LCD_BOARD_HEIGHT-LCD_DISPLAY_HEIGHT)
			          , CASE_THICKNESS - CASE_SCREEN_COVER_DEPTH -
			            CASE_SCREEN_COVER_THICKNESS - LCD_DISPLAY_THICKNESS -
			            CASE_SCREEN_TOLLERANCE*2 - LCD_BOARD_THICKNESS
			          ])
				cube([ CASE_SWIRE_WIDTH
				     , LCD_BOARD_HEIGHT - LCD_DISPLAY_HEIGHT + CASE_SWIRE_HEIGHT
				     , CASE_SWIRE_THICKNESS + LCD_BOARD_THICKNESS + CASE_SCREEN_TOLLERANCE
				     ]);
			
			// The gap for the LCD's board
			translate([ CASE_WIDTH/2 - LCD_BOARD_WIDTH/2 - CASE_SCREEN_TOLLERANCE
			          , CASE_HEIGHT - CASE_SWIRE_HEIGHT - CASE_WALL - LCD_BOARD_HEIGHT - CASE_SCREEN_TOLLERANCE
			          , CASE_THICKNESS - CASE_SCREEN_COVER_DEPTH -
			            CASE_SCREEN_COVER_THICKNESS - LCD_DISPLAY_THICKNESS -
			            CASE_SCREEN_TOLLERANCE*2 - LCD_BOARD_THICKNESS
			          ])
				cube([ LCD_BOARD_WIDTH + 2*CASE_SCREEN_TOLLERANCE
				     , LCD_BOARD_HEIGHT + 2*CASE_SCREEN_TOLLERANCE
				     , LCD_BOARD_THICKNESS + CASE_SCREEN_TOLLERANCE
				     ]);
			
			// The space for the tabs on the LCD
			translate([ CASE_WIDTH/2 - LCD_BOARD_WIDTH/2 - CASE_SCREEN_TOLLERANCE
			          , CASE_HEIGHT - CASE_SWIRE_HEIGHT - CASE_WALL - LCD_BOARD_HEIGHT -
			          3*CASE_SCREEN_TOLLERANCE - LCD_TAB_LENGTH
			          , CASE_THICKNESS - CASE_SCREEN_COVER_DEPTH -
			            CASE_SCREEN_COVER_THICKNESS - LCD_DISPLAY_THICKNESS -
			            CASE_SCREEN_TOLLERANCE*2 - LCD_BOARD_THICKNESS
			          ])
				cube([ LCD_TAB_RADIUS + 2*CASE_SCREEN_TOLLERANCE
				     , LCD_TAB_LENGTH + 2*CASE_SCREEN_TOLLERANCE
				     , LCD_BOARD_THICKNESS + CASE_SCREEN_TOLLERANCE
				     ]);
			translate([ CASE_WIDTH/2 + LCD_BOARD_WIDTH/2 - CASE_SCREEN_TOLLERANCE - LCD_TAB_RADIUS
			          , CASE_HEIGHT - CASE_SWIRE_HEIGHT - CASE_WALL - LCD_BOARD_HEIGHT -
			          3*CASE_SCREEN_TOLLERANCE - LCD_TAB_LENGTH
			          , CASE_THICKNESS - CASE_SCREEN_COVER_DEPTH -
			            CASE_SCREEN_COVER_THICKNESS - LCD_DISPLAY_THICKNESS -
			            CASE_SCREEN_TOLLERANCE*2 - LCD_BOARD_THICKNESS
			          ])
				cube([ LCD_TAB_RADIUS + 2*CASE_SCREEN_TOLLERANCE
				     , LCD_TAB_LENGTH + 2*CASE_SCREEN_TOLLERANCE
				     , LCD_BOARD_THICKNESS + CASE_SCREEN_TOLLERANCE
				     ]);
			
			// -----------------------------------------------------------------------------
			
			// The GPS chip antenna
			translate([ CASE_WALL + (GPS_BOARD_HEIGHT-GPS_CHIP_HEIGHT)/2 - CASE_GPS_TOLLERANCE
			          , CASE_WALL + (GPS_BOARD_HEIGHT-GPS_CHIP_HEIGHT)/2 - CASE_GPS_TOLLERANCE
			          , CASE_THICKNESS - GPS_CHIP_THICKNESS - CASE_WALL
			          ])
				cube([ GPS_CHIP_WIDTH + 2*CASE_GPS_TOLLERANCE
				     , GPS_CHIP_HEIGHT + 2*CASE_GPS_TOLLERANCE
				     , GPS_CHIP_THICKNESS + CASE_GPS_TOLLERANCE
				     ]);
			
			// The GPS board + pins
			translate([ CASE_WALL
			          , CASE_WALL - CASE_GPS_TOLLERANCE
			          , CASE_THICKNESS - (GPS_CHIP_THICKNESS + GPS_BOARD_THICKNESS +
			          GPS_PIN_THICKNESS) - CASE_WALL
			          ])
				cube([ GPS_BOARD_WIDTH + 2*CASE_GPS_TOLLERANCE
				     , GPS_BOARD_HEIGHT + 2*CASE_GPS_TOLLERANCE
				     , GPS_BOARD_THICKNESS + GPS_PIN_THICKNESS + CASE_GPS_TOLLERANCE
				     ]);
			
			// -----------------------------------------------------------------------------
			
			// Battery Area
			translate([ CASE_WALL
			          , CASE_WALL
			          , CASE_BAT_DEPTH
			          ])
				cube([BAT_WIDTH, BAT_HEIGHT, BAT_THICKNESS]);
		}
	}
}


////////////////////////////////////////////////////////////////////////////////
// Halves of a hollow container
////////////////////////////////////////////////////////////////////////////////

// size: The size of the box [w,h,t]
// wall_thickness: Thicknesses of the walls of the box
// joint_size: The size of the joint
// joint_tollerance: Size of a gap added as extra around the join.
// female: Is this the female part of the box?
// radius: The radius of the rounding of the corners
module box_half(size, wall_thickness, joint_size, joint_tollerance, female, radius) {
	// Half is in the top, half in the bottom
	joint_tollerance = joint_tollerance / 2;
	
	union() {
		// The box itself
		difference() {
			round_cube([size[0], size[1], size[2]+radius], [radius,radius, radius]);
			
			// Chop the rounded corners off
			translate([0,0,size[2]])
				cube([size[0], size[1], radius]);
			
			
			// Hollow out the inside
			translate([wall_thickness, wall_thickness, wall_thickness])
				cube([ size[0] - (wall_thickness*2)
				     , size[1] - (wall_thickness*2)
				     , size[2]
				     ]);
		}
		
		// Create the joint
		if (!female) {
			difference() {
				translate([wall_thickness/3 + joint_tollerance/4, wall_thickness/3 + joint_tollerance/4, size[2]])
					cube([ size[0] - (2*(wall_thickness/3)) - joint_tollerance/2
					     , size[1] - (2*(wall_thickness/3)) - joint_tollerance/2
					     , joint_size
					     ]);
				
				translate([2*(wall_thickness/3) - joint_tollerance/4, 2*(wall_thickness/3) - joint_tollerance/4, size[2] - 1])
					cube([ size[0] - (4*(wall_thickness/3)) + joint_tollerance/2
					     , size[1] - (4*(wall_thickness/3)) + joint_tollerance/2
					     , joint_size + 2
					     ]);
			}
		} else {
			union() {
				// Inner lip
				difference() {
					translate([2*(wall_thickness/3) + joint_tollerance/4, 2*(wall_thickness/3) + joint_tollerance/4, size[2]])
						cube([ size[0] - (4*(wall_thickness/3)) - joint_tollerance/2
						     , size[1] - (4*(wall_thickness/3)) - joint_tollerance/2
						     , joint_size
						     ]);
					
					translate([wall_thickness, wall_thickness, size[2] - 1])
						cube([ size[0] - 2*wall_thickness
						     , size[1] - 2*wall_thickness
						     , joint_size + 2
						     ]);
					
				}
				
				// Outer Lip
				difference() {
					intersection() {
						translate([0,0,size[2]-radius])
							round_cube([size[0],size[1],joint_size+(radius*2)], [radius,radius,radius]);
						translate([0,0,size[2]])
							cube([size[0],size[1],joint_size]);
					}
					
					translate([wall_thickness/3 - joint_tollerance/4, wall_thickness/3 - joint_tollerance/4, size[2]-1])
						cube([ size[0] - (2*(wall_thickness/3))  + joint_tollerance/2
						     , size[1] - (2*(wall_thickness/3))  + joint_tollerance/2
						     , joint_size + 2
						     ]);
				}
			}
		}
	}
}

// translate([0,0,0])
// 	box_half(size = [30,30,10], wall_thickness = 5, joint_size = 4, joint_tollerance = 0.5, female = false, radius = 3);
// translate([40,0,0])
// 	box_half(size = [30,30,10], wall_thickness = 5, joint_size = 4, joint_tollerance = 0.5, female = true, radius = 3);


////////////////////////////////////////////////////////////////////////////////
// Clips and their cutout
////////////////////////////////////////////////////////////////////////////////

// width: The width of the clip
// thickness: The thickness of the shaft
// shaft_length: The length of the straight section of the clip
// clip_length: The length of the angled clip section (additional to the shaft_length)
// clip_protrusion: The distance the point of the clip sticks out from the shaft.
// clip_tollerance: The additional space added around a clip to account for manufacturing errors.
module clip(width, thickness, shaft_length, clip_length, clip_protrusion, clip_tollerance) {
	width = width + clip_tollerance;
	translate([-clip_tollerance/2, 0,0])
		union() {
			// Shaft
			cube([width, thickness + clip_tollerance, shaft_length - clip_tollerance]);
			
			// Clip
			translate([0,0,shaft_length - clip_tollerance]) {
				difference() {
					cube([width, thickness + clip_protrusion + clip_tollerance, clip_length + 2*clip_tollerance]);
				
					translate([-1,0,clip_length + clip_tollerance*2])
						rotate(a=[-atan((clip_length+2*clip_tollerance)/(thickness + clip_protrusion + clip_tollerance)),0,0])
							cube([width+2, sqrt(pow(thickness + clip_protrusion + clip_tollerance, 2) + pow(clip_length + 2*clip_tollerance,2)), clip_length]);
				}
			}
		}
}


////////////////////////////////////////////////////////////////////////////////
// Experimentation
////////////////////////////////////////////////////////////////////////////////

size = [30,30,10];
wall_thickness = 5;
joint_size = 4;
joint_tollerance = 0.5;
radius = 3;
clip_thickness = (wall_thickness/3) - (joint_tollerance/4);
shaft_length = 3.5;
clip_length = 5;
clip_protrusion = 1.5;
clip_width = 7;
pos_clip_tollerance = 0.0;
neg_clip_tollerance = 0.5;

//translate([0,0,0]) {
//	difference() {
//		box_half( size = size, wall_thickness = wall_thickness
//		        , joint_size = joint_size, joint_tollerance = joint_tollerance
//		        , female = false, radius = radius
//		        );
//		// Left clip
//		translate([(size[0]/2) - (clip_width/2),0, size[2]])
//			mirror([0,0,1])
//				clip( width = clip_width, thickness = clip_thickness
//				    , shaft_length = shaft_length, clip_length = clip_length
//				    , clip_protrusion = clip_protrusion, clip_tollerance = neg_clip_tollerance);
//		// Right clip
//		translate([(size[0]/2) - (clip_width/2), size[1], size[2]])
//			mirror([0,0,1])
//			mirror([0,1,0])
//				clip( width = clip_width, thickness = clip_thickness
//				    , shaft_length = shaft_length, clip_length = clip_length
//				    , clip_protrusion = clip_protrusion, clip_tollerance = neg_clip_tollerance);
//	}
//}

translate([0,0,0]) {
	union() {
		box_half( size = size, wall_thickness = wall_thickness
		        , joint_size = joint_size, joint_tollerance = joint_tollerance
		        , female = true, radius = radius
		        );
		// Left clip
		translate([(size[0]/2) - (clip_width/2),0, size[2] + joint_size])
			clip( width = clip_width, thickness = clip_thickness
			    , shaft_length = shaft_length, clip_length = clip_length
			    , clip_protrusion = clip_protrusion, clip_tollerance = pos_clip_tollerance);
		// Right clip
		translate([(size[0]/2) - (clip_width/2), size[1], size[2] + joint_size])
			mirror([0,1,0])
				clip( width = clip_width, thickness = clip_thickness
				    , shaft_length = shaft_length, clip_length = clip_length
				    , clip_protrusion = clip_protrusion, clip_tollerance = pos_clip_tollerance);
	}
}
