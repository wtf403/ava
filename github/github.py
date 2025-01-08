import os
import requests
from dotenv import load_dotenv

load_dotenv()

GITHUB_TOKEN = os.getenv("GITHUB_TOKEN")
IMAGE_PATH = os.getenv("IMAGE_PATH")


def update_github_avatar():
    with open(IMAGE_PATH, "rb") as image_file:
        image_data = image_file.read()

    headers = {
        "Authorization": f"token {GITHUB_TOKEN}",
        "Content-Type": "application/octet-stream",
    }

    response = requests.patch(
        "https://api.github.com/user", headers=headers, data=image_data
    )

    if response.status_code == 200:
        print("GitHub avatar updated successfully.")
    else:
        print(
            f"Failed to update GitHub avatar: {response.status_code} - {response.text}"
        )


if __name__ == "__main__":
    update_github_avatar()
