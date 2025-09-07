# Atomic Stream Workstation

An opinionated atomic workstation based on the CentOS Stream 10 `bootc` image.

Built using the [AlmaLinux atomic-respin-template](https://github.com/AlmaLinux/atomic-respin-template).

### Changes from the template

- Uses the forked `atomic-ci` CI pipeline, with AlmaLinux-specific components removed  
- Uses CentOS Stream 10 `bootc` image as the base  
- Adds multimedia codecs from Negativo  
- Adds backported GNOME 48 from HyperScale SIG COPR  
- Removes RPM Firefox-ESR in favor of the Flatpak version 
- Adds virtualization support, VS Code, and various tools, utilities, and fonts


**Intended for personal use and testing only.**
