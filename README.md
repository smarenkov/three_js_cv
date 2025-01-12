# Three.js portfolio

> A simple Vue.js project that use Three.js to showcase your portfolio with interactive 3D elements.

## Getting started

Follow these steps to set up, configure, and deploy project.

### Environment Setup

1. Duplicate the `.env.example` file:
```bash
cp .env.example .env
```

2. Fill out all required environment variables in the `.env` file.


### Configure Nginx

1. Create an Nginx configuration file for your domain at `/etc/nginx/sites-available/{your_domain}`:
```conf
server {
    listen 80;
    server_name your_domain #example cv.smarenkov.dev;

    root            /usr/share/nginx/html/portfolio;  # NGINX_HTML_DIRECTORY from your .env
    index           index.html;

    location / {
            try_files $uri $uri/ /index.html;
    }
}
```

2. Create a symbolic link to enable the site:
```bash
ln -s /etc/nginx/sites-enabled/{your_domain} /etc/nginx/sites-available/{your_domain}
```

3. Restart Nginx to apply the changes:
```bash
sudo systemctl restart nginx
```

### Deployment

To deploy the project, execute the provided deployment script:
```bash
sh ./deploy.sh
```

## Additional Notes
• Ensure the `NGINX_HTML_DIRECTORY` in your `.env` file matches the correct path.

• For HTTPS support, set up SSL/TLS certificates using a tool like [Certbot](https://certbot.eff.org/).