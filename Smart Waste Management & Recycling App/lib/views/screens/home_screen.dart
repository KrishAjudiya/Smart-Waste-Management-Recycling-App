import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/auth_viewmodel.dart';
import 'login_screen.dart';
import 'waste_logging_screen.dart';
import 'pickup_scheduling_screen.dart';
import 'maps_screen.dart';
import 'reward_screen.dart';
import 'admin_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authViewModel = context.watch<AuthViewModel>();
    final user = authViewModel.currentUserModel;

    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
        backgroundColor: Colors.green.shade700,
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await authViewModel.logout();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => LoginScreen()),
              );
            },
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Welcome, ${user?.name ?? 'User'}!",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              "Reward Points: ${user?.totalRewardPoints ?? 0}",
              style: TextStyle(fontSize: 18, color: Colors.green.shade800),
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                 Navigator.push(
                   context,
                   MaterialPageRoute(builder: (_) => WasteLoggingScreen()),
                 );
              },
              child: Text("Log Waste (+10 Pts)"),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                 Navigator.push(
                   context,
                   MaterialPageRoute(builder: (_) => PickupSchedulingScreen()),
                 );
              },
              child: Text("Schedule Pickup"),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
              ),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => MapsScreen())),
                    icon: Icon(Icons.map, color: Colors.green.shade700),
                    label: Text("Recycling Centers"),
                  )
                ),
                SizedBox(width: 16),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => RewardScreen())),
                    icon: Icon(Icons.stars, color: Colors.amber),
                    label: Text("Rewards"),
                  )
                )
              ]
            ),
            SizedBox(height: 16),
            if (user?.role == 'admin')
               OutlinedButton.icon(
                 onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => AdminScreen())),
                 icon: Icon(Icons.admin_panel_settings, color: Colors.teal),
                 label: Text("Admin Dashboard"),
               ),
          ],
        ),
      ),
    );
  }
}
