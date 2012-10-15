# awwbomb Cookbook

## Description
Installs awwbomb. Written for Ubuntu 12.04 (Precise Pangolin).

## Requirements
* Passenger Standalone
* Memcached

## Attributes
| Attribute | Description |
|:-------------|:----------------|
| `node[:awwbomb][:username]` | User to run as |
| `node[:awwbomb][:home]` | User home |
| `node[:awwbomb][:repo]` | URL to awwbomb git repository |
| `node[:awwbomb][:project_home]` | Path to clone awwbomb into |
| `node[:awwbomb][:dependencies]` | System dependencies to install via apt-get |
| `node[:awwbomb][:port]` | Webserver port |
| `node[:awwbomb][:ENV][:CF_USERNAME]` | Cloud Files Username |
| `node[:awwbomb][:ENV][:CF_APIKEY]` | Cloud Files API Key |
| `node[:awwbomb][:ENV][:CF_CONTAINER]` | Cloud Files Container Name |
| `node[:awwbomb][:ENV][:RACK_ENV]` | Environment Type (production, development) |

