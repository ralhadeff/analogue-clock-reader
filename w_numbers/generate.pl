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
    # discrete hours and minutes in intervals of 5-minutes
    $t[0] = int(rand(12))+1;
    $t[1] = int(rand(12))+1;
    # length of hour hand (around 0.5 of radius)
    $l[0] = (rand()/5+0.4)*$r;
    # lengh of minutes hand, at least 10% larger than hour hand and up to the clock's radius
    $l[1] = rand()*($r-1.1*$l[0])+1.1*$l[0];
    # edge of hand
    $pi = 3.141592;
    # angle from 12 going clockwise
    $a[0] = $t[0]*((2*$pi)/12);
    $a[1] = $t[1]*((2*$pi)/12);
    # angle from 3 (x-axis) going counterclockwise
    $angle[0] = $pi/2 - $a[0];
    $angle[1] = $pi/2 - $a[1];
    # edges of hands
    $h[0] = $c[0] + $l[0] * cos(-$angle[0]);
    $h[1] = $c[1] + $l[0] * sin(-$angle[0]);
    $m[0] = $c[0] + $l[1] * cos(-$angle[1]);
    $m[1] = $c[1] + $l[1] * sin(-$angle[1]);
    
    # numbers around the clock
    $ps = int($r/6)+1;
    for ($ang=0; $ang<12; $ang++){
    	$n_x[$ang] = $c[0] + $r*0.85 * cos($ang*(2*$pi)/12-$pi/2) -$ps/2;
        $n_y[$ang] = $c[1] + $r*0.85 * sin($ang*(2*$pi)/12-$pi/2) +$ps/2;
    }
    # style
    $style = int(rand(3));
    if ($style==0){
        @annot = qw(12 1 2 3 4 5 6 7 8 9 10 11);
    } elsif ($style==1){
        @annot = qw(XII I II III IV V VI VII VIII IX X XI);
    } elsif ($style==2){
        @annot = qw(I / / - \\\ \\\ I / / - \\\ \\\ );
    }  

    # name
    $min = $t[1]*5;
    if ($min==60){
       $min = 0;
    }
    $name = "$t[0]_${min}_clock_${i}.png";
    
    # generate image
    $command = "convert -size ${size}x${size} xc:$bg ";
    $command.= "-stroke $st[0] -fill $fl -strokewidth 3 -draw $el ";
    $command.= "-stroke $st[1] -strokewidth 3 -draw 'line $c[0],$c[1] $h[0],$h[1]' ";
    $command.= "-stroke $st[1] -strokewidth 2 -draw 'line $c[0],$c[1] $m[0],$m[1]' ";
    $command.= "-pointsize $ps ";
    for ($ang=0; $ang<12; $ang++){
        $command.= "-annotate +$n_x[$ang]+$n_y[$ang] '$annot[$ang]' ";
    }
    $command.= "$name";
    system($command);
}
