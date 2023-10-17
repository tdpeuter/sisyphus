# Adding SSH keys

To incorporate SSH keys, for instance, to enable authentication with a Git server, follow these steps:

Step 0: If necessary, generate a keypair, for example using the command:

```bash
ssh-keygen -t ed25519
```

Please note that setting a password for the keypair is not yet tested.

Step 1: Create a new file named `yourservice.yaml` within the [secrets](../../../secrets/) directory by executing the following command:

```bash
sops secrets/yourservice.yaml
```

Within this file, create a value that contains your private key. For example:

```yaml
yourservice:
    ssh: |
        -----BEGIN OPENSSH PRIVATE KEY-----
        <...>
        -----END OPENSSH PRIVATE KEY-----
```

Step 2: Reference this value in [your sops configuration](../../utils/sops/default.nix) as follows:

```
sops.secrets."yourservice/ssh".format = "yaml";
sops.secrets."yourservice/sss".sopsFile = secrets/youservice.yaml;
```

Step 3: Finally, add the SSH key to your SSH configuration so that it is used correctly when connecting to your host. Add the following lines to your SSH configuraton file:

```
Host yourservice
    IdentityFile /run/secrets/yourservice/ssh
```
