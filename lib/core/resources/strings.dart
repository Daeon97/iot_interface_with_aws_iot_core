// ignore_for_file: public_member_api_docs

// routes
const defaultScreenRoute = '/';
const homeScreenRoute = '/home';

// environment variable key names
const iotUnityPlatformTopicNameKey = 'IOT_UNITY_PLATFORM_TOPIC_NAME';
const awsIotCoreServerEndPointKey = 'AWS_IOT_CORE_SERVER_END_POINT';
const deviceCertificateKey = 'DEVICE_CERTIFICATE';
const privateKeyKey = 'PRIVATE_KEY';
const rootCertificateAuthorityKey = 'ROOT_CERTIFICATE_AUTHORITY';

// ID's
const defaultClientId = 'iot_interface_with_aws_iot_core';

// exception messages
const brokerExceptionMessage =
    '''Broker exception. Connection status -> state: %s, return code: %s, disconnect origin: %s''';
const badCertificateExceptionMessage =
    'Bad certificate exception. X509Certificate -> %s';
const topicSubscriptionExceptionMessage =
    'Topic subscription exception. Topic name -> %s';
const unsolicitedDisconnectionExceptionMessage =
    'Unsolicited disconnection -> %s';

// failure messages
const brokerFailureMessage = 'There was an issue connecting to the MQTT broker';
const badCertificateFailureMessage = 'Certificate credentials are incorrect';
const topicSubscriptionFailureMessage =
    'There was an issue subscribing to the appropriate topic';
const unsolicitedDisconnectionFailureMessage =
    'Client unexpectedly disconnected';
