SMS Cleaner
===========

Parses [SMS Backup & Restore](https://play.google.com/store/apps/details?id=com.riteshsahu.SMSBackupRestore) sms backups and deletes old messages

## Usage

### Truncation script

```sh
$ bundle
$ ./bin/truncate_six_months < backup_file.xml > truncated_file.xml
```

to remove unwanted blank lines:

```sh
$ bundle
$ ./bin/truncate_six_months < backup_file.xml | grep -v '^  $' > truncated_file.xml
```
