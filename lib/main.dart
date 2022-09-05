
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_application/shared/components/constants.dart';
import 'package:news_application/shared/network/local/cache_helper.dart';
import 'package:news_application/shared/network/remote/dio_helper.dart';

import 'layout/news_app/cubit/cubit.dart';
import 'news_app/one_screen/one_screen.dart';
import 'shared/cubit/cubit.dart';
import 'shared/cubit/states.dart';
import 'shared/styles/styles.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.initDio();
  await CacheHelper.init();
  bool isDark = CacheHelper.getBoolean(key: 'isDark');

  runApp(MyApp(isDark));
}

class MyApp extends StatelessWidget {
  final bool isDark;
  const MyApp(this.isDark, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context)=> NewsCubit()..getBusiness()..getSports()..getScience()
        ),
        BlocProvider(create: (BuildContext context) => AppCubit()..changeAppMode(
          fromShared: isDark,
        ),),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: lightTheme,
              darkTheme: darkTheme,
              themeMode: AppCubit.get(context).isDark
                  ? ThemeMode.light
                  : ThemeMode.dark,
              home: const OneScreen(),
            );
          }),
    );
  }
}
