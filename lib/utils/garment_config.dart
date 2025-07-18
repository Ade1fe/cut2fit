class GarmentMeasurement {
  final String type;
  final String title;
  final String imagePath;
  final List<Map<String, String>> fields;

  GarmentMeasurement({
    required this.type,
    required this.title,
    required this.imagePath,
    required this.fields,
  });
}

final Map<String, GarmentMeasurement> garmentConfigs = {
  'dress': GarmentMeasurement(
    type: 'dress',
    title: 'Dress Measurements',
    imagePath: 'assets/images/dress_diagram.png',
    fields: [
      {'key': 'dress_length', 'label': 'Dress Length'},
      {'key': 'neck', 'label': 'Neck'},
      {'key': 'shoulder', 'label': 'Shoulder'},
      {'key': 'chest', 'label': 'Chest'},
      {'key': 'waist', 'label': 'Waist'},
      {'key': 'sleeve_length', 'label': 'Sleeve Length'},
      {'key': 'sleeve_round', 'label': 'Sleeve Round'},
      {'key': 'hips', 'label': 'Hips'},
    ],
  ),
  'skirt': GarmentMeasurement(
    type: 'skirt',
    title: 'Skirt Measurements',
    imagePath: 'assets/images/skirt_diagram.png',
    fields: [
      {'key': 'skirt_length', 'label': 'Skirt Length'},
      {'key': 'waist_circumference', 'label': 'Waist Circumference'},
      {'key': 'hip_circumference', 'label': 'Hip Circumference'},
      {'key': 'hem_circumference', 'label': 'Hem Circumference'},
    ],
  ),
  'blouse': GarmentMeasurement(
    type: 'blouse',
    title: 'Blouse Measurements',
    imagePath: 'assets/images/blouse_diagram.png',
    fields: [
      {'key': 'blouse_length', 'label': 'Blouse Length'},
      {'key': 'shoulder', 'label': 'Shoulder'},
      {'key': 'chest', 'label': 'Chest'},
      {'key': 'sleeve_length', 'label': 'Sleeve Length'},
      {'key': 'sleeve_round', 'label': 'Sleeve Round'},
      {'key': 'waist', 'label': 'Waist'},
    ],
  ),
  'shorts': GarmentMeasurement(
    type: 'shorts',
    title: 'Shorts Measurements',
    imagePath: 'assets/images/shorts_diagram.png',
    fields: [
      {'key': 'shorts_length', 'label': 'Shorts Length'},
      {'key': 'waist', 'label': 'Waist'},
      {'key': 'hip', 'label': 'Hip'},
      {'key': 'thigh', 'label': 'Thigh'},
      {'key': 'inseam', 'label': 'Inseam'},
    ],
  ),
  'gown': GarmentMeasurement(
    type: 'gown',
    title: 'Gown Measurements',
    imagePath: 'assets/images/gown_diagram.png',
    fields: [
      {'key': 'gown_length', 'label': 'Gown Length'},
      {'key': 'neck', 'label': 'Neck'},
      {'key': 'shoulder', 'label': 'Shoulder'},
      {'key': 'chest', 'label': 'Chest'},
      {'key': 'waist', 'label': 'Waist'},
      {'key': 'hips', 'label': 'Hips'},
      {'key': 'sleeve_length', 'label': 'Sleeve Length'},
      {'key': 'sleeve_round', 'label': 'Sleeve Round'},
    ],
  ),
  'trousers': GarmentMeasurement(
    type: 'trousers',
    title: 'Trousers Measurements',
    imagePath: 'assets/images/trousers_diagram.png',
    fields: [
      {'key': 'trouser_waist', 'label': 'Trouser Waist'},
      {'key': 'trouser_length', 'label': 'Trouser Length'},
      {'key': 'hip', 'label': 'Hip'},
      {'key': 'thigh', 'label': 'Thigh'},
      {'key': 'inseam', 'label': 'Inseam'},
      {'key': 'outseam', 'label': 'Outseam'},
      {'key': 'knee', 'label': 'Knee'},
      {'key': 'ankle', 'label': 'Ankle'},
    ],
  ),
};
