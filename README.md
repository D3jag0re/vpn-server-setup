# VPN Server Setup


This is based off the DevOps Roadmap Project [VPN Server Setup](https://roadmap.sh/projects/vpn-server-setup)

Set up a WireGuard or OpenVPN server to secure remote access.

This is an intermediate [DevOps Project](https://roadmap.sh/devops/projects) as per roadmap.sh

## Description From Site 

The goal of this project is to set up your own VPN server to secure your internet traffic when on untrusted networks (like public WiFi) and to access your private network remotely. You will configure a VPN server using either WireGuard (modern and simple) or OpenVPN (widely compatible), and connect to it from your devices.

## Prerequisites 

Before starting this project, you should have:

- A Linux server with a public IP address (VPS from any cloud provider)

- Basic Linux command-line skills

- Firewall configured (UFW or iptables)

- Understanding of basic networking concepts (IP addresses, ports, routing)


## Requirements

Choose one of the following VPN solutions and complete the setup:

`Option 1: WireGuard (Recommended)`

WireGuard is a modern, fast, and simple VPN protocol built into the Linux kernel.

- Install WireGuard on your server

- Generate server and client key pairs (public and private keys)

- Configure the WireGuard interface (wg0.conf) with appropriate IP ranges

- Enable IP forwarding and configure NAT rules for traffic routing

- Open the WireGuard port (default: 51820/UDP) in your firewall

- Start and enable the WireGuard service

- Create client configuration files for your devices

`Option 2: OpenVPN`

OpenVPN is a mature, widely-supported VPN solution with broad client compatibility.

- Install OpenVPN and Easy-RSA on your server

- Set up a Certificate Authority (CA) and generate server certificates

- Configure the OpenVPN server (server.conf)

- Enable IP forwarding and configure NAT rules

- Open the OpenVPN port (default: 1194/UDP) in your firewall

- Generate client certificates and create .ovpn configuration files

`After Server Setup (Both Options)`

- Install the VPN client on your phone, laptop, or other devices

- Import the client configuration and connect to your VPN server

- Verify your traffic is routed through the VPN (check your public IP)

- Test DNS resolution to ensure there are no DNS leaks

- Add multiple client configurations (e.g., phone, laptop, tablet)

### Learning Outcomes

After completing this project, you will understand how VPNs work at a technical level, including tunneling, encryption, and traffic routing. You will be able to secure your internet traffic on untrusted networks and access your private resources remotely. These skills are valuable for personal security, remote work scenarios, and managing secure connections to cloud infrastructure.


### Stretch Goals


- Configure split tunneling to only route specific traffic through the VPN

- Set up a Pi-hole or AdGuard alongside your VPN for ad-blocking

- Configure automatic connection on untrusted networks

- Set up monitoring to track connected clients and bandwidth usage

## prerequisites

- Setup the following repository secrets:
    - DO_TOKEN : Digital Ocean access token
    - DO_SPACES_SECRET_KEY : Digital Ocean spaces secret key (for Terraform state file)
    - DO_SPACES_ACCESS_KEY : Digital Ocean spaces access key (for Terraform state file)
    - DO_SSH_PUBLIC_KEY : Keypair to be used for Private VM 
    - DO_SSH_PRIVATE_KEY : Keypair to be used for Private VM

## To Run  

- (blank)


## Notes 

- (blank)

## Lessons Learned

- (blank)

## How To Test The VPN

After the deploy workflow completes successfully, download the `wireguard-client-config` artifact from the GitHub Actions run. Install the WireGuard client on the device you want to test with, then import the generated `.conf` file and activate the tunnel.

### Basic Validation

- Confirm the WireGuard client shows a recent handshake and transfer activity after connecting.
- Visit `https://ifconfig.me` or `https://icanhazip.com` before connecting and note your public IP.
- Connect to the VPN and check the same site again. The IP should now match your VPN droplet's public IP.
- Browse a few websites or run `curl ifconfig.me` while connected to confirm traffic continues to route through the VPN.

### DNS Leak Test

- While connected to the VPN, open `https://dnsleaktest.com`.
- Run a standard or extended test.
- Confirm the reported DNS servers match the resolver configured in your WireGuard client profile and do not expose your local network or ISP DNS.

### Server-Side Verification

SSH to the server and run:

```bash
sudo wg show
```

You should see:

- the client peer listed
- a recent `latest handshake`
- increasing transfer counters for `received` and `sent`

You can also confirm IP forwarding is enabled:

```bash
sysctl net.ipv4.ip_forward
```

It should return `net.ipv4.ip_forward = 1`.

### Recommended Real-World Test

- Connect your laptop or phone to a different network such as a mobile hotspot or public Wi-Fi.
- Turn on the WireGuard tunnel.
- Confirm your public IP changes to the droplet IP.
- Verify normal web browsing works.
- Run `sudo wg show` on the server and confirm handshake and traffic counters increase while you use the connection.
