# Restic Backup to MinIO S3 Bucket on Macbook Pro

This guide explains how to use a Bash script to back up files from a Macbook Pro to an S3 Bucket hosted on MinIO using Restic. Restic is a fast, secure, and efficient backup program, and MinIO is a high-performance, distributed object storage server. This script automates the backup process.

## Prerequisites

Before using the script, make sure you have the following prerequisites installed and configured:

1. **Restic**: Install Restic on your Macbook Pro. You can download it from the [official website](https://restic.net/) or use HomeBrew.

    ```bash
    brew install restic
    ```

1. **MinIO Client (mc)**: Install MinIO Client (mc) to manage MinIO resources. You can download it from the [MinIO website](https://min.io/download). Configure `mc` with your MinIO server information.

1. **Access Key and Secret Key**: You should have access to the MinIO S3 Bucket and obtain access and secret keys to configure `mc`.

## Configuration

1. Clone or download the script from this repository.

1. Make the script executable:

    ```bash
    chmod +x restic-backup.sh
    ```

1. Open the variables file (`Mac: MacOS/variables.sh` or `Ubuntu: Ubuntu/variables.sh`) in a text editor and customize the following variables of the script to match your configuration:

- `minio_url`: Set the url of the MinIO server. You should replace `"s3:https://api.edge-minio-01.homelab/"` with the URL of your MinIO.

- `bucket_name`: Set the name of the S3 Bucket where your backups will be stored. You should replace `"macbook-luciano"` with the name of your MinIO S3 Bucket.

- `passwordCommand`: Specify the command to retrieve the password for the repository. In the provided code, it uses macOS's `security` command to retrieve the password from the system's keychain. You may customize this command to match how you store your repository password.

- `AWS_ACCESS_KEY_ID`: This variable is used to configure Restic with the access key for connecting to MinIO. You should replace `edge-minio-01-restic-backup-access-key-id` with the name you used on your Keychain.

- `AWS_SECRET_ACCESS_KEY`: This variable is used to configure Restic with the secret access key for connecting to MinIO. Replace `edge-minio-01-restic-backup-secret-access-key` with the name you used on your Keychain.

- `GOMAXPROCS`: Set the number of CPU cores Restic should use. The default is `1`, but you can adjust it as needed based on your system's resources.

Customize these variables to match your specific MinIO and system configuration.

## Usage

### 1. Init

The `init` script initializes the Restic repository. You only need to run this script once for each repository you create. To initialize the repository, execute the following command:
```bash
./init.sh
```

### 2. Backup

The `backup` script is used to create a backup snapshot of your specified source directory. You can run this script to regularly back up your data. Execute the following command to create a backup:
```bash
./backup.sh
```

## Automating Backups with Cron

You can automate your backups by scheduling the backup script to run at specific intervals using the `cron` service. This ensures that your files are regularly backed up without manual intervention. To set up a cron job to run the backup script every hour, follow these steps:

1. Open your terminal.

2. Edit your user's crontab by running the following command:

    ```bash
    crontab -e
    ```

3. This will open the crontab configuration in the default text editor. If prompted, choose your preferred text editor (e.g., nano, vim, or another).

4. Add the following line to the crontab file to run the backup script every hour:

    ```bash
    # Run the backup every hour.
    0 * * * * /path/to/restic-backup.sh >> /path/to/backup.log 2>&1
    ```

   Make sure to replace `/path/to/restic-backup.sh` with the actual path to your backup script.

   - `0` in the first position represents the minute (0-59).
   - `*` in the second position represents the hour (0-23).
   - `*` in the third position represents the day of the month (1-31).
   - `*` in the fourth position represents the month (1-12).
   - `*` in the fifth position represents the day of the week (0-6, where both 0 and 6 represent Sunday).

   This configuration runs the script at the beginning of every hour.

5. Save and exit the text editor. The cron job is now set up.

6. The cron service will automatically run your backup script every hour.

**Note**: Ensure that the script has execute permissions, as mentioned in the previous sections of this README.

Remember to adjust the cron schedule to your specific needs. If you want to run the backup more or less frequently, you can modify the cron expression accordingly. That's it! Your backup script will now run automatically every hour as scheduled.

# Other Restic Bash Scripts

This repository includes a set of other Bash scripts as well. Each script is designed to perform a specific task related to managing Restic backups.

### 1. Check

The `check` script verifies the integrity of the Restic repository, ensuring that your backups are healthy and free from corruption. Use this script to perform repository checks. Run the following command to check your repository:
```bash
./check.sh
```

### 2. Snapshots

The `snapshots` script provides a list of all available snapshots in your Restic repository. It allows you to view and manage your snapshots easily. To list your snapshots, use the following command:
```bash
./snapshots.sh
```
### 3. Forget

The `forget` script is used to manage retention policies for your snapshots. You can use it to remove old snapshots and save storage space. To manage snapshots retention, execute the following command:
```bash
./forget.sh
```

These scripts provide a convenient way to interact with Restic and manage your backup processes. Customize and use them according to your specific backup needs.

## Troubleshooting

If you encounter any issues or errors while running the script, refer to the error messages and check your configuration. You can also consult the official documentation for Restic and MinIO.

## Contributing

If you encounter any issues with the script or have suggestions for improvements, feel free to create a pull request or open an issue in the GitHub repository.
