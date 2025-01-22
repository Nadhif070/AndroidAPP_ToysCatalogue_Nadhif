import 'package:flutter/material.dart';
import '../profile_page.dart'; // Import ProfilePage

class GundamDetailPage extends StatefulWidget {
  final Map<String, String> toy;

  const GundamDetailPage({Key? key, required this.toy}) : super(key: key);

  @override
  _GundamDetailPageState createState() => _GundamDetailPageState();
}

class _GundamDetailPageState extends State<GundamDetailPage> {
  late PageController _pageController;
  int _currentPage = 0;

  final List<String> images = [
    'assets/gundam.png',  // Main Image
    'assets/gundam2.webp', // Image 2
    'assets/gundam3.jpeg', // Image 3
    'assets/gundam4.jpg', // Image 4
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
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        title: Text(
          widget.toy['name']!,
          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent, // Changed from redAccent to blueAccent
        actions: [
          // Bio Toko Button with white icon (now positioned first)
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
          // Profile Button with white icon (now positioned second)
          IconButton(
            icon: const Icon(Icons.account_circle, color: Colors.white),
            onPressed: () {
              // Navigate to ProfilePage when profile button is clicked
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
                  "Gundam RX-78 (New) Ver 2.0",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
              const SizedBox(height: 10),

              // First Image stays at the top
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    images[0], // Main Gundam Image
                    height: 300,
                    fit: BoxFit.contain,
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
                          color: Colors.black, // Changed to blueAccent
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Gundam RX-78 (New) Ver 2.0 adalah model Gunpla skala 1:100 dengan detail luar biasa. Dilengkapi dengan fitur posable, senjata, dan aksesoris tambahan seperti bazooka dan beam rifle. Dengan material plastik ABS berkualitas tinggi, model ini memiliki desain ikonik dengan kombinasi warna putih, biru, merah, dan emas, cocok untuk koleksi dan display.",
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
                          color: Colors.black, // Changed to blueAccent
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "- Tinggi: 15 cm (skala 1:100)\n"
                            "- Material: Plastik ABS berkualitas tinggi\n"
                            "- Fitur: Posable, dengan senjata dan aksesoris tambahan\n"
                            "- Warna: Kombinasi putih, biru, merah, dan emas\n",
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
                              fit: BoxFit.cover, // Changed to BoxFit.cover for landscape effect
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
                      "Rp. 850,000",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.redAccent, // Changed to blueAccent
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
            ],
          ),
        ),
      ),
    );
  }
}
