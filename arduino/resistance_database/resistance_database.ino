#define KNOWN_RES 984   //the given resistance in Voltage divider
#define VOLT_TOTAL 5    //the vcc that feeds the circuit
#define ANALAOG_PIN A5  //the analog pin used to measure the voltage
#define LOOPS 50

void setup() {
  //begin serial communication with baud-rate 9600 bit/s
  Serial.begin(9600);
}

unsigned int volt_r;
double volt;
double res;

void loop() {
  //check any request from matlab
  if (Serial.available()) {
    //read the request
    Serial.readStringUntil('\n');

    res = 0;
    for (int i = 0; i < LOOPS; i++) {
      //get the ADC value, Register size is 10 bit
      volt_r = analogRead(ANALAOG_PIN);  //0->1023

      //map the register value to become volt unit
      volt = VOLT_TOTAL * (volt_r / 1023.0);  //volt

      //calculate the resistance using voltage divider circuit
      res += volt * KNOWN_RES / (VOLT_TOTAL - volt);
    }
    res = res / LOOPS;

    //send the resistance value to matlab as string
    Serial.println((int)res);
  }
}