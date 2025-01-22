import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'login_page.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final TextEditingController _toyNameController = TextEditingController();
  final TextEditingController _toyImageController = TextEditingController();
  final TextEditingController _toyPriceController = TextEditingController();

  List<dynamic> toysList = [];
  List<dynamic> reviewsList = [];
  bool isEditing = false;
  int? editingToyId;

  // Fungsi untuk menambahkan mainan baru
  Future<void> addAvailableToy(String name, String imageUrl, int price) async {
    final response = await http.post(
      Uri.parse('http://teknologi22.xyz/project_api/api_nadhif/katalog/add_available_toy.php'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'name': name, 'image': imageUrl, 'price': price}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['status'] == 'success') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Mainan berhasil ditambahkan!')),
        );
        _toyNameController.clear();
        _toyImageController.clear();
        _toyPriceController.clear();
        loadToys();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${data['message']}')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Gagal menambahkan mainan. Mohon coba lagi.')),
      );
    }
  }

  // Fungsi untuk memuat daftar mainan
  Future<void> loadToys() async {
    final response = await http.get(
      Uri.parse('http://teknologi22.xyz/project_api/api_nadhif/katalog/get_available_toys.php'),
    );

    if (response.statusCode == 200) {
      try {
        final data = jsonDecode(response.body);
        if (data['status'] == 'success') {
          setState(() {
            toysList = List.from(data['data']);
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${data['message']}')),
          );
        }
      } catch (_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error parsing data.')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Gagal memuat mainan. Mohon coba lagi.')),
      );
    }
  }

  // Fungsi untuk mengedit mainan
  Future<void> editAvailableToy(int id, String name, String imageUrl, int price) async {
    final response = await http.post(
      Uri.parse('http://teknologi22.xyz/project_api/api_nadhif/katalog/edit_available_toy.php'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'id': id, 'name': name, 'image': imageUrl, 'price': price}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['status'] == 'success') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Data mainan telah berhasil diedit!')),
        );
        setState(() {
          isEditing = false;
          editingToyId = null;
        });
        loadToys();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${data['message']}')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Gagal mengupdate data mainan.')),
      );
    }
  }

  // Fungsi untuk menghapus mainan
  Future<void> deleteAvailableToy(int id) async {
    final response = await http.post(
      Uri.parse('http://teknologi22.xyz/project_api/api_nadhif/katalog/delete_available_toy.php'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'id': id}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['status'] == 'success') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Toy deleted successfully!')),
        );
        loadToys();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${data['message']}')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to delete toy.')),
      );
    }
  }

  // Fungsi untuk menampilkan dialog konfirmasi hapus
  void showDeleteConfirmationDialog(int toyId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Konfirmasi Hapus'),
          content: const Text('Apakah Anda yakin ingin menghapus mainan ini?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Tutup dialog
              },
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Tutup dialog
                deleteAvailableToy(toyId); // Panggil fungsi untuk menghapus data
              },
              child: const Text('Hapus'),
            ),
          ],
        );
      },
    );
  }



  // Fungsi untuk menampilkan daftar review
  Future<void> loadReviews() async {
    final response = await http.get(
      Uri.parse('http://teknologi22.xyz/project_api/api_nadhif/katalog/get_reviews.php'),
    );

    if (response.statusCode == 200) {
      try {
        final data = jsonDecode(response.body);
        if (data['status'] == 'success') {
          setState(() {
            reviewsList = List.from(data['data']);
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${data['message']}')),
          );
        }
      } catch (_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error parsing data.')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to load reviews. Please try again.')),
      );
    }
  }

  // Fungsi untuk menghapus review
  Future<void> deleteReview(String username, int rating) async {
    final response = await http.post(
      Uri.parse('http://teknologi22.xyz/project_api/api_nadhif/katalog/delete_reviews.php'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': username, 'rating': rating}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['status'] == 'success') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Review deleted successfully!')),
        );
        loadReviews();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${data['message']}')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to delete review.')),
      );
    }
  }

  // Fungsi untuk logout
  void showLogoutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Konfirmasi Logout'),
          content: const Text('Apakah Anda yakin ingin keluar?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                      (Route<dynamic> route) => false,
                );
              },
              child: const Text('Logout'),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    loadToys();
    loadReviews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Halaman Admin', style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),

        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: const Icon(Icons.logout),
          onPressed: showLogoutDialog,
        ),
      ),
      backgroundColor: Color(0xFFE3F2FD), // Set the background color to blue[100]
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Tambah atau Edit Mainan',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _toyNameController,
              decoration: const InputDecoration(
                labelText: 'Nama Mainan',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _toyImageController,
              decoration: const InputDecoration(
                labelText: 'Gambar Mainan (URL)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _toyPriceController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Harga Mainan',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  final name = _toyNameController.text;
                  final imageUrl = _toyImageController.text;
                  final price = int.tryParse(_toyPriceController.text);

                  if (name.isEmpty || imageUrl.isEmpty || price == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please fill all fields.')),
                    );
                    return;
                  }

                  if (isEditing) {
                    editAvailableToy(editingToyId!, name, imageUrl, price);
                  } else {
                    addAvailableToy(name, imageUrl, price);
                  }
                },
                child: Text(isEditing ? 'Update Mainan' : 'Tambah Mainan'),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: toysList.length,
                itemBuilder: (context, index) {
                  final toy = toysList[index];
                  final toyId = int.tryParse(toy['id'].toString()) ?? 0;

                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    elevation: 4.0,
                    child: ListTile(
                      leading: Image.network(
                        toy['image'],
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                      title: Text(
                        toy['name'],
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text('Price: ${toy['price']}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.blue),
                            onPressed: () {
                              setState(() {
                                isEditing = true;
                                editingToyId = toyId;
                                _toyNameController.text = toy['name'];
                                _toyImageController.text = toy['image'];
                                _toyPriceController.text =
                                    toy['price'].toString();
                              });
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              showDeleteConfirmationDialog(toyId);
                            },
                          ),

                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Reviews Pengguna',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: reviewsList.length,
                itemBuilder: (context, index) {
                  final review = reviewsList[index];
                  final username = review['username'];
                  final rating = int.tryParse(review['rating'].toString()) ?? 0;

                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    elevation: 4.0,
                    child: ListTile(
                      title: Text(
                        'User: $username',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text('Rating: $rating\nReview: ${review['review']}'),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          deleteReview(username, rating);
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
