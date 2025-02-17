# Restic Backup to MinIO S3 Bucket on Macbook Pro or Ubuntu.

This guide explains how to use a Bash script to automate backups on a Macbook Pro and an Ubuntu, securely storing them in an S3 Bucket hosted on MinIO using Restic. Restic is a fast, secure, and efficient backup program, and MinIO is a high-performance, distributed object storage server.

## Prerequisites

Before using the script, make sure you have the following prerequisites installed and configured:

1. **Restic**: Install Restic on your machine. You can download it from the [official website](https://restic.net/) or use any packet manager.

    - MacOS
    ```bash
    brew install restic
    ```

    - Ubuntu
    ```bash
    apt install -y restic
    ```

1. **MinIO Client (mc)**: Install MinIO Client (mc) to manage MinIO resources. You can download it from the [MinIO website](https://min.io/download). Configure `mc` with your MinIO server information.

1. **Access Key and Secret Key**: You should have access to the MinIO S3 Bucket and obtain access and secret keys to configure `mc`.
    - [Create Access and Secret keys on MinIO](https://github.com/lsampaioweb/home-edge-minio/blob/main/02-Config/04%20-%20Policies/02%20-%20restic.txt).

## Configuration

1. Clone or download the script from this repository.

1. Make the script executable:

    ```bash
    chmod u+x restic-backup.sh
    ```

    Customize these variables to match your specific MinIO and system configuration.

1. Open the file (`Mac: variables/main.sh`) in a text editor and customize the following variables of the script to match your configuration:

    - `GOMAXPROCS`: Set the number of CPU cores Restic should use.
        - The default is `1`, but you can adjust it as needed based on your system's resources.

1. Open the file (`Mac: variables/macos.sh` or `Ubuntu: variables/ubuntu.sh`) in a text editor and customize the following variables of the script to match your configuration:

    - `restic_path`: Set the path where the Restic application is installed.
        - Replace `"/usr/local/bin/restic"` with the path in your OS.

1. Open the file (`Mac: variables/macos-local.sh` or `Ubuntu: variables/ubuntu-local.sh`) in a text editor and customize the following variables of the script to match your configuration:

    - `passwordCommand`: Specify the command to retrieve the password for the repository.
        - Customize this command to match how you store your repository password. More in the next section.

1. Open the file (`Mac: variables/macos-minio.sh` or `Ubuntu: variables/ubuntu-minio.sh`) in a text editor and customize the following variables of the script to match your configuration:

    - `passwordCommand`: Specify the command to retrieve the password for the repository.
        - Customize this command to match how you store your repository password. More in the next section.

    - `AWS_ACCESS_KEY_ID`: This variable is used to configure Restic with the access key for connecting to MinIO.
        - Replace `restic-backup-access-key-id` with the name you used on your Keychain.

    - `AWS_SECRET_ACCESS_KEY`: This variable is used to configure Restic with the secret access key for connecting to MinIO.
        - Replace `restic-backup-secret-access-key` with the name you used on your Keychain.

## Save Your Passwords

To enhance security, it is advisable not to store passwords in plaintext files or environment variables. Instead, we will utilize the `Keychain` (security) for macOS and `Libsecret` (secret-tool) for Ubuntu to securely manage these credentials.

Use the commands below to create password entries, customizing them according to your needs:

**MacOS:**

- Local
    ```bash
    # The password of the repository.
    security add-generic-password -a $USER -U -s "restic-backup-local-password" -j "restic-backup-local-password" -w
    ```

- Minio

    ```bash
    # The password of the repository.
    security add-generic-password -a $USER -U -s "restic-backup-password" -j "restic-backup-password" -w

    # The "ID" that Restic will use to connect to MinIO.
    security add-generic-password -a $USER -U -s "restic-backup-access-key-id" -j "restic-backup-access-key-id" -w

    # The "Password" that Restic will use to connect to MinIO.
    security add-generic-password -a $USER -U -s "restic-backup-secret-access-key" -j "restic-backup-secret-access-key" -w
    ```

**Ubuntu:**

- Local
    ```bash
    # The password of the repository.
    secret-tool store --label="restic-backup-local-password" password restic-backup-local-password
    ```

- Minio
    ```bash
    # The password of the repository.
    secret-tool store --label="restic-backup-password" password restic-backup-password

    # The "ID" that Restic will use to connect to MinIO.
    secret-tool store --label="restic-backup-access-key-id" password restic-backup-access-key-id

    # The "Password" that Restic will use to connect to MinIO.
    secret-tool store --label="restic-backup-secret-access-key" password restic-backup-secret-access-key
    ```

## Usage

### 1. Init

The `init` script initializes the Restic repository. You only need to run this script once for each repository you create. To initialize the repository, execute the following command:

The `<repository>` can be:
  - local: `/Volumes/Backup-03/MacOS-Backup-Luciano`
  - minio: `s3:https://api.edge-minio-01.lan.homelab/macbook-luciano`

```bash
./init.sh local <repository>
./init.sh minio <repository>
```

### 2. Backup

The `backup` script is used to create a backup snapshot of your specified source directory. You can run this script to regularly back up your data. Execute the following command to create a backup:

```bash
./backup.sh local <repository>
./backup.sh minio <repository>
```

## Automating Backups with `launchd` or `Cron`

You can automate your backups by scheduling the backup script to run at specific intervals using the `launchd` or `Cron` service. This ensures that your files are regularly backed up without manual intervention. To set up a job to run the backup script every hour, follow these steps:

**MacOS:**

1. Edit the `MacOS/restic-backup-[local|minio]-01.plist` file if you want to run the backup more or less frequently:

    ```bash
    <key>StartInterval</key>
    <!-- 3600 seconds = 1 hour -->
    <integer>3600</integer>
    <key>StartCalendarInterval</key>
    <dict>
        <key>Minute</key>
        <!-- 0 minute mark of every hour -->
        <integer>0</integer>
    </dict>
    ```

1. Copy the Property List File to the correct path:

    ```bash
    cp MacOS/restic-backup-local-02.plist ~/Library/LaunchAgents/restic-backup-local-02.plist
    cp MacOS/restic-backup-local-03.plist ~/Library/LaunchAgents/restic-backup-local-03.plist
    cp MacOS/restic-backup-minio-01.plist ~/Library/LaunchAgents/restic-backup-minio-01.plist
    ```

1. Load the Launch Agent:

    ```bash
    launchctl load ~/Library/LaunchAgents/restic-backup-local-02.plist
    launchctl load ~/Library/LaunchAgents/restic-backup-local-03.plist
    launchctl load ~/Library/LaunchAgents/restic-backup-minio-01.plist
    ```

1. Start the Job:

    ```bash
    launchctl start restic-backup-local-02
    launchctl start restic-backup-local-03
    launchctl start restic-backup-minio-01
    ```

1. List the running jobs:

    ```bash
    launchctl list | grep restic-backup
    ```

1. Stop the Job:

    ```bash
    launchctl stop restic-backup-local-02
    launchctl stop restic-backup-local-03
    launchctl stop restic-backup-minio-01
    ```

1. Unload the Launch Agent:

    ```bash
    launchctl unload ~/Library/LaunchAgents/restic-backup-local-02.plist
    launchctl unload ~/Library/LaunchAgents/restic-backup-local-03.plist
    launchctl unload ~/Library/LaunchAgents/restic-backup-minio-01.plist
    ```

**Ubuntu:**

1. Open your terminal.

1. Edit your user's crontab by running the following command:

    ```bash
    crontab -e
    ```

1. This will open the crontab configuration in the default text editor. If prompted, choose your preferred text editor (e.g., nano, vim, or another).

1. Add the following line to the crontab file to run the backup script every hour:

    ```bash
    # Run the backup every hour.
    0 * * * * /path/to/restic-backup.sh local <repository> >> /path/to/backup.log 2>&1
    ```

   Make sure to replace `/path/to/restic-backup.sh` with the actual path to your backup script.

   - `0` in the first position represents the minute (0-59).
   - `*` in the second position represents the hour (0-23).
   - `*` in the third position represents the day of the month (1-31).
   - `*` in the fourth position represents the month (1-12).
   - `*` in the fifth position represents the day of the week (0-6, where both 0 and 6 represent Sunday).

1. Save and exit the text editor. The cron job is now set up.

1. The cron service will automatically run your backup script every hour.

**Note**: Ensure that the script has execute permissions, as mentioned in the previous sections of this README.

Remember to adjust the cron schedule to your specific needs. If you want to run the backup more or less frequently, you can modify the cron expression accordingly. That's it! Your backup script will now run automatically every hour as scheduled.

# Other Restic Bash Scripts

This repository includes a set of other Bash scripts as well. Each script is designed to perform a specific task related to managing Restic backups.

### 1. Check

The `check` script verifies the integrity of the Restic repository, ensuring that your backups are healthy and free from corruption. Use this script to perform repository checks. Run the following command to check your repository:

```bash
./check.sh local <repository>
./check.sh minio <repository>
```

### 2. Snapshots

The `snapshots` script provides a list of all available snapshots in your Restic repository. It allows you to view and manage your snapshots easily. To list your snapshots, use the following command:

```bash
./snapshots.sh local <repository>
./snapshots.sh minio <repository>
```

### 3. Forget

The `forget` script is used to manage retention policies for your snapshots. You can use it to remove old snapshots and save storage space. To manage snapshots retention, execute the following command:

```bash
./forget.sh local <repository>
./forget.sh minio <repository>
```

### 4. Restore

The `restore` script is used to recover files and directories from a backup repository. You can use it to restore specific snapshots or specific files and directories within a snapshot. To perform a restore, execute the following command:

```bash
./restore.sh local <repository> [snapshotId] [target]
./restore.sh minio <repository> [snapshotId] [target]
```

These scripts provide a convenient way to interact with Restic and manage your backup processes. Customize and use them according to your specific backup needs.

## Troubleshooting

If you encounter any issues or errors while running the script, refer to the error messages and check your configuration. You can also consult the official documentation for Restic and MinIO.

## Contributing

If you encounter any issues with the script or have suggestions for improvements, feel free to create a pull request or open an issue in the GitHub repository.
