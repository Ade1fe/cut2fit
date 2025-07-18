import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cut2fit/utils/database_helper.dart';
import 'package:cut2fit/components/measurement_input_card.dart';
import 'package:cut2fit/main.dart'; // For ContextExtension

class MeasurementInputPage extends StatefulWidget {
  final String clientId;
  final String clientName;

  const MeasurementInputPage({
    super.key,
    required this.clientId,
    required this.clientName,
  });

  @override
  State<MeasurementInputPage> createState() => _MeasurementInputPageState();
}

class _MeasurementInputPageState extends State<MeasurementInputPage> {
  // Map to store all measurement controllers and their unit states
  final Map<String, TextEditingController> _controllers = {};
  final Map<String, bool> _unitInches =
      {}; // true for inches/lbs, false for cm/kg
  bool _isSaving = false;

  // Define all possible measurements
  final List<Map<String, dynamic>> _measurementsConfig = [
    {
      'section': 'General Body Measurements',
      'type': 'neck_circumference',
      'title': 'Neck Circumference',
      'description': 'Around the base of the neck',
      'icon': Icons.accessibility_new,
      'unitLabels': ['in', 'cm'],
    },
    {
      'section': 'General Body Measurements',
      'type': 'shoulder_width',
      'title': 'Shoulder Width',
      'description': 'From one shoulder tip to the other',
      'icon': Icons.accessibility_new,
      'unitLabels': ['in', 'cm'],
    },
    {
      'section': 'General Body Measurements',
      'type': 'chest_bust_circumference',
      'title': 'Chest/Bust Circumference',
      'description': 'Around the fullest part of the chest',
      'icon': Icons.accessibility_new,
      'unitLabels': ['in', 'cm'],
    },
    {
      'section': 'General Body Measurements',
      'type': 'waist_circumference',
      'title': 'Waist Circumference',
      'description': 'Around the natural waistline (above belly button)',
      'icon': Icons.accessibility_new,
      'unitLabels': ['in', 'cm'],
    },
    {
      'section': 'General Body Measurements',
      'type': 'hip_circumference',
      'title': 'Hip Circumference',
      'description': 'Around the fullest part of the hips/buttocks',
      'icon': Icons.accessibility_new,
      'unitLabels': ['in', 'cm'],
    },
    {
      'section': 'General Body Measurements',
      'type': 'armhole_circumference',
      'title': 'Armhole Circumference',
      'description': 'Around the shoulder socket (where sleeve is joined)',
      'icon': Icons.accessibility_new,
      'unitLabels': ['in', 'cm'],
    },
    {
      'section': 'General Body Measurements',
      'type': 'bicep_circumference',
      'title': 'Bicep Circumference',
      'description': 'Around the widest part of upper arm',
      'icon': Icons.accessibility_new,
      'unitLabels': ['in', 'cm'],
    },
    {
      'section': 'General Body Measurements',
      'type': 'forearm_circumference',
      'title': 'Forearm Circumference',
      'description': 'Around the fullest part of the forearm',
      'icon': Icons.accessibility_new,
      'unitLabels': ['in', 'cm'],
    },
    {
      'section': 'General Body Measurements',
      'type': 'wrist_circumference',
      'title': 'Wrist Circumference',
      'description': 'Around the wrist',
      'icon': Icons.accessibility_new,
      'unitLabels': ['in', 'cm'],
    },
    {
      'section': 'General Body Measurements',
      'type': 'thigh_circumference',
      'title': 'Thigh Circumference',
      'description': 'Around the thickest part of thigh',
      'icon': Icons.accessibility_new,
      'unitLabels': ['in', 'cm'],
    },
    {
      'section': 'General Body Measurements',
      'type': 'knee_circumference',
      'title': 'Knee Circumference',
      'description': 'Around the knee cap',
      'icon': Icons.accessibility_new,
      'unitLabels': ['in', 'cm'],
    },
    {
      'section': 'General Body Measurements',
      'type': 'calf_circumference',
      'title': 'Calf Circumference',
      'description': 'Around the fullest part of the calf',
      'icon': Icons.accessibility_new,
      'unitLabels': ['in', 'cm'],
    },
    {
      'section': 'General Body Measurements',
      'type': 'ankle_circumference',
      'title': 'Ankle Circumference',
      'description': 'Around the ankle',
      'icon': Icons.accessibility_new,
      'unitLabels': ['in', 'cm'],
    },
    {
      'section': 'General Body Measurements',
      'type': 'inseam',
      'title': 'Inseam',
      'description': 'From crotch to bottom of pants/floor (inside leg)',
      'icon': Icons.accessibility_new,
      'unitLabels': ['in', 'cm'],
    },
    {
      'section': 'General Body Measurements',
      'type': 'outseam',
      'title': 'Outseam',
      'description': 'From waist to bottom of pants/floor',
      'icon': Icons.accessibility_new,
      'unitLabels': ['in', 'cm'],
    },
    {
      'section': 'General Body Measurements',
      'type': 'trouser_waist',
      'title': 'Trouser Waist',
      'description': 'Waistline for trousers (may differ from natural waist)',
      'icon': Icons.accessibility_new,
      'unitLabels': ['in', 'cm'],
    },
    {
      'section': 'General Body Measurements',
      'type': 'trouser_length',
      'title': 'Trouser Length',
      'description': 'From waist down to ankle or floor',
      'icon': Icons.accessibility_new,
      'unitLabels': ['in', 'cm'],
    },
    {
      'section': 'General Body Measurements',
      'type': 'shirt_top_length',
      'title': 'Shirt/Top Length',
      'description': 'From shoulder (near neck) to desired shirt/top bottom',
      'icon': Icons.accessibility_new,
      'unitLabels': ['in', 'cm'],
    },
    {
      'section': 'General Body Measurements',
      'type': 'sleeve_length_long',
      'title': 'Sleeve Length (Long)',
      'description': 'From shoulder to wrist',
      'icon': Icons.accessibility_new,
      'unitLabels': ['in', 'cm'],
    },
    {
      'section': 'General Body Measurements',
      'type': 'short_sleeve_length',
      'title': 'Short Sleeve Length',
      'description': 'From shoulder point to desired short sleeve length',
      'icon': Icons.accessibility_new,
      'unitLabels': ['in', 'cm'],
    },

    {
      'section': 'Female Specific Measurements',
      'type': 'under_bust_circumference',
      'title': 'Under Bust Circumference',
      'description': 'Just below the bust',
      'icon': Icons.accessibility_new,
      'unitLabels': ['in', 'cm'],
    },
    {
      'section': 'Female Specific Measurements',
      'type': 'shoulder_to_bust',
      'title': 'Shoulder to Bust',
      'description': 'From shoulder to nipple point',
      'icon': Icons.accessibility_new,
      'unitLabels': ['in', 'cm'],
    },
    {
      'section': 'Female Specific Measurements',
      'type': 'shoulder_to_waist',
      'title': 'Shoulder to Waist',
      'description': 'From shoulder tip to natural waist',
      'icon': Icons.accessibility_new,
      'unitLabels': ['in', 'cm'],
    },
    {
      'section': 'Female Specific Measurements',
      'type': 'shoulder_to_hip',
      'title': 'Shoulder to Hip',
      'description': 'From shoulder to hip line',
      'icon': Icons.accessibility_new,
      'unitLabels': ['in', 'cm'],
    },
    {
      'section': 'Female Specific Measurements',
      'type': 'waist_to_hip',
      'title': 'Waist to Hip',
      'description': 'From natural waist to hip (vertically)',
      'icon': Icons.accessibility_new,
      'unitLabels': ['in', 'cm'],
    },
    {
      'section': 'Female Specific Measurements',
      'type': 'back_width',
      'title': 'Back Width',
      'description': 'Across the shoulder blades',
      'icon': Icons.accessibility_new,
      'unitLabels': ['in', 'cm'],
    },
    {
      'section': 'Female Specific Measurements',
      'type': 'nape_to_waist',
      'title': 'Nape to Waist',
      'description': 'From neck base (nape) to waist (center back)',
      'icon': Icons.accessibility_new,
      'unitLabels': ['in', 'cm'],
    },
  ];

