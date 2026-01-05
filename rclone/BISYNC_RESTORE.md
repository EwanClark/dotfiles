# rclone bisync – Restore Instructions

Use this ONLY if the bisync state directory has been lost, deleted, or not restored:

    /home/ewan/.config/rclone/bisync

This process safely rebuilds the bisync state.
DO NOT run the normal bisync script before completing these steps.

---

## 1️⃣ Dry-run resync (REQUIRED)

This shows what would happen without changing anything.
If you see errors or unexpected mass deletes, STOP.

```bash
rclone bisync "/home/ewan/Documents/" "gdrive:Documents/" --workdir "/home/ewan/.config/rclone/bisync" --resync --copy-links --fast-list --create-empty-src-dirs --log-level=NOTICE --log-file="/home/ewan/.config/rclone/logs.txt" --exclude-from "/home/ewan/.config/rclone/exclude.txt" --dry-run
```

---

## 2️⃣ Real resync (ONLY if dry-run looks safe)

This rebuilds the bisync state and applies changes.

```bash
rclone bisync "/home/ewan/Documents/" "gdrive:Documents/" --workdir "/home/ewan/.config/rclone/bisync" --resync --copy-links --fast-list --create-empty-src-dirs --log-level=NOTICE --log-file="/home/ewan/.config/rclone/logs.txt" --exclude-from "/home/ewan/.config/rclone/exclude.txt"
```

---

## 3️⃣ After restore

Resume normal usage with the regular bisync command or script.
DO NOT continue using `--resync`.

---

## 🚨 Important rules

- Never run bisync without `--resync` if state is missing
- Never skip the dry-run
- Never use `rclone sync` on these paths again
- Do not restore old bisync state from backups or Git

This process is safe and repeatable.