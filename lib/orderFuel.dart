import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderFuelPage extends StatefulWidget {
  OrderFuelPage({super.key});

  @override
  State<OrderFuelPage> createState() => _OrderFuelPageState();
}

class _OrderFuelPageState extends State<OrderFuelPage> {
  String selectedFuelType = 'Petrol';

  int selectedQuantity = 5;

  DateTime selectedDate = DateTime.now();

  double pricePerGallon = 3.45;

  double total = 0;

  bool isCurrentLocation = false;

  List<Map<String, dynamic>> fuels = [
    {'fuel': 'Petrol', 'rate': 3.45, 'color': Colors.red},
    {'fuel': 'Diesel', 'rate': 3.75, 'color': Colors.green},
    {'fuel': 'Gasoline', 'rate': 3.55, 'color': Colors.amber}
  ];

  List<int> quantities = [1, 3, 5, 10, 15, 20];

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate)
      //setState(() {
      selectedDate = picked;
    // });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    total = pricePerGallon * selectedQuantity;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome, Dear ',
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                'What would you like to do today?',
                style: TextStyle(
                  fontSize: 14.5.sp,
                  color: Colors.black54,
                ),
              ),
              SizedBox(height: 20.h),
              Row(
                children: [
                  _buildTab(
                      icon: Icons.local_gas_station,
                      label: 'Order Fuel',
                      selected: true),
                  // _buildTab(icon: Icons.build, label: 'Hire Mechanic'),
                  // _buildTab(icon: Icons.receipt, label: 'My Orders'),
                ],
              ),
              SizedBox(height: 24.h),
              _buildSectionTitle('Order Fuel'),
              SizedBox(height: 12.h),
              Text(
                'Select Fuel Type',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 16.h),
              Container(
                height: 240.r,
                width: 360.r,
                child: ListView.builder(
                  itemCount: fuels.length,
                  itemBuilder: (context, index) {
                    final fuel = fuels[index];
                    return InkWell(
                        onTap: () {
                          setState(() {
                            selectedFuelType = fuel['fuel'];
                            total = fuel['rate'] * selectedQuantity;
                            pricePerGallon = fuel['rate'];
                          });
                        },
                        child: _buildFuelCard(
                          color: fuel['color'],
                          fuelType: fuel['fuel'],
                          price: fuel['rate'].toString(),
                          selected:
                              selectedFuelType == fuel['fuel'] ? true : false,
                        ));
                  },
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.h),
                  Text("Quantity:  ${selectedQuantity} gallons",
                      style: TextStyle(fontSize: 16.sp)),
                  SizedBox(height: 8.h),
                  DropdownButtonFormField<int>(
                    value: selectedQuantity,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                    items: quantities
                        .map((qty) => DropdownMenuItem(
                              value: qty,
                              child: Text("$qty gallons",
                                  style: TextStyle(fontSize: 14.sp)),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedQuantity = value!;
                        total = pricePerGallon * selectedQuantity;
                      });
                    },
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Delivery Location",
                          style: TextStyle(fontSize: 16.sp)),
                      Checkbox(
                          value: isCurrentLocation,
                          onChanged: (_) {
                            setState(() {
                              isCurrentLocation = !isCurrentLocation;
                            });
                          }),
                      Text("Use current location",
                          style: TextStyle(fontSize: 14.sp))
                    ],
                  ),
                  Visibility(
                    visible: isCurrentLocation,
                    child: Container(
                      padding: EdgeInsets.all(12.w),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          color: Colors.white38,
                          border: Border.all(color: Colors.grey.shade300)),
                      child: Row(
                        children: [
                          Icon(Icons.location_on, color: Colors.blue),
                          SizedBox(width: 10.w),
                          Text("Using your current location",
                              style: TextStyle(fontSize: 14.sp)),
                        ],
                      ),
                    ),
                  ),
                  Visibility(
                    visible: !isCurrentLocation,
                    child: Container(
                        padding: EdgeInsets.all(12.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          color: Colors.grey.shade100,
                        ),
                        child: TextFormField(
                         
                          decoration: InputDecoration(
                            hintText: "Enter your location",
                            prefixIcon:
                                Icon(Icons.location_on, color: Colors.blue),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 2.w, vertical: 14.h),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.r),
                              borderSide:
                                  BorderSide(color: Colors.grey.shade300),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.r),
                              borderSide:
                                  BorderSide(color: Colors.grey.shade300),
                            ),
                          ),
                        )),
                  ),
                  SizedBox(height: 20.h),
                  Text("Delivery Date", style: TextStyle(fontSize: 16.sp)),
                  SizedBox(height: 8.h),
                  GestureDetector(
                    onTap: () => _selectDate(context),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 12.w, vertical: 14.h),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade400),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${selectedDate.day.toString().padLeft(2, '0')}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.year}",
                            style: TextStyle(fontSize: 14.sp),
                          ),
                          Icon(Icons.calendar_today, size: 20.sp),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Order Summary",
                            style: TextStyle(
                                fontSize: 16.sp, fontWeight: FontWeight.bold)),
                        SizedBox(height: 10.h),
                        _buildSummaryRow("Fuel Type:", selectedFuelType),
                        _buildSummaryRow(
                            "Quantity:", selectedQuantity.toString()),
                        _buildSummaryRow("Price per gallon:",
                            "\$${pricePerGallon.toStringAsFixed(2)}"),
                        Divider(),
                        _buildSummaryRow(
                            "Total:", "\$${total.toStringAsFixed(2)}",
                            isBold: true, color: Colors.blue),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                      backgroundColor: Colors.blueAccent,
                    ),
                    child: Center(
                      child: Text("Place Order",
                          style:
                              TextStyle(fontSize: 16.sp, color: Colors.white)),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTab(
      {required IconData icon, required String label, bool selected = false}) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: selected ? Colors.blue : Colors.transparent,
              width: 2.w,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon,
                size: 16.sp, color: selected ? Colors.blue : Colors.black54),
            SizedBox(width: 6.w),
            Text(
              label,
              style: TextStyle(
                fontSize: 18.r,
                fontWeight: FontWeight.w700,
                color: selected ? Colors.blue : Colors.black54,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildFuelCard({
    required Color color,
    required String fuelType,
    required String price,
    bool selected = false,
  }) {
    return Column(children: [
      Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: selected ? Colors.blue : const Color(0xFFE0E0E0),
            width: selected ? 2.w : 1.w,
          ),
          color: Colors.white,
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 16.r,
              backgroundColor: color.withOpacity(0.2),
              child:
                  Icon(Icons.local_fire_department, color: color, size: 18.sp),
            ),
            SizedBox(width: 12.w),
            Text(
              fuelType,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: selected ? Colors.blue : Colors.black87,
              ),
            ),
            const Spacer(),
            Text(
              '\$ ${price}/gallon',
              style: TextStyle(
                fontSize: 14.sp,
                color: selected ? Colors.blue : Colors.black54,
              ),
            ),
          ],
        ),
      ),
      SizedBox(
        height: 15.r,
      ),
    ]);
  }

  Widget _buildSummaryRow(String label, String value,
      {bool isBold = false, Color? color}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: 14.sp)),
          Text(
            value,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              color: color ?? Colors.black,
            ),
          )
        ],
      ),
    );
  }
}
