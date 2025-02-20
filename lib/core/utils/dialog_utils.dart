import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

showLoading(
  BuildContext context,
) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return const CupertinoAlertDialog(
          content: Row(
            children: [
              Text("Loading..."),
              Spacer(),
              CircularProgressIndicator(),
            ],
          ),
        );
      });
}

hideLoading(BuildContext context) {
  Navigator.pop(context);
}

showMessage(
  BuildContext context,
  String message, {
  String? title,
  String? posButtonTitle,
  Function? posButtonClick,
  String? negativeButtonTitle,
  Function? negativeButtonClick,
}) {
  showDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: title != null ? Text(title) : null,
          content: Text(message),
          actions: [
            if (posButtonTitle != null)
              TextButton(
                  onPressed: () {
                    hideLoading(context);
                    if (posButtonClick != null) posButtonClick();
                  },
                  child: Text(posButtonTitle)),
            if (negativeButtonTitle != null)
              TextButton(
                  onPressed: () {
                    hideLoading(context);
                    if (negativeButtonClick != null) negativeButtonClick();
                  },
                  child: Text(negativeButtonTitle))
          ],
        );
      });
}
