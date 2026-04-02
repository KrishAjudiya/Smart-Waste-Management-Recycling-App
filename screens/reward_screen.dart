import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/auth_viewmodel.dart';

class RewardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authVM = context.watch<AuthViewModel>();
    final user = authVM.currentUserModel;
    final int points = user?.totalRewardPoints ?? 0;

    return Scaffold(
      appBar: AppBar(
        title: Text("Rewards Dashboard"),
        backgroundColor: Colors.green.shade700,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: Colors.green.shade200, width: 2),
              ),
              child: Column(
                children: [
                  Icon(Icons.stars, color: Colors.amber, size: 64),
                  SizedBox(height: 16),
                  Text("Total Green Points", style: TextStyle(fontSize: 18, color: Colors.green.shade900)),
                  Text("$points", style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.green.shade800)),
                ],
              ),
            ),
            SizedBox(height: 32),
            Expanded(
              child: ListView(
                children: [
                   _buildRewardItem("Free Recycled Tote Bag", 100, points),
                   _buildRewardItem("5% Discount on GreenGroceries", 250, points),
                   _buildRewardItem("City Park Tree Planting in your name", 500, points),
                   _buildRewardItem("1 Month Free Waste Pickup", 1000, points),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRewardItem(String title, int requiredPoints, int currentPoints) {
    bool canRedeem = currentPoints >= requiredPoints;
    return Card(
      margin: EdgeInsets.only(bottom: 16),
      child: ListTile(
        contentPadding: EdgeInsets.all(16),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text("Requires $requiredPoints points"),
        trailing: ElevatedButton(
          onPressed: canRedeem ? () {} : null,
          child: Text("Redeem"),
          style: ElevatedButton.styleFrom(
            backgroundColor: canRedeem ? Colors.green.shade600 : Colors.grey,
          ),
        ),
      ),
    );
  }
}
