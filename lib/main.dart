import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_donation/layout/admin_app/admin_home_layout.dart';
import 'package:food_donation/layout/admin_app/cubit/cubit.dart';
import 'package:food_donation/layout/user_app/cubit/cubit.dart';
import 'package:food_donation/layout/user_app/user_home_layout.dart';
import 'package:food_donation/modules/splash/splash_screen.dart';
import 'package:food_donation/shared/components/constants.dart';
import 'package:food_donation/shared/cubit/bloc_observer.dart';
import 'package:food_donation/shared/cubit/cubit.dart';
import 'package:food_donation/shared/cubit/states.dart';
import 'package:food_donation/shared/network/local/cache_helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CacheHelper.init();

  Widget widget;
  uId = CacheHelper.getData(key: "uId");
  if (uId != null) {
    if (uId == 'VHwOfV1iPkRp1gDNuds7RDpXG7t1') {
      widget = AdminHomeLayout();
    } else {
      widget = UserHomeLayout();
    }
  } else {
    widget = SplashScreen();
  }

  BlocOverrides.runZoned(
    () {
      runApp(MyApp(
        startWidget: widget,
      ));
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  final Widget startWidget;

  MyApp({
    required this.startWidget,
  });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AppCubit(),
        ),
        BlocProvider(
          create: (context) => HomeLayoutAppCubit()..getUserData()..getRequestData(),
        ),
        BlocProvider(
          create: (context) => AdminHomeLayoutAppCubit()..getRequestData(),
        ),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, states) {},
        builder: (context, states) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: startWidget,
          );
        },
      ),
    );
  }
}
