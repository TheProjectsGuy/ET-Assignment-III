void Temperature_Database_Handler() {
  switch(CURRENT_VIEW) {
  case "SELECT THERMISTOR LOADER":
    load_T_Database();
    break;
  case "SELECT THERMISTOR":
    selectThermistorFromDatabaseMenu();
    break;
  }
}
UITextField user_choice;
void load_T_Database() {
  user_choice = new UITextField(width * 5/8, height * 3/4, width * 5/8 + 100, height * 3/4 + 40);
  user_choice.placeholder_text = "No : ";
  user_choice.text = "";
  user_choice.singleLineTextField = true;
  CURRENT_VIEW = "SELECT THERMISTOR";
}

void selectThermistorFromDatabaseMenu() {
  background(255);
  strokeWeight(1);
  stroke(0);
  textFont(graphAxisLabelFont);
  textSize(20);
  textAlign(LEFT, BOTTOM);
  fill(0, 0, 255);
  text("Name", width * 1/5 + 5, height * 0.08 - 10);
  textAlign(CENTER, BOTTOM);
  text("Alpha (K)", width * 1/5 + 10 + 150, height * 0.08 - 10);
  textAlign(RIGHT, BOTTOM);
  text("Data Point", width * 1/5 + 500 - 20, height * 0.08 - 5);
  for (int i = 0; i < thermistors.size(); i++) {
    Thermistor currentThermistor = thermistors.get(i);
    noFill();
    rectMode(CORNER);
    rect(width * 1/5, height * 0.08 + 60 * i, 500, 50);
    textFont(graphAxisLabelFont);
    textSize(20);
    if (default_Thermistor.Name.equals(currentThermistor.Name)) {
      fill(255, 0, 0);
    } else {
      fill(0);
    }
    textAlign(RIGHT, TOP);
    text(str(i + 1) + ") ", width * 1/5, height * 0.08 + 60 * i + 10);
    if (currentThermistor.Band_100uA == max_100uA_band) {
      fill(0, 255, 50);
    } else if (currentThermistor.Band_10uA == max_10uA_band) {
      fill(0, 127, 0);
    } else if (currentThermistor.ResistanceTolerance == min_resistanceTolerance) {
      fill(#8003FF);
    } else {
      fill(0);
    }
    textAlign(LEFT, TOP);
    text(currentThermistor.Name, width * 1/5 + 10, height * 0.08 + 60 * i + 10);
    textAlign(CENTER, TOP);
    text(currentThermistor.alpha, width * 1/5 + 10 + 150, height * 0.08 + 60 * i + 10);
    textAlign(RIGHT, TOP);
    text(str(currentThermistor.R_0) + " Ω, " + str(currentThermistor.T_0) + " K", width * 1/5 + 500 - 20, height * 0.08 + 60 * i + 10);
  }
  user_choice.drawItems();
}


void Temperature_Database_keyPressed() {
  if (user_choice.selected) {
    if (key != ENTER) {
      user_choice.keyboardManager();
    } else {
      //Enter pressed
      try {
        default_Thermistor = new Thermistor_Graph(thermistors.get(int(float(user_choice.text) - 1)));
        println("Default thermistor changed to " + default_Thermistor.Name);
        CURRENT_VIEW = "SELECT THERMISTOR LOADER";
      } 
      catch (Exception e) {
        println("Enter something valid please");
      }
    }
  }
}