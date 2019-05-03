workflow "Install, Test and Deploy" {
  on = "push"
  resolves = ["Send SMS"]
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

action "Send SMS" {
  uses = "swinton/httpie.action@8ab0a0e926d091e0444fcacd5eb679d2e2d4ab3d"
  needs = ["Publish to netlify"]
  args = ["POST", "https://api.twilio.com/2010-04-01/Accounts/$ACCOUNT_SID/Messages.json", "Authorization:`Basic $TWILIO_ENCODE`", "body=Deployment-Ready:$GITHUB_REPOSITORY", "to=+51966528536", "from=+14694252086"]
  secrets = [
    "ACCOUNT_SID",
    "TWILIO_ENCODE",
  ]
}
