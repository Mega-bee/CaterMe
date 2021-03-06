import 'package:CaterMe/IntroTest/size_config.dart';
import 'package:CaterMe/Providers/user.dart';
import 'package:CaterMe/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../NavigationBar/navigation_bar.dart';
import '../language/language.dart';
import 'on_boarding_contant.dart';

class  Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int currentPage = 0;
  List<Map<String, String>> onBoardingData = [
    {
      'text': '',
      'image': 'images/IntroductionScreen/introductionscreen04.png',
    },
    {
      'text': '',
      'image': 'images/IntroductionScreen/introductionscreen01.png',
    },
    {
      'text': '',
      'image': 'images/IntroductionScreen/introductionscreen02.png',
    },
    {
      'text': '',
      'image': 'images/IntroductionScreen/introductionscreen03.png',
    },


  ];

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<UserProvider>(context, listen: true);
    final userprovider=Provider.of<UserProvider>(context,listen: true);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 9,
              child: PageView.builder(
                  onPageChanged: (value) {
                    setState(() {
                      currentPage = value;
                    });
                  },
                  itemCount: onBoardingData.length,
                  itemBuilder: (context, index) => OnBoardingContent(
                    text: onBoardingData[index]['text'],
                    image: onBoardingData[index]['image'],
                  )),
            ),
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      onBoardingData.length,
                          (index) => buildDot(index),
                    ),
                  ),
                  Spacer(
                    flex: 1,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: getScreenHeight(60),
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      color: Colors.white,
                      onPressed: ()  async{
                        SharedPreferences sh= await SharedPreferences.getInstance();
                        sh.setBool("wlkdone", true);
                        userprovider.language=sh.getString("locale");


                        userprovider.status=Status.Unauthenticated;
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) =>
                                Navigationbar(0)));
                        //  onDone(context);
                      },
                      child: Text('${authProvider.lg[authProvider.language]["Get Started"]}'
                       ,
                        style: TextStyle(
                          fontSize: 18,
                          color: colorCustom,
                        ),
                      ),
                    ),
                  ),
                //  Spacer(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  AnimatedContainer buildDot(int index) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      margin: EdgeInsets.only(right: 5),
      width: currentPage == index ? 20 : 6,
      height: 6,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3),
        color: currentPage == index ? colorCustom: redColor,
      ),
    );
  }
}
