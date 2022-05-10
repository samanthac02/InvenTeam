#include <Servo.h>

Servo stabMotor;

void setup() {
  // put your setup code here, to run once:
  stabMotor.attach(4);
  Serial.begin(9600);
}

void loop() {
  // put your main code here, to run repeatedly:
  stabMotor.writeMicroseconds(1000);
  delay(1000);
  stabMotor.writeMicroseconds(1500);
  delay(1000);
}
