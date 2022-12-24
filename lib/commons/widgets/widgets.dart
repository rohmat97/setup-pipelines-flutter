import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kai_wisata/commons/widgets/text.dart';

import '../../hotel/models/hotel.dart';
import '../../hotel/models/room.dart';
import '../commons.dart';
import 'button.dart';

class ReviewWidget extends StatelessWidget {
  const ReviewWidget({
    Key? key,
    required this.name,
    this.imageUrl,
    required this.content,
  }) : super(key: key);

  final String name;
  final String? imageUrl;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SizedBox(
                width: 32,
                child: AspectRatio(
                  aspectRatio: 1, // 1.5,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: CachedNetworkImage(
                      imageUrl: imageUrl ?? '',
                      fit: BoxFit.cover,
                      // placeholder: (context, url) => const CircularProgressIndicator(),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                    )
                  ),
                ),
              ),
              const SizedBox(width: 6),
              Text(name)
            ],
          ),
          const SizedBox(height: 6),
          Text(content)
        ],
      )
    );
  }

}

class RoomWidget extends StatelessWidget {
  const RoomWidget({
    Key? key,
    required this.room,
    this.onPressed,
  }) : super(key: key);

  final Room room;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container( //Avicenna
      padding: const EdgeInsets.all(12),
      // onTap: onPressed,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: AspectRatio(
              aspectRatio: 2, // 1.5,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(2),
                child: CachedNetworkImage(
                  imageUrl : 'https://via.placeholder.com/266x120',
                  //imageUrl: room.photos.first,
                  fit: BoxFit.cover,
                  // placeholder: (context, url) => const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                )
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(room.name, style: MyTextStyle.heading1),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: const [
                       Icon(Icons.person),
                       SizedBox(width: 8),
                      Text('1 tamu/kamar')
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: const [
                      Icon(Icons.hotel),
                      SizedBox(width: 8),
                      Text('1 ranjang single')
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.fastfood_outlined),
                      const SizedBox(width: 8),
                      Text(room.breakfast)
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.wifi),
                      const SizedBox(width: 8),
                      Text('Wi-Fi gratis')
                    ],
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('Rp${moneyFormat(room.price)}', style: MyTextStyle.heading1),
                  Text('/kamar/malam', style: MyTextStyle.info),
                  const SizedBox(height: 4),
                  Text('Sisa ${room.availableRoom} kamar', style: room.availableRoom > 2 ? MyTextStyle.info : MyTextStyle.warning),
                  const SizedBox(height: 8),
                  AvicennaButton(onPressed: onPressed, text: 'Pesan', minimumSize: Size(48, 36),)
                ],
              ),
            ],
          ),
        ],
      )
    );
  }

}
