Vagrant.configure("2") do |config|
  config.ssh.keep_alive = true

  # config.vm.provision :ansible do |ansible|
  #   ansible.playbook = "provisioning/playbook.yml"
  # end


  # KUBERNETES MASTER NODE
  config.vm.define "kmaster" do |kmaster|
    kmaster.vm.box = "generic/alma9"
    kmaster.vm.box_version = "4.3.12"
    kmaster.vm.network "private_network", ip: "172.16.16.50"
    kmaster.vm.hostname = "kmaster.homecluster.com"
    
    kmaster.vm.provider :libvirt do |lv|
      lv.memory = 2048
      lv.nested = true
      lv.cpus = 1
    end
    # kmaster.vm.provision "shell", path: "scripts/k8s_master_setup.sh"
  end



  # KUBERNETES WORKER NODES

  # use env to se number of node i.e export NODE_COUNT= to set number of node. default is 2
  NodeCount = ENV['NODE_COUNT'] ? ENV['NODE_COUNT'].to_i : 2
  
  (1..NodeCount).each do |i|
    config.vm.define "kworker#{i}" do |workerNode|
      workerNode.vm.box = "generic/alma9"
      workerNode.vm.box_version = "4.3.12"
      workerNode.vm.network "private_network", ip: "172.16.16.5#{i}"
      workerNode.vm.hostname = "kworker#{i}.homecluster.com"

      workerNode.vm.provider :libvirt do |lv|
        lv.memory = 1024
        lv.nested = true
        lv.cpus = 1
      end
      # workerNode.vm.provision "shell", path: "scripts/k8s_worker_setup.sh"
    end
  end
end
