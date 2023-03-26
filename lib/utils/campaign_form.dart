import 'package:flutter/material.dart';

class CampaignForm extends StatefulWidget {
  const CampaignForm({super.key});

  @override
  _CampaignFormState createState() => _CampaignFormState();
}

class _CampaignFormState extends State<CampaignForm> {
  final _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Enter your name',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _textController,
              decoration: const InputDecoration(
                hintText: 'Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(_textController.text);
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
