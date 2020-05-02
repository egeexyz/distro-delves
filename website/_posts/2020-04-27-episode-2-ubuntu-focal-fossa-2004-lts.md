---
title: 'Episode 2: Ubuntu Focal Fossa 20.04 LTS'
date: '2020-04-27 15:57:24'
description: Taking a look at the mighty Ubuntu 20.04 LTS released on April 23rd of
  2020.
featured_image: "/images/blog/ep20.jpg"
---

<iframe width="560" height="315" src="https://www.youtube.com/embed/4olree_yK4M" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

### Ubuntu Focal Fossa 20.04 LTS
#### Released Date April 23 2020

Results Key:

**E:** *Expected or within expected parameters.*

**U:** *Unexpected result or anomaly in test.*

**N:** *Not Applicable.*

***Note:** AppImage, Flatpak, and Snap tests don't have an official expected result.*

---

### Install & Resources

| Test | Result   | Notes |
|----------------------|---------------|
| Installer                               | E | Ubiquity |
| Welcome App                  |  E | |
| Disk Usage                         | 7.6gb |  |
| Resource Usage App   |  1.1gb| Heavy at idle |


### Desktop, Apps, & Drivers

| Test | Result   | Notes |
|----------------------|---------------|
| DE                           | N | Gnome 3.36 |
| Style/Theme     |  N | Yaru |
| Default Apps    | E |  |
| Custom Tools   |  E|  |
| Nvidia Drivers   |  E | 440 |
| OBS  | E | |

### Application Management

| Test | Result   | Notes |
|----------------------|---------------|
| SD Card exfat        | E |  |
| External SSD          |  E | |
| Archive files           | E |  |
| Media Playback   |  E |  |
| AppImage               |  N | Supported |
| Flatpak   | N | Not Supported |
| Snap               |  N | Supported but Software Center was buggy |


### Networking

| Test | Result   | Notes |
|----------------------|---------------|
| Samba Sharing        | E | Config tool crashed but sharing succeeded |
| DLNA          |  E | |
| Direct Connect           | E |  |
| Printer   |  E |  |
| Bluetooth               |  **U** | Very buggy |

### Benchmarks

| Test | Result   | Notes |
|----------------------|---------------|
| CPU        | N |  [Link](https://browser.geekbench.com/v5/cpu/1937922) |
| GPU          |  N | [Link](https://browser.geekbench.com/v5/compute/820062) |
| Grid           | N | 38fps |
| War Thunder   |  N | 26fps |
| Grand Theft Auto 5               |  N | 18fps |


*A total of **1** "U" test result was recorded.*
