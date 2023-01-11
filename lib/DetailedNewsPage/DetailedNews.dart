import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailedNews extends StatefulWidget {
  String? img,date,title,author,desc,url;
    DetailedNews({Key? key}) : super(key: key);


  DetailedNews.detail(this.img, this.date, this.title, this.author, this.desc,this.url);

  @override
  State<DetailedNews> createState() => _DetailedNewsState();
}

class _DetailedNewsState extends State<DetailedNews> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
          Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  height:300.h ,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    image: DecorationImage(
                        image: NetworkImage(this.widget.img.toString()=="null"?
                        "https://shahpourpouyan.com/wp-content/uploads/2018/10/orionthemes-placeholder-image-1.png"
                            :this.widget.img.toString()),
                    fit: BoxFit.cover)
                  ),
                )),
            Positioned(
                top: 374.h,
                left: 0,
                right: 0,
                child: Container(
                  height:438.h,
                  width: double.infinity,

                  decoration: BoxDecoration(
                      color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(24),
                      topLeft: Radius.circular(24)
                    ),


                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15.0,right: 15),
                    child: Column(
                      children: [
                        SizedBox(height: 88,),
                        Text(this.widget.desc.toString()=="null"?
                          "No Description found!!":
                        this.widget.desc.toString()
                          ,
                        style: GoogleFonts.nunito(fontSize: 14,color: Colors.black,fontWeight: FontWeight.w900),
                        ),
                        InkWell(
                            onTap: (){
                              Uri uri=Uri.parse(this.widget.url.toString());
                              _launchInWebViewOrVC(uri);
                            },
                            child: Text("Read full Article..",style: GoogleFonts.lato(color: Colors.blue,fontSize: 14),))
                      ],
                    ),

                  ),
                )),
            Positioned(
                top: 235.h,
                left: 32.h,
                right: 32.h,
                child: Container(

                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(245, 245, 245, 0.9),
                    borderRadius: BorderRadius.circular(16),

                  ),
                  child: Padding(
                    padding:   EdgeInsets.fromLTRB(24,16,24,16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(this.widget.date.toString()=="null"?
                          "No Content Found!!"
                            :this.widget.date.toString()
                          ,style: GoogleFonts.nunito(fontSize: 12,color: Colors.black,fontWeight: FontWeight.w600),),
                        SizedBox(height: 8,),
                        Text(this.widget.title.toString()=="null"?
                        "No Content Found!!"
                            :this.widget.title.toString(),
                          style: GoogleFonts.poppins(fontSize: 16,color: Colors.black,fontWeight: FontWeight.w700),),
                        SizedBox(height: 8,),
                        Text(this.widget.author.toString()=="null"? "UnAuthorised"
                          :this.widget.author.toString(),style: GoogleFonts.nunito(fontSize: 10,color: Colors.black,fontWeight: FontWeight.w800),),
                      ],
                    ),
                  ),
                )),
            Align(
                alignment: Alignment.topLeft,
                child: IconButton(onPressed: (){
                  Navigator.maybePop(context);
                }, icon: Icon(Icons.arrow_back_ios,size: 25,color: Colors.white,))),

          ],
        ),
      ),
    );
  }
  Future<void> _launchInWebViewOrVC(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.inAppWebView,
      webViewConfiguration: const WebViewConfiguration(
          headers: <String, String>{'my_header_key': 'my_header_value'}),
    )) {
      throw 'Could not launch $url';
    }
  }
}
