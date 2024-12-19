import 'package:flutter/material.dart';

class APIConstant {
  static String login = '/signup';
  static String deleteUser = '/user-delete';
  static String userList = '/users-list';
  static String chapterList = '/chapter-list';
  static String moduleList = '/module-list';
  static String questionList = '/question-list';
  static String addChapter = '/add-chapter';
  static String addModules = '/add-module';
  static String chapterEditPost = '/chapter-edit-post';
  static String chapterDelete = '/chapter-delete';
  static String moduleEditPost = '/module-edit-post';
  static String moduleDelete = '/module-delete';
  static String addQuestion = '/question-add';
  static String questionEditPost = '/question-edit-post';
  static String questionDelete = '/question-delete';
  static String questionAnalytics = '/question-analytics';
  static String unlockSubscription = '/subscription-post';
  static String userEditAccess = '/user-edit-access';
}

disposeKeyBoard() {
  FocusManager.instance.primaryFocus?.unfocus();
}
