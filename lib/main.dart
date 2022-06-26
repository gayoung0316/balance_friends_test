import 'package:balance_friends_test/provider/chatting_list_provider.dart';
import 'package:balance_friends_test/provider/user_setting_provider.dart';
import 'package:balance_friends_test/screen/login_page.dart';
import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:provider/provider.dart';

void main() {
  KakaoSdk.init(nativeAppKey: '3cad65feaaa0f00fb0f7dff183d91b52');
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserSettingProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ChattingListProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Balance Friends Test',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color(0xffF5F4F2),
      ),
      debugShowCheckedModeBanner: false,
      home: const LoginPage(),
    );
  }
}
