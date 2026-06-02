{
  lib,
  stdenvNoCC,
  runCommand,
  fetchurl,
  buildNpmPackage,
  nodejs_24,
  cacert,
  fd,
  ripgrep,
  jq,
}:

let
  pname = "kimi-code";
  version = "0.7.0";

  srcTarball = fetchurl {
    url = "https://registry.npmjs.org/@moonshot-ai/kimi-code/-/kimi-code-${version}.tgz";
    hash = "sha256-O8e2LgxXzEkoryQIJZr8sVlQp273RB4OSK/YOs7ITIc=";
  };

  generatedLock = stdenvNoCC.mkDerivation {
    pname = "${pname}-generated-package-lock";
    inherit version;

    nativeBuildInputs = [
      nodejs_24
      cacert
      jq
    ];

    dontUnpack = true;

    outputHashAlgo = "sha256";
    outputHashMode = "recursive";
    outputHash = "sha256-t+4aN/BF1QF/wWpn7k/7t2KPR52gcwuhRGmahRzTqG8=";

    buildPhase = ''
      runHook preBuild

      export HOME="$TMPDIR"
      export npm_config_cache="$TMPDIR/npm-cache"
      export npm_config_audit=false
      export npm_config_fund=false

      mkdir -p work
      tar -xzf ${srcTarball} -C work --strip-components=1
      cd work

      jq 'del(.devDependencies)' package.json > package.json.new
      mv package.json.new package.json

      npm install \
        --package-lock-only \
        --ignore-scripts \
        --registry=https://registry.npmjs.org \
        --omit=dev

      mkdir -p "$out"
      cp package-lock.json "$out/package-lock.json"
      cp package.json "$out/package.json"

      runHook postBuild
    '';
  };

  srcWithLock =
    runCommand "${pname}-${version}-src-with-lock"
      {
        nativeBuildInputs = [ jq ];
      }
      ''
        mkdir -p "$out"
        tar -xzf ${srcTarball} -C "$out" --strip-components=1

        cd "$out"

        jq 'del(.devDependencies)' package.json > package.json.new
        mv package.json.new package.json

        cp ${generatedLock}/package-lock.json "$out/package-lock.json"
      '';
in

buildNpmPackage {
  inherit pname version;

  src = srcWithLock;

  nodejs = nodejs_24;

  npmDepsHash = "sha256-rpBlTXosXXbKHtRUCcgVg+RPZGKdsDIzLaZOCBYfcbk=";

  dontNpmBuild = true;

  npmInstallFlags = [
    "--ignore-scripts"
    "--omit=dev"
  ];
  npmPackFlags = [ "--ignore-scripts" ];

  postInstall = ''
    wrapProgram $out/bin/kimi \
      --prefix PATH : ${
        lib.makeBinPath [
          fd
          ripgrep
        ]
      }
  '';

  meta = {
    description = "The Starting Point for Next-Gen Agents";
    homepage = "https://github.com/MoonshotAI/kimi-code";
    # changelog = "https://github.com/MoonshotAI/kimi-code/releases";
    license = lib.licenses.mit;
    sourceProvenance = with lib.sourceTypes; [ binaryBytecode ];
    maintainers = with lib.maintainers; [ kwaa ];
    platforms = lib.platforms.all;
    mainProgram = "kimi";
  };
}
