float Power = 2;
PVector RealBounds = new PVector(-2, 2);
PVector ImaginaryBounds = new PVector(-1, 1);
int MaxIterations = 100;
float Infinity = 2;

int GetColor(PVector c)
{
  PVector Z  = new PVector (0,0);
  float Col;
  int Iterations = 0;
  while(sqrt(Z.x * Z.x + Z.y * Z.y) < Infinity && Iterations < MaxIterations)
  {
    //Z.x = pow(Z.x, (float)Power) + sqrt((c.x * c.x) + (c.y * c.y));
    Z = new PVector(pow(Z.x, Power) + c.x, pow(Z.y, Power) + c.y);
    //println("Z " + Z);
    Iterations++;
    //println(Iterations);
    //delay(2);
  }
  Col = (float) Iterations / (float) MaxIterations;
  //println(Col);
  return (color(255 - (Col * 255)));
  
}

PVector GetComplexAtPoint(int x, int y)
{
  float RealZero = abs(RealBounds.x);
  float CompZero = abs(ImaginaryBounds.x);
  PVector Complex = new PVector();
  
  
  /*
  if (x / width * (RealZero + RealBounds.y) < RealZero) //Negative
  {
    Complex.x  = -1 * ((float) x / width * (RealZero + RealBounds.y) - RealBounds.y);
  }
  else
  {
    Complex.x = ((float )x / width * (RealZero + RealBounds.y) - abs(RealBounds.x));
  }
  
  if (y / height * (CompZero + ImaginaryBounds.y) > CompZero)
  {
    Complex.y  = -1 * ((float) y / height * (CompZero + ImaginaryBounds.y) - ImaginaryBounds.y);
  }
  else
  {
    Complex.y = ((float) y / height * (CompZero + ImaginaryBounds.y) - abs(ImaginaryBounds.x));
  }
  */
  //println(Complex);
  return (Complex);
}

void setup()
{
  size (1280, 720);
  noLoop();
  background(GetColor(new PVector(-1, 0.0)));
  //println(GetColor(new PVector(-1, 0)));
  
  /*
  for (int x = 0; x < width; x-=-1)
  {
    for (int y = 0; y < height; y-=-1)
    {
      stroke(GetColor(GetComplexAtPoint(x, y)));
      point(x,y);
    }
    
  }
  //*/
}
