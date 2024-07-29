set PNPM_RUN_PROGNAME nr

function __print_npm_scripts -d "print scripts from package.json"
  # do nothing if package.json doesn't exist
  if ! test -r package.json
      return
  end

  node -e 'console.log(Object.keys(require("./package.json").scripts).sort().join("\n"))'
end

complete -c $PNPM_RUN_PROGNAME -xa "(__print_npm_scripts)"
