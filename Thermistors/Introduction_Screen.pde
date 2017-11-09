//CURRENT_SCREEN = "Introduction Screen"
void Introduction_Screen_Handler() {
  switch(CURRENT_VIEW) {
  case "HOMEPAGE":  //CURRENT_VIEW = HOMEPAGE
    MakeHomepage();
    break;
  }
}

void MakeHomepage() {
  background(127);
  MakeHomepageButtons();
}

void Introduction_Screen_keyPressed() {
  
}

PImage Default_Calibration_Curve_Button;  //285 BY 50

void MakeHomepageButtons() {
  Make_Default_Calibration_Curve_Button();
}

void Make_Default_Calibration_Curve_Button() {
  if (mouseX <= width/2 + 285/2.0 && mouseX >= width/2 - 285/2.0 && mouseY <= height/2 + 50/2.0 && mouseY >= height/2 - 50/2.0) {
    Default_Calibration_Curve_Button = loadImage("data/Images/Introduction Screen/Default_Calibration_Curve_hovered.png");
    if (mousePressed) {
      doCommand("Screen.Grapher_Screen.Default_Graph");  // ;-> "Grapher Screen"."Default Graph"
    }
  } else {
    Default_Calibration_Curve_Button = loadImage("data/Images/Introduction Screen/Default_Calibration_Curve_unhovered.png");
  }
  imageMode(CENTER);
  image(Default_Calibration_Curve_Button, width/2, height/2);
}