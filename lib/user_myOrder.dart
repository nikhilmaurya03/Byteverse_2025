import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderHistoryPage extends StatefulWidget {
  const OrderHistoryPage({super.key});

  @override
  State<OrderHistoryPage> createState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends State<OrderHistoryPage> {
  int _selectedSegment = 0;
  final DateFormat _dateFormat = DateFormat('dd MMM yyyy, hh:mm a');

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.blue.shade100,
        appBar: AppBar(
          title: const Text('My Orders', style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.w600),),
          elevation: 0,
          backgroundColor: Colors.blue,
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Current',),
              Tab(text: 'History'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // CURRENT ORDERS TAB
            _buildCurrentOrdersTab(),

            // HISTORY TAB
            _buildHistoryTab(),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrentOrdersTab() {
    final currentOrders = [
      _FuelOrder(
        id: '#12346',
        status: OrderStatus.onTheWay,
        fuelType: 'Petrol',
        quantity: '10L',
        price: 800,
        pumpName: 'BP Pump',
        pumpLocation: 'Sector 15',
        date: DateTime.now().subtract(const Duration(minutes: 30)),
        deliveryBoy: _DeliveryBoy(
          name: 'Rahul',
          phone: '+91 98765 12345',
          vehicleNumber: 'DL 05 AB 1234',
          location: 'Near Sector 14',
          eta: '15 min',
          lat: 28.6139,
          long: 77.2090,
        ),
      ),
      _FuelOrder(
        id: '#12347',
        status: OrderStatus.confirmed,
        fuelType: 'Diesel',
        quantity: '20L',
        price: 1600,
        pumpName: 'Indian Oil',
        pumpLocation: 'Sector 18',
        date: DateTime.now().subtract(const Duration(minutes: 5)),
      ),
    ];

    if (currentOrders.isEmpty) {
      return const Center(
        child: Text('No current orders'),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: currentOrders.length,
      itemBuilder: (context, index) {
        final order = currentOrders[index];
        return _buildCurrentOrderCard(order);
      },
    );
  }

  Widget _buildCurrentOrderCard(_FuelOrder order) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      color: Colors.white,
      shadowColor: Colors.grey.shade300,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  order.id,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                _buildStatusChip(order.status),
              ],
            ),
            const SizedBox(height: 12),
            // Order details
            _buildOrderDetailRow(Icons.local_gas_station,
                '${order.fuelType} (${order.quantity})'),
            _buildOrderDetailRow(Icons.currency_rupee, '₹${order.price}'),
            _buildOrderDetailRow(
                Icons.location_on, '${order.pumpName}, ${order.pumpLocation}'),
            _buildOrderDetailRow(
                Icons.calendar_today, _dateFormat.format(order.date)),

            if (order.deliveryBoy != null) ...[
              const Divider(height: 24),
              // Delivery boy info
              const Text(
                'Delivery Executive',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              _buildDeliveryBoyInfo(order.deliveryBoy!),

              const SizedBox(height: 16),

              // Track Delivery button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.directions),
                  label: const Text('TRACK DELIVERY'),
                  onPressed: () => _openMapForTracking(order.deliveryBoy!),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
            ] else ...[
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {},
                  child: const Text('WAITING FOR DELIVERY EXECUTIVE'),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildDeliveryBoyInfo(_DeliveryBoy deliveryBoy) {
    return Column(
      children: [
        Row(
          children: [
            const Icon(Icons.person, size: 20),
            const SizedBox(width: 8),
            Text(deliveryBoy.name),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            const Icon(Icons.phone, size: 20),
            const SizedBox(width: 8),
            GestureDetector(
              onTap: () => _callNumber(deliveryBoy.phone),
              child: Text(
                deliveryBoy.phone,
                style: const TextStyle(
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            const Icon(Icons.directions_bike, size: 20),
            const SizedBox(width: 8),
            Text(deliveryBoy.vehicleNumber),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            const Icon(Icons.location_pin, size: 20),
            const SizedBox(width: 8),
            Text('${deliveryBoy.location} (ETA: ${deliveryBoy.eta})'),
          ],
        ),
      ],
    );
  }

  Widget _buildStatusChip(OrderStatus status) {
    final statusData = {
      OrderStatus.confirmed: {'text': 'Confirmed', 'color': Colors.orange},
      OrderStatus.onTheWay: {'text': 'On the way', 'color': Colors.blue},
      OrderStatus.delivered: {'text': 'Delivered', 'color': Colors.green},
      OrderStatus.cancelled: {'text': 'Cancelled', 'color': Colors.red},
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        // color: statusData[status]!['color'] as Color,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: statusData[status]!['color'] as Color,
          width: 1,
        ),
      ),
      child: Text(
        statusData[status]!['text'] as String,
        style: TextStyle(
          color: statusData[status]!['color'] as Color,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildOrderDetailRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 20),
          const SizedBox(width: 8),
          Text(text),
        ],
      ),
    );
  }

  Future<void> _openMapForTracking(_DeliveryBoy deliveryBoy) async {
    final url = Uri.parse(
      'https://www.google.com/maps?q=${deliveryBoy.lat},${deliveryBoy.long}',
    );
   try{
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not launch maps')),
      );
    }} catch(e){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not launch maps')),
      );
    print('Error launching maps: $e');
    }
    
  }

  Future<void> _callNumber(String phone) async {
    final url = Uri.parse('tel:$phone');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }

  Widget _buildHistoryTab() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          // Segmented Control for History tab
          Container(
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.all(4),
            child: Row(
              children: [
                Expanded(
                  child: ChoiceChip(
                    label: const Text('Fuel Orders'),
                    selected: _selectedSegment == 0,
                    onSelected: (selected) {
                      setState(() {
                        _selectedSegment = selected ? 0 : _selectedSegment;
                      });
                    },
                    selectedColor: Colors.blue,
                    labelStyle: TextStyle(
                      color:
                          _selectedSegment == 0 ? Colors.white : Colors.black,
                    ),
                  ),
                ),
                Expanded(
                  child: ChoiceChip(
                    label: const Text('Mechanic Services'),
                    selected: _selectedSegment == 1,
                    onSelected: (selected) {
                      setState(() {
                        _selectedSegment = selected ? 1 : _selectedSegment;
                      });
                    },
                    selectedColor: Colors.blue,
                    labelStyle: TextStyle(
                      color:
                          _selectedSegment == 1 ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Content based on selection
          Expanded(
            child: _selectedSegment == 0
                ? _buildFuelOrdersList()
                : _buildMechanicServicesList(),
          ),
        ],
      ),
    );
  }

  Widget _buildFuelOrdersList() {
    final orders = [
      _FuelOrder(
        id: '#12345',
        status: OrderStatus.delivered,
        fuelType: 'Diesel',
        quantity: '15L',
        price: 1200,
        pumpName: 'HP Pump',
        pumpLocation: 'Sector 5',
        date: DateTime.now().subtract(const Duration(days: 1)),
        deliveryBoy: _DeliveryBoy(
          name: 'Vikram',
          phone: '+91 98765 54321',
          vehicleNumber: 'DL 05 CD 5678',
          location: 'Delivered',
          eta: 'Delivered',
          lat: 0,
          long: 0,
        ),
      ),
      _FuelOrder(
        id: '#12344',
        status: OrderStatus.cancelled,
        fuelType: 'Petrol',
        quantity: '5L',
        price: 400,
        pumpName: 'Shell Pump',
        pumpLocation: 'Sector 8',
        date: DateTime.now().subtract(const Duration(days: 3)),
      ),
    ];

    return ListView.separated(
      itemCount: orders.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final order = orders[index];
        return Card(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      order.id,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    _buildStatusChip(order.status),
                  ],
                ),
                const SizedBox(height: 8),
                _buildOrderDetailRow(Icons.local_gas_station,
                    '${order.fuelType} (${order.quantity})'),
                _buildOrderDetailRow(Icons.currency_rupee, '₹${order.price}'),
                _buildOrderDetailRow(Icons.location_on,
                    '${order.pumpName}, ${order.pumpLocation}'),
                _buildOrderDetailRow(
                    Icons.calendar_today, _dateFormat.format(order.date)),
                if (order.status == OrderStatus.delivered &&
                    order.deliveryBoy != null) ...[
                  const Divider(height: 16),
                  const Text(
                    'Delivered by',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  _buildDeliveryBoyInfo(order.deliveryBoy!),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildMechanicServicesList() {
    final services = [
      _MechanicService(
        mechanicName: 'John Doe',
        shopName: 'ABC Mechanic',
        phone: '+91 98765 43210',
        service: 'Battery Replacement',
        price: 500,
        status: ServiceStatus.completed,
        date: DateTime.now().subtract(const Duration(days: 5)),
      ),
      _MechanicService(
        mechanicName: 'Ramesh',
        shopName: 'XYZ Auto',
        phone: '+91 87654 32109',
        service: 'Engine Check',
        price: 800,
        status: ServiceStatus.pending,
        date: DateTime.now().subtract(const Duration(days: 2)),
      ),
    ];

    return ListView.separated(
      itemCount: services.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final service = services[index];
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const CircleAvatar(
                      child: Icon(Icons.person),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          service.mechanicName,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          service.shopName,
                          style: const TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                _buildOrderDetailRow(Icons.phone, service.phone),
                _buildOrderDetailRow(Icons.build, service.service),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '₹${service.price}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: service.status == ServiceStatus.completed
                            ? Colors.green.shade100
                            : Colors.orange.shade100,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            service.status == ServiceStatus.completed
                                ? Icons.check_circle
                                : Icons.timer,
                            color: service.status == ServiceStatus.completed
                                ? Colors.green
                                : Colors.orange,
                            size: 16,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            service.status == ServiceStatus.completed
                                ? 'Completed'
                                : 'Pending',
                            style: TextStyle(
                              color: service.status == ServiceStatus.completed
                                  ? Colors.green
                                  : Colors.orange,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                _buildOrderDetailRow(
                    Icons.calendar_today, _dateFormat.format(service.date)),
              ],
            ),
          ),
        );
      },
    );
  }
}

enum OrderStatus { confirmed, onTheWay, delivered, cancelled }

enum ServiceStatus { completed, pending }

class _FuelOrder {
  final String id;
  final OrderStatus status;
  final String fuelType;
  final String quantity;
  final int price;
  final String pumpName;
  final String pumpLocation;
  final DateTime date;
  final _DeliveryBoy? deliveryBoy;

  _FuelOrder({
    required this.id,
    required this.status,
    required this.fuelType,
    required this.quantity,
    required this.price,
    required this.pumpName,
    required this.pumpLocation,
    required this.date,
    this.deliveryBoy,
  });
}

class _DeliveryBoy {
  final String name;
  final String phone;
  final String vehicleNumber;
  final String location;
  final String eta;
  final double lat;
  final double long;

  _DeliveryBoy({
    required this.name,
    required this.phone,
    required this.vehicleNumber,
    required this.location,
    required this.eta,
    required this.lat,
    required this.long,
  });
}

class _MechanicService {
  final String mechanicName;
  final String shopName;
  final String phone;
  final String service;
  final int price;
  final ServiceStatus status;
  final DateTime date;

  _MechanicService({
    required this.mechanicName,
    required this.shopName,
    required this.phone,
    required this.service,
    required this.price,
    required this.status,
    required this.date,
  });
}