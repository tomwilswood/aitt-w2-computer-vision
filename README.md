# Prototyping vision-based interaction in Processing with OpenCV

Open Computer Vision (more commonly known as OpenCV) is an industry standard library for implementing computer vision applications. There are implementations (or to be more precise [!‘wrapper libraries’](https://en.wikipedia.org/wiki/Wrapper_library) available that allow you to use OpenCV with nearly all major programming languages. I’ve found that the API is fairly similar (i.e. class names and methods are usually consistent) across languages. Therefore, once you’ve used OpenCV to program in one language, you can transfer your experience to others.

In this practical, we will learn how to get started with prototyping vision-based interfaces by using the Processing implementation of OpenCV. We will experiment with the library by exploring some basic computer vision techniques in the context of interaction, including: Cascade classifiers, regions of interest and optical flow.  
Getting the Library, Documentation and Template Project

OpenCV is included as one of Processing’s standard libraries. If you are using Processing 3 you
can import it into your project by searching for “OpenCV” in the Library Manager (Sketch > Import Library… > Add Library…). 

However, if you are using Processing 4 (i.e. the version in the lab you are working in for the practicals) you’ll have to use a newer beta version of the library. I’ve attached this newer version as a zip file (opencv_processing.zip) on this VLE item. You’ll need to download this, unzip it and copy the contents into the “libraries” folder within your Processing Sketchbook. You should find your sketchbook in the “Documents” folder in the lab computers. If you can’t see it, put your hand up and we’ll help you.

You can find the documentation for OpenCV for Processing and some examples showing how to use it at the following link:

•	https://github.com/atduskgreg/opencv-processing
•	http://atduskgreg.github.io/opencv-processing/reference/

To help you get started, I’ve put together a template Processing sketch that you can base your code on today. This sketch includes the code you need to grab video frames for use with OpenCV. This sketch can be found in a .zip file attached to this VLE item.
Task 1: Adding a Red Nose with a Cascade Classifier

Note: If you are completing this task in the lab under Covid restrictions, nose detection may not work – because you nose will be behind a mask! I would recommend that you address this issue by completing this task such that you detect your eyes instead of your nose.

In this task you will create a simple vision-based interface that overlays a face found in a video stream with an image showing a funny mask. Your implementation will be based on the following example Processing sketch that uses a face detector to track the position of a face in a still image. 

•	https://github.com/atduskgreg/opencv-processing/blob/master/examples/FaceDetection/FaceDetection.pde

The example uses a Cascade classifier to track the positions of faces in an image. It works by looking for specific features in an image that match features that have been found in images of other faces (see the OpenCV docs for more information).

In the example, you should see that a loadCascade method call initializes the face detector. The OpenCV.CASCADE_FRONTALFACE parameter currently specifies that the detector should look for faces. However, it can be configured to look for other facial features by changing this parameter (see the documentation for how). Add the code for initializing the tracker into the template sketch, and change the parameter so that it looks for noses rather than faces.

Once the detector has been initialized in the setup method, the detect method is used to detect the position of all faces (or noses) in the camera image. The example only calls the detect method once, because it’s working on a still image. Add the detect method to the draw loop of the template sketch, so that it runs for every video frame (note that the template already uses the loadImage to load the latest video frame into the OpenCV object).

The detect method returns an array of Rectangle objects that specify the position and size of all objects detected. These objects are then used to draw some green rectangles showing the position and size of these objects. Complete the task by adapting this code to draw a red “Comic Relief” nose on the detected nose positions instead.

Task 2: More Accurate Nose Tracking with a Region of Interest

Note: I have found that face detection seems to still work with a mask on, so you should still be able to complete this task as described.

You might have noticed that the nose tracker from the previous task isn’t very reliable, with lots of objects that look a bit like noses being detected in error. One way to make a nose tracker more reliable is to only look for noses within the bounds of a valid face (we can assume most noses are on a face!). Doing this would be an example of the common computer vision approach of defining a “Region of Interest”. A region of interest is a sub-region of an image where we would like to search for a particular visual cue (creating a region of interest is a bit like creating a mask in Photoshop).

In this task, you should extend your program so that it only looks for noses within the bounds of a valid face. To do this you should:

1.	Detect the position of all faces in each video frame using a Cascade classifier
2.	For each face found, detect the position of noses within its bounds, again using a Cascade classifier
3.	Draw a red nose over every detected nose within the face

You can use the setROI method (see documentation) to specify that an operation (i.e. searching for noses) should only be applied to a sub-region of an image (i.e. the position of a face). Use this method to specify that the nose detection should only be performed within the bounds of a detected face. You might also wish to explore making your nose detector more reliable and efficient by making the region of interest smaller than the whole face (most noses are somewhere in the middle!).

Task 3: A Simple Movement Game with Optical Flow

In this final task, we will explore another common computer vision technique called Optical Flow to create a movement game. Optical flow tracks the amount and direction of movement in the pixels of a series of video frame (see this article for more information). 

You are going to use this technique to create a simple movement game, which has the following mechanic:

1.	Show a text instruction to the user telling them to either move to the left or right
2.	Display the word “correct” if the user moves as instructed and “incorrect” if they don’t
3.	Repeat, incrementing a score counter every time the player moves correctly and decrementing it if they have moved incorrectly

Implementing the game mechanic described above using optical flow is reasonably simple. First, you should add the calculateOpticalFlow (see docs) method to the draw loop. This method call calculates the current optical flow in the video, with respect to subsequent frames. Second, you should call the getAverageFlow (see docs) method, which returns a PVector specifying the average direction of movement in the video. You can use this vector to determine whether the user has moved to the left or right, by looking at its direction and magnitude. 
 
Optional Extensions

If you complete all of the above tasks before the end of the practical, or would like to continue to develop your skills in your free study time, then you should consider experimenting with some of the other OpenCV for Processing examples to:

•	Use Optical Flow to create an automatic security camera that records still images when someone moves in a video stream (this could be limited to a rate of once every 10 seconds). 
•	Use Background Subtraction and a Region of Interest to implement the Coffee Alarm described in the lecture (i.e. by detecting a significant difference between a recorded image of an empty coffee pot and a video frame showing a pot that’s filling with coffee).
•	Use a combination of Hue Range Selection and Contour Detection to implement the Bubblegum Sequencer example from the lecture.

