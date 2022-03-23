import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
admin.initializeApp();

const db = admin.firestore();


// // Start writing Firebase Functions
// // https://firebase.google.com/docs/functions/typescript
//
exports.onCustomerCreate = functions.firestore
    .document("NEEDS/{uid}")
    .onCreate(async (snapshot, context) => {
      const needId = snapshot.id;
      const docStats = await db.collection("STATS").doc("CITY").get();
      const dataStats = docStats.data();
      console.log(dataStats[needId]);
    });

