import 'package:flutter/material.dart';
import 'package:shooe_pos/order/order_screen.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]).then((value) => runApp(ShooePosWebApp()));
  runApp(const ShooePosWebApp());
}

class ShooePosWebApp extends StatelessWidget {
  const ShooePosWebApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => const OrderScreen(),
      },
    );
  }
}
