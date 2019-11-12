# Install nodejs

## 1. Install nodeJS

```
curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
sudo apt-get install -y nodejs
```

Search on browser URL "https://deb.nodesource.com/setup_`{version}`.x" to get new version

## 2. Install Yarn

```
curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt-get update && sudo apt-get install yarn
```

## 3. Install nodemon

```
sudo npm install -g nodemon
```

Run `nodemon` with `npm`

```
nodemon --exec npm <command>
```

## 4. Install pm2

```
sudo npm install -g pm2
sudo pm2 startup
sudo pm2 save
```

Run `pm2` with `npm`

```
pm2 start [--name app_name] [-i max] npm --- run-script <script>
```
- `[-name app_name]` : Rename `app_name` for app
- `[-i max]` : Run with cluster mode