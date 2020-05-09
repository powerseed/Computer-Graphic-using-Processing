float widthOfGrid = 0.2;
float radiusOfBox = 0.2;
float radiusOfSphere = widthOfGrid / 2;

float left = -4;
float right = 4;

float bottom = -1;
float top = 1;

float near = 1;
float far = 8;

float heightOfFloor = -1;

PImage textureForFloor;
PImage textureForEarth;
PImage textureForMars;
PImage textureForClock;


PImage textureForUp;
PImage textureForDown;
PImage textureForRotate;

PImage textureForGlass;
PImage textureForWalls;

float eyeX = 0.3, eyeY = -0.4, eyeZ = -2.3, centerX = 0.3, centerY = -0.4, centerZ= -1 * far, upX = 0, upY = -1, upZ = 0;

float originEyeZ = -100;
float originEyeX = -100;
float destinationEyeZ = -100;
float destinationEyeX = -100;
float tForMove = 0;


float changeForCenterX = 0;
float changeForCenterZ = 0;

float originForCenterX = -100;
float originForCenterZ = -100;
float destinationForCenterX = -100;
float destinationForCenterZ = -100;
float t = 0;

float rotationForAll = 0;

float XOffsetForSpheres = 1.5;
float XOffsetForBoxes = -1.5;

float ZOffsetForFirstLine = -2.9;
float ZOffsetForSecondLine = -5.9;

float distaceOfView = 0.7;
float distaceOfViewToWalls = 0.9;


ArrayList<PVector> downArrow = new ArrayList<PVector>();
ArrayList<PVector> upArrow = new ArrayList<PVector>();
ArrayList<PVector> rotateArrow = new ArrayList<PVector>();

float heightOfBallon = -1 * (1 - 0.5 * radiusOfBox ) + 2 * radiusOfBox;
float changeTheHeightForBallon = 0;

float rotateForBallon = 0;
float changeTherotateForBallon = 0;

boolean resetY = false;
float originForCenterY = -100;

void setup()
{
  size(800, 600, P3D);  
  float fov = PI / 3.0;
  perspective(fov, float(width)/float(height), near, far);
  resetMatrix();
  colorMode(RGB);
    
  textureForFloor = loadImage("assets/floor.jpg");
  textureForEarth = loadImage("assets/sphere.jpg");
  textureForMars = loadImage("assets/mars.jpg");
  textureForClock = loadImage("assets/clock.jpg");
  
  textureForUp = loadImage("assets/up.png");
  textureForDown = loadImage("assets/down.png");
  textureForRotate = loadImage("assets/rotate.jpg");

  textureForGlass = loadImage("assets/glass.jpg");
  textureForWalls = loadImage("assets/walls.jpg");
  textureMode(NORMAL);
  
  for(float row = heightOfFloor; row < heightOfFloor + radiusOfBox ; row += 0.01)
  {
    for(float col = XOffsetForBoxes - 0.5 * radiusOfBox; col < XOffsetForBoxes + 0.5 * radiusOfBox; col += 0.01)
    {
      downArrow.add(new PVector(col, row, ZOffsetForSecondLine + 0.5 * radiusOfBox ));
    }
  }
  
  for(float row = heightOfFloor + radiusOfBox; row < heightOfFloor + 2 * radiusOfBox ; row += 0.01)
  {
    for(float col = XOffsetForBoxes - 0.5 * radiusOfBox; col < XOffsetForBoxes + 0.5 * radiusOfBox; col += 0.01)
    {
      rotateArrow.add(new PVector(col, row, ZOffsetForSecondLine + 0.5 * radiusOfBox ));
    }
  }
  
  for(float row = heightOfFloor + 2 * radiusOfBox; row < heightOfFloor + 3 * radiusOfBox ; row += 0.01)
  {
    for(float col = XOffsetForBoxes - 0.5 * radiusOfBox; col < XOffsetForBoxes + 0.5 * radiusOfBox; col += 0.01)
    {
      upArrow.add(new PVector(col, row, ZOffsetForSecondLine + 0.5 * radiusOfBox ));
    }
  }
  

}

