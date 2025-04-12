import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HireMechanicPage extends StatelessWidget {
  const HireMechanicPage({Key? key}) : super(key: key);

  final List<Map<String, dynamic>> _services = const [
    {
      'title': 'Tire Change',
      'description':
          'Professional tire change service. We bring the tools, you just relax.',
      'price': '\$49.99',
      'image': 'assets/tire_change.png',
    },
    {
      'title': 'Engine Check',
      'description':
          'Expert engine diagnostics to identify and fix issues quickly.',
      'price': '\$69.99',
      'image': 'assets/engine.png',
    },
    {
      'title': 'Battery Replacement',
      'description':
          'Fast and reliable battery replacement service at your location.',
      'price': '\$59.99',
      'image': 'assets/battery_change.jpg',
    }
    // Add more services here if needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      appBar: AppBar(
        title:  Text('Hire Mechanic', style: TextStyle(fontFamily: 'Signika', fontWeight: FontWeight.bold,fontSize: 28.r,color: Colors.white),),
        centerTitle: true,
        backgroundColor: Colors.blueAccent.shade700,
        shadowColor: Colors.blueAccent.shade200,
        elevation: 5,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _services.length,
        itemBuilder: (context, index) {
          final service = _services[index];
          return Card(
            color: Colors.white,
            shadowColor: Colors.grey.shade400,
            
            margin:  EdgeInsets.only(bottom: 16).r,
            shape:
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: BorderSide(
                    color: Colors.grey.shade300,
                    width: 2.r,)
                  ),
            elevation: 4,
            child: Stack(
            //  crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image section
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16)),
                  child: Image.asset(
                    service['image'],
                    height: 270.r,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      height: 150.r,
                      color: Colors.grey.shade300,
                      alignment: Alignment.center,
                      child: Text(
                        service['title'],
                        style:  TextStyle(
                            fontSize: 18.r, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                
                Container(
                  height: 270.r,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.black54.withOpacity(0.1),
                        Colors.black.withOpacity(0.5),
                        Colors.black54.withOpacity(0.9),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      
                    ),
                    borderRadius:  BorderRadius.circular(
                      16.r
                    ),
                  ),
                ),
               
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 90.r,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16.r),
                            topRight: Radius.circular(16.r),
                          ),
                        ),
                        child: Center(),
                      ),
                      
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.black26.withOpacity(0.4),
                          border: Border.all(color: Colors.blue.shade300, width: 2.r),
                          borderRadius: BorderRadius.circular(10.r),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blue.withOpacity(0.8),
                              blurRadius: 8.r,
                              offset: const Offset(2, 4),
                            ),
                            
                          ],
                        ),
                        child: Text(
                          service['title'],
                         
                          style:  TextStyle(
                              fontSize: 24.r, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                       SizedBox(height: 16.r),
                      Text(
                        service['description'],
                        style:  TextStyle(fontSize: 16.r, fontWeight: FontWeight.w600, 
                        color: Colors.white70),
                      ),
                       SizedBox(height: 4.r),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            service['price'],
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                          // hi
                          Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                                Colors.blue.shade300,
                                Colors.blue.shade700,
                              ]),
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: ElevatedButton(
                              onPressed: () {
                                // Add your action here
                              },
                              style: ElevatedButton.styleFrom(
                                elevation: 3,
                                padding:  EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10).r,
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20).r,
                                ),
                              ),
                              child:  Text('Hire Now',
                                  style: TextStyle(
                                    fontSize: 16.r,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
