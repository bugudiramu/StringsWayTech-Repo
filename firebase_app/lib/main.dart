// import 'dart:async';

// import 'package:firebase_remote_config/firebase_remote_config.dart';
// import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Remote Config Example',
//       home: FutureBuilder<RemoteConfig>(
//         future: setupRemoteConfig(),
//         builder: (BuildContext context, AsyncSnapshot<RemoteConfig> snapshot) {
//           return snapshot.hasData
//               ? WelcomeWidget(remoteConfig: snapshot.data)
//               : Container();
//         },
//       ),
//     );
//   }
// }

// class WelcomeWidget extends AnimatedWidget {
//   WelcomeWidget({this.remoteConfig}) : super(listenable: remoteConfig);

//   final RemoteConfig remoteConfig;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Remote Config Example'),
//       ),
//       body: Center(child: Text('Welcome ${remoteConfig.getString('hello')}')),
//       floatingActionButton: FloatingActionButton(
//           child: const Icon(Icons.refresh),
//           onPressed: () async {
//             try {
//               // Using default duration to force fetching from remote server.
//               await remoteConfig.fetch(expiration: const Duration(seconds: 0));
//               await remoteConfig.activateFetched();
//             } on FetchThrottledException catch (exception) {
//               // Fetch throttled.
//               print(exception);
//             } catch (exception) {
//               print(
//                   'Unable to fetch remote config. Cached or default values will be '
//                   'used');
//             }
//           }),
//     );
//   }
// }

// Future<RemoteConfig> setupRemoteConfig() async {
//   final RemoteConfig remoteConfig = await RemoteConfig.instance;
//   // Enable developer mode to relax fetch throttling
//   remoteConfig.setConfigSettings(RemoteConfigSettings(debugMode: true));
//   remoteConfig.setDefaults(<String, dynamic>{
//     'welcome': 'default welcome',
//     'hello': 'default hello',
//   });
//   return remoteConfig;
// }

import 'package:flutter/material.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FirRemConWid(),
    );
  }
}

class FirRemConWid extends StatefulWidget {
  @override
  _FirRemConWidState createState() => _FirRemConWidState();
}

class _FirRemConWidState extends State<FirRemConWid> {
  Future fetching() async {
    final RemoteConfig remoteConfig = await RemoteConfig.instance;
    RemoteConfigSettings configSettings = RemoteConfigSettings();
    remoteConfig.setConfigSettings(configSettings);

    final defaults = <String, dynamic>{
      'welcome': 'hey',
      'version': '1.0.0',
      'imgUrl':
          'https://www.belightsoft.com/products/imagetricks/img/intro-video-poster@2x.jpg'
    };
    await remoteConfig.setDefaults(defaults);
    await remoteConfig.fetch(expiration: Duration(seconds: 2));
    await remoteConfig.activateFetched();
    print("Welcome message ${remoteConfig.getString('welcome')}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            child: MaterialButton(
              color: Colors.blue,
              child: Text("Update"),
              onPressed: () {},
            ),
          ),
          Container(
            child: MaterialButton(
              color: Colors.red,
              child: Text("Fetch"),
              onPressed: () => fetching(),
            ),
          ),
        ],
      ),
    );
  }
}