void draw()
{
  clear();
  
  directionalLight(255, 255, 255, 0, -1, 0);
  pointLight(240, 230, 140, 0, 1, -4);   
  spotLight(255, 255, 255, eyeX, eyeY, eyeZ, centerX - eyeX, centerY - eyeY, centerZ - eyeZ, 0.1, 800);
  
  if ( destinationEyeX != -100 || destinationEyeZ != -100 )
  {
    if( destinationEyeX != -100 )
    {
      eyeX = mylerp( tForMove, originEyeX, destinationEyeX );
    }
    
    if( destinationEyeZ != -100 )
    {
      eyeZ = mylerp( tForMove, originEyeZ, destinationEyeZ );
    }
    
    tForMove += 0.05;
    if( tForMove > 1 )
    {
      tForMove = 0;
      eyeX = destinationEyeX;
      eyeZ = destinationEyeZ;
      
      destinationEyeX = -100;
      destinationEyeZ = -100;
    }
  }
  
  if ( destinationForCenterX != -100 || destinationForCenterZ != -100 || resetY )
  {    
    if( destinationForCenterX != -100 )
    {
      centerX = mylerp( t, originForCenterX, destinationForCenterX);
    }  

    if( destinationForCenterZ != -100 )
    {
      centerZ = mylerp( t, originForCenterZ, destinationForCenterZ);
    } 
    
    if( resetY )
    {
      centerY = mylerp( t, originForCenterY, eyeY);
    }
    
    t += 0.01;
    if(t > 1)
    {
      t = 0;
      centerX = destinationForCenterX;
      centerZ = destinationForCenterZ;
      centerY = eyeY;
      
      destinationForCenterX = -100;
      destinationForCenterZ = -100;
      resetY = false;
    }
  }
  if ( changeTheHeightForBallon < 0 )
  {
    heightOfBallon -= 0.01;
    changeTheHeightForBallon += 0.01;
    if(changeTheHeightForBallon > 0)
    {
      changeTheHeightForBallon = 0;
    }
  }
  if ( changeTheHeightForBallon > 0 )
  {
    heightOfBallon += 0.01;
    changeTheHeightForBallon -= 0.01;
    if(changeTheHeightForBallon < 0)
    {
      changeTheHeightForBallon = 0;
    }
  }
  if (changeTherotateForBallon > 0)
  {
    rotateForBallon += radians(1);
    changeTherotateForBallon -= radians(1);
    
    if(changeTherotateForBallon < 0)
    {
      changeTheHeightForBallon = 0;
    }
  }
  
  camera(eyeX, eyeY, eyeZ, centerX, centerY, centerZ, upX, upY, upZ);

  drawGrid();
  drawWalls();

  pushMatrix();
    translate(XOffsetForSpheres, -1 * (1 - radiusOfSphere ), ZOffsetForFirstLine); 
    rotateY(rotationForAll);
    rotateX(PI);
    drawExhibitSphere(textureForEarth);
  popMatrix();

  pushMatrix();
    translate(XOffsetForSpheres, -1 * (1 - radiusOfSphere ), ZOffsetForSecondLine);
    rotateY(rotationForAll);
    drawExhibitSphere(textureForMars);
  popMatrix();

  pushMatrix();        // 3 boxes
    pushMatrix();
      translate(XOffsetForBoxes, -1 * (1 - 0.5 * radiusOfBox ), ZOffsetForSecondLine); 
      drawExhibitSpecialCube(textureForUp, textureForClock);
    popMatrix();
    
    pushMatrix();
      translate(XOffsetForBoxes, -1 * (1 - 0.5 * radiusOfBox ) + radiusOfBox, ZOffsetForSecondLine); 
      drawExhibitSpecialCube(textureForRotate, textureForClock);
    popMatrix();
    
    pushMatrix();
      translate(XOffsetForBoxes, -1 * (1 - 0.5 * radiusOfBox ) + 2 * radiusOfBox, ZOffsetForSecondLine); 
      drawExhibitSpecialCube(textureForDown, textureForClock);
    popMatrix();
  popMatrix();
  
  pushMatrix();  //ballon
    translate(XOffsetForBoxes - 0.2, heightOfBallon, ZOffsetForSecondLine);
    rotateY(rotateForBallon);
    scale(0.5, 0.5, 0.5);
    drawExhibitSphere(textureForEarth);
  popMatrix();

  pushMatrix();
    translate(XOffsetForBoxes, -1 * (1 - 0.5 * radiusOfBox ), ZOffsetForFirstLine); 
    rotateY(rotationForAll);
    drawExhibitCube(textureForGlass);
  popMatrix();
  
  rotationForAll += radians(1);
  rotationForAll = rotationForAll % (2 * PI);
}

