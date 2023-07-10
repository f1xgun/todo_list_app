import 'package:flutter/material.dart';
import 'package:todo_list_app/core/environments.dart';

class EnvironmentBanner extends StatelessWidget {
  const EnvironmentBanner(
      {required this.child, required this.environment, super.key});

  final Widget child;
  final Environment environment;
  @override
  Widget build(BuildContext context) {
    return switch (environment) {
      Environment.production => child,
      Environment.test => Directionality(
          textDirection: TextDirection.ltr,
          child: Banner(
            child: child,
            message: 'TEST',
            location: BannerLocation.topEnd,
          ),
        ),
      Environment.development => Directionality(
          textDirection: TextDirection.ltr,
          child: Banner(
            child: child,
            message: 'DEV',
            location: BannerLocation.topEnd,
          ),
        ),
    };
  }
}
