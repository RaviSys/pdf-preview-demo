# README

## Development Setup

Prerequisites:

- PostgreSQL
- Bundler
- Node(>= 11.x)
- Yarn
- Ruby(2.7.1)
- Rails(>=6)

```sh
bundle install
yarn install
```
Now you need to setup the database. And you need to run following commands but before running them you need to change the values of username and password of your pg inside 
```sh
config/database.yml
```
Once changed, run following commands:

```sh
rails db:create
rails data:migrate
```

Now you are all set. Run following command on your terminal:

```sh
rails server 
```
To render css and js assets faster open another tab and run following command:

```sh
./bin/webpack-dev-server
```

open browser at: [http://localhost:3000](http://localhost:3000).

##WARNING: Minimagic Auth Error While Creating Preview

You might get following error while creating preview images of pdf pages.

```sh
MiniMagick::Invalid (`identify /tmp/mini_magick20210515-8656-tjz3ib` failed with error:
identify-im6.q16: not authorized `/tmp/mini_magick20210515-8656-tjz3ib' @ error/constitute.c/ReadImage/412.
):
```

Run following command on terminal:

```sh
sudo subl /etc/ImageMagick-6/policy.xml
```

and find following line into the file opened:

```sh
<policy domain="coder" rights="none" pattern="PDF" />

```
and replace with following line:

```sh
<policy domain="coder" rights="read | write" pattern="PDF" />

```

Now you done completely.

Cheers!!
