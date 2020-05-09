void setup()
{
  size(800, 600, P3D);
  background(0,0,0);
  stroke(255,255,255);
  surface.setResizable(true);
}

float red = 0;
float green = 0;
float blue = 205;                
  
float[] origin = new float[2];

float widthOfColor = 10;
float heightOfColor = 10;
  
float colors [][] = {
                      {0, 0, 205},
                      {0, 205, 0},
                      {255, 0, 0},
                      {0, 255, 255},
                      {255, 20, 147},
                      {255, 255, 0},
                      {95, 158, 160},
                      {148, 0, 211},
                      {184, 134, 11},
                      {139, 139, 122}
                    }; 
                    
int indexOfVertex = 0;

ArrayList<PVector> vertices  = new ArrayList<PVector>();   
ArrayList<PVector> originalVertices  = new ArrayList<PVector>();   

ArrayList<int[]> triangles = new ArrayList<int[]>();
ArrayList<float[]> colourForTriangles  = new ArrayList<float[]>(); 

int[] containerForTriangle = new int[3];

int numOfTriangleSelected = -1 ;
int numOfVertexSelected = -1 ;
int numOfColorSelected = -1; 

float transformationForViewX = 0;
float transformationForViewY = 0;

float scaleForView = 1;


void draw()
{  
  clear();
  origin[0] = width/2;
  origin[1] = height/2;
  widthOfColor = width / 10;
  heightOfColor = 30;

  float startOfX = 0;
  for( int i = 0; i < 10; i++)
  {
    fill(colors[i][0], colors[i][1], colors[i][2]);
    noStroke();
    rect( startOfX, height-30, widthOfColor, heightOfColor );
    startOfX += widthOfColor;
  }  
  
  if( numOfColorSelected != -1 )
  {
    noFill();
    stroke(255, 255, 255);
    strokeWeight(3);
    rect( widthOfColor * numOfColorSelected, height-30, widthOfColor, heightOfColor);
  }
  
  pushMatrix();
    translate(transformationForViewX, transformationForViewY);
    scale(scaleForView);

  int indexOfColor = 0;
  for( int i = 0; i < triangles.size(); i++ )
  {    
    stroke(255, 255, 255);
    strokeWeight(1);
    fill( colourForTriangles.get(indexOfColor)[0], colourForTriangles.get(indexOfColor)[1], colourForTriangles.get(indexOfColor)[2] );
    indexOfColor++;
    triangle(
              vertices.get(triangles.get(i)[0]).x, vertices.get(triangles.get(i)[0]).y,
              vertices.get(triangles.get(i)[1]).x, vertices.get(triangles.get(i)[1]).y, 
              vertices.get(triangles.get(i)[2]).x, vertices.get(triangles.get(i)[2]).y
            );
  }
   
  if( numOfTriangleSelected != -1 )
  {
    strokeWeight(5);
    stroke(255,255,255);
    beginShape(POINTS);
      vertex( vertices.get(triangles.get(numOfTriangleSelected)[0]).x, vertices.get(triangles.get(numOfTriangleSelected)[0]).y );
      vertex( vertices.get(triangles.get(numOfTriangleSelected)[1]).x, vertices.get(triangles.get(numOfTriangleSelected)[1]).y );
      vertex( vertices.get(triangles.get(numOfTriangleSelected)[2]).x, vertices.get(triangles.get(numOfTriangleSelected)[2]).y );
    endShape();
  }
  
  popMatrix();
}

