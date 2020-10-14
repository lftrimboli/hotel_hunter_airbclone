import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hotel_hunter/Models/appConstants.dart';
import 'package:hotel_hunter/Models/data.dart';
import 'package:hotel_hunter/Models/postingObjects.dart';
import 'package:hotel_hunter/Screens/viewPostingPage.dart';
import 'package:hotel_hunter/Views/gridWidgets.dart';

class ExplorePage extends StatefulWidget {

  ExplorePage({Key key}) : super(key: key);

  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {

  TextEditingController _controller = TextEditingController();
  Stream _stream = Firestore.instance.collection('postings').snapshots();
  String _searchType = "";
  bool _isNameButtonSelected = false;
  bool _isCityButtonSelected = false;
  bool _isTypeButtonSelected = false;

  void _searchByField() {
    if (_searchType.isEmpty) {
      _stream = Firestore.instance.collection('postings').snapshots();
    } else {
      String text = _controller.text;
      _stream = Firestore.instance.collection('postings').where(_searchType, isEqualTo: text).snapshots();
    }
    setState(() {});
  }

  void _pressSearchByButton(String searchType, bool isNameSelected, bool isCitySelected, bool isTypeSelected) {
    _searchType = searchType;
    _isNameButtonSelected = isNameSelected;
    _isCityButtonSelected = isCitySelected;
    _isTypeButtonSelected = isTypeSelected;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(25, 25, 25, 0),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey,
                      width: 2.0
                    ),
                  ),
                  contentPadding: EdgeInsets.all(5.0),
                ),
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.black
                ),
                controller: _controller,
                onEditingComplete: _searchByField,
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height / 9,
              child: Row(
                children: <Widget>[
                  MaterialButton(
                    onPressed: () {
                      _pressSearchByButton("name", true, false, false);
                    },
                    child: Text('Name'),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    color: _isNameButtonSelected ? Colors.grey : Colors.white,
                  ),
                  MaterialButton(
                    onPressed: () {
                      _pressSearchByButton("city", false, true, false);
                    },
                    child: Text('City'),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    color: _isCityButtonSelected ? Colors.grey : Colors.white,
                  ),
                  MaterialButton(
                    onPressed: () {
                      _pressSearchByButton("type", false, false, true);
                    },
                    child: Text('Type'),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    color: _isTypeButtonSelected ? Colors.grey : Colors.white,
                  ),
                  MaterialButton(
                    onPressed: () {
                      _pressSearchByButton("", false, false, false);
                    },
                    child: Text('Clear'),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  ),
                ],
              ),
            ),
            StreamBuilder(
              stream: _stream,
              builder: (context, snapshots) {
                switch (snapshots.connectionState) {
                  case ConnectionState.waiting:
                    return Center(child: CircularProgressIndicator());
                  default:
                    return GridView.builder(
                      physics: ScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshots.data.documents.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 15,
                          mainAxisSpacing: 15,
                          childAspectRatio: 3/4
                      ),
                      itemBuilder: (context, index) {
                        DocumentSnapshot snapshot = snapshots.data.documents[index];
                        Posting currentPosting = Posting(id: snapshot.documentID);
                        currentPosting.getPostingInfoFromSnapshot(snapshot);
                        return InkResponse(
                          enableFeedback: true,
                          child: PostingGridTile(posting: currentPosting,),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ViewPostingPage(posting: currentPosting,),
                              ),
                            );
                          },
                        );
                      },
                    );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
