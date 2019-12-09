

double RealSize = 6;
double ComplexSize = 2;
double BaseReal = 6;
double BaseComplex = 3;
double YOffset;
double XOffset;
int BaseMaxIterations = 100;
int MaxIterations = 3000;
float BailOut = 15;
color[] Colors = {255, #FF0009, #00FFDB , #3D33B9, #1603FF, #FF00EF, #FF03AB, #00FFF9, #FC7200, 0
};
double ZoomAmount = .35;
double MoveAmount = .13;
int PixelSkip = 10; // 1 = no skips, 2 = every other pixel, ect..
float ColorOffset;
int AutoSetMaxIterations = 0;

class Complex
{
  double x;
  double y;
  
  public Complex(double Inx, double Iny)
  {
    x = Inx;
    y = Iny;
  }
}


int GetColor(Complex c)
{
  Complex Z  = new Complex (0, 0);
  float Col;
  int Iterations = 0;
  while ((Z.x * Z.x) + (Z.y * Z.y) < BailOut && Iterations < MaxIterations)
  {
    Z = new Complex(Z.x + c.x, Z.y + c.y);
    Z = new Complex((Z.x * Z.x) - (Z.y * Z.y), 2 * (Z.x * Z.y));
    Iterations++;
  }
  Col = (float) Iterations / (float) MaxIterations;
  if (Col == 1)
  {
    return(color(0));
  }
  else
  {
  return(color(255 - (Col * 255.0 + ColorOffset), 255, 200));
  }
}

Complex GetComplexAtPoint(int x, int y)
{
  return (new Complex(((double) x / width * RealSize - ((double)RealSize / 2)) + XOffset, ((double) y / height * ComplexSize) - ((double)ComplexSize / 2) + YOffset));
}

void setup()
{
  //size (4950, 3825);
  size (1800, 950);
  String[] Coords = loadStrings("Coords.txt");
  RealSize = Double.valueOf(Coords[0]);
  ComplexSize = Double.valueOf(Coords[1]);
  XOffset = Double.valueOf(Coords[2]);
  YOffset = Double.valueOf(Coords[3]);
  noSmooth();
  MandelDraw();
  colorMode(HSB);
}

void draw()
{
}

void keyPressed()
{
  
  if (keyCode == UP)
  {
    YOffset += RealSize * MoveAmount;
  } 
  else if (keyCode == DOWN)
  {
    YOffset -= RealSize * MoveAmount;
  } 
  else if (keyCode == LEFT)
  {
    XOffset += ComplexSize * MoveAmount;
  } 
  else if (keyCode == RIGHT)
  {
    XOffset -= ComplexSize * MoveAmount;
  } 
  else if (key == '=')
  {
    RealSize -= ZoomAmount * RealSize;
    ComplexSize = RealSize * .5;
    if (AutoSetMaxIterations == 1)
    {
    SetMaxIterations();
    }
    println ("Zoomed to : " + RealSize + " , " + ComplexSize);
  } 
  else if (key == '-')
  {
    RealSize += ZoomAmount * RealSize;
    ComplexSize = RealSize * .5;
    if (AutoSetMaxIterations == 1)
    {
    SetMaxIterations();
    }
    println ("Zoomed to : " + RealSize + " , " + ComplexSize);
  } 
  else if(key == 'r')
  {
    RealSize = BaseReal;
    ComplexSize = BaseComplex;
    YOffset = 0;
    XOffset = 0;
  }
  else if(key == 'l')
  {
    PixelSkip = 18;
  }
  else if (key == 'h')
  {
    PixelSkip = 1;
  }
  else if(key == 'o')
  {
    ColorOffset++;
    println(ColorOffset);
  }
  else if (key == 's')
  {
    save("Output.png"); 
  }
  else
  {
    return;
  }
  String[] FileStrings = {String.valueOf(RealSize), String.valueOf(ComplexSize), String.valueOf(XOffset), String.valueOf(YOffset)};
  saveStrings("Coords.txt", FileStrings);
  MandelDraw();
  
}

void MandelDraw()
{
  clear();
  background(color(255));
  println("Starting Draw");
  for (int x = 0; x < width; x-=-1)
  {
    if (x % PixelSkip == 0)
    {
      for (int y = 0; y < height; y-=-1)
      {
        if (y % PixelSkip == 0)
        {
          rectMode(CENTER);
          noStroke();
          fill(GetColor(GetComplexAtPoint(x, y)));
          rect(x, y, PixelSkip, PixelSkip);
        }
        //println((float)(x * height) / (width * height));
      }
    }
  }
  println("Finished");
}

void SetMaxIterations()
{
  MaxIterations = (int)((double)((BaseReal * BaseReal) + (BaseComplex * BaseComplex)) / ((RealSize * RealSize) + (ComplexSize * ComplexSize)) * BaseMaxIterations);
}
