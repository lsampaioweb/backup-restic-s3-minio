# Backup with Restic to an S3 Bucket on MinIO
Repository with commands to run Restic to backup my files to an S3 bucket on MinIO.

## Commands sequence:

### Init
```bash
./init
```

### Backup
```bash
./backup
```

### Check
```bash
./check
```

### Snapshots
```bash
./snapshots
```

### Forget
```bash
./forget
```

Backup commands:
  restic init --repo /Volumes/Backup-04/Luciano
  restic --repo /Volumes/Backup-04/Luciano backup ~/Luciano --verbose
  restic --repo /Volumes/Backup-04/Luciano backup ~/Luciano --tag MYTAG1 --tag MYTAG2 --verbose
  restic --repo /Volumes/Backup-04/Luciano snapshots
  restic --repo /Volumes/Backup-04/Luciano ls latest
  restic --repo /Volumes/Backup-04/Luciano diff ID1 ID2
  restic --repo /Volumes/Backup-04/Luciano forget ID
  restic --repo /Volumes/Backup-04/Luciano forget --keep-last 12 --keep-daily 30 --keep-weekly 4 --keep-monthly 12 --dry-run
  restic --repo /Volumes/Backup-04/Luciano prune
  restic --repo /Volumes/Backup-04/Luciano check
  restic --repo /Volumes/Backup-04/Luciano restore latest --target /tmp/Luciano

To run the backup:
  /Volumes/Backup-04/./backup.sh
