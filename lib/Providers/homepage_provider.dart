import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:github_repos_app/Services/apis.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class HomePageFunctions extends ChangeNotifier {
  List replyresponseget = [];

  firstLoad() async {
    var url = Uri.parse("${ApiClass().getGitHubRepoUrl}");
    final res = await http.get(url);
    var replyresponse = json.decode(res.body);
    replyresponseget = replyresponseget + replyresponse["items"];
    notifyListeners();
  }
}
