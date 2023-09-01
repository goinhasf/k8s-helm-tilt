# Local DNS Setup

Warning: This was only tested on macOS.

1. Install dnsmasq
   > `brew install dnsmasq`
2. Create dnsmasq config
   > `mkdir -pv $(brew --prefix)/etc/`
3. Setup domain resolution config
   ```bash
   # This will create a DNS entry that will resolve a domain ending with .test to 127.0.0.1
   # For example: a.cluster.test -> 127.0.0.1
   echo 'address=/.test/127.0.0.1' >> $(brew --prefix)/etc/dnsmasq.conf
   ```
4. Restart service
   > `sudo brew services start dnsmasq`
5. Test DNS lookup of local dnsmasq instance. This command should return an answer with 127.0.0.1 as the IP
   > `dig example.test @127.0.0.1`
6. Create a dns resolver and test setup
   > `sudo mkdir -v /etc/resolver`
7. Add nameserver to systemm's dns resolvers
   > `sudo bash -c 'echo "nameserver 127.0.0.1" > /etc/resolver/test'`
8. Test both of these return the an answer

   > `ping -c 1 another-sub-domain.test`

   > `ping -c 1 apple.com`

# Create a local kubernetes cluster using k3d

1. Run `k3d cluster create --config Cluster.yml`
   - This auto configures the traefik ingress to:
     - Listen on both http and https ports
     - Create a local docker registry to pull images from

# Using Tilt to deploy the app locally

- Run `tilt up` from the root of the project. Tilt will:
   1. Create a local CA and add it your system's trust chain
   2. Create certificate/key pair signed by the local CA
   3. Use that certificate/key pair to enable TLS for the application's ingress
   4. Create a deployment for services `foo` and `bar`

You can access these services via the browser on:

- https://foo.cluster.test
- https://bar.cluster.test