void mousePressed()
{
  float mouseXAfterTransformation = mouseX / scaleForView - transformationForViewX;
  float mouseYAfterTransformation = mouseY / scaleForView - transformationForViewY;

  int newColorSelected = ifIntheColor(mouseX, mouseY);
  
  if( indexOfVertex == 0 )  // while not drawing anything
  {
    if ( newColorSelected != -1 )         // selecting a color
    {
      numOfColorSelected = newColorSelected;
      red = colors[numOfColorSelected][0];
      green = colors[numOfColorSelected][1];
      blue = colors[numOfColorSelected][2];
    }
    else                            // selecting a triangle OR a vertex or nothing.
    {    
      int inTriangle = isInTriangle( mouseXAfterTransformation, mouseYAfterTransformation );
      int inVertex = ifCloseToVertex( mouseXAfterTransformation, mouseYAfterTransformation );
      
      if( inTriangle != -1 )  // in triangle
      {
        numOfTriangleSelected = inTriangle;
        numOfVertexSelected = -1;
      }
      else if( inVertex != -1 )    // close to a vertex
      {     
        numOfVertexSelected = inVertex;
        numOfTriangleSelected = -1; 
        
        if( indexOfVertex == 0 )                     // This is the 1st vertex of a triangle
        {
          containerForTriangle[0] = numOfVertexSelected;   
          indexOfVertex = 1;
        }
        else                                        // This is the 2nd or 3rd vertex of a triangle
        {
          if( indexOfVertex == 1 )                    // This is the 2nd vertex
          {
            containerForTriangle[1] = numOfVertexSelected;
            indexOfVertex = 2;
          }
          else                                        // This is the 3rd vertex
          {
            if ( !(numOfVertexSelected == containerForTriangle[0] && numOfVertexSelected == containerForTriangle[1]) )
            {
              containerForTriangle[2] = numOfVertexSelected;
              float[] newColor = { red, green, blue };
              colourForTriangles.add(newColor);
              triangles.add(containerForTriangle.clone());
              indexOfVertex = 0;
            }
          }       
        }
      }
      else                                           // click on empty area
      {
          numOfTriangleSelected = -1;
          numOfVertexSelected = -1;
          
          PVector newVertice = new PVector();
          PVector newVertice2 = new PVector();
          newVertice.set(mouseXAfterTransformation, mouseYAfterTransformation);
          newVertice2.set(mouseXAfterTransformation, mouseYAfterTransformation);
          vertices.add( newVertice.copy() ); 
          originalVertices.add( newVertice2.copy() ); 
          
          if( indexOfVertex == 0 )
          {
            containerForTriangle[0] = vertices.size()-1;
            indexOfVertex = 1;
          }
          else
          {
            if( indexOfVertex == 1 )
            {
              containerForTriangle[1] = vertices.size()-1;         
              indexOfVertex = 2;
            }
            else
            {
                containerForTriangle[2] = vertices.size()-1;
                float[] newColor = { red, green, blue };
                colourForTriangles.add(newColor);
                triangles.add(containerForTriangle.clone());
                indexOfVertex = 0;
            }      
          }    
      }  
    } // if
  }
  else                              //while drawing a triangle
  {
    int indexOfVertexClosed = -1;
    if( (indexOfVertexClosed = ifCloseToVertex( mouseXAfterTransformation, mouseYAfterTransformation )) != -1 )    // close to a vertex
    {     
      numOfTriangleSelected = -1;
      
      if( indexOfVertex == 0 )                     // This is the 1st vertex of a triangle
      {
          containerForTriangle[0] = indexOfVertexClosed;        
          indexOfVertex = 1;
      }
      else                                        // This is the 2nd or 3rd vertex of a triangle
      {
        if( indexOfVertex == 1 )                    // This is the 2nd vertex
        {
          if ( indexOfVertexClosed != containerForTriangle[0] )
          {
            containerForTriangle[1] = indexOfVertexClosed;
            indexOfVertex = 2;
          }
        }
        else                                        // This is the 3rd vertex
        {
            containerForTriangle[2] = indexOfVertexClosed;
            float[] newColor = { red, green, blue };
            colourForTriangles.add(newColor);
            triangles.add(containerForTriangle.clone());
            indexOfVertex = 0;
        }       
      }
    }
    else                                           // click on empty area or in a triangle
    {
      numOfTriangleSelected = -1;
      numOfVertexSelected = -1;
      
      PVector newVertice = new PVector();
      PVector newVertice2 = new PVector();
      newVertice.set(mouseXAfterTransformation, mouseYAfterTransformation);
      newVertice2.set(mouseXAfterTransformation, mouseYAfterTransformation);
      vertices.add( newVertice.copy() ); 
      originalVertices.add( newVertice2.copy() ); 
    
      if( indexOfVertex == 0 )
      {
        containerForTriangle[0] = vertices.size()-1;
        indexOfVertex = 1;
      }
      else
      {
        if( indexOfVertex == 1 )
        {
          containerForTriangle[1] = vertices.size()-1;
          indexOfVertex = 2;
        }
        else
        {
            containerForTriangle[2] = vertices.size()-1;
            float[] newColor = { red, green, blue };
            colourForTriangles.add(newColor);
            triangles.add(containerForTriangle.clone());
            indexOfVertex = 0;
        }      
      }      
    }
  }
}

