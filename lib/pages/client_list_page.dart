import 'package:cut2fit/utils/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:cut2fit/pages/measurement_input_page.dart';
import 'package:cut2fit/utils/database_helper.dart';
import 'package:cut2fit/main.dart'; // For ContextExtension
import 'package:image_picker/image_picker.dart'; // For image picking
import 'dart:io'; // For File operations
import 'package:path_provider/path_provider.dart'; // For getting app document directory

class ClientListPage extends StatefulWidget {
  const ClientListPage({super.key});

  @override
  State<ClientListPage> createState() => _ClientListPageState();
}

class _ClientListPageState extends State<ClientListPage> {
  List<Map<String, dynamic>> _clients = [];
  bool _isLoading = true;
  String?
  _pickedImagePath; // To hold the path of the image selected in the dialog

  @override
  void initState() {
    super.initState();
    _fetchClients();
  }

  Future<void> _fetchClients() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final clients = await DatabaseHelper.instance.getClients();
      setState(() {
        _clients = clients;
      });
    } catch (e) {
      if (mounted) {
        context.showSnackBar('Error fetching clients: $e', isError: true);
      }
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _pickedImagePath = image.path;
      });
    }
  }

  Future<void> _addClient() async {
    String? clientName = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        TextEditingController nameController = TextEditingController();
        return StatefulBuilder(
          // Use StatefulBuilder to update dialog UI
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Add New Client'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: () async {
                      final ImagePicker picker = ImagePicker();
                      final XFile? image = await picker.pickImage(
                        source: ImageSource.gallery,
                      );
                      if (image != null) {
                        setState(() {
                          _pickedImagePath = image.path;
                        });
                      }
                    },
                    child: CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.orange[100], // Changed to orange
                      backgroundImage: _pickedImagePath != null
                          ? FileImage(File(_pickedImagePath!))
                          : null,
                      child: _pickedImagePath == null
                          ? Icon(
                              Icons.camera_alt,
                              size: 40,
                              color: Colors.orange[700],
                            ) // Changed to orange
                          : null,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(hintText: 'Client Name'),
                  ),
                ],
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('Cancel'),
                  onPressed: () {
                    _pickedImagePath = null; // Clear image path on cancel
                    Navigator.of(context).pop();
                  },
                ),
                ElevatedButton(
                  child: const Text('Add'),
                  onPressed: () {
                    Navigator.of(context).pop(nameController.text);
                  },
                ),
              ],
            );
          },
        );
      },
    );

    if (clientName != null && clientName.isNotEmpty) {
      String? savedImagePath;
      if (_pickedImagePath != null) {
        try {
          final appDocDir = await getApplicationDocumentsDirectory();
          final clientProfilesDir = Directory(
            '${appDocDir.path}/client_profiles',
          );
          if (!await clientProfilesDir.exists()) {
            await clientProfilesDir.create(recursive: true);
          }
          final fileName = '${DateTime.now().millisecondsSinceEpoch}.png';
          final newPath = '${clientProfilesDir.path}/$fileName';
          await File(_pickedImagePath!).copy(newPath);
          savedImagePath = newPath;
        } catch (e) {
          if (mounted) {
            context.showSnackBar('Error saving image: $e', isError: true);
          }
          savedImagePath = null; // Don't save path if copy failed
        }
      }

      try {
        await DatabaseHelper.instance.insertClient(
          clientName,
          profilePicturePath: savedImagePath,
        );
        if (mounted) {
          context.showSnackBar('Client "$clientName" added successfully!');
        }
        _fetchClients(); // Refresh the list
      } catch (e) {
        if (mounted) {
          context.showSnackBar('Error adding client: $e', isError: true);
        }
      } finally {
        setState(() {
          _pickedImagePath = null; // Reset for next add
        });
      }
    } else {
      setState(() {
        _pickedImagePath =
            null; // Clear image path if dialog was dismissed without adding
      });
    }
  }

  Future<void> _confirmDeleteClient(String clientId, String clientName) async {
    final bool? confirm = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Client'),
          content: Text(
            'Are you sure you want to delete "$clientName"? All their measurements will also be deleted.',
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text(
                'Delete',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );

    if (confirm == true) {
      try {
        await DatabaseHelper.instance.deleteClient(clientId);
        if (mounted) {
          context.showSnackBar('Client "$clientName" deleted successfully!');
        }
        _fetchClients(); // Refresh the list
      } catch (e) {
        if (mounted) {
          context.showSnackBar('Error deleting client: $e', isError: true);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Clients'),
        actions: [
          IconButton(icon: const Icon(Icons.refresh), onPressed: _fetchClients),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _clients.isEmpty
          ? const Center(
              child: Text(
                'No clients yet. Add one to get started!',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: _clients.length,
              itemBuilder: (context, index) {
                final client = _clients[index];
                final String? profilePicturePath =
                    client['profile_picture_path'];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    leading: CircleAvatar(
                      backgroundColor: Colors.orange[100], // Changed to orange
                      backgroundImage:
                          profilePicturePath != null &&
                              File(profilePicturePath).existsSync()
                          ? FileImage(File(profilePicturePath))
                          : null,
                      child:
                          profilePicturePath == null ||
                              !File(profilePicturePath).existsSync()
                          ? Text(
                              client['name'][0].toUpperCase(),
                              style: TextStyle(
                                color: Colors.orange[700],
                                fontWeight: FontWeight.bold,
                              ), // Changed to orange
                            )
                          : null,
                    ),
                    title: Text(
                      client['name'],
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Text(
                      'Joined: ${DateTime.parse(client['created_at']).toLocal().toString().split(' ')[0]}',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.delete_outline,
                            color: Colors.red,
                          ),
                          onPressed: () => _confirmDeleteClient(
                            client['id'],
                            client['name'],
                          ),
                        ),
                        const Icon(
                          Icons.arrow_forward_ios,
                          size: 16,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.of(context)
                          .push(
                            MaterialPageRoute(
                              builder: (context) => MeasurementInputPage(
                                clientId: client['id'],
                                clientName: client['name'],
                              ),
                            ),
                          )
                          .then(
                            (_) => _fetchClients(),
                          ); // Refresh list when returning
                    },
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _addClient,
        label: const Text('Add New Client'),
        icon: const Icon(Icons.person_add),
        backgroundColor: Colors.orange[700], // Changed to orange
        foregroundColor: Colors.white,
      ),
    );
  }
}
