# analogue-clock-reader

Project to generate a convolutional neuron network that can read an analogue clock (work in progress).  


Training is performed on randomly generated images (initially 64x64, in RGB).  

`1-hand` - Only the hour's hand has been implemented. One example image has been uploaded in the folder.  

`2-hands` - Hours and minutes hands implemented (at 5 minutes intervals).  

After achieving good results with 2-hands, I tested the model on real clock images and performance was poor. I decided that the lack of digits at the clock edges is probably an issue.  
Thus, the next model was trained on randomly generated images with digits (arabic, roman or simple lines). This set was increased to 96x96 so that the numbers are somewhat readable.

`w_numbers` - Hours and minutes hands and digits printed at the edges.

Finally, I tested the version with digits on real images (chosen arbitrarily from google images), with mixed success. I think that I will have to add to the hands small protrusions on the opposite end, and probably also a thin seconds hand to ensure the networks learns to ignore it.

`w_seconds` - Seconds hand and protrusions added (that should be ignored by network), appear optionally in the images. Image quality increase to 128x128 to better distinguish between thickness of hands.
