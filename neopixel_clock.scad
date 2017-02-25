difference()
{
    //cylinder(h=5, r = 150, $fn=60);

    rotate([0,0,180]) arc(0, 150, 5, 90);
    
    segments = 15;
    segment_rotation_const = 360 / (segments * 4);
    
    for(a = [0:segments])
    {
        //  Rotate half const to enable splitting into four pizza slices
        rotation_value = (a * segment_rotation_const) + 
            (segment_rotation_const / 2);
        
        rotate([0,0,rotation_value]) 
            translate([140,0,0.5]) cylinder(h = 5, r = 5, $fn=15);
    }
      
        
        rotate([0,0,45]) 
            translate([40,0,0.5]) cylinder(h = 5, r = 5, $fn=15);
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