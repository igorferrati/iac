cd /home/ubuntu

#install pip and ansible
curl https://bootstrap.pypa.io/get-pip.py -o get-pip-py
sudo python3 get-pip.py
sudo python3 -m pip install ansible
#criando arq
tee -a playbook.yml > /dev/null <<EOT
- hosts: localhost
  tasks:
  - name: install python 3 and virtualenv
    apt: 
      pkg: 
      - python3
      - virtualenv
      update_cache: yes
      become: yes
  - name: git clone
    ansible.builtin.git: 
      repo: https://github.com/igorferrati/api-clientes-django/tree/main
      dest: /home/ubuntu/projects/
      version: main
      force: yes
  - name: install dependencies pip
    pip:
      virtualenv: /home/ubuntu/projects/venv
      requeriments: /home/ubuntu/projects/requeriments.txt
  - name: config hosts settings
    lineinfile:
      path: /home/ubuntu/projects/setup/settings.py
      regexp: 'ALLOWED_HOSTS'
      line: 'ALLOWED_HOSTS = ["*"]'
      backrefs: yes   #caso não encontre o allowed_hosts não faça nada
  - name: setup database
    shell: '. /home/ubuntu/projects/env/bin/activate; python /home/ubuntu/projects/manage.py migrate'
  - name: database init
    shell: '. /home/ubuntu/projects/env/bin/activate; python /home/ubuntu/projects/manage.py loaddata clientes.json'
  - name: init server
    shell: '. /home/ubuntu/projects/env/bin/activate; nohup python /home/ubuntu/projects/manage.py runserver 0.0.0.0:8000 &'
EOT
ansible-playbook playbook.yml
