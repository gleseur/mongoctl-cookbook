## Overview ##
#
# This recipe will
# - install mongoctl through pip
# - for each specified user install the specified version of mongodb
#

python_pip "mongoctl" do
    action :install
    options "--no-deps" if node["mongoctl"]["no-deps"]
end

node["mongoctl"]["users"].each do |user|
    name        = user["name"]
    home        = user["home"] || "/home/#{name}"
    config_dir  = "#{home}/.mongoctl"
    config_file = "#{config_dir}/mongoctl.config"

    # Deploying the mongoctl.config template
    directory config_dir do
        owner name
        group name
        action :create
    end

    template config_file do
        source "config.erb"
        mode 0600
        owner name
        group name
        variables :home => home
    end

    bash "Install mongodb" do
        user name
        group name
        cwd home
        environment "HOME" => home
        code "mongoctl install-mongodb #{user["version"]}"
    end
end
