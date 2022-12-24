import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../../data/models/station.dart';
import '../../helpers/theme.dart';
import '../../widgets/kai_search_field.dart';

class SearchStation extends StatefulWidget {
   SearchStation(this.stations, this.onPick, {Key? key}) : super(key: key);
   List<Station> stations = [];
   Function(Station) onPick;

  @override
  State<StatefulWidget> createState() => _SearchStationState();
}

class _SearchStationState extends State<SearchStation> {

  TextEditingController searchController = TextEditingController();
  List<Station> filtered = [];

  @override
  void initState() {
    super.initState();

    filterStations();
    searchController.addListener(filterStations);
  }

  void filterStations(){
    var search = searchController.text;
    if(search == ""){
      setState(() {
        filtered = widget.stations;
      });
    }else {
      var theFiltered = widget.stations.where((e) =>
      e.code.toUpperCase().contains(search.toUpperCase()) ||
          e.name.toUpperCase().contains(search.toUpperCase()));
      setState(() {
        filtered = theFiltered.toList();
      });
    }
  }

  showIndicator(){
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          "Please wait ...",
        ),
        Container(
            alignment: Alignment.center,
            width: MediaQuery
                .of(context)
                .size
                .width * 0.8,
            margin: const EdgeInsets.only(top: 10),
            child: const LoadingIndicator(
                indicatorType: Indicator.ballPulse,
                colors: [KaiColor.primary],
                strokeWidth: 2,
                backgroundColor: KaiColor.white,
                pathBackgroundColor: KaiColor.white
            )
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              color: KaiColor.blue),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    alignment: Alignment.center,
                    child: Text(
                      'Pilih Stasiun',
                      style: KaiTextStyle.titleSmallBold.apply(
                        color: KaiColor.white,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.close,
                      color: KaiColor.white,
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              )
            ],
          ),
        ),
        Container(
          color: KaiColor.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 18.0),
            child: KaiSearchField(
              textController: searchController,
              hint: 'Cari stasiun kereta',
              obscure: false,
              widget: const Icon(Icons.search),
            ),
          ),
        ),
        Container(
          color: KaiColor.blue,
          child: const Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                'Stasiun terdekat ',
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w400,
                  color: KaiColor.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
            flex: 18,
            child: ListView.builder(
                itemCount: filtered.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () => widget.onPick(filtered[index]),
                    child: ListTile(
                      title: Text(
                        filtered[index].code,
                        style: KaiTextStyle.bodyLargeBold,
                      ),
                      subtitle: Text(filtered[index].name,
                        style: KaiTextStyle.bodySmallMedium,
                      ),
                      tileColor: KaiColor.white,
                    ),
                  );
                })
        )
      ],
    );
  }
}