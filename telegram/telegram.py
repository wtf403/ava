import os
import sys
from telethon import TelegramClient, functions, types
from dotenv import load_dotenv

load_dotenv()

api_id = os.getenv("API_ID")
api_hash = os.getenv("API_HASH")
phone_number = os.getenv("PHONE_NUMBER")

client = TelegramClient("wtf403", api_id, api_hash)

async def main():
    try:
        await client.start(phone=phone_number)

        if len(sys.argv) < 2:
            raise ValueError("Please provide the image file path as an argument.")

        image_path = sys.argv[1]

        if not os.path.isfile(image_path):
            raise FileNotFoundError(f"The file {image_path} does not exist.")

        current_photos = await client(
            functions.photos.GetUserPhotosRequest(
                user_id="me",
                offset=0,
                max_id=0,
                limit=3,
            )
        )

        if len(current_photos.photos) > 1:
            photo = current_photos.photos[0]
            await client(
                functions.photos.DeletePhotosRequest(
                    id=[
                        types.InputPhoto(
                            id=photo.id,
                            access_hash=photo.access_hash,
                            file_reference=photo.file_reference,
                        )
                    ]
                )
            )
            print(f"Previous profile photo deleted: {photo.id}")

        file = await client.upload_file(image_path)
        await client(functions.photos.UploadProfilePhotoRequest(file=file))
        print(f"Profile photo updated successfully: {image_path}")

    except Exception as e:
        print(f"Failed to update profile photo: {e}")


if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: python telegram.py <avatar_image_path>")
        sys.exit(1)

    avatar_image_path = sys.argv[1]

    with client:
        client.loop.run_until_complete(main(avatar_image_path))
