import 'dart:convert';

import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import 'package:amazon_cognito_identity_dart_2/sig_v4.dart';
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';

part 'amazon_lex.g.dart';

enum DialogState {
  ElicitIntent,
  ConfirmIntent,
  ElicitSlot,
  Fulfilled,
  ReadyForFulfillment,
  Failed,
}

enum MessageFormat { PlainText, CustomPayload, SSML, Composite }

class AmazonLex {
  Future<LexResponse> postResponse(
    String text, {
    String userId = 'testuser123',
  }) async {
    final userPool = new CognitoUserPool(
      'us-east-1_mJ2rr10v6',
      '7ugeoran4o1m1in8vol70p15a5',
    );
    final cognitoUser = new CognitoUser('testuser', userPool,
        clientSecret: '1nr5b3ngac4t91po9nuvgrgtgb4upcbbmcc48s65pd3jrm88rc3t');
    final authDetails = new AuthenticationDetails(
      username: 'testuser',
      password: 'Test1234!',
    );
    CognitoUserSession session;
    try {
      session = await cognitoUser.authenticateUser(authDetails);
    } on CognitoUserNewPasswordRequiredException catch (e) {
      print('New Password Required');
    } on CognitoUserMfaRequiredException catch (e) {
      print('MFA Challenge');
    } on CognitoUserSelectMfaTypeException catch (e) {
      print('Select MFA Type');
    } on CognitoUserMfaSetupException catch (e) {
      print('Setup MFA');
    } on CognitoUserTotpRequiredException catch (e) {
      print('TOTP');
    } on CognitoUserCustomChallengeException catch (e) {
      print('Custom Challenge');
    } on CognitoUserConfirmationNecessaryException catch (e) {
      print('Confirmation Necessary');
    } on CognitoClientException catch (e) {
      print('Wrong username/password');
    } catch (e) {
      print(e);
    }
    print(session.getAccessToken().decodePayload());
    final credentials = new CognitoCredentials(
        'us-east-1:c18ae620-6bc0-4e41-af13-a27b2adfe541', userPool);
    await credentials.getAwsCredentials(session.getIdToken().getJwtToken());
    //await credentials.getGuestAwsCredentialsId();

    AwsSigV4Client client = AwsSigV4Client(
      credentials.accessKeyId,
      credentials.secretAccessKey,
      'https://runtime.lex.us-east-1.amazonaws.com',
      region: 'us-east-1',
      sessionToken: credentials.sessionToken,
      serviceName: 'lex',
    );
    final signedRequest = SigV4Request(
      client,
      method: 'POST',
      path: '/bot/SLHack/alias/slhack/user/$userId/text',
      headers: Map<String, String>.from({
        'Content-Type': 'application/json; charset=utf-8',
      }),
      body: Map<String, dynamic>.from({"inputText": text}),
    );

    final response = await http.post(
      signedRequest.url,
      headers: signedRequest.headers,
      body: signedRequest.body,
    );
    print('${response.statusCode} - ${response.body}');
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      var value = json.decode(response.body);
      return LexResponse.fromJson(value);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      return null;
    }
  }
}

@JsonSerializable(nullable: true)
class LexResponse {
  final DialogState dialogState;
  final String intentName, message;
  final MessageFormat messageFormat;
  final ResponseCard responseCard;
  final SentimentResponse sentimentResponse;
  final Map<String, String> sessionAttributes;
  final String sessionId;
  final Map<String, String> slots;
  final String slotToElicit;
  LexResponse(
      {this.dialogState,
      this.intentName,
      this.message,
      this.messageFormat,
      this.responseCard,
      this.sentimentResponse,
      this.sessionAttributes,
      this.sessionId,
      this.slots,
      this.slotToElicit});
  factory LexResponse.fromJson(Map<String, dynamic> json) =>
      _$LexResponseFromJson(json);
  Map<String, dynamic> toJson() => _$LexResponseToJson(this);
}

@JsonSerializable(nullable: true)
class ResponseCard {
  final String contentType;
  final List<GenericAttachment> genericAttachments;
  final String version;
  ResponseCard({this.contentType, this.genericAttachments, this.version});
  factory ResponseCard.fromJson(Map<String, dynamic> json) =>
      _$ResponseCardFromJson(json);
  Map<String, dynamic> toJson() => _$ResponseCardToJson(this);
}

@JsonSerializable(nullable: true)
class SentimentResponse {
  final String sentimentLabel;
  final String sentimentScore;
  SentimentResponse({this.sentimentLabel, this.sentimentScore});
  factory SentimentResponse.fromJson(Map<String, dynamic> json) =>
      _$SentimentResponseFromJson(json);
  Map<String, dynamic> toJson() => _$SentimentResponseToJson(this);
}

@JsonSerializable(nullable: true)
class GenericAttachment {
  final String attachmentLinkUrl;
  final List<Button> buttons;
  final String imageUrl;
  final String subTitle;
  final String title;
  GenericAttachment(
      {this.attachmentLinkUrl,
      this.buttons,
      this.imageUrl,
      this.subTitle,
      this.title});
  factory GenericAttachment.fromJson(Map<String, dynamic> json) =>
      _$GenericAttachmentFromJson(json);
  Map<String, dynamic> toJson() => _$GenericAttachmentToJson(this);
}

@JsonSerializable(nullable: true)
class Button {
  final String text, value;
  Button({this.text, this.value});
  factory Button.fromJson(Map<String, dynamic> json) => _$ButtonFromJson(json);
  Map<String, dynamic> toJson() => _$ButtonToJson(this);
}

@JsonSerializable(nullable: false)
class Payload {
  final String inputText;
  Payload({this.inputText});
  factory Payload.fromJson(Map<String, dynamic> json) =>
      _$PayloadFromJson(json);
  Map<String, dynamic> toJson() => _$PayloadToJson(this);
}
