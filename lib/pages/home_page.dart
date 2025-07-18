import 'package:flutter/material.dart';
import 'package:cut2fit/pages/client_list_page.dart';
import 'package:cut2fit/pages/garment_measurement_page.dart'; // Import the new page

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Welcome to Measurement Pro')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero Section
            Container(
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.orange[50],
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.orange.withOpacity(0.1),
                    spreadRadius: 3,
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Icon(
                    Icons
                        .fitness_center, // A relevant icon for fitness/measurements
                    size: 80,
                    color: Colors.orange[700],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Your Ultimate Client Measurement Tool',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange[900],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Effortlessly track and manage all your clients\' body measurements with precision and ease.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const ClientListPage(),
                          ),
                        );
                      },
                      icon: const Icon(Icons.people),
                      label: const Text('Manage Clients'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16), // Added space
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // For demonstration, we'll pass dummy client info.
                        // In a real app, you'd select a client first.
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const GarmentMeasurementPage(
                              clientId: 'dummy_client_id', // Placeholder
                              clientName: 'Sample Client', // Placeholder
                              garmentType: 'dress', // Pass the garment type
                            ),
                          ),
                        );
                      },
                      icon: const Icon(Icons.checkroom), // Icon for clothing
                      label: const Text('Add Dress Measurements'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        backgroundColor:
                            Colors.orange[500], // Slightly different shade
                      ),
                    ),
                  ),
                  const SizedBox(height: 16), // Added space
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const GarmentMeasurementPage(
                              clientId: 'dummy_client_id', // Placeholder
                              clientName: 'Sample Client', // Placeholder
                              garmentType: 'skirt', // Pass the garment type
                            ),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.format_align_justify,
                      ), // Icon for skirt
                      label: const Text('Add Skirt Measurements'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        backgroundColor:
                            Colors.orange[500], // Slightly different shade
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const GarmentMeasurementPage(
                              clientId: 'dummy_client_id',
                              clientName: 'Sample Client',
                              garmentType: 'blouse',
                            ),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.accessibility_new,
                      ), // Generic icon for blouse
                      label: const Text('Add Blouse Measurements'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        backgroundColor: Colors.orange[500],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const GarmentMeasurementPage(
                              clientId: 'dummy_client_id',
                              clientName: 'Sample Client',
                              garmentType: 'shorts',
                            ),
                          ),
                        );
                      },
                      icon: const Icon(Icons.short_text), // Icon for shorts
                      label: const Text('Add Shorts Measurements'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        backgroundColor: Colors.orange[500],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const GarmentMeasurementPage(
                              clientId: 'dummy_client_id',
                              clientName: 'Sample Client',
                              garmentType: 'gown',
                            ),
                          ),
                        );
                      },
                      icon: const Icon(Icons.dry_cleaning), // Icon for gown
                      label: const Text('Add Gown Measurements'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        backgroundColor: Colors.orange[500],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const GarmentMeasurementPage(
                              clientId: 'dummy_client_id',
                              clientName: 'Sample Client',
                              garmentType: 'trousers',
                            ),
                          ),
                        );
                      },
                      icon: const Icon(Icons.straighten), // Icon for trousers
                      label: const Text('Add Trousers Measurements'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        backgroundColor: Colors.orange[500],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),

            // Coming Soon Features Section
            Text(
              'COMING SOON FEATURES',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.grey[600],
                letterSpacing: 1,
              ),
            ),
            const SizedBox(height: 16),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildFeatureItem(
                      Icons.history,
                      'Measurement History & Trends',
                      'Visualize client progress over time with interactive charts.',
                    ),
                    _buildFeatureItem(
                      Icons.bar_chart,
                      'Body Composition Analysis',
                      'Calculate BMI, body fat percentage, and more.',
                    ),
                    _buildFeatureItem(
                      Icons.cloud_upload,
                      'Cloud Sync & Backup',
                      'Securely store and sync your data across devices.',
                    ),
                    _buildFeatureItem(
                      Icons.file_download,
                      'Export Data (CSV/PDF)',
                      'Generate professional reports for your clients.',
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 40),

            // Things to Do Section
            Text(
              'THINGS TO DO',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.grey[600],
                letterSpacing: 1,
              ),
            ),
            const SizedBox(height: 16),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTodoItem(
                      'Add your first client and start tracking measurements.',
                    ),
                    _buildTodoItem(
                      'Explore the different measurement categories.',
                    ),
                    _buildTodoItem(
                      'Provide feedback to help us improve the app!',
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureItem(IconData icon, String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.orange[600], size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTodoItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.check_circle_outline, color: Colors.green[600], size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: 15, color: Colors.grey[800]),
            ),
          ),
        ],
      ),
    );
  }
}
