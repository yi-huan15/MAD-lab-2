import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Exercise2_3Screen(),
  ));
}

class Exercise2_3Screen extends StatefulWidget {
  const Exercise2_3Screen({super.key});

  @override
  State<Exercise2_3Screen> createState() => _Exercise2_3ScreenState();
}

class _Exercise2_3ScreenState extends State<Exercise2_3Screen> {
  DateTime _selectedDate = DateTime.now();
  String _selectedHouse = 'Slytherin';

  final List<String> _houses = [
    'Gryffindor',
    'Slytherin',
    'Ravenclaw',
    'Hufflepuff',
  ];

  @override
  Widget build(BuildContext context) {
    final String formattedDate =
        "${_selectedDate.year}-${_selectedDate.month.toString().padLeft(2, '0')}-${_selectedDate.day.toString().padLeft(2, '0')}";

    return Scaffold(
      appBar: AppBar(
        title: const Text('CSS3344 Mobile App Dev - Lab 02'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // 1. Unified Student Profile & Location Card
          const StudentProfileCard(),
          const SizedBox(height: 16),

          // 2. Image Section
          const ImageSection(imagePath: 'assets/images/cat.jpeg'),
          const SizedBox(height: 16),

          // 3. Interactive Pickers Card
          Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Interactive Pickers (Lab 2.2)',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Divider(height: 20),
                  Text(
                    'Selected Date: $formattedDate',
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                  Text(
                    'Selected House: $_selectedHouse',
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.indigo,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Material Date Picker Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () => _selectMaterialDate(context),
                      icon: const Icon(Icons.calendar_today),
                      label: const Text('Material Date Picker'),
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Cupertino Date Picker Button
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () => _showCupertinoDatePicker(context),
                      icon: const Icon(CupertinoIcons.calendar),
                      label: const Text('Cupertino Date Picker (Modal Sheet)'),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Material Dropdown
                  Row(
                    children: [
                      const Text(
                        'Material House: ',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(width: 8),
                      DropdownButton<String>(
                        value: _houses.contains(_selectedHouse)
                            ? _selectedHouse
                            : _houses.first,
                        items: _houses.map((String house) {
                          return DropdownMenuItem<String>(
                            value: house,
                            child: Text(house),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            setState(() => _selectedHouse = newValue);
                          }
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Cupertino House Wheel Picker Button
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () => _showCupertinoHousePicker(context),
                      icon: const Icon(CupertinoIcons.option),
                      label: const Text('Cupertino House Wheel Picker'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- Picker Actions ---

  Future<void> _selectMaterialDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() => _selectedDate = picked);
    }
  }

  void _showCupertinoDatePicker(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => Container(
        height: 240,
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: CupertinoButton(
                child: const Text('Done'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            Expanded(
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                initialDateTime: _selectedDate,
                maximumDate: DateTime.now(),
                minimumYear: 1950,
                maximumYear: DateTime.now().year,
                onDateTimeChanged: (DateTime newDate) {
                  setState(() => _selectedDate = newDate);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showCupertinoHousePicker(BuildContext context) {
    int initialIndex = _houses.indexOf(_selectedHouse);
    if (initialIndex < 0) initialIndex = 0;

    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => Container(
        height: 220,
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: CupertinoButton(
                child: const Text('Done'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            Expanded(
              child: CupertinoPicker(
                itemExtent: 32,
                scrollController:
                FixedExtentScrollController(initialItem: initialIndex),
                onSelectedItemChanged: (int index) {
                  setState(() => _selectedHouse = _houses[index]);
                },
                children:
                _houses.map((house) => Center(child: Text(house))).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Unified Single Card Widget
class StudentProfileCard extends StatelessWidget {
  const StudentProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: const [
                  CircleAvatar(
                    radius: 45,
                    backgroundImage: AssetImage('assets/images/huan.jpeg'),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'CHUA YI HUAN',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Student ID: BCS24090005',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  Divider(height: 32, thickness: 1),
                  Text(
                    'Personal Life Goal / Quote: let me pass my Degree plz, but I hope can have better skills along the FYP journey',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    '"Im not such ambitious person but I wish to be billionaire"',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                      color: Colors.indigo,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 32, thickness: 1),
            const Text(
              'Location Details',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            const TitleSection(
              name: 'University of Technology Sarawak',
              location: 'Sibu, Sarawak',
              starCount: 24,
            ),
          ],
        ),
      ),
    );
  }
}

// Sub-Widget for Title and Rating
class TitleSection extends StatelessWidget {
  final String name;
  final String location;
  final int starCount;

  const TitleSection({
    super.key,
    required this.name,
    required this.location,
    required this.starCount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                location,
                style: TextStyle(color: Colors.grey[600], fontSize: 13),
              ),
            ],
          ),
        ),
        Icon(Icons.star, color: Colors.indigo[300]),
        const SizedBox(width: 4),
        Text('$starCount'),
      ],
    );
  }
}

// Sub-Widget for Image
class ImageSection extends StatelessWidget {
  final String imagePath;

  const ImageSection({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Image.asset(
        imagePath,
        width: double.infinity,
        height: 200,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            height: 200,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Center(
              child: Icon(Icons.image_not_supported, size: 50, color: Colors.grey),
            ),
          );
        },
      ),
    );
  }
}