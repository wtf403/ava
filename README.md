# Ava

Collection of scripts for different socials to update avatars daily

1. **Upload Images to Server**

   Ensure each image is named with the date format (e.g. `12-01-2025.jpg`). You can use the following command to upload image folder to the server:

   ```sh
   scp -r images/ user@server:/path/to/server/images/
   ```

2. **Create Environment File**

   On the Linux server, create a `.env` file with the necessary environment variables. You can find .env.example file for each social in corresponding folder

3. **Run Installation Script**

   Execute the `install.sh` script on the Linux server to set up `avatars.service` and `avatars.timer`. Script also will run the binary with `test.jpg` image to generate `.session` file

   - **Telegram:**

     ```sh
     cat .env | bash <(wget -qO- https://github.com/wtf403/ava/raw/main/telegram/install.sh)
     ```

   - **Twitter:**

     ```sh
     cat .env | bash <(wget -qO- https://github.com/wtf403/ava/raw/main/twitter/install.sh)
     ```

   - **GitHub:**

     ```sh
     cat .env | bash <(wget -qO- https://github.com/wtf403/ava/raw/main/github/install.sh)
     ```
