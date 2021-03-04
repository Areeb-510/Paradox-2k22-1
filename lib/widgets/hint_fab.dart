import 'package:flutter/material.dart';
import 'package:flutter_boom_menu/flutter_boom_menu.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:paradox/models/brightness_options.dart';
import 'package:paradox/providers/question_provider.dart';
import 'package:paradox/providers/theme_provider.dart';
import 'package:paradox/providers/user_provider.dart';
import 'package:paradox/utilities/Toast.dart';
import 'package:provider/provider.dart';

class HintsFab extends StatefulWidget {
  @override
  _HintsFabState createState() => _HintsFabState();
}

class _HintsFabState extends State<HintsFab> {
  @override
  Widget build(BuildContext context) {
    void displayDialogforHint(
        {String title, String imgName, String text, Color color, int level}) {
      showDialog(
        context: context,
        builder: (context) => NetworkGiffyDialog(
          image: Image.asset("assets/images/hint.gif"),
          title: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600),
          ),
          description: Text(
            'Press $text to continue',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
          ),
          buttonOkColor: Colors.blue,
          buttonCancelColor: color,
          entryAnimation: EntryAnimation.RIGHT,
          buttonCancelText:
              Text("No", style: TextStyle(color: Colors.white, fontSize: 18)),
          buttonOkText:
              Text(text, style: TextStyle(color: Colors.white, fontSize: 18)),
          onCancelButtonPressed: () {
            Navigator.of(context).pop();
          },
          onOkButtonPressed: () async {
            showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) => SpinKitFadingGrid(
                      color: Colors.blue,
                    ));
            try {
              final resp =
                  await Provider.of<UserProvider>(context, listen: false)
                      .availHints();
              if (resp == true) {
                createToast("Hint successfully availed");
              }
              Navigator.of(context).pop();
              Navigator.of(context).pop();
              createToast("Hint availed Successfully");
            } catch (e) {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
              createToast("Please try again later. There was some issue.");
            }
          },
        ),
      );
    }

    final brightness = Provider.of<ThemeProvider>(context).brightnessOption;
    final hintList = Provider.of<QuestionProvider>(context).hintsList;
    final user = Provider.of<UserProvider>(context).user;
    return Consumer<UserProvider>(builder: (context, provider, _) {
      int hintNumber = provider.user.hintLevel;
      return BoomMenu(
        foregroundColor:
            brightness == BrightnessOption.dark ? Colors.white : Colors.black,
        backgroundColor:
            brightness == BrightnessOption.dark ? Colors.black : Colors.white,
        animatedIcon: AnimatedIcons.menu_close,
        animatedIconTheme: IconThemeData(size: 22.0),
        scrollVisible: true,
        overlayColor: Colors.black,
        overlayOpacity: 0.7,
        children: [
          if (hintNumber <= 0)
            MenuItem(
              child: Icon(Icons.lightbulb_outline, color: Colors.black),
              title: "Hint 1",
              titleColor: Colors.black,
              subtitle: "Avail hint 1 with 20 coins",
              subTitleColor: Colors.black,
              backgroundColor: Colors.white,
              onTap: () {
                if (hintNumber != 0) {
                  createToast("Please Avail Previous Hint First.");
                  return;
                }
                displayDialogforHint(
                    title: 'Are you sure you want to Retrieve hint 1?',
                    imgName: 'hint.gif',
                    text: 'Yes',
                    color: Colors.red);
              },
            ),
          if (hintNumber >= 1)
            MenuItem(
              child: Icon(Icons.lightbulb_outline, color: Colors.black),
              title: 'Hint 1',
              subtitle: '${hintList[user.level - 1].hint1}',
              titleColor: Colors.black,
              subTitleColor: Colors.black,
              backgroundColor: Colors.white,
            ),
          if (hintNumber <= 1)
            MenuItem(
              child: Icon(Icons.lightbulb_outline, color: Colors.black),
              title: "Hint 2",
              titleColor: Colors.black,
              subtitle: "Avail hint 2 with 30 coins",
              subTitleColor: Colors.black,
              backgroundColor: Colors.white,
              onTap: () {
                if (hintNumber != 1) {
                  createToast("Please Avail Previous Hint First.");
                  return;
                }
                displayDialogforHint(
                  title: 'Are you sure you want to Retrieve hint 2?',
                  imgName: 'wrong.gif',
                  text: 'Yes',
                  color: Colors.red,
                );
              },
            ),
          if (hintNumber >= 2)
            MenuItem(
              child: Icon(Icons.lightbulb_outline, color: Colors.black),
              title: "Hint 2",
              subtitle: '${hintList[user.level - 1].hint2}',
              titleColor: Colors.black,
              subTitleColor: Colors.black,
              backgroundColor: Colors.white,
            ),
          if (hintNumber <= 2)
            MenuItem(
              child: Icon(Icons.lightbulb_outline, color: Colors.black),
              title: "Hint 3",
              titleColor: Colors.black,
              subtitle: "Avail hint 3 with 40 coins",
              subTitleColor: Colors.black,
              backgroundColor: Colors.white,
              onTap: () {
                if (hintNumber != 2) {
                  createToast("Please Avail Previous Hint First.");
                  return;
                }
                displayDialogforHint(
                  title: 'Are you sure you want to Retrieve hint 3?',
                  imgName: 'wrong.gif',
                  text: 'Yes',
                  color: Colors.red,
                );
              },
            ),
          if (hintNumber >= 3)
            MenuItem(
              child: Icon(Icons.lightbulb_outline, color: Colors.black),
              subtitle: '${hintList[user.level - 1].hint3}',
              title: "Hint 3",
              titleColor: Colors.black,
              subTitleColor: Colors.black,
              backgroundColor: Colors.white,
            ),
        ],
      );
    });
  }
}
