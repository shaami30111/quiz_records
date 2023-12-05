import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

admin.initializeApp();

export const setRoleClaimOnUserCreate = functions.auth.user()
  .onCreate(async (user) => {
    try {
      const userId = user.uid;
      // Retrieve data from the access_roles
      const accessRoleDoc = await admin.firestore()
        .doc("access_roles/"+userId).get();
      if (!accessRoleDoc.exists) {
        console.error("Access role not found with ID: "+userId);
        return null;
      }
      const accessRoleData = accessRoleDoc.data();
      console.log(accessRoleData);
      if (!accessRoleData) {
        console.error("No data found for document with ID: "+userId);
        return null;
      }
      // Extract the role from the access role data
      const userRole = accessRoleData.role;
      if (!userRole) {
        console.error("Role not found for ID: "+userId);
        return null;
      }
      // Set custom claim 'role' for the user
      await admin.auth().setCustomUserClaims(userId, {
        role: userRole,
      });
      console.log("Role set for user with ID: "+userId);
      return null;
    } catch (error) {
      console.error("Error:", error);
      return null;
    }
  });
