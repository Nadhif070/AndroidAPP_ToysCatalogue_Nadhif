import 'package:flutter/material.dart';
import 'login_page.dart'; // Import LoginPage setelah log out
import 'detail/gundam_detail_page.dart'; // Import Gundam detail page
import 'detail/spiderman_detail_page.dart'; // Import Spiderman detail page
import 'detail/lego_detail_page.dart'; // Import Lego detail page
import 'catalog_page.dart'; // Import Catalog Page
import 'profile_page.dart'; // Import Profile Page

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<String> promoImages = [
    'assets/bannerpromo.jpg',
    'assets/bannerpromo2.jpg',
    'assets/bannerpromo3.jpeg',
    'assets/bannerpromo4.jpg',
    'assets/bannerpromo5.jpg',
  ];

  final List<Map<String, String>> popularToys = const [
    {
      'name': 'Gundam RX-78',
      'description': 'Model kit Gundam RX-78 dengan detail tinggi dan artikulasi.',
      'icon': 'gundam', // Add a custom icon for Gundam
    },
    {
      'name': 'Marvel Spider-Man Action Figure',
      'description': 'Action figure Spider-Man dengan pose dinamis dan aksesori.',
      'icon': 'spiderman', // Add a custom icon for Spider-Man
    },
    {
      'name': 'Lego Technic Ferrari',
      'description': 'Set Lego Technic Ferrari dengan fitur realistis dan desain canggih.',
      'icon': 'lego', // Add a custom icon for Lego
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[50], // Changed background to light blue
      appBar: AppBar(
        backgroundColor: Colors.blue, // Changed to blue
        title: const Text(
          'Katalog Dunia Mainan',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        actions: [
          // Bio Toko Button (Diletakkan di kiri)
          PopupMenuButton<String>(
            onSelected: (value) {
              // Handle bio menu option
            },
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem<String>(
                  value: 'bio',
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('Dunia Mainan adalah toko mainan terbesar dengan koleksi mainan terkini dan terpercaya.'),
                      SizedBox(height: 5),
                      Text('Jam Buka: 09:00 - 21:00'),
                      SizedBox(height: 5),
                      Text('Buka Setiap Hari: Senin - Minggu'),
                      SizedBox(height: 5),
                      Text('Nomor Telepon: +62 812-3456-7890'),
                      SizedBox(height: 5),
                      Text('Alamat: Jl. Mawar No.123, Jakarta Selatan'),
                    ],
                  ),
                ),
              ];
            },
            icon: const Icon(Icons.info_outline, color: Colors.white), // Bio Icon
          ),

          // Profile Button (Diletakkan di kanan)
          IconButton(
            icon: const Icon(Icons.account_circle, color: Colors.white), // Profile Icon
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfilePage()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Selamat Datang
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.2), // Changed to blue
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
              ),
              child: const Text(
                'Selamat Datang di Dunia Mainan!',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black, // Changed to blue
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),
            // Banner Atas
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  'assets/banneratas.jpg',
                  height: 250,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Penawaran Menarik
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.yellow.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Colors.orangeAccent,
                  width: 1.5,
                ),
              ),
              child: Column(
                children: const [
                  Text(
                    'Penawaran Menarik!',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Jangan lewatkan koleksi mainan terbaru kami dengan diskon menarik '
                        'untuk setiap pembelian. Ayo cek sekarang!',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Banner Promo Slider
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                height: 250,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    PageView.builder(
                      controller: _pageController,
                      itemCount: promoImages.length,
                      onPageChanged: (index) {
                        setState(() {
                          _currentPage = index;
                        });
                      },
                      itemBuilder: (context, index) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.asset(
                            promoImages[index],
                            fit: BoxFit.contain, // Menggunakan BoxFit.contain agar gambar tetap penuh
                          ),
                        );
                      },
                    ),
                    // Left Arrow
                    Positioned(
                      left: 8,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_left, size: 50, color: Colors.white),
                        onPressed: () {
                          if (_currentPage > 0) {
                            _pageController.previousPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          }
                        },
                      ),
                    ),
                    // Right Arrow
                    Positioned(
                      right: 8,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_right, size: 50, color: Colors.white),
                        onPressed: () {
                          if (_currentPage < promoImages.length - 1) {
                            _pageController.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Daftar Mainan Populer
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Mainan Populer - 2024',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue, // Changed to blue
                    ),
                  ),
                  const SizedBox(height: 10),
                  ListView.builder(
                    padding: const EdgeInsets.all(0),
                    itemCount: popularToys.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      IconData icon;
                      switch (popularToys[index]['icon']) {
                        case 'gundam':
                          icon = Icons.model_training; // Gundam icon
                          break;
                        case 'spiderman':
                          icon = Icons.ac_unit; // Spider-Man icon
                          break;
                        case 'lego':
                          icon = Icons.build; // Lego icon
                          break;
                        default:
                          icon = Icons.toys; // Default toy icon
                      }

                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        elevation: 5,
                        child: ListTile(
                          leading: Icon(icon, color: Colors.blue), // Changed to blue
                          title: Text(
                            popularToys[index]['name']!,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(popularToys[index]['description']!),
                          trailing: const Icon(Icons.arrow_forward_ios, color: Colors.grey),
                          onTap: () {
                            if (index == 0) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => GundamDetailPage(toy: popularToys[index]),
                                ),
                              );
                            } else if (index == 1) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SpidermanDetailPage(toy: popularToys[index]),
                                ),
                              );
                            } else if (index == 2) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LegoDetailPage(toy: popularToys[index]),
                                ),
                              );
                            }
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Tombol Catalog
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CatalogPage(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Changed background to blue
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),

                child: const Text(
                  'Mainan Lainnya',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // Changed text color to white
                  ),
                ),

              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
