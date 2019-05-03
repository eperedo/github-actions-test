workflow "Install, Test and Deploy" {
  on = "push"
  resolves = ["Publish to netlify"]
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

action "Publish to netlify" {
  uses = "actions/npm@59b64a598378f31e49cb76f27d6f3312b582f680"
  needs = ["Testing"]
  runs = "npm run build"
  secrets = ["NETLIFY_AUTH_TOKEN", "NETLIFY_SITE_ID"]
}
