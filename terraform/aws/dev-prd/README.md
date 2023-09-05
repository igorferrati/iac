### Terraform + Ansible + App Django

Provisionar infra a partir de terraform, configurar, preparar o ambiente e executar app com ansible.

### overview

```
 ── ec2-dev-prd 
    ├── env
    |    └── dev
    |    └── prd
    └── infra
```
* dev - iac configura ambiente para desenvolvimento de app django.
* prd - iac configura ambiente, baixa e executa app a partir de um repo git
* infra - contém os main.tf, variáveis, sg.tf e os hosts usados nos playbooks de dev/prd
---

Login aws cli
```
export AWS_ACCESS_KEY_ID=
export AWS_SECRET_ACCESS_KEY=
```

### DEV

1. Executamos o terraform para criar a infra:
```
cd env/dev
```
```
terraform init
```

```
terraform apply
```
2. Pegamos o output (ip máquina provisionada) e colocamos no hosts

3. Exec o playbook:

```
ansible-playbook env/dev/playbook.yaml -i infra/hosts.yaml -u ubuntu --private-key env/dev/iac-prd
```
* playbook configura o ambiente para desenvolvimento da app.

---
### PRD

1. Executamos o terraform para criar a infra:

```
cd env/prd
```
```
terraform init
```

```
terraform apply
```
2. Pegamos o output (ip máquina provisionada) e colocamos no hosts

3. Exec o playbook:

```
ansible-playbook env/prd/playbook.yaml -i infra/hosts.yaml -u ubuntu --private-key env/prd/iac-prd
```

* Esse playbook baixa a app de um git, configura o ambiente de acordo com o requerements e exercuta a app.
---