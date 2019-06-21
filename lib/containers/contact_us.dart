import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:photo_share/utilities/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: iLColors.gradient2,
        title: Text('Contact us'),
      ),
      body: ListView(
        children: <Widget>[
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
//                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  //UrlLauncher.launch("tel://<phone_number>");
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Text(
                      'iLeaf Solutions',
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                  FlatButton(
                      onPressed: () async {
                        await mail("info@ileafsolutions.com");
                      },
                      child: Text(
                        'info@ileafsolutions.com',
                        style: TextStyle(color: iLColors.gradient2),
                      )),
                  FlatButton(
                    onPressed: () {
                      _launchURL() async {
                        const url = 'tel:+914842988403';
                        if (await canLaunch(url)) {
                          await launch(url);
                        } else {
                          throw 'Could not launch $url';
                        }
                      }

                      _launchURL();
                    },
                    child: Text("+91 484 298 8403"),
                  ),
                  FlatButton(
                    onPressed: () {
                      _launchURL() async {
                        const url = 'https://www.ileafsolutions.com';
                        if (await canLaunch(url)) {
                          await launch(url);
                        } else {
                          throw 'Could not launch $url';
                        }
                      }

                      _launchURL();
                    },
                    child: Text("https://www.ileafsolutions.com"),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Future mail(String emailId) async {
    final Email email = Email(
      body: '',
      subject: 'iNSTA CAPTURE APP',
      recipients: [emailId],
    );

    await FlutterEmailSender.send(email);
  }
}
