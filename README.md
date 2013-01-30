# awwbomb Cookbook

## Description
Installs awwbomb. Written for Ubuntu 12.04 (Precise Pangolin).

## Requirements
* Passenger Standalone
* [Firewall cookbook](https://github.com/opscode-cookbooks/firewall)

## Databag
It is recommended to store your CloudFiles API key in an encrypted data bag; however, this is optional.
If you choose to use a databag, make sure to use the `node[:awwbomb][:databag]` and `node[:awwbomb][:databag_item]`
attributes.

## Attributes
| Attribute | Description |
|:-------------|:----------------|
| `node[:awwbomb][:databag]` | Name of databag |
| `node[:awwbomb][:databag_item` | Name of databag item |
| `node[:awwbomb][:username]` | User to run as |
| `node[:awwbomb][:dependencies]` | System dependencies to install via apt-get |
| `node[:awwbomb][:port]` | Port to bind Passenger Standalone to |
| `node[:awwbomb][:ENV][:CF_USERNAME]` | Cloud Files Username |
| `node[:awwbomb][:ENV][:CF_APIKEY]` | Cloud Files API Key |
| `node[:awwbomb][:ENV][:CF_CONTAINER]` | Cloud Files Container Name |

