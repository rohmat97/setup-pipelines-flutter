import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kai_wisata/helpers/theme.dart';
import 'package:kai_wisata/kai_reguler/arguments/search_ticket_arguments.dart';

class KaiLastSearch extends StatelessWidget {
  const KaiLastSearch(this.arg, {
    Key? key,
    this.onTap,
  }) : super(key: key);

  final SearchTicketArguments arg;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(
          left: 18.0,
          top: 10.0,
          bottom: 5.0,
        ),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: KaiColor.white,
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 18.0,
                  right: 18.0,
                  top: 18.0,
                  bottom: 9.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${arg.from?.getCutName(7)}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: KaiColor.black,
                      ),
                    ),
                    SvgPicture.asset(
                      'assets/svg/arrow.svg',
                      color: KaiColor.yellow,
                    ),
                    Text(
                      "${arg.to?.getCutName(7)}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: KaiColor.black,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 18.0,
                  right: 18.0,
                  bottom: 9.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      arg.shortFromDate,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: KaiColor.black,
                      ),
                    ),
                    const Text(
                      '',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: KaiColor.blue,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 18.0,
                  right: 18.0,
                  bottom: 18.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      '',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: KaiColor.grey,
                      ),
                    ),
                    Text(
                      'Lihat Selengkapnya',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: KaiColor.blue,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