void drawGrid()
{
  stroke(255, 255, 255);
  for (float x = left; x <= right; x += widthOfGrid)
  {
    for (float z = -1 * near; z >= -1 * far; z -= widthOfGrid)
    {
      emissive(163, 148, 128);
      ambient(41, 36, 33);
      specular(221, 160, 221);
      beginShape(QUADS);
        texture(textureForFloor);
        vertex(x, heightOfFloor, z, 0, 0);
        vertex(x + widthOfGrid, heightOfFloor, z, 0, 1);
        vertex(x + widthOfGrid, heightOfFloor, z - widthOfGrid, 1, 1);
        vertex(x, heightOfFloor, z - widthOfGrid, 1, 0);
      endShape();
    }
  }
}


void drawExhibitSphere(PImage texture)
{
  emissive(65, 105, 225);
  ambient(127, 255, 0);
  specular(255, 192, 203);
  
  noStroke();
  PShape globe = createShape(SPHERE, radiusOfSphere); 
  globe.setTexture(texture);
  shape(globe);
}

void drawExhibitCube(PImage texture)
{
  emissive(0, 199, 140);
  ambient(210, 180, 140);
  specular(112, 128, 105);
  
  noStroke();
  PShape cube = createShape(BOX, radiusOfBox); 
  cube.setTexture(texture);
  shape(cube);
}

void drawExhibitSpecialCube(PImage textureForArrow, PImage textureForOther)
{
  emissive(0, 199, 140);
  ambient(210, 180, 140);
  specular(112, 128, 105);
  
  beginShape(QUADS);
    // bottom
    texture(textureForOther);
    vertex( 0.5 * widthOfGrid, -0.5*widthOfGrid, 0.5*widthOfGrid, 0, 0 );
    vertex( -0.5 * widthOfGrid, -0.5*widthOfGrid, 0.5*widthOfGrid, 1, 0 );
    vertex( -0.5 * widthOfGrid, -0.5*widthOfGrid, -0.5*widthOfGrid, 1, 1 );
    vertex( 0.5 * widthOfGrid, -0.5*widthOfGrid, -0.5*widthOfGrid, 0, 1 );
  endShape();
  
  beginShape(QUADS);
    // top
    texture(textureForOther);
    vertex( 0.5 * widthOfGrid, 0.5*widthOfGrid, 0.5*widthOfGrid, 0, 0 );
    vertex( -0.5 * widthOfGrid, 0.5*widthOfGrid, 0.5*widthOfGrid, 1, 0 );
    vertex( -0.5 * widthOfGrid, 0.5*widthOfGrid, -0.5*widthOfGrid, 1, 1 );
    vertex( 0.5 * widthOfGrid, 0.5*widthOfGrid, -0.5*widthOfGrid, 0, 1 );
  endShape();
  
  beginShape(QUADS);
    // back
    texture(textureForOther);
    vertex( 0.5 * widthOfGrid, -0.5*widthOfGrid, -0.5*widthOfGrid, 0, 0 );
    vertex( -0.5 * widthOfGrid, -0.5*widthOfGrid, -0.5*widthOfGrid, 1, 0 );
    vertex( -0.5 * widthOfGrid, 0.5*widthOfGrid, -0.5*widthOfGrid, 1, 1 );
    vertex( 0.5 * widthOfGrid, 0.5*widthOfGrid, -0.5*widthOfGrid, 0, 1 );
  endShape();
  
  beginShape(QUADS);
    // front
    texture(textureForArrow);
    vertex( 0.5 * widthOfGrid, -0.5*widthOfGrid, 0.5*widthOfGrid, 0, 0 );
    vertex( -0.5 * widthOfGrid, -0.5*widthOfGrid, 0.5*widthOfGrid, 1, 0 );
    vertex( -0.5 * widthOfGrid, 0.5*widthOfGrid, 0.5*widthOfGrid, 1, 1 );
    vertex( 0.5 * widthOfGrid, 0.5*widthOfGrid, 0.5*widthOfGrid, 0, 1 );   
  endShape();
  
  beginShape(QUADS);
    // left
    texture(textureForOther);
    vertex( 0.5 * widthOfGrid, -0.5*widthOfGrid, 0.5*widthOfGrid, 0, 0 );
    vertex( 0.5 * widthOfGrid, -0.5*widthOfGrid, -0.5*widthOfGrid, 1, 0 );
    vertex( 0.5 * widthOfGrid, 0.5*widthOfGrid, -0.5*widthOfGrid, 1, 1 );
    vertex( 0.5 * widthOfGrid, 0.5*widthOfGrid, 0.5*widthOfGrid, 0, 1 );   
  endShape();
  
  beginShape(QUADS);
    // right
    texture(textureForOther);
    vertex( -0.5 * widthOfGrid, -0.5*widthOfGrid, 0.5*widthOfGrid, 0, 0 );
    vertex( -0.5 * widthOfGrid, -0.5*widthOfGrid, -0.5*widthOfGrid, 1, 0 );
    vertex( -0.5 * widthOfGrid, 0.5*widthOfGrid, -0.5*widthOfGrid, 1, 1 );
    vertex( -0.5 * widthOfGrid, 0.5*widthOfGrid, 0.5*widthOfGrid, 0, 1 );  
  endShape();
}