int ifIntheColor( float x, float y )
{
  boolean isIn = false;
  int indexOfColor = 0;
  while( !isIn && indexOfColor < 10)
  {   
    if( indexOfColor * widthOfColor < x && x < ( indexOfColor + 1 ) * widthOfColor && (height-30) < y && y < height )
    {
      isIn = true;
    }
    else
    {
      indexOfColor++;
    }
  }
  
  if( isIn )
  {
    return indexOfColor;
  }
  else
  {
    return -1;
  }
}

int ifCloseToVertex( float x, float y )
{
  boolean isClose = false;
  int indexOfVertex = 0;
  
  while( !isClose && indexOfVertex < vertices.size() )
  {
    if( dist( x, y, vertices.get(indexOfVertex).x, vertices.get(indexOfVertex).y ) <= 7 )
    {
      isClose = true;
    }     
    else
    {     
      indexOfVertex++;
    }
  }
  
  if( isClose )
  {
    return indexOfVertex;
  }
  else
  {
    return -1;
  }
}

ArrayList<Integer> isInBound(float x, float y)
{
  ArrayList<Integer> list = new ArrayList<Integer>();
    
  for(int i = 0; i < triangles.size(); i++ )
  {
    float minX = min( vertices.get(triangles.get(i)[0]).x, vertices.get(triangles.get(i)[1]).x, vertices.get(triangles.get(i)[2]).x );
    float minY = min( vertices.get(triangles.get(i)[0]).y, vertices.get(triangles.get(i)[1]).y, vertices.get(triangles.get(i)[2]).y );
    float maxX = max( vertices.get(triangles.get(i)[0]).x, vertices.get(triangles.get(i)[1]).x, vertices.get(triangles.get(i)[2]).x );
    float maxY = max( vertices.get(triangles.get(i)[0]).y, vertices.get(triangles.get(i)[1]).y, vertices.get(triangles.get(i)[2]).y );
    
    if( minX <= x && x <= maxX && minY <= y && y <= maxY )
    {
      list.add(i);
    }
  }
  return list;
}


int isInTriangle(float x, float y)
{  
  ArrayList<Integer> inBoundOfWhichTriangle = isInBound (x, y); 
  int index = inBoundOfWhichTriangle.size()-1;
  
  while( index >= 0 )
  {
    PVector one = new PVector();
      one.set( vertices.get( triangles.get(inBoundOfWhichTriangle.get(index))[0]).x, vertices.get( triangles.get(inBoundOfWhichTriangle.get(index))[0]).y );
    PVector two = new PVector();
      two.set( vertices.get(triangles.get(inBoundOfWhichTriangle.get(index))[1]).x, vertices.get(triangles.get(inBoundOfWhichTriangle.get(index))[1]).y );
    PVector three = new PVector();
      three.set( vertices.get(triangles.get(inBoundOfWhichTriangle.get(index))[2]).x, vertices.get(triangles.get(inBoundOfWhichTriangle.get(index))[2]).y );
    
    PVector pointTobeChecked = new PVector();
    pointTobeChecked.set( x, y );
    
    PVector e1 = new PVector();
    e1.set( two.x - one.x, two.y - one.y);
    
    PVector e2 = new PVector();
    e2.set( three.x - two.x, three.y - two.y);
  
    PVector e3 = new PVector();
    e3.set( one.x - three.x, one.y - three.y);
  
    PVector a1 = new PVector();
    a1.set( pointTobeChecked.x - one.x, pointTobeChecked.y - one.y );
    
    PVector a2 = new PVector();
    a2.set( pointTobeChecked.x - two.x, pointTobeChecked.y - two.y );
  
    PVector a3 = new PVector();
    a3.set( pointTobeChecked.x - three.x, pointTobeChecked.y - three.y );
    
    float crossProduct1 = e1.x * a1.y - a1.x * e1.y;
    float crossProduct2 = e2.x * a2.y - a2.x * e2.y;
    float crossProduct3 = e3.x * a3.y - a3.x * e3.y;
    
    if( ( crossProduct1 > 0 && crossProduct2 > 0 && crossProduct3 > 0 ) || ( crossProduct1 < 0 && crossProduct2 < 0 && crossProduct3 < 0 ))  // in the triangle
    {
      return inBoundOfWhichTriangle.get(index);      // in
    }
    
    index--;
  }
  return -1;
}

