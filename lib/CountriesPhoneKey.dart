import 'package:flutter/material.dart';

class CountriesPhoneKey {
  List<DropdownMenuItem> items = <DropdownMenuItem>[
    DropdownMenuItem(
      value: "+20",
      child: Row(
        children: const [
          Text("+20"),
          SizedBox(
            width: 5,
          ),
          Image(
            width: 30,
            height: 30,
            image: AssetImage("design/images/Egypt.png"),
          ),
          SizedBox(
            width: 5,
          ),
          Text("Egypt"),
        ],
      ),
    ),
    DropdownMenuItem(
      value: "+1",
      child: Row(
        children: const [
          Text("+1"),
          SizedBox(
            width: 5,
          ),
          Image(
            width: 30,
            height: 30,
            image: AssetImage("design/images/USA.png"),
          ),
          SizedBox(
            width: 5,
          ),
          Text("USA"),
        ],
      ),
    ),
    DropdownMenuItem(
      value: "+44",
      child: Row(
        children: const [
          Text("+44"),
          SizedBox(
            width: 5,
          ),
          Image(
            width: 30,
            height: 30,
            image: AssetImage("design/images/UK.png"),
          ),
          SizedBox(
            width: 5,
          ),
          Text("UK"),
        ],
      ),
    ),
    DropdownMenuItem(
      value: "+33",
      child: Row(
        children: const [
          Text("+33"),
          SizedBox(
            width: 5,
          ),
          Image(
            width: 30,
            height: 30,
            image: AssetImage("design/images/France.png"),
          ),
          SizedBox(
            width: 5,
          ),
          Text("France"),
        ],
      ),
    ),
    DropdownMenuItem(
      value: "+970",
      child: Row(
        children: const [
          Text("+970"),
          SizedBox(
            width: 5,
          ),
          Image(
            width: 30,
            height: 30,
            image: AssetImage("design/images/Palestine.png"),
          ),
          SizedBox(
            width: 5,
          ),
          Text("Palestine"),
        ],
      ),
    ),
  ];

  CountriesPhoneKey();

  List<DropdownMenuItem> get getItems {
    return items;
  }
}
