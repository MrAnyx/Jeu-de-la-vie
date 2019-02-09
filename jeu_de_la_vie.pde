// choisir entre R et P (Random ou Perso)
// Appuiyer sur enter pour lancer
// re-appuiyer sur entrer pour stopper

int nb_cases_x = 120;
int nb_cases_y = 80;


int[][] tab_old = new int[nb_cases_x+2][nb_cases_y+2];
int[][] tab_new = new int[nb_cases_x+2][nb_cases_y+2];

boolean rand = true;

boolean state = false;
int compteur = 0;

void setup() {
  size(1201, 801);
  smooth();

  for (int i = 1; i<nb_cases_x+1; i++) {
    for (int j = 1; j<nb_cases_y+1; j++) {

      int a=int(random(0, 101));
      if (a<20) {
        tab_old[i][j]=1;
      } else tab_old[i][j]=0;
    }
  }

  egaliser();
}

void egaliser() {
  for (int i = 1; i<nb_cases_x+1; i++) {
    for (int j = 1; j<nb_cases_y+1; j++) {
      tab_new[i][j] = tab_old[i][j];
    }
  }
}

void affiche_tab() {
  for (int i = 1; i<nb_cases_x+1; i++) {
    for (int j = 1; j<nb_cases_y+1; j++) {
      if (tab_new[i][j] == 0) {
        fill(255);
      } else {
        fill(0);
      }
      rect(i*10-10, j*10-10, 10, 10);
    }
  }
}

void reset_tab() {
  for (int i = 1; i<nb_cases_x+1; i++) {
    for (int j = 1; j<nb_cases_y+1; j++) {
      tab_new[i][j] = 0;
      tab_old[i][j] = 0;
    }
  }
}

void random_tab() {
  for (int i = 1; i<nb_cases_x+1; i++) {
    for (int j = 1; j<nb_cases_y+1; j++) {
      int a=int(random(0, 101));
      if (a<20) {
        tab_old[i][j]=1;
      } else tab_old[i][j]=0;
    }
  }
}

void draw() {
  if (state == false && rand == false) {
    for (int i = 1; i<nb_cases_x+1; i++) {
      for (int j = 1; j<nb_cases_y+1; j++) {
        tab_new[i][j] = tab_old[i][j];
      }
    }
    if (mousePressed && mouseButton == LEFT) {
      int x = floor((mouseX + 10)/10); 
      int y = floor((mouseY + 10)/10);
      if (x < 0 || x > (width+10)/10 || y < 0 || y > (height+10)/10) {
      } else {
        tab_old[x][y] = 1;
        tab_new[x][y] = 1;
      }
    } else if (mousePressed && mouseButton == RIGHT) {
      int x = floor((mouseX + 10)/10); 
      int y = floor((mouseY + 10)/10); 
      if (x < 0 || x > (width+10)/10 || y < 0 || y > (height+10)/10) {
      } else {
        tab_old[x][y] = 0;
        tab_new[x][y] = 0;
      }
    }
  }


  if (state == true) {
    if (compteur%3 == 0) {
      for (int i = 1; i<nb_cases_x+1; i++) {
        for (int j = 1; j<nb_cases_y+1; j++) {
          if ((tab_old[i-1][j-1] + tab_old[i][j-1] + tab_old[i+1][j-1] + tab_old[i-1][j] + tab_old[i+1][j] + tab_old[i-1][j+1] + tab_old[i][j+1] + tab_old[i+1][j+1] == 3) && tab_old[i][j]==0) {
            tab_new[i][j]=1;
          }
          if ((tab_old[i-1][j-1] + tab_old[i][j-1] + tab_old[i+1][j-1] + tab_old[i-1][j] + tab_old[i+1][j] + tab_old[i-1][j+1] + tab_old[i][j+1] + tab_old[i+1][j+1] < 2) && tab_old[i][j]==1) {
            tab_new[i][j]=0;
          }
          if ((tab_old[i-1][j-1] + tab_old[i][j-1] + tab_old[i+1][j-1] + tab_old[i-1][j] + tab_old[i+1][j] + tab_old[i-1][j+1] + tab_old[i][j+1] + tab_old[i+1][j+1] > 3) && tab_old[i][j]==1) {
            tab_new[i][j]=0;
          }
        }
      }

      for (int i = 1; i<nb_cases_x+1; i++) {
        for (int j = 1; j<nb_cases_y+1; j++) {
          tab_old[i][j] = tab_new[i][j];
        }
      }
    }
    compteur++;
  }
  affiche_tab();
  fill(255);
  rect(0, 0, 100, 40);

  if (rand == true) {
    fill(0, 150, 0);
    text("R : Random", 18, 15);
    fill(200, 0, 0);
    text("P : Perso", 18, 35);
  } else {
    fill(200, 0, 0);
    text("R : Random", 18, 15);
    fill(0, 150, 0);
    text("P : Perso", 18, 35);
  }
}

void keyPressed() {
  if (keyCode == ENTER)state = !state;
  if (key == 'r' || key == 'R') {
    rand = true;
    reset_tab();
    random_tab();
    egaliser();
    affiche_tab();
  }
  if (key == 'p' || key == 'P') {
    rand = false;
    reset_tab();
    egaliser();
    affiche_tab();
  }
}
