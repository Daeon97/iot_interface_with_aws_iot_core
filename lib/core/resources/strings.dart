// ignore_for_file: public_member_api_docs

// routes
const defaultScreenRoute = '/';
const homeScreenRoute = '/home';

// assets path
const assetsPath = 'assets';

// certificates path
const certificatesPath = '$assetsPath/certificates';

// certificates
const deviceCertificateAssetPath = '$certificatesPath/device_certificate.pem.crt';
const privateKeyAssetPath = '$certificatesPath/private_key.pem.key';
const rootCertificateAuthorityAssetPath = '$certificatesPath/root_certificate_authority.pem';

// environment variable key names
const iotUnityPlatformTopicNameKey = 'IOT_UNITY_PLATFORM_TOPIC_NAME';
const awsIotCoreServerEndPointKey = 'AWS_IOT_CORE_SERVER_END_POINT';

// ID's
const defaultClientId = 'iot_interface_with_aws_iot_core';

// Get it registration instance names
const mqttServerEndpoint = 'mqttServerEndpoint';
const mqttClientIdentifier = 'mqttClientIdentifier';

// exception messages
const noMessagesFromBrokerExceptionMessage =
    'No messages from broker exception -> %s';
const badCertificateExceptionMessage =
    'Bad certificate exception. X509Certificate -> %s';
const topicSubscriptionExceptionMessage =
    'Topic subscription exception. Topic name -> %s';
const unsolicitedDisconnectionExceptionMessage =
    'Unsolicited disconnection exception -> %s';
const couldNotConnectToBrokerExceptionMessage =
    '''Could not connect to broker exception. Connection status -> state: %s, return code: %s, disconnect origin: %s''';
const messageTopicMismatchExceptionMessage =
    '''Message topic mismatch exception. MQTT received message -> payload: %s, topic: %s, as published message -> payload message: %s''';
const badMessageFormatExceptionMessage = '''...''';

// failure messages
const noMessagesFromBrokerFailureMessage = 'No data';
const badCertificateFailureMessage = 'Certificate credentials are incorrect';
const topicSubscriptionFailureMessage =
    'There was an issue subscribing to the appropriate topic';
const unsolicitedDisconnectionFailureMessage =
    'Client unexpectedly disconnected';
const couldNotConnectToBrokerFailureMessage = 'Unable to connect to broker';
const messageTopicMismatchFailureMessage =
    'Received message topic does not correspond to current topic';
const badMessageFormatFailureMessage = '''...''';
const unknownFailureMessage = 'An unknown error occurred';

// empty strings and special characters and other strings
const emptyString = '';
