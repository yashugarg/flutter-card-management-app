import 'package:flutter/material.dart';

class LoadingDisabler extends StatelessWidget {
  final Widget child;
  final bool isDisabled;

  /// if true shows child beneath loader, by default `true`
  final bool? isStacked;
  const LoadingDisabler(
      {Key? key, required this.child, required this.isDisabled, this.isStacked})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        if (isStacked == false && isDisabled == true)
          Container(
            color: Colors.white,
            height: double.infinity,
            width: double.infinity,
          )
        else
          IgnorePointer(
            ignoring: isDisabled,
            child: Opacity(
              opacity: isDisabled == true ? 0.5 : 1,
              child: child,
            ),
          ),
        if (isDisabled)
          CircularProgressIndicator()
        else
          const SizedBox(
            height: 0,
            width: 0,
          )
      ],
    );
  }
}
