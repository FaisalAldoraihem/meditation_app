import 'package:bloc/bloc.dart';

class SimpleBlocDelegate extends BlocObserver {
  @override
  void onChange(Cubit cubit, Change change) {
    super.onChange(cubit, change);
    print(change);
  }

  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    print(event);
  }
}
