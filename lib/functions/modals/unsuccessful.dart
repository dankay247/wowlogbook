import 'package:flutter/material.dart';
import '../../accra_parent/screens/registration/new_registration.dart';



class Unsuccessful extends StatefulWidget {
  final String apiText;
  final VoidCallback returnToFormState;

  const Unsuccessful(this.apiText, {Key? key, required this.returnToFormState})
      : super(key: key);

  @override
  State<Unsuccessful> createState() => _UnsuccessfulState();
}

class _UnsuccessfulState extends State<Unsuccessful> {
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
    // Start a timer and navigate back to the form after 4 seconds
    Future.delayed(const Duration(seconds: 8), () {
      Navigator.pop(context); // Pop the dialog
      if (mounted) {
        setState(() {
          submittedRegistration = false; // Reset the submitted flag
          hasError = false; // Reset the error flag
        });
      }
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
      onTap: () {},
      child: AlertDialog(
        backgroundColor: const Color(0XFFF2F4F7),
        content: SingleChildScrollView(
          child: SizedBox(
            width: width/2.5,
            // height: screenHeight/2.8,
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
                const SizedBox(height: 15),
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
                      onPressed: () {
                        Navigator.pop(context);
                        widget.returnToFormState();
                      },
                      child: Text('Retry',
                          style: TextStyle(
                              color: const Color(0xFFFFFFFF),
                              fontFamily: 'Sofia Pro',
                              fontSize: modalButtonTextFont,
                              fontWeight: FontWeight.w600)),
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
