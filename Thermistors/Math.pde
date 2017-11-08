public class MathematicalException extends Exception {
  String description;
  MathematicalException(String Message) {
    this.description = Message;
  }
  String getMessage() {
    return description;
  }
}

//R = Ro exp[ a (1/T - 1/To) ]

class Thermistor {  //Thermistor class and function
  float alpha = Defaults.Thermistor.alpha;
  float R_0 = Defaults.Thermistor.R_0;
  float T_0 = Defaults.Thermistor.T_0;
  void setAlpha(float alpha) {
    this.alpha = alpha;
  }
  void setR_0(float resistance) {
    this.R_0 = resistance;
  }
  void setT_0(float temperature_K) {
    this.T_0 = temperature_K;
  }

  Thermistor() {
  }

  Thermistor(Thermistor t) {
    this.alpha = t.alpha;
    this.R_0 = t.R_0;
    this.T_0 = t.T_0;
  }

  Thermistor(float alpha, float R_0, float T_0) {
    this.setAlpha(alpha);
    this.setR_0(R_0);
    this.setT_0(T_0);
  }
  //Calculate Aplha values
  float calculateAlpha(float R_1, float T_1_K) throws MathematicalException {
    try {
      return calculateAlpha(R_1, T_1_K, R_0, T_0);
    } 
    catch (Exception e) {
      throw new MathematicalException("Error : " + e.getMessage());
    }
  }
  float calculateAlpha(float R_1, float T_1_K, float R_0, float T_0_K) throws MathematicalException {
    if (R_1 == R_0 || T_1_K == T_0_K) {
      throw new MathematicalException("Data error : (R,T) : (" + str(R_1) + "," + str(T_1_K) + ") ; (" + str(R_0) + "," + str(T_0_K) + ")");
    }
    if (T_1_K < 0 || T_0_K < 0) {
      throw new MathematicalException("Temperatures " + str(T_1_K) + "K and " + str(T_0_K) + "K are theoretically incorrect");
    }
    try {
      this.alpha = log(R_1/R_0) * (1.0/ (1.0/T_1_K - 1.0/T_0_K) );
    }
    catch (Exception e) {
      throw new MathematicalException("Error : " + e.getMessage());
    }
    return alpha;
  }

  float getResistance_T_K(float Temperature_K) {    
    return R_0 * exp(alpha * (1.0/Temperature_K - 1.0/T_0));
  }

  float getResistance(float Temperature_C) {
    return getResistance_T_K(dc_k(Temperature_C));
  }

  float getTemperature_K(float Resistance) {
    return 1.0/((log(Resistance / R_0) / alpha) + 1.0/T_0);
  }
}


class Thermistor_Graph extends Thermistor {  //To integrate Thermistor and Graph
  color graphColor = #ff0000;
  Thermistor_Graph() {
  }
  Thermistor_Graph(Thermistor t, color graphColor) {
    super(t);
    this.graphColor = graphColor;
  }
  Thermistor_Graph(Thermistor t) {
    super(t);
    this.graphColor = color(255, 0, 0);
  }
}

ArrayList<Thermistor_Graph> thermistors;