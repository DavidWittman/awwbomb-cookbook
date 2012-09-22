# awwbomb Cookbook

## Description
Installs awwbomb. Written for Ubuntu 12.04 (Precise Pangolin).

## Requirements
* Passenger Standalone

## Attributes
| Attribute | Description |
|:-------------|:----------------|
| `node[:awwbomb][:username]` | User to run as |
| `node[:awwbomb][:dependencies]` | System dependencies to install via apt-get |
| `node[:awwbomb][:port]` | Port to bind Passenger Standalone to |
| `node[:awwbomb][:ENV][:CF_USERNAME]` | Cloud Files Username |
| `node[:awwbomb][:ENV][:CF_APIKEY]` | Cloud Files API Key |
| `node[:awwbomb][:ENV][:CF_CONTAINER]` | Cloud Files Container Name |

