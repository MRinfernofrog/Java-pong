/**
 * Noise1D.
 *
 * Using 1D Perlin Noise to assign location.
 */
float xs = 10.0;
float ys = 10.0; //5
float g = 1;
int r = 32;
float py;
float px;
float bot;
float botSpeed = 9; //4.5
float y = 50;
float x = r;
int scaleX = 2000 ;
int scaleY = 1200 ;
int left;
int right;
int timerDuration = 1000; // Time to wait in milliseconds (1 seconds)
int nextExecutionTime = 0;
int here = 255;
PImage winPhoto;
PImage losePhoto;
int state;

void setup() {
  int scaleX = 2560 / 2 ;
  int scaleY = 1440 /2 ;
  println(scaleX, scaleY);
  size(2000, 1200);
  background(35);
  noStroke();
  winPhoto = loadImage("1.png");
  losePhoto = loadImage("2.png");
}

void draw() {
  background(66);

  if (state !=0) {
    if (state == 1) {
      win();
    } else {
      lose();
    }
  }
  // Create an alpha blended background
  if (x + y >= px + py + 30) {
    int c = int(random(0, 255));
    int b = int(random(0, 255));
    int f = int(random(0, 255));
    fill(c, f, b, here);
  }
  String s = str(left) + '-' + str(right);
  fill(25, 255, 0, here);
  textSize(62);
  textAlign(CENTER, CENTER);
  text(s, width/2, 100);

  fill(0, 200, 0, here) ;
  rectMode(CENTER);
  rect(scaleX/6, mouseY, 60, 150);

  bot += y >= bot ? botSpeed : -botSpeed;

  rectMode(CENTER);
  rect((width/6)*5, bot, 60, 150);
  ellipse(x, y, r*2, r*2);
 // y += py;
 // x += px;
  y += ys;
  //ys += g;
  x += xs;
  if (y >= height - r || y <= r) {
    ys = -ys;
  }
  //  if (x >= width - r || x <= r) {
  //  }
  if (x >= width - r || x <= r) {
    if (x <= r) {
      right++;
    } else {
      left++;
    }
    if (left >= 3 || right >= 3) {
      if (left >= 3) {
        win();
      } else {
        lose();
      }
    }
    x = (width/2);
    y = height/3;
  }
  if (x <= scaleX/6 + 30 && x >= scaleX/6 - 30) {
    if (y >= mouseY - 75 && y <= mouseY + 75 ) {
      hit();
    }
  }
  if (x <= (scaleX/6)*5 + 30 && x >= (scaleX/6)*5 - 30) {
    if (y >= bot - 75 && y <= bot + 75 ) {
      hit();
    }
  }
}

void win() {
  here = 0;
  image(winPhoto, width/2 - (740/2), 0);
  textSize(120);
  fill(0, 255, 0);
  textMode(CENTER);
  textAlign(CENTER, CENTER);
  text("YOU WIN!!!", width/2, height/2 );
  state = 1;
}

void lose() {
  here = 0;
  textSize(120);
  fill(255, 0, 0);
  image(losePhoto, width/2 - 540, 0);
  textMode(CENTER);
  textAlign(CENTER, CENTER);
  text("You lost!", width/2, height/2 );
  //nextExecutionTime = millis() + timerDuration;
  state = 2;
  // if (millis() >= nextExecutionTime) {
  //   xs = -xs;
  // }

  //delay(90000);
}
void hit() {
  if (millis() >= nextExecutionTime) {
    xs = -xs;
  }
  nextExecutionTime = millis() + timerDuration;
}

void keyPressed() {
    if (millis() >= nextExecutionTime) {
      if (key == 'q' || key == 'Q') {
        xs += (xs > 0) ? 1 : -1 ;
        ys += (ys > 0) ? 1 : -1 ;
      }
      if (key == 'a' || key == 'A') {
        xs -= (xs > 0) ? 1 : -1 ;
        ys -= (ys > 0) ? 1 : -1 ;
      }
      if (key == 'd' || key == 'D') {
        botSpeed--;
      }
      if (key == 'e' || key == 'E') {
        botSpeed++;
      }
      if (key == 'x' || key == 'X') {
        right++;
      }
      if (key == 'z' || key == 'Z') {
        left++;
      }
      if (key == 'r' || key == 'R') {
        state =0;
        ys = xs = 10;
        here = 255;
        bot = height/2;
        botSpeed = 9;
        x = (width/2);
        y = height/3;
        left = 0;
        right = 0;
      }
      nextExecutionTime = millis() + 200;
    }
  }
