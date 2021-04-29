import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
//import 'package:flutter_svg/flutter_svg.dart';
import 'package:plants_world/theme/constants.dart';

class LandingPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        color: AppConstants.lightPurple,
        height: size.height,
        width: double.infinity,
        child: Column(
          //alignment: Alignment.center,
          //children: <Widget>[Image(image: AssetImage('assets/plant.jpg'),width: 200, height: 200,)],
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 150),
              child: SvgPicture.asset("svg/Flowers-amico.svg",width: 200,height: 200),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FlatButton(
                  minWidth: 250,
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                  color: AppConstants.purple,
                  onPressed: (){},
                  child: Text("Login"),
                  textColor: Colors.white,),),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FlatButton(

                  minWidth: 250,
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                  color: Colors.white,
                  onPressed: (){},
                  child: Text("Sign Up"),
                  textColor: AppConstants.purple),),
            )
          //FlatButton(color: Colors.white ,onPressed: (){}, child: Text("Sign Up"), textColor: AppConstants.purple,),
        ]),

      ),
    );
  }

}
