UITextField R_0_TextField, T_0_TextField, R_1_TextField, T_1_TextField;
Thermistor_Graph Thermistor_Analyzer_Graph;
Graph Thermistor_Analyzer_GraphView;
PFont UITextField_TextFont;
void Thermistor_Analyzer_Handler() {

  switch (CURRENT_VIEW) {
  case "FORM VIEW LOADER":  //Entrance point of this screen
    background(255);
    InitializeTextFields_Thermistor_Analyzer();
    break;
  case "FORM VIEW":
    background(255);
    Form_Fill_Thermistor_Analyzer();
    break;
  case "RESULT PAGE":
    background(255);
    DisplayResults_Thermistor_Analyzer();
    break;
  case "RESULT GRAPH":
    DisplayGraphicalResults_Thermistor_Analyzer();
    break;
  }
  makeEssentialButtons_Thermistor_Analyzer();
}

void DisplayGraphicalResults_Thermistor_Analyzer() {
  Thermistor_Analyzer_GraphView.drawGraph(Thermistor_Analyzer_Graph);
}

PImage GraohResult_Thermistor_Analyzer;
void DisplayResults_Thermistor_Analyzer() {
  textFont(graphAxisLabelFont, 20);
  fill(255, 0, 0);
  textAlign(LEFT, CENTER);
  text("R0 = " + str(Thermistor_Analyzer_Graph.R_0) + " Ω", width * 1/6, 200);
  text("R1 = " + R_1_TextField.text + " Ω", width * 1/6, 350);
  text("T0 = " + str(Thermistor_Analyzer_Graph.T_0) + " K", width * 4/6, 200);
  text("T1 = " + T_1_TextField.text + " K", width * 4/6, 350);
  textAlign(CENTER, CENTER);
  text("Alpha = " + str(Thermistor_Analyzer_Graph.alpha) + " K", width/2, 100);

  GraohResult_Thermistor_Analyzer = loadImage("data/Images/Thermistor Analyzer/Graph_Button.png");
  if (mouseX <= width * 0.9 + 100 && mouseX >= width * 0.9 && mouseY <= height*2/3 + 100 && mouseY >= height*2/3 && mousePressed) {
    //Load the graph
    Thermistor_Analyzer_GraphView = new Graph(width * 1/6, height * 1/5, width * 5/6, height * 3/5);
    Thermistor_Analyzer_GraphView.xlabel = "Temperature (in ˚C)";
    Thermistor_Analyzer_GraphView.ylabel = "Resistance (in kΩ)";
    Thermistor_Analyzer_GraphView.setXAxis(k_dc(min(Thermistor_Analyzer_Graph.T_0, float(T_1_TextField.text))), k_dc(max(Thermistor_Analyzer_Graph.T_0, float(T_1_TextField.text))), 15);
    Thermistor_Analyzer_GraphView.setYAxis(min(Thermistor_Analyzer_Graph.R_0, float(R_1_TextField.text))/1000, max(Thermistor_Analyzer_Graph.R_0, float(R_1_TextField.text))/1000, 10);
    background(255);
    Thermistor_Analyzer_GraphView.make();
    //Graph loaded
    CURRENT_VIEW = "RESULT GRAPH";
  }
  image(GraohResult_Thermistor_Analyzer, width * 0.9, height * 2/3, 100, 100);
}

void makeEssentialButtons_Thermistor_Analyzer() {
  if (CURRENT_VIEW.equals("FORM VIEW")) {
    makeSubmitAndClearButtons_ThermistorAnalyzer();
  } else {
    makeBackButton_ThermistorAnalyzer();
  }
}

PImage BackButton_Icon;
void makeBackButton_ThermistorAnalyzer() {
  BackButton_Icon = loadImage("data/Images/Thermistor Analyzer/Back_Button.png");
  if (mouseX <= width * 2/3 + 100 && mouseX >= width * 2/3 && mouseY >= height * 9/10 && mouseY <= height * 9/10 + 50 && mousePressed) {
    CURRENT_VIEW = "FORM VIEW LOADER";
  }
  image(BackButton_Icon, width * 2/3, height * 9/10, 100, 50);
}

