# homebrew-sioyek

Homebrew tap that builds [sioyek](https://github.com/ahrm/sioyek) from source, tracking the `development` branch.

    brew tap d-rens/sioyek
    brew install d-rens/sioyek/sioyek
    ln -sf "$(brew --prefix sioyek)/sioyek.app" /Applications/sioyek.app   # optional

A GitHub Action bumps the pinned upstream commit every three days, so `brew upgrade` picks up new development commits.
`brew install --HEAD d-rens/sioyek/sioyek` builds the very latest commit instead.
