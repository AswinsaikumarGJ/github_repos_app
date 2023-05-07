import 'package:github_repos_app/Providers/homepage_provider.dart';
import 'package:provider/provider.dart';

class ApiClass {
  var getGitHubRepoUrl =
      'https://api.github.com/search/repositories?q=created:%3E2022-04-29&sort=stars&order=desc';
}
