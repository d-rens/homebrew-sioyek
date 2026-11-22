class Sioyek < Formula
  desc "PDF viewer designed for reading research papers and technical books"
  homepage "https://sioyek.info"
  url "https://github.com/ahrm/sioyek.git", branch: "development", submodules: true
  version "development"
  license "GPL-3.0-or-later"
  head "https://github.com/ahrm/sioyek.git", branch: "development", submodules: true

  depends_on "pkgconf" => :build
  depends_on :macos
  depends_on "qt5compat"
  depends_on "qtbase"
  depends_on "qtdeclarative"
  depends_on "qtspeech"
  depends_on "qtsvg"

  conflicts_with cask: "sioyek", because: "both install a `sioyek` executable"

  def install
    system "make", "-C", "mupdf", "HAVE_GLUT=no", "-j#{ENV.make_jobs}"

    inreplace "pdf_viewer_build_config.pro",
              /QMAKE_MACOSX_DEPLOYMENT_TARGET\s*=\s*\d+/,
              "QMAKE_MACOSX_DEPLOYMENT_TARGET = #{MacOS.version.major}"

    system "qmake", "CONFIG+=non_portable", "pdf_viewer_build_config.pro"
    system "make", "-j#{ENV.make_jobs}"

    app = prefix/"sioyek.app"
    cp_r "sioyek.app", app
    resources = app/"Contents/Resources"
    cp_r "pdf_viewer/shaders", resources/"shaders"
    cp %w[prefs.config prefs_user.config keys.config keys_user.config].map { |f| "pdf_viewer/#{f}" }, resources
    cp "tutorial.pdf", resources

    bin.install_symlink app/"Contents/MacOS/sioyek"
  end

  def caveats
    <<~EOS
      Sioyek.app is installed in:
        #{opt_prefix}/sioyek.app
      To make it visible to Spotlight/Launchpad:
        ln -sf #{opt_prefix}/sioyek.app /Applications/sioyek.app
    EOS
  end

  test do
    assert_match "sioyek", shell_output("#{bin}/sioyek --version").downcase
  end
end
