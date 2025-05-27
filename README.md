# Smartphone App for AC
Chat replacement app in the style of an iPhone and iMessage.

If you're looking for a more "oldschool" feel, try my [Mobilephone](https://github.com/C1XTZ/ac-mobilephone/) app.

### Current Features:
- **Dark Mode**
- **Displays current reallife time (24h/12h formats) - Left click to send it to chat**
- **Displays currently playing music information - Left click to send it to chat**
- **Displays your ping - Left click to send it to chat**
- **Support for Custom Community Pictures, linking to a URL**
  - Owners of communities that want to be added can contact me with the following information:
    ```ini
    Server IPs:     ;List of IP addresses of your servers. IP's should not change all the time.
    Image:          ;Image that you want to be displayed. 
    Tooltip Text:   ;Text that you want to be displayed in the tooltip.
- **Ingame chat - Right click a message to @mention the sender**
- **iOS 18 Sounds - Keystrokes, Messages, Notifications**
- **Hides annoying messages from other apps**
    - Example: `PLP: running version 1.21, 2-60-3-True-3.3-0.9-3-2-8-5-0|C1XTZ`
- **Many adjustable settings as seen below - images might be outdated, always check ingame**

<p align="center">
<img width="185" src="https://raw.githubusercontent.com/C1XTZ/ac-smartphone/main/.github/img/appsettings.png"> <img width="185" src="https://raw.githubusercontent.com/C1XTZ/ac-smartphone/main/.github/img/preview.gif"> <img width="185" src="https://raw.githubusercontent.com/C1XTZ/ac-smartphone/main/.github/img/chatsettings.png"> <img width="185" src="https://raw.githubusercontent.com/C1XTZ/ac-smartphone/main/.github/img/audiosettings.png">
</p>

If you have any questions or suggestions, feel free to open an issue or pull request.  
You can also reach me here:
- Discord [@c1xtz](https://discord.com/users/856601560728207371) 
- Twitter [@C1XTZ](https://twitter.com/C1XTZ)
- BlueSky [@c1xtz.bsky.social](https://bsky.app/profile/c1xtz.bsky.social)

# License
Unless otherwise noted in **[Exceptions](#exceptions)**, **all original source code** in this repository such as `.lua` scripts, build scripts, and any other code files, is licensed under the **GNU GPL v3.0 License**. 

### What you can do:

- Modify the code
- Use the code privately and commercially
- Distribute the code (including in other projects)

### What you are required to do:

- Make the source code public (which means you cannot obfuscate the code in any way)
- Maintain the same license for any forks/modifications you do
- State what you have changed (this includes a simple "I changed some of the numbers")

### What you don't get:

- Liability
- Warranty

This may seem like a lot, but the general gist is: if you're going to use it, make sure people know where it's from, or if you're going to modify it, the modifications are public. The easiest way to do this is to create a [Fork](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/working-with-forks/about-forks) of the repository.

Full license details are available in the [`smartphone/CODELICENSE.txt`](./smartphone/CODELICENSE.txt) or on [https://www.gnu.org](https://www.gnu.org/licenses/gpl-3.0.en.html)  

## Exceptions

### **SRP Logo**  
[`srp-logo-socials.png`](./smartphone/src/img/communities/srp-logo-socials.png)  
- **License:** All rights reserved by Shutoko Revival Project  
    - You may distribute the image **unchanged**, provided it **remains bundled with this app**.  
- **Standalone redistribution, modification, or commercial use** requires explicit permission from [Shutoko Revival Project](https://shutokorevivalproject.com).  

### **Inter Font**  
[`InterVariable.ttf`](./smartphone/src/ttf/InterVariable.ttf), [Inter 4.1](https://github.com/rsms/inter) by Rasmus Andersson  
- **License:** SIL Open Font License 1.1 (OFL-1.1)  
    - You may use, modify, or redistribute the font under the terms of OFL-1.1.  
- See [`smartphone/src/ttf/FONTLICENSE.txt`](./smartphone/src/ttf/FONTLICENSE.txt) or [https://openfontlicense.org](https://openfontlicense.org) for full license details.  

### **Icons**
[`icon.png`](./smartphone/icon.png), ["mobile chat"](https://thenounproject.com/icon/mobile-chat-6633091/) by Hermawan on The Noun Project.  
- **License:** Creative Commons Attribution 3.0 Unported (CC BY 3.0)  
    - You must provide indivitual attribution per CC BY 3.0.  
- See [`smartphone/ICONLICENSE.txt`](./smartphone/ICONLICENSE.txt) or [https://creativecommons.org](https://creativecommons.org/licenses/by/3.0/) for full license details.  

## Additional Credits  
- **x4fab** for providing the CSP lua SDK and fixing features I'm probably the only user of.  
- **Cheesymaniac** for forwarding my CSP issues to x4fab and enduring my complaining.  
- **Eurobeat** for testing and feedback.  