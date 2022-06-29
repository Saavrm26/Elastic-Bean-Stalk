import 'package:elastic_bean_stalk/Utils/Routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  bool isRun = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Mutation(
          options: MutationOptions(
            document: gql(
                """
                        mutation
                        {
                          Authenticate(input:{emailOrPhone:\$emailOrPhone,password:\$password})
                          {
                            token
                          }
                        }
                      """),
            update:
                (GraphQLDataProxy cache, QueryResult<Object?>? result) {
              print("inside update");
              return cache;
            },
            onCompleted: (dynamic resultData) {
              print("inside on completed ");
            },
          ),
          builder: (RunMutation runMutation, QueryResult<Object?>? result) {
            print(result?.data?.toString());
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "LOGIN",
                    style: Theme
                        .of(context)
                        .textTheme
                        .displayLarge,
                  ),
                  Form(
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.all(10),
                          child: const TextField(
                            decoration: InputDecoration(
                                hintText: "Enter email or username",
                                filled: true,
                                // fillColor: ,
                                enabledBorder: OutlineInputBorder(
                                    borderSide:
                                    BorderSide(width: 3, color: Colors.black))),
                            autocorrect: false,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(10),
                          child: const TextField(
                            decoration: InputDecoration(
                                hintText: "Enter password",
                                filled: true,
                                // fillColor: Colors.green,
                                enabledBorder: OutlineInputBorder(
                                    borderSide:
                                    BorderSide(width: 3, color: Colors.black))),
                            autocorrect: false,
                          ),
                        ),
                        ElevatedButton(
                            onPressed: () {
                              runMutation(<String, dynamic>{
                                'emailOrPhone': '9456679268',
                                'password': 'goodguy123'
                              });
                              print(result?.data);
                              // major modifications from the last commit
                            },
                            child: const Text("click me")
                        )
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
      ),
    );
  }
}
