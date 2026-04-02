import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/pickup_viewmodel.dart';
import 'package:intl/intl.dart';

class PickupSchedulingScreen extends StatefulWidget {
  @override
  _PickupSchedulingScreenState createState() => _PickupSchedulingScreenState();
}

class _PickupSchedulingScreenState extends State<PickupSchedulingScreen> {
  final TextEditingController _addressController = TextEditingController();
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  void _pickDate() async {
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 30)),
    );
    if (date != null) {
      setState(() => _selectedDate = date);
    }
  }

  void _pickTime() async {
    TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: 9, minute: 0),
    );
    if (time != null) {
      setState(() => _selectedTime = time);
    }
  }

  void _submit() async {
    if (_addressController.text.isEmpty || _selectedDate == null || _selectedTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Address, Date, and Time are required.")));
      return;
    }

    DateTime finalDateTime = DateTime(
      _selectedDate!.year, _selectedDate!.month, _selectedDate!.day,
      _selectedTime!.hour, _selectedTime!.minute,
    );

    final pickupVM = context.read<PickupViewModel>();
    bool success = await pickupVM.schedulePickup(_addressController.text, finalDateTime);

    if (success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Pickup Scheduled Successfully!")));
      Navigator.pop(context);
    } else if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(pickupVM.errorMessage ?? "An error occurred")));
    }
  }

  @override
  Widget build(BuildContext context) {
    final pickupVM = context.watch<PickupViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: Text("Schedule Pickup"),
        backgroundColor: Colors.green.shade700,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text("Enter Pickup Location", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            TextField(
              controller: _addressController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.location_on, color: Colors.green.shade700),
                hintText: "Full Address",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
              maxLines: 2,
            ),
            SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: _pickDate,
                    icon: Icon(Icons.calendar_today, color: Colors.green.shade700),
                    label: Text(_selectedDate == null ? "Select Date" : DateFormat('MMM dd, yyyy').format(_selectedDate!)),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: _pickTime,
                    icon: Icon(Icons.access_time, color: Colors.green.shade700),
                    label: Text(_selectedTime == null ? "Select Time" : _selectedTime!.format(context)),
                  ),
                ),
              ],
            ),
            Spacer(),
            ElevatedButton(
              onPressed: pickupVM.isLoading ? null : _submit,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16),
                backgroundColor: Colors.green.shade700,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: pickupVM.isLoading
                  ? CircularProgressIndicator(color: Colors.white)
                  : Text("Confirm Pickup Schedule", style: TextStyle(fontSize: 16, color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
