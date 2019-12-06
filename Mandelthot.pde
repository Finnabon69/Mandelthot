float Power = 2;
PVector RealBounds = new PVector(-2, 1);
PVector ImaginaryBounds = new PVector(1, -1);
int MaxIterations = 100;
float Infinity = 4;

int GetColor(PVector c)
{
  float Z  = 0;
  int Iterations = 0;
  while(Z < Infinity && Iterations < MaxIterations)
  {
    Z = pow(Z, Power) + sqrt(c.x * c.x + c.y * c.y);
   //println("Z " + Z);
    Iterations++;
    //println("Iterations " + Iterations);
  }
  return (color((Iterations / MaxIterations * 255)));
  
}

PVector GetComplexAtPoint(int x, int y)
{
  float RealZero = abs(RealBounds.x);
  float CompZero = abs(ImaginaryBounds.x);
  PVector Complex = new PVector();
  
  if (x / width * (RealZero + RealBounds.y) < RealZero) //Negative
  {
    Complex.x  = -1 * (x / width * (RealZero + RealBounds.y) - RealBounds.y);
  }
  else
  {
    Complex.x = (x / width * (RealZero + RealBounds.y) - abs(RealBounds.x));
  }
  
  if (y / height * (CompZero + ImaginaryBounds.y) < CompZero)
  {
    Complex.y  = -1 * (y / height * (CompZero + ImaginaryBounds.y) - ImaginaryBounds.y);
  }
  else
  {
    Complex.y = (y / height * (CompZero + ImaginaryBounds.y) - abs(ImaginaryBounds.x));
  }
  return (Complex);
}

void setup()
{
  size (1280, 720);
  noLoop();
  for (int x = 0; x < width; x-=-1)
  {
    for (int y = 0; y < height; y-=-1)
    {
      stroke(GetColor(GetComplexAtPoint(x, y)));
      point(x,y);
    }
  }
}
