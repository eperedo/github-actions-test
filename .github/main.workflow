workflow "Install, Test and Deploy" {
  on = "push"
  resolves = ["Publish"]
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

action "Publish" {
  uses = "netlify/actions/build@master"
  needs = ["Testing"]
  secrets = ["GITHUB_TOKEN", "NETLIFY_SITE_ID"]
  env = {
    NETLIFY_DIR = "public"
  }  
}
