{
  pkgs,
  userTheme,
  ...
}: let
in {
  programs.bash = {
    enable = true;
    shellAliases = {
      ll = "ls -lah";
      k = "kubectl";
      kctx = "kubectl config current-context";
      kunset = "kubectl config unset current-context";
    };
    initExtra = ''
      export PATH="$HOME/.local/bin:$PATH"
      export EDITOR=nvim
      eval "$(zoxide init bash)"
      eval "$(direnv hook bash)"
    '';
  };
}
