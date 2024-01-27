{ pkgs }:
pkgs.stdenv.mkDerivation rec {
  pname = "hello";
  version = "2.11";

  src = pkgs.fetchurl {
    url = "mirror://gnu/hello/${pname}-${version}.tar.gz";
    sha256 = "sha256-jJzgVy08RO0GcOsc3pgFhOA4tvYsJf396O8SjeFQBL0=";
  };

  meta = with pkgs.lib; {
    description = "A program that produces a familiar, friendly greeting";
    longDescription = ''
      GNU Hello is a program that prints "Hello, world!" when you run it.
      It is fully customizable.
    '';
    homepage = "https://www.gnu.org/software/hello/manual/";
    changelog =
      "https://git.savannah.gnu.org/cgit/hello.git/plain/NEWS?h=v${version}";
    license = licenses.gpl3Plus;
    maintainers = [ maintainers.eelco ];
    platforms = platforms.all;
  };
}
