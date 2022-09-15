import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nike_shoe/constants/strings.dart';
import 'package:nike_shoe/constants/style.dart';
import 'package:nike_shoe/controller/shoe_controller.dart';
import 'package:nike_shoe/routing/app_router.gr.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(ShoeController(), permanent: true);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));

  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final _appRouter = AppRouter();
  @override
  Widget build(BuildContext context) {
    final theme = ThemeData(
        scaffoldBackgroundColor: darkColor,
        colorScheme: ColorScheme.fromSwatch().copyWith(primary: primaryColor),
        canvasColor: darkColor,
        dialogBackgroundColor: darkColor,
        floatingActionButtonTheme: ThemeData.dark()
            .floatingActionButtonTheme
            .copyWith(backgroundColor: primaryColor),
        cardColor: lightColor,
        iconTheme: ThemeData.light().iconTheme.copyWith(color: primaryColor),
        textTheme: GoogleFonts.poiretOneTextTheme(
          Theme.of(context).textTheme.copyWith(
                bodyText1: const TextStyle(
                  fontSize: 16,
                  color: lightColor,
                  fontWeight: FontWeight.bold,
                ),
                bodyText2: const TextStyle(
                  fontSize: 12,
                  color: lightColor,
                ),
              ),
        ).apply(
          bodyColor: lightColor,
        ));

    return MaterialApp.router(
      routerDelegate: _appRouter.delegate(),
      routeInformationParser: _appRouter.defaultRouteParser(),
      debugShowCheckedModeBanner: false,
      title: appName,
      theme: theme,
    );
  }
}
