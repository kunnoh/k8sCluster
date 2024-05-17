Vagrant.configure("2") do |config|
  # config.ssh.keep_alive = true

  # config.vm.provision :ansible do |ansible|
  #   ansible.playbook = "provisioning/playbook.yml"
  # end

  # Kubernetes master node
  config.vm.define "kmaster" do |kmaster|
    kmaster.vm.box = "generic/alma9"
    kmaster.vm.box_version = "4.3.12"
    kmaster.vm.network "private_network", ip: "172.16.16.50"
    kmaster.vm.hostname = "kmaster.example.com"
    
    kmaster.vm.provider :libvirt do |lv|
      lv.memory = 2048
      lv.nested = true
      lv.cpus = 1
    end
  end

  # Kubernetes worker nodes
  NodeCount = 2
  (1..NodeCount).each do |i|
    config.vm.define "kworker#{i}" do |workerNode|
      workerNode.vm.box = "generic/alma9"
      workerNode.vm.box_version = "4.3.12"
      workerNode.vm.network "private_network", ip: "172.16.16.5#{i}"
      workerNode.vm.hostname = "kworker#{i}.example.com"

      workerNode.vm.provider :libvirt do |lv|
        lv.memory = 1024
        lv.nested = true
        lv.cpus = 1
      end
    end   
  end
end
