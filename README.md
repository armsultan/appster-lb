# Appster Load Balancer

A CICD demo for NGINX Plus **Load Balancing**

## File Structure

```
/
├── etc/
│    ├── nginx/
│    │    ├── conf.d/ # ADD your HTTP/S configurations here
│    │    │   ├── www.appster.com.conf......HTTP www.appster.com Virtual Server configuration
│    │    │   ├── www2.appster.com.conf.....HTTPS www2.appster.com Virtual Server configuration
│    │    │   └── upstreams.conf............Upstream configurations
│    │    │   └── stub_status.conf .........NGINX Open Source basic status information available http://localhost/nginx_status only
│    │    │   └── status_api.conf...........NGINX Plus Live Activity Monitoring available on port 8080 - [Source](https://gist.github.com/nginx-gists/│a51 341a11ff1cf4e94ac359b67f1c4ae)
│    │    ├── includes
│    │    │    ├── add_headers
│    │    │    │   └── security.conf_ ....................Recommended response headers for security
│    │    │    ├── proxy_headers
│    │    │    │   └── load_balancing_algorithms.conf.....Recommended request headers for security and performance
│    │    │    └── ssl
│    │    │        ├── ssl_intermediate.conf.....Recommended SSL configuration for General-purpose servers with a variety of clients, recommended for almost all systems
│    │    │        ├── ssl_a+_strong.conf........Recommended SSL configuration for Based on SSL Labs A+ (https://www.ssllabs.com/ssltest/)
│    │    │        ├── ssl_modern.conf...........Recommended SSL configuration for Modern clients: TLS 1.3 and don't need backward compatibility
│    │    │        └── ssl_old.conf..............Recommended SSL configuration for compatiblity ith a number of very old clients, and should be used only as a last resort
│    │    ├── stream.conf.d/ #ADD your TCP and UDP Stream configurations here
│    │    └── nginx.conf ...............Main NGINX configuration file with global settings
│    └── ssl/
│          ├── nginx/
│          │   ├── nginx-repo.crt........NGINX Plus repository certificate file (**Use your own license**)
│          │   └── nginx-repo.key........NGINX Plus repository key file (**Use your own license**)
│          ├── dhparam_2048.pem..........Diffie-Hellman parameters for testing (2048 bit)
│          ├── dhparam_4096.pem..........Diffie-Hellman parameters for testing (4096 bit)
│          ├── appster.com.crt...........Self-signed wildcard certifcate for testing (*.appster.com)
│          └── appster.com.key...........Self-signed private key for testing
├── usr/
│   └── share/
│        └── nginx/
│              └── html/
│                    └── demo-index.html...Demo HTML webpage with placeholder values
└── var/
     ├── cache/
     │    └── nginx/ # Example NGINX cache path for storing cached content
     └── lib/
          └── nginx/
               └── state/ # The recommended path for storing state files on Linux distributions
```

## Build Docker container

 1. Copy and paste your `nginx-repo.crt` and `nginx-repo.key` into `etc/ssl/nginx` directory



## Demos

### Example 1. Update nginx config

example here

```bash
# This works with both GNU and BSD versions of sed:

# replace iphone 7 image to iphone x
sed -i '' 's/iphone_7.png/iphone_x.png/g' etc/nginx/html/index.html

# replace iphone x image to iphone 7
sed -i '' 's/iphone_x.png/iphone_7.png/g' etc/nginx/html/index.html
```

1. Commit and push changes to code repository:

```bash
git add .; git commit -m "update URL rewrite rule"; git push origin master
```