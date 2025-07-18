import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For input formatters
import 'package:cut2fit/main.dart'; // For ContextExtension
import 'package:cut2fit/utils/garment_config.dart'; // Import garment configurations

class GarmentMeasurementPage extends StatefulWidget {
  final String clientId;
  final String clientName;
  final String garmentType; // New parameter to specify garment type

  const GarmentMeasurementPage({
    super.key,
    required this.clientId,
    required this.clientName,
    required this.garmentType, // Required garment type
  });

  @override
  State<GarmentMeasurementPage> createState() => _GarmentMeasurementPageState();
}

class _GarmentMeasurementPageState extends State<GarmentMeasurementPage> {
  late GarmentMeasurement _currentGarment;
  final Map<String, TextEditingController> _controllers = {};

  @override
  void initState() {
    super.initState();
    _currentGarment = garmentConfigs[widget.garmentType]!;
    // Initialize controllers based on the current garment's fields
    for (var field in _currentGarment.fields) {
      _controllers[field['key']!] = TextEditingController();
    }
    // You might want to load existing measurements here if they were saved previously
    // _loadGarmentMeasurements();
  }

  @override
  void dispose() {
    _controllers.forEach((key, controller) => controller.dispose());
    super.dispose();
  }

  void _saveGarmentMeasurements() {
    // This is where you would save the garment measurements to the database.
    // For now, we'll just print them.
    print(
      'Saving Garment Measurements for ${widget.clientName} (${_currentGarment.title}):',
    );
    _controllers.forEach((key, controller) {
      print('$key: ${controller.text}');
    });

    if (mounted) {
      context.showSnackBar('Garment measurements saved (to console)!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.clientName}\'s ${_currentGarment.title}'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Garment Diagram Section
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Garment Diagram
                  Expanded(
                    flex: 2,
                    child: Image.asset(
                      _currentGarment.imagePath, // Dynamic image path
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Measurement Inputs
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: _currentGarment.fields.map((field) {
                        return _buildMeasurementRow(
                          field['label']!,
                          _controllers[field['key']!]!,
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _saveGarmentMeasurements,
                child: const Text('Save Garment Measurements'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMeasurementRow(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: TextFormField(
                  controller: controller,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                      RegExp(r'^\d+\.?\d{0,2}'),
                    ),
                  ],
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                    isDense: true,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            'in', // Default unit for garment measurements
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}
