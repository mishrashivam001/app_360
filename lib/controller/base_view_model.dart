import 'package:flutter/foundation.dart';

class BaseViewModel extends ChangeNotifier {
  ViewState _state = ViewState.none;

  ViewState get currentState => _state;

  String _message = 'Unknown Error';

  String get message => _message;

  bool get loading => currentState == ViewState.loading;

  bool get hasError => currentState == ViewState.error;

  setLoading() {
    _state = ViewState.loading;
    notifyListeners();
  }

  setError(String message) {
    _state = ViewState.error;

    if (message.isEmpty) {
      message = 'Unknown error occurred';
    }

    _message = message;
    notifyListeners();
  }

  setSuccess() {
    _state = ViewState.dataReady;
    notifyListeners();
  }
}

enum ViewState { none, loading, dataReady, error }