PImage ClearButton_Icon, SubmitButton_Icon;
void makeSubmitAndClearButtons_ThermistorAnalyzer() {
  ClearButton_Icon = loadImage("data/Images/Thermistor Analyzer/Clear_Button.png");
  SubmitButton_Icon = loadImage("data/Images/Thermistor Analyzer/Submit_Button.png");
  imageMode(CORNER);
  if (mouseX <= width * 2/3 + 100 && mouseX >= width * 2/3 && mouseY >= height * 9/10 && mouseY <= height * 9/10 + 50 && mousePressed) {
    CURRENT_VIEW = "FORM VIEW LOADER";
  }
  image(ClearButton_Icon, width * 2/3, height * 9/10, 100, 50);
  if (mouseX <= width * 2/3 + 100 + 120 && mouseX >= width * 2/3 + 120 && mouseY >= height * 9/10 && mouseY <= height * 9/10 + 50 && mousePressed) {
    CURRENT_VIEW = "RESULT PAGE";
    try {
      Thermistor_Analyzer_Graph = new Thermistor_Graph(new Thermistor(), color(0, 0, 255));
      Thermistor_Analyzer_Graph.R_0 = float(R_0_TextField.text);
      Thermistor_Analyzer_Graph.T_0 = float(T_0_TextField.text);
      Thermistor_Analyzer_Graph.calculateAlpha(float(R_1_TextField.text), float(T_1_TextField.text));
    } 
    catch (Exception e) {
      println("INVALID DATA ENTERED");
      CURRENT_VIEW = "FORM VIEW LOADER";
    }
  }
  image(SubmitButton_Icon, width * 2/3 + 120, height * 9/10, 100, 50);
}

void InitializeTextFields_Thermistor_Analyzer() {
  R_0_TextField = new UITextField(width * 1/6, 200, width * 1/3, 250);
  R_0_TextField.text = "";
  R_0_TextField.singleLineTextField = true;
  R_0_TextField.placeholder_text = "Enter R0 in Ω";

  T_0_TextField = new UITextField(width * 4/6, 200, width * 5/6, 250);
  T_0_TextField.text = "";
  T_0_TextField.singleLineTextField = true;
  T_0_TextField.placeholder_text = "Enter T0 in K";

  R_1_TextField = new UITextField(width * 1/6, 350, width * 1/3, 400);
  R_1_TextField.text = "";
  R_1_TextField.singleLineTextField = true;
  R_1_TextField.placeholder_text = "Enter R1 in Ω";

  T_1_TextField = new UITextField(width * 4/6, 350, width * 5/6, 400);
  T_1_TextField.text = "";
  T_1_TextField.singleLineTextField = true;
  T_1_TextField.placeholder_text = "Enter T1 in K";

  CURRENT_VIEW = "FORM VIEW";
}

void Form_Fill_Thermistor_Analyzer() {
  R_0_TextField.drawItems();
  R_1_TextField.drawItems();
  T_0_TextField.drawItems();
  T_1_TextField.drawItems();
}


void Thermistor_Analyzer_keyPressed() {
  if (key != ENTER) {
    if (R_0_TextField.selected) {
      R_0_TextField.keyboardManager();
    } else if (R_1_TextField.selected) {
      R_1_TextField.keyboardManager();
    } else if (T_0_TextField.selected) {
      T_0_TextField.keyboardManager();
    } else if (T_1_TextField.selected) {
      T_1_TextField.keyboardManager();
    }
  }
  if (key == ENTER) {
    if (R_0_TextField.selected) {
      R_0_TextField.selected = false;
    } else if (R_1_TextField.selected) {
      R_1_TextField.selected = false;
    } else if (T_0_TextField.selected) {
      T_0_TextField.selected = false;
    } else if (T_1_TextField.selected) {
      T_1_TextField.selected = false;
    }
  }
}