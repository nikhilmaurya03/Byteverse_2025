import 'package:flutter/material.dart';

class TodayOrdersPage extends StatefulWidget {
  TodayOrdersPage({super.key});

  @override
  State<TodayOrdersPage> createState() => _TodayOrdersPageState();
}

class _TodayOrdersPageState extends State<TodayOrdersPage> {

  //...................order list...................
  final List<Order> orders = [
    Order(
      id: 1,
      status: 'Pending',
      dateTime: DateTime(2025, 4, 6, 23, 26),
      price: 34.50,
      fuelType: 'Petrol',
      quantity: '10 gallons',
      address: '123 Market St, San Francisco, CA',
    ),
    Order(
      id: 2,
      status: 'Confirmed',
      dateTime: DateTime(2025, 4, 6, 22, 26),
      price: 29.99,
      fuelType: 'Diesel',
      quantity: '8 gallons',
      address: '456 Oak St, San Francisco, CA',
    ),
  ];

  List<Order> filteredOrders = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    filteredOrders = orders;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      appBar: AppBar(
        title: const Text(
          "Today's Orders",
          style: TextStyle(
              color: Colors.white, fontSize: 24, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue.shade600,
        shadowColor: Colors.grey.shade300,
        elevation: 2,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Orders Management",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: "Search by order ID or address",
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: 'All Status',
              items: ['All Status', 'Pending', 'Confirmed', 'Cancelled']
                  .map((status) =>
                      DropdownMenuItem(value: status, child: Text(status)))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  filteredOrders = orders.where((order) {
                    if (value == 'All Status') return true;
                    return order.status == value;
                  }).toList();
                });
              },
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: filteredOrders.length,
                itemBuilder: (context, index) {
                  final order = filteredOrders[index];
                  return OrderCard(order: order);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class OrderCard extends StatelessWidget {
  final Order order;

  const OrderCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    Color statusColor = order.status == 'Pending'
        ? Colors.amber
        : order.status == 'Confirmed'
            ? Colors.blueAccent
            : Colors.grey;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      color: Colors.white,
      shadowColor: Colors.grey.shade300,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.grey.shade400, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Order #${order.id}",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16)),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(order.status,
                      style: TextStyle(
                          color: statusColor, fontWeight: FontWeight.w500)),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              '${order.dateTime.toLocal()}'.split('.')[0],
              style: TextStyle(color: Colors.grey[700]),
            ),
            const SizedBox(height: 12),
            Text('\$${order.price.toStringAsFixed(2)}',
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.blue)),
            const SizedBox(height: 8),
            Row(
              children: [
                Chip(
                  label: Text(order.fuelType),
                  backgroundColor: order.fuelType == 'Petrol'
                      ? Colors.red[100]
                      : order.fuelType == 'Diesel'
                          ? Colors.green[100]
                          : Colors.orange[100],
                ),
                const SizedBox(width: 8),
                Text(order.quantity),
              ],
            ),
            const SizedBox(height: 8),
            const Text("Delivery Address",
                style: TextStyle(fontWeight: FontWeight.w600)),
            Text(order.address),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                    onPressed: () {},
                    child: const Text("Confirm Order"),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[300]),
                    onPressed: () {},
                    child: const Text("Cancel",
                        style: TextStyle(color: Colors.black)),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class Order {
  final int id;
  final String status;
  final DateTime dateTime;
  final double price;
  final String fuelType;
  final String quantity;
  final String address;

  Order({
    required this.id,
    required this.status,
    required this.dateTime,
    required this.price,
    required this.fuelType,
    required this.quantity,
    required this.address,
  });
}
