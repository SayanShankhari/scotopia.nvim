# Contributing to scotopia.nvim

First off, thank you for considering contributing to `scotopia.nvim`!
It's contributions like yours that make the Neovim community so vibrant.

## How Can I Contribute?

### Reporting Bugs
Before creating a bug report, please check existing issues to avoid duplicates.
When opening a bug report, please include:
- Your Neovim version (`nvim --version`).
- A minimal reproduction configuration (`minimal_init.lua`).
- Expected vs. actual behavior (with screenshots if visual).

### Supporting New Plugins
If a plugin you use lacks proper highlight groups:
1. Open an issue with the plugin name and a link to its repository.
2. Or submit a PR adding the missing highlight groups to `lua/scotopia/highlights.lua`.

### Submitting Pull Requests
1. **Fork** the repository and create your branch from `main`:

```bash
git checkout -b feature/my-new-highlight
```

2. Make your changes then consider basic tests with the following:

2.1. Format code using StyLua:

```bash
stylua .
```

2.2. Run tests using Plenary:

```bash
sh tests/run.sh
```

2.3. Regenerate extra configs if you modified palette.lua:

```bash
nvim --headless -c "lua require('scotopia.extra').setup()" -c "q"
```

2.4. Ensure all tests and StyLua format checks pass in CI before requesting review.


🙏 Thank you for helping make scotopia.nvim better!
🤝 Hope we'll make the theme better together?
