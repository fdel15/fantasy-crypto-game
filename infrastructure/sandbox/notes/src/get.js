import handler from "./util/handler"
import dynamoDb from "./util/dynamodb"

export const main = handler(async(event) => {
  const params = {
    TableName: process.env.TABLE_NAME,
    //  Key defines the partition key and sort key of the item to be retrieved
    Key: {
      userId: "123", // the id of the user
      noteId: event.pathParameters.id, // The id of the note from the path
    },
  };

  const result = await dynamoDb.get(params);

  if (!result.Item) {
    throw new Error("item not found.");
  }

  // Return retrieved item
  return result.Item
})