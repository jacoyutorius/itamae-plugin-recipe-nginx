package "nginx" do
  action :install
end

directory "/var/www/html/" do
  owner "nginx"
  group "nginx"
  action :create
end

file "/var/www/html/index.html" do
  owner "nginx"
  group "nginx"
  action :create
  content "Hello, #{node[:platform]}"
end

template "/etc/nginx/nginx.conf" do
  user "root"
  group "root"
  source "./templates/etc/nginx/nginx.conf.erb"
end

template "/etc/nginx/conf.d/default.conf" do
  user "root"
  group "root"
  source "./templates/etc/nginx/conf.d/default.conf.erb"
  variables(nginx_root_location: "/var/www/html")
end

service "nginx" do
  action [:enable, :start, :reload]
end