# Open Source AI Machine Setup

I am setting up my machine for doing open source AI development, and wanted a repo to keep my development log and various setup scripts.

## Initial Setup

The osai-redwood host is running Ubuntu Server 23.10.

## Ops

I have osai-redwood configured in `~/.ssh/config`, so ansible will get the hostname, port, and identity file from there.

```sh
cd ansible/
ansible-playbook setup.yml --ask-become-pass
```
