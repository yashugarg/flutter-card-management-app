import 'package:flutter/material.dart';

class WidgetHelper {
  static Future showCustomDialog(BuildContext context, List<Widget> actions,
      {String? title, String? content}) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title ?? 'Warning',
              style: const TextStyle(fontWeight: FontWeight.bold)),
          content: Text(content ?? ''),
          actions: actions,
        );
      },
    );
  }

  static Future showInfoDialog(BuildContext context,
      {String? title,
      String? content,
      List<Widget>? actions,
      String? dismissText}) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title ?? 'Info',
              style: const TextStyle(fontWeight: FontWeight.bold)),
          content: IntrinsicHeight(
            child: Column(
              children: [
                const SizedBox(height: 10),
                Text(content ?? ''),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(dismissText ?? "Dismiss"),
            ),
            ...actions ?? <Widget>[],
          ],
        );
      },
    );
  }

  static void showWarningDialog(BuildContext context,
      {String? title, String? content, List<Widget>? actions}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title ?? 'Warning',
              style: const TextStyle(fontWeight: FontWeight.bold)),
          content: Text(content ?? ''),
          actions: <Widget>[
            ...actions ?? <Widget>[],
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Dismiss"),
            ),
          ],
        );
      },
    );
  }

  static void openInInterctiveScreen(BuildContext ctx,
      {Widget? appBar, required Widget body}) {
    Navigator.of(ctx).push(
      MaterialPageRoute(
        builder: (context) => Scaffold(
          backgroundColor: Colors.black,
          appBar: appBar as PreferredSizeWidget? ?? AppBar(),
          body: InteractiveViewer(
            alignPanAxis: true,
            child: Center(child: body),
          ),
        ),
      ),
    );
  }
}
