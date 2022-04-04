import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:coffee_rosting_timer/models/stop_watch_model.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'provider demo', home: _ProviderWidget());
  }
}

class _ProviderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<StopWatchModel>(
          create: (context) => StopWatchModel(),
        )
      ],
      child: _MainPageBody(),
    );
  }
}

class _MainPageBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final stopWatchModel = Provider.of<StopWatchModel>(context);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.black,
          title: Text('焙煎タイマー'),
        ),
        // 再描画したい箇所だけConsumerで囲む
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Consumer<StopWatchModel>(
                  builder: (context, model, _) => Text(
                        model.stopWatchTimeDisplay,
                        style: Theme.of(context).textTheme.headline2,
                      )),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: stopWatchModel.isStartPressed
                          ? stopWatchModel.startStopWatch
                          : null,
                      child: Text('スタート')),
                  ElevatedButton(
                      onPressed: stopWatchModel.isStopPressed
                          ? null
                          : stopWatchModel.stopStopWatch,
                      child: Text('ストップ')),
                  ElevatedButton(
                    onPressed: stopWatchModel.isResetPressed
                        ? null
                        : stopWatchModel.resetStopWatch,
                    child: Text('リセット'),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red, //ボタンの背景色
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
