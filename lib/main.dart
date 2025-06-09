import 'package:delivery_app/screens/deliver_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart' as mapbox;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load();
  final accessToken = dotenv.env['ACCESS_TOKEN'] ?? '';

  //String.fromEnvironment('ACCESS_TOKEN');
  mapbox.MapboxOptions.setAccessToken(accessToken);

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812), // Flutter's Size
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          title: 'Delivery Detail',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            textTheme: Typography.englishLike2018.apply(fontSizeFactor: 1.sp),
          ),
          home: const DeliveryScreen(),
        );
      },
    );
  }
}
