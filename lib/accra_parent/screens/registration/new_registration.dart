import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:wowlogbook/accra_parent/screens/home_screen.dart';
import 'package:wowlogbook/functions/modals/success.dart';
import 'package:wowlogbook/functions/modals/unsuccessful.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

TextEditingController _nameController = TextEditingController();
double inputHeight =
_nameController.text.isEmpty && submittedRegistration ? 70.0 : 50.0;
final RegExp phonePattern = RegExp(r'^\+?[0-9]{8,15}$');
bool submittedRegistration = false;
bool hasError = false;
bool isLoading = false;

class NewRegistration extends StatefulWidget {
  const NewRegistration({Key? key}) : super(key: key);

  @override
  State<NewRegistration> createState() => _NewRegistrationState();
}

void setSystemUIModeNormal() {
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
    SystemUiOverlay.top,
  ]);

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.black26,
    statusBarIconBrightness: Brightness.dark,
    systemNavigationBarColor: Colors.transparent,
    systemNavigationBarIconBrightness: Brightness.dark,
  ));

  // Hide the navigation bar
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
}

class _NewRegistrationState extends State<NewRegistration> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _roleController = TextEditingController();
  final TextEditingController _institutionController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneNumberController.dispose();
    _emailController.dispose();
    _roleController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Initialize ScreenUtil with the design size of your UI
    ScreenUtil.init(
      context,
      designSize: const Size(360, 690),
    );

    Timer(const Duration(seconds: 3), setSystemUIModeNormal);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background/accra-parent-registration.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 7,
                  child: Stack(
                    children: [
                      Positioned(
                        top: ScreenUtil().setHeight(15), // Replace with desired height in logical pixels
                        left: ScreenUtil().setWidth(0),
                        right: ScreenUtil().setWidth(150),// Replace with desired width in logical pixels
                        child: GestureDetector(
                          onTap: () {
                            FocusScope.of(context).unfocus();
                            Navigator.pushReplacement(
                              context,
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                const HomeScreen(),
                                transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) {
                                  const begin = Offset(2.0, 0.0);
                                  const end = Offset.zero;
                                  final tween = Tween(begin: begin, end: end);
                                  final offsetAnimation =
                                  animation.drive(tween);
                                  return SlideTransition(
                                    position: offsetAnimation,
                                    child: child,
                                  );
                                },
                              ),
                            );
                            setState(() {
                              _formKey.currentState?.reset();
                              _phoneNumberController.clear();
                              _nameController.clear();
                              _roleController.clear();
                              _institutionController.clear();
                              _emailController.clear();
                              submittedRegistration = false;
                            });
                          },
                          child: Image.asset(
                            'assets/images/white_back_button.png',
                            // Replace with the actual path to your image
                            height: ScreenUtil().setHeight(40), // Replace with desired height in logical pixels
                            width: ScreenUtil().setWidth(120), // Replace with desired width in logical pixels
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: Center(
                    child: Stack(
                      children: [
                        Container(
                          width: ScreenUtil().setWidth(157),
                          height: ScreenUtil().setHeight(550),
                          margin: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color(0XFF000000),
                              width: 2,
                            ),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(18),
                            ),
                            color: const Color(0xCC323E3B), // Replace with your desired color
                          ),
                        ),
                        Container(
                          width: ScreenUtil().setWidth(157),
                          height: ScreenUtil().setHeight(550),
                          decoration: BoxDecoration(
                            border:
                            Border.all(color: const Color(0XFFFFFFFF), width: 2),
                            color: const Color(0XFFFFFFFF),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(18),
                            ), // Replace with your desired color
                          ),
                          padding: const EdgeInsets.all(25),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Padding(
                              padding:
                              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom)/1.4,
                              child: Center(
                                child: SingleChildScrollView(
                                  reverse: true,
                                  controller: _scrollController,
                                  child: Form(
                                    autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                    key: _formKey,
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          decoration: const BoxDecoration(
                                            color: Color(0xFFFFFFFF),
                                          ),
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: Center(
                                              child: Text(
                                                'REGISTER',
                                                style: TextStyle(
                                                  color: const Color(0xFF18191B),
                                                  fontSize: ScreenUtil().setSp(8),
                                                  fontWeight: FontWeight.w700,
                                                  fontFamily: 'Sofia Pro',
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: ScreenUtil().setHeight(15)),
                                        SizedBox(
                                          height: _phoneNumberController.text.isEmpty &&
                                              submittedRegistration
                                              ? ScreenUtil().setHeight(75)
                                              : ScreenUtil().setHeight(50),
                                          child: TextFormField(
                                            controller: _nameController,
                                            decoration: InputDecoration(
                                              hintText: 'Name (Required)',
                                              hintStyle: TextStyle(
                                                fontSize: ScreenUtil().setSp(3.8),
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w400,
                                              ),
                                              filled: true,
                                              fillColor: Colors.white,
                                              // Set the background color to pure white
                                              border: const OutlineInputBorder(
                                                // Set the border radius to 10 pixels
                                                borderSide: BorderSide(
                                                  color: Color.fromRGBO(
                                                      212, 212, 212, 1),
                                                  width: 2,
                                                ),
                                              ),
                                              focusedBorder: const OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color:  Color(0XFFFBA00F),
                                                  // Set the focused border color to #AA0123
                                                  width: 2,
                                                ),
                                              ),
                                              contentPadding: const EdgeInsets.symmetric(
                                                  vertical: 10, horizontal: 7),
                                              errorStyle: TextStyle(
                                                fontSize: ScreenUtil().setSp(3),
                                                fontFamily: 'Poppins',
                                              ),
                                            ),
                                            textCapitalization:
                                            TextCapitalization.words,
                                            keyboardType: TextInputType.text,
                                            style: const TextStyle(
                                              fontFamily: 'Poppins',
                                            ),
                                            onChanged: (value) {
                                              setState(() {
                                                submittedRegistration = false;
                                              });
                                            },
                                            validator: (value) {
                                              if (submittedRegistration &&
                                                  (value?.isEmpty ?? true)) {
                                                return 'Please enter your name';
                                              }
                                              return null;
                                            },
                                          ),
                                        ),
                                        SizedBox(height: ScreenUtil().setHeight(10)),
                                        SizedBox(
                                          height: submittedRegistration &&
                                              !phonePattern.hasMatch(
                                                  _phoneNumberController.text)
                                              ? ScreenUtil().setHeight(75)
                                              : ScreenUtil().setHeight(50),
                                          child: TextFormField(
                                            controller: _phoneNumberController,
                                            decoration: InputDecoration(
                                              hintText: 'Phone Number (Required)',
                                              hintStyle: TextStyle(
                                                fontSize: ScreenUtil().setSp(3.8),
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w400,
                                              ),
                                              filled: true,
                                              fillColor: Colors.white,
                                              // Set the background color to pure white
                                              border: const OutlineInputBorder(
                                                // Set the border radius to 10 pixels
                                                borderSide: BorderSide(
                                                  color: Color.fromRGBO(
                                                      212, 212, 212, 1),
                                                  width: 2,
                                                ),
                                              ),
                                              focusedBorder: const OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color:  Color(0XFFFBA00F),
                                                  // Set the focused border color to #AA0123
                                                  width: 2,
                                                ),
                                              ),
                                              contentPadding:  const EdgeInsets.symmetric(
                                                  vertical: 10, horizontal: 7),
                                              errorStyle: TextStyle(
                                                fontSize: ScreenUtil().setSp(3),
                                                fontFamily: 'Poppins',
                                              ),
                                            ),
                                            textCapitalization:
                                            TextCapitalization.words,
                                            style: const TextStyle(
                                              fontFamily: 'Poppins',
                                            ),
                                            keyboardType: TextInputType.phone,
                                            onChanged: (value) {
                                              setState(() {
                                                // Reset the error state when the value changes
                                                submittedRegistration = false;
                                              });
                                            },
                                            validator: (value) {
                                              if (submittedRegistration &&
                                                  (value?.isEmpty ?? true)) {
                                                return 'Please enter your phone number';
                                              }

                                              // Validate phone number format using a regular expression pattern

                                              if (submittedRegistration &&
                                                  value != null &&
                                                  value.isNotEmpty) {
                                                if (!phonePattern.hasMatch(value)) {
                                                  return 'Invalid phone number';
                                                }
                                              }
                                              return null;
                                            },
                                          ),
                                        ),
                                        SizedBox(height: ScreenUtil().setHeight(10)),
                                        SizedBox(
                                          height: ScreenUtil().setHeight(50),
                                          child: TextFormField(
                                            controller: _roleController,
                                            decoration:  InputDecoration(
                                              hintText: 'Role',
                                              hintStyle: TextStyle(
                                                fontSize: ScreenUtil().setSp(3.8),
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w400,
                                              ),
                                              filled: true,
                                              fillColor: Colors.white,
                                              // Set the background color to pure white
                                              border: const OutlineInputBorder(
                                                // Set the border radius to 10 pixels
                                                borderSide: BorderSide(
                                                  color: Color.fromRGBO(
                                                      212, 212, 212, 1),
                                                  width: 2,
                                                ),
                                              ),
                                              focusedBorder: const OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color:  Color(0XFFFBA00F),
                                                  // Set the focused border color to #AA0123
                                                  width: 2,
                                                ),
                                              ),
                                              contentPadding: const EdgeInsets.symmetric(
                                                  vertical: 10, horizontal: 7),
                                            ),
                                            textCapitalization:
                                            TextCapitalization.words,
                                            keyboardType: TextInputType.text,
                                            style: const TextStyle(
                                              fontFamily: 'Poppins',
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: ScreenUtil().setHeight(10)),
                                        SizedBox(
                                          height: ScreenUtil().setHeight(50),
                                          child: TextFormField(
                                            controller: _institutionController,
                                            decoration:  InputDecoration(
                                              hintText: 'Institution',
                                              hintStyle: TextStyle(
                                                fontSize: ScreenUtil().setSp(3.8),
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w400,
                                              ),
                                              filled: true,
                                              fillColor: Colors.white,
                                              // Set the background color to pure white
                                              border: const OutlineInputBorder(
                                                // Set the border radius to 10 pixels
                                                borderSide: BorderSide(
                                                  color: Color.fromRGBO(
                                                      212, 212, 212, 1),
                                                  width: 2,
                                                ),
                                              ),
                                              focusedBorder: const OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color:  Color(0XFFFBA00F),
                                                  // Set the focused border color to #AA0123
                                                  width: 2,
                                                ),
                                              ),
                                              contentPadding: const EdgeInsets.symmetric(
                                                  vertical: 10, horizontal: 7),
                                            ),
                                            textCapitalization:
                                            TextCapitalization.words,
                                            keyboardType: TextInputType.text,
                                            style: const TextStyle(
                                              fontFamily: 'Poppins',
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: ScreenUtil().setHeight(10)),
                                        SizedBox(
                                          height: ScreenUtil().setHeight(50),
                                          child: TextFormField(
                                            controller: _emailController,
                                            decoration:  InputDecoration(
                                              hintText: 'Email (Optional)',
                                              hintStyle: TextStyle(
                                                fontSize: ScreenUtil().setSp(3.8),
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w400,
                                              ),
                                              filled: true,
                                              fillColor: Colors.white,
                                              // Set the background color to pure white
                                              border: const OutlineInputBorder(
                                                // Set the border radius to 10 pixels
                                                borderSide: BorderSide(
                                                  color: Color.fromRGBO(
                                                      212, 212, 212, 1),
                                                  width: 2,
                                                ),
                                              ),
                                              focusedBorder: const OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color:  Color(0XFFFBA00F),
                                                  // Set the focused border color to #AA0123
                                                  width: 2,
                                                ),
                                              ),
                                              contentPadding: const EdgeInsets.symmetric(
                                                  vertical: 10, horizontal: 7),
                                            ),
                                            textCapitalization:
                                            TextCapitalization.none,
                                            inputFormatters: [
                                              FilteringTextInputFormatter.allow(RegExp(
                                                  r'[a-zA-Z0-9@.!#$%&’*+/=?^_`{|}~-]')),
                                            ],
                                            keyboardType:
                                            TextInputType.emailAddress,
                                            style: const TextStyle(
                                              fontFamily: 'Poppins',
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: ScreenUtil().setHeight(20)),
                                        Center(
                                          child: Container(
                                            width: MediaQuery.of(context).size.width,
                                            height: ScreenUtil().setHeight(45),
                                            decoration: const BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                  color:
                                                  Color.fromRGBO(0, 0, 0, 0.25),
                                                  offset: Offset(0, 4),
                                                  blurRadius: 60,
                                                  spreadRadius: -10,
                                                ),
                                              ],
                                            ),
                                            child: Material(
                                              color: Colors.transparent,
                                              elevation: 0,
                                              child: ElevatedButton(
                                                onPressed: () async {
                                                  setState(() {
                                                    submittedRegistration = true;
                                                  });
                                                  if (_formKey.currentState
                                                      ?.validate() ??
                                                      false) {
                                                    setState(() {
                                                      isLoading = true;
                                                    });
                                                    await Future.delayed(
                                                        const Duration(
                                                            milliseconds: 1500));
                                                    setState(() {
                                                      isLoading = false;
                                                    });
                                                    if (_formKey.currentState
                                                        ?.validate() ??
                                                        false) {
                                                      final name =
                                                          _nameController.text;
                                                      final phoneNumber =
                                                          _phoneNumberController
                                                              .text;
                                                      final email =
                                                          _emailController.text;
                                                      final role =
                                                          _roleController.text;
                                                      final institution =
                                                          _institutionController.text;



                                                      final currentContext =
                                                          context;
                                                      try {
                                                        final http.Response
                                                        response =
                                                        await http.post(
                                                          Uri.parse(
                                                              'https://api.wowlogbook.com/api/v1/childcare/register'),
                                                          headers: <String, String>{
                                                            'Content-Type':
                                                            'application/json; charset=UTF-8',
                                                          },
                                                          body: jsonEncode({
                                                            'name': name,
                                                            'email': email,
                                                            'phone': phoneNumber,
                                                            'company': institution,
                                                            'position': role,
                                                          }),
                                                        );

                                                        var decodedRes = jsonDecode(
                                                            response.body);

                                                        if (response.statusCode ==
                                                            200) {
                                                          Future.microtask(() {
                                                            showDialog(
                                                              context:
                                                              currentContext,
                                                              builder: (dialogContext) =>
                                                                  Success(decodedRes[
                                                                  'message']),
                                                            );
                                                          }).then((value) {
                                                            // Return to the form state after dismissing the modal
                                                            setState(() {
                                                              _formKey.currentState
                                                                  ?.reset();
                                                              _nameController
                                                                  .clear();
                                                              _phoneNumberController
                                                                  .clear();
                                                              _emailController
                                                                  .clear();
                                                              _roleController
                                                                  .clear();
                                                              _institutionController
                                                                  .clear();
                                                              submittedRegistration =
                                                              false;
                                                              submittedRegistration =
                                                              false;
                                                            });
                                                          });
                                                        } else {
                                                          Future.microtask(() {
                                                            showDialog(
                                                              context:
                                                              currentContext,
                                                              builder:
                                                                  (dialogContext) =>
                                                                  Unsuccessful(
                                                                    decodedRes[
                                                                    'message'],
                                                                    returnToFormState:
                                                                        () {},
                                                                  ),
                                                            );
                                                          });
                                                        }
                                                      } catch (error) {
                                                        Future.microtask(() {
                                                          showDialog(
                                                            context: currentContext,
                                                            builder:
                                                                (dialogContext) =>
                                                                Unsuccessful(
                                                                  'Sorry, an error occurred while processing the request.',
                                                                  returnToFormState:
                                                                      () {},
                                                                ),
                                                          );
                                                        });
                                                      }
                                                    }
                                                  }
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                  const Color(0XFFFBA00F),
                                                  side: const BorderSide(
                                                      color: Color(0xFFFBA00F),
                                                      width: 0.3),
                                                ),
                                                child: isLoading
                                                    ? const SizedBox(
                                                  width: 25,
                                                  height: 25,
                                                  child:
                                                  CircularProgressIndicator(
                                                    valueColor:
                                                    AlwaysStoppedAnimation<
                                                        Color>(
                                                        Color(
                                                            0XFFFFFFFF)),
                                                  ),
                                                )
                                                    :  Text(
                                                  'SUBMIT',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: ScreenUtil().setSp(6.8),
                                                    fontFamily: 'Roboto',
                                                    fontWeight:
                                                    FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: ScreenUtil().setHeight(30),),
                                        Text(
                                          'We do not share any of your information with any third parties.',
                                          style: TextStyle(
                                            fontSize: ScreenUtil().setSp(3),
                                            fontFamily: 'Poppins',
                                            // fontWeight: FontWeight.w600,
                                            color: const Color(0XFF18191B),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )

              ],
            ),
          ),
          Positioned(
            bottom: ScreenUtil().setHeight(0), // Replace with desired height in logical pixels
            left: ScreenUtil().setWidth(0), // Replace with desired width in logical pixels
            right: ScreenUtil().setWidth(0), // Replace with desired width in logical pixels
            child: Column(
              children: [
                SizedBox(height: ScreenUtil().setHeight(10)), // Replace with desired height in logical pixels
                Text(
                  'wowlogbook.com',
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(4), // Replace with desired font size in logical pixels
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                    color: const Color(0XFF5C4E4E),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
