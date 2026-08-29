path: vars:
  builtins.replaceStrings
  (map (k: "@${k}@") (builtins.attrNames vars))
  (builtins.attrValues vars)
  (builtins.readFile path)
