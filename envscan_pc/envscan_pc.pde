import processing.serial.*;

ArrayList<Co> cos = new ArrayList<Co>();

Serial myPort;  // Create object from Serial class ss
PGraphics pg;

String val;
float va;
Float vat = 0.0;
Float vas = 0.0;

float xp, yp, zp;
float xx, yy, zz;

float sx, sy, sz;

int test;

FloatList coList;
FloatList colorList;
Float last = 0.0; 
Float first;
int newLine = 0;
int index = 0;
int index2 = 0;

int rotation = 45;
int he = 30;
int rY = 135;

Float z = 0.0;

float xcor;
float xcor2;
int x2;
int y;
Float count = .0;
float count2;

int h = height/45;
int w = width/45;
String portName;

int mX = 0;
int mY = 0;

void setup()
{
  size(1080, 1080, P3D);
  background(0);
  printArray(Serial.list());

  portName = Serial.list()[1]; 
  myPort = new Serial(this, portName, 9600);
  coList = new FloatList();
  colorList = new FloatList();
}


void draw() {
  background(155,0,0);
   mX +=1;
   mY  +=1;
  camera(mouseX,mouseY, (height/2) / tan(PI/6), width/2, height/2, 0, 0, 1, 0);

  //directionalLight(vas, vas, vas, 0, -10, 0);
  lights();
   // spotLight(0, 255, 255, width/2, height/2, 700, 0, 0, 0, PI, .7);

  
  //reads the data from arduino, stores as a string to 'val'
  val = myPort.readStringUntil('\n');
  if ( val == null ||  val.isEmpty() || val.length() == 0) 
  { 
    println("nul");
  } else if (val != null &&  !val.isEmpty() && val.length() > 0) {
    //converts string of arduino data to a float
    Float va = Float.valueOf(val).floatValue();
    // printArray(va);
    //maps distance coordiantes to rgb values
    vas = map(va, 0, 300, 255, 0);

    //makes shape is more pronounced.
    vat = va; //map(va, 25, 44, va, va*3);
    // coList is created to store the second plot point for the graph line to be drawn to. 
    
   

    // by assigning the second to last coordinates to the new variable, this can be given as a plot point

    // in arduino, when each rotation is complete '1000.9' is serial printed, and so if processing receives
    // that number, it clears the data from coList, which is the list that the second coordinates are stored 
    ////in so as to cnnect the graph. 
    //resets the x coordinate to 0 every time the servo finishes a loop. 
    // x is removed from the y coordinate with every loop, so each new line is plotted on a new level. 
    //println(coList.size());
    if (va == 1000.9 || coList.size() > rotation ) { //|| coList.size() > rotation
      //println(coList.size());
      //|| coList.size() > 90
      coList.clear();
      //colorList.clear();
      //newLine +=1;
      count = 0.0;
      y += 1;
      test +=1;
      //x += va;
    }
   

    // count is assigned to the x coordinate so with each new plot points, the coordinate moves across
    // the screen. 

    wave();
    //spheres();

    saveFrame("3d_######.jpg");
  }
}






void wave() {
 
  cos.add(new Co(vat, count, y));
   
      
    if (va != 1000.9) {
      count += 1;
      colorList.append(vas);
    }
      
      for (int i = cos.size()-1; i>0; i--) {
      //Co n = cos.get(i);
           
      Co m = cos.get(i-1);
      Co n = cos.get(i);
      //if (colorList.size() > 0) {
        float col = colorList.get(i-1);
        fill(col);
       // stroke(col);
      
      //n.threed();
      m.threed();
      
      //xp = m.position.x;
      //yp = m.position.y;
      //zp = m.position.z;
      
      //xx = n.position.x;
      //yy = n.position.y;
      //zz = n.position.z;
      
  
     //spheres3d();
     //lines3d();
   
      if (test >= rotation) {
        m.nois();
        n.nois();
      }
     
    }
}







void spheres3d() {
  
  
  sx = -vat*sin(count)*cos(y);
  sy = -vat*sin(count)*sin(y);
  sz = -vat*cos(count);
  //pushMatrix();
  //translate(width/2, height/2);
  
  //  sphere(200);
    
    //popMatrix();
  pushMatrix();
 
     translate(xp,yp,zp);
     //translate(sx, sy, sz);
     
     
     sphere(10);
     noStroke();
     
     popMatrix();
     
     // pushMatrix();
     //translate((xp+xx)/2,(yp + yy)/2, (zp+zz)/2);
     //sphere(10);
     //noStroke();
   
     //println(zp);
  
     //popMatrix();
     
}



















void spheres() {

  pushMatrix();
  // camera(5, 500, (height/2) / tan(PI/6), width/2, height/2, 0, 0, 1, 0);

  noStroke();
  if (va != 1000.9) {
    translate(count, y, -(vat));
    sphere(5);
    popMatrix();
  }
}




void lines3d() {
  if (xx  == 1000.9 || xp == 1000.9) {//> 600 || xp > 600 || xx < 10 || xp < 10) {
    stroke(0, 0);
  } else {
//  stroke(255);    
  line(xp, yp, zp, xx, yy, zz);
  }
  
    
  
}




















void lines() {
  scale(1.5, 1);
  //camera(5, 500, (height/2) / tan(PI/6), width/2, height/2, 0, 0, 1, 0);
  if (coList.size() < 4 ) {

    stroke(0);
    xcor = -(vat);
    xcor2 = -(vat);
  } else if (coList.size() > 3 ) {
    index = coList.size();

    //stroke(vas);
    strokeWeight(2);
    last = coList.get((index - 2)); 
    first = coList.get((index-1));

    xcor = -(first);
    xcor2 = -(last);
  } 
  //translate(count-100, x, xcor);
  line(count,y, xcor, count2, y, xcor2);
}












































void spheresList() {
  camera(5, 500, (height/2) / tan(PI/6), width/2, height/2, 0, 0, 1, 0);

  if (va != 0) {
    //maps distance coordiantes to rgb values
    // vas = map(va, 2, 50, 255, 50);

    // count is assigned to the x coordinate so with each new plot points, the coordinate moves across
    // the screen. 

    vat = va;
    // print(vat + "b    ");
    colorList.append(vat);
    if (colorList.size() > 1) {
      index2 = colorList.size();
      if (z == 1000.9) {
        newLine +=1;
        count = 0.0;
        y += height/90;
      }

      if (newLine == 1) {
        int i = 1;
        while (i < colorList.size()) {
          i = i+1;
          z = colorList.get(i-1);
          // print(z + "z    ");
          // print(i + "b      ");
          count += width/90;
          fill(vas);
          noStroke();
          translate(count, y, -z);
          sphere(2);
        }
      }
    }
  }
}
