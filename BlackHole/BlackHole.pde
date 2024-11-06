GameObject player;
ArrayList<GameObject> objects = new ArrayList<GameObject>();
float spawnTime;
int score = 0;
boolean isGameOver = false;
float health;

void setup()
{
  size(800, 800);
  ResetGame();
  textAlign(CENTER);
}

void draw()
{
  background(0);
  
  fill(120, 0, 0);
  rect(10, 10, (width-20) * (health/maxHealth), 20);
  fill(255);
  textSize(32);
  text(score, width/2, 32);
  
  if (isGameOver)
  {
    textSize(64);
    text("Game Over!\nPress to play again!", width/2, height/2);
    return;
  }
  
  SpawnObject();

  player.display();
  for (int i = objects.size()-1; i >= 0; --i)
  {
    GameObject current = objects.get(i);
    current.display();

    if (current.Collide(player))
    {
      //Reduce the radius;
      current.radius -= 1;
      //Reduce the speed
      current.xSpeed /= speedLoss;
      current.ySpeed /= speedLoss;
      if (current.isFood)
      {
        score += 1;
      } else
      {
        health -= 1;
        if (health <= 0)
        {
          isGameOver = true;
        }
      }
      if (current.radius <= 0)
      {
        objects.remove(i);
      }
    } else if (current.y > height + 200)
    {
      objects.remove(i);
    }
  }
}

void mousePressed() {
  if (isGameOver)
  {
    ResetGame();
  }
}

void SpawnObject()
{
  spawnTime-=1;
  if (spawnTime > 0)
  {
    return;
  }
  spawnTime = random(minSpawnTime, maxSpawnTime);

  float type = random(1);
  //Good
  GameObject temp;
  float size = random(minFoodSize, player.radius-10);
  if (type < 0.7f)
  {
    temp = new GameObject(size, color(0, 255, 0));
    temp.isFood = true;
  }
  //Bad 
  else
  {
    temp = new GameObject(size, color(255, 0, 0));
    temp.isFood = false;
  }
  objects.add(temp);
}

void ResetGame()
{
  player = new GameObject(startSize, color(255));
  player.isPlayer = true;
  isGameOver = false;
  score = 0; 
  health = maxHealth;
  objects.clear();
}