void mouseDragged() 
{
  float mouseXAfterTransformation = mouseX / scaleForView - transformationForViewX;
  float mouseYAfterTransformation = mouseY / scaleForView - transformationForViewY;
  
  float pmouseXAfterTransformation = pmouseX / scaleForView - transformationForViewX;
  float pmouseYAfterTransformation = pmouseY / scaleForView - transformationForViewY;
  
  if ( indexOfVertex == 0 && numOfTriangleSelected != -1 )    // not drawing
  {
      vertices.get(triangles.get(numOfTriangleSelected)[0]).x += mouseXAfterTransformation - pmouseXAfterTransformation;
      vertices.get(triangles.get(numOfTriangleSelected)[1]).x += mouseXAfterTransformation - pmouseXAfterTransformation;
      vertices.get(triangles.get(numOfTriangleSelected)[2]).x += mouseXAfterTransformation - pmouseXAfterTransformation;
      
      vertices.get(triangles.get(numOfTriangleSelected)[0]).y += mouseYAfterTransformation - pmouseYAfterTransformation;
      vertices.get(triangles.get(numOfTriangleSelected)[1]).y += mouseYAfterTransformation - pmouseYAfterTransformation;
      vertices.get(triangles.get(numOfTriangleSelected)[2]).y += mouseYAfterTransformation - pmouseYAfterTransformation;    
  }  
  else if( ( indexOfVertex == 1 || indexOfVertex == 0 ) && numOfVertexSelected != -1)   // there is selected vertex.
  {
    vertices.get(numOfVertexSelected).x += mouseXAfterTransformation - pmouseXAfterTransformation;
    vertices.get(numOfVertexSelected).y += mouseYAfterTransformation - pmouseYAfterTransformation;
    indexOfVertex = 0;
  }
}

