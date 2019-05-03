workflow "Install Dependencies" {
  on = "push"
  resolves = ["Testing"]
}

action "GitHub Action for npm" {
  uses = "actions/npm@59b64a598378f31e49cb76f27d6f3312b582f680"
  runs = "npm install"
}

workflow "New workflow" {
  on = "push"
}

action "Testing" {
  uses = "actions/npm@59b64a598378f31e49cb76f27d6f3312b582f680"
  needs = ["GitHub Action for npm"]
  runs = "npm test"
}
