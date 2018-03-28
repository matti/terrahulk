# terrahulk

[Terragrunt](https://github.com/gruntwork-io/terragrunt) alternative. Less opinionated and written in shell script.

```
th climb <any terraform command>
  - Finds first terraberg.tf.template and terraberg.auto.tfvars.template files
    from parent dirs. Interpolates and copies them to all subfolders.
  - Runs terraform command in current dir and all sub dirs.
  - Intended use: $ tb climb apply -auto-approve

th fall <any terraform command>
  - Runs terraform command in all subdirs starting from the deepest path
  - Intended use: $ tb fall destroy -force

th clean terrahulk|terraform|state
  - Cleans terrahulk.tf and terrahulk.auto.tfvars, .terraform or local terraform state from sub directories
```

When the `WORKSPACE` environment variable is provided, then Terrahulk will switch to that env in every directory.

## install

```
curl https://raw.githubusercontent.com/matti/terrahulk/master/bin/th > /usr/local/bin/th
chmod +x /usr/local/bin/th
```

## demo

```
$ th climb apply -auto-approve

🐸  terraform apply -auto-approve in /Users/ci/infra
./
./  Apply complete! Resources: 0 added, 0 changed, 0 destroyed.
./
./  Outputs:
./
./  project = root
./  root = run
🐸  terraform apply -auto-approve in /Users/ci/infra/second-a
🐸  terraform apply -auto-approve in /Users/ci/infra/second-b
./second-b
./second-b  Apply complete! Resources: 0 added, 0 changed, 0 destroyed.
./second-b
./second-b  Outputs:
./second-b
./second-b  project = second-b
./second-b  second-b = run
./second-a  null_resource.second_a_first: Refreshing state... (ID: 5498607625708678269)
./second-a  null_resource.second_a_second: Refreshing state... (ID: 2169926884652953485)
./second-a  null_resource.second_a_count[2]: Refreshing state... (ID: 7952674477254858471)
./second-a  null_resource.second_a_count[1]: Refreshing state... (ID: 5612200487324964604)
./second-a  null_resource.second_a_count[0]: Refreshing state... (ID: 1111515596931444191)
./second-a
./second-a  Apply complete! Resources: 0 added, 0 changed, 0 destroyed.
./second-a
./second-a  Outputs:
./second-a
./second-a  project = second-a
./second-a  second-a = run
🐸  terraform apply -auto-approve in /Users/ci/infra/second-a
🐸  terraform apply -auto-approve in /Users/ci/infra/second-b
./second-b
./second-b  Apply complete! Resources: 0 added, 0 changed, 0 destroyed.
./second-b
./second-b  Outputs:
./second-b
./second-b  project = second-b
./second-b  second-b = run
🐸  terraform apply -auto-approve in /Users/ci/infra/second-b/second-b-third-a
🐸  terraform apply -auto-approve in /Users/ci/infra/second-b/second-b-third-b
./second-a  null_resource.second_a_second: Refreshing state... (ID: 2169926884652953485)
./second-a  null_resource.second_a_count[1]: Refreshing state... (ID: 5612200487324964604)
./second-a  null_resource.second_a_count[2]: Refreshing state... (ID: 7952674477254858471)
./second-a  null_resource.second_a_count[0]: Refreshing state... (ID: 1111515596931444191)
./second-a  null_resource.second_a_first: Refreshing state... (ID: 5498607625708678269)
./second-a
./second-a  Apply complete! Resources: 0 added, 0 changed, 0 destroyed.
./second-a
./second-a  Outputs:
./second-a
./second-a  project = second-a
./second-a  second-a = run
./second-b/second-b-third-a
./second-b/second-b-third-a  Apply complete! Resources: 0 added, 0 changed, 0 destroyed.
./second-b/second-b-third-a
./second-b/second-b-third-a  Outputs:
./second-b/second-b-third-a
./second-b/second-b-third-a  project = second-b-third-a
./second-b/second-b-third-a  second-b-third-a = run
./second-b/second-b-third-b
./second-b/second-b-third-b  Apply complete! Resources: 0 added, 0 changed, 0 destroyed.
./second-b/second-b-third-b
./second-b/second-b-third-b  Outputs:
./second-b/second-b-third-b
./second-b/second-b-third-b  project = second-b-third-b
./second-b/second-b-third-b  second-b-third-b = {
./second-b/second-b-third-b    first = 1
./second-b/second-b-third-b    second = 2
./second-b/second-b-third-b  }
🐸  terraform apply -auto-approve in /Users/ci/infra/second-b/second-b-third-a
🐸  terraform apply -auto-approve in /Users/ci/infra/second-b/second-b-third-b
./second-b/second-b-third-a
./second-b/second-b-third-a  Apply complete! Resources: 0 added, 0 changed, 0 destroyed.
./second-b/second-b-third-a
./second-b/second-b-third-a  Outputs:
./second-b/second-b-third-b
./second-b/second-b-third-a
./second-b/second-b-third-a  project = second-b-third-a
./second-b/second-b-third-b  Apply complete! Resources: 0 added, 0 changed, 0 destroyed.
./second-b/second-b-third-a  second-b-third-a = run
./second-b/second-b-third-b
./second-b/second-b-third-b  Outputs:
./second-b/second-b-third-b
./second-b/second-b-third-b  project = second-b-third-b
./second-b/second-b-third-b  second-b-third-b = {
./second-b/second-b-third-b    first = 1
./second-b/second-b-third-b    second = 2
./second-b/second-b-third-b  }
```

```
$ th fall destroy -force

🐸  terraform destroy -force in /Users/ci/infra/second-a
🐸  terraform destroy -force in /Users/ci/infra/second-b/second-b-third-a
🐸  terraform destroy -force in /Users/ci/infra/second-b/second-b-third-b
./second-b/second-b-third-b
./second-b/second-b-third-a
./second-b/second-b-third-b  Destroy complete! Resources: 0 destroyed.
./second-b/second-b-third-a  Destroy complete! Resources: 0 destroyed.
🐸  terraform destroy -force in /Users/ci/infra/second-b
./second-a  null_resource.second_a_count[0]: Refreshing state... (ID: 1111515596931444191)
./second-a  null_resource.second_a_count[2]: Refreshing state... (ID: 7952674477254858471)
./second-a  null_resource.second_a_count[1]: Refreshing state... (ID: 5612200487324964604)
./second-a  null_resource.second_a_second: Refreshing state... (ID: 2169926884652953485)
./second-a  null_resource.second_a_first: Refreshing state... (ID: 5498607625708678269)
./second-a  null_resource.second_a_second: Destroying... (ID: 2169926884652953485)
./second-a  null_resource.second_a_count[2]: Destroying... (ID: 7952674477254858471)
./second-a  null_resource.second_a_count[1]: Destroying... (ID: 5612200487324964604)
./second-a  null_resource.second_a_first: Destroying... (ID: 5498607625708678269)
./second-a  null_resource.second_a_count[0]: Destroying... (ID: 1111515596931444191)
./second-a  null_resource.second_a_count[0]: Destruction complete after 0s
./second-a  null_resource.second_a_second: Destruction complete after 0s
./second-a  null_resource.second_a_count[2]: Destruction complete after 0s
./second-a  null_resource.second_a_first: Destruction complete after 0s
./second-a  null_resource.second_a_count[1]: Destruction complete after 0s
./second-a
./second-a  Destroy complete! Resources: 5 destroyed.
./second-b
./second-b  Destroy complete! Resources: 0 destroyed.
🐸  terraform destroy -force in /Users/ci/infra
./
./  Destroy complete! Resources: 0 destroyed.
```
