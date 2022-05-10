#include <Servo.h>

Servo stabMotor;
int PulseSensorPurplePin = 0;
int LED16 = 16;

int Signal;
int Threshold = 550;

void setup() {
  pinMode(LED16, OUTPUT);
  stabMotor.attach(4);
  
  Serial.begin(9600);
}

void loop() {
  Signal = analogRead(PulseSensorPurplePin);

   Serial.println(Signal);


   if(Signal > Threshold) {
     digitalWrite(LED16,HIGH);
     stabMotor.writeMicroseconds(1000);
     delay(1000);
   } else {
     digitalWrite(LED16,LOW);
     stabMotor.writeMicroseconds(2000);
     delay(1000);
   }

  delay(10);
}
