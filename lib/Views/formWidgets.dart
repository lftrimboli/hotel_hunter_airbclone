import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:hotel_hunter/Models/AppConstants.dart';
import 'package:hotel_hunter/Models/postingObjects.dart';
import 'package:hotel_hunter/Models/userObjects.dart';

class ReviewForm extends StatefulWidget {

  final Posting posting;
  final User user;

  ReviewForm({Key key, this.posting, this.user}): super(key: key);

  @override
  _ReviewFormState createState() => _ReviewFormState();

}

class _ReviewFormState extends State<ReviewForm> {

  TextEditingController _controller = TextEditingController();
  double _rating = 2.5;

  void _submitReview() {
    if (widget.posting == null) {
      widget.user.postNewReview(_controller.text, _rating).whenComplete(() {
        _controller.text = "";
        _rating = 2.5;
        setState(() {

        });
      });
    } else {
      widget.posting.postNewReview(_controller.text, _rating).whenComplete(() {
        _controller.text = "";
        _rating = 2.5;
        setState(() {

        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 2.0
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Form(
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Enter review text',
                    ),
                    maxLines: 2,
                    style: TextStyle(
                      fontSize: 20.0
                    ),
                    controller: _controller,
                    validator: (text) {
                      if (text.isEmpty) {
                        return "Please enter some text";
                      }
                      return null;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: StarRating(
                      rating: _rating,
                      size: 40.0,
                      starCount: 5,
                      color: AppConstants.selectedIconColor,
                      borderColor: Colors.grey,
                      onRatingChanged: (rating) {
                        _rating = rating;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
            ),
            MaterialButton(
              onPressed: _submitReview,
              child: Text('Submit'),
              color: Colors.blue,
            )
          ],
        ),
      ),
    );
  }

}