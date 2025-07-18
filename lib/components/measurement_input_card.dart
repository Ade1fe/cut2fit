import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MeasurementInputCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final TextEditingController controller;
  final bool unitInches; // true for inches/lbs, false for cm/kg
  final ValueChanged<bool> onUnitToggle;
  final List<String> unitLabels; // e.g., ['in', 'cm'] or ['lbs', 'kg']
  final bool readOnly;

  const MeasurementInputCard({
    super.key,
    required this.title,
    required this.icon,
    required this.controller,
    required this.unitInches,
    required this.onUnitToggle,
    this.unitLabels = const ['in', 'cm'],
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.05),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.orange[50], // Changed to orange
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 28, color: Colors.orange[700]), // Changed to orange
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                if (!readOnly)
                  Text(
                    'Enter value',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[500],
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          if (!readOnly)
            Container(
              width: 80,
              height: 48,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: TextFormField(
                  controller: controller,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))], // Allow decimals
                  style: const TextStyle(
                    fontSize: 18,
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
            )
          else
            Container(
              width: 80,
              height: 48,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  controller.text.isEmpty ? 'N/A' : controller.text,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: controller.text.isEmpty ? Colors.grey[500] : Colors.black87,
                  ),
                ),
              ),
            ),
          const SizedBox(width: 8),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => onUnitToggle(true),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    decoration: BoxDecoration(
                      color: unitInches ? Colors.orange[100] : Colors.transparent, // Changed to orange
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      unitLabels[0],
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: unitInches ? Colors.orange[700] : Colors.grey[600], // Changed to orange
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => onUnitToggle(false),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    decoration: BoxDecoration(
                      color: !unitInches ? Colors.orange[100] : Colors.transparent, // Changed to orange
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      unitLabels[1],
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: !unitInches ? Colors.orange[700] : Colors.grey[600], // Changed to orange
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
