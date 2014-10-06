# Heavy Water Operations opinionated `code_generator` cookbook

This repo contains an opinionated fork of the `code_generator` cookbook which [ships as part of the ChefDK](https://github.com/opscode/chef-dk/tree/master/lib/chef-dk/skeletons/code_generator).

You can use the cookbook in this repo with the `chef generate` command, where NAME is the name of
the cookbook you want to generate, and REPO_PATH is the path to this repository:

```sh
$ chef generate cookbook NAME -g REPO_PATH
```
