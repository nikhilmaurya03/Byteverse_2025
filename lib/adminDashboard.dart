import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucide_icons/lucide_icons.dart';

class AdminGasStationPage extends StatefulWidget {
  const AdminGasStationPage({super.key});

  @override
  State<AdminGasStationPage> createState() => _AdminGasStationPageState();
}

class _AdminGasStationPageState extends State<AdminGasStationPage> with TickerProviderStateMixin  {
  final List<Map<String, dynamic>> stationsDetails = [
    {
      'name': "City Center Gas",
      'location': "123 Market St\nSan Francisco, CA",
      'inventory': "Petrol: 5000 gal\nDiesel: 3000 gal\nGasoline: 4000 gal",
      'manager': "John Smith\njohn@citycentergas.com",
    },
    {
      'name': "Riverside Fuel",
      'location': "456 Riverside Dr\nLos Angeles, CA",
      'inventory': "Petrol: 4500 gal\nDiesel: 5000 gal\nGasoline: 3200 gal",
      'manager': "Sarah Johnson\nsarah@riversidefuel.com",
    },
    {
      'name': "Golden Gate Petrol",
      'location': "789 Golden Gate Ave\nSan Francisco, CA",
      'inventory': "Petrol: 6000 gal\nDiesel: 4500 gal\nGasoline: 5200 gal",
      'manager': "Michael Wilson\nmichael@ggpetrol.com",
    }
  ];

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController managerEmailController = TextEditingController();
  final TextEditingController managerNameController = TextEditingController();
  final TextEditingController stationNameController = TextEditingController();
  final TextEditingController stationLocationController =
      TextEditingController();
  final TextEditingController petrolInventoryController =
      TextEditingController();
  final TextEditingController dieselInventoryController =
      TextEditingController();
  final TextEditingController gasolineInventoryController =
      TextEditingController();

