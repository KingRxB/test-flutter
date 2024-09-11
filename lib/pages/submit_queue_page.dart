import 'package:flutter/material.dart';
import '../services/api_service.dart';

class SubmitQueuePage extends StatefulWidget {
  @override
  _SubmitQueuePageState createState() => _SubmitQueuePageState();
}

class _SubmitQueuePageState extends State<SubmitQueuePage> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String phone = '';
  int pax = 1;

  Future<void> submitQueue() async {
    if (_formKey.currentState!.validate()) {
      try {
        final response = await ApiService().submitQueue(name, phone, pax);
        if (response['status']) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Queue submitted successfully!')),
          );
          Navigator.pop(context);
        }
      } catch (error) {
        print('Error submitting queue: $error');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Submit Queue'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
                onChanged: (value) => name = value,
              ),
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(labelText: 'WhatsApp Number'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your WhatsApp number';
                  }
                  return null;
                },
                onChanged: (value) => phone = value,
              ),
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(labelText: 'Customer Pax'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || int.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
                onChanged: (value) => pax = int.parse(value),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: submitQueue,
                child: Text('Submit Queue'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
