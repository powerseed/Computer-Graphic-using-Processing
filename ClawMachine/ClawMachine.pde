boolean perspective = false;

float eyeX = 0, eyeY = 0, eyeZ = 0, centerX = 0, centerY = 0, centerZ = -1, upX = 0, upY = 1, upZ = 0;

float rotateYForBar = 0;
float translateXForfloatingBlock = -0.75;
float scaleXForCable = 0.05;
float rotateForUnderBlock = 0;
float rotateForUpClaw = -25;

boolean isBarRotatingQ = false;
boolean isBarRotatingW = false;

boolean isFloatingBlockMovingE = false;
boolean isFloatingBlockMovingR = false;

boolean isCableExtendingA = false;
boolean isCableExtendingZ = false;

boolean isUnderBlockRotatingS = false;
boolean isUnderBlockRotatingD = false;

boolean isUpClawRotatingX = false;
boolean isUpClawRotatingC = false;

boolean isSequenceOpen = false;
boolean downward = true;

void setup()
{
  size(640,640,P3D);
  hint(DISABLE_OPTIMIZED_STROKE);
}

void draw()
{
  if ( perspective )
  {
    frustum(-1, 1, 1, -1, 1, 8);
  }
  else
  {
    ortho(-1, 1, 1, -1, 1, 8);
  }
  
  clear();
  resetMatrix();
  camera(eyeX, eyeY, eyeZ, centerX, centerY, centerZ, upX, upY, upZ);
  
  if(isSequenceOpen)
  {
     isBarRotatingQ = false;
     isBarRotatingW = false;
    
     isFloatingBlockMovingE = false;
     isFloatingBlockMovingR = false;
    
     isCableExtendingA = false;
     isCableExtendingZ = false;
    
     isUnderBlockRotatingS = false;
     isUnderBlockRotatingD = false;
    
     isUpClawRotatingX = false;
     isUpClawRotatingC = false;
     
    if(downward && rotateForUpClaw > -40)
    {
      rotateForUpClaw -= 1;
    }
    else 
    {
      if( downward && scaleXForCable < 0.4 )
      {
        scaleXForCable += 0.01;
      }
      else
      {
        downward = false;
        if(rotateForUpClaw < -10)
        {
          rotateForUpClaw += 1;
        }
        else
        {
          if(scaleXForCable > 0.05)
          {
            scaleXForCable -= 0.01;
          }
          else
          {
            isSequenceOpen = false;
            downward = true;
          }
        }
      }
    }
  }
  
  if(isBarRotatingQ)
  {
    rotateYForBar += 1;
  }
  else if (isBarRotatingW)
  {
    rotateYForBar -= 1;
  }
  
  if(isFloatingBlockMovingE)
  {
    if(translateXForfloatingBlock > -0.75)
    {
      translateXForfloatingBlock -= 0.01;
    }
    else
    {
      isFloatingBlockMovingE = false;
    }
  }
  else if (isFloatingBlockMovingR)
  {
    if(translateXForfloatingBlock < 0.75)
    {
      translateXForfloatingBlock += 0.01;
    }
    else
    {
      isFloatingBlockMovingR = false;
    }
  }
  
  if(isCableExtendingA)
  {
    if(scaleXForCable > 0.05)
    {
      scaleXForCable -= 0.01;
    }
    else
    {
      isCableExtendingA = false;
    }
  }
  else if (isCableExtendingZ)
  {
    if( scaleXForCable < 0.4 )
    {
      scaleXForCable += 0.01;
    }
    else
    {
      isCableExtendingZ = false;
    }
  }
  
  if(isUnderBlockRotatingS)
  {    
    rotateForUnderBlock -= 1;
  }
  else if (isUnderBlockRotatingD)
  {
    rotateForUnderBlock += 1;
  }
  
  if(isUpClawRotatingX)
  {
    if(rotateForUpClaw > -35)
    {
      rotateForUpClaw -= 1;
    }
    else
    {
      isUpClawRotatingX = false;
    }
  }
  else if (isUpClawRotatingC)
  {
    if(rotateForUpClaw < -15)
    {
      rotateForUpClaw += 1;
    }
    else
    {
      isUpClawRotatingC = false;
    }
  }  
  
  //draw the top box;
  pushMatrix();
    translate(0, 0.9, -3);
    scale(0.25, 0.1, 0.125);
    rotateY(PI); // just to see different color;
    drawQuad();
  popMatrix();
  
  //draw the horizantal bar;
  pushMatrix();
    translate(0, 0.75, -3);
    rotateY(radians(rotateYForBar));
    
    pushMatrix();
      scale(0.75, 0.05, 0.05);
      drawQuad();
    popMatrix();
    
    //draw the floating block;
    pushMatrix();
      translate(translateXForfloatingBlock, -0.15, 0);
      
      pushMatrix();
        rotateY(PI/2);
        scale(0.1, 0.1, 0.1);
        drawQuad();
      popMatrix();
    
      //draw the cable;
      translate(0, -0.1 - (0.5 * 2 * scaleXForCable ), 0);
      
      pushMatrix();
        rotate(PI/2);
        scale(scaleXForCable, 0.01, 0.01);
        drawQuad();
      popMatrix();
    
      //draw the block under the floating block;
      translate(0, -(0.5 * 2 * scaleXForCable) - 0.1, 0);
      rotateY(radians(rotateForUnderBlock));
      
      pushMatrix();
        scale(0.1, 0.1, 0.1);
        drawQuad();
      popMatrix();
      
      pushMatrix();
        //draw the left up claw;
        translate(-0.065, -0.1-0.04, 0); 
        rotate( radians(rotateForUpClaw) );
        pushMatrix();
          scale(0.03, 0.065, 0.03);
          drawQuad();
        popMatrix();
        
        translate(0, -0.05 - 0.03, 0);       
        fill(255,255,255);
        stroke(255,255,255);
        strokeWeight(1);
        sphere(0.03);
        
        noStroke();
        //draw the left low claw;
        translate(0.05, -0.03 - 0.02, 0); 
        rotate( radians(45) );
        scale(0.03, 0.05, 0.03);
        drawQuad();
      popMatrix();
      
      pushMatrix();
        //draw the right up claw;
        translate(0.065, -0.1-0.04, 0); 
        rotate( radians(-rotateForUpClaw) );
        pushMatrix();
          scale(0.03, 0.065, 0.03);
          drawQuad();
        popMatrix();
        
        translate(0, -0.05 - 0.03, 0);       
        fill(255,255,255);
        stroke(255,255,255);
        strokeWeight(1);
        sphere(0.03);
        
        noStroke();
        //draw the right low claw;
        translate(-0.05, -0.03 - 0.02, 0); 
        rotate( radians(-45) );
        scale(0.03, 0.05, 0.03);
        drawQuad();
      popMatrix();

    popMatrix();
  popMatrix();
  
  strokeWeight(1);
  stroke(255,255,255);
  
  pushMatrix();
    fill(250, 127, 80);
    translate(0, -0.8, -2.5);
    box(0.1, 0.2, 0.1);
  popMatrix();
  
  pushMatrix();
    fill(0, 199, 140);
    translate(0.5, -0.8, -3);
    sphere(0.1);
  popMatrix();
  
  pushMatrix();
    fill(12, 45, 7);
    translate(-0.3, -0.8, -3);
    beginShape(TRIANGLES);
    vertex(-0.1, 0, -0.1); // bottom
    vertex(0, 0, 0.1);
    vertex(0.1, 0, -0.1);
    
    vertex(-0.1, 0, -0.1); // left
    vertex(0, 0, 0.1);
    vertex(0, 0.1, -0.05);
    
    vertex(0.1, 0, -0.1); // right
    vertex(0, 0, 0.1);
    vertex(0, 0.1, -0.05);
    
    vertex(-0.1, 0, -0.1); // rear
    vertex(0, 0.1, -0.05);
    vertex(0.1, 0, -0.1);
    endShape();
  popMatrix();
  
}

