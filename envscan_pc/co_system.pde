class Co {
  PVector wind, position, co, w, w2, w3, w4, mult; 
     float wi, wi2, wi3, wi4;
  float noiseV;
  float noiz, noiz2, noiz3, noiz4, noiz2z, noiz3z, x;
  float sx, sy, sz;

  
  
  Co(float range, float theta, float phi) {
    //s
   
   position = new PVector(range, theta, phi);
  
  }
  

  
  void threed() {
    
    sx = position.x * sin(position.z) * cos(position.y);
    sy = position.x * sin(position.z) * sin(position.y);
    sz = position.x * cos(position.z);
    
    println("spherical  (" + position.x + "," + position.y + "," + position.z +")");
    println("cartestian  (" + sx + "," + sy + "," + sz +")");
    println(" ");
    
     pushMatrix();
     //fill(255);
    // translate(position.x, position.y, position.z);
     translate(sx, sy, sz);
     sphere(5);
     noStroke();
      //fill(255);
     popMatrix();
  }
  
  
   void nois() {
    //x += .0001;
    noiz = noise((position.y * .009));
    noiz2 = noise((position.x * .0005));
    noiz3 = noise(position.y * .005);
    noiz4 = noise(position.x * .005);
    
    position.sub(noiz, noiz2);
    position.add(noiz3, noiz4);
  }
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
    void update() {
    run();
    nois();
   
  }
  
  
  
  
  void lines() {
  // if (y > height - ad|| x > width - ad|| y < 0 + ad|| x < 0 + ad|| y > height - ad|| x > width - ad ||y < 0 + ad || x < 0 + ad) {
  // //if (y  >height || (x  >width) ) {
  //  stroke(0, 0);
  //} else {
  //  stroke(255);
  //}

 // shape(s);
  
  // line(x,y, z, x2, y2, z2);
  //  //line(x2,y2, z2, x, y, z);
  //// line(y,x, y, x);
   }  
  
  void run() {
  
    noStroke();
    //fill(255);
  circle(position.x, position.y, 2);
    
  }
  
 
      
  
  void wid() {
    wi = position.dist(w);
    wi2 = position.dist(w2);
    wi3 = position.dist(w3);
    wi3 = position.dist(w3);
    
    wi3/=250;
    wi4/=500;
    wi2/=250;
    wi/=500;
    position.sub(0, 0);
  }
  
 
  
  void edge() {
    
    if (position.y > height) {
      position.sub(0, height);
    } else if (position.x > width) {
       position.sub(width, 0);     
    } 
    
    
  }
  
  
  void leftright() {
    for (int i = 0; i< 1200; i++) {
      if (i< 600) {
        position.add(wi2, wi2);
      } else if (i> 600) {
        position.sub(wi2, wi2);
      }
    }
  }
  

    
}
