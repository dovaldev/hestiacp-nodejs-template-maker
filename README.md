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