  TabController? _tabController;
  int selectedTab = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     _tabController = TabController(length: 3, vsync: this);
    _tabController?.addListener(() {
        selectedTab = _tabController!.index;
      if(mounted){
        setState(() {
        });
      }
    });
  }    
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      appBar: AppBar(
        title: const Text(
          "Admin Dashboard",
          style: TextStyle(
              color: Colors.white, fontSize: 24, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        elevation: 2,
        backgroundColor: Colors.blue.shade600,
        shadowColor: Colors.grey.shade300,
      ),
      bottomNavigationBar: BottomAppBar(
          color: Colors.white,
          child: TabBar(
              controller: _tabController,
              indicatorColor: Colors.blue.shade600,
              indicatorSize: TabBarIndicatorSize.tab,
              dividerColor: Colors.transparent,
              overlayColor: MaterialStateProperty.all(Colors.transparent),
              onTap: (value) => setState(() {
                    selectedTab = value;
                  }),
              unselectedLabelStyle: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 12.r,
                fontWeight: FontWeight.w700,
              ),
              labelStyle: TextStyle(
                color: Colors.blue.shade600,
                fontSize: 12.r,
                fontWeight: FontWeight.w700,
              ),
              tabs: [
                Tab(text: 'Stations  Manage', icon: Icon(selectedTab == 0 ? LucideIcons.fuel :LucideIcons.fuel),),
                Tab(text: 'Users', icon: Icon(selectedTab == 1 ? LucideIcons.user : LucideIcons.user)),
                Tab(text: 'Orders', icon: Icon(selectedTab == 2 ? LucideIcons.fileText :LucideIcons.fileText)),
               
              ]),
        ),
      body: TabBarView(
        controller: _tabController,
        children: [
        //....................................... Tab 1st ...............................//
        Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Tabs
            // const Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceAround,
            //   children: [
                
            //     _DashboardTab(
            //         icon: LucideIcons.fuel,
            //         label: "Gas Stations",
            //         selected: true),
            //     _DashboardTab(icon: LucideIcons.users, label: "Users"),
            //     _DashboardTab(icon: LucideIcons.fileText, label: "Orders"),
            //   ],
            // ),
            const SizedBox(height: 20),

            const Text(
              "Gas Station Management",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 12),

            // Search + Add Button
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Search gas stations by name or location",
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton.icon(
                  onPressed: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return SingleChildScrollView(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20.w, vertical: 20.h),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Gas Station Name",
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 8.h),
                                  TextFormField(
                                    obscureText: false,
                                    controller: stationNameController,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter gas station name';
                                      } else if (value.length < 5) {
                                        return 'Please enter a valid station address';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      hintText: "Enter gas station name",
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 14.w, vertical: 14.h),
                                      filled: true,
                                      fillColor: Colors.white,
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(12.r),
                                        borderSide: BorderSide(
                                            color: Colors.grey.shade300),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(12.r),
                                        borderSide: BorderSide(
                                            color: Colors.grey.shade300),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 16.h),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Location",
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 8.h),
                                  TextFormField(
                                    obscureText: false,
                                    controller: stationLocationController,
                                    //  controller: emailController,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter station location';
                                      } else if (value.length < 5) {
                                        return 'Please enter a valid station address';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      hintText: "Enter station location",
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 14.w, vertical: 14.h),
                                      filled: true,
                                      fillColor: Colors.white,
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(12.r),
                                        borderSide: BorderSide(
                                            color: Colors.grey.shade300),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(12.r),
                                        borderSide: BorderSide(
                                            color: Colors.grey.shade300),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 16.r,
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Petrol Inventory",
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 8.h),
                                  TextFormField(
                                    obscureText: false,
                                    controller: petrolInventoryController,
                                    //  controller: emailController,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter petrol inventory';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      hintText: "Enter petrol inventory",
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 14.w, vertical: 14.h),
                                      filled: true,
                                      fillColor: Colors.white,
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(12.r),
                                        borderSide: BorderSide(
                                            color: Colors.grey.shade300),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(12.r),
                                        borderSide: BorderSide(
                                            color: Colors.grey.shade300),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 16.r,
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Diesel Inventory",
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 8.h),
                                  TextFormField(
                                    obscureText: false,
                                    controller: dieselInventoryController,
                                    //  controller: emailController,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your diesel inventory';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      hintText: "Enter diesel inventory",
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 14.w, vertical: 14.h),
                                      filled: true,
                                      fillColor: Colors.white,
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(12.r),
                                        borderSide: BorderSide(
                                            color: Colors.grey.shade300),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(12.r),
                                        borderSide: BorderSide(
                                            color: Colors.grey.shade300),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 16.r,
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Gasoline Inventory",
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 8.h),
                                  TextFormField(
                                    obscureText: false,
                                    controller: gasolineInventoryController,
                                    //  controller: emailController,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your gasoline inventory';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      hintText: "Enter your gasoline inventory",
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 14.w, vertical: 14.h),
                                      filled: true,
                                      fillColor: Colors.white,
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(12.r),
                                        borderSide: BorderSide(
                                            color: Colors.grey.shade300),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(12.r),
                                        borderSide: BorderSide(
                                            color: Colors.grey.shade300),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 16.r,
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Manager Name",
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 8.h),
                                  TextFormField(
                                    obscureText: false,
                                    controller: managerNameController,
                                    //  controller: emailController,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter manager name';
                                      } else if (value.length < 3) {
                                        return 'Please enter a valid name';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      hintText: "Enter manager name",
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 14.w, vertical: 14.h),
                                      filled: true,
                                      fillColor: Colors.white,
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(12.r),
                                        borderSide: BorderSide(
                                            color: Colors.grey.shade300),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(12.r),
                                        borderSide: BorderSide(
                                            color: Colors.grey.shade300),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 16.r,
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Email",
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 8.h),
                                  TextFormField(
                                    obscureText: false,
                                    controller: managerEmailController,
                                    //  controller: emailController,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your email';
                                      } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                                          .hasMatch(value)) {
                                        return 'Please enter a valid email address';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      hintText: "Enter Manager Email",
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 14.w, vertical: 14.h),
                                      filled: true,
                                      fillColor: Colors.white,
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(12.r),
                                        borderSide: BorderSide(
                                            color: Colors.grey.shade300),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(12.r),
                                        borderSide: BorderSide(
                                            color: Colors.grey.shade300),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 16.r,
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        // Handle create account
                                        stationsDetails.add({
                                          "name": stationNameController.text,
                                          "location":
                                              stationLocationController.text,
                                          "inventory":
                                              "Petrol: ${petrolInventoryController.text} gal\nDiesel: ${dieselInventoryController.text} gal\nGasoline: ${gasolineInventoryController.text} gal",
                                          "manager":
                                              managerNameController.text +
                                                  "\n" +
                                                  managerEmailController.text,
                                          // "Manager Email": managerEmailController.text,
                                          //"Petrol: 5000 gal\nDiesel: 3000 gal\nGasoline: 4000 gal"
                                        });
                                        stationNameController.clear();
                                        stationLocationController.clear();
                                        petrolInventoryController.clear();
                                        dieselInventoryController.clear();
                                        gasolineInventoryController.clear();
                                        managerNameController.clear();
                                        managerEmailController.clear();

                                        setState(() {});

                                        Navigator.pop(context);
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF347DFF),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12.r),
                                      ),
                                    ),
                                    child: Text(
                                      "Submit",
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        });
                  },
                  icon: const Icon(Icons.add),
                  label: const Text("Add Gas Station"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade600,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Table Header
            const _TableHeader(),

            const SizedBox(height: 10),

            // Station List
            Expanded(
              child: ListView.builder(
                itemCount: stationsDetails.length,
                itemBuilder: (context, index) {
                  final station = stationsDetails[index];
                  return Card(
                    elevation: 2,
                    color: Colors.white,
                    shadowColor: Colors.grey.shade300,
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: const BorderSide(color: Colors.grey, width: 1),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                              flex: 2,
                              child: Text(station['name'],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600))),
                          Expanded(flex: 2, child: Text(station['location'])),
                          Expanded(flex: 3, child: Text(station['inventory'])),
                          Expanded(flex: 2, child: Text(station['manager'])),
                          Column(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit,
                                    color: Colors.deepPurple),
                                onPressed: () {
                                  
                                },
                              ),
                              IconButton(
                                icon:
                                    const Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  // Handle delete action
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title:
                                            const Text("Delete Confirmation"),
                                        content: const Text(
                                            "Are you sure you want to delete this gas station?"),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text("Cancel"),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              // Handle deletion logic here
                                              setState(() {
                                                stationsDetails.removeAt(index);
                                              });
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text("Delete"),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),

  //....................................... Tab 2nd ...............................//
        const Center(
          child: Text(
            "User Tab",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),

        //....................................... Tab 3rd ...............................//
        const Center(
          child: Text(
            "Orders Tab",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),

         
      ])
    );
  }
}

