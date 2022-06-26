import 'package:balance_friends_test/model/friend_list.dart';
import 'package:balance_friends_test/provider/user_setting_provider.dart';
import 'package:balance_friends_test/screen/name_setting_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'chatting_screen_page.dart';

class FriendListPage extends StatefulWidget {
  const FriendListPage({Key? key}) : super(key: key);

  @override
  State<FriendListPage> createState() => _FriendListPageState();
}

class _FriendListPageState extends State<FriendListPage> {
  late UserSettingProvider userSettingProvider;

  @override
  Widget build(BuildContext context) {
    userSettingProvider = Provider.of<UserSettingProvider>(context);

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: ListView(
          padding: const EdgeInsets.only(top: 40),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${userSettingProvider.userName}님,\n만나서 반가워요!',
                    textScaleFactor: 1.0,
                    style: const TextStyle(
                      color: Color(0xff000000),
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const NameSettingPage(),
                        ),
                      );
                    },
                    padding: EdgeInsets.zero,
                    iconSize: 30,
                    icon: Icon(
                      Icons.settings,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 60),
            const Padding(
              padding: EdgeInsets.only(left: 20, bottom: 20),
              child: Text(
                '친구 목록',
                textScaleFactor: 1.0,
                style: TextStyle(
                  color: Color(0xff362E27),
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            ...friendList.map(
              (item) => friendInfoBox(item['name']!),
            ),
          ],
        ),
      ),
    );
  }

  Widget friendInfoBox(String name) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChattingScreenPage(name: name),
          ),
        );
      },
      child: Container(
        width: 374,
        height: 56,
        margin: const EdgeInsets.only(left: 20, right: 20, bottom: 18),
        decoration: BoxDecoration(
          color: const Color(0xffF1EBE5),
          borderRadius: BorderRadius.circular(8),
        ),
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(left: 20),
        child: Text(
          name,
          textScaleFactor: 1.0,
          style: const TextStyle(
            color: Color(0xff22232B),
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