void drawQuad()
{
  stroke(255,255,255);
  strokeWeight(10);
  beginShape(QUADS);
    fill(255, 0, 0);
    vertex(-1, -1, 1);
    vertex(1, -1, 1);
    vertex(1, 1, 1);
    vertex(-1, 1, 1);
    
    fill(0, 255, 0);
    vertex(-1, -1, -1);
    vertex(1, -1, -1);
    vertex(1, 1, -1);
    vertex(-1, 1, -1);
    
    fill(0, 0, 255);
    vertex(-1, 1, 1);
    vertex(-1, -1, 1);
    vertex(-1, -1, -1);
    vertex(-1, 1, -1);
    
    fill(255, 255, 0);
    vertex(1, 1, 1);
    vertex(1, -1, 1);
    vertex(1, -1, -1);
    vertex(1, 1, -1);
    
    fill(0, 255, 255);
    vertex(-1, -1, 1);
    vertex(1, -1, 1);
    vertex(1, -1, -1);
    vertex(-1, -1, -1);
    
    fill(255, 0, 255);
    vertex(-1, 1, 1);
    vertex(1, 1, 1);
    vertex(1, 1, -1);
    vertex(-1, 1, -1);
  endShape();
  noStroke();
}

void keyPressed()
{
  if(key == 'q')
  {
    if(isBarRotatingQ)
    {
      isBarRotatingQ = false;
    }
    else if (isBarRotatingW)
    {
      isBarRotatingW = false;
      isBarRotatingQ = true;
    }
    else
    {
      isBarRotatingQ = true;
    }
  }
  else if(key == 'w')
  {
    if(isBarRotatingW)
    {
      isBarRotatingW = false;
    }
    else if (isBarRotatingQ)
    {
      isBarRotatingQ = false;
      isBarRotatingW = true;
    }
    else
    {
      isBarRotatingW = true;
    }
  }
  
  if(key == 'e')
  {
    if(isFloatingBlockMovingE)
    {
      isFloatingBlockMovingE = false;
    }
    else if (isFloatingBlockMovingR)
    {
      isFloatingBlockMovingE = true;
      isFloatingBlockMovingR = false;
    }
    else
    {
      isFloatingBlockMovingE = true;
    }
  }
  else if(key == 'r')
  {
    if(isFloatingBlockMovingR)
    {
      isFloatingBlockMovingR = false;
    }
    else if (isFloatingBlockMovingE)
    {
      isFloatingBlockMovingR = true;
      isFloatingBlockMovingE = false;
    }
    else
    {
      isFloatingBlockMovingR = true;
    }
  }
  
  if(key == 'a')
  {
    if(isCableExtendingA)
    {
      isCableExtendingA = false;
    }
    else if (isCableExtendingZ)
    {
      isCableExtendingA = true;
      isCableExtendingZ = false;
    }
    else
    {
      isCableExtendingA = true;
    }
  }
  else if(key == 'z')
  {
    if(isCableExtendingZ)
    {
      isCableExtendingZ = false;
    }
    else if (isCableExtendingA)
    {
      isCableExtendingA = false;
      isCableExtendingZ = true;
    }
    else
    {
      isCableExtendingZ = true;
    }
  }
  
  if(key == 's')
  {
    if(isUnderBlockRotatingS)
    {
      isUnderBlockRotatingS = false;
    }
    else if (isUnderBlockRotatingD)
    {
      isUnderBlockRotatingD = false;
      isUnderBlockRotatingS = true;
    }
    else
    {
      isUnderBlockRotatingS = true;
    }
  }
  else if(key == 'd')
  {
    if(isUnderBlockRotatingD)
    {
      isUnderBlockRotatingD = false;
    }
    else if (isUnderBlockRotatingS)
    {
      isUnderBlockRotatingS = false;
      isUnderBlockRotatingD = true;
    }
    else
    {
      isUnderBlockRotatingD = true;
    }
  }
  
  if(key == 'x')
  {
    if(isUpClawRotatingX)
    {
      isUpClawRotatingX = false;
    }
    else if (isUpClawRotatingC)
    {
      isUpClawRotatingC = false;
      isUpClawRotatingX = true;
    }
    else
    {
      isUpClawRotatingX = true;
    }
  }
  else if(key == 'c')
  {
    if(isUpClawRotatingC)
    {
      isUpClawRotatingC = false;
    }
    else if (isUpClawRotatingX)
    {
      isUpClawRotatingC = true;
      isUpClawRotatingX = false;
    }
    else
    {
      isUpClawRotatingC = true;
    }
  }
  
  if(key == 'o')
  {
    perspective = false;
  }
  else if(key == 'p')
  {
    perspective = true;
  }
  
  if(key == '1')
  {
    eyeX = 0;
    eyeY = 0;
    eyeZ = 0;
    centerX = 0;
    centerY = 0;
    centerZ = -1;
    upX = 0;
    upY = 1;
    upZ = 0;
  }
  else if(key == '2')
  {
    eyeX = 2.0;
    eyeY = -0.6;
    eyeZ = 0;
    centerX = 1.3;
    centerY = -0.375;
    centerZ = -1;
    upX = 0;
    upY = 1;
    upZ = 0;
  }
  else if(key == '3')
  {
    eyeX = -0.5;
    eyeY = 1.8;
    eyeZ = 0;
    centerX = -0.35;
    centerY = 1.2;
    centerZ = -1;
    upX = 0;
    upY = 1;
    upZ = 0;
  }
  
  else if(key == ' ')
  {
    isSequenceOpen = true; 
  }
}
