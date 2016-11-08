# Raspberry Pi: Basic network connection tutorial

Raspberry Pi's are awesome! They are inexpensive and (mostly) open-source little computers with GPIO (general purpose input-output) pins that you can use to receive signals and interact with external devices. For the purposes of Ethereum, you can use the Raspberry Pi 3 to run a full node, launch an editor to write smart contracts and deploy those to the network, or  use the device to link transactions from the Ethereum network to hardware components (from coffee machines to door-locking mechanisms) through the GPIO pins or pre-built add-on devices. There is a lot of potential for DIY projects and prototyping ideas on-the-cheap. 

For this small guide I want to focus on a couple tips that are useful for setting up the Pi on a new network in order to get programming and tinkering quickly. I'm going to assume that you have installed an operating system on Raspberry Pi sd card, but don't have separate monitor and keyboard handy. If you need help doing the initial setup, check these out: 
1. [EthEmbedded: Raspberry Pi Image Step-By-Step Install Instructions](http://ethembedded.com/?page_id=171). Helpful for getting everything set up for an Ethereum node
2. [RaspberryPi.org](https://www.raspberrypi.org/help/)	 The Raspberry Pi Organization's help guides. Useful! 


### Finding a Raspberry Pi over ssh
Let us assume that you have a laptop and an ethernet cable, but no keyboard or external monitor for your Raspberry Pi (RPi). I find this to be a common scenario. How does one access the RPi over the network in order to deploy code or fire-up the ethereum node? Use something called secure shell (ssh). To do this we need to know the IP address of RPi on the local network. This is a problem, especially if we don't have access to the network router to lookup all devices connected to the local network. Fortunately, there are a few command line tricks that we can use. 

(1) Assumption 1: I'm going to assume that you have used a `terminal` or `command prompt` before. If not, see the guide for [Mac](http://guides.macrumors.com/Terminal} or type ctl+alt+T on linux. 

(2) Assumption 2: I'm going to assume that SSH is enabled on the RPi. This is the defaul setting for the standard RPi sd card image. If it's not enabled, our process is more complicated. You'll need to attach the RPi to a screen and keyboard and, from the terminal, run the following commands: 

>Enter `sudo raspi-config` in the terminal, first select `advanced options`, then navigate to ssh, press `Enter` and select  >`Enable or disable ssh server`

(3) Install `nmap`. From the terminal, type `sudo apt-get install nmap`. I'm not sure what the install command is for Mac, or even if there is an equivalent on Windows. You're on your own. Oh yeah, now is a good time to mention that I'm using debian-based Linux exclusively, so my instructions may not apply if you're on a different system. And by "may" I mean that you'll have to load up your favourite search engine and find comparable commands for your system. 

(4) With the assumptions and pre-conditions out of the way, we need have a powered RPi connected to your computer via an ethernet cable, and we want to access that lil'bugger. Some connections will automatically "share the connection with other computers", but if it doesn't happen automatically you'll need to select that option under Network-Manager -> IPv4, and reboot your computer. Sucks, I know. Just get it done. 

(5) IP Address scan. In terminal type: `ifconfig`. That will bring up a list of network devices. Although the names might vary slightly from system to system, it should populate a list that includes wlan0, eth1, and lo; you may have different labels. No worries. Look for the section under your ethernet connection that says "inet". It might look something like "inet 10.42.0.1", while your wlan0 device might look something like "inet 192.168.1.35".  If so, that's great. We want to scan the ethernet (eth0 or eth1 perhaps) IP range to find the specific IP of your raspberry pi. For that we're going to use the network mapping tool, or nmap as follows: 

`nmap -n -sP 10.42.0.255/24`

My output looks like this: 

```
~ » nmap -n -sP 10.42.0.255/24  

Starting Nmap 7.12 ( https://nmap.org ) at 2016-11-08 16:56 EST
Nmap scan report for 10.42.0.1
Host is up (0.00012s latency).
Nmap scan report for 10.42.0.85
Host is up (0.0011s latency).
Nmap done: 256 IP addresses (2 hosts up) scanned in 2.51 seconds

```

The line with "Nmap scan report for 10.42.0.85" is what we're interested in. Since I only have one device connected to my ethernet cable, that's the IP I want; it's the IP of my Raspberry Pi. If your Rasberry Pi is connected to the router on your network via an ethernet cable, then it's likely that you'll need to run nmap over a different range of IP addresses: "nmap -n -sP 192.168.1.255/24", or something close to that range (depends on your system; some other routers use 192.168.0.1, so check your ifconfig results to get a sense of your network's IP range). Also, if you're checking for your device connected to a router, you're going to get a lot more IP results, so finding the one belonging to your RPi is a tad harder. 

(6) SSH: Now that we know the IP address of the Raspberry Pi ("10.42.0.85" in my case), it's time to log into it from the laptop. We're essentially going to access that device over a secure communications protocol called Secure Shell (ssh). In the default setup for the RPI, the login name is `pi` and the password is `raspberry`: 

a. Type: `ssh pi@10.42.0.85`

b. password: raspberry

c. You should see the following prompt info:  `pi@raspberrypi:~ $`


Yay! Have fun.


Next Steps for me: 

(a). Add pictures for each step to make the tutorial more intuitive. 
(b). Show to connect to the router and internet. The Rpi-3 comes with wifi built-in, so we just need to add the ssid and password information. For the Rpi-2, we'll need to add an external wifi adapter, or connect it to the router via ethernet. In some cases wifi is the only option (especially if you're at a university or public place); at home, direct connection should be fine, and easiest. 


 



