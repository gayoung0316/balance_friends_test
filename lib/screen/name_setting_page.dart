import 'package:balance_friends_test/provider/user_setting_provider.dart';
import 'package:balance_friends_test/screen/friend_list_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NameSettingPage extends StatefulWidget {
  final bool isFirst;
  const NameSettingPage({Key? key, this.isFirst = false}) : super(key: key);

  @override
  State<NameSettingPage> createState() => _NameSettingPageState();
}

class _NameSettingPageState extends State<NameSettingPage> {
  final TextEditingController _nameSettingController = TextEditingController();
  late UserSettingProvider userSettingProvider;

  @override
  Widget build(BuildContext context) {
    userSettingProvider = Provider.of<UserSettingProvider>(context);

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            Visibility(
              visible: !widget.isFirst,
              child: Positioned(
                top: 0,
                left: 10,
                child: IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  iconSize: 40,
                  icon: const Icon(
                    Icons.keyboard_arrow_left_outlined,
                  ),
                ),
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    '이름 설정',
                    textScaleFactor: 1.0,
                    style: TextStyle(
                      color: Color(0xff362E27),
                      fontWeight: FontWeight.bold,
                      fontSize: 36,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    '앱 내에서 사용하실\n이름을 알려주세요!',
                    textScaleFactor: 1.0,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xff22232B),
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    widget.isFirst
                        ? '(*) 나중에 이름을 수정할 수 있습니다'
                        : '현재 설정된 이름은 ${userSettingProvider.userName}입니다',
                    textScaleFactor: 1.0,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color(0xff22232B).withOpacity(0.6),
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 70),
                  Container(
                    height: 52,
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: const Color(0xffffffff),
                      borderRadius: BorderRadius.circular(32),
                    ),
                    child: TextField(
                      controller: _nameSettingController,
                      maxLength: 10,
                      onChanged: (value) {
                        setState(() {});
                      },
                      decoration: const InputDecoration(
                        hintText: '10자 이내로 작성해주세요',
                        hintStyle: TextStyle(
                          color: Color(0xffC8C8CB),
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(left: 20),
                        counterText: '',
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Visibility(
                    visible: _nameSettingController.text.isNotEmpty &&
                        _nameSettingController.text.trim().isNotEmpty,
                    child: InkWell(
                      onTap: () {
                        userSettingProvider.userName =
                            _nameSettingController.text;

                        if (widget.isFirst) {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const FriendListPage(),
                            ),
                            (route) => false,
                          );
                        } else {
                          Navigator.pop(context);
                        }
                      },
                      child: const Text(
                        '설정 완료',
                        textScaleFactor: 1.0,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xff22232B),
                          fontWeight: FontWeight.w400,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
