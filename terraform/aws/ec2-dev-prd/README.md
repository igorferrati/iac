### Terraform + Ansible + App Django


### DEV

1. Executamos o terraform para criar a infra:

```
cd env/prd
```

```
terraform apply
```
2. Pegamos o output (ip máquina provisionada) e colocamos no host

3. Exec o playbook do ansible para config na máquina:

```
ansible-playbook env/prd/playbook.yaml -i infra/hosts.yaml -u ubuntu --private-key env/prd/iac-prd
```

* Esse playbook configura e baixa de um repo git a app pronta para máquina criada com terraform.