void keyPressed()
{ 
  if ( destinationEyeX == -100 && destinationEyeZ == -100 && destinationForCenterX == -100 && destinationForCenterZ == -100 )
  {           
    for(float row = heightOfFloor; row < heightOfFloor + radiusOfBox ; row += 0.01)
    {
      for(float col = XOffsetForBoxes - 0.5 * radiusOfBox; col < XOffsetForBoxes + 0.5 * radiusOfBox; col += 0.01)
      {
        downArrow.add(new PVector(col, row, ZOffsetForSecondLine + 0.5 * radiusOfBox ));
      }
    }
    
    for(float row = heightOfFloor + radiusOfBox; row < heightOfFloor + 2 * radiusOfBox ; row += 0.01)
    {
      for(float col = XOffsetForBoxes - 0.5 * radiusOfBox; col < XOffsetForBoxes + 0.5 * radiusOfBox; col += 0.01)
      {
        rotateArrow.add(new PVector(col, row, ZOffsetForSecondLine + 0.5 * radiusOfBox ));
      }
    }
    
    for(float row = heightOfFloor + 2 * radiusOfBox; row < heightOfFloor + 3 * radiusOfBox ; row += 0.01)
    {
      for(float col = XOffsetForBoxes - 0.5 * radiusOfBox; col < XOffsetForBoxes + 0.5 * radiusOfBox; col += 0.01)
      {
        upArrow.add(new PVector(col, row, ZOffsetForSecondLine + 0.5 * radiusOfBox ));
      }
    }
    
    if (key == 'w')
    {
      float centerXMinusEyeX = centerX - eyeX;
      float centerZMinusEyeZ = centerZ - eyeZ;
      float angle = centerZMinusEyeZ / centerXMinusEyeX;
      
      originEyeX = eyeX;
      originEyeZ = eyeZ;
            
      float temporaryX = 0;
      float temporaryZ = 0;

      if( centerXMinusEyeX > 0 ) // increment X
      {
        temporaryX = eyeX + widthOfGrid;        
        
        float changeForZ = angle * widthOfGrid;
                       
        temporaryZ = eyeZ + changeForZ;
      }
      else if (centerXMinusEyeX < 0 ) // decrement X 
      {
        temporaryX = eyeX + ( -1 * widthOfGrid );     
        
        float changeForZ = angle * ( -1 * widthOfGrid );
        
        temporaryZ = eyeZ + changeForZ;
      }
      else
      {
        if( centerZ > eyeZ )
        {
          temporaryX = eyeX;
          temporaryZ = eyeZ + widthOfGrid;
        }
        else
        {
          temporaryX = eyeX;
          temporaryZ = eyeZ - widthOfGrid;
        }
      }      
      if( (!stepInObject (temporaryX, temporaryZ)) && (!stepOutbound(temporaryX, temporaryZ)) )
      {
         destinationEyeX = temporaryX;
         destinationEyeZ = temporaryZ;
      }
    } 
    
    else if (key == 'd')
    {      
      if ( centerX > eyeX && centerZ <= eyeZ )   // north
      {
        originForCenterX = centerX;     
        originForCenterZ = centerZ;

        destinationForCenterX = eyeX;
        destinationForCenterZ = -1 * far;
      } 
      else if ( centerX == eyeX && centerZ <= eyeZ )
      {
        originForCenterX = centerX;     
        originForCenterZ = centerZ;
      
        destinationForCenterX = left;
        destinationForCenterZ = eyeZ;
      }
      
      else if ( centerX <= eyeX && centerZ < eyeZ )   // west
      {      
        originForCenterX = centerX;     
        originForCenterZ = centerZ;
        
        destinationForCenterX = left;
        destinationForCenterZ = eyeZ;
      } 
      else if ( centerX <= eyeX && centerZ == eyeZ ) 
      {
        originForCenterX = centerX;     
        originForCenterZ = centerZ;
        
        destinationForCenterX = eyeX;
        destinationForCenterZ = -1 * near;
      }
      
      else if ( centerX >= eyeX && centerZ > eyeZ )  // east
      {
        originForCenterX = centerX;     
        originForCenterZ = centerZ;
        
        destinationForCenterX = right;
        destinationForCenterZ = eyeZ;
      } 
      else if ( centerX >= eyeX && centerZ == eyeZ )
      {
        originForCenterX = centerX;     
        originForCenterZ = centerZ;
         
        destinationForCenterX = eyeX;
        destinationForCenterZ = -1 * far;
      }
      
      else if ( centerX < eyeX && centerZ >= eyeZ )                     // south
      {
        originForCenterX = centerX;     
        originForCenterZ = centerZ;

        destinationForCenterX = eyeX;
        destinationForCenterZ = -1 * near;
      }
      else if ( centerX == eyeX && centerZ >= eyeZ )                      
      {
        originForCenterX = centerX;     
        originForCenterZ = centerZ;
        
        destinationForCenterX = right;
        destinationForCenterZ = eyeZ;
      }
      
      originForCenterY = centerY;
      resetY = true;
    } 
    else if (key == 's')
    {
      float centerXMinusEyeX = centerX - eyeX;
      float centerZMinusEyeZ = centerZ - eyeZ;
      float angle = centerZMinusEyeZ / centerXMinusEyeX;
      
      originEyeX = eyeX;
      originEyeZ = eyeZ;
            
      float temporaryX = 0;
      float temporaryZ = 0;

      if( centerXMinusEyeX > 0 ) // increment X
      {
        temporaryX = eyeX - widthOfGrid;        
        temporaryZ = eyeZ - angle * widthOfGrid;
      }
      else if (centerXMinusEyeX < 0 ) // decrement X 
      {
        temporaryX = eyeX - ( -1 * widthOfGrid );        
        temporaryZ = eyeZ - angle * ( -1 * widthOfGrid );
      }
      else
      {
        if( centerZ > eyeZ )
        {
          temporaryX = eyeX;
          temporaryZ = eyeZ - widthOfGrid;
        }
        else
        {
          temporaryX = eyeX;
          temporaryZ = eyeZ + widthOfGrid;
        }
      }      
      if( (!stepInObject (temporaryX, temporaryZ)) && (!stepOutbound(temporaryX, temporaryZ)) )
      {
         destinationEyeX = temporaryX;
         destinationEyeZ = temporaryZ;
      }
    } 
    
    else if (key == 'a')
    {      
      //centerZ == -1 * far
      if ( centerX >= eyeX && centerZ < eyeZ )   // north
      {        
        originForCenterX = centerX;     
        originForCenterZ = centerZ;
      
        destinationForCenterX = right;
        destinationForCenterZ = eyeZ;
      } 
      else if ( centerX >= eyeX && centerZ == eyeZ )
      {
        originForCenterX = centerX;     
        originForCenterZ = centerZ;
      
        destinationForCenterX = eyeX;
        destinationForCenterZ = -1 * near;
      }
      
      // centerX == left
      else if ( centerX < eyeX && centerZ <= eyeZ )  // west
      {
        originForCenterX = centerX;     
        originForCenterZ = centerZ;
        destinationForCenterX = eyeX;
        destinationForCenterZ = -1 * far;
      } 
      else if ( centerX == eyeX && centerZ <= eyeZ ) 
      {
        originForCenterX = centerX;     
        originForCenterZ = centerZ;
        destinationForCenterX = right;
        destinationForCenterZ = eyeZ;
      } 
      
      //centerX == right
      else if ( centerX > eyeX && centerZ >= eyeZ )   // east
      {
        originForCenterX = centerX;     
        originForCenterZ = centerZ;
        destinationForCenterX = eyeX;
        destinationForCenterZ = -1 * near;
      }       
      else if ( centerX == eyeX && centerZ >= eyeZ )
      {
        originForCenterX = centerX;     
        originForCenterZ = centerZ;
        destinationForCenterX = left;
        destinationForCenterZ = eyeZ;
      }
            
      //centerZ == -1 * near
      else if ( centerX <= eyeX && centerZ >= eyeZ )                      // south
      {
        originForCenterX = centerX;     
        originForCenterZ = centerZ;
        destinationForCenterX = left;
        destinationForCenterZ = eyeZ;
      }
      else if ( centerX < eyeX && centerZ == eyeZ )                      
      {
        originForCenterX = centerX;     
        originForCenterZ = centerZ;
        destinationForCenterX = eyeX;
        destinationForCenterZ = -1 * far;
      }
      originForCenterY = centerY;    
      resetY = true;
    }
  }//if
}

