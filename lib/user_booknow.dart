import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PlaceOrderScreen extends StatefulWidget {
  final bool isMechHire;
  PlaceOrderScreen({Key? key, required this.isMechHire}) : super(key: key);
  @override
  _PlaceOrderScreenState createState() => _PlaceOrderScreenState();
}

class _PlaceOrderScreenState extends State<PlaceOrderScreen> {
  int? selectedPumpIndex;
  int? selectedMechanicIndex;
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

  List<Map<String, dynamic>> mechanics = [
    {
      'name': 'Sharda Mechanic ',
      'place': 'Andheri, Mumbai',
      'distanceKm': 3.5,
      'Engine Checkup': 2000.10,
      'battery Replacement': 2400.0,  
      'tire Change': 1800.0,
    },
    {
      'name': 'Shivaji Mechanic',
      'place': 'Bandra, Mumbai',
      'distanceKm': 5.8,
      'Engine Checkup': 1800.10,
      'battery Replacement': 3000.0,
      'tire Change': 1200.0,
      
    },
    {
      'name': 'Ramesh Mechanic',
      'place': 'Juhu, Mumbai',
      'distanceKm': 4.2,
      'Engine Checkup': 2060.10,
      'battery Replacement': 2500.0,
      'tire Change': 1500.0,
    }];
  void oilbookNow() {
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

  void mechanicbookNow() {
    if (selectedMechanicIndex == null) {
      Fluttertoast.showToast(msg: 'Please select mechanic first');
      return;
    }

    final selectedMechanic = mechanics[selectedMechanicIndex!];

    Fluttertoast.showToast(
      msg: 'Order placed from ${selectedMechanic['name']} with $selectedPaymentMethod',
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
        title: widget.isMechHire ? Text('Select Mechanic', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w600),) : Text('Select Petrol Pump', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w600),)),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           widget.isMechHire ? Text("Nearby Mechanics", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)) :Text('Nearby Petrol Pumps',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Visibility(
              visible: !widget.isMechHire,
              child: Expanded(
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
            ),
            Visibility(
              visible: widget.isMechHire,
              child: Expanded(
                child: ListView.builder(
                  itemCount: mechanics.length,
                  itemBuilder: (context, index){
                    final mechanic_shop = mechanics[index];
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
                        title: Text(mechanic_shop['name'], style: TextStyle(fontWeight: FontWeight.w600, fontSize:20),),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Place: ${mechanic_shop['place']}'),
                            Text('Distance: ${mechanic_shop['distanceKm']} km'),
                            Text('Engine Check Price: ₹${mechanic_shop['Engine Checkup']} / hour'),
                            Text('Battery Replacement Price: ₹${mechanic_shop['battery Replacement']}'),
                            Text('Tire Change Price: ₹${mechanic_shop['tire Change']}'),
                            
                          ],
                        ),
                        trailing: Radio<int>(
                          value: index,
                          groupValue: selectedMechanicIndex,
                          onChanged: (value) {
                            setState(() {
                              selectedMechanicIndex = value;
                            });
                          },
                        ),
                      ),
                    );
                  }
                  
                  
                   )
                   )
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
                  onPressed: widget.isMechHire ? mechanicbookNow : oilbookNow,
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
