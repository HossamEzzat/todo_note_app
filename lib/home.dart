import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff181818),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset("assets/images/logo.svg"),
                SizedBox(width: 16),
                Text(
                  "Tasky",
                  style: TextStyle(
                    fontFamily: "PlusJakartaSans",
                    color: Color(0xffffffff),
                    fontSize: 28,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            SizedBox(height: 108),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Welcome To Tasky ",
                  style: TextStyle(
                    fontFamily: "PlusJakartaSans",

                    color: Color(0xffFFFCFC),
                    fontSize: 24,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SvgPicture.asset("assets/images/hand.svg"),
              ],
            ),
            Text(
              "Your productivity journey starts here.",
              style: TextStyle(
                fontFamily: "PlusJakartaSans",
                color: Color(0xffFFFCFC),
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 24),
            Image.asset("assets/images/pana.png",width: 215,height: 204,),
            SizedBox(height: 28),
            ElevatedButton(onPressed: (){
            }, child: Text("Let’s Get Started"),style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xff15b86c),
              foregroundColor: Color(0xffFFFCFC),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              fixedSize: Size(343, 40),
            ),)

          ],
        ),
      ),
    );
  }
}
