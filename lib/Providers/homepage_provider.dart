import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:github_repos_app/Services/apis.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
class HomePageFunctions extends ChangeNotifier {
  List replyresponseget = [];
  int page = 0;
  final int limit = 10;
  bool isFirstLoadRunning = false;
  bool hasNextPage = true;
  bool isLoadMoreRunning = false;
  late ScrollController controller;
  
 firstLoad() async {
  try {
    isFirstLoadRunning = true;
    var url = Uri.parse("${ApiClass().getGitHubRepoUrl}&per_page=$limit&page=$page");
    final res = await http.get(url);
    var replyresponse =  json.decode(res.body);
    replyresponseget = replyresponseget + replyresponse["items"];
    isFirstLoadRunning = false;
    notifyListeners();
  }
  catch (e){
   print("Error");
  }
  
}
 loadMore() async {
  if(controller.position.pixels == controller.position.maxScrollExtent){
    isLoadMoreRunning = true;
    page = page + 1;
    await firstLoad();
    isLoadMoreRunning = false;
    notifyListeners();
  }
}

}