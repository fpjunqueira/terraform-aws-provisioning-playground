**ssh to instance**

`$ ssh -i ../aws-key -l ubuntu <IP/DNS>
`

**See root volume (/dev/xvda1      7.7G  1.2G  6.6G  15% /)**

`$ df -h
`

**Root**
`$ sudo -s
`

**Create an ext4 file system**

`$ mkfs.ext4 /dev/xvdh
`

**Mount extra volume**

` $ mkdir /data
`
` $ mount /dev/xvdh /data
`

**See extra volume now (/dev/xvdh        20G   44M   19G   1% /data)**

`$ df -h
`

_This volume is not ephemeral. You can reboot the instance and we'll have data always available_

**Add configuration to mount and umount volume in fstab**

 `$ vi /etc/fstab
`

 **Put the line: /dev/xvdh /data ext4 defaults 0 0**


`$ umount /data
`
`$ df -h
`

`$ umount /data
`
`$ df -h
`

_We can create a immutable infrastructe because our data will be on a volume if we want to keep our data_

_We can relaunch the instance using user data and scripts to bring it in the same state that it was_
