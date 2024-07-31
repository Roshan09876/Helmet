import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:helmet/constants/show_snackbar.dart';
import 'package:helmet/features/booked_helmet/book_helmet_service.dart';

class Cartview extends ConsumerStatefulWidget {
  const Cartview({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CartviewState();
}

class _CartviewState extends ConsumerState<Cartview> {
  final BookHelmetService _bookHelmetService = BookHelmetService();
  List<dynamic>? _bookedHelmetData;

  @override
  void initState() {
    super.initState();
    _getBookedHelmet();
  }

  void _getBookedHelmet() async {
    try {
      final response = await _bookHelmetService.getBookedHelmet(context);
      print('Booked Helmet API Response $response');
      if (response != null &&
          response['success'] == true &&
          response.containsKey('books')) {
        setState(() {
          _bookedHelmetData = response['books'];
        });
      } else {
        throw Exception(
            response['message'] ?? 'Failed to fetch booked helmet data');
      }
    } catch (e) {
      print('Error fetching Booked Helmet: $e');
      showSnackBar(
        color: Colors.red,
        message: e.toString().replaceFirst('Exception: ', ''),
        context: context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Center(
          child: Text(
            'Cart Page',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
      body: _bookedHelmetData == null
          ? Center(child: Text('No Helmet is Booked'))
          : _bookedHelmetData!.isEmpty
              ? Center(child: Text('No helmets booked yet'))
              : Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: ListView.builder(
                    itemCount: _bookedHelmetData!.length,
                    itemBuilder: (context, index) {
                      final helmet = _bookedHelmetData![index];
                      return ListTile(
                        leading: Image.network(helmet['image']),
                        title: Text(helmet['helmetType']),
                        subtitle: Text('Price: ${helmet['helmetPrice']}'),
                      );
                    },
                  ),
                ),
    );
  }
}
