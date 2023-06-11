import 'package:flutter/material.dart';
import 'package:wowlogbook/accra_parent/screens/registration/already_registered.dart';

import '../../accra_parent/screens/home_screen.dart';
import '../../accra_parent/screens/registration/new_registration.dart';



final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
final TextEditingController _nameController = TextEditingController();
final TextEditingController _phoneNumberController = TextEditingController();
final TextEditingController _emailController = TextEditingController();
final TextEditingController _companyController = TextEditingController();

class Success extends StatefulWidget {
  final String apiText;

  const Success(this.apiText, {Key? key}) : super(key: key);

  @override
  State<Success> createState() => _SuccessState();
}

class _SuccessState extends State<Success> {
  double _opacity = 0;

  @override
  void initState() {
    super.initState();
    _startTimer();
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _opacity = 1;
      });
    });
  }

  void _startTimer() {
    // Start a timer and route to the Home Screen after 4 seconds
    Future.delayed(const Duration(seconds: 6), () {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
        (route) => false,
      );

      // Reset the form by resetting the form state and clearing the controllers
      _formKey.currentState?.reset();
      _nameController.clear();
      _phoneNumberController.clear();
      _emailController.clear();
      _companyController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double modalImageHeight = screenHeight * 0.12;

    //Fonts
    double modalButtonTextFont = (width / 720) * 11;
    double modalTextFont = (width / 720) * 16.2;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {}, // Disable taps outside the modal
      child: AlertDialog(
        backgroundColor: const Color(0XFFF2F4F7),
        content: SingleChildScrollView(
          child: SizedBox(
            width: width/2.5,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  child: Align(
                    child: Image.asset(
                      'assets/images/modal.png',
                      height: modalImageHeight,
                      width: width/3,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: Wrap(
                    children: [
                      AnimatedOpacity(
                        opacity: _opacity,
                        duration: const Duration(seconds: 1),
                        child: Text(
                          widget.apiText,
                          style:  TextStyle(
                            fontSize: modalTextFont,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Sofia Pro',
                            color: const Color(0xFF005A5E),
                            shadows: const [
                              Shadow(
                                color: Colors.white,
                                blurRadius: 2,
                                offset: Offset(2, 2),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                AnimatedOpacity(
                  opacity: _opacity,
                  duration: const Duration(seconds: 1),
                  child: SizedBox(
                    width: width/10,
                    height: screenHeight/14,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)),
                        backgroundColor: const Color(0XFF005A5E),
                      ),
                      onPressed: () {},
                      child: GestureDetector(
                        onTap: () {
                          // Dismiss the keyboard
                          FocusScope.of(context).unfocus();
                          // Navigate to HomeScreen
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const HomeScreen()));
                          setState(() {
                            _formKey.currentState?.reset();
                            _nameController.clear();
                            _phoneNumberController.clear();
                            _companyController.clear();
                            _emailController.clear();
                            submittedRegistration = false;
                            submitted = false;
                          });
                        },
                        child:  Text('Thanks',
                            style: TextStyle(
                                color: const Color(0xFFFFFFFF),
                                fontFamily: 'Sofia Pro',
                                fontSize: modalButtonTextFont,
                                fontWeight: FontWeight.w600)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
