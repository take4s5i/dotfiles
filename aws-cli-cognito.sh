#!/bin/bash
# aws-cli-cognito - get AWS credentials via Cognito Identity with Cognito User Pool Login

# [config_file]
# path: ~/.config/aws-cli-cognito.json
# you can configure multiple profile
# {
#   "my-profile": {
#     "client_id": "<your cognito user pool client id>",
#     "endpoint": "<your cognito user pool hosted ui endpoint>",
#     "cognito_identity_pool_id": "<your cognito identity pool id",
#     "aws_region": "<taget region>",
#     "cognito_user_pool_id": "<your cognito user pool id>"
#   }
# }

# [Setup]
# 1. put aws-cli-cognito on your $PATH
# 2. create config file
# 3. add aws profile
#   [profile my-profile]
#   credential_process = aws-cli-cognito show_credentials my-profile
# 4. run `aws-cli-cognito login my-profile`

set -uex
cache=~/.config/aws-cli-cognito.cache.json
config=~/.config/aws-cli-cognito.json
export CLIENT_ID=$(jq -r ".$2.client_id" $config)
export ENDPOINT=$(jq -r ".$2.endpoint" $config)
export COGNITO_IDENTITY_POOL_ID=$(jq -r ".$2.cognito_identity_pool_id" $config)
export AWS_REGION=$(jq -r ".$2.aws_region" $config)
export COGNITO_USER_POOL_ID=$(jq -r ".$2.cognito_user_pool_id" $config)

function get_id_token() {
	node --experimental-fetch <<'EOS' | jq -r .id_token
const { createServer } = require('node:http')
const { execSync } = require('node:child_process')
const qs = require('node:querystring')

const port = process.env.PORT || 12345
const clientId = process.env.CLIENT_ID
const endpoint = process.env.ENDPOINT
const callbackUrl = `http://localhost:${port}/callback`

const openLogin = () => {
  const url = new URL('/authorize', endpoint)
  url.searchParams.append('client_id', clientId)
  url.searchParams.append('response_type', 'code')
  url.searchParams.append('scope', 'openid')
  url.searchParams.append('redirect_uri', callbackUrl)
  execSync(`open "${url.href}"`)
}

const getAuthorizationCode = () => {
  return new Promise((resolve, reject) => {
    const server = createServer((req, res) => {
      const url = new URL(req.url, callbackUrl)
      const data = {
        method: req.method,
        url: url.href,
        pathname: url.pathname,
        query: Object.fromEntries(url.searchParams.entries()),
      }

      const code = url.searchParams.get('code')
      if (code) {
        res.statusCode = 200
        res.setHeader('content-type', 'text/html')
        res.write(`
      <!DOCTYPE html>
      <html lang="en">
      <head>
        <meta charset="UTF-8">
        <title>callback</title>
      </head>
      <body>
      ウィンドウを閉じてください
      </body>
      </html>
      `)
        res.end()
        server.close()
        resolve({ code })
      } else {
        res.statusCode = 400
        res.end()
        server.close()
        reject(new Error('cannot get code from callback url query parameter'))
      }
    })

    server.listen(port, () => {
    })
  })
}

const getAccessToken = async (code) => {
  const url = new URL('/oauth2/token', endpoint)
  const res = await fetch(url, {
    method: 'POST',
    headers: {
      'content-type': 'application/x-www-form-urlencoded',
    },
    body: qs.stringify({
      grant_type: 'authorization_code',
      client_id: clientId,
      redirect_uri: callbackUrl,
      code: code,
    }),
  })

  return res.json()
}

const main = async () => {
  openLogin()
  const { code } = await getAuthorizationCode()
  const token = await getAccessToken(code)
  console.log(JSON.stringify(token))
}

main()
.catch(e => {
console.error(e)
process.exit(1)
})
EOS
}

function login() {
	TOKEN=$(get_id_token)
	COGNITO_LOGINS="cognito-idp.ap-northeast-1.amazonaws.com/ap-northeast-1_Xfjc8mIzZ=$TOKEN"
	IDENTITY_ID=$(aws cognito-identity get-id --identity-pool-id $COGNITO_IDENTITY_POOL_ID --logins "$COGNITO_LOGINS" | jq -r .IdentityId)
	aws cognito-identity get-credentials-for-identity --identity-id $IDENTITY_ID --logins "$COGNITO_LOGINS" |
		jq -M '.Credentials | { Version: 1, AccessKeyId: .AccessKeyId, SecretAccessKey: .SecretKey, SessionToken: .SessionToken, Expiration: .Expiration }' >$cache
}

function show_credentials() {
	cat $cache
}

case $1 in
login) login ;;
show_credentials) show_credentials ;;
*) exit 1 ;;
esac
