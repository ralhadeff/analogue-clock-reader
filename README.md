# analogue-clock-reader

A project to generate a convolutional neuron network that can read an analogue clock (work still in progress).  


Training is performed on randomly generated images (initially 64x64, in RGB). Example images are available in all sub-folders. 

* `1-hand` - Only the hour's hand has been implemented.  

* `2-hands` - Hours and minutes hands implemented (at 5 minutes intervals).  

After achieving good results with 2-hands, I tested the model on real clock images (taken from Google images) and performance was poor. I figured that the lack of digits at the clock edges might be an issue.  
Thus, the next model was trained on randomly generated images with digits (Arabic, Roman or simple lines). This set was increased to 96x96 so that the numbers are more distinguishable.

* `w_numbers` - Hours and minutes hands with digits printed at the edges of the clock.

Finally, I tested the version with digits on real images (chosen arbitrarily from google images), with mixed success. I hypothesized that adding small protrusions at the opposite ends of the hands will help, and perhaps also a thin seconds hand to ensure the networks learns to ignore it from real images later.

* `w_seconds` - Seconds hand and protrusions added (to be ignored by the network), appear stochastically in the training images. Image quality was increased to 128x128 to better distinguish the thickness of the hands. Mixed success.
