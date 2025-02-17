import 'package:custom_swipe_to_confirm/custom_swipe_to_confirm.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Custom Swipe to confirm',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Custom Swipe to confirm'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //payment whole amount with wallet related
  bool isSwipeFinished = false;
  bool isSwipeResponseFailed = false;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CustomSwipeToConfirmWidget(
              onFinish: () {},
              isFinished: isSwipeFinished,
              hasFailed: isSwipeResponseFailed,
              onWaitingProcess: () async {
                //mimic the delay
                await Future.delayed(Duration(seconds: 2));

                if (true) {
                  setState(() {
                    isSwipeFinished = true;
                    isSwipeResponseFailed = false;
                  });
                } else {
                  setState(() {
                    isSwipeFinished = true;
                    isSwipeResponseFailed = true;
                  });
                }
              },
              activeColor: theme.colorScheme.primary,
              buttonColor: theme.colorScheme.onPrimary,
              buttonWidget: Icon(Icons.payment),
              buttonText: 'swipe right to pay',
              buttontextstyle: theme.textTheme.bodyLarge!.copyWith(
                color: theme.colorScheme.primaryContainer,
                fontSize: 15,
              ),
            ),
          ],
        ),
      )),
    );
  }
}
