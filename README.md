# hayao-pacman-repo

hayao個人のpacmanリポジトリのソースです。パッケージは[Kamisato](https://github.com/Hayao0819/Kamisato)のayakaでGitHub Actions上でビルドされ、さくらVPS上のayatoから配信されます。

## リポジトリの追加

`/etc/pacman.conf` に以下を追記すると利用できます。

```ini
[hayao]
SigLevel = Optional TrustAll
Server = https://repo.vps-1.skr.hayao0819.com/repo/hayao/x86_64
```

## パッケージの追加

`hayao/` 直下にpkgbaseと同名のディレクトリを置きます。AURのパッケージはgit submoduleとして取り込みます。

```sh
git submodule add https://aur.archlinux.org/<pkgname> hayao/<pkgname>
```

AUR由来のsubmoduleは毎日の `update.yml` がAUR RPCと照合して自動で追従します。それ以外のパッケージは `PKGBUILD` と `.SRCINFO` をコミットし、upstream追従が必要なら `.nvchecker.toml` を同じディレクトリに置きます。

## ローカルでの更新

`./update.sh` を実行すると `ayaka ci nvcheck` が各パッケージの新版を報告し、`ayaka src pull` がAURミラーをorigin HEADへ進めます。AURサブモジュールは `.nvchecker.toml` なしで自動的にAUR RPCと照合されます(非AURパッケージだけが `.nvchecker.toml` を必要とします)。取り込んだ差分をコミットしてpushすれば `build.yml` がビルドして配信に反映します。

## ビルド

masterへのpushを契機に `build.yml` が差分をビルドしてayatoへpublishします。ローカルでビルドする場合はayakaを入れて `ayaka build hayao` を実行します。
