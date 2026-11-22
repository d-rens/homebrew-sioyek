# homebrew-sioyek

Homebrew tap that builds [sioyek](https://github.com/ahrm/sioyek) from source, tracking the `development` branch.

    brew tap d-rens/sioyek
    brew install --HEAD d-rens/sioyek/sioyek
    ln -sf "$(brew --prefix sioyek)/sioyek.app" /Applications/sioyek.app   # optional

Update with `brew reinstall --HEAD d-rens/sioyek/sioyek`.
