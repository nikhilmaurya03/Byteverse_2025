import 'dart:ui';
import 'package:fuel_delivery/log_in.dart';
import 'package:fuel_delivery/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



class FuelFlowHomePage extends StatelessWidget {
  const FuelFlowHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.local_gas_station, color: Colors.blue[300], size: 22.sp),
            SizedBox(width: 8.w),
            Text(
              'Fuel Flow',
              style: TextStyle(color: Colors.blue[300], fontSize: 24.sp, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        actions: [
          // IconButton(
          //   icon: Icon(Icons.menu, color: Colors.black87, size: 22.sp),
          //   onPressed: () {},
          // ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Hero Section
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 40.h),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue.shade700, Colors.grey.shade900],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Fuel Delivery &\nMechanic Services At Your\nFingertips',
                    style: TextStyle(
                      fontSize: 26.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      height: 1.3,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    'Never worry about running out of fuel again. Get fuel delivered to your doorstep or hire experienced mechanics with just a few taps.',
                    style: TextStyle(
                      fontSize: 15.sp,
                      color: Colors.white70,
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: 40.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.blue.shade200, Colors.blueAccent.shade700],
                          ),
                          borderRadius: BorderRadius.circular(30.r),
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => LoginPage()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.r),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 32.w, vertical: 16.h),
                          ),
                          child: Text('Order Now', style: TextStyle(fontSize: 16.sp, color: Colors.white)),
                        ),
                      ),
                      TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.black26,
                      padding: EdgeInsets.symmetric(
                          horizontal: 32.w, vertical: 16.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Learn More', style: TextStyle(fontSize: 16.sp)),
                        SizedBox(width: 8.w),
                        Icon(Icons.arrow_forward,
                            size: 18.sp, color: Colors.white),
                      ],
                    ),
                  ),
                    ],
                  ),
                  SizedBox(height:7.r),
                  Row(children: [
                   SizedBox(width: 120.r,),
                  Image.asset('assets/hand_Gif.gif', height: 40.h, width: 40.w),
                  ],),
                  
                  SizedBox(height: 16.h),
                  
                ],
              ),
            ),

            // Our Services Section
            Container(
              width: double.infinity,
              color: Colors.grey[100],
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 40.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      'Our Services',
                      style: TextStyle(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Center(
                    child: Text(
                      'We offer a range of services to keep you moving, from fuel delivery to professional mechanic assistance.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.black54,
                        height: 1.4,
                      ),
                    ),
                  ),
                  SizedBox(height: 30.h),
                  // Service Card
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.r),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10.r,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(16.r),
                              topRight: Radius.circular(16.r),
                            ),
                          ),
                          padding: EdgeInsets.all(16.w),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 20.r,
                                backgroundColor: Colors.blue[200],
                                child: Icon(Icons.local_shipping,
                                    color: Colors.white, size: 20.sp),
                              ),
                              SizedBox(width: 12.w),
                              Text(
                                'Fuel Delivery',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(16.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Get fuel delivered to your doorstep. Choose from petrol, diesel, or gasoline.',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Colors.black87,
                                ),
                              ),
                              SizedBox(height: 12.h),
                              InkWell(
                                onTap: () {},
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'Learn more',
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        color: Colors.blue,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(width: 4.w),
                                    Icon(Icons.arrow_forward,
                                        size: 16.sp, color: Colors.blue),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.r,
                  ),
                  //service card
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.r),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10.r,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(16.r),
                              topRight: Radius.circular(16.r),
                            ),
                          ),
                          padding: EdgeInsets.all(16.w),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 20.r,
                                backgroundColor: Colors.blue[200],
                                child: Icon(Icons.local_shipping,
                                    color: Colors.white, size: 20.sp),
                              ),
                              SizedBox(width: 12.w),
                              Text(
                                'Machenics Service',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(16.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Hire professional mechanics for repairs and maintenance services.',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Colors.black87,
                                ),
                              ),
                              SizedBox(height: 12.h),
                              InkWell(
                                onTap: () {},
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'Learn more',
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        color: Colors.blue,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(width: 4.w),
                                    Icon(Icons.arrow_forward,
                                        size: 16.sp, color: Colors.blue),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(
                    height: 20.r,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.r),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10.r,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(16.r),
                              topRight: Radius.circular(16.r),
                            ),
                          ),
                          padding: EdgeInsets.all(16.w),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 20.r,
                                backgroundColor: Colors.blue[200],
                                child: Icon(Icons.local_shipping,
                                    color: Colors.white, size: 20.sp),
                              ),
                              SizedBox(width: 12.w),
                              Text(
                                'Emergency Service',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(16.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Get immediate assistance when your stranded with an empty tank.',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Colors.black87,
                                ),
                              ),
                              SizedBox(height: 12.h),
                              InkWell(
                                onTap: () {},
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'Learn more',
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        color: Colors.blue,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(width: 4.w),
                                    Icon(Icons.arrow_forward,
                                        size: 16.sp, color: Colors.blue),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'How It Works',
                    style: TextStyle(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    'Getting fuel delivered or hiring a mechanic is easy with Fuel Flow.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.black54,
                      height: 1.4,
                    ),
                  ),
                  SizedBox(height: 30.h),

                  // Step 1
                  _buildStepItem(
                    step: '1',
                    title: 'Choose Your Service',
                    description:
                        'Select the service you need - fuel delivery or mechanic assistance.',
                  ),
                  SizedBox(height: 30.h),

                  // Step 2
                  _buildStepItem(
                    step: '2',
                    title: 'Provide Location',
                    description:
                        'Enter your location or use GPS to pinpoint your exact position.',
                  ),

                  SizedBox(
                    height: 30.h,
                  ),
                  _buildStepItem(
                    step: '3',
                    title: 'Complete Order',
                    description:
                        'Make payment and wait for your fuel or mechanic to arrive.',
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30.r,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Why Choose Fuel Flow?',
                    style:
                        TextStyle(fontSize: 28.r, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 20.r,
                  ),
                  Text(
                    'We aim to provide the most convenient and reliable fuel delivery and mechanic services, saving you time and hassle.',
                    style: TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                  SizedBox(height: 20),
                  buildFeature(
                    icon: Icons.access_time,
                    title: '24/7 Service Availability',
                    description:
                        'Get fuel delivered or hire mechanics anytime, day or night.',
                  ),
                  buildFeature(
                    icon: Icons.local_shipping,
                    title: 'Fast Delivery',
                    description:
                        'Our network of gas stations ensures quick delivery times.',
                  ),
                  buildFeature(
                    icon: Icons.build_circle,
                    title: 'Professional Mechanics',
                    description:
                        'Skilled and certified mechanics to help with your vehicle issues.',
                  ),
                  buildFeature(
                    icon: Icons.security,
                    title: 'Safe & Secure Transactions',
                    description:
                        'Multiple payment options with secure transaction processing.',
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20.r,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header Section
                  Text(
                    'Fuel Flow',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue.shade900,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Convenient and reliable fuel delivery services, right at your doorstep.',
                    style: TextStyle(fontSize: 18, color: Colors.black87),
                  ),
                  SizedBox(height: 32),

                  // "Quick Links" Section
                  buildSectionTitle('Quick Links'),
                  buildQuickLinks(),
                  SizedBox(height: 24),

                  // "Our Services" Section
                  buildSectionTitle('Our Services'),
                  buildServices(),
                  SizedBox(height: 24),

                  // "Contact Us" Section
                  buildSectionTitle('Contact Us'),
                  buildContactInfo(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Section Title Widget
  Widget buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.blue.shade700,
      ),
    );
  }

  // Quick Links
  Widget buildQuickLinks() {
    final links = [
      'Home',
      'Services',
      'About Us',
      'Contact Us',
      'Login',
      'Register'
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: links
          .map((link) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Text(
                  link,
                  style: TextStyle(fontSize: 16, color: Colors.blue),
                ),
              ))
          .toList(),
    );
  }

  // Our Services
  Widget buildServices() {
    final services = [
      'Fuel Delivery',
      'Mechanic Service',
      'Gas Station Network',
      'Corporate Solutions',
      'Emergency Fuel'
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: services
          .map((service) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Text(
                  service,
                  style: TextStyle(fontSize: 16, color: Colors.black87),
                ),
              ))
          .toList(),
    );
  }

  // Contact Info
  Widget buildContactInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '123 Fuel Street, City Center, State 12345',
          style: TextStyle(fontSize: 16, color: Colors.black87),
        ),
        SizedBox(height: 8),
        Text(
          '+1 (555) 123-4567',
          style: TextStyle(fontSize: 16, color: Colors.black87),
        ),
      ],
    );
  }

  Widget buildFeature({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.blue, size: 30),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87),
                ),
                SizedBox(height: 5),
                Text(
                  description,
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepItem({
    required String step,
    required String title,
    required String description,
  }) {
    return Column(
      children: [
        CircleAvatar(
          radius: 30.r,
          backgroundColor: Colors.blue[50],
          child: Text(
            step,
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
        ),
        SizedBox(height: 16.h),
        Text(
          title,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          description,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14.sp,
            color: Colors.black54,
            height: 1.4,
          ),
        ),
      ],
    );
  }
}
