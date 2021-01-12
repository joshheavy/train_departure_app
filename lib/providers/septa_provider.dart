import 'package:flutter/cupertino.dart';
import 'package:train_departure/blocs/septa_bloc.dart';

class SeptaProvider with ChangeNotifier {
  SeptaBloc _bloc;

  SeptaProvider() {
    _bloc = SeptaBloc();
  }

  SeptaBloc get bloc => _bloc;
}
