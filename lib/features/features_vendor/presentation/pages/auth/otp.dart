import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Otp extends StatefulWidget {
  @override
  State<Otp> createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  // لاحتفاظ بالقيم المدخلة
  final List<TextEditingController> _otpControllers =
      List.generate(5, (_) => TextEditingController());

  @override
  Widget build(BuildContext context) {
    // الحصول على عرض الشاشة
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xfff0f1f6),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Icon(
                    Icons.arrow_back,
                    size: screenWidth * 0.08, // حجم السهم
                    color: Colors.black54,
                  ),
                ),
              ),
              SizedBox(
                height: 2,
              ),
              Container(
                width: 200, // ضبط عرض الحاوية بنسبة من عرض الشاشة
                height: 120, // ضبط ارتفاع الحاوية بنسبة من عرض الشاشة
                decoration: BoxDecoration(
                  color: Colors.deepPurple.shade100,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    'EMPO',
                    style: GoogleFonts.poppins(
                      fontSize: 38, // حجم النص
                      color: Colors.deepPurple,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Text(
                'Verification',
                style: GoogleFonts.poppins(
                  fontSize: screenWidth * 0.05, // حجم النص
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(
                height: 2,
              ),
              Text(
                "Enter your OTP code number",
                style: GoogleFonts.poppins(
                  fontSize: screenWidth * 0.04, // حجم النص
                  fontWeight: FontWeight.w500,
                  color: Colors.black54,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 12,
              ),
              Container(
                width: 900,
                padding: EdgeInsets.all(screenWidth * 0.06),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(5, (index) {
                        return _textFieldOTP(
                          first: index == 0,
                          last: index == 4,
                          screenWidth: screenWidth,
                          controller: _otpControllers[index],
                        );
                      }),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          // طباعة القيم المدخلة
                          String otpCode = _otpControllers
                              .map((controller) => controller.text)
                              .join();
                          print("OTP Code: $otpCode");
                        },
                        style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.deepPurple),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24.0),
                            ),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(screenWidth * 0.035),
                          child: Text(
                            'Verify',
                            style: GoogleFonts.poppins(
                                fontSize: screenWidth * 0.045),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                "Didn't you receive any code?",
                style: GoogleFonts.poppins(
                  fontSize: screenWidth * 0.04, // حجم النص
                  fontWeight: FontWeight.w500,
                  color: Colors.black54,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 16,
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  "Resend New Code",
                  style: GoogleFonts.poppins(
                    fontSize: screenWidth * 0.045, // حجم النص
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                  ),
                ),
                // textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _textFieldOTP({
    required bool first,
    required bool last,
    required double screenWidth,
    required TextEditingController controller,
  }) {
    return Container(
      height: screenWidth * 0.18,
      child: AspectRatio(
        aspectRatio: 0.8,
        child: TextField(
          controller: controller,
          autofocus: true,
          onChanged: (value) {
            if (value.length == 1 && last == false) {
              FocusScope.of(context).nextFocus();
            }
            if (value.length == 0 && first == false) {
              FocusScope.of(context).previousFocus();
            }
          },
          showCursor: false,
          readOnly: false,
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
              fontSize: screenWidth * 0.06, fontWeight: FontWeight.bold),
          keyboardType: TextInputType.number,
          maxLength: 1,
          decoration: InputDecoration(
            counter: Offstage(),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: Colors.black12),
                borderRadius: BorderRadius.circular(12)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: Colors.deepPurple),
                borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ),
    );
  }
}
