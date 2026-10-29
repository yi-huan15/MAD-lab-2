import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Exercise2_1Screen(),
  ));
}

class Exercise2_1Screen extends StatelessWidget {
  const Exercise2_1Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CSS3344 Mobile App Dev - Lab 02'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Card(
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
                  // --- Student Info Section ---
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

                  // --- Divider before Location Details ---
                  const Divider(height: 32, thickness: 1),

                  // --- Location Details Header ---
                  const Text(
                    'Location Details',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // --- Deconstructed TitleSection Sub-Widget ---
                  const TitleSection(
                    name: 'University of Technology Sarawak',
                    location: 'Sibu, Sarawak',
                    starCount: 24,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Exercise 2.1 TitleSection Sub-Widget (Base code from lab sheet)
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
        Icon(Icons.star, color: Colors.yellow[600]),
        const SizedBox(width: 4),
        Text('$starCount'),
      ],
    );
  }
}