import 'package:flutter/material.dart';
import '../services/api_service.dart';
import 'package:intl/intl.dart';

class QueueDetailPage extends StatelessWidget {
  final Map<String, dynamic> queue;

  QueueDetailPage({required this.queue});

  // Fungsi untuk mengonversi timestamp ke format tanggal
  String _formatDate(int timestamp) {
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    var formattedDate = DateFormat('HH:mm').format(date); // Format jam:menit
    return formattedDate;
  }

  // Fungsi untuk membangun detail item
  Widget _buildDetailItem(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(value),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Antrian'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 4,
              margin: EdgeInsets.symmetric(vertical: 10),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDetailItem('No Antrian',
                        queue['no'].toString()), // Konversi int ke String
                    _buildDetailItem('Customer', queue['customerName']),
                    _buildDetailItem('Store Name', queue['storeName']),
                    _buildDetailItem('Pax',
                        queue['pax'].toString()), // Konversi int ke String
                    _buildDetailItem(
                        'Jam Submit',
                        _formatDate(queue[
                            'dateIn'])), // Konversi timestamp ke jam:menit
                    _buildDetailItem(
                        'Estimasi Waktu Masuk',
                        queue['averageWaitTime']
                            .toString()), // Konversi averageWaitTime
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Antrian Pelanggan Lainnya',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            // Jika queue history lain kosong, tampilkan teks 'Tidak ada data'
            queue['queueHistory'] != null && queue['queueHistory'].isNotEmpty
                ? Expanded(
                    child: ListView.builder(
                      itemCount: queue['queueHistory'].length,
                      itemBuilder: (context, index) {
                        var history = queue['queueHistory'][index];
                        return Card(
                          elevation: 2,
                          child: ListTile(
                            title: Text(history['customerName']),
                            subtitle: Text('Pax: ${history['pax'].toString()}'),
                          ),
                        );
                      },
                    ),
                  )
                : Text('Tidak ada data'),
          ],
        ),
      ),
    );
  }
}
