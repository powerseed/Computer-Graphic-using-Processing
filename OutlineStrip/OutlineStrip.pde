final int[][][] STRIPS = {
  {
    { 30, 30 },
    { 80, 80 }
  },
  {
    { 150, 80 },
    { 100, 30 }
  },
  {
    { 80, 150 },
    { 30, 200 }
  },
  {
    { 100, 200 },
    { 150, 150 }
  },
  {
    { 180, 320 },
    { 160, 260 },
    { 40, 450 },
    { 100, 600 },
    { 160, 450 },
    { 40, 260 },
    { 20, 320 }
  },
  {
    { 480, 20 },
    { 200, 20 },
    { 200, 200 },
    { 270, 200 },
    { 270, 40 },
    { 230, 40 },
    { 230, 150 },
    { 310, 150 },
    { 310, 100 },
    { 350, 100 },
    { 350, 40 },
    { 290, 40 },
    { 290, 130 },
    { 330, 130 },
    { 330, 80 },
    { 370, 80 },
    { 400, 80 },
    { 400, 40 },
    { 380, 40 },
    { 380, 100 },
    { 380, 170 },
    { 300, 170 },
    { 300, 200 },
    { 350, 200 },
    { 350, 140 },
    { 400, 140 },
    { 445, 140 },
    { 480, 140 },
    { 480, 200 },
    { 460, 200 },
    { 460, 40 },
    { 430, 40 },
    { 430, 190 },
    { 400, 190 },
  },
  {
    { 520, 20 },
    { 570, 50 },
    { 540, 270 },
    { 550, 360 },
    { 580, 280 },
    { 620, 360 },
    { 620, 250 },
    { 515, 70 },
    { 560, 15 },
    { 590, 15 },
    { 620, 40 },
    { 600, 70 },
    { 610, 150 }
  },

  {
    { 250, 250 }, 
    { 426, 523 }, 
    { 239, 314 }, 
    { 317, 590 }, 
    { 204, 491 }, 
    { 339, 485 }, 
    { 363, 579 }, 
    { 427, 577 }, 
    { 435, 626 }, 
    { 619, 624 }, 
    { 594, 392 }, 
    { 572, 591 }, 
    { 421, 236 }, 
    { 497, 238 }, 
    { 505, 349 }, 
    { 513, 590 }, 
    { 458, 550 }, 
    { 471, 457 }, 
    { 306, 274 }, 
    { 368, 235 }, 
    { 425, 459 }
  }
};

final int[] WIDTHS = {
  45,
  45,
  44,
  44,
  37,
  15,
  29,
  24
};

void setup()
{
  size(640, 640, P3D);
  noFill();
}

