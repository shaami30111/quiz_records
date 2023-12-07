import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

admin.initializeApp();

export const setRoleClaimOnAccessRolesChange = functions.firestore.
  document("access_roles/{userId}")
  .onWrite(async (change, context) => {
    try {
      const userId = context.params.userId;
      // Check if the document was deleted
      if (!change.after.exists) {
        console.log("Document was deleted with ID " + userId);
        // await admin.auth().setCustomUserClaims(userId, null);
        await admin.auth().deleteUser(userId);
        return null;
      }
      const accessRoleData = change.after.data();
      if (!accessRoleData || !accessRoleData.role) {
        console.error("Role not found for ID: " + userId);
        return null;
      }

      const userRole = accessRoleData.role;

      // Set custom claim 'role' for the user
      await admin.auth().setCustomUserClaims(userId, {
        role: userRole,
      });

      console.log("Role set for user with ID: " + userId);
      return null;
    } catch (error) {
      console.error("Error:", error);
      return null;
    }
  });
