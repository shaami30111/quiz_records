import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

admin.initializeApp();

export const setRoleClaimOnAccessCreate = functions.firestore
  .document("access_roles/{anyId}")
  .onCreate(async (snapshot, context) => {
    try {
      // const accessId = context.params.anyId;

      // Retrieve data from the new access document
      const newAccessData = snapshot.data();

      if (!newAccessData) {
        console.error("No data for new access ID: ${accessId}");
        return null;
      }

      // Extract the userId and role from the new data
      const userId = newAccessData.userId;
      const userRole = newAccessData.role;

      if (!userId || !userRole) {
        console.error("UserId or Role not found with ID: ${accessId}");
        return null;
      }

      // Set custom claim 'role' for the user
      await admin.auth().setCustomUserClaims(userId, {
        role: userRole,
      });

      console.log("Role set to ${userRole} for ID: ${userId}");
      return null;
    } catch (error) {
      console.error("Error:", error);
      return null;
    }
  });
