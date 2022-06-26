import 'package:balance_friends_test/provider/chatting_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'widget/chat_bubble_widget.dart';

class ChattingScreenPage extends StatefulWidget {
  final String name;
  const ChattingScreenPage({Key? key, required this.name}) : super(key: key);

  @override
  State<ChattingScreenPage> createState() => _ChattingScreenPageState();
}

class _ChattingScreenPageState extends State<ChattingScreenPage> {
  final ImagePicker _picker = ImagePicker();
  late ChattingListProvider chattingListProvider;
  final TextEditingController _chattingTextController = TextEditingController();

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      context.read<ChattingListProvider>().addChattingList(
        {
          'isMe': false,
          'isSendedImage': false,
          'text': '${widget.name}님과의 채팅방입니다.\n자유롭게 이야기를 나눠주세요!',
        },
      );
    });
    super.initState();
  }

  Future<void> getGalleryImage() async {
    var pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    chattingListProvider.addChattingList(
      {
        'isMe': true,
        'isSendedImage': true,
        'text': pickedFile!.path,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    chattingListProvider = Provider.of<ChattingListProvider>(context);

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: SafeArea(
          bottom: false,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      chattingListProvider.chattingList.clear();
                      Navigator.pop(context);
                    },
                    iconSize: 40,
                    icon: const Icon(
                      Icons.keyboard_arrow_left_outlined,
                    ),
                  ),
                  Text(
                    widget.name,
                    textScaleFactor: 1.0,
                    style: const TextStyle(
                      color: Color(0xff000000),
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                  const SizedBox(height: 40, width: 40),
                ],
              ),
              const SizedBox(height: 10),
              const Divider(
                color: Color(0xffE0DEDB),
                thickness: 2,
                height: 0,
              ),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.only(top: 38),
                  children: [
                    ...chattingListProvider.chattingList.map(
                      (item) => ChatBubbleWidget(
                        text: item['text']!,
                        isMe: item['isMe']!,
                        isSendedImage: item['isSendedImage'],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 105,
                child: Column(
                  children: [
                    const Divider(
                      color: Color(0xffE0DEDB),
                      thickness: 2,
                      height: 0,
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            padding: EdgeInsets.zero,
                            onPressed: () => openGalleryImageDialog(),
                            iconSize: 20,
                            icon: const Icon(
                              Icons.add_a_photo,
                            ),
                          ),
                          Expanded(
                            flex: 4,
                            child: Container(
                              height: 52,
                              decoration: BoxDecoration(
                                color: const Color(0xffffffff),
                                borderRadius: BorderRadius.circular(32),
                              ),
                              child: TextField(
                                controller: _chattingTextController,
                                maxLines: null,
                                onChanged: (value) {
                                  setState(() {});
                                },
                                decoration: const InputDecoration(
                                  hintText: '메세지를 작성해주세요',
                                  hintStyle: TextStyle(
                                    color: Color(0xffC8C8CB),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15,
                                  ),
                                  border: InputBorder.none,
                                  contentPadding:
                                      EdgeInsets.only(left: 20, right: 20),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            flex: 1,
                            child: InkWell(
                              onTap: () {
                                if (_chattingTextController.text.isNotEmpty &&
                                    _chattingTextController.text
                                        .trim()
                                        .isNotEmpty) {
                                  chattingListProvider.addChattingList(
                                    {
                                      'isMe': true,
                                      'isSendedImage': false,
                                      'text': _chattingTextController.text,
                                    },
                                  );
                                  FocusScope.of(context).unfocus();
                                  _chattingTextController.clear();
                                }
                              },
                              child: Container(
                                height: 52,
                                decoration: BoxDecoration(
                                  color:
                                      _chattingTextController.text.isNotEmpty &&
                                              _chattingTextController.text
                                                  .trim()
                                                  .isNotEmpty
                                          ? const Color(0xffF1EBE5)
                                          : const Color(0xffE0DEDB),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  '전송',
                                  textScaleFactor: 1.0,
                                  style: TextStyle(
                                    color: _chattingTextController
                                                .text.isNotEmpty &&
                                            _chattingTextController.text
                                                .trim()
                                                .isNotEmpty
                                        ? const Color(0xff22232B)
                                        : const Color(0xffC8C7CB),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void openGalleryImageDialog() {
    showDialog(
      barrierColor: const Color.fromRGBO(7, 6, 6, 0.5),
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          backgroundColor: Colors.transparent,
          content: Container(
            width: 300,
            height: 200,
            decoration: BoxDecoration(
              color: const Color(0xffffffff),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    '이미지 전송을 위해\n갤러리로 이동하시겠습니까?',
                    textAlign: TextAlign.center,
                    textScaleFactor: 1.0,
                    style: TextStyle(
                      color: Color(0xff22232B),
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                          getGalleryImage();
                        },
                        child: Container(
                          width: 112,
                          height: 48,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: const Color(0xffF1EBE5),
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: const Text(
                            '네',
                            textScaleFactor: 1.0,
                            style: TextStyle(
                              color: Color.fromRGBO(97, 97, 97, 1),
                              fontSize: 15,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          width: 112,
                          height: 48,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: const Color(0xffF1EBE5),
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: const Text(
                            '아니오',
                            textScaleFactor: 1.0,
                            style: TextStyle(
                              color: Color.fromRGBO(97, 97, 97, 1),
                              fontSize: 15,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
