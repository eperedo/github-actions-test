workflow "Install Dependencies" {
  on = "push"
  resolves = ["Testing"]
}

action "Installing" {
  uses = "actions/npm@59b64a598378f31e49cb76f27d6f3312b582f680"
  runs = "npm install"
}

action "Testing" {
  uses = "actions/npm@59b64a598378f31e49cb76f27d6f3312b582f680"
  runs = "npm test"
  needs = ["Installing"]
}
