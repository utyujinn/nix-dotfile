{config, pkgs, inputs, ...}:
{
  programs.git = {
    enable = true;
    settings.user = {
      name="utyujinn";
      email="hg33fah9@utyujin.com";
    };
  };
}
