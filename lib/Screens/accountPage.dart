import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hotel_hunter/Models/appConstants.dart';

import 'guestHomePage.dart';
import 'hostHomePage.dart';
import 'loginPage.dart';
import 'personalInfoPage.dart';
import 'viewProfilePage.dart';

class AccountPage extends StatefulWidget {

  AccountPage({Key key}) : super(key: key);

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {

  String _hostingTitle = 'To Host Dashboard';

  void _logout() {
    Navigator.pushNamed(context, LoginPage.routeName);
  }

  void _changeHosting() {
    if (AppConstants.currentUser.isHost) {
      if (AppConstants.currentUser.isCurrentlyHosting) {
        AppConstants.currentUser.isCurrentlyHosting = false;
        Navigator.pushNamed(
          context,
          GuestHomePage.routeName,
        );
      } else {
        AppConstants.currentUser.isCurrentlyHosting = true;
        Navigator.pushNamed(
          context,
          HostHomePage.routeName,
        );
      }
    } else {
      AppConstants.currentUser.becomeHost().whenComplete(() {
        AppConstants.currentUser.isCurrentlyHosting = true;
        Navigator.pushNamed(
          context,
          HostHomePage.routeName,
        );
      });
    }

  }

  @override
  void initState() {
    if (AppConstants.currentUser.isHost) {
      if (AppConstants.currentUser.isCurrentlyHosting) {
        _hostingTitle = 'To Guest Dashboard';
      } else {
        _hostingTitle = 'To Host Dashboard';
      }
    } else {
      _hostingTitle = 'Become a host';
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 50, 20, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                MaterialButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ViewProfilePage(contact: AppConstants.currentUser.createContactFromUser(),),
                      ),
                    );
                  },
                  child: CircleAvatar(
                    backgroundColor: Colors.black,
                    radius: MediaQuery.of(context).size.width / 9.5,
                    child: CircleAvatar(
                      backgroundImage: AppConstants.currentUser.displayImage,
                      radius: MediaQuery.of(context).size.width / 10,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      AutoSizeText(
                        AppConstants.currentUser.getFullName(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                      AutoSizeText(
                        AppConstants.currentUser.email,
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          ListView(
            shrinkWrap: true,
            children: <Widget>[
              MaterialButton(
                height: MediaQuery.of(context).size.height / 9.0,
                onPressed: () {
                  Navigator.pushNamed(context, PersonalInfoPage.routeName);
                },
                child: AccountPageListTile(text: 'Personal Information', iconData: Icons.person,),
              ),
              MaterialButton(
                height: MediaQuery.of(context).size.height / 9.0,
                onPressed: _changeHosting,
                child: AccountPageListTile(text: _hostingTitle, iconData: Icons.hotel,),
              ),
              MaterialButton(
                height: MediaQuery.of(context).size.height / 9.0,
                onPressed: _logout,
                child: AccountPageListTile(text: 'Logout', iconData: null,),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class AccountPageListTile extends StatelessWidget {

  final String text;
  final IconData iconData;

  AccountPageListTile({Key key, this.text, this.iconData}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.all(0.0),
      leading: Text(
        this.text,
        style: TextStyle(
          fontSize: 25.0,
          fontWeight: FontWeight.normal
        ),
      ),
      trailing: Icon(
        this.iconData,
        size: 35.0,
      ),
    );
  }

}
