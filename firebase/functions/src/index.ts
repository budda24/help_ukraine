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
      const cityStatsDoc = await db.collection("STATS").doc("CITY").get();
      const cityStatsData = cityStatsDoc.data();
      const newStatsCity = {
        [cityId]: fieldValue.increment(1),
      };

      await db.collection("STATS").doc("CITY").update(newStatsCity);
      console.log(cityStatsData[cityId]);

      const adminStatsDoc = await db.collection("STATS").doc("ADMIN").get();
      const adminStatsData = adminStatsDoc.data();
      const newStatsAdmin = {
        "countNeeds": fieldValue.increment(1),
      };
      await db.collection("STATS").doc("ADMIN").update(newStatsAdmin);
      console.log(adminStatsData["countNeeds"]);
    });

exports.onNeedDelete = functions.firestore
    .document("NEEDS/{uid}")
    .onDelete(async (snapshot) => {
      const needData = snapshot.data();
      const cityId = needData["cityId"];
      const docStats = await db.collection("STATS").doc("CITY").get();
      const dataStats = docStats.data();
      console.log("Got Data");
      console.log(cityId);
      const newStats = {
        [cityId]: fieldValue.increment(-1),
      };
      await db.collection("STATS").doc("CITY").update(newStats);
      console.log("Updated Data");
      console.log(dataStats[cityId]);

      const adminStatsDoc = await db.collection("STATS").doc("ADMIN").get();
      const adminStatsData = adminStatsDoc.data();
      const newStatsAdmin = {
        "countNeeds": fieldValue.increment(-1),
      };
      await db.collection("STATS").doc("ADMIN").update(newStatsAdmin);
      console.log(adminStatsData["countNeeds"]);
    });

exports.onUserCreate = functions.firestore
    .document("USERS/{uid}")
    .onCreate(async () => {
      const newStatsAdmin = {
        "countUsers": fieldValue.increment(1),
      };
      await db.collection("STATS").doc("ADMIN").update(newStatsAdmin);
      console.log("Updated Data");
    });

exports.onUserDelete = functions.firestore
    .document("USERS/{uid}")
    .onDelete(async () => {
      const newStatsAdmin = {
        "countUsers": fieldValue.increment(-1),
      };
      await db.collection("STATS").doc("ADMIN").update(newStatsAdmin);
    });