void draw()
{
  float x1 = 0;
  float y1 = 0;
  float x2 = 0;
  float y2 = 0;
  float x3 = 0;
  float y3 = 0;
  float x4 = 0;
  float y4 = 0;
  float angle = 0;
  float distance = 0;
    
    background(0,0,0);
    stroke( 255,255,0);
    // draw strips
    for(int numOfStrip = 0; numOfStrip<STRIPS.length; numOfStrip++)
    {
      beginShape(LINE_STRIP);
      for(int numOfVertex = 0; numOfVertex<STRIPS[numOfStrip].length; numOfVertex++)
      {
        vertex(STRIPS[numOfStrip][numOfVertex][0], STRIPS[numOfStrip][numOfVertex][1]);
      }
      endShape();
    } 
    
    stroke( 255,0,0);    
    // draw outlines
    for(int numOfStrip = 0; numOfStrip<STRIPS.length; numOfStrip++)
    {
      float right[][] = new float[ 2 * STRIPS[numOfStrip].length - 2 ][2];
      float left[][]  = new float[ 2 * STRIPS[numOfStrip].length - 2 ][2];
      int indexForRight = 0;
      int indexForLeft = 0;
      
      for(int numOfVertex = 0; numOfVertex < STRIPS[numOfStrip].length-1; numOfVertex++)
      {
        x1 = STRIPS[numOfStrip][numOfVertex][0];
        y1 = STRIPS[numOfStrip][numOfVertex][1];
        x2 = STRIPS[numOfStrip][numOfVertex+1][0];
        y2 = STRIPS[numOfStrip][numOfVertex+1][1];
        
        float widthOfStrip = WIDTHS[numOfStrip] / 2.0f;
        distance = dist(x1, y1, x2, y2);
        angle = asin( abs(x2-x1) / distance );
        float Xoffset = sin ( 0.5 * PI - angle ) * widthOfStrip;
        float Yoffset = cos ( 0.5 * PI - angle ) * widthOfStrip;
        
        float newX1;
        float newY1;
        float newX2;
        float newY2;
        
        if( ( x1 > x2 && y1 < y2 ) || ( x1 < x2 && y1 > y2) )
        {
          newX1 = x1 - Xoffset;
          newY1 = y1 - Yoffset;
          newX2 = x2 - Xoffset;
          newY2 = y2 - Yoffset;
          
          if( x1 > x2 && y1 < y2 )
          {
            right[indexForRight][0] = newX1;
            right[indexForRight][1] = newY1;            
            indexForRight++;            
            right[indexForRight][0] = newX2;
            right[indexForRight][1] = newY2;            
            indexForRight++;
          }
          else if ( x1 < x2 && y1 > y2 )
          {
            left[indexForLeft][0] = newX1;
            left[indexForLeft][1] = newY1;
            indexForLeft++;
            left[indexForLeft][0] = newX2;
            left[indexForLeft][1] = newY2;
            indexForLeft++;
          }          
          
          newX1 = x1 + Xoffset;
          newY1 = y1 + Yoffset;
          newX2 = x2 + Xoffset;
          newY2 = y2 + Yoffset;
          
          if( x1 > x2 && y1 < y2 )
          {
            left[indexForLeft][0] = newX1;
            left[indexForLeft][1] = newY1;
            indexForLeft++;
            left[indexForLeft][0] = newX2;
            left[indexForLeft][1] = newY2;
            indexForLeft++;
          }
          else if ( x1 < x2 && y1 > y2 )
          {
            right[indexForRight][0] = newX1;
            right[indexForRight][1] = newY1;
            indexForRight++;
            right[indexForRight][0] = newX2;
            right[indexForRight][1] = newY2;
            indexForRight++;
          }           
        }
        else if ( ( x1 < x2 && y1 < y2 ) || ( x1 > x2 && y1 > y2 ) )
        {
          newX1 = x1 + Xoffset;
          newY1 = y1 - Yoffset;
          newX2 = x2 + Xoffset;
          newY2 = y2 - Yoffset;
          
          if( x1 < x2 && y1 < y2 )
          {
            left[indexForLeft][0] = newX1;
            left[indexForLeft][1] = newY1;
            indexForLeft++;
            left[indexForLeft][0] = newX2;
            left[indexForLeft][1] = newY2;
            indexForLeft++;
          }
          else if ( x1 > x2 && y1 > y2 )
          {
            right[indexForRight][0] = newX1;
            right[indexForRight][1] = newY1;
            indexForRight++;
            right[indexForRight][0] = newX2;
            right[indexForRight][1] = newY2;
            indexForRight++;
          }
                   
          newX1 = x1 - Xoffset;
          newY1 = y1 + Yoffset;
          newX2 = x2 - Xoffset;
          newY2 = y2 + Yoffset;
          
          if( x1 < x2 && y1 < y2 )
          {
            right[indexForRight][0] = newX1;
            right[indexForRight][1] = newY1;
            indexForRight++;
            right[indexForRight][0] = newX2;
            right[indexForRight][1] = newY2;
            indexForRight++;
          }
          else if ( x1 > x2 && y1 > y2 )
          {
            left[indexForLeft][0] = newX1;
            left[indexForLeft][1] = newY1;
            indexForLeft++;
            left[indexForLeft][0] = newX2;
            left[indexForLeft][1] = newY2;
            indexForLeft++;
          }          
        }
        else if( x1 == x2 )      // vertical
        {
          // move to right 
          newX1 = x1 + widthOfStrip;
          newY1 = y1;
          newX2 = x2 + widthOfStrip;
          newY2 = y2;
          
          if( y1 > y2 )
          {            
            right[indexForRight][0] = newX1;
            right[indexForRight][1] = newY1;
            indexForRight++;
            right[indexForRight][0] = newX2;
            right[indexForRight][1] = newY2;
            indexForRight++;
          }
          else
          {
            left[indexForLeft][0] = newX1;
            left[indexForLeft][1] = newY1;
            indexForLeft++;
            left[indexForLeft][0] = newX2;
            left[indexForLeft][1] = newY2;
            indexForLeft++;
          }
          
          // move to left 
          newX1 = x1 - widthOfStrip;
          newY1 = y1;
          newX2 = x2 - widthOfStrip;
          newY2 = y2;
          
          if( y1 > y2 )
          {
            left[indexForLeft][0] = newX1;
            left[indexForLeft][1] = newY1;
            indexForLeft++;
            left[indexForLeft][0] = newX2;
            left[indexForLeft][1] = newY2;
            indexForLeft++;
          }
          else
          {
            right[indexForRight][0] = newX1;
            right[indexForRight][1] = newY1;
            indexForRight++;
            right[indexForRight][0] = newX2;
            right[indexForRight][1] = newY2;
            indexForRight++;
          }
        }
        else if (y1 == y2)                // horizantal
        {
          // move down
          newX1 = x1;
          newY1 = y1 + widthOfStrip;
          newX2 = x2;
          newY2 = y2 + widthOfStrip;
          
          if( x1 < x2 )
          {
            right[indexForRight][0] = newX1;
            right[indexForRight][1] = newY1;
            indexForRight++;
            right[indexForRight][0] = newX2;
            right[indexForRight][1] = newY2;
            indexForRight++;
          }
          else
          {
            left[indexForLeft][0] = newX1;
            left[indexForLeft][1] = newY1;
            indexForLeft++;
            left[indexForLeft][0] = newX2;
            left[indexForLeft][1] = newY2;
            indexForLeft++;
          }
          
          // move up
          newX1 = x1;
          newY1 = y1 - widthOfStrip;
          newX2 = x2;
          newY2 = y2 - widthOfStrip;
          
          if( x1 < x2 )
          {
            left[indexForLeft][0] = newX1;
            left[indexForLeft][1] = newY1;
            indexForLeft++;
            left[indexForLeft][0] = newX2;
            left[indexForLeft][1] = newY2;
            indexForLeft++;
          }
          else
          {
            right[indexForRight][0] = newX1;
            right[indexForRight][1] = newY1;
            indexForRight++;
            right[indexForRight][0] = newX2;
            right[indexForRight][1] = newY2;
            indexForRight++;
          }
        }
      }// inner for
    
      for(int i = 0; i < right.length-3; i += 2)
      {
        x1 = right[i][0];
        y1 = right[i][1];

        x2 = right[i+1][0];
        y2 = right[i+1][1];
        
        x3 = right[i+2][0];
        y3 = right[i+2][1];
        
        x4 = right[i+3][0];
        y4 = right[i+3][1];
        
        float ta, tb;
        ta = ((x4-x3)*(y1-y3)-(y4-y3)*(x1-x3)) / ((y4-y3)*(x2-x1)-(x4-x3)*(y2-y1));
        tb = ((x2-x1)*(y1-y3)-(y2-y1)*(x1-x3)) / ((y4-y3)*(x2-x1)-(x4-x3)*(y2-y1));
        
        if( (ta > 0 && ta < 1) && (tb > 0 && tb < 1) )    //   have intersections on the right side
        {
            float intersectionX = x1 + ta * (x2 - x1);
            float intersectionY = y1 + ta * (y2 - y1);
            
            right[i+1][0] = intersectionX;
            right[i+1][1] = intersectionY;
        
            right[i+2][0] = intersectionX;
            right[i+2][1] = intersectionY;
            
            // draw joins
            float p1x = left[i+1][0];
            float p1y = left[i+1][1];
            
            float p2x = left[i+2][0];
            float p2y = left[i+2][1];
            
            float originX = STRIPS[numOfStrip][(i+2)/2][0];
            float originY = STRIPS[numOfStrip][(i+2)/2][1];
            
            angle = 2 * ( asin( (dist(p1x, p1y, p2x, p2y) / 2.0f ) / ( WIDTHS[numOfStrip] / 2.0f ) ) );            
            float beta = asin( abs( originY - p1y ) / ( WIDTHS[numOfStrip] / 2.0f ) );
            float finalAngle = 0;
            if( p1x >= originX && p1y <= originY )
            {
              finalAngle = 2 * PI - beta;
            }
            else if ( p1x <= originX && p1y <= originY )
            {
              finalAngle = PI + beta;
            }
            else if ( p1x <= originX && p1y >= originY )
            {
              finalAngle = PI - beta;
            }
            else if ( p1x >= originX && p1y >= originY )
            {
              finalAngle = beta;
            }            
            else if ( originX == p2x && originY == p1y && p2x > p1x && p2y < p1y )  // 1
            {            
              finalAngle = PI;      
            }          
            else if ( originX == p1x && originY == p2y && p2x < p1x && p2y > p1y )  // 2
            {
              finalAngle = PI; 
            }
            else if ( originX == p1x && originY == p2y && p2x > p1x && p2y > p1y )  // 3 
            {
              finalAngle = 1.5 * PI;  
            } 
            else if ( originX == p2x && originY == p1y && p2x < p1x && p2y < p1y )  // 4
            {
              finalAngle = 1.5 * PI;  
            }
            else if ( originX == p2x && originY == p1y && p2x > p1x && p2y > p1y )  // 5
            {
              finalAngle = 0.5 * PI;  
            } 
            else if ( originX == p1x && originY == p2y && p2x < p1x && p2y < p1y )  // 6
            {
              finalAngle = 0.5 * PI;  
            }          
            else if ( originX == p2x && originY == p1y && p2x < p1x && p2y > p1y )  // 7
            {
              finalAngle = 0;  
            }
            else if ( originX == p1x && originY == p2y && p2x > p1x && p2y < p1y )  // 8
            {
              finalAngle = 0;  
            }
            arc( originX, originY, WIDTHS[numOfStrip], WIDTHS[numOfStrip], finalAngle, finalAngle+angle);
        }
        else if ( ta < 0 || ta > 1 || tb < 0 || tb > 1 )                                                 //   no intersections on the right side
        {
          x1 = left[i][0];
          y1 = left[i][1];
  
          x2 = left[i+1][0];
          y2 = left[i+1][1];
          
          x3 = left[i+2][0];
          y3 = left[i+2][1];
          
          x4 = left[i+3][0];
          y4 = left[i+3][1];
          
          ta = ((x4-x3)*(y1-y3)-(y4-y3)*(x1-x3)) / ((y4-y3)*(x2-x1)-(x4-x3)*(y2-y1));
          tb = ((x2-x1)*(y1-y3)-(y2-y1)*(x1-x3)) / ((y4-y3)*(x2-x1)-(x4-x3)*(y2-y1));
          
          float intersectionX = x1 + ta * (x2 - x1);
          float intersectionY = y1 + ta * (y2 - y1);
          
          left[i+1][0] = intersectionX;
          left[i+1][1] = intersectionY;
      
          left[i+2][0] = intersectionX;
          left[i+2][1] = intersectionY;
          
          // draw joins ( p1x and p2x are reversed, so as p1y and p2y)
          float p2x = right[i+1][0];
          float p2y = right[i+1][1];
          
          float p1x = right[i+2][0];
          float p1y = right[i+2][1];
          
          float originX = STRIPS[numOfStrip][(i+2)/2][0];
          float originY = STRIPS[numOfStrip][(i+2)/2][1];
          
          angle = 2 * ( asin( (dist(p1x, p1y, p2x, p2y) / 2) / ( WIDTHS[numOfStrip] / 2.0f ) ) );            
          float beta = asin( abs( originY - p1y ) / ( WIDTHS[numOfStrip] / 2.0f ) );
          float finalAngle = 0;
                              
          if( p1x >= originX && p1y <= originY )
          {
            finalAngle = 2 * PI - beta;
          }
          else if ( p1x <= originX && p1y <= originY )
          {
            finalAngle = PI + beta;
          }
          else if ( p1x <= originX && p1y >= originY )
          {
            finalAngle = PI - beta;
          }
          else if ( p1x >= originX && p1y >= originY )
          {
            finalAngle = beta;
          }          
          // all p1x, p2x, p1y, p2y are reversed
          else if ( originX == p2x && originY == p1y && p2x > p1x && p2y < p1y )  // 1
          {            
            finalAngle = PI;      
          }          
          else if ( originX == p1x && originY == p2y && p2x < p1x && p2y > p1y )  // 2
          {
            finalAngle = PI; 
          }
          else if ( originX == p1x && originY == p2y && p2x > p1x && p2y > p1y )  // 3 
          {
            finalAngle = 1.5 * PI;  
          } 
          else if ( originX == p2x && originY == p1y && p2x < p1x && p2y < p1y )  // 4
          {
            finalAngle = 1.5 * PI;  
          }
          else if ( originX == p2x && originY == p1y && p2x > p1x && p2y > p1y )  // 5
          {
            finalAngle = 0.5 * PI;  
          } 
          else if ( originX == p1x && originY == p2y && p2x < p1x && p2y < p1y )  // 6
          {
            finalAngle = 0.5 * PI;  
          }          
          else if ( originX == p2x && originY == p1y && p2x < p1x && p2y > p1y )  // 7
          {
            finalAngle = 0;  
          }
          else if ( originX == p1x && originY == p2y && p2x > p1x && p2y < p1y )  // 8
          {
            finalAngle = 0;  
          }
          
          arc( originX, originY, WIDTHS[numOfStrip], WIDTHS[numOfStrip], finalAngle, finalAngle+angle);
        }       
      }    
      
      for(int i = 0; i < right.length; i+=2)
      {
        float rightOriginX = right[i][0];
        float rightOriginY = right[i][1];
        float rightDestX = right[i+1][0];
        float rightDestY = right[i+1][1];
        
        float leftOriginX = left[i][0];
        float leftOriginY = left[i][1];
        float leftDestX = left[i+1][0];
        float leftDestY = left[i+1][1];
        
        float otherRightOriginX = 0;
        float otherRightOriginY = 0;
        float otherRightDestX = 0;
        float otherRightDestY = 0;
        
        float otherLeftOriginX = 0;
        float otherLeftOriginY = 0;
        float otherLeftDestX = 0;
        float otherLeftDestY = 0;
        
                  
        float rrInterX = 0;
        float rrInterY = 0;
        float rlInterX = 0;
        float rlInterY = 0;
        
        float lrInterX = 0;
        float lrInterY = 0;
        float llInterX = 0;
        float llInterY = 0;
        
        int index = i+2;
        boolean isIntersected = false;
        while( !isIntersected && index < right.length - 3 )
        {         
          // the right side outline that intersect with right
          otherRightOriginX = right[index+2][0];
          otherRightOriginY = right[index+2][1];
          
          otherRightDestX = right[index+3][0];
          otherRightDestY = right[index+3][1];
          
          float ta = ((otherRightOriginX - otherRightDestX) * (rightOriginY - otherRightDestY) - (otherRightOriginY - otherRightDestY ) * ( rightOriginX - otherRightDestX )) / 
                     ((otherRightOriginY - otherRightDestY) * (rightDestX - rightOriginX) - (otherRightOriginX - otherRightDestX ) * ( rightDestY - rightOriginY ));
          float tb = (( rightDestX - rightOriginX ) * ( rightOriginY - otherRightDestY ) - ( rightDestY - rightOriginY ) * ( rightOriginX - otherRightDestX )) / 
                     ((otherRightOriginY - otherRightDestY) * (rightDestX - rightOriginX) - (otherRightOriginX - otherRightDestX ) * ( rightDestY - rightOriginY ));
            
          if( (ta > 0 && ta < 1) && (tb > 0 && tb < 1) )  // have intersections
          {
            isIntersected = true;
            rrInterX = rightOriginX + ta * (rightDestX - rightOriginX);
            rrInterY = rightOriginY + ta * (rightDestY - rightOriginY);
            
            // take the left ouline that intersect with original one.            
            otherLeftOriginX = left[index+2][0];
            otherLeftOriginY = left[index+2][1];
            
            otherLeftDestX = left[index+3][0];
            otherLeftDestY = left[index+3][1];
            
            ta = ((otherLeftOriginX-otherLeftDestX)*(rightOriginY-otherLeftDestY)-(otherLeftOriginY-otherLeftDestY)*(rightOriginX-otherLeftDestX)) / 
                 ((otherLeftOriginY-otherLeftDestY)*(rightDestX-rightOriginX)-(otherLeftOriginX-otherLeftDestX)*(rightDestY-rightOriginY));
            tb = ((rightDestX-rightOriginX)*(rightOriginY-otherLeftDestY)-(rightDestY-rightOriginY)*(rightOriginX-otherLeftDestX)) /
                 ((otherLeftOriginY-otherLeftDestY)*(rightDestX-rightOriginX)-(otherLeftOriginX-otherLeftDestX)*(rightDestY-rightOriginY));
            
            rlInterX = rightOriginX + ta * (rightDestX - rightOriginX);
            rlInterY = rightOriginY + ta * (rightDestY - rightOriginY);
            
            float distance1 = dist(rrInterX, rrInterY, rightOriginX, rightOriginY);
            float distance2 = dist(rlInterX, rlInterY, rightOriginX, rightOriginY);
            
            if( distance1 < distance2 )
            {
              beginShape(LINES);
                vertex( rightOriginX, rightOriginY );
                vertex( rrInterX, rrInterY );
                
                vertex( rlInterX, rlInterY );
                vertex( rightDestX, rightDestY );
              endShape();
            }
            else
            {
              beginShape(LINES);
                vertex( rightOriginX, rightOriginY );
                vertex( rlInterX, rlInterY );
                
                vertex( rrInterX, rrInterY );
                vertex( rightDestX, rightDestY );
              endShape();
            }
            
            // draw left outline
            ta = ((otherRightOriginX - otherRightDestX) * (leftOriginY - otherRightDestY) - (otherRightOriginY - otherRightDestY ) * ( leftOriginX - otherRightDestX )) / 
                       ((otherRightOriginY - otherRightDestY) * (leftDestX - leftOriginX) - (otherRightOriginX - otherRightDestX ) * ( leftDestY - leftOriginY ));
            tb = (( leftDestX - leftOriginX ) * ( leftOriginY - otherRightDestY ) - ( leftDestY - leftOriginY ) * ( leftOriginX - otherRightDestX )) / 
                       ((otherRightOriginY - otherRightDestY) * (leftDestX - leftOriginX) - (otherRightOriginX - otherRightDestX ) * ( leftDestY - leftOriginY ));
            
            lrInterX = leftOriginX + ta * (leftDestX - leftOriginX);
            lrInterY = leftOriginY + ta * (leftDestY - leftOriginY);
            
            // take the left ouline that intersect with original one.                          
            ta = ((otherLeftOriginX - otherLeftDestX) * (leftOriginY - otherLeftDestY) - (otherLeftOriginY - otherLeftDestY ) * ( leftOriginX - otherLeftDestX )) / 
                     ((otherLeftOriginY - otherLeftDestY) * (leftDestX - leftOriginX) - (otherLeftOriginX - otherLeftDestX ) * ( leftDestY - leftOriginY ));
            tb = (( leftDestX - leftOriginX ) * ( leftOriginY - otherLeftDestY ) - ( leftDestY - leftOriginY ) * ( leftOriginX - otherLeftDestX )) / 
                     ((otherLeftOriginY - otherLeftDestY) * (leftDestX - leftOriginX) - (otherLeftOriginX - otherLeftDestX ) * ( leftDestY - leftOriginY ));
            
            llInterX = leftOriginX + ta * (leftDestX - leftOriginX);
            llInterY = leftOriginY + ta * (leftDestY - leftOriginY);
            
            distance1 = dist(lrInterX, lrInterY, leftOriginX, leftOriginY);
            distance2 = dist(llInterX, llInterY, leftOriginX, leftOriginY);
            
            if( distance1 < distance2 )
            {
              beginShape(LINES);
                vertex( leftOriginX, leftOriginY );
                vertex( lrInterX, lrInterY );
                
                vertex( llInterX, llInterY );
                vertex( leftDestX, leftDestY );
              endShape();
            }
            else
            {
              beginShape(LINES);
                vertex( leftOriginX, leftOriginY );
                vertex( llInterX, llInterY );
                
                vertex( lrInterX, lrInterY );
                vertex( leftDestX, leftDestY );
              endShape();
            }        
            // modify the right other outline.
            distance1 = dist(lrInterX, lrInterY, otherRightOriginX, otherRightOriginY);
            distance2 = dist(rrInterX, rrInterY, otherRightOriginX, otherRightOriginY);
            if(distance1 < distance2)
            {
              beginShape(LINES);
                vertex( otherRightOriginX, otherRightOriginY );
                vertex( lrInterX, lrInterY );
                
                vertex( rrInterX, rrInterY );
                vertex( otherRightDestX, otherRightDestY );
              endShape();
            }
            else
            {
              beginShape(LINES);
                vertex( otherRightOriginX, otherRightOriginY );
                vertex( rrInterX, rrInterY );
                
                vertex( lrInterX, lrInterY );
                vertex( otherRightDestX, otherRightDestY );
              endShape();
            }
            right[index+2][0] = -1;
            right[index+2][1] = -1;
          
            right[index+3][0] = -1;
            right[index+3][1] = -1;
            
            // modify the left other outline.
            distance1 = dist(rlInterX, rlInterY, otherLeftOriginX, otherLeftOriginY);
            distance2 = dist(llInterX, llInterY, otherLeftOriginX, otherLeftOriginY);
            if(distance1 < distance2)
            {
              beginShape(LINES);
                vertex( otherLeftOriginX, otherLeftOriginY );
                vertex( rlInterX, rlInterY );
                
                vertex( llInterX, llInterY );
                vertex( otherLeftDestX, otherLeftDestY );
              endShape();
            }
            else
            {
              beginShape(LINES);
                vertex( otherLeftOriginX, otherLeftOriginY );
                vertex( llInterX, llInterY );
                
                vertex( rlInterX, rlInterY );
                vertex( otherLeftDestX, otherLeftDestY );
              endShape();
            }
            left[index+2][0] = -1;
            left[index+2][1] = -1;
          
            left[index+3][0] = -1;
            left[index+3][1] = -1;
            
          }//if       
          index = index + 2;
        }//while   
        if( isIntersected == false ) 
        {
          beginShape(LINES);
              vertex( rightOriginX, rightOriginY );
              vertex( rightDestX, rightDestY );
              
              vertex( leftOriginX, leftOriginY );
              vertex( leftDestX, leftDestY );
          endShape();
        }
      }
    }
          
    // draw caps
    for(int numOfStrip = 0; numOfStrip<STRIPS.length; numOfStrip++)
    {
      //the first vertex
      x1 = STRIPS[numOfStrip][0][0];
      y1 = STRIPS[numOfStrip][0][1];
      x2 = STRIPS[numOfStrip][1][0];
      y2 = STRIPS[numOfStrip][1][1];
      
      if( (x1 < x2 && y1 < y2) || ( x1 > x2 && y1 > y2 ) )   // less than 90 degrees. 
      {
        angle = asin( abs(y2-y1) / dist(x1,y1,x2,y2) );
        if(x1 < x2)
        {
          arc(x1, y1, WIDTHS[numOfStrip], WIDTHS[numOfStrip], 0.5*PI+angle, 1.5*PI+angle);
        }
        else
        {
          arc(x1, y1, WIDTHS[numOfStrip], WIDTHS[numOfStrip], 1.5*PI+angle, 2.5*PI+angle);
        }
      }
      else if ( (x1 < x2 && y1 > y2) || ( x1 > x2 && y1 < y2 ) )  // greater than 90 degrees. 
      {
        angle = PI - asin( abs(y2-y1) / dist(x1,y1,x2,y2) );
        if(x1 < x2)
        {
          arc(x1, y1, WIDTHS[numOfStrip], WIDTHS[numOfStrip], 1.5*PI+angle, 2.5*PI+angle);
        }
        else
        {
          arc(x1, y1, WIDTHS[numOfStrip], WIDTHS[numOfStrip], 0.5*PI+angle, 1.5*PI+angle);
        }
      } 
      else    //   horizantal
      {
        if(x1 < x2)
        {
          arc(x1, y1, WIDTHS[numOfStrip], WIDTHS[numOfStrip], 0.5*PI, 1.5*PI);
        }
        else
        {
          arc(x1, y1, WIDTHS[numOfStrip], WIDTHS[numOfStrip], 1.5*PI, 2.5*PI);
        }
      }
      
      // the last vertext
      int last = STRIPS[numOfStrip].length - 1;
      x2 = STRIPS[numOfStrip][last-1][0];
      y2 = STRIPS[numOfStrip][last-1][1];
      x1 = STRIPS[numOfStrip][last][0];
      y1 = STRIPS[numOfStrip][last][1];
      
      if( (x1 < x2 && y1 < y2) || ( x1 > x2 && y1 > y2 ) )   // less than 90 degrees. 
      {
        angle = asin( abs(y2-y1) / dist(x1,y1,x2,y2) );
        if(x1 < x2)
        {
          arc(x1, y1, WIDTHS[numOfStrip], WIDTHS[numOfStrip], 0.5*PI+angle, 1.5*PI+angle);
        }
        else
        {
          arc(x1, y1, WIDTHS[numOfStrip], WIDTHS[numOfStrip], 1.5*PI+angle, 2.5*PI+angle);
        }
      }
      else if ( (x1 < x2 && y1 > y2) || ( x1 > x2 && y1 < y2 ) )  // greater than 90 degrees. 
      {
        angle = PI - asin( abs(y2-y1) / dist(x1,y1,x2,y2) );
        if(x1 < x2)
        {
          arc(x1, y1, WIDTHS[numOfStrip], WIDTHS[numOfStrip], 1.5*PI+angle, 2.5*PI+angle);
        }
        else
        {
          arc(x1, y1, WIDTHS[numOfStrip], WIDTHS[numOfStrip], 0.5*PI+angle, 1.5*PI+angle);
        }
      } 
      else    //   horizantal
      {
        if(x1 < x2)
        {
          arc(x1, y1, WIDTHS[numOfStrip], WIDTHS[numOfStrip], 0.5*PI, 1.5*PI);
        }
        else
        {
          arc(x1, y1, WIDTHS[numOfStrip], WIDTHS[numOfStrip], 1.5*PI, 2.5*PI);
        }
      }
    }
}
