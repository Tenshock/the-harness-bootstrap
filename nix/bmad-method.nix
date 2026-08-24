{
  lib,
  buildNpmPackage,
  src,
  versionCheckHook,
}:

buildNpmPackage {
  pname = "bmad-method";
  version = "6.11.0";

  inherit src;

  npmDepsHash = "sha256-UhB8E5LNzCqf4iSqF4Mhr+m+vzQKSjZbuBSbKLNSSnI=";

  dontNpmBuild = true;

  doInstallCheck = true;
  nativeInstallCheckInputs = [ versionCheckHook ];

  meta = {
    description = "Agile AI-driven software development method";
    homepage = "https://github.com/bmad-code-org/BMAD-METHOD";
    license = lib.licenses.mit;
    mainProgram = "bmad-method";
    platforms = lib.platforms.all;
  };
}
