# hestiacp-nodejs-template-maker

## Instalation

***Create all files:***
* First download this Git in your `home` directory and run `chmod +x ./install-nodeapp.sh`, `./install-nodeapp.sh`. The script create and auto install `nodejsXXXX.sh`,  `nodejsXXXX.tpl` and `nodejsXXXX.stpl` 

***Remember:***
* You need install `npm` and `nvm`. 


***Clone and Run the app:***
```
# cd /tmp
# git clone https://github.com/contentful/the-example-app.nodejs.git
# cd the-example-app.nodejs/
# mv .* /home/admin/web/nombre_dominio/nodeapp
# mv * /home/admin/web/nombre_dominio/nodeapp
# cd /home/admin/web/nombre_dominio/nodeapp
# cd ..
# chown -R  admin.admin nodeapp/
# find nodeapp/ -type f -exec chmod 644 {} ";"
# find nodeapp/ -type d -exec chmod 755 {} ";"
# cd nodeapp
# npm install
# npm run start:dev
```

***App running***
* To maintain the app running after close the terminal should be install PM2 `npm i pm2@latest -g`

To install PM2 and use it for a Node.js app, you can follow these steps:

1. Open your terminal.
2. Run the following command to install PM2 globally: `npm install pm2@latest -g`.
3. Navigate to the directory where your Node.js app is located. For example, `cd /path/to/your/app`.
4. Start your Node.js app with PM2 using the following command: `pm2 start app.js` (replace `app.js` with the entry point file of your app).
5. PM2 will automatically manage your app and keep it running in the background. You can view the status of your app by running `pm2 status`.
6. To stop your app, use the command `pm2 stop app`.
7. If you want to restart your app, use `pm2 restart app`.
8. To monitor the logs of your app, you can use `pm2 logs app`.

By using PM2, you can ensure that your Node.js app stays running even after closing the terminal session.

<hr>
Information and tutorial https://help.clouding.io/hc/es/articles/360016993480-C%C3%B3mo-usar-Node-js-en-HestiaCP