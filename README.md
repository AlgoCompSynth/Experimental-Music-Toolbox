# The Experimental Music Toolbox (EMT)

Welcome to the Experimental Music Toolbox! As the name suggests, the Experimental Music Toolbox (EMT) is a collection of tools for creating experimental music. But since it's based on open source Linux tools, it can help you make any kind of music.

## Who is EMT for?

The main audience for EMT is experienced coders who want to learn how to make music using a computer. However, its core is the [Ubuntu 22.04 LTS](https://www.releases.ubuntu.com/22.04/ "Ubuntu 22.04 LTS download page") Linux distribution, which means you can install any software from that distribution, as well as any software provided by third parties. If you wish, you can install a spreadsheet and do your taxes on it.

## What's in it?

EMT is a [Git repository](https://github.com/AlgoCompSynth/Experimental-Music-Toolbox "Experimenatal Music Toolbox GitHub repository") housing a collection of scripts. The scripts can install the following tools:

-   Linux music packages: the main packages in this group are classic, low-level music programming environments like [Csound](https://csound.com/ "Csound home page"), [Pd (Pure Data)](https://pd.iem.sh/ "Pd home page") and [SuperCollider](https://supercollider.github.io/ "SuperCollider home page").

-   High-level programming language integrated development environments (IDEs):

    -   [RStudio Server](https://posit.co/download/rstudio-server/ "RStudio Server download page"), with optional package development and audio analysis / synthesis tools. This is my primary tool set.
    -   [JupyterLab](https://jupyter.org/ "Project Jupyter home page"), with [PyTorch](https://pytorch.org/ "PyTorch home page"), [torchaudio](https://pytorch.org/audio/stable/index.html "torchaudio documentation")and the complete Python data science stack.

-   The [ChucK](https://chuck.cs.princeton.edu/ "ChucK home page")live coding audio programming language, built from source: Although ChucK is included in the Ubuntu 22.04 LTS repositories and could be installed with the Linux music packages, the version there is quite old. ChucK received a significant upgrade to version 1.5 since Ubuntu 22.04 was released, so scripts to build ChucK from source are included.

-   The [NVIDIA CUDA Toolkit](https://developer.nvidia.com/cuda-toolkit "CUDA Toolkit home page"): If your system has an NVIDIA GPU, you can install the CUDA toolkit and program the GPU in C / C++.

## What hardware do I need?

EMT should run on any modern 64-bit PC (`amd64` / `X86_64`) capable of supporting Windows 11. There are three ways to run it:

1.  On a Windows 11 machine using a [Windows Subsystem for Linux](https://learn.microsoft.com/en-us/windows/wsl/ "Windows Subsystem for Linux documentation") installation of Ubuntu 22.04 LTS "Jammy Jellyfish".
2.  As a [Distrobox](https://distrobox.it/ "Distrobox home page")container inside any `amd64` / `X86_64` Linux system running Distrobox 1.7.1.0 or later.
3.  On a Windows 11-capable machine running Ubuntu 22.04. Note that I do not own such a machine so I can't verify that it works.

The JupyterLab / PyTorch subsystem can be installed in either of two modes: CPU and CUDA. The CPU mode will work on any `amd64` / `X86_64` system, but the CUDA mode requires an NVIDIA 10 series GPU or newer. I test on a GTX 1650 and an RTX 3090. And the CUDA toolkit only works with an NVIDIA GPU.

## Plan of the book

I'll start with the easiest way to get started: a Windows 11PC with no GPU. That involves just installing Ubuntu 22.04 from the Microsoft Store. Part 1 will cover all the CPU mode tools in that environment.

Part 2 will cover the tools that use an NVIDIA CPU: the CUDA toolkit and the GPU-enabled version of PyTorch. And Part 3 will cover Distrobox, [Fedora Atomic Desktops](https://fedoraproject.org/atomic-desktops/ "Fedora Atomic Desktops home page") and [Universal Blue](https://universal-blue.org/ "Universal Blue home page") Linux systems.
