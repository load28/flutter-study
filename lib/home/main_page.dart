import 'package:flutter/material.dart';
import 'package:my_app/utils/app_colors.dart';
import 'package:my_app/widgets/big_text.dart';

import 'main_page_body.dart';


class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  MyHomeState createState() => MyHomeState();
}


class MyHomeState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _header(),
          MainPageBody(),
        ],
      )
    );
  }

  Widget _header() {
    return Container(
      child: Container(
        margin: EdgeInsets.only(top: 45, bottom: 15),
        padding: EdgeInsets.only(left:20, right: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                BigText(text: "Derek seo", color: AppColors.mainColor),
              ],
            ),
            Center(
              child: Container(
                width: 45,
                height: 45,
                child: Icon(Icons.search, color: Colors.white),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: AppColors.mainColor,
                ),
              ),
            )
          ]
        )
      ),
    );
  }
}
