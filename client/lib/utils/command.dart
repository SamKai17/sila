import 'package:client/utils/result.dart';
import 'package:flutter/material.dart';

abstract class Command<T> extends ChangeNotifier {
  Command();

  bool _running = false;

  bool get running => _running;

  Result<T>? _result;

  bool get completed => _result is Ok;

  bool get error => _result is Error;

  Result? get result => _result;

  Future<void> _execute(Future<Result<T>> Function() action) async {
    if (_running) {
      return;
    }
    _running = true;
    _result = null;
    notifyListeners();
    try {
      _result = await action();
    } finally {
      _running = false;
      notifyListeners();
    }
  }

  void clearResult() {
    _result = null;
    notifyListeners();
  }
}

class Command0<T> extends Command<T> {
  final Future<Result<T>> Function() _action;

  Command0(this._action);
  Future<void> execute() async {
    await _execute(_action);
  }
}

class Command1<T, A> extends Command<T> {
  final Future<Result<T>> Function(A param) _action;

  Command1(this._action);
  Future<void> execute(A param) async {
    await _execute(() => _action(param));
  }
}
