import 'package:flutter/material.dart';
import '../services/api_service.dart';
import 'queue_detail_page.dart';

class QueueListPage extends StatefulWidget {
  @override
  _QueueListPageState createState() => _QueueListPageState();
}

class _QueueListPageState extends State<QueueListPage> {
  List queueData = [];
  List filteredData = [];
  String searchQuery = '';

  // Fungsi untuk mengambil data antrian dari API
  Future<void> fetchQueueData() async {
    try {
      final data = await ApiService().getQueueList(phoneNumber: '');
      setState(() {
        queueData = data['queueHistory'];
        filteredData = queueData; // Set initial data to be all queue data
      });
    } catch (error) {
      print('Error fetching queue data: $error');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchQueueData();
  }

  // Fungsi untuk filter data berdasarkan nama pelanggan
  void filterQueueData(String query) {
    setState(() {
      searchQuery = query;
      if (searchQuery.isEmpty) {
        // Jika tidak ada query, tampilkan semua data
        filteredData = queueData;
      } else {
        // Filter berdasarkan nama yang cocok dengan query
        filteredData = queueData
            .where((queue) => queue['customerName']
                .toLowerCase()
                .contains(searchQuery.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Antrian'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // TextField untuk pencarian berdasarkan nama
            TextField(
              decoration: InputDecoration(
                labelText: 'Cari berdasarkan Nama',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                filterQueueData(value);
              },
            ),
            SizedBox(height: 16),
            // List dari hasil pencarian
            Expanded(
              child: filteredData.isEmpty
                  ? Center(child: Text('Tidak ada antrian yang ditemukan'))
                  : ListView.builder(
                      itemCount: filteredData.length,
                      itemBuilder: (context, index) {
                        final queue = filteredData[index];
                        return ListTile(
                          title: Text(queue['customerName']),
                          subtitle: Text(
                              'Pax: ${queue['pax']}, Phone: ${queue['customerPhone']}'),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    QueueDetailPage(queue: queue),
                              ),
                            );
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/submit');
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
