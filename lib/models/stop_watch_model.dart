import 'package:flutter/material.dart';
import 'dart:async';

class StopWatchModel extends ChangeNotifier {
  bool isStopPressed = true;
  bool isResetPressed = true;
  bool isStartPressed = true;

  String stopWatchTimeDisplay = '00:00:00';
  // Stopwatch型を指定
  Stopwatch swatch = Stopwatch();
  final dul = const Duration(seconds: 1);

  void startTimer() {
    Timer(dul, keepRunning);
  }

  void keepRunning() {
    if (swatch.isRunning) {
      startTimer();
    }
    stopWatchTimeDisplay =
        swatch.elapsed.inHours.toString().padLeft(2, "0") +
            ':' +
            (swatch.elapsed.inMinutes % 60).toString().padLeft(2, "0") +
            ':' +
            (swatch.elapsed.inSeconds % 60).toString().padLeft(2, "0");
    notifyListeners();
  }

  startStopWatch() {
    isStopPressed = false;
    isStartPressed = false;
    isResetPressed = false;

    swatch.start();
    startTimer();
    notifyListeners();
  }

  stopStopWatch() {
    isStopPressed = true;
    isResetPressed = false;
    isStartPressed = true;

    swatch.stop();
    notifyListeners();
  }

  resetStopWatch() {
    isResetPressed = true;
    isStartPressed = true;
    isStopPressed = true;

    swatch.stop();
    swatch.reset();
    stopWatchTimeDisplay = '00:00:00';
    notifyListeners();
  }
}

class MyTimer {
  // タイマーを開始してから停止までの時間
  final Duration _timeLimit;

  // [_tick]毎に[_onTickedCallback]で通知を行う
  final Duration _tick;

  // 内部で使用するタイマー
  Timer? _timer;

  // 経過時間
  Duration _elapsed = const Duration(seconds: 0);

  MyTimer(
      this._timeLimit,
      this._tick,
      );

  // 経過時間を取得するgetter
  Duration get elapsedTime => _elapsed;

  // タイマーを開始するメソッド
  void start() {
    _timer ??= Timer.periodic(_tick, _onTicked);
  }

  // タイマーを停止するメソッド
  // タイマーを停止した場合は[_onEndedCallback]は呼ばれない
  void stop() {
    if (_timer != null) {
      _timer!.cancel();
    }
  }

  // [_elapsed]を更新して[_onTickedCallback]を呼び出す
  // 終了判定も行う
  void _onTicked(Timer t) {
    _elapsed += _tick;

    if (_elapsed >= _timeLimit) {
      t.cancel();
    }
  }
}