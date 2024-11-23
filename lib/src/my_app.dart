import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:knovator_practical_by_chirag/src/route/route_collection.dart';
import 'package:knovator_practical_by_chirag/src/route/route_name.dart';

import 'core/const/app_color.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Theme.of(context).copyWith(
        colorScheme: Theme.of(context)
            .colorScheme
            .copyWith(primary: AppColor.whiteColor),
      ),
      defaultTransition: Transition.noTransition,
      initialRoute: RouteName.postRoute,
      getPages: RouteCollection.routePage,
    );
  }
}
