import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loading_overlay/loading_overlay.dart';

class CustomLoader extends StatelessWidget {
  final bool isLoading;
  final Widget child;

  const CustomLoader({Key? key, required this.isLoading, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: isLoading,
      color: Color(0xff8D01E5),
      opacity: 0.2,

      progressIndicator:  const SpinKitWave(
        color: Color(0xff8D01E5),
        size: 40,
      ),
      child: child,
    );
  }
}
