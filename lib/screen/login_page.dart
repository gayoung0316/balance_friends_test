import 'dart:developer';

import 'package:balance_friends_test/screen/name_setting_page.dart';
import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Future<bool> kakaoLogin() async {
    try {
      late OAuthToken token;
      final isKakaoInstalled = await isKakaoTalkInstalled();

      if (isKakaoInstalled) {
        token = await UserApi.instance.loginWithKakaoTalk();
      } else {
        token = await UserApi.instance.loginWithKakaoAccount();
      }

      log('카카오톡으로 로그인 성공 ${token.accessToken}');
      return true;
    } catch (error) {
      log('카카오톡으로 로그인 실패 $error');
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '로그인',
              textScaleFactor: 1.0,
              style: TextStyle(
                color: Color(0xff362E27),
                fontWeight: FontWeight.bold,
                fontSize: 36,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              '원하는 서비스로 로그인하여\n다음 단계를 진행 해주세요',
              textScaleFactor: 1.0,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xff22232B),
                fontWeight: FontWeight.w400,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 66),
            loginBox(loginType: 1),
            const SizedBox(height: 20),
            loginBox(loginType: 2),
          ],
        ),
      ),
    );
  }

  Widget loginBox({
    required int loginType, // 카카오 로그인 : 1 / 게스트 로그인 : 2
  }) {
    return InkWell(
      onTap: () async {
        bool result = false;

        if (loginType == 1) {
          result = await kakaoLogin();
        } else {
          result = true;
        }

        if (result) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const NameSettingPage(isFirst: true),
            ),
            (route) => false,
          );
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        height: 48,
        decoration: BoxDecoration(
          color: const Color(0xffF1EBE5),
          borderRadius: BorderRadius.circular(8),
        ),
        alignment: Alignment.center,
        child: Text(
          '${loginType == 1 ? '카카오' : '게스트'} 계정으로 로그인',
          textScaleFactor: 1.0,
          style: const TextStyle(
            color: Color(0xff22232B),
            fontWeight: FontWeight.w400,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
