import 'package:flutter/material.dart';
import 'package:test_app/design/apptheme/colors.dart';
import 'package:test_app/sub_navigator.dart';

class Loginfieldsample extends StatefulWidget {
  const Loginfieldsample({super.key});

  @override
  State<Loginfieldsample> createState() => _LoginfieldsampleState();
}

class _LoginfieldsampleState extends State<Loginfieldsample> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  

  @override
  Widget build(BuildContext context) {

    return LayoutBuilder(
      builder: (context, constraints) {
        final parentHeight = constraints.maxHeight;
        final parentWidth = constraints.maxWidth;

        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: parentHeight,
            ),
            child: IntrinsicHeight(
              child: Container(
                decoration: BoxDecoration(
                  color: Apptheme.backgroundlight,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.blueGrey,
                      blurRadius: 2,
                      offset: Offset(0, 1),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Username field
                    TextField(
                      controller: usernameController,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Apptheme.textclrdark,
                      ),
                      decoration: InputDecoration(
                        isDense: true,
                        filled: true,
                        fillColor: Apptheme.texthintbgrnd,
                        hintText: 'Email (example@gmail.com)',
                        hintStyle: TextStyle(
                          color: Apptheme.texthintclrdark,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    //--Password--
                    TextField(
                      controller: passwordController,
                      obscureText: true,
                      obscuringCharacter: '*',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Apptheme.textclrdark,
                      ),
                      decoration: InputDecoration(
                        isDense: true,
                        filled: true,
                        fillColor: Apptheme.texthintbgrnd,
                        hintText: 'Password',
                        hintStyle: TextStyle(
                          color: Apptheme.texthintclrdark,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                      ),
                    ),

                    const Spacer(),

                    //--Sign In--
                    LayoutBuilder(
                      builder: (context, btnConstraints) {
                        final btnHeight = parentHeight * 0.25;
                        final double btnFontSize =
                            (btnHeight * 0.25 < 14) ? 14 : btnHeight * 0.25;

                        return SizedBox(
                          width: parentWidth * 0.5,
                          height: btnHeight,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Apptheme.error,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: const EdgeInsets.all(8),
                            ),
                            onPressed: () {
                              if (usernameController.text == "sphere@gmail.com" &&
                                  passwordController.text == "sphere1234") {
                                RootScaffold.of(context)?.goToHomePage();
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    backgroundColor: Apptheme.backgroundlight,
                                    content: Text(
                                      'Incorrect username or password. Please try again',
                                      style: TextStyle(
                                        color: Apptheme.error,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                );
                              }
                            },
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                "Sign In",
                                style: TextStyle(
                                  color: Apptheme.textclrdark,
                                  fontWeight: FontWeight.bold,
                                  fontSize: btnFontSize,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
