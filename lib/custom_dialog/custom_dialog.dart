import 'package:flutter/material.dart';
import 'package:plants_world/controllers/myPlantsController.dart';
import 'package:plants_world/theme/constants.dart';

class CustomDialog extends StatelessWidget {
  final String plantName;
  final String photo;
  final int wateringTime;

  const CustomDialog({Key key, this.plantName, this.photo, this.wateringTime})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PlantsController _controller = PlantsController();

    return Dialog(
      child: Container(
        height: MediaQuery.of(context).size.height * .50,
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildSvgPicture(context, photo),
            SizedBox(height: 6),
            buildCongratsText(context),
            SizedBox(height: 8),
            // buildYouMadeText(context),
            // SizedBox(height: 6),
            // buildPointText(context),
            // SizedBox(height: 6),
            // buildSecondsText(context),
            // SizedBox(height: 12),
            buildOkButton(context, _controller, plantName, wateringTime),
          ],
        ),
      ),
    );
  }

  Expanded buildSvgPicture(context, photo) {
    return Expanded(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Image.network(
          "$photo",
          width: MediaQuery.of(context).size.height * .30,
          height: MediaQuery.of(context).size.height * .30,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Center buildCongratsText(BuildContext context) {
    return Center(
      child: Text(
        "$plantName bitkisini sulama zamanı geldi!",
        style: Theme.of(context)
            .textTheme
            .headline6
            .copyWith(color: AppConstants.green),
      ),
    );
  }

  Text buildYouMadeText(BuildContext context) {
    return Text(
      "You made it in",
      style: Theme.of(context).textTheme.bodyText1.copyWith(
            color: AppConstants.lightRed,
            fontWeight: FontWeight.w500,
          ),
    );
  }

  // Text buildPointText(BuildContext context) {
  //   return Text(
  //     point.toString(),
  //     style: Theme.of(context).textTheme.headline4.copyWith(
  //           color: AppConstants.green,
  //         ),
  //   );
  // }

  Text buildSecondsText(BuildContext context) {
    return Text(
      "seconds!",
      style: Theme.of(context).textTheme.bodyText2.copyWith(
            color: Colors.red,
            fontWeight: FontWeight.w500,
          ),
    );
  }

  ElevatedButton buildOkButton(
      context, _controller, String plantName, int wateringTime) {
    return ElevatedButton.icon(
      onPressed: () {
        _controller.setWater(plantName: plantName, wateringTime: wateringTime);
        Navigator.pushNamed(context, '/navigation');
      },
      icon: Icon(
        Icons.done_rounded,
        color: Colors.blueGrey,
      ),
      label: Text(
        'Şimdi Sula',
        style:
            Theme.of(context).textTheme.button.copyWith(color: Colors.yellow),
      ),
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 30),
        primary: Colors.amber,
      ),
    );
  }
}
