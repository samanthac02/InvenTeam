#include <ESP8266WiFi.h>

const char WiFiAPPSK[] = "esp8266-12e";

WiFiServer server(80);

void setupWiFi()
{
  WiFi.mode(WIFI_AP);

  // Do a little work to get a unique-ish name. Append the
  // last two bytes of the MAC (HEX'd) to "ThingDev-":
  uint8_t mac[WL_MAC_ADDR_LENGTH];
  WiFi.softAPmacAddress(mac);
  String macID = String(mac[WL_MAC_ADDR_LENGTH - 2], HEX) +
                 String(mac[WL_MAC_ADDR_LENGTH - 1], HEX);
  macID.toUpperCase();
  String AP_NameString = "LED-" + macID;

  char AP_NameChar[AP_NameString.length() + 1];
  memset(AP_NameChar, 0, AP_NameString.length() + 1);

  for (int i=0; i<AP_NameString.length(); i++)
    AP_NameChar[i] = AP_NameString.charAt(i);

  WiFi.softAP(AP_NameChar, WiFiAPPSK);
}

void initHardware()
{
  Serial.begin(115200);
  pinMode(16, OUTPUT);
  digitalWrite(16, LOW);
}

void setup() 
{
  initHardware();
  setupWiFi();
  server.begin();
}

void loop() 
{
  WiFiClient client = server.available();
  if (!client) {
    return;
  }

  String req = client.readStringUntil('\r');
  Serial.println(req);
  client.flush();

  int val = -1; 
  if (req.indexOf("/led/0") != -1)
    val = 0; 
  else if (req.indexOf("/led/1") != -1)
    val = 1;

  if (val >= 0)
    Serial.println(val);
    digitalWrite(16, val);
  
  client.flush();

  String s = "HTTP/1.1 200 OK\r\n";
  s += "Content-Type: text/html\r\n\r\n";
  s += "<!DOCTYPE HTML>\r\n<html>\r\n";
  if (val >= 0)
  {
    s += "LED is now ";
    s += (val)?"off":"on";
  }
  else
  {
    s += "Invalid Request.<br> Try /led/1, /led/0, or /read.";
  }
  s += "</html>\n";

  client.print(s);
  delay(1);
  Serial.println("Client disonnected");

}
