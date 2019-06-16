PFont myFontHead;
PFont myFontBody;

boolean mouseEvent = false;
boolean editingMode = false;
int time=500;
int alpha=120;

int botX=0;
int botY=0;
int botDir=0;

int goalCenterX=14;
int goalCenterY=14;
int botCenterX=0;
int botCenterY=0;

int botHeight=20;
int botWidth=20;

int[][] gCostArray=new int[29][29];
int[][] hCostArray=new int[29][29];
int[][] fCostArray=new int[29][29];
int[][] cellStateArray=new int[29][29];

char[][] maze=new char[29][29];
char[][] maze_temp={
  //  0    1    2    3    4
  {'#', '-', '#', '-', '#', '-', '#', '-', '#', '-', '#', '-', '#', '-', '#', '-', '#', '-', '#', '-', '#', '-', '#', '-', '#', '-', '#', '-', '#'}, 
  {'-', ' ', ' ', ' ', ' ', ' ', ' ', ' ', '-', ' ', ' ', ' ', ' ', ' ', ' ', ' ', '-', ' ', '-', ' ', ' ', ' ', '-', ' ', ' ', ' ', ' ', ' ', '-'}, 
  {'#', '-', '#', ' ', '#', '-', '#', '-', '#', '-', '#', ' ', '#', '-', '#', ' ', '#', ' ', '#', '-', '#', ' ', '#', ' ', '#', '-', '#', '-', '#'}, 
  {'-', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', '-', ' ', ' ', ' ', '-', ' ', '-', ' ', '-', ' ', ' ', ' ', '-', ' ', ' ', ' ', ' ', ' ', '-'}, 
  {'#', ' ', '#', '-', '#', '-', '#', '-', '#', ' ', '#', '-', '#', ' ', '#', ' ', '#', ' ', '#', '-', '#', ' ', '#', '-', '#', '-', '#', ' ', '#'}, 
  {'-', ' ', '-', ' ', ' ', ' ', ' ', ' ', '-', ' ', ' ', ' ', ' ', ' ', '-', ' ', ' ', ' ', '-', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', '-'}, 
  {'#', ' ', '#', ' ', '#', '-', '#', ' ', '#', '-', '#', '-', '#', ' ', '#', ' ', '#', '-', '#', '-', '#', ' ', '#', '-', '#', '-', '#', '-', '#'}, 
  {'-', ' ', '-', ' ', ' ', ' ', '-', ' ', '-', ' ', ' ', ' ', ' ', ' ', '-', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', '-', ' ', ' ', ' ', '-'}, 
  {'#', ' ', '#', '-', '#', '-', '#', ' ', '#', '-', '#', ' ', '#', ' ', '#', '-', '#', '-', '#', '-', '#', '-', '#', ' ', '#', ' ', '#', '-', '#'}, 
  {'-', ' ', '-', ' ', ' ', ' ', ' ', ' ', '-', ' ', '-', ' ', '-', ' ', ' ', ' ', ' ', ' ', '-', ' ', ' ', ' ', '-', ' ', '-', ' ', ' ', ' ', '-'}, 
  {'#', ' ', '#', ' ', '#', ' ', '#', '-', '#', ' ', '#', ' ', '#', '-', '#', '-', '#', '-', '#', ' ', '#', '-', '#', ' ', '#', '-', '#', ' ', '#'}, 
  {'-', ' ', ' ', ' ', '-', ' ', '-', ' ', ' ', ' ', '-', ' ', '-', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', '-'}, 
  {'#', '-', '#', '-', '#', ' ', '#', '-', '#', ' ', '#', '-', '#', '|', '#', '|', '#', '-', '#', ' ', '#', '-', '#', '-', '#', '-', '#', '-', '#'}, 
  {'-', ' ', ' ', ' ', ' ', ' ', '-', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', '|', ' ', '-', ' ', '-', ' ', ' ', ' ', ' ', ' ', ' ', ' ', '-'}, 
  {'#', ' ', '#', ' ', '#', ' ', '#', '-', '#', ' ', '#', ' ', '#', ' ', '#', ' ', '#', ' ', '#', ' ', '#', '-', '#', '-', '#', ' ', '#', '-', '#'}, 
  {'-', ' ', '-', ' ', '-', ' ', ' ', ' ', '-', ' ', '-', ' ', '|', ' ', ' ', ' ', '|', ' ', '-', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', '-'}, 
  {'#', ' ', '#', ' ', '#', '-', '#', '-', '#', ' ', '#', ' ', '#', '|', '#', '|', '#', ' ', '#', ' ', '#', '-', '#', ' ', '#', '-', '#', '-', '#'}, 
  {'-', ' ', '-', ' ', ' ', ' ', '-', ' ', ' ', ' ', '-', ' ', ' ', ' ', ' ', ' ', '-', ' ', ' ', ' ', '-', ' ', ' ', ' ', '-', ' ', ' ', ' ', '-'}, 
  {'#', '-', '#', ' ', '#', '-', '#', ' ', '#', ' ', '#', '-', '#', '-', '#', ' ', '#', '-', '#', '-', '#', ' ', '#', '-', '#', ' ', '#', ' ', '#'}, 
  {'-', ' ', ' ', ' ', '-', ' ', ' ', ' ', '-', ' ', ' ', ' ', ' ', ' ', '-', ' ', ' ', ' ', ' ', ' ', '-', ' ', '-', ' ', ' ', ' ', '-', ' ', '-'}, 
  {'#', '-', '#', ' ', '#', '-', '#', ' ', '#', '-', '#', '-', '#', ' ', '#', ' ', '#', '-', '#', '-', '#', ' ', '#', '-', '#', ' ', '#', '-', '#'}, 
  {'-', ' ', '-', ' ', ' ', ' ', '-', ' ', ' ', ' ', ' ', ' ', '-', ' ', '-', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', '-'}, 
  {'#', ' ', '#', '-', '#', ' ', '#', '-', '#', '-', '#', '-', '#', ' ', '#', ' ', '#', '-', '#', '-', '#', '-', '#', '-', '#', '-', '#', '-', '#'}, 
  {'-', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', '-', ' ', ' ', ' ', '-', ' ', ' ', ' ', ' ', ' ', '-', ' ', ' ', ' ', ' ', ' ', ' ', ' ', '-'}, 
  {'#', '-', '#', '-', '#', ' ', '#', ' ', '#', '-', '#', ' ', '#', '-', '#', '-', '#', '-', '#', ' ', '#', '-', '#', ' ', '#', '-', '#', ' ', '#'}, 
  {'-', ' ', ' ', ' ', ' ', ' ', '-', ' ', ' ', ' ', '-', ' ', ' ', ' ', ' ', ' ', ' ', ' ', '-', ' ', '-', ' ', ' ', ' ', ' ', ' ', '-', ' ', '-'}, 
  {'#', ' ', '#', '-', '#', '-', '#', ' ', '#', ' ', '#', '-', '#', '-', '#', '-', '#', ' ', '#', ' ', '#', ' ', '#', '-', '#', '-', '#', ' ', '#'}, 
  {'-', ' ', '-', ' ', ' ', ' ', '-', ' ', '-', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', '-', ' ', ' ', ' ', '-', ' ', ' ', ' ', ' ', ' ', '-'}, 
  {'#', '-', '#', '-', '#', '-', '#', '-', '#', '-', '#', '-', '#', '-', '#', '-', '#', '-', '#', '-', '#', '-', '#', '-', '#', '-', '#', '-', '#'}, 

};

char[][] maze_temp_blank={
  //  0    1    2    3    4

  {'#', '-', '#', '-', '#', '-', '#', '-', '#', '-', '#', '-', '#', '-', '#', '-', '#', '-', '#', '-', '#', '-', '#', '-', '#', '-', '#', '-', '#'}, 
  {'-', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', '-'}, 
  {'#', ' ', '#', ' ', '#', ' ', '#', ' ', '#', ' ', '#', ' ', '#', ' ', '#', ' ', '#', ' ', '#', ' ', '#', ' ', '#', ' ', '#', ' ', '#', ' ', '#'}, 
  {'-', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', '-'}, 
  {'#', ' ', '#', ' ', '#', ' ', '#', ' ', '#', ' ', '#', ' ', '#', ' ', '#', ' ', '#', ' ', '#', ' ', '#', ' ', '#', ' ', '#', ' ', '#', ' ', '#'}, 
  {'-', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', '-'}, 
  {'#', ' ', '#', ' ', '#', ' ', '#', ' ', '#', ' ', '#', ' ', '#', ' ', '#', ' ', '#', ' ', '#', ' ', '#', ' ', '#', ' ', '#', ' ', '#', ' ', '#'}, 
  {'-', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', '-'}, 
  {'#', ' ', '#', ' ', '#', ' ', '#', ' ', '#', ' ', '#', ' ', '#', ' ', '#', ' ', '#', ' ', '#', ' ', '#', ' ', '#', ' ', '#', ' ', '#', ' ', '#'}, 
  {'-', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', '-'}, 
  {'#', ' ', '#', ' ', '#', ' ', '#', ' ', '#', ' ', '#', ' ', '#', ' ', '#', ' ', '#', ' ', '#', ' ', '#', ' ', '#', ' ', '#', ' ', '#', ' ', '#'}, 
  {'-', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', '-'}, 
  {'#', ' ', '#', ' ', '#', ' ', '#', ' ', '#', ' ', '#', ' ', '#', '-', '#', '-', '#', ' ', '#', ' ', '#', ' ', '#', ' ', '#', ' ', '#', ' ', '#'}, 
  {'-', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', '-', ' ', ' ', ' ', '-', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', '-'}, 
  {'#', ' ', '#', ' ', '#', ' ', '#', ' ', '#', ' ', '#', ' ', '#', ' ', '#', ' ', '#', ' ', '#', ' ', '#', ' ', '#', ' ', '#', ' ', '#', ' ', '#'}, 
  {'-', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', '-', ' ', ' ', ' ', '-', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', '-'}, 
  {'#', ' ', '#', ' ', '#', ' ', '#', ' ', '#', ' ', '#', ' ', '#', '-', '#', '-', '#', ' ', '#', ' ', '#', ' ', '#', ' ', '#', ' ', '#', ' ', '#'}, 
  {'-', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', '-'}, 
  {'#', ' ', '#', ' ', '#', ' ', '#', ' ', '#', ' ', '#', ' ', '#', ' ', '#', ' ', '#', ' ', '#', ' ', '#', ' ', '#', ' ', '#', ' ', '#', ' ', '#'}, 
  {'-', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', '-'}, 
  {'#', ' ', '#', ' ', '#', ' ', '#', ' ', '#', ' ', '#', ' ', '#', ' ', '#', ' ', '#', ' ', '#', ' ', '#', ' ', '#', ' ', '#', ' ', '#', ' ', '#'}, 
  {'-', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', '-'}, 
  {'#', ' ', '#', ' ', '#', ' ', '#', ' ', '#', ' ', '#', ' ', '#', ' ', '#', ' ', '#', ' ', '#', ' ', '#', ' ', '#', ' ', '#', ' ', '#', ' ', '#'}, 
  {'-', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', '-'}, 
  {'#', ' ', '#', ' ', '#', ' ', '#', ' ', '#', ' ', '#', ' ', '#', ' ', '#', ' ', '#', ' ', '#', ' ', '#', ' ', '#', ' ', '#', ' ', '#', ' ', '#'}, 
  {'-', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', '-'}, 
  {'#', ' ', '#', ' ', '#', ' ', '#', ' ', '#', ' ', '#', ' ', '#', ' ', '#', ' ', '#', ' ', '#', ' ', '#', ' ', '#', ' ', '#', ' ', '#', ' ', '#'}, 
  {'-', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', '-'}, 
  {'#', '-', '#', '-', '#', '-', '#', '-', '#', '-', '#', '-', '#', '-', '#', '-', '#', '-', '#', '-', '#', '-', '#', '-', '#', '-', '#', '-', '#'}, 
};

int x_offset = 50;
int y_offset = 50;

int box_height = 40;
int box_width = 40;

int wall_height = 40;
int wall_width = 3;

int numWallsH = 0;
int numWallsV = 0;
int[] wallsArray=new int[15];

void setup() {
  size(700, 700);

  myFontHead = createFont("Arial", 15);
  myFontBody = createFont("Arial", 10);
  textFont(myFontHead);
  textAlign(CENTER, CENTER);

  //stroke(255, 0, 0);
  noStroke();
  //translate(x_offset, y_offset);

  int x=0;
  int y=0;

  //  print(maze_temp[0][2]);

  for (x=0; x<29; x++) {
    for (y=0; y<29; y++) {
      maze[x][y]=maze_temp[y][x];
      //maze[x][y]=maze_temp_blank[y][x];
    }
  }

  botStart(botCenterX, botCenterY, 2);
  resetMazeCells();
  costUpdate(botX, botY);
}


void draw() {
  background(255);
  numWallsH = 0;
  numWallsV = 0;
  for (int l=0; l<wallsArray.length; l++) {
    wallsArray[l]=0;
  }  
  drawMaze();
  // println(numWallsH);
  // println(numWallsV);
  println(wallsArray);
  int sumWalls=0;
  for (int l=1; l<wallsArray.length; l++) {
    sumWalls+= wallsArray[l]*l;
  }
  println(sumWalls);
  // costUpdate();
  costDraw();
  //-----------------------------------------------------------------------------

  //simple right hand rule maze solver algorithm

  if (!botAtGoal()) {
    if (wallOnRight()) {
      if (wallOnFront()) {
        if (wallOnLeft()) {
          botLeft();

          botLeft();

          botFoward(1);
        } else {
          botLeft();

          botFoward(1);
        }
      } else {

        botFoward(1);
      }
    } else {
      botRight();
      botFoward(1);
    }
  }

  cellStateArray[botX][botY]=2;


  //-----------------------------------------------------------------------------
  delay(time);
  drawBot();

  int[] nearCells=new int[5];

  if (maze[botX+1][botY]!='-' && maze[botX+1][botY]!='|') {
    nearCells[0] = int(maze[botX+2][botY]);
    if (cellStateArray[botX+2][botY]==0) {
      cellStateArray[botX+2][botY]=1;
      costUpdate(botX+2, botY);
    }
  } else {
    nearCells[0]=int(127);
  }
  if (maze[botX-1][botY]!='-' && maze[botX-1][botY]!='|') {
    nearCells[1] = int(maze[botX-2][botY]);
    if (cellStateArray[botX-2][botY]==0) {
      cellStateArray[botX-2][botY]=1;
      costUpdate(botX-2, botY);
    }
  } else {
    nearCells[1]=int(127);
  }
  if (maze[botX][botY+1]!='-' && maze[botX][botY+1]!='|') {
    nearCells[2] = int(maze[botX][botY+2]);
    if (cellStateArray[botX][botY+2]==0) {
      cellStateArray[botX][botY+2]=1;
      costUpdate(botX, botY+2);
    }
  } else {
    nearCells[2]=int(127);
  }
  if (maze[botX][botY-1]!='-' && maze[botX][botY-1]!='|') {
    nearCells[3] = int(maze[botX][botY-2]);
    if (cellStateArray[botX][botY-2]==0) {
      cellStateArray[botX][botY-2]=1;
      costUpdate(botX, botY-2);
    }
  } else {
    nearCells[3]=int(127);
  }
  if (true) {
    nearCells[4] = int(maze[botX][botY]);
  }


  if (maze[botX][botY]==char(0)) {
  } else {
    maze[botX][botY] = char(min(nearCells)+1);
  }

  drawAvatar();
  mouseEventMazeUpdate();
}


void keyPressed() {
  if (keyCode == UP) {
    botFoward(1);
  }
  if (keyCode == LEFT) {
    botLeft();
  }
  if (keyCode == RIGHT) {
    botRight();
  }
  if (key == 's') {
    editingMode=!editingMode;
  }
  if (key == '-') {
    time=time+100;
  }
  if (key == '+') {
    time=time-100;
  }
  if (key == ']') {
    alpha=alpha+10;
  }
  if (key == '[') {
    alpha=alpha-10;
  }
  time=constrain(time, 0, 1000);
}

void mousePressed() {
  if (editingMode) {
    mouseEvent=true;
  }
}

void botStart(int xOrigin, int yOrigin, int dir) {
  botX=xOrigin*2+1;
  botY=yOrigin*2+1;
  botDir=dir;

  maze[botX][botY]=char(0);
}

void botFoward(int steps) {
  if (botDir==0) {
    botY = botY-2*steps;
  }
  if (botDir==1) {
    botX = botX+2*steps;
  }
  if (botDir==2) {
    botY = botY+2*steps;
  }
  if (botDir==3) {
    botX = botX-2*steps;
  }

  botX = constrain(botX, 1, 27);
  botY = constrain(botY, 1, 27);
}
void botLeft() {
  botDir--;
  if (botDir==-1) {
    botDir=3;
  }
}
void botRight() {
  botDir++;
  if (botDir==4) {
    botDir=0;
  }
}

boolean botAtGoal() {
  if (botX>=13 && botX<=15 && botY>=13 && botY<=15) {
    return true;
  }
  return false;
}

boolean wallOnLeft() {
  if (botDir==0) {
    if (maze[botX-1][botY]=='-'||maze[botX-1][botY]=='|') {
      return true;
    }
  }
  if (botDir==1) {
    if (maze[botX][botY-1]=='-'||maze[botX][botY-1]=='|') {
      return true;
    }
  }
  if (botDir==2) {
    if (maze[botX+1][botY]=='-'||maze[botX+1][botY]=='|') {
      return true;
    }
  }
  if (botDir==3) {
    if (maze[botX][botY+1]=='-'||maze[botX][botY+1]=='|') {
      return true;
    }
  }
  return false;
}
boolean wallOnRight() {
  if (botDir==0) {
    if (maze[botX+1][botY]=='-'||maze[botX+1][botY]=='|') {
      return true;
    }
  }
  if (botDir==1) {
    if (maze[botX][botY+1]=='-'||maze[botX][botY+1]=='|') {
      return true;
    }
  }
  if (botDir==2) {
    if (maze[botX-1][botY]=='-'||maze[botX-1][botY]=='|') {
      return true;
    }
  }
  if (botDir==3) {
    if (maze[botX][botY-1]=='-'||maze[botX][botY-1]=='|') {
      return true;
    }
  }
  return false;
}
boolean wallOnFront() {
  if (botDir==0) {
    if (maze[botX][botY-1]=='-'||maze[botX][botY-1]=='|') {
      return true;
    }
  }
  if (botDir==1) {
    if (maze[botX+1][botY]=='-'||maze[botX+1][botY]=='|') {
      return true;
    }
  }
  if (botDir==2) {
    if (maze[botX][botY+1]=='-'||maze[botX][botY+1]=='|') {
      return true;
    }
  }
  if (botDir==3) {
    if (maze[botX-1][botY]=='-'||maze[botX-1][botY]=='|') {
      return true;
    }
  }
  return false;
}

void drawAvatar() {
  int avatarX = 650;
  int avatarY = 100;

  fill(0);
  ellipse(avatarX, avatarY, botWidth, botHeight);

  if (wallOnLeft()) {
    rect(avatarX-20, avatarY-20, 2, 40);
  }
  if (wallOnFront()) {
    rect(avatarX-20, avatarY-20, 40, 2);
  }
  if (wallOnRight()) {
    rect(avatarX+20, avatarY-20, 2, 40);
  }

  textFont(myFontHead);
  text("X:"+botX+" Y:"+botY, avatarX, avatarY+40);

  int dirEnd1=0;
  int dirEnd2=0;

  dirEnd1 = avatarX;
  dirEnd2 = avatarY-botWidth;

  stroke(255);
  line(avatarX, avatarY, dirEnd1, dirEnd2);
  noStroke();
}

void drawBot() {
  fill(0);
  ellipse((botX+1)*box_width/2, (botY+1)*box_height/2, botWidth, botHeight);

  int dirEnd1=0;
  int dirEnd2=0;

  if (botDir==0) {
    dirEnd1 = (botX+1)*box_width/2;
    dirEnd2 = (botY+1)*box_height/2-botWidth;
  }        
  if (botDir==1) {
    dirEnd1 = (botX+1)*box_width/2+botWidth;
    dirEnd2 = (botY+1)*box_height/2;
  }
  if (botDir==2) {
    dirEnd1 = (botX+1)*box_width/2;
    dirEnd2 = (botY+1)*box_height/2+botWidth;
  }
  if (botDir==3) {
    dirEnd1 = (botX+1)*box_width/2-botWidth;
    dirEnd2 = (botY+1)*box_height/2;
  }
  stroke(255);
  line((botX+1)*box_width/2, (botY+1)*box_height/2, dirEnd1, dirEnd2);
  noStroke();
}


void drawMaze() {
  int x=0;
  int y=0;
  noStroke();

  for (x=0; x<29; x++) {

    for (y=0; y<29; y++) {

      if (x%2==0 && y%2==0) {
        if (maze[x][y]=='#') {
          fill(255, 0, 0);
          //rect((x+1)*box_width/2, (y+1)*box_height/2, wall_width*4, wall_width*4);
        }
      } else if (y%2==0 && x%2!=0) {
        if (maze[x][y]=='-') {
          fill(0);
        } else if (maze[x][y]=='|') {
          fill(255, 0, 0);
        } else {
          fill(230);
        }
        rect(x*box_width/2, (y+1)*box_height/2, wall_height, wall_width);
      } else if (x%2==0 && y%2!=0) {
        if (maze[x][y]=='-') {
          fill(0);
        } else if (maze[x][y]=='|') {
          fill(255, 0, 0);
        } else {
          fill(230);
        }
        rect((x+1)*box_width/2, y*box_height/2, wall_width, wall_height);
      } else if (x%2!=0 && y%2!=0) {
        if (maze[x][y]==char(127)) {
          fill(0);
          // rect(x*box_width/2, y*box_height/2, box_width, box_height);
        }
        if (cellStateArray[x][y]==1) {
          fill(0, 255, 0, alpha);
          rect(x*box_width/2, y*box_height/2, box_width, box_height);
        }
        if (cellStateArray[x][y]==2) {
          fill(255, 0, 0, alpha);
          rect(x*box_width/2, y*box_height/2, box_width, box_height);
        } else {
          fill(0);
          textFont(myFontHead);
          //text(int(maze[x][y]), (x+1)*box_width/2, (y+1)*box_height/2);
        }
      } else {
        print("ERROR");
      }
    }
  }



  for (x=0; x<29; x++) {
    for (y=0; y<29; y++) {

      if (x%2==0 && y%2!=0) {
        if (maze[x][y]=='-') {
          numWallsV++;
        } else if (maze[x][y]=='|') {
          numWallsV++;
        } else {
          wallsArray[numWallsV]++;
          numWallsV=0;
        }
      }
    }
    wallsArray[numWallsV]++;
    numWallsV=0;
  }



  for (y=0; y<29; y++) {
    for (x=0; x<29; x++) {
      if (y%2==0 && x%2!=0) {
        if (maze[x][y]=='-') {
          numWallsH++;
        } else if (maze[x][y]=='|') {
          numWallsH++;
        } else {
          wallsArray[numWallsH]++;
          numWallsH=0;
        }
      }
    }
    wallsArray[numWallsH]++;
    numWallsH=0;
  }


  textFont(myFontHead);
  textAlign(LEFT, CENTER);
  text("Editing Mode: " + editingMode, 20, 600);
  text("Step delay: " + time, 200, 600);
  text("Alpha: " + alpha, 400, 600);
  textAlign(CENTER, CENTER);
}
void resetMazeCells() {
  int x=0;
  int y=0;

  for (x=0; x<29; x++) {
    for (y=0; y<29; y++) {
      if (x%2!=0 && y%2!=0) {
        if (maze[x][y]==' ') {
          maze[x][y]=char(127);
        }
      }
    }
  }
}

void mouseEventMazeUpdate() {
  if (mouseEvent) {
    //print("X "+mouseX+"Y "+mouseY+"\n");
    //print(maze.toString());

    int x=0;
    int y=0;

    for (x=0; x<29; x++) {

      for (y=0; y<29; y++) {
        if (x%2==0 && y%2==0) {
          if (maze[x][y]=='#') {
          }
        } else if (y%2==0 && x%2!=0) {
          if ((x*box_width/2 < mouseX &&  mouseX < x*box_width/2+wall_height)&&((y+1)*box_height/2 < mouseY && mouseY < (y+1)*box_height/2+wall_width*5)) {
            if (maze[x][y]=='-') {
              maze[x][y]=' ';
            } else if (maze[x][y]==' ') {
              maze[x][y]='-';
            }
          }
        } else if (x%2==0 && y%2!=0) {          
          if (((x+1)*box_width/2 < mouseX &&  mouseX < (x+1)*box_width/2+wall_width*5)&&(y*box_height/2 < mouseY && mouseY < y*box_height/2+wall_height)) {
            if (maze[x][y]=='-') {
              maze[x][y]=' ';
            } else if (maze[x][y]==' ') {
              maze[x][y]='-';
            }
          }
        } else if (x%2!=0 && y%2!=0) {
        } else {
          print("ERROR");
        }
      }
    }
  }
  mouseEvent=false;
}
/*
void costUpdate() {
 int x=0;
 int y=0;
 noStroke();
 
 for (x=0; x<29; x++) {
 
 for (y=0; y<29; y++) {
 if (x%2!=0 && y%2!=0) {
 if (cellStateArray[x][y]!=2) {    
 int gCost=int(sqrt(sq(botX-botCenterX) + sq(botY-botCenterY)));
 int hCost=int(sqrt(sq(goalCenterX-botX) + sq(goalCenterY-botY)));       
 int fCost = gCost+hCost;
 
 gCostArray[x][y]=gCost;
 hCostArray[x][y]=hCost;
 fCostArray[x][y]=fCost;
 }
 }
 }
 }
 }
 */

void costUpdate(int x, int y) {
  if (cellStateArray[x][y]!=2) {    
    int gCost=int(sqrt(sq(x-botCenterX) + sq(y-botCenterY)));
    int hCost=int(sqrt(sq(goalCenterX-x) + sq(goalCenterY-y)));       
    int fCost = gCost+hCost;

    gCostArray[x][y]=gCost;
    hCostArray[x][y]=hCost;
    fCostArray[x][y]=fCost;
  }
}


void costDraw() {
  int x=0;
  int y=0;
  noStroke();

  for (x=0; x<29; x++) {

    for (y=0; y<29; y++) {
      if (x%2!=0 && y%2!=0) {
        fill(0);
        textFont(myFontBody);
        text(gCostArray[x][y], (x)*box_width/2+box_width/4, (y)*box_height/2+box_height/4);
        text(hCostArray[x][y], (x+1)*box_width/2+box_width/4, (y+1)*box_height/2+box_height/4);
        textFont(myFontHead);
        text(fCostArray[x][y], (x+1)*box_width/2, (y+1)*box_height/2);
      }
    }
  }
}
