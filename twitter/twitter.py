import os
import sys
from dotenv import load_dotenv
import tweepy

load_dotenv()


def change_twitter_avatar(
    consumer_key, consumer_secret, access_token, access_token_secret, avatar_image_path
):
    auth = tweepy.OAuthHandler(consumer_key, consumer_secret)
    auth.set_access_token(access_token, access_token_secret)
    api = tweepy.API(auth)

    if not os.path.exists(avatar_image_path):
        print("Error: Avatar image file not found!")
        return

    try:
        print("Update profile image")
        api.update_profile_image(avatar_image_path)
        print("Twitter avatar updated successfully!")
    except tweepy.TweepError as e:
        print(f"Error: {e.api_code} - {e.reason}")
    except Exception as e:
        print(f"Unexpected error: {e}")


consumer_key = os.getenv("CONSUMER_KEY")
consumer_secret = os.getenv("CONSUMER_SECRET")
access_token = os.getenv("ACCESS_TOKEN")
access_token_secret = os.getenv("ACCESS_TOKEN_SECRET")

if len(sys.argv) < 2:
    print("Usage: python twitter.py <avatar_image_path>")
    sys.exit(1)

avatar_image_path = sys.argv[1]

if __name__ == "__main__":
    change_twitter_avatar(
        consumer_key,
        consumer_secret,
        access_token,
        access_token_secret,
        avatar_image_path,
    )
