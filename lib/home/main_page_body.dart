import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:my_app/utils/app_colors.dart';
import 'package:my_app/utils/dimensions.dart';
import 'package:my_app/widgets/small_text.dart';

import '../widgets/big_text.dart';
import '../widgets/icon_and_text_widget.dart';

class MainPageBody extends StatefulWidget {
  const MainPageBody({Key? key}) : super(key: key);

  @override
  MainPageBodyState createState() => MainPageBodyState();
}

class MainPageBodyState extends State<MainPageBody> {
  PageController _pageController = PageController(viewportFraction: 0.9);
  var _currentPageValue = 0.0;
  double _scaleFactor = 0.8;
  double _height = Dimensions.pageViewContainer;
  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPageValue = _pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _sliceList(),
        _dotIndicator(),
      ],
    );
  }

  Widget _sliceList() {
    return Container(
      height: 320,
      child: PageView.builder(
          controller: _pageController,
          itemCount: 5,
          itemBuilder: (context, position){
            return _buildPageItem(position);
          }),
    );
  }

  Widget _buildPageItem(int index) {
    Matrix4 matrix = Matrix4.identity();
    if(index == _currentPageValue.floor()) {
      var currScale = 1 - (_currentPageValue - index)*(1-_scaleFactor);
      var currTranslation = _height * (1- currScale)/2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTranslation, 0);
    } else if(index == _currentPageValue.floor() + 1) {
      var currScale = _scaleFactor + (_currentPageValue - index + 1)*(1-_scaleFactor);
      var currTranslation = _height * (1- currScale)/2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTranslation, 0);
    } else if(index == _currentPageValue.floor() - 1) {
      var currScale = 1 - (_currentPageValue - index)*(1-_scaleFactor);
      var currTranslation = _height * (1- currScale)/2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTranslation, 0);
    } else {
      var currScale = _scaleFactor;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, _height * (1- currScale)/2, 1);
    }

    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          Container(
            height: Dimensions.pageViewContainer,
            margin: EdgeInsets.only(left: 10, right: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: index.isEven ? Color(0xFF69c5df): Color(0xFF9294cc),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage("assets/images/food_1.jpg"),
                )
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: Dimensions.pageViewTextContainer,
              margin: EdgeInsets.only(left: 25, right: 25, bottom: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFFe8e8e8),
                    blurRadius: 5.0,
                    offset: Offset(0, 5),
                  ),
                  BoxShadow(
                    color: Colors.white,
                    offset: Offset(-5, 0),
                  ),
                  BoxShadow(
                    color: Colors.white,
                    offset: Offset(5, 0),
                  )
                ]
              ),
              child: Container(
                padding: EdgeInsets.only(top: 15, left: 15, right: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BigText(text: "Chinese Side"),
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        Wrap(
                          children: List.generate(5, (index) {return Icon(Icons.star, color: AppColors.mainColor, size: 15);}),
                        ),
                        SizedBox(width: 10,),
                        SmallText(text: "4.5"),
                        SizedBox(width: 10,),
                        SmallText(text: "1222"),
                        SizedBox(width: 5,),
                        SmallText(text: "comments"),
                      ]
                    ),
                    SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconAndTextWidget(
                          text: "Normal",
                          icon: Icons.circle_sharp,
                          iconColor: AppColors.iconColor1,
                        ),
                        IconAndTextWidget(
                          text: "1.3km",
                          icon: Icons.location_on,
                          iconColor: AppColors.mainColor,
                        ),
                        IconAndTextWidget(
                          text: "32min",
                          icon: Icons.access_time_rounded,
                          iconColor: AppColors.iconColor2,
                        ),
                      ],
                    ),
                  ],
                )
              )
            ),
          )
        ],
      ),
    );
  }

  Widget _dotIndicator() {
    return new DotsIndicator(
      dotsCount: 5,
      position: _currentPageValue,
      decorator: DotsDecorator(
        size: const Size.square(9.0),
        activeSize: const Size(18.0, 9.0),
        activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        activeColor: AppColors.mainColor,
      ),
    );
  }
}