void drawWalls()
{
  beginShape(QUADS);
    texture(textureForWalls);
    vertex(left, -1, -1 * near, 1, 0 );
    vertex(left, -1, -1 * far, 1, 1);
    vertex(left, 1, -1 * far, 0, 1);
    vertex(left, 1, -1 * near, 0, 0);
    
    vertex(right, -1, -1 * near, 1, 0 );
    vertex(right, -1, -1 * far, 1, 1);
    vertex(right, 1, -1 * far, 0, 1);
    vertex(right, 1, -1 * near, 0, 0);
    
    vertex(left, -1, -1 * far, 1, 0 );
    vertex(right, -1, -1 * far, 1, 1);
    vertex(right, 1, -1 * far, 0, 1);
    vertex(left, 1, -1 * far, 0, 0);
    
    vertex(left, -1, -1 * near, 1, 0 );
    vertex(right, -1, -1 * near, 1, 1 );
    vertex(right, 1, -1 * near, 0, 1);
    vertex(left, 1, -1 * near, 0, 0);
  endShape();
}


float mylerp (float t, float start, float end)
{
  return ( 1 - t ) * start + t * end;
}

void mouseClicked()
{  
  boolean down = false;
  boolean rotate = false;
  boolean up = false;
    
  for( int i = 0; i < downArrow.size(); i++ )
  {
    if( (int)screenX(downArrow.get(i).x, downArrow.get(i).y, downArrow.get(i).z) -5 <= mouseX && mouseX <= (int)screenX(downArrow.get(i).x, downArrow.get(i).y, downArrow.get(i).z) + 5
        && (int)screenY(downArrow.get(i).x, downArrow.get(i).y, downArrow.get(i).z) - 5 <= mouseY && mouseY <= (int)screenY(downArrow.get(i).x, downArrow.get(i).y, downArrow.get(i).z) + 5 
      )
    {
      down = true;
    }
  }
  
  for( int i = 0; i < rotateArrow.size(); i++ )
  {
    if( (int)screenX(rotateArrow.get(i).x, rotateArrow.get(i).y, rotateArrow.get(i).z) -5 <= mouseX && mouseX <= (int)screenX(rotateArrow.get(i).x, rotateArrow.get(i).y, rotateArrow.get(i).z) + 5
        && (int)screenY(rotateArrow.get(i).x, rotateArrow.get(i).y, rotateArrow.get(i).z) - 5 <= mouseY && mouseY <= (int)screenY(rotateArrow.get(i).x, rotateArrow.get(i).y, rotateArrow.get(i).z) + 5 
      )
    {
      rotate = true;
    }
  }
  
  for( int i = 0; i < upArrow.size(); i++ )
  {
    if( (int)screenX(upArrow.get(i).x, upArrow.get(i).y, upArrow.get(i).z) -5 <= mouseX && mouseX <= (int)screenX(upArrow.get(i).x, upArrow.get(i).y, upArrow.get(i).z) + 5
        && (int)screenY(upArrow.get(i).x, upArrow.get(i).y, upArrow.get(i).z) - 5 <= mouseY && mouseY <= (int)screenY(upArrow.get(i).x, upArrow.get(i).y, upArrow.get(i).z) + 5 
      )
    {
      up = true;
    }
  }
  
  if(down)
  {
    println("down");
    if(heightOfBallon > -0.6)
    {
      changeTheHeightForBallon = -0.1;
    }
  }  
  else if (rotate)
  {
    println("rotate");
    changeTherotateForBallon += radians(30);
  }
  else if(up)
  {
    println("up");
    if(heightOfBallon < -0.4)
    {
      changeTheHeightForBallon = 0.1;
    }
  }
}

