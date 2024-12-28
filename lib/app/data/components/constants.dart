import 'package:flutter/material.dart';

class APIConstant {
  static String login = '/auth/login';

  // For question api
  static String getAllQue = '/question/getAll';
  static String addQue = '/question/create';
  static String questionAnalysis = '/question/questionAnalysis';
  static String deleteQue = '/question/delete';
  static String updateQue = '/question/update';
  static String addQueByLang = '/question/add-question-language';
  static String getQueAnsWithUser = '/question/getQuestionWithUser';

  // static String getAllQue = '/question/getAll';

  // For User api
  static String getUser = '/user/getAll';

  // For User chapter
  static String getChapter = '/chapter/getAll';
  static String addChapter = '/chapter/create';
  static String updateChapter = '/chapter/update';
  static String deleteChapter = '/chapter/delete';

  // For User chapter
  static String getModule = '/module/getAll';
  static String addModule = '/module/create';
  static String updateModule = '/module/update';
  static String deleteModule = '/module/delete';

  // For user
  static String unlockSubscription = '/subscription/create';
  static String unlockChapterTimer = '/chapterAccess';
  static String deleteUser = '/delete';

  static String userList = '/users-list';
  static String chapterList = '/chapter-list';
  static String moduleList = '/module-list';
  static String questionList = '/question-list';

  // static String addChapter = '/add-chapter';
  // static String addModules = '/add-module';
  static String chapterEditPost = '/chapter-edit-post';
  static String chapterDelete = '/chapter-delete';
  static String moduleEditPost = '/module-edit-post';
  static String moduleDelete = '/module-delete';
  static String addQuestion = '/question-add';
  static String questionEditPost = '/question-edit-post';
  static String questionDelete = '/question-delete';
  static String userEditAccess = '/user-edit-access';
}

disposeKeyBoard() {
  FocusManager.instance.primaryFocus?.unfocus();
}
