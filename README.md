# Python Scripts to Update Avatars

1. **Upload Images to Server**

   Ensure each image is named with the date format (e.g., `2025-01-01.jpg`). Use the following command to upload images to the server:

   ```sh
   scp -r images/ user@server:/path/to/server/images/
   ```

2. **Create Environment File**

   On the Linux server, create a `.env` file with the necessary environment variables.

3. **Run Installation Script**

   Execute the `install.sh` script on the Linux server to set up `avatars.service` and `avatars.timer`

   - **Telegram:**

     ```sh
     echo .env | bash <(wget -qO- https://github.com/wtf403/ava/raw/main/install.sh)
     ```

   - **Twitter:**

     ```sh
     echo .env | bash <(wget -qO- https://github.com/wtf403/ava/raw/main/twitter/install.sh)
     ```

   - **GitHub:**

     ```sh
     echo .env | bash <(wget -qO- https://github.com/wtf403/ava/raw/main/github/install.sh)
     ```
