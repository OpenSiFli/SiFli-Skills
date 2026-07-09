# sifli-skills

SiFli agent skills for the existing [`skills`](https://www.npmjs.com/package/skills)
CLI.

## Usage

```sh
npx skills add OpenSiFli/SiFli-Skills --list
npx skills add OpenSiFli/SiFli-Skills --skill sftool -g -a codex -y
npx skills add OpenSiFli/SiFli-Skills --skill '*' -g -a codex -y
```

With `skills@1.5.15`, `-g -a codex` installs to `~/.agents/skills`.

## Sync

This repository mirrors skills from upstream OpenSiFli repositories. Refresh it
manually with:

```sh
bash scripts/sync-skills.sh
```

GitHub Actions also runs the same sync every 6 hours and commits changes when
an upstream skill changes.

## Available Skills

| Skill | Source |
| --- | --- |
| `sifli-build-win` | `OpenSiFli/SiFli-SDK` |
| `sftool` | `OpenSiFli/sftool` |
| `sifli-sdk-codekit` | `OpenSiFli/SiFli-SDK-CodeKit` |
