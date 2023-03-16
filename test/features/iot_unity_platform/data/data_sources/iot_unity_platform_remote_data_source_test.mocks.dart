// Mocks generated by Mockito 5.3.2 from annotations
// in iot_interface_with_aws_iot_core/test/features/iot_unity_platform/data/data_sources/iot_unity_platform_remote_data_source_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;
import 'dart:io' as _i2;

import 'package:iot_interface_with_aws_iot_core/core/clients/mqtt_client.dart'
    as _i4;
import 'package:mockito/mockito.dart' as _i1;
import 'package:mqtt_client/mqtt_client.dart' as _i6;
import 'package:mqtt_client/mqtt_server_client.dart' as _i3;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeSecurityContext_0 extends _i1.SmartFake
    implements _i2.SecurityContext {
  _FakeSecurityContext_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeMqttServerClient_1 extends _i1.SmartFake
    implements _i3.MqttServerClient {
  _FakeMqttServerClient_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [MqttClient].
///
/// See the documentation for Mockito's code generation for more information.
class MockMqttClient extends _i1.Mock implements _i4.MqttClient {
  @override
  _i2.SecurityContext get securityContext => (super.noSuchMethod(
        Invocation.getter(#securityContext),
        returnValue: _FakeSecurityContext_0(
          this,
          Invocation.getter(#securityContext),
        ),
        returnValueForMissingStub: _FakeSecurityContext_0(
          this,
          Invocation.getter(#securityContext),
        ),
      ) as _i2.SecurityContext);
  @override
  _i3.MqttServerClient get mqttServerClient => (super.noSuchMethod(
        Invocation.getter(#mqttServerClient),
        returnValue: _FakeMqttServerClient_1(
          this,
          Invocation.getter(#mqttServerClient),
        ),
        returnValueForMissingStub: _FakeMqttServerClient_1(
          this,
          Invocation.getter(#mqttServerClient),
        ),
      ) as _i3.MqttServerClient);
  @override
  void establishSecurityContext({
    required String? rootCertificateAuthority,
    required String? privateKey,
    required String? deviceCertificate,
  }) =>
      super.noSuchMethod(
        Invocation.method(
          #setSecurityContext,
          [],
          {
            #rootCertificateAuthority: rootCertificateAuthority,
            #privateKey: privateKey,
            #deviceCertificate: deviceCertificate,
          },
        ),
        returnValueForMissingStub: null,
      );
  @override
  void ensureAllOtherImportantStuffInitialized({
    bool? enableLogging = true,
    int? port = 8883,
    int? keepAlivePeriod = 20,
    String? clientId = r'iot_interface_with_aws_iot_core',
  }) =>
      super.noSuchMethod(
        Invocation.method(
          #ensureAllOtherImportantStuffInitialized,
          [],
          {
            #enableLogging: enableLogging,
            #port: port,
            #keepAlivePeriod: keepAlivePeriod,
            #clientId: clientId,
          },
        ),
        returnValueForMissingStub: null,
      );
  @override
  bool onBadCertificateSupplied(_i2.X509Certificate? certificate) =>
      (super.noSuchMethod(
        Invocation.method(
          #onBadCertificateSupplied,
          [certificate],
        ),
        returnValue: false,
        returnValueForMissingStub: false,
      ) as bool);
  @override
  void onSubscriptionToTopicFailed(String? topicName) => super.noSuchMethod(
        Invocation.method(
          #onSubscriptionToTopicFailed,
          [topicName],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void onDisconnectedFromBroker() => super.noSuchMethod(
        Invocation.method(
          #onDisconnectedFromBroker,
          [],
        ),
        returnValueForMissingStub: null,
      );
  @override
  _i5.Future<_i6.MqttClientConnectionStatus?> connectToBroker({
    String? username,
    String? password,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #connectToBroker,
          [],
          {
            #username: username,
            #password: password,
          },
        ),
        returnValue: _i5.Future<_i6.MqttClientConnectionStatus?>.value(),
        returnValueForMissingStub:
            _i5.Future<_i6.MqttClientConnectionStatus?>.value(),
      ) as _i5.Future<_i6.MqttClientConnectionStatus?>);
  @override
  void disconnectFromBroker() => super.noSuchMethod(
        Invocation.method(
          #disconnectFromBroker,
          [],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void subscribeToTopic({
    required String? topicName,
    required _i6.MqttQos? qualityOfService,
  }) =>
      super.noSuchMethod(
        Invocation.method(
          #subscribeToTopic,
          [],
          {
            #topicName: topicName,
            #qualityOfService: qualityOfService,
          },
        ),
        returnValueForMissingStub: null,
      );
  @override
  void unsubscribeFromTopic({
    required String? topicName,
    required bool? acknowledgeUnsubscription,
  }) =>
      super.noSuchMethod(
        Invocation.method(
          #unsubscribeFromTopic,
          [],
          {
            #topicName: topicName,
            #acknowledgeUnsubscription: acknowledgeUnsubscription,
          },
        ),
        returnValueForMissingStub: null,
      );
}
