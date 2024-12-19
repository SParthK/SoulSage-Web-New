import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:soul_sage_web/app/data/components/app_color.dart';
import 'package:soul_sage_web/app/data/components/app_icons_path.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 4.h),
                child: Image.asset(AppIcons.appLogo),
              ),
              Row(
                children: [
                  // Left Side (Login form)
                  Expanded(
                    flex: 3,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: constraints.maxWidth < 850 ? 20.h : 5.h),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Welcome to SoulSage!",
                              style: GoogleFonts.poppins(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 2.h),
                            Text(
                              "Enter your username and password to continue.",
                              style: GoogleFonts.poppins(
                                fontSize: 12.sp,
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(height: 5.h),

                            // Email TextField
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Email",
                                style: GoogleFonts.poppins(
                                  fontSize: 12.sp,
                                  color: AppColors.appBlack,
                                ),
                              ),
                            ),
                            SizedBox(height: 1.h),

                            TextField(
                              onChanged: (value) =>
                                  controller.email.value = value,
                              decoration: InputDecoration(
                                hintText: "Enter your email address",
                                border: const OutlineInputBorder(),
                                hintStyle: GoogleFonts.poppins(),
                              ),
                            ),
                            SizedBox(height: 3.h),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Password",
                                style: GoogleFonts.poppins(
                                  fontSize: 12.sp,
                                  color: AppColors.appBlack,
                                ),
                              ),
                            ),
                            SizedBox(height: 1.h),
                            // Password TextField
                            Obx(() {
                              return TextField(
                                obscureText:
                                    !controller.isPasswordVisible.value,
                                onChanged: (value) =>
                                    controller.password.value = value,
                                decoration: InputDecoration(
                                  hintText: "Enter your password",
                                  hintStyle: GoogleFonts.poppins(),
                                  border: const OutlineInputBorder(),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      controller.isPasswordVisible.value
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                    ),
                                    onPressed:
                                        controller.togglePasswordVisibility,
                                  ),
                                ),
                              );
                            }),
                            SizedBox(height: 4.h),

                            // Remember me and Forgot Password
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Obx(() {
                                  return Checkbox(
                                    value: controller.rememberMe.value,
                                    onChanged: (newValue) {
                                      controller.rememberMe.value = newValue!;
                                    },
                                  );
                                }),
                                Text(
                                  'Remember me',
                                  style: GoogleFonts.poppins(),
                                ),
                                const Spacer(),
                                TextButton(
                                  onPressed: () {
                                    // Forgot password functionality
                                  },
                                  child: Text(
                                    "Forgot password?",
                                    style: GoogleFonts.poppins(),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 2.h),

                            // Login Button
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: controller.login,
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(vertical: 2.h),
                                  backgroundColor: Colors.deepPurpleAccent,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: Text(
                                  'Log in',
                                  style: GoogleFonts.poppins(
                                      fontSize: 15.sp,
                                      color: AppColors.appWhite),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Right Side (Image/Illustration)
                  if (constraints.maxWidth > 850)
                    Expanded(
                      flex: 2,
                      child: Container(
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(AppIcons.loginPresentationImage),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
