import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tenant_review/views/homepage_map.dart';
import 'package:tenant_review/views/logon.dart';
import 'package:tenant_review/widgets/common_widgets.dart';
import 'package:tenant_review/providers/auth.dart';

class TRVULogonWidget extends LogonCommnon {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Auth myAuth = Provider.of<Auth>(context);

    return Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                const Text("Please Fill in Your Credentials"),
                TextFormField(
                    decoration: const InputDecoration(
                        labelText: "username", icon: Icon(Icons.person)),
                    controller: userNameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter UserName';
                      }
                      return null;
                    }),
                TextFormField(
                    decoration: const InputDecoration(
                        labelText: "password", icon: Icon(Icons.person)),
                    controller: passWordController,
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter PassWord';
                      }
                      return null;
                    }),
                Visibility(
                  visible: myAuth.registerationState == "Register",
                  child: TextFormField(
                      decoration: const InputDecoration(
                          labelText: "email", icon: Icon(Icons.person)),
                      controller: emailController,
                      obscureText: false,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Valid Email Address';
                        }
                        return null;
                      }),
                ),
                Visibility(
                  visible: myAuth.registerationState == "Register",
                  child: TextFormField(
                      decoration: const InputDecoration(
                          labelText: "phone", icon: Icon(Icons.person)),
                      controller: phoneNumberController,
                      obscureText: false,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Phone Number';
                        }
                        return null;
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton.icon(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          if (myAuth.registerationState == "Logon") {
                            myAuth
                                .authenticate(userNameController.text,
                                    passWordController.text)
                                .then((value) {
                              if (value) {
                                ScaffoldMessenger.of(context).clearSnackBars();

                                Navigator.of(context).pushReplacementNamed(
                                    TRVUHomeMap.routeName);
                              }
                            });

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Processing Data'),
                                duration: Duration(milliseconds: 500),
                              ),
                            );
                          } else if (myAuth.registerationState == "Register") {
                            myAuth
                                .register(
                                    userNameController.text,
                                    passWordController.text,
                                    emailController.text,
                                    phoneNumberController.text)
                                .then((value) {
                              myAuth.registerationState = "Logon";
                              Navigator.of(context)
                                  .pushReplacementNamed(TRVULogin.routeName);
                            });
                          }
                        }
                      },
                      icon: const Icon(Icons.login),
                      label: Text(myAuth.registerationState)),
                ),
              ]),
        ));
  }
}
