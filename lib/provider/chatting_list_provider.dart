import 'package:flutter/material.dart';

class ChattingListProvider extends ChangeNotifier {
  final List<Map<String, dynamic>> _chattingList = [];
  List<Map<String, dynamic>> get chattingList => _chattingList;
  void addChattingList(Map<String, dynamic> item) {
    _chattingList.add(item);
    notifyListeners();
  }
}
