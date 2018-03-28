resource "null_resource" "second_a_first" {}
resource "null_resource" "second_a_second" {}

resource "null_resource" "second_a_count" {
  count = 3
}

output "second-a" {
  value = "run"
}
