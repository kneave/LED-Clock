//  Comment out whichever bit you don't need
segment_base();
logo_backlight();
indicator_leds();
raised_rim();

module segment_base()
{
    //  Create the segment base
    difference()
    {    
        //  Create the base arc
        arc(0, 95, 4, 360);
        //  Cut out a chunk
        translate([0,0,2]) arc(30, 86, 5, 360);
    }
}

module logo_backlight()
{
    generate_led_holders(4, 25);
}

module indicator_leds()
{
    generate_led_holders(60, 90);
}

module raised_rim()
{
    //  The raised rim around the edge
    arc(94, 95, 12, 360);
}

module segment_connector()
{
    //  Create the connectors for the LED holding bit
    difference()
    {
        rotate([0,0,45]) 
            translate([0,0,2]) arc(50, 128, 5, 30);
        
        rotate([0,0,41]) 
            translate([0,0,1.9]) arc(60, 120, 6, 22);
    }   
}

module generate_led_holders(segments, distance)
{
    //  The indicator LED holders
    difference()
    {
        segment_rotation_const = 360 / segments;

        //  Draw the base cylinders
        for(a = [0:segments - 1])
        {
            //  Rotate half const to enable splitting into four pizza slices
            rotation_value = (a * segment_rotation_const) + 
                (segment_rotation_const / 2);
            
            rotate([0,0,rotation_value]) 
                translate([distance,0,2]) cylinder(h = 7, r = 3, $fn=15);
        }
        
        //  Remove the hold for the LEDs
        for(a = [0:segments - 1])
        {
            //  Rotate half const to enable splitting into four pizza slices
            rotation_value = (a * segment_rotation_const) + 
                (segment_rotation_const / 2);
            
            rotate([0,0,rotation_value]) 
                translate([distance,0,2]) cylinder(h = 8, r = 2.5, $fn=15);
        }    
    }
}

/* 
 * Excerpt from... 
 * 
 * Parametric Encoder Wheel 
 *
 * by Alex Franke (codecreations), March 2012
 * http://www.theFrankes.com
 * 
 * Licenced under Creative Commons Attribution - Non-Commercial - Share Alike 3.0 
*/
module arc(innerradius, radius, height, degrees ) 
{
    $fn=60;
    
    render() 
    {
            if( degrees > 180 )
            {
                difference()
                {
                  difference()
                    {
                        cylinder( r=radius, h=height );
                        cylinder( r=innerradius*1.0001, h=height );
                    }
                    rotate([0,0,-degrees]) arc( innerradius,radius*1.0001, height*1.0001,  360-degrees) ;                    
                }
            }
            else
            {        
                difference() 
                {    
                    // Outer ring
                    rotate_extrude()
                        translate([innerradius, 0, 0])
                            square([radius - innerradius,height]);
                
                    // Cut half off
                    translate([0,-(radius+1),-.5]) 
                        cube ([radius+1,(radius+1)*2,height+1]);
           
                    // Cover the other half as necessary
                    rotate([0,0,180-degrees])
                    translate([0,-(radius+1),-.5]) 
                        cube ([radius+1,(radius+1)*2,height+1]);
                }
            }
        
    }
}