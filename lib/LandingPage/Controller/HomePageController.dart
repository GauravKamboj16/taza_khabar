import 'dart:convert';

import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart';
import 'package:taza_khabar/LandingPage/Model/NewsModel.dart';

class MyHomePageController extends GetxController{

  MyHomePageController(this.category);

  var isLoading=false.obs;
  NewsModel? newsModel;
  var category="health";


  @override
  void onInit() {
    // TODO: implement onInit
    getNews();
    super.onInit();
  }
  
  Future<void> getNews()async{
    isLoading(true);

    try{
      Uri uri =Uri.parse("https://newsapi.org/v2/top-headlines?country=in&category=${this.category}&apiKey=c9054db6c62e41728890fd2db48a79e4");
      var res=await get(uri,
      //headers: {
        //"apiKey":"c9054db6c62e41728890fd2db48a79e4"
      //}
      );

      if(res.statusCode==200){
        print("${res.statusCode} Gourav");
        var result=jsonDecode(res.body);

        newsModel=NewsModel.fromJson(result);


      }else{
        print("Error Status ${res.statusCode}");
      }


    }catch(e){
      print("Error: $e");

    }
    finally{
      isLoading(false);
    }

  }

}