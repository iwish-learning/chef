# See https://docs.getchef.com/config_rb.html for more information on knife configuration options

current_dir = File.dirname(__FILE__)
log_level                :info
log_location             STDOUT
node_name                "dlwang"
client_key               "#{current_dir}/dlwang.pem"
chef_server_url          "https://lp-cn1-wechat-stage.merklechina.com/organizations/lsg"
cookbook_path            ["#{current_dir}/../cookbooks"]
