import 'package:polymer/polymer.dart';
import 'dart:html';
import 'dart:async';
import 'dart:math';
import '../../src/app.dart';
import '../../src/input_formatter.dart';
import 'package:firebase/firebase.dart' as db;

@CustomTag('item-activities')
class ItemActivities extends PolymerElement {
  @published App app;
  @observable List comments = toObservable([]);

//  InputElement get name => $['name'];
//  InputElement get comment => $['comment'];

  get formattedDate {
//    if (app.selectedItem == null) return '';
//    return InputFormatter.formatMomentDate(app.selectedItem['createdDate'], short: true, momentsAgo: true);
  }

  getActivities() {
    if (app.selectedItem == null) return;
    print("Got here");

    var itemId = app.selectedItem['id'];
    var f = new db.Firebase('https://luminous-fire-4671.firebaseio.com/items/' + itemId + '/activities/comments');
    f.onChildAdded.listen((e) {
      var comment = e.snapshot.val();
      comment['createdDate'] = DateTime.parse(comment['createdDate']);

      comment['id'] = e.snapshot.name();

      // Insert each new item at top of list so the list is ascending
      comments.insert(0, comment);
    });
  }

  // *
  // Add a comment to /activities/comments for this item.
  // *
//  addComment(Event e, var detail, Element target) {
//    e.preventDefault();
//
//    if (name.value.trim().isEmpty) {
//      window.alert("Your name is empty.");
//      return false;
//    }
//
//    var itemId = app.selectedItem['id'];
//
//    final comments = new db.Firebase('https://luminous-fire-4671.firebaseio.com/items/' + itemId + '/activities/comments');
//
//    DateTime now = new DateTime.now().toUtc();
//
//    Future set(db.Firebase comments) {
//      comments.push().set({
//          'user': name.value,
//          'comment': comment.value,
//          'createdDate': '$now'
//      }).then((e){print('Commented: ' + comment.value);});
//    }
//
//    set(comments);
//  }

  attached() {
    print("+ItemActivities");
    getActivities();
  }

  ItemActivities.created() : super.created();
}