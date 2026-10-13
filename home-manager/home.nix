{ homeUser, config, pkgs, lib, ... }:

let
  isLinux = pkgs.stdenv.hostPlatform.isLinux;

  # Neovim 0.11.1 desde GitHub
  neovim_0111 = pkgs.neovim.overrideAttrs (old: rec {
    pname = "neovim";
    version = "0.11.1";

    src = pkgs.fetchFromGitHub {
      owner = "neovim";
      repo = "neovim";
      rev = "v${version}";
      sha256 = "sha256-NgZkk3CVxb1oEqUPxjILRYFVZJ2XlM++FoqmgTn9TBg=";
    };
  });
in

{
  home.username = homeUser;

  home.homeDirectory = (
    if isLinux
    then "/home/${config.home.username}"
    else "/Users/${config.home.username}"
  );

  home.stateVersion = "24.11";

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  home.shellAliases = {
    vi = "nvim";
    vim = "nvim";
    lg = "lazygit";
    ld = "lazydocker";
  };

  home.packages = with pkgs; [
    # Cloud
    awscli2

    # Git
    lazygit
    gh

    # Contenedores
    docker
    docker-compose
    lazydocker
    podman

    # Bases de datos
    jetbrains.datagrip
    dbeaver-bin

    # Desarrollo
    pnpm
    nixfmt-rfc-style
    vscode
    neovim_0111
    luajit
    luarocks

    # Terminal
    tmux
    yazi
    unzip

    # Fuentes
    nerd-fonts.jetbrains-mono
  ];

  home.file = { };

  services.podman = lib.mkIf isLinux {
    enable = true;
  };

  programs.home-manager.enable = true;

  programs.direnv.enable = true;

  programs.bash = {
    enable = true;
    enableCompletion = true;
  };

  programs.starship.enable = true;
  programs.zoxide.enable = true;

  programs.keychain = {
    enable = true;
    keys = [ "id_ed25519" ];
  };

  programs.git = {
    enable = true;
    userName = "${GIT_USER}";
    userEmail = "${GIT_EMAIL}";

    extraConfig = {
      commit.gpgsign = true;
      gpg.format = "ssh";
      user.signingkey = "$SSH_PUB_KEY";
    };

    aliases = {
      "subup" = "submodule update --init --recursive";
      "co" = "checkout";
      "cob" = "checkout -b";
      "br" = "branch";
      "st" = "status";
      "cm" = "commit -m";
      "amend" = "commit --amend -m";
      "po" = "push origin";
      "cp" = "cherry-pick";
      "rmcache" = "rm -rf --cached .";

      "gone" = "! git fetch -p && git for-each-ref --format '%(refname:short) %(upstream:track)' | awk '$2 == \"[gone]\" {print $1}' | xargs -r git branch -D";
    };
  };
}
