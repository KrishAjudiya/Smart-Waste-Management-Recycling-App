import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/waste_viewmodel.dart';

class WasteLoggingScreen extends StatefulWidget {
  @override
  _WasteLoggingScreenState createState() => _WasteLoggingScreenState();
}

class _WasteLoggingScreenState extends State<WasteLoggingScreen> {
  final TextEditingController _descController = TextEditingController();
  String _selectedCategory = 'Plastic';
  final List<String> _categories = ['Organic', 'Plastic', 'E-waste', 'Paper', 'Other'];

  void _submitLog() async {
    if (_descController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Description is required")));
      return;
    }

    final wasteVM = context.read<WasteViewModel>();
    bool success = await wasteVM.logWaste(_selectedCategory, _descController.text);
    
    if (success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Waste logged successfully! +10 Points")));
      Navigator.pop(context); // Return to home
    } else if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(wasteVM.errorMessage ?? "An error occurred")));
    }
  }

  @override
  Widget build(BuildContext context) {
    final wasteVM = context.watch<WasteViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: Text("Log Waste"),
        backgroundColor: Colors.green.shade700,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "What type of waste are you disposing?",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _selectedCategory,
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
              items: _categories.map((cat) {
                return DropdownMenuItem(value: cat, child: Text(cat));
              }).toList(),
              onChanged: (val) {
                if (val != null) setState(() => _selectedCategory = val);
              },
            ),
            SizedBox(height: 24),
            TextField(
              controller: _descController,
              decoration: InputDecoration(
                labelText: "Description (e.g., 3 plastic bottles)",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
              maxLines: 3,
            ),
            SizedBox(height: 16),
            // Placeholder for Image Picker
            Container(
              height: 120,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: TextButton.icon(
                  onPressed: () {}, 
                  icon: Icon(Icons.camera_alt, color: Colors.green.shade700),
                  label: Text("Add Photo (Optional)", style: TextStyle(color: Colors.green.shade700)),
                ),
              ),
            ),
            Spacer(),
            ElevatedButton(
              onPressed: wasteVM.isLoading ? null : _submitLog,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16),
                backgroundColor: Colors.green.shade700,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: wasteVM.isLoading
                  ? CircularProgressIndicator(color: Colors.white)
                  : Text("Log Waste and Earn Points", style: TextStyle(fontSize: 16, color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
