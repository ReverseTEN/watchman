<h1 align="center">
  <br>
<img src="https://user-images.githubusercontent.com/59805766/222277973-f4dee0d6-99f4-41e3-ab08-0defa2d260a9.png" alt="Watchman"></a>
</h1>
<h4 align="center">Keep your targets under constant watch with Watchman</h4>

<p align="center">
<a href="https://opensource.org/licenses/MIT"><img src="https://img.shields.io/badge/license-MIT-_red.svg"></a>
<a href="https://github.com/ReverseTEN/watchman/issues"><img src="https://img.shields.io/badge/contributions-welcome-brightgreen.svg?style=flat"></a>
</p>

<p align="center">




This bash script utilizes Naabu and Httpx to monitor web applications for changes in open ports or website status and title. Naabu is a fast and flexible port scanner that can identify open ports on a target system, while Httpx is a fast and versatile HTTP toolkit that allows running multiple probes using the retryablehttp library. It is designed to maintain result reliability with an increased number of threads.

With Naabu and Httpx working together, this program provides comprehensive monitoring and detection of potential vulnerabilities. By automating the monitoring process and sending notifications, it is an efficient tool for bug hunters to keep track of their targets and ensure they are aware of any changes or issues that may arise.

Bug hunters can schedule the script to run at regular intervals using a cronjob to continuously monitor their targets for potential vulnerabilities. This automated monitoring process, combined with timely notifications, allows them to stay ahead of any changes or issues that may arise, saving them time and effort in the long run.

Overall, this program is a valuable addition to any bug hunter's toolkit, as it can help them save time and effort by automating the monitoring process and delivering notifications in a timely manner. Give it a try and see how it can improve your workflow and help you stay ahead of any potential vulnerabilities!


## Requirements

- [Naabu](https://github.com/projectdiscovery/naabu)
- [HTTPX](https://github.com/projectdiscovery/httpx)
- [anew](https://github.com/tomnomnom/anew)
- [notify](https://github.com/projectdiscovery/notify)

## Usage

1. Clone the repository and navigate to the `watchman` directory.

```

git clone https://github.com/RT3N/watchman.git
cd watchman
chmod +x watchman.sh

```

2. Create a file called `ips.txt` in the root directory of the script and add your target IPs or domains of your target assets to the file, one per line.

3. Run the script using the following command: `./watchman.sh <any name>`

4. Create a cronjob by running the following command: `crontab -e`

5. Add the following line to the crontab file to run the script every 5 hours or at any desired frequency. In this example, I am running it every 5 hours.

```
* */5 * * * /bin/bash /path/to/watchman/watchman.sh TARGET > /dev/null 2>&1
```


## Usage

- When the cronjob runs, Watchman will check for changes in target ports and statuses and titles. If it's the first time Watchman is run for a target, it will create a new directory for the target and save the scan results to files. If changes are detected in subsequent scans, Watchman will notify the user of any new ports or status changes.


## Notifications

notify is a lightweight and user-friendly tool that makes it easy to send notifications to messaging platforms like Slack, Discord, and Telegram. 

To set up notify for your messaging platform, you can follow the instructions on the [Project Discovery GitHub page](https://github.com/projectdiscovery/notify#provider-config).

## Example

Here's an example usage of the script:

```bash

./watchman.sh hackerone

```



