include_recipe "firewall"

node["awwbomb"]["open_ports"].each do |open_port|
  firewall_rule open_port do
    port open_port.to_i
    action :allow
  end
end