// ---------------------- Custom Widgets -------------------------

class _DashboardTab extends StatefulWidget {
  final IconData icon;
  final String label;
  final bool selected;

  const _DashboardTab({
    required this.icon,
    required this.label,
    this.selected = false,
  });

  @override
  State<_DashboardTab> createState() => _DashboardTabState();
}

class _DashboardTabState extends State<_DashboardTab> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(widget.icon, color: widget.selected ? Colors.blue : Colors.grey),
        Text(
          widget.label,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: widget.selected ? Colors.blue : Colors.grey,
          ),
        ),
        if (widget.selected)
          Container(
            margin: const EdgeInsets.only(top: 5),
            height: 3,
            width: 60,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
      ],
    );
  }
}

class _TableHeader extends StatelessWidget {
  const _TableHeader();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Expanded(flex: 2, child: Text("Name", style: _headerStyle)),
        Expanded(flex: 2, child: Text("Location", style: _headerStyle)),
        Expanded(flex: 3, child: Text("Inventory", style: _headerStyle)),
        Expanded(flex: 2, child: Text("Manager", style: _headerStyle)),
        SizedBox(width: 50), // For actions
      ],
    );
  }
}

class _StationRow extends StatelessWidget {
  final String name;
  final String location;
  final String inventory;
  final String manager;

  const _StationRow({
    required this.name,
    required this.location,
    required this.inventory,
    required this.manager,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      color: Colors.white,
      shadowColor: Colors.grey.shade300,
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(color: Colors.grey, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                flex: 2,
                child: Text(name,
                    style: const TextStyle(fontWeight: FontWeight.w600))),
            Expanded(flex: 2, child: Text(location)),
            Expanded(flex: 3, child: Text(inventory)),
            Expanded(flex: 2, child: Text(manager)),
            Column(
              children: [
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.deepPurple),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    // Handle delete action
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text("Delete Confirmation"),
                          content: const Text(
                              "Are you sure you want to delete this gas station?"),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text("Cancel"),
                            ),
                            TextButton(
                              onPressed: () {
                                // Handle deletion logic here

                                Navigator.of(context).pop();
                              },
                              child: const Text("Delete"),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

const _headerStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 14);
