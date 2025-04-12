import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PlaceOrderScreen extends StatefulWidget {
  @override
  _PlaceOrderScreenState createState() => _PlaceOrderScreenState();
}

class _PlaceOrderScreenState extends State<PlaceOrderScreen> {
  int? selectedPumpIndex;
  String selectedPaymentMethod = 'COD';

  List<Map<String, dynamic>> petrolPumps = [
    {
      'name': 'Shell Fuel Station',
      'place': 'Andheri, Mumbai',
      'distanceKm': 3.5,
      'pricePerLitre': 106.20,
      'timing': '24 Hours',
    },
    {
      'name': 'HP Petrol Pump',
      'place': 'Bandra, Mumbai',
      'distanceKm': 5.8,
      'pricePerLitre': 105.90,
      'timing': '6AM - 10PM',
    },
    {
      'name': 'Indian Oil Pump',
      'place': 'Juhu, Mumbai',
      'distanceKm': 4.2,
      'pricePerLitre': 106.10,
      'timing': '24 Hours',
    },
  ];

  void bookNow() {
    if (selectedPumpIndex == null) {
      Fluttertoast.showToast(msg: 'Please select pump first');
      return;
    }

    final selectedPump = petrolPumps[selectedPumpIndex!];

    // Here you can proceed to Razorpay or save order based on selectedPaymentMethod
    Fluttertoast.showToast(
      msg:
          'Order placed from ${selectedPump['name']} with $selectedPaymentMethod',
    );

    // Example logic:
    // if (selectedPaymentMethod == 'ONLINE') {
    //    triggerRazorpayPayment();
    // } else {
    //    saveOrderToDatabase();
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue.shade600,
        title: Text('Select Petrol Pump', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w600),)),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nearby Petrol Pumps',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Expanded(
              child: ListView.builder(
                itemCount: petrolPumps.length,
                itemBuilder: (context, index) {
                  final pump = petrolPumps[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    color: Colors.white,
                    shadowColor: Colors.grey.shade300,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: BorderSide(color: Colors.grey.shade400, width: 1),
                    ),
                    elevation: 3,
                    child: ListTile(
                      title: Text(pump['name'], style: TextStyle(fontWeight: FontWeight.w600, fontSize:20),),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Place: ${pump['place']}'),
                          Text('Distance: ${pump['distanceKm']} km'),
                          Text('Price: ₹${pump['pricePerLitre']} / Litre'),
                          Text('Timing: ${pump['timing']}'),
                        ],
                      ),
                      trailing: Radio<int>(
                        value: index,
                        groupValue: selectedPumpIndex,
                        onChanged: (value) {
                          setState(() {
                            selectedPumpIndex = value;
                          });
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 15),
            Text('Select Payment Method',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ListTile(
              title: const Text('Cash on Delivery', style: TextStyle(color: Colors.green),),
              leading: Radio<String>(
                value: 'COD',
                groupValue: selectedPaymentMethod,
                onChanged: (value) {
                  setState(() {
                    selectedPaymentMethod = value!;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('Online Payment', style: TextStyle(color: Colors.green),),
              leading: Radio<String>(
                value: 'ONLINE',
                groupValue: selectedPaymentMethod,
                onChanged: (value) {
                  setState(() {
                    selectedPaymentMethod = value!;
                  });
                },
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                 // color: Colors.blue,
                 gradient: LinearGradient(
                  colors: [Colors.blue.shade300, Colors.blue.shade600],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  ),
                  onPressed: bookNow,
                  child: Text('Book Now', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