void keyPressed()
{
  if( key == 'w' )
  {
    if( numOfTriangleSelected == -1 )    // translate the view
    {
      transformationForViewY += -1;
    }
    else                                 // translate the selected triangle
    {
      vertices.get(triangles.get(numOfTriangleSelected)[0]).y += -1;
      vertices.get(triangles.get(numOfTriangleSelected)[1]).y += -1;
      vertices.get(triangles.get(numOfTriangleSelected)[2]).y += -1;
    }
  }
  else if ( key == 'a' )
  {
    if( numOfTriangleSelected == -1 )
    {
      transformationForViewX += -1;
    }
    else
    {
      vertices.get(triangles.get(numOfTriangleSelected)[0]).x += -1;
      vertices.get(triangles.get(numOfTriangleSelected)[1]).x += -1;
      vertices.get(triangles.get(numOfTriangleSelected)[2]).x += -1;
    }
  }
  else if ( key == 's' )
  {
    if( numOfTriangleSelected == -1 )
    {
      transformationForViewY += 1;
    }
    else
    {
      vertices.get(triangles.get(numOfTriangleSelected)[0]).y += 1;
      vertices.get(triangles.get(numOfTriangleSelected)[1]).y += 1;
      vertices.get(triangles.get(numOfTriangleSelected)[2]).y += 1;
    }
  }
  else if ( key == 'd' )
  {
    if( numOfTriangleSelected == -1 )
    {
      transformationForViewX += 1;
    }
    else
    {
      vertices.get(triangles.get(numOfTriangleSelected)[0]).x += 1;
      vertices.get(triangles.get(numOfTriangleSelected)[1]).x += 1;
      vertices.get(triangles.get(numOfTriangleSelected)[2]).x += 1;
    }
  }
  else if ( key == 'c' )
  {
    if( numOfTriangleSelected == -1 )
    {
      scaleForView += 0.1;
    }
    else
    {
      float[] center = calculateCenter( vertices.get(triangles.get(numOfTriangleSelected)[0]), 
                                        vertices.get(triangles.get(numOfTriangleSelected)[1]),
                                        vertices.get(triangles.get(numOfTriangleSelected)[2]) );
                                        
      float offsetX = center[0] - origin[0];    
      float offsetY = center[1] - origin[1]; 
      
      vertices.get(triangles.get(numOfTriangleSelected)[0]).x = (vertices.get(triangles.get(numOfTriangleSelected)[0]).x - offsetX - origin[0]) * 1.1 + origin[0] + offsetX;
      vertices.get(triangles.get(numOfTriangleSelected)[0]).y = (vertices.get(triangles.get(numOfTriangleSelected)[0]).y - offsetY - origin[1]) * 1.1 + origin[1] + offsetY;
      
      vertices.get(triangles.get(numOfTriangleSelected)[1]).x = (vertices.get(triangles.get(numOfTriangleSelected)[1]).x - offsetX - origin[0]) * 1.1 + origin[0] + offsetX;
      vertices.get(triangles.get(numOfTriangleSelected)[1]).y = (vertices.get(triangles.get(numOfTriangleSelected)[1]).y - offsetY - origin[1]) * 1.1 + origin[1]+ offsetY;
      
      vertices.get(triangles.get(numOfTriangleSelected)[2]).x = (vertices.get(triangles.get(numOfTriangleSelected)[2]).x - offsetX - origin[0]) * 1.1 + origin[0] + offsetX;
      vertices.get(triangles.get(numOfTriangleSelected)[2]).y = (vertices.get(triangles.get(numOfTriangleSelected)[2]).y - offsetY - origin[1]) * 1.1 + origin[1] + offsetY;
    }
  }
  else if ( key == 'v' )
  {
    if( numOfTriangleSelected == -1 )
    {
      scaleForView -= 0.1;
    }
    else
    {
      float[] center = calculateCenter( vertices.get(triangles.get(numOfTriangleSelected)[0]), 
                                        vertices.get(triangles.get(numOfTriangleSelected)[1]),
                                        vertices.get(triangles.get(numOfTriangleSelected)[2]) );
                                        
      float offsetX = center[0] - origin[0];    
      float offsetY = center[1] - origin[1]; 
      
      vertices.get(triangles.get(numOfTriangleSelected)[0]).x = (vertices.get(triangles.get(numOfTriangleSelected)[0]).x - offsetX - origin[0]) * 0.9 + origin[0] + offsetX;
      vertices.get(triangles.get(numOfTriangleSelected)[0]).y = (vertices.get(triangles.get(numOfTriangleSelected)[0]).y - offsetY - origin[1]) * 0.9 + origin[1] + offsetY;
      
      vertices.get(triangles.get(numOfTriangleSelected)[1]).x = (vertices.get(triangles.get(numOfTriangleSelected)[1]).x - offsetX - origin[0]) * 0.9 + origin[0] + offsetX;
      vertices.get(triangles.get(numOfTriangleSelected)[1]).y = (vertices.get(triangles.get(numOfTriangleSelected)[1]).y - offsetY - origin[1]) * 0.9 + origin[1] + offsetY;
      
      vertices.get(triangles.get(numOfTriangleSelected)[2]).x = (vertices.get(triangles.get(numOfTriangleSelected)[2]).x - offsetX - origin[0]) * 0.9 + origin[0] + offsetX;
      vertices.get(triangles.get(numOfTriangleSelected)[2]).y = (vertices.get(triangles.get(numOfTriangleSelected)[2]).y - offsetY - origin[1]) * 0.9 + origin[1] + offsetY;
    }
  }
  else if ( key == 'z' )
  {
    if( numOfTriangleSelected == -1 )
    {
      scaleForView = 1;
    }
  }
  else if ( key == 'e' )
  {
    if( numOfTriangleSelected != -1 )
    {
      float[] center = calculateCenter( vertices.get(triangles.get(numOfTriangleSelected)[0]), 
                                        vertices.get(triangles.get(numOfTriangleSelected)[1]),
                                        vertices.get(triangles.get(numOfTriangleSelected)[2]) );
                                        
      float offsetX = center[0] - origin[0];    
      float offsetY = center[1] - origin[1]; 
      cos(radians(-3.75));
      sin(radians(-3.75));
      vertices.get(triangles.get(numOfTriangleSelected)[0]).x = (vertices.get(triangles.get(numOfTriangleSelected)[0]).x - offsetX - origin[0]) * cos(radians(-3.75)) - 
                                                                (vertices.get(triangles.get(numOfTriangleSelected)[0]).y - offsetY - origin[1]) * sin(radians(-3.75))
                                                                + origin[0] + offsetX;
                                                                
      vertices.get(triangles.get(numOfTriangleSelected)[0]).y = (vertices.get(triangles.get(numOfTriangleSelected)[0]).x - offsetX - origin[0]) * sin(radians(-3.75)) + 
                                                                (vertices.get(triangles.get(numOfTriangleSelected)[0]).y - offsetY - origin[1]) * cos(radians(-3.75))
                                                                + origin[1] + offsetY;
      
      vertices.get(triangles.get(numOfTriangleSelected)[1]).x = (vertices.get(triangles.get(numOfTriangleSelected)[1]).x - offsetX - origin[0]) * cos(radians(-3.75)) - 
                                                                (vertices.get(triangles.get(numOfTriangleSelected)[1]).y - offsetY - origin[1]) * sin(radians(-3.75))
                                                                + origin[0] + offsetX;
                                                                
      vertices.get(triangles.get(numOfTriangleSelected)[1]).y = (vertices.get(triangles.get(numOfTriangleSelected)[1]).x - offsetX - origin[0]) * sin(radians(-3.75)) + 
                                                                (vertices.get(triangles.get(numOfTriangleSelected)[1]).y - offsetY - origin[1]) * cos(radians(-3.75))
                                                                + origin[1] + offsetY;
      
      vertices.get(triangles.get(numOfTriangleSelected)[2]).x = (vertices.get(triangles.get(numOfTriangleSelected)[2]).x - offsetX - origin[0]) * cos(radians(-3.75)) - 
                                                                (vertices.get(triangles.get(numOfTriangleSelected)[2]).y - offsetY - origin[1]) * sin(radians(-3.75))
                                                                + origin[0] + offsetX;
                                                                
      vertices.get(triangles.get(numOfTriangleSelected)[2]).y = (vertices.get(triangles.get(numOfTriangleSelected)[2]).x - offsetX - origin[0]) * sin(radians(-3.75)) + 
                                                                (vertices.get(triangles.get(numOfTriangleSelected)[2]).y - offsetY - origin[1]) * cos(radians(-3.75))
                                                                + origin[1] + offsetY;
    }
  }
  else if ( key == 'r' )
  {
    if( numOfTriangleSelected != -1 )
    {
      float[] center = calculateCenter( vertices.get(triangles.get(numOfTriangleSelected)[0]), 
                                        vertices.get(triangles.get(numOfTriangleSelected)[1]),
                                        vertices.get(triangles.get(numOfTriangleSelected)[2]) );
                                        
      float offsetX = center[0] - origin[0];    
      float offsetY = center[1] - origin[1]; 
      cos(radians(-3.75));
      sin(radians(-3.75));
      vertices.get(triangles.get(numOfTriangleSelected)[0]).x = (vertices.get(triangles.get(numOfTriangleSelected)[0]).x - offsetX - origin[0]) * cos(radians(3.75)) - 
                                                                (vertices.get(triangles.get(numOfTriangleSelected)[0]).y - offsetY - origin[1]) * sin(radians(3.75))
                                                                + origin[0] + offsetX;
                                                                
      vertices.get(triangles.get(numOfTriangleSelected)[0]).y = (vertices.get(triangles.get(numOfTriangleSelected)[0]).x - offsetX - origin[0]) * sin(radians(3.75)) + 
                                                                (vertices.get(triangles.get(numOfTriangleSelected)[0]).y - offsetY - origin[1]) * cos(radians(3.75))
                                                                + origin[1] + offsetY;
      
      vertices.get(triangles.get(numOfTriangleSelected)[1]).x = (vertices.get(triangles.get(numOfTriangleSelected)[1]).x - offsetX - origin[0]) * cos(radians(3.75)) - 
                                                                (vertices.get(triangles.get(numOfTriangleSelected)[1]).y - offsetY - origin[1]) * sin(radians(3.75))
                                                                + origin[0] + offsetX;
                                                                
      vertices.get(triangles.get(numOfTriangleSelected)[1]).y = (vertices.get(triangles.get(numOfTriangleSelected)[1]).x - offsetX - origin[0]) * sin(radians(3.75)) + 
                                                                (vertices.get(triangles.get(numOfTriangleSelected)[1]).y - offsetY - origin[1]) * cos(radians(3.75))
                                                                + origin[1] + offsetY;
      
      vertices.get(triangles.get(numOfTriangleSelected)[2]).x = (vertices.get(triangles.get(numOfTriangleSelected)[2]).x - offsetX - origin[0]) * cos(radians(3.75)) - 
                                                                (vertices.get(triangles.get(numOfTriangleSelected)[2]).y - offsetY - origin[1]) * sin(radians(3.75))
                                                                + origin[0] + offsetX;
                                                                
      vertices.get(triangles.get(numOfTriangleSelected)[2]).y = (vertices.get(triangles.get(numOfTriangleSelected)[2]).x - offsetX - origin[0]) * sin(radians(3.75)) + 
                                                                (vertices.get(triangles.get(numOfTriangleSelected)[2]).y - offsetY - origin[1]) * cos(radians(3.75))
                                                                + origin[1] + offsetY;
    }
  }
}

float[] calculateCenter(PVector one, PVector two, PVector three)
{
  float[] center = new float[2];
  
  center[0] = ( one.x + two.x + three.x ) / 3;
  center[1] = ( one.y + two.y + three.y ) / 3;
  
  return center;
}
