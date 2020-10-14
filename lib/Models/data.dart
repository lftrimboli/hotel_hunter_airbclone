import 'package:hotel_hunter/Models/postingObjects.dart';
import 'package:hotel_hunter/Models/reviewObjects.dart';
import 'package:hotel_hunter/Models/userObjects.dart';

import 'messagingObjects.dart';

class PracticeData {

  static List<User> users = [];
  static List<Posting> postings = [];

  static populateFields() {
    // Creating users
    User user1 = User(
      firstName: "Nimish",
      lastName: "Narang",
      email: "narangnimish@gmail.com",
      bio: "I like travelling, exploring new places, and seeing the world",
      city: "Vancouver",
      country: "Canada",
    );
    user1.isHost = true;
    User user2 = User(
      firstName: "Cool",
      lastName: "Dude",
      email: "cooldude@gmail.com",
      bio: "I'm a cool guy who likes to travel and have fun in the sun",
      city: "Somewhere",
      country: "Nowhere",
    );
    users.add(user1);
    users.add(user2);

    // Adding a review to user1
    Review review = Review();
    review.createReview(
      user2.createContactFromUser(),
      "Fun guy, would definitely recommend him to others",
      4.5,
      DateTime.now(),
    );
    user1.reviews.add(review);

    // Adding conversation with some messages to user1
    Conversation conversation = Conversation();
    conversation.createConversation(user2.createContactFromUser(), []);
    Message message1 = Message();
    message1.createMessage(
      user1.createContactFromUser(),
      "Hey how's it going?",
      DateTime.now(),
    );
    Message message2 = Message();
    message2.createMessage(
      user2.createContactFromUser(),
      "Hey it's going really well, how have you been?",
      DateTime.now(),
    );
    conversation.messages.add(message1);
    conversation.messages.add(message2);
    user1.conversations.add(conversation);

    Posting posting1 = Posting(
      name: "Cool Casa",
      type: "House",
      price: 120,
      description: "Groovy house in the heart of the suburbs, perfect quiet little getaway",
      address: "1936 West 12 Avenue",
      city: "Vancouver",
      country: "Canada",
      host: user1.createContactFromUser(),
    );
//    posting1.setImages(['assets/images/apartment.jpg', 'assets/images/apartment.jpg']);
    posting1.amenities = ['washer', 'dryer', 'iron', 'coffee machine'];
    posting1.beds = {
      'small': 0,
      'medium': 2,
      'large': 2,
    };
    posting1.bathrooms = {
      'full': 2,
      'half': 1,
    };
    Posting posting2 = Posting(
      name: "Awesome Apartment",
      type: "Apartment",
      price: 100,
      description: "Modern and chic, central location, convenient and close to everything",
      address: "111 West Broadway",
      city: "Vancouver",
      country: "Canada",
      host: user2.createContactFromUser(),
    );
//    posting2.setImages(['assets/images/apartment2.jpg', 'assets/images/apartment2.jpg']);
    posting2.amenities = ['dishwasher', 'Cable', 'WiFi'];
    posting2.beds = {
      'small': 1,
      'medium': 0,
      'large': 1,
    };
    posting2.bathrooms = {
      'full': 1,
      'half': 1,
    };
    postings.add(posting1);
    postings.add(posting2);

    Booking booking1 = Booking();
    booking1.createBooking(
      posting2,
      user1.createContactFromUser(),
      [DateTime(2019, 08, 20),DateTime(2019, 08, 21),DateTime(2019, 08, 22),],
    );
    Booking booking2 = Booking();
    booking2.createBooking(
      posting2,
      user1.createContactFromUser(),
      [DateTime(2019, 10, 10),DateTime(2019, 10, 11),],
    );
    posting2.bookings.add(booking1);
    posting2.bookings.add(booking2);

    Review postingReview = Review();
    postingReview.createReview(
      user2.createContactFromUser(),
      "Pretty decent place, not as big as I was expecting though",
      3.5,
      DateTime(2019, 08, 08),
    );
    posting1.reviews.add(postingReview);

    user1.bookings.add(booking1);
    user1.bookings.add(booking2);
    user1.myPostings.add(posting1);
    user2.myPostings.add(posting2);

    user1.savedPostings.add(posting2);
  }

}