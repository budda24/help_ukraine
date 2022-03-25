import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
admin.initializeApp();

const db = admin.firestore();

const fieldValue = admin.firestore.FieldValue;

// // Start writing Firebase Functions
// // https://firebase.google.com/docs/functions/typescript
//
exports.onNeedCreate = functions.firestore
    .document("NEEDS/{uid}")
    .onCreate(async (snapshot) => {
      const cityData = snapshot.data();
      const cityId = cityData["cityId"];
      await db.collection("STATS").doc("CITY").update( {
        [cityId]: fieldValue.increment(1),
      });

      await db.collection("STATS").doc("ADMIN").update({
        "countNeeds": fieldValue.increment(1),
      });
    });

exports.onNeedDelete = functions.firestore
    .document("NEEDS/{uid}")
    .onDelete(async (snapshot) => {
      const needData = snapshot.data();
      const cityId = needData["cityId"];

      await db.collection("STATS").doc("CITY").update({
        [cityId]: fieldValue.increment(-1),
      });

      await db.collection("STATS").doc("ADMIN").update({
        "countNeeds": fieldValue.increment(-1),
      });
    });

exports.onUserCreate = functions.firestore
    .document("USERS/{uid}")
    .onCreate(async () => {
      await db.collection("STATS").doc("ADMIN").update({
        "countUsers": fieldValue.increment(1),
      });
    });

exports.onUserDelete = functions.firestore
    .document("USERS/{uid}")
    .onDelete(async () => {
      await db.collection("STATS").doc("ADMIN").update({
        "countUsers": fieldValue.increment(-1),
      });
    });


