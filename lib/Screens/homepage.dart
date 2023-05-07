import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:github_repos_app/Providers/homepage_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    print("ffff");
    super.initState();
      Provider.of<HomePageFunctions>(context, listen: false).firstLoad();
     Provider.of<HomePageFunctions>(context, listen: false).controller = ScrollController()..addListener(() {
      Provider.of<HomePageFunctions>(context, listen: false).loadMore();
     });
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 209, 200, 200),
      appBar: AppBar(
        centerTitle: true,
        title: Text('Github Repo List'),
        backgroundColor: Colors.blue,
      ),
      body:Provider.of<HomePageFunctions>(context, listen: true).isFirstLoadRunning == true ? Center(child: CircularProgressIndicator()) :
       SingleChildScrollView(
         child: Container(
           child: Column(
            children: [
              Container(
                height: h,
                width: w,
                child:  ListView.builder(
                      controller: Provider.of<HomePageFunctions>(context, listen: false).controller,
                        itemCount:Provider.of<HomePageFunctions>(context, listen: false).isLoadMoreRunning ?
                         Provider.of<HomePageFunctions>(context, listen: false).replyresponseget.length + 1 : 
                         Provider.of<HomePageFunctions>(context, listen: false).replyresponseget.length,
                        itemBuilder: (context, index) => Container(
                              height: h * 0.4,
                              width: w,
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.white.withOpacity(0.8)),
                              margin: EdgeInsets.all(14),
                              child: Stack(children: [
                                Positioned(
                                  top: h * 0.04,
                                  left: w * 0.38,
                                  child: Container(
                                    height: 70,
                                    width: 70,
                                    child: CircleAvatar(
                                      backgroundImage: NetworkImage(
                                          "${Provider.of<HomePageFunctions>(context, listen: false).replyresponseget[index]["owner"]["avatar_url"]}"),
                                    ),
                                  ),
                                ),
                                Positioned(
                                    top: 110,
                                    child: Container(
                                        width: w,
                                        child: Center(
                                            child: Text(
                                          "${Provider.of<HomePageFunctions>(context, listen: false).replyresponseget[index]["name"]}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold, fontSize: 20),
                                        )))),
                                Positioned(
                                    top: 124,
                                    child: Container(
                                        padding: EdgeInsets.all(20),
                                        width: w,
                                        child: Center(
                                            child:
                                                Wrap(direction: Axis.horizontal, children: [
                                          Text(
                                            "${Provider.of<HomePageFunctions>(context, listen: false).replyresponseget[index]["description"]}",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15,
                                                overflow: TextOverflow.ellipsis),
                                          )
                                        ])))),
                                        Positioned(
                                          top: h * 0.3,
                                          left: w * 0.2,
                                          child: Container(
                                            child: RatingBar.builder(
                                              initialRating: Provider.of<HomePageFunctions>(context,listen: false).replyresponseget[index]["score"],
                                              maxRating: Provider.of<HomePageFunctions>(context,listen: false).replyresponseget[index]["score"],
                                              itemCount: 5,
                                              itemBuilder: (context,_)=>Icon(
                                              Icons.star,
                                              color: Colors.yellow,
                                            ), onRatingUpdate: (double value) { 
                                              
                                             },),
                                          ),
                                        )
                              ]),
                            ))
              ),
              if(Provider.of<HomePageFunctions>(context,listen: false).isLoadMoreRunning == true)
              const Padding(padding: EdgeInsets.only(top: 10, bottom: 40),
              child: Center(
                child: CircularProgressIndicator(),
              ),
              ),
              if(Provider.of<HomePageFunctions>(context,listen: false).isLoadMoreRunning == false)
               const Padding(padding: EdgeInsets.only(top: 10, bottom: 40),
              child: Center(
                child: Text('All content'),
              ),
              ),
            ],
               ),
         ),
       ),
    );
  }
}