void mouseDragged()
{
  if ( centerZ == -1 * far ) // north
  {
    centerX -= (mouseX - pmouseX) / 30.0;
    centerY -= (mouseY - pmouseY) / 30.0;
  }
  else if ( centerX == left )  // 
  {
    centerZ += (mouseX - pmouseX) / 30.0;
    centerY -= (mouseY - pmouseY) / 30.0;
  }
  else if ( centerX == right )
  {
    centerZ -= (mouseX - pmouseX) / 30.0;
    centerY -= (mouseY - pmouseY) / 30.0;
  }
  else
  {
    centerX += (mouseX - pmouseX) / 30.0;
    centerY -= (mouseY - pmouseY) / 30.0;
  }
}

boolean stepInObject(float x, float z)
{
  boolean isIn = false;
  
  if( (XOffsetForSpheres - (radiusOfSphere + distaceOfView ) <= x) && (x <= XOffsetForSpheres + (radiusOfSphere + distaceOfView )) && (ZOffsetForFirstLine - (radiusOfSphere + distaceOfView ) <= z) && (z <= ZOffsetForFirstLine + ( radiusOfSphere + distaceOfView ))
  )          
  {
    // earth
    isIn = true;
  }
  else if ( (XOffsetForSpheres - (radiusOfSphere + distaceOfView ) <= x) && (x <= XOffsetForSpheres + (radiusOfSphere + distaceOfView )) && (ZOffsetForSecondLine - (radiusOfSphere + distaceOfView ) <= z) && (z <= ZOffsetForSecondLine + ( radiusOfSphere + distaceOfView ))
          )
  {
    // mars
    isIn = true;
  }
  else if ( (XOffsetForBoxes - ( 0.5 * radiusOfBox + distaceOfView ) <= x) && ( x <= XOffsetForBoxes + ( 0.5 * radiusOfBox + distaceOfView ) ) && (ZOffsetForFirstLine - ( 0.5 * radiusOfBox + distaceOfView ) <= z) && (z <= ZOffsetForFirstLine + ( 0.5 * radiusOfBox + distaceOfView  ))
          )
  {
    // glass
    isIn = true;
  }
  else if ( (XOffsetForBoxes - ( 0.5 * radiusOfBox + distaceOfView )<= x) && ( x <= XOffsetForBoxes + ( 0.5 * radiusOfBox + distaceOfView ) ) && (ZOffsetForSecondLine - (  0.5 * radiusOfBox + distaceOfView ) <= z) && (z <= ZOffsetForSecondLine + ( 0.5 * radiusOfBox + distaceOfView  ))
          )
  {
    // clock
    isIn = true;
  }    
  return isIn;
}

boolean stepOutbound(float x, float z)
{
  boolean isOut = false;
  
  if( x <= left + distaceOfViewToWalls || x >= right - distaceOfViewToWalls || z >= -1 * near - distaceOfViewToWalls || z <= -1 * far + distaceOfViewToWalls)
  {
    isOut = true;
  }  
  
  return isOut;
}
