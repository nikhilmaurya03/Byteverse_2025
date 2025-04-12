import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuel_delivery/machenicHire.dart';
import 'package:fuel_delivery/orderFuel.dart';
import 'package:fuel_delivery/user_myOrder.dart';
import 'package:lucide_icons/lucide_icons.dart';

class OurServicesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue.shade300,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const OrderHistoryPage()),
            );
          },
          tooltip: 'MY Orders',
          backgroundColor: Colors.blueAccent.shade700,
          child:
              Icon(LucideIcons.listOrdered, size: 30.sp, color: Colors.white),
        ),
        body: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.blue.shade900, Colors.blue.shade300],
              ),
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0)
                      .r,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header Section
                  Center(
                    child: Text(
                      'Fuel Flow',
                      style: TextStyle(
                        fontSize: 32.r,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 16.r),
                  Center(
                    child: Text(
                      'Our Services',
                      style: TextStyle(
                        fontSize: 24.r,
                        fontWeight: FontWeight.w600,
                        color: Colors.white70,
                      ),
                    ),
                  ),
                  SizedBox(height: 24.r),
                  Text(
                    'We offer a range of services to keep you moving, from on-demand fuel delivery to professional mechanic assistance.',
                    style: TextStyle(fontSize: 16, color: Colors.white70),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 32.r),

                  // Fuel Delivery Section
                  _buildServiceCard(
                    icon: Icons.water_drop_outlined,
                    iconColor: Colors.blueAccent,
                    title: "Fuel Delivery",
                    description:
                        "Get fuel delivered directly to your vehicle wherever you are. We offer petrol, diesel, and gasoline.",
                    linkText: "Order Fuel Now >",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => OrderFuelPage()),
                      );
                    },
                  ),
                  SizedBox(
                    height: 26.r,
                  ),
                  _buildServiceCard(
                      icon: Icons.build_outlined,
                      iconColor: Colors.blueAccent,
                      title: "Mechanic Services",
                      description:
                          "Professional mechanics at your service. From tire changes to engine repairs, we've got you covered.",
                      linkText: "Hire a Mechanic >",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HireMechanicPage()),
                        );
                      }),

                  SizedBox(
                    height: 26.r,
                  ),
                  _buildServiceCard(
                      icon: Icons.timer_10_outlined,
                      iconColor: Colors.blueAccent,
                      title: "Emergency Service",
                      description:
                          "Stranded with an empty tank or car trouble? Our emergency services are available 24/7.",
                      linkText: "Get Emergency Help >",
                      onTap: () {}),
                ],
              ),
            ),
          ),
        ));
  }

  Widget _buildServiceCard(
      {required IconData icon,
      required Color iconColor,
      required String title,
      required String description,
      required String linkText,
      required VoidCallback onTap}) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8.r,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 20.r,
            backgroundColor: const Color(0xFFE5F0FF),
            child: Icon(icon, size: 22.sp, color: iconColor),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 6.h),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 13.5.sp,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 8.h),
                InkWell(
                    onTap: onTap,
                    child: Text(
                      linkText,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.blue,
                        fontWeight: FontWeight.w500,
                      ),
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }
}
