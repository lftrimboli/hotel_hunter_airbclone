import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hotel_hunter/Models/userObjects.dart';
import 'appConstants.dart';

class Review {

  String id;
  Contact contact;
  String text;
  double rating;
  DateTime dateTime;

  Review();

  void createReview(Contact contact, String text, double rating, DateTime dateTime) {
    this.contact = contact;
    this.text = text;
    this.rating = rating;
    this.dateTime = dateTime;
  }

  void getReviewInfoFromFirestore(DocumentSnapshot snapshot) {
    this.id = snapshot.documentID;
    this.rating = snapshot['rating'].toDouble() ?? 2.5;
    this.text = snapshot['text'] ?? "";

    Timestamp timestamp = snapshot['dateTime'] ?? Timestamp.now();
    this.dateTime = timestamp.toDate();

    String fullName = snapshot['name'] ?? "";
    String contactID = snapshot['userID'] ?? "";
    _loadContactInfo(contactID, fullName);
  }

  void _loadContactInfo(String id, String fullName) {
    String firstName = "";
    String lastName = "";
    firstName = fullName.split(" ")[0];
    lastName = fullName.split(" ")[1];
    this.contact = Contact(id: id, firstName: firstName, lastName: lastName);
  }

}