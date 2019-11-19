# scaffold for Nix based interactive Haskell project with Hadui

> Pro-tips: prepare a separate volume and mount to `/nix`, then:

[Install Nix](https://nixos.org/nix/download.html)

```shell
curl -L https://github.com/complyue/hadui-demo-nix/archive/master.tar.gz | tar tzf -
mv hadui-demo-nix-master my-awsome-project
cd my-awsome-project
nix-shell --run hadui-dev
```
