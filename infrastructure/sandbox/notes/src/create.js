import * as uuid from "uuid";
import handler from "./util/handler";
import dynamoDb from "./util/dynamodb";

// noteId":"293594d0-5c4c-11ec-9de0-215b63d97165"
// "userId":"frankie" "noteId":"7e24de80-5c4f-11ec-ac1a-8d3a3a732a28"
export const main = handler(async(event) => {
  // Request body is passed in as a JSON encoded string in 'event.body'
  const data = JSON.parse(event.body)

  const params = {
    TableName: process.env.TABLE_NAME,
    Item: {
      // The attributes of the item to be created
      userId: "1234", // The id of the author
      noteId: uuid.v1(), // A unique uuid
      content: data.content, // Parsed from request body
      attachment: data.attachment, // Parsed from request body
      createdAt: Date.now() // Current Unix timestamp
    }
  };

  await dynamoDb.put(params);

  return params.Item;
})