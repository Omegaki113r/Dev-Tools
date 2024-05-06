void setup()
{
  Serial.begin(115200);
  delay(1000);
}

void loop()
{
  while (Serial.available() > 0)
    Serial.write(Serial.read());
  delay(20);
}
