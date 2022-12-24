import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../commons/commons.dart';
import '../../commons/widgets/button.dart';
import '../../commons/widgets/text.dart';
import '../../commons/widgets/text_field.dart';
import '../../commons/widgets/values.dart';
import '../models/hotel.dart';
import '../../hotel/pages/06hotel_checkout_page.dart';
import '../models/room.dart';

class HotelRatingPage extends StatefulWidget {
  const HotelRatingPage({
    required this.hotel,
    required this.room,
    Key? key
  }) : super(key: key);

  final Hotel hotel;
  final Room room;

  @override
  State<HotelRatingPage> createState() => _HotelRatingPageState();
}

class _HotelRatingPageState extends State<HotelRatingPage> {

  @override
  void initState() {
    super.initState();
    //
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      appBar: AppBar(
        title: const Text('Beri Penilaian', style: TextStyle(
            color: Colors.black
        )),
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        elevation: 0,
        backgroundColor: MyColors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(24),
            color: MyColors.transparent,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children : [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 128,
                      child: AspectRatio(
                        aspectRatio: 1, // 1.5,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(2),
                            child: CachedNetworkImage(
                              imageUrl: widget.hotel.photos.first,
                              fit: BoxFit.cover,
                              // placeholder: (context, url) => const CircularProgressIndicator(),
                              errorWidget: (context, url, error) => const Icon(Icons.error),
                            )
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const SizedBox(height: 6),
                          Text(widget.hotel.name, style: MyTextStyle.heading1,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: const [
                              Icon(Icons.star, size: 20, color: Color(0xFFFFC940)),
                              Icon(Icons.star, size: 20, color: Color(0xFFFFC940)),
                              Icon(Icons.star, size: 20, color: Color(0xFFFFC940)),
                              Icon(Icons.star, size: 20, color: Color(0xFFFFC940)),
                              Icon(Icons.star, size: 20, color: Colors.grey),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Icon(Icons.pin_drop, size: 20, color: Colors.grey),
                              Text(widget.hotel.city.name),
                            ],
                          ),
                        ],
                      ),
                    ),

                  ],
                ),
                const SizedBox(height: 12),
                Text(widget.room.name, style: MyTextStyle.heading1),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Icon(Icons.person),
                    const SizedBox(width: 6),
                    Text('1 tamu/kamar')
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.hotel),
                    const SizedBox(width: 6),
                    Text('1 ranjang single')
                  ],
                ),
                const Divider(thickness: 2, height: 34),
                Center(child: Text('Bagaimana Pengalaman staycation nya?', style: MyTextStyle.heading1)),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (var i = 0; i < 5; i++)
                    Icon(Icons.star, size: 34, color: Colors.grey),
                  ],
                ),
                const SizedBox(height: 24),
                const AvicennaTextField(
                  maxLines: 3,
                  textFieldStyle: AvicennaTextFieldStyle.border,
                  hintText: 'Tambahkan Komentar',
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const Spacer(),
                    AvicennaButton(
                      text: 'Kirim',
                      onPressed: () {
                        navigateToPage(context, HotelCheckoutPage());
                      },
                    ),
                  ],
                )
              ]
            ),
          ),
        )
      )
    );
  }
}