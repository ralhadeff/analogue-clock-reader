# generate images of 1 hand clocks randomly

# image size (square)
$size = $ARGV[0];
$s = int($size/2);

for ($i=0;$i<$ARGV[1];$i++){
    # background color (no darker than 128,128,128)
    $b[0] = int(rand(128))+128;
    $b[1] = int(rand(128))+128;
    $b[2] = int(rand(128))+128;
    $bg = "'rgb($b[0],$b[1],$b[2])'";
    
    # strokes - no brighter than 128,128,128
    $s[0] = int(rand(128));
    $s[1] = int(rand(128));
    $s[2] = int(rand(128));
    $st[0] = "'rgb($s[0],$s[1],$s[2])'";
    $s[0] = int(rand(128));
    $s[1] = int(rand(128));
    $s[2] = int(rand(128));
    $st[1] = "'rgb($s[0],$s[1],$s[2])'";
    
    # fill - no darker than 128,128,128
    $f[0] = int(rand(128))+128;
    $f[1] = int(rand(128))+128;
    $f[2] = int(rand(128))+128;
    $fl = "'rgb($f[0],$f[1],$f[2])'";
    
    # radius of clock (around 100) - scaled with respect to 256
    $r = int( (rand(41)+80)*($size/256) );
    # center of clock (around 128,128 without truncating edges) - scaled with respect to 256
    $c[0] = $s+int(rand(2*($s-$r)))-($s-$r);
    $c[1] = $s+int(rand(2*($s-$r)))-($s-$r);
    $el = "'ellipse $c[0],$c[1] $r,$r 0,360'";
    
    # determine the time
    # discrete hours
    $t = int(rand(12))+1;
    # length of hand (around 0.5 or radius)
    $l = int( (rand()/5+0.4)*$r );
    # edge of hand
    $pi = 3.141592;
    # angle from 12 going clockwise
    $a = $t*((2*$pi)/12);
    # angle from 3 (x-axis) going counterclockwise
    $angle = $pi/2 - $a;
    # edges of hand
    $e[0] = $c[0] + $l * cos(-$angle);
    $e[1] = $c[1] + $l * sin(-$angle);
    
    # name
    $name = "${t}_clock_${i}.png";
    
    # generate image
    $command = "convert -size ${size}x${size} xc:$bg ";
    $command.= "-stroke $st[0] -fill $fl -strokewidth 3 -draw $el ";
    $command.= "-stroke $st[1] -strokewidth 4 -draw 'line $c[0],$c[1] $e[0],$e[1]' ";
    $command.= "$name";
    system($command);
}
