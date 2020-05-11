import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyNavigatorObserver extends NavigatorObserver {
  @override
  void didPop(Route route, Route previousRoute) {
    print(
        "didPop route: ${route?.settings?.name} previousRoute: ${previousRoute?.settings?.name}");
  }

  @override
  void didPush(Route route, Route previousRoute) {
    print(
        "didPush route: ${route?.settings?.name} previousRoute: ${previousRoute?.settings?.name}");
  }

  @override
  void didRemove(Route route, Route previousRoute) {
    print(
        "didRemove route: ${route?.settings?.name} previousRoute: ${previousRoute?.settings?.name}");
  }

  @override
  void didReplace({Route newRoute, Route oldRoute}) {
    print(
        "didReplace route: ${newRoute?.settings?.name} previousRoute: ${oldRoute?.settings?.name}");
  }
}

class MyPage extends StatelessWidget {
  final int n;

  const MyPage({Key key, this.n = 0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("n = $n"),
            RaisedButton(
              child: Text("push"),
              onPressed: () {
                Navigator.of(context).push(
                  buildMaterialPageRoute(),
                );
              },
            ),
            RaisedButton(
              child: Text("popUntil [isFirst] + pushReplacement"),
              onPressed: () {
                Navigator.of(context).popUntil((r) => r.isFirst);
                Navigator.of(context).pushReplacement(
                  buildMaterialPageRoute(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  MaterialPageRoute buildMaterialPageRoute() => MaterialPageRoute(
        settings: RouteSettings(name: "route${n + 1}"),
        builder: (context) => MyPage(n: n + 1),
      );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyPage(),
      navigatorObservers: [MyNavigatorObserver()],
    );
  }
}
