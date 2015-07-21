server {

        listen 80;
        server_name simplifychaosdesign.com www.simplifychaosdesign.com;


        access_log /srv/www/simplifychaosdesign.com/logs/access.log;
        error_log /srv/www/simplifychaosdesign.com/logs/error.log;

       

        root /srv/www/simplifychaosdesign.com/public;
        index index.php index.html index.htm;

    

        rewrite_log on;

        include /etc/nginx/scripts.d/*.conf;

}
