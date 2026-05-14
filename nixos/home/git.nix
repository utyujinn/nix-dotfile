{config, pkgs, inputs, ...}:
{
  programs.git = {
    enable = true;
    signing.format = null;
    settings.user = {
      name="utyujinn";
      email="hg33fah9@utyujin.com";
    };
  };
}
