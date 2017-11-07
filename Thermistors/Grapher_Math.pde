//R = Ro exp[ a (1/T - 1/To) ]
// a = 4013.474827 K   For the given problem

static class Thermistor_Defaults {
  static float R_0 = 3000;  //3000 Ohms
  static float T_0 = 298;  //298 K
  static float alpha = 4013.474827;  //alpha (for thermistor = 4013.474827 K)
  
  static float R_1 = 200;  //R1 = 200 Ohms
  static float T_1 = 373;  //100 degree C, 373 K
}

class Thermistor {  //Thermistor class and function
  float alpha;
  float R_0;
  float T_0;
    
}