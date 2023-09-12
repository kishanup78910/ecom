import 'package:flutter/cupertino.dart';

class MyAlertDialogue {
  void showMyDialogue(
      {required context,
      required title,
      required String content,
      required Function() tabNo,
      required Function() tabYes}) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(content),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            /// This parameter indicates this action is the default,
            /// and turns the action's text to bold text.
            isDefaultAction: true,
            onPressed: tabNo,

            // () {
            //   Navigator.pop(context);
            // },
            child: const Text('No'),
          ),
          CupertinoDialogAction(
            /// This parameter indicates the action would perform
            /// a destructive action such as deletion, and turns
            /// the action's text color to red.
            isDestructiveAction: true,
            onPressed: tabYes,
            //  () async {
            //   await FirebaseAuth.instance.signOut();
            //   Navigator.pop(context);
            //   Navigator.pushReplacementNamed(context, '/welcome_screen');
            // },
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  }
}
