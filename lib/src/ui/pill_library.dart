import 'package:flutter/material.dart';

class PillLibrary extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Søg",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () =>
                {showSearch(context: context, delegate: PillSearch())},
          )
        ],
      ),
      body: new Center(),
    );
  }
}

// Four methods that we have to override to make searchpage
class PillSearch extends SearchDelegate<String> {
  final pills = [
    "Viagra",
    "Morfin",
    "Pamol",
    "Benadryl",
    "Kemo",
    "Pinex",
    "Voltaren",
    "Benzadryl",
    "Næsespray",
    "Nyre vand",
    "Movicol",
    "Viagra",
    "Morfin",
    "Pamol",
    "Benadryl",
    "Kemo",
    "Pinex",
    "Voltaren",
    "Benzadryl",
    "Næsespray",
    "Nyre vand",
    "Movicol",
    "Viagra",
    "Morfin",
    "Pamol",
    "Benadryl",
    "Kemo",
    "Pinex",
    "Voltaren",
    "Benzadryl",
    "Næsespray",
    "Nyre vand",
    "Movicol",
    "Viagra",
    "Morfin",
    "Pamol",
    "Benadryl",
    "Kemo",
    "Pinex",
    "Voltaren",
    "Benzadryl",
    "Næsespray",
    "Nyre vand",
    "Movicol",
    "Viagra",
    "Morfin",
    "Pamol",
    "Benadryl",
    "Kemo",
    "Pinex",
    "Voltaren",
    "Benzadryl",
    "Næsespray",
    "Nyre vand",
    "Movicol",
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () => {query = ""},
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: () => {close(context, null)});
  }

  @override
  Widget buildResults(BuildContext context) {}

  @override
  Widget buildSuggestions(BuildContext context) {
    final totalPillList = pills
        .where((p) => p.toLowerCase().startsWith(query.toLowerCase()))
        .toList();

    return ListView.builder(
      key: Key('SearchScreen'),
      itemBuilder: (context, index) => ListTile(
            leading: Icon(Icons.colorize),
            title: Text(totalPillList[index]),
          ),
      itemCount: totalPillList.length,
    );
  }
}
