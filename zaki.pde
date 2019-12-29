/* @pjs preload="1.png", "2.png", "3.png"; */

//Global variables
PImage [] images = new PImage [3];
int inum = 1;
int h = 0;
int w = 0;
int pn = 10;
int score = 0;
Coordinates pellets;
Coordinates [] fxy = pelletCoordinates( pn);    //An array which stores random positions for the pellets
PFont myFont;

void setup()
{
  size( 1200, 500);
  
  //An array which collects all the images in the folder
  for( int count = 0; count < images.length; count++)
  {
    images[count] = loadImage( inum + ".png");
    images[count].resize( width, height);
    inum++;
  }
  frameRate( 50);    //A frame rate of 50 is used so as to slower the speed of the fish than usual in order for the game to run at normal speed
}

void draw()
{
  background( images[0]);
  
  //Displaying the pellets
  for( int f = 0; f < pn; f++)
  {
    pellets = fxy [f];  
    image( images[2], pellets.getX(), pellets.getY(), 165, 165);
  }
  
  //Controls of the fish
  if( keyPressed == true)
  { 
      if (keyCode == RIGHT) 
      {
        w++;
      }
      else if (keyCode == LEFT) 
      {
        w--;
      }
      else if (keyCode == UP) 
      {
        h=h-2;
      }
  }
  
  //Displays the fish and makes sure that its swims deeper into the ocean with the passage of time
  image( images[1], w, h, 70, 60);
  h++;
  
  //Ensuring that if the fish exits the frame horizontally, it reappears at the left end of the screen at the same height
  if( w == 1198)
  {
      w = -40;
  }
  if( w == -47)
  {
    w = -44;
  }
  
  //Checking the score
  for( int check = 0; check < pn; check++)
  {
    if( abs( (w+45) - (fxy[check].getX()+82.5)) <= 15 && abs( (h+30) - (fxy[check].getY()+82.5)) <= 5)
    {
      fxy[check].setCoordinates( 1500, 1500);  
      score++;
      println( w);
      println(h);
    }
  }
  
  //Display screen which appears either when the player collects all 10 points, or when the fish drowns at the bottom of the sea
  if( score == 10 || h >= 490)
  {
    fill( 255, 0, 0, 191);
    noStroke();
    rectMode( CENTER);
    rect( width/2, height/2, 800, 400);
    //Information display
    fill( #FFFFFF);
    myFont = createFont( "Rockwell Bold Italic", 45);
    textFont( myFont);
    textAlign( CENTER);
    text( "GAME OVER", width/2, 145);
    textSize( 33);
    text( "Your Score: " + score, width/2, 225);
    textSize( 25);
    text( "Press ENTER to Restart", width/2, 340);
    text( "Press ESC to Exit", width/2, 390);
    
    if( keyPressed == true)
    {
      //If the user presses the ENTER key, the game is restarted
      if( key == ENTER)
      {
        w=0;
        h=0;
        score = 0;
        fxy = pelletCoordinates( pn);
      }
      else if( key == CODED)
      {
        //If the user presses the ESC key, the window closes
        if( keyCode == ESC)
        {
          exit();
        }
      }
    }
  }
  
  //Displaying the results and coordinates of the fish and the pellets on the console
  println( "Score: " + score);
  println();
  println( "x-coordinate of fish: " + w + " y-coordinate of fish: " + h);
  for( int t = 0; t < 10; t++)
  {
    println( fxy[t].printCoordinates());  
  }
}

//A function that returns an array of randomized coordinates for a give number of pellets
Coordinates [] pelletCoordinates( int pn)
  {
    Coordinates [] fxy = new Coordinates[pn];
    for( int f = 0; f < pn; f++)
    {
      int posX = int( random( 1100));
      int posY = int( random( 400));
      pellets = new Coordinates( posX, posY);
      fxy [f] = pellets;
    }
    return fxy;
  }

class Coordinates
{
  //Properties
  int x;
  int y;
  
  //Constructor 
  Coordinates( int fx, int fy)
  {
    x = fx;
    y = fy;
  }
  
  //Methods
  void setCoordinates( int nx, int ny)
  {
    x = nx;
    y = ny;
  }
  
  int getX()
  {
    return x;
  }
  
  int getY()
  {
    return y;
  }
  
  String printCoordinates()
  {
    return "x: " + x + "    y: " + y;   
  }
}
