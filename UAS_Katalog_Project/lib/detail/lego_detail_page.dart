import 'package:flutter/material.dart';
import '../profile_page.dart'; // Import halaman profil

class LegoDetailPage extends StatefulWidget {
  final Map<String, String> toy;

  const LegoDetailPage({Key? key, required this.toy}) : super(key: key);

  @override
  _LegoDetailPageState createState() => _LegoDetailPageState();
}

class _LegoDetailPageState extends State<LegoDetailPage> {
  late PageController _pageController;
  int _currentPage = 0;

  final List<String> images = [
    'assets/lego.png',
    'assets/lego2.jpg',
    'assets/lego3.jpg',
    'assets/lego4.jpg',
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[100],
      appBar: AppBar(
        title: Text(
          widget.toy['name']!,
          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
        actions: [
          // Bio Toko Button with white icon
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
                    ],
                  ),
                ),
              ];
            },
            icon: const Icon(Icons.info_outline, color: Colors.white), // Bio Icon with white color
          ),
          // Profile Button with white icon
          IconButton(
            icon: const Icon(Icons.account_circle, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage()), // Navigate to ProfilePage
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Name above the Image Slider
              Center(
                child: Text(
                  "LEGO® Ferrari Daytona SP3 - 42143",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
              const SizedBox(height: 10),

              // Image Slider with Navigation (First Image)
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    images[0],
                    fit: BoxFit.contain,
                    height: 250, // Image height adjusted
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Deskripsi Produk
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Deskripsi Produk",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        widget.toy['description']!,
                        style: const TextStyle(
                          fontSize: 16,
                          height: 1.5,
                          color: Colors.black87,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Spesifikasi Produk
              Card(
                elevation: 4,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Spesifikasi Produk",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "- Ukuran keseluruhan produk ini adalah 25 x 25 x 30 cm.\n"
                            "- Berat produk sekitar 500 gram, memberikan keseimbangan antara ukuran dan kenyamanan untuk dipindahkan dari satu tempat ke tempat lain.\n"
                            "- Terbuat dari material plastik ABS berkualitas tinggi yang dikenal karena daya tahannya yang luar biasa, menjamin ketahanan produk meskipun sering digunakan.\n"
                            "- Set ini terdiri dari 350 pieces, memberikan tantangan tersendiri untuk merakitnya.\n",
                        style: TextStyle(
                          fontSize: 16,
                          height: 1.5,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Image Slider for Images 2, 3, 4 with Navigation
              Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      height: 250, // Height adjusted
                      child: PageView.builder(
                        controller: _pageController,
                        itemCount: images.length - 1, // Excluding the first image
                        onPageChanged: (index) {
                          setState(() {
                            _currentPage = index;
                          });
                        },
                        itemBuilder: (context, index) {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.asset(
                              images[index + 1], // Adjusted to start from image 2
                              fit: BoxFit.cover, // Changed to BoxFit.cover to crop images for landscape effect
                            ),
                          );
                        },
                      ),
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
                        padding: const EdgeInsets.all(10),
                        iconSize: 50,
                        color: Colors.black.withOpacity(0.6),
                      ),
                    ),
                    // Right Arrow
                    Positioned(
                      right: 8,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_right, size: 50, color: Colors.white),
                        onPressed: () {
                          if (_currentPage < images.length - 2) {
                            _pageController.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          }
                        },
                        padding: const EdgeInsets.all(10),
                        iconSize: 50,
                        color: Colors.black.withOpacity(0.6),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Harga
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.grey[200],
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Harga:",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    Text(
                      "Rp. 360,000",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.redAccent,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Pemberitahuan Pembelian Offline
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Text(
                  "Pembelian hanya dapat dilakukan secara offline. Silakan hubungi kami untuk detail lebih lanjut.",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
