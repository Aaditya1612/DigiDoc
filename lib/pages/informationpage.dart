import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:wikipedia/wikipedia.dart';

class InformationPage extends StatefulWidget {
  InformationPage({super.key, required this.disease});
  String disease = "";

  @override
  State<InformationPage> createState() => _InformationPageState();
}

class _InformationPageState extends State<InformationPage> {
  bool isLoading = false;
  var resultDesc;
  getData() async {
    Wikipedia instance = Wikipedia();
    var result =
        await instance.searchQuery(searchQuery: widget.disease, limit: 1);
    for (int i = 0; i < result!.query!.search!.length; i++) {
      if (!(result.query!.search![i].pageid == null)) {
        resultDesc = await instance.searchSummaryWithPageId(
            pageId: result.query!.search![i].pageid!);
        print(resultDesc!.description);
      }
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState

    setState(() {
      isLoading = true;
    });
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return (isLoading)
        ? Scaffold(
            body: Container(child: CircularProgressIndicator()),
          )
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Color(0xff232c51),
              title: Text(resultDesc!.title),
            ),
            body: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(15.0),
                child: ExpandableText(
                  resultDesc!.extract,
                  textAlign: TextAlign.justify,
                  animation: true,
                  expandText: 'Read More',
                  maxLines: 10,
                  linkColor: Color.fromARGB(255, 20, 131, 221),
                ),
              ),
            ),
          );
  }
}
