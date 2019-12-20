# Install GitLab on Ubuntu with Apache

## 1. Install package

```
apt-get install curl openssh-server ca-certificates postfix
```

## 2. Download GitLab

```
curl https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.deb.sh | sudo bash
```

## 3. Install GitLab

```
apt-get install gitlab-ce
```

Installing gitlab manually on our server gives us the power to switch the default nginx server it was configured to use.

## 4. Config domain for GitLab

```
vi /etc/gitlab/gitlab.rb
```

Edit domain:

```
external_url "http://<yourdomain>"
letsencrypt['enable'] = true
letsencrypt['contact_emails'] = ['sammy@yourdomain.com']
```

Save configuration

## 5. Run initalize

```
gitlab-ctl reconfigure
```

## 6. Apache module required

```
a2enmod proxy_http
a2enmod rewrite
a2enmod ssl
a2enmod headers
```

## 7. Change config GitLab for Apache

```
vi /etc/gitlab/gitlab.rb
```

Recommented config

```
external_url "http://<yourdomain>"

# Disable nginx
nginx['enable'] = false

# Give apache user privileges to listen to gitLab
web_server['external_users'] = ['www-data']
```

## 8. Config VirtualHost for domain

```
<VirtualHost *:80>
  ServerName <your_domain_or_sub_domain>
  ServerSignature Off

  ProxyPreserveHost On
  AllowEncodedSlashes NoDecode

  <Location />
    Require all granted
    ProxyPassReverse http://127.0.0.1:8080
    ProxyPassReverse <your_domain_or_sub_domain>
  </Location>

  RewriteEngine on
  RewriteCond %{DOCUMENT_ROOT}/%{REQUEST_FILENAME} !-f
  RewriteRule .* http://127.0.0.1:8080%{REQUEST_URI} [P,QSA]

  # needed for downloading attachments
  DocumentRoot /opt/gitlab/embedded/service/gitlab-rails/public

  #Set up apache error documents, if back end goes down (i.e. 503 error) then a maintenance/deploy page is thrown up.
  ErrorDocument 404 /404.html
  ErrorDocument 422 /422.html
  ErrorDocument 500 /500.html
  ErrorDocument 503 /deploy.html

  LogFormat "%{X-Forwarded-For}i %l %u %t \"%r\" %>s %b" common_forwarded
  ErrorLog  /var/log/httpd/logs/<your_domain_or_sub_domain>_error.log
  CustomLog /var/log/httpd/logs/<your_domain_or_sub_domain>_forwarded.log common_forwarded
  CustomLog /var/log/httpd/logs/<your_domain_or_sub_domain>_access.log combined env=!dontlog
  CustomLog /var/log/httpd/logs/<your_domain_or_sub_domain>.log combined

</VirtualHost>
```

===============================================================================================

## 9. Default user

```
root
```

## 10. Reset default root password

```
gitlab-rails console or sudo gitlab-rake rails console
```

Search

```
user = User.find_by(email: ‘admin@local.host’) or user = User.find(1)
```

Change password

```
# create new password
user.password = 'secret_pass'

# confirm password
user.password_confirmation = 'secret_pass'

# save user password
user.save

# quit
quit
```

## 11. Configure push and pull on server repositories

In a situation where no user is allowed to pull or push to any repository.

```
vi /etc/gitlab/gitlab.rb
```

Edit the following lines to reflect the changes below

```
gitlab_workhorse['enable'] = true
gitlab_workhorse['listen_network'] = "tcp"
gitlab_workhorse['listen_addr'] = "localhost:8282"
```

After saving the config file, reconfigure the gitlab server using

```
gitlab-ctl reconfigure
```

Modify gitlab config file to reflect update

```
RewriteRule /[-\/\w\.]+\.git\/ http://127.0.0.1:8282%{REQUEST_URI} [P,QSA,L]
```

## 12. Disable register

Access to Dashboard on browser

Navigate to Admin area by clicking the Spanner icon. Click to `Settings`

Expand `Sign-up restrictions`

Uncheck `Sign-up enabled` button to disable User registration on GitLab welcome page

===============================================================================================

## 13. Error ENOMEM

Upgrade RAM Server or swap to run