import 'package:elastic_bean_stalk/Utils/Routes/routes.dart';
import 'package:elastic_bean_stalk/Utils/Theme/theme.dart';

import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

final HttpLink httpLink = HttpLink(
    'http://humapp-env.eba-5psj3xci.ap-south-1.elasticbeanstalk.com/graphql',
);

 ValueNotifier<GraphQLClient> client = ValueNotifier(
  GraphQLClient(
    link: httpLink,
    // The default store is the InMemoryStore, which does NOT persist to disk
    cache: GraphQLCache(store: HiveStore()),
  ),
);

void main() async{
  await initHiveForFlutter();
  runApp(MyApp());
}


class MyApp extends StatefulWidget {
  // late ValueNotifier<GraphQLClient> client;
  MyApp({Key? key}) : super(key: key);
  // MyApp.initClient(this.client,{Key? key}) : super(key: key);
  // ValueNotifier<GraphQLClient> getClient(){
  //   return client;
  // }
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // ValueNotifier<GraphQLClient> client=MyApp().client;
  _MyAppState();
  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: client,
       child:MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: RouteManager.login,
      theme: (CustomTheme.isDark) ? CustomTheme.darkTheme() : CustomTheme.lightTheme(),
      onGenerateRoute: RouteManager.generateRoute,
    )
    );
  }
}
