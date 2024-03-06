IoT Interface with AWS IoT Core is a mobile app interface for an ESP32 IoT device that communicates
with AWS IoT Core over MQTT. The app uses the [mqtt_client](https://pub.dev/packages/mqtt_client)
package to establish a direct communication link with AWS IoT Core- It first connects to the MQTT
broker, AWS IoT Core in this case, subscribes to the specified topic and processes incoming messages 
from the topic. The app was built using TDD and Clean Architecture

# Screenshot
<img src="https://github.com/Daeon97/iot_interface_with_aws_iot_core/assets/40745212/19b93057-4d25-4731-8d2b-6256b8fde9b5" width="200" height="400" />

# Demo
[Screencast from 2024-03-06 16-38-57.webm](https://github.com/Daeon97/iot_interface_with_aws_iot_core/assets/40745212/5693f851-36be-40f4-b796-b2c44915dc4a)
