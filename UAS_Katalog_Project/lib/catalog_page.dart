import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class CatalogPage extends StatefulWidget {
  const CatalogPage({Key? key}) : super(key: key);

  @override
  _CatalogPageState createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
  final List<Map<String, dynamic>> categories = const [
    {
      'category': 'Cinematic Movie Figures Series',
      'toys': [
        {
          'name': 'Superheroes Figure',
          'image': 'https://images.unsplash.com/photo-1561149877-84d268ba65b8?q=80&w=1935&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
          'price': 500000,
          'details': [ 'Batman: The Dark Knight Edition - 500000', 'Iron Man Mark LXXXV - 550000',
            'Superman: Man of Steel Version - 458000', 'Spider-Man: Far From Home Suit - 405000',
            'Wonder Woman: Golden Eagle Armor - 530000', 'Thor Hot Toys Ver. Endgame - 522000',
            'Captain America: Shield Masterpiece - 510000', 'Black Panther: Wakanda Forever Edition - 545000',
            'Hulk: Gladiator Version - 470000', 'Aquaman: Trident Bearer Edition - 490000',
            'Doctor Strange: Multiverse of Madness - 560000', 'Flash: Speedforce Suit - 460000',
            'Green Lantern: Emerald Knight Edition - 475000', 'Black Widow: White Suit Ver. - 500000',
            'Deadpool: X-Force Version - 583000'],
        },
        {
          'name': 'Villains Figure',
          'image': 'https://images.unsplash.com/photo-1591927675938-b81b071d3e91?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
          'price': 600000,
          'details': [
            'Darth Vader: Sith Lord Edition - 550000', 'Joker: Clown Prince of Crime - 600000',
            'Thanos: Infinity Gauntlet Ver. - 700000', 'Green Goblin: Oscorp Armor - 650000',
            'Loki: God of Mischief Edition - 750000', 'Ultron: Age of Extinction Ver. - 720000',
            'Venom: Symbiote Masterpiece - 680000', 'Harley Quinn: Suicide Squad Edition - 710000',
            'Magneto: Master of Magnetism - 670000', 'Red Skull: Hydra Commander - 640000',
            'Kingpin: Underworld Mastermind - 690000', 'Darkseid: Ruler of Apokolips - 750000',
            'Penguin: Gotham Crime Lord - 560000', 'Riddler: Puzzle Masterpiece - 580000',
            'Catwoman: Feline Femme Fatale - 610000'],
        },
      ],
    },
    {
      'category': 'Exclusive Toys',
      'toys': [
        {
          'name': 'Luxury Car Model',
          'image': 'https://m.media-amazon.com/images/I/61YAFhOEcjL._AC_UF894,1000_QL80_.jpg',
          'price': 800000,
          'details': [
            'Ferrari SF90 Stradale - 3,500,000', 'Lamborghini Aventador SVJ - 3,800,000',
            'Porsche 911 Turbo S - 2,800,000', 'McLaren P1 - 3,200,000',
            'Bugatti Chiron Sport - 5,000,000', 'Rolls Royce Phantom VIII - 4,500,000',
            'Bentley Continental GT - 3,700,000', 'Aston Martin DB11 - 3,400,000',
            'Maserati MC20 - 2,900,000', 'Pagani Huayra BC - 4,800,000',
            'Koenigsegg Jesko - 5,500,000', 'Lotus Evija - 2,600,000',
            'Tesla Roadster - 1,800,000', 'Jaguar F-Type R - 2,500,000',
            'BMW M8 Competition - 1,900,000'],
        },
        {
          'name': 'Golden Robot',
          'image': 'https://m.media-amazon.com/images/I/71ysd+ZysFL.jpg',
          'price': 900000,
          'details': [
            'C-3PO: Golden Protocol Droid - 550000', 'Bumblebee: Autobot Leader - 600000',
            'R2-D2: Astromech Droid - 580000', 'Optimus Prime: The Last Knight - 700000',
            'Wall-E: Earth’s Last Robot - 620000', 'Megatron: Decepticon Leader - 650000',
            'Iron Giant: Protector of Humanity - 750000', 'BB-8: Resistance Astromech - 580000',
            'Ultron: Artificial Intelligence - 720000', 'T-800: Terminator Endoskeleton - 800000',
            'EVE: Extraterrestrial Vegetation Evaluator - 560000', 'K-2SO: Imperial Enforcer Droid - 670000',
            'Droid: The Force Awakens Edition - 500000', 'Sentinel Prime: Cybertronian Leader - 680000',
            'Astro Boy: Robot Boy Hero - 550000'],
        },
      ],
    },
  ];

  List<Map<String, dynamic>> _reviews = [];
  String username = 'Guest'; // Default username
  List<Map<String, dynamic>> availableToys = [];



  Future<void> loadUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('username') ?? 'Guest';
    });
  }

  Future<void> loadReviews() async {
    final response = await http.get(Uri.parse('http://teknologi22.xyz/project_api/api_nadhif/katalog/get_reviews.php'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['status'] == 'success') {
        setState(() {
          _reviews = List<Map<String, dynamic>>.from(data['data']);
        });
      } else {
        print('Error: ${data['message']}');
      }
    } else {
      print('Failed to load reviews');
    }
  }

  Future<void> loadAvailableToys() async {
    final response = await http.get(Uri.parse('http://teknologi22.xyz/project_api/api_nadhif/katalog/get_available_toys.php'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['status'] == 'success') {
        setState(() {
          availableToys = List<Map<String, dynamic>>.from(data['data']);
        });
      } else {
        print('Error: ${data['message']}');
      }
    } else {
      print('Failed to load available toys');
    }
  }

  Future<void> addReview(String reviewText, int rating) async {
    final response = await http.post(
      Uri.parse('http://teknologi22.xyz/project_api/api_nadhif/katalog/add_reviews.php'),
      body: {
        'username': username,
        'review': reviewText,
        'rating': rating.toString(),
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['status'] == 'success') {
        loadReviews();
        print('Review added successfully!');
      } else {
        print('Error: ${data['message']}');
      }
    } else {
      print('Failed to add review');
    }
  }

  @override
  void initState() {
    super.initState();
    loadUsername();
    loadReviews();
    loadAvailableToys();
  }

  // Menambahkan dialog untuk review
  Future<void> _showReviewDialog(BuildContext context) async {
    String? review;
    int rating = 5;

    await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Review'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: const InputDecoration(hintText: 'Write your review here'),
              onChanged: (value) {
                review = value;
              },
            ),
            const SizedBox(height: 10),
            DropdownButton<int>(
              value: rating,
              items: List.generate(5, (index) {
                return DropdownMenuItem<int>(
                  value: index + 1,
                  child: Text('${index + 1} Stars'),
                );
              }),
              onChanged: (value) {
                setState(() {
                  rating = value!;
                });
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (review != null && review!.isNotEmpty) {
                addReview(review!, rating);
              }
              Navigator.of(context).pop();
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        flexibleSpace: Center(
          child: const Text(
            'Katalog Mainan',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ),
      ),
      body: Container(
        color: Color(0xFFE3F2FD), // Background color for the body
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: categories.length,
          itemBuilder: (context, categoryIndex) {
            final category = categories[categoryIndex];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Text(
                  category['category'],
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // 2 items per row
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                    childAspectRatio: 0.75,
                  ),
                  itemCount: category['toys'].length,
                  itemBuilder: (context, toyIndex) {
                    final toy = category['toys'][toyIndex];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ToyDetailPage(
                              toyName: toy['name'],
                              toyDetails: List<String>.from(toy['details']),
                            ),
                          ),
                        );
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(toy['image'] ?? 'default_image_url'),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              Container(
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [Colors.black54, Colors.transparent],
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  toy['name'] ?? 'Unknown Toy',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20), // Space between sections

                // Mainan Tersedia section
                if (categoryIndex == 1) ...[
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Mainan Tersedia',
                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        availableToys.isNotEmpty
                            ? Column(
                          children: availableToys.map<Widget>((toy) {
                            return Container(
                              margin: const EdgeInsets.only(bottom: 15),
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: Colors.grey, // Border color for each item
                                  width: 2, // Border width for each item
                                ),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(toy['image'] ?? 'default_image_url'),
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        toy['name'] ?? 'Unknown Toy',
                                        style: const TextStyle(
                                            fontSize: 16, fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        'Price: Rp ${toy['price'] ?? 0}',
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.green,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        )
                            : const Center(
                          child: Text(
                            'No toys available',
                            style: TextStyle(
                                fontSize: 16, fontStyle: FontStyle.italic),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20), // Add space after Mainan Tersedia
                ],

                // Review Toko section
                if (categoryIndex == categories.length - 1)
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Review Toko',
                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        Column(
                          children: _reviews.map<Widget>((review) {
                            return Row(
                              children: [
                                CircleAvatar(
                                  radius: 20,
                                  backgroundImage: AssetImage('assets/fotoprofile.jpg'),
                                ),
                                const SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      review['username'] ?? 'Guest',
                                      style: const TextStyle(
                                          fontSize: 16, fontWeight: FontWeight.bold),
                                    ),
                                    Text('${review['rating'] ?? 0} Stars',
                                        style: const TextStyle(color: Colors.orange)),
                                    Text(review['review'] ?? 'No review provided',
                                        style: const TextStyle(color: Colors.grey)),
                                  ],
                                ),
                              ],
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 20),
                        Center(
                          child: ElevatedButton(
                            onPressed: () => _showReviewDialog(context),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,  // Background color
                              foregroundColor: Colors.white,  // Text color
                              padding: EdgeInsets.symmetric(vertical: 14, horizontal: 30),  // Padding inside the button
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),  // Rounded corners
                              ),
                            ),
                            child: const Text(
                              'Tambahkan Review',
                              style: TextStyle(
                                fontSize: 16,  // Font size
                                fontWeight: FontWeight.bold,  // Bold text
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class ToyDetailPage extends StatelessWidget {
  final String toyName;
  final List<String> toyDetails;

  const ToyDetailPage({
    Key? key,
    required this.toyName,
    required this.toyDetails,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          toyName,
          style: TextStyle(
            fontWeight: FontWeight.bold, // Bold text
            color: Colors.white,         // White color
          ),
        ),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView( // Tambahkan SingleChildScrollView di sini
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Container with some decoration
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,  // Light red background color
                  borderRadius: BorderRadius.circular(10),  // Rounded corners
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: const Text(
                  'Daftar Mainan Tersedia 2025 (Ongoing)',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,  // Red text color
                  ),
                ),
              ),
              const SizedBox(height: 10),
              // List of toys
              ...toyDetails.map((detail) => ListTile(
                leading: const Icon(Icons.circle, size: 12, color: Colors.grey),
                title: Text(detail),
              )),
            ],
          ),
        ),
      ),
      backgroundColor: Color(0xFFE3F2FD), // Set background color to blue[100]
    );

  }

}



