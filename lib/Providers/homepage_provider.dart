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
  // getGithubRepo() async {
  //   var url = Uri.parse("${ApiClass().getGitHubRepoUrl}");
  //   print(url);
  //   var response = await http.get(url);
  //   var replyresponsedetails = json.decode(response.body);
  //   replyresponseget = replyresponsedetails["items"];
  //   print(replyresponseget);
  // }

 firstLoad() async {
  // isFirstLoadRunning = true;
  try {
    isFirstLoadRunning = true;
    var url = Uri.parse("${ApiClass().getGitHubRepoUrl}&per_page=$limit&page=$page");
    print(url);
    final res = await http.get(url);
    var replyresponse =  json.decode(res.body);
    replyresponseget = replyresponseget + replyresponse["items"];
    print(replyresponseget);
    print(replyresponseget.length);
    isFirstLoadRunning = false;
    print("nnnnn");
    print(isFirstLoadRunning);
    notifyListeners();
  }
  catch (e){
   print("Error");
  }
  
}
 loadMore() async {
  // if(hasNextPage == true && isFirstLoadRunning == false && isLoadMoreRunning == false 
  // ){
  //   isLoadMoreRunning = true;
  //   page += 1;
  //   try{
  //    var url = Uri.parse("${ApiClass().getGitHubRepoUrl}&page=$page&per_page=$limit");
  //   print(url);
  //   final res = await http.get(url);
  //   var replyresponse = json.decode(res.body);
  //   final List fetchedreplyresponseget = replyresponse["items"];
  //   if(fetchedreplyresponseget.isNotEmpty){
  //     replyresponseget = replyresponseget + fetchedreplyresponseget;
  //     notifyListeners();
  //   }
  //   else{
  //     hasNextPage = false;
  //     notifyListeners();
  //   }
  //   }
  //   catch (e){
  //     print("error 2");
  //   }
  //   isLoadMoreRunning = false;
  //   notifyListeners();
  // }
  if(controller.position.pixels == controller.position.maxScrollExtent){
    isLoadMoreRunning = true;
    page = page + 1;
    await firstLoad();
    isLoadMoreRunning = false;
    notifyListeners();
  }
}

}