workflow "Build" {
  on = "push"
  resolves = ["Build Image"]
}

action "Build Image" {
  uses = "actions/docker/cli@8cdf801b322af5f369e00d85e9cf3a7122f49108"
  args = "build --pull -t phlak/minecraft:test ."
}
