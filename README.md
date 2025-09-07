# Atomic Kitten Workstation

An opinionated atomic workstation based on the CentOS Stream `bootc` image.

Built using the [AlmaLinux atomic-respin-template](https://github.com/AlmaLinux/atomic-respin-template).

### Changes from the template

- Switched to a forked atomic-ci build pipeline
- Changed the base image from the original `atomic-desktop` to the `CentOS Stream` bootc image
- Retained most configuration from the original `atomic-desktop` base image
- Added multimedia codecs from EPEL
- Removed Firefox in favor of Flatpak version 
- Added virtualization support, VS Code, and some tools, utilities, and fonts
- Experimental `g48` branch with backported GNOME 48

**Intended for personal use and testing only.**