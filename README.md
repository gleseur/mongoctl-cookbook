mongoctl-cookbook
=================

Chef cookbook for installing mongoctl (https://github.com/mongolab/mongoctl)

Prerequisite
============

pip should be installed on the machine

attributes
==========
:users => list of users and their configs, you have to specify a name, home and version are optional.
home will default to "/home/:name" and version wil be latest version install.
Default configuration is:
```
default["mongoctl"]["users"] = [{
    "name" => "web",
    "home" => "/home/web",
    "version" => nil
}]
```

