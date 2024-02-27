import gab.opencv.*;
import processing.video.*;
import java.awt.Rectangle;

OpenCV opencv;
OpenCV facecv;
OpenCV flowcv;
Capture cam;
Rectangle[] faces;
Rectangle[] faces2;

Boolean playerRight;

void setup() 
{
  size(10, 10);
  
  initCamera();
  opencv = new OpenCV(this, cam.width, cam.height);
  facecv = new OpenCV(this, cam.width, cam.height);
  flowcv = new OpenCV(this, cam.width, cam.height);
  
  surface.setResizable(true);
  surface.setSize(opencv.width, opencv.height);
  
  opencv.loadCascade(OpenCV.CASCADE_NOSE);
  facecv.loadCascade(OpenCV.CASCADE_FRONTALFACE);
  playerRight = false;
}

void draw() 
{
  if(cam.available())
  {    
    cam.read();
    cam.loadPixels();
    opencv.loadImage((PImage)cam);
    facecv.loadImage((PImage)cam);
    flowcv.loadImage((PImage)cam);
    //image(opencv.getInput(), 0, 0);

    // you should write most of your computer vision code here 
    
      
    
    
  
  
  
  
    faces2 = facecv.detect();
  
  image(facecv.getInput(), 0, 0);
  //noFill();
  //stroke(0, 255, 0);
  //for (int i = 0; i < faces2.length; i++) {
  //  ellipse(faces2[i].x + (faces2[i].width/2), faces2[i].y + (faces2[i].height/2), faces2[i].width, faces2[i].height);
  //}
    //image(opencv.getInput(), 0, 0);
    
    for (int i = 0; i < faces2.length; i++) {
    opencv.setROI(faces2[i].x, faces2[i].y, faces2[i].width, faces2[i].height);
    faces = opencv.detect();
  }
  
   
  
  //noFill();
  fill(255,0,0);
  stroke(255, 0, 0);
  strokeWeight(3);
  ellipseMode(CENTER);
  for (int i = 0; i < faces.length; i++) {
    for (int j = 0; j < faces2.length; j++) {
    ellipse(faces[i].x + (faces[i].width/2) +faces2[j].x, faces[i].y + (faces[i].height/2) +faces2[j].y, faces[i].width, faces[i].height);
    }
  }
  
  //image(flowcv.getInput(), 0, 0);
  
  fill (255);
  stroke(255);
  rect(0, 0, cam.width, 30);
  fill(0);
  textSize(20);
  text("move to the left", 10, 20);
  flowcv.calculateOpticalFlow();
  flowcv.getAverageFlow();
  if (flowcv.getAverageFlow().x >0){
    playerRight = true;
  } else{
    playerRight = false;
  }
  println(playerRight);
  
  if (playerRight == true){
    fill (255);
  stroke(255);
  rect(0, 50, cam.width, 30);
  fill(0);
  textSize(20);
  text("your ight", 10, 70);
  } else{
    fill (255);
  stroke(255);
  rect(0, 50, cam.width, 30);
  fill(0);
  textSize(20);
  text("eat shit", 10, 70);
  }
  
  //println(flowcv.getAverageFlow().mag());
    
    // end code
    
    
  }
}

void initCamera()
{
  String[] cameras = Capture.list();
  if (cameras.length != 0) 
  {
    println("Using camera: " + cameras[0]); 
    cam = new Capture(this, cameras[0]);
    cam.start();    
    
    while(!cam.available()) print();
    
    cam.read();
    cam.loadPixels();
  }
  else
  {
    println("There are no cameras available for capture.");
    exit();
  }
}
