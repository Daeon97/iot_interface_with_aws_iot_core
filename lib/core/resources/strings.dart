// routes
// ignore_for_file: public_member_api_docs

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

// error messages

// failure messages
const brokerExceptionMessage =
    '''Broker exception. Connection status -> state: %s, return code: %s, disconnect origin: %s''';
