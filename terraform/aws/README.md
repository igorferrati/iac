## Terraform and Ansible

* Login aws cli
```
export AWS_ACCESS_KEY_ID=
export AWS_SECRET_ACCESS_KEY=
```

### Folders
---

:file_folder: dev-prd

* Create:

:white_check_mark: launch template

:white_check_mark: security group

:white_check_mark: aws key pair

:white_check_mark: asg

:white_check_mark: lb

:white_check_mark: VPC

:white_check_mark: target group

:white_check_mark: subnets

:white_check_mark: user data -> ansible.sh


```
├── dev-prd 
     |
     ├── env
     |    ├── dev
     |    └── prd
     |
     └── infra
```
---

:file_folder: ec2-basic

---

:file_folder: instance-ec2
