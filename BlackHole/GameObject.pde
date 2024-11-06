class GameObject{
  float x; 
  float y;
  float radius;
  
  float xSpeed;
  float ySpeed;
  float acceleration;
  
  boolean isPlayer;
  boolean isFood;
  color myColor;
  
  public GameObject(float radius, color myColor)
  {
    int side = (int)random(2)*2-1;
    println(side);
    xSpeed = random(minHSpeed, maxHSpeed) * side;
    ySpeed = -random(minVSpeed, maxVSpeed);
    
    y = height + random(50, 100);
    if(side == 1)
    {
      x = -random(50 , 100);
    }
    else
    {
      x = width + random(50, 100);
    }  
    this.radius = radius;
    this.myColor = myColor;
  }
  
  void display()
  {
    if(isPlayer)
    {
      x = mouseX;
      y = mouseY;
    }
    else
    {
      move();
    }
    fill(myColor);
    circle(x,y, radius);
  } 
  
  void move()
  {
    x+=xSpeed;
    y+=ySpeed;
    ySpeed += gravity;
  }
  
  boolean Collide(GameObject other)
  {
     //To tell if two circles are inside of eachother
     //We need to first get the distance
     float xDist = other.x - x;
     float yDist = other.y - y;
     float dist = sqrt(xDist * xDist + yDist * yDist);
     //Then we need to find if the distance is smaller than the absolute subtraction of radii
     float rDiff = other.radius - radius;
     if(dist <= rDiff)
     {
       return true;
     }
     return false;
  }
}