  @override
  void initState() {
    super.initState();
    // Initialize controllers and unit states
    for (var config in _measurementsConfig) {
      final type = config['type'] as String;
      _controllers[type] = TextEditingController();
      _unitInches[type] = true; // Default to inches/lbs
    }
    _loadMeasurements();
  }

  Future<void> _loadMeasurements() async {
    try {
      final measurements = await DatabaseHelper.instance
          .getMeasurementsForClient(widget.clientId);

      for (var measurement in measurements) {
        final type = measurement['type'] as String;
        final value = measurement['value'] as double;
        final unit = measurement['unit'] as String;

        if (_controllers.containsKey(type)) {
          _controllers[type]?.text = value.toString();
          _unitInches[type] = (unit == 'in' || unit == 'lbs' || unit == '%');
        }
      }
    } catch (e) {
      if (mounted) {
        context.showSnackBar('Error loading measurements: $e', isError: true);
      }
    }
  }

  Future<void> _saveMeasurements() async {
    setState(() {
      _isSaving = true;
    });
    try {
      List<Map<String, dynamic>> measurementsToSave = [];
      for (var config in _measurementsConfig) {
        final type = config['type'] as String;
        final controller = _controllers[type];
        final isInch = _unitInches[type]!;
        final unitLabels = config['unitLabels'] as List<String>;
        final unit = isInch ? unitLabels[0] : unitLabels[1];

        if (controller != null && controller.text.isNotEmpty) {
          final value = double.tryParse(controller.text);
          if (value != null) {
            measurementsToSave.add({
              'client_id': widget.clientId,
              'type': type,
              'value': value,
              'unit': unit,
            });
          }
        }
      }

      // Delete existing measurements for this client before inserting new ones
      await DatabaseHelper.instance.deleteMeasurementsForClient(
        widget.clientId,
      );
      if (measurementsToSave.isNotEmpty) {
        for (var measurement in measurementsToSave) {
          await DatabaseHelper.instance.insertMeasurement(measurement);
        }
      }

      if (mounted) context.showSnackBar('Measurements saved successfully!');
    } catch (e) {
      if (mounted) {
        context.showSnackBar('Error saving measurements: $e', isError: true);
      }
    } finally {
      setState(() {
        _isSaving = false;
      });
    }
  }

