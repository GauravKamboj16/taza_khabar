import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:taza_khabar/DetailedNewsPage/DetailedNews.dart';
import 'package:taza_khabar/LandingPage/Controller/HeadlinesController.dart';
import 'package:taza_khabar/LandingPage/Model/NewsModel.dart';

import '../Controller/HomePageController.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {

  //Same page UI
  var isLoading=false;
  late NewsModel mNewsModel;

  ////
  var category="health";
  var selectedCategory=0;
  final List<String> catList=["Health","Sports","Entertainment","General","Science","Business","Technology"];
  MyHomePageController _controller=Get.put(MyHomePageController("sports"));
  HeadlinesController _headlinesController=Get.put(HeadlinesController());


  bool isCatSelected=false;

  @override
  void initState() {

    // TODO: implement initState
    getNews("sports");


    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() =>(_controller.isLoading ==true?
          Center(child: CircularProgressIndicator()):
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(children: [
              SizedBox(height: 2.h,),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 32.h,
                    width: 296.w,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey,
                              blurRadius: 0.5,
                              spreadRadius: 0.5,
                              offset: Offset(0, 0.5)
                          )
                        ]
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: 12),
                      child: TextField(
                        style: TextStyle(
                            fontSize: 12
                        ),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.zero,
                          hintText: 'Search News.',
                          hintStyle: TextStyle(fontSize: 12),
                          suffixIcon: IconButton(onPressed: () {},
                              icon: Icon(Icons.search, size: 12,)),
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,

                        ),
                      ),
                    ),

                  ),
                  Spacer(),
                  Container(
                    height: 32.h,
                    width: 32.w,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,

                        //#FF3A44  #FF8086
                        // gradient: LinearGradient(colors: [Color(0xFF3A44),Color(0xFF8086)],
                        gradient: LinearGradient(colors: [
                          Colors.red,
                          Colors.redAccent
                        ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight
                        )
                    ),
                    child: Center(
                      child: IconButton(onPressed: () {}, icon: Icon(
                        Icons.notifications, color: Colors.white, size: 13,)),),
                  ),


                ],
              ),
              SizedBox(height: 24.h,),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Latest News", style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w700),),
                  Text("See All  -->", style: TextStyle(color: Colors.blue,
                      fontSize: 12,
                      fontWeight: FontWeight.w600),)
                ],
              ),
              SizedBox(height: 24.h,),
              Container(
                height: 240.h,
                width: 345.w,
                child: _headlinesController.isLoading==true?Center(
                    child: CircularProgressIndicator()):ListView.separated(
                  scrollDirection: Axis.horizontal,
                    separatorBuilder: (BuildContext context, int index){
                  return SizedBox(width: 5,);
                    },
                    itemCount: _headlinesController.newsModel!.articles!.length,
                  itemBuilder: (context,index){
                      return Container(
                        height: 240.h,
                        width: 345.w,
                        decoration: BoxDecoration(
                          image: DecorationImage(image: NetworkImage(_headlinesController.newsModel!.articles!.elementAt(index).urlToImage.toString()=="null"?
                          "https://shahpourpouyan.com/wp-content/uploads/2018/10/orionthemes-placeholder-image-1.png"
                              :_headlinesController.newsModel!.articles!.elementAt(index).urlToImage.toString()),
                          fit: BoxFit.cover),
                          borderRadius: BorderRadius.circular(12)
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                                top: 80.h,
                                left: 8.w,
                                right: 8.w,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("by ${_headlinesController.newsModel!.articles!.elementAt(index).author.toString()}",
                                    style: GoogleFonts.nunito(fontSize:10 ,color:Colors.white ,fontWeight: FontWeight.w800),),
                                    Text("${_headlinesController.newsModel!.articles!.elementAt(index).title.toString()}",
                                      maxLines: 3,
                                      style: GoogleFonts.poppins(fontSize:16 ,color:Colors.white ,fontWeight: FontWeight.w700,),),


                                  ],
                                )),
                            Positioned(
                                top: 188.h,
                                left: 8,
                                right: 8.w,
                                child: Text(maxLines: 2,"${_headlinesController.newsModel!.articles!.elementAt(index).description.toString()}",
                                  style: GoogleFonts.nunito(fontSize:10 ,color:Colors.white ,fontWeight: FontWeight.w400),),
                            )
                          ],
                        ),

                      );
                  },
                ),
              ),
              // ClipRRect(
              //   borderRadius: BorderRadius.circular(12),
              //   child: Image.network(
              //     fit: BoxFit.cover,
              //     'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
              //     height: 240.h,
              //     width: 345.w,),
              // ),
              SizedBox(height: 24.h,),
              Container(
                height: 32,
                width: double.infinity,
                child:ListView.separated(
                  itemCount: catList.length,

                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {

                        setState(() {
                          isLoading=false;
                          selectedCategory = index;

                          getNews(catList.elementAt(index).toLowerCase());

                          print(_controller.category);
                        });
                      },
                      child: Container(
                        height: 32,
                        width: 95,
                        decoration: BoxDecoration(

                          borderRadius: BorderRadius.circular(15),
                          gradient: index == selectedCategory ? LinearGradient(
                              colors: [Color(0xffFF3A44), Color(0xffFF8086),
                                Color(0xffFFB3B6)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight
                          ) : null,

                          color: Colors.white,
                        ),
                        child: Center(child: Text(
                          catList.elementAt(index).toString(), style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Colors.black),)),
                      ),
                    );
                  }, separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(width: 4,);
                },),
              ),
              SizedBox(height: 24.h,),
              Expanded(
                child: isLoading==true?
                Center(
                  child: CircularProgressIndicator(),
                ): ListView.separated(
                  itemCount: mNewsModel!.articles!.length,
                  itemBuilder: (context, index) {
                    print(mNewsModel!.articles!.elementAt(index).urlToImage.toString());
                    return

                      InkWell(
                        onTap: (){
                          var item=mNewsModel!.articles!.elementAt(index);
                          Get.to(DetailedNews.detail(item.urlToImage,
                              item.publishedAt,
                              item.title,
                              item.author,
                              item.content,
                              item.url
                          ));
                        },
                        child: Stack(
                          children: [
                            Container(
                              height: 128.h,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(12),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                        mNewsModel!.articles!.elementAt(index).urlToImage.toString()=="null"?
                                    "https://shahpourpouyan.com/wp-content/uploads/2018/10/orionthemes-placeholder-image-1.png":
                                        mNewsModel!.articles!.elementAt(index).urlToImage.toString() ),
                                  )
                              ),
                            ),
                            Positioned(
                              left: 16,
                              right: 16,
                              top: 8,
                              child: Text(

                                mNewsModel.articles!.elementAt(index).title.toString(),
                                maxLines:1,
                                style: GoogleFonts.poppins(fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),),

                            ),
                            Positioned(
                              left: 16,
                              top: 99.h,
                              child: Text(mNewsModel!.articles!.elementAt(index).author.toString(),
                                style: GoogleFonts.poppins(fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),),

                            ),
                            Positioned(
                              right: 16,
                              top: 99.h,
                              child: Text(mNewsModel!.articles!.elementAt(index).publishedAt.toString(),
                                  style: GoogleFonts.poppins(fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white)),

                            ),
                          ],
                        ),
                      );
                  }, separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(height: 8,);
                },),
              ),


            ],),
          ),
        )
      ),


    ));
  }
  Future<void> getNews(String cat)async{
    isLoading=true;

    try{
      Uri uri =Uri.parse("https://newsapi.org/v2/top-headlines?country=in&category=$cat&apiKey=c9054db6c62e41728890fd2db48a79e4");
      var res=await get(uri,
        //headers: {
        //"apiKey":"c9054db6c62e41728890fd2db48a79e4"
        //}
      );

      if(res.statusCode==200){
        print("${res.statusCode} Gourav");
        var result=jsonDecode(res.body);

        print("${res.statusCode} inClass Call by ME");
        setState((){
          mNewsModel=NewsModel.fromJson(result);
        });

        print(mNewsModel.articles!.length);



      }else{
        print("Error Status ${res.statusCode}");
      }


    }catch(e){
      print("Error: $e");

    }
    finally{
      isLoading=false;
    }

  }
}
