
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_application/shared/cubit/states.dart';
import '../network/local/cache_helper.dart';


class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  bool isDark = false;

  void changeAppMode({bool fromShared})
  {
    if(fromShared != null) {
      isDark =fromShared;
    } else {
      isDark = !isDark;
      CacheHelper.putBoolean(
        key: 'isDark',
        value: isDark,
      ).then((value)
      {
        emit(AppChangeModeState());
      });
    }
  }
}