  @override
  void dispose() {
    _controllers.forEach((key, controller) => controller.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Group measurements by section
    final Map<String, List<Map<String, dynamic>>> groupedMeasurements = {};
    for (var config in _measurementsConfig) {
      final section = config['section'] as String;
      if (!groupedMeasurements.containsKey(section)) {
        groupedMeasurements[section] = [];
      }
      groupedMeasurements[section]!.add(config);
    }

    return Scaffold(
      appBar: AppBar(title: Text('${widget.clientName}\'s Measurements')),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: groupedMeasurements.entries.map((entry) {
                final sectionTitle = entry.key;
                final measurements = entry.value;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Text(
                        sectionTitle.toUpperCase(),
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[600],
                          letterSpacing: 0.8,
                        ),
                      ),
                    ),
                    ...measurements.map((config) {
                      final type = config['type'] as String;
                      final isReadOnly = config['readOnly'] as bool? ?? false;
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: MeasurementInputCard(
                          title: config['title'] as String,
                          icon: config['icon'] as IconData,
                          controller: _controllers[type]!,
                          unitInches: _unitInches[type]!,
                          unitLabels: config['unitLabels'] as List<String>,
                          readOnly: isReadOnly,
                          onUnitToggle: (isInch) {
                            setState(() {
                              _unitInches[type] = isInch;
                            });
                          },
                        ),
                      );
                    }),
                  ],
                );
              }).toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isSaving ? null : _saveMeasurements,
                child: _isSaving
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Save Measurements'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
