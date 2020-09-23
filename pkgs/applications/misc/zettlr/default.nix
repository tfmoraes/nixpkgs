{
  lib, fetchFromGitHub, mkYarnPackage, makeWrapper, electron
}:
mkYarnPackage rec {
  pname = "zettlr";
  version = "1.7.5";
  src = fetchFromGitHub{
    owner = "Zettlr";
    repo = "Zettlr";
    rev = "v${version}";
    sha256 = "05m04q0906c3zd6lcdxa6gffxz7m7x2csk4fz60y11ssxcdm3z99";
  };
  # packageJSON = ./package.json;
  # yarnNix = ./zettlr-yarndeps.nix;
  # buildPhase = "PUBLIC_URL=. yarn build";

  nativeBuildInputs = [ makeWrapper ];

  installPhase = ''
    ls -l
    mkdir -p "$out/share"
    cp -r ./deps/zettlr $out/share
    rm -r $out/share/zettlr/node_modules
    cp -r ./node_modules $out/share/zettlr/

    makeWrapper '${electron}/bin/electron' "$out/bin/zettlr" \
      --add-flags "$out/share/zettlr"
  '';

  distPhase = ''
    true
  '';

}
