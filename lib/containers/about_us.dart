import 'package:flutter/material.dart';
import 'package:insta_capture/utilities/colors.dart';

class AboutUsView extends StatefulWidget {
  @override
  _AboutUsViewState createState() => _AboutUsViewState();
}

class _AboutUsViewState extends State<AboutUsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: iLColors.gradient2,
        title: Text('About us'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
            """iLeaf Solutions Pvt. Ltd. is a global player in consulting, designing and developing web and mobile solutions for businesses, departments and individuals. iLeaf Solutions has persistently positioned itself as a leading developer of mobile applications since its inception in 2007. Besides specialization in iPhone & iPad apps, Android apps, cross platform apps, Windows mobile apps, we have a robust inventory of web development.

        Established at Infopark in Kochi our company offers a rare blend of technology and creativity. It has attracted a wide range of clientele across the globe. Our team develops outstanding mobile apps encompassing varied genres, that cover enterprise mobility apps, e-learning apps, entertainment apps, social networking apps, communication / chat apps, booking apps, fitness/health care Apps, lifestyle apps, navigation apps, travel apps, productivity apps etc.. and quality games for iPhone, iPad and Android devices."""),
      ),
    );
  }
}
