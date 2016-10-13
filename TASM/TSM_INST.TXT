/*************************************************************************/
                           TSM_INST.TXT
                        TURBO ASSEMBLER 5.0

This file contains details on how to install the TASM 5.0 package.

--------------------------------------------------------------------
                        TABLE OF CONTENTS

SECTION 1     System Requirements  -   Full Installation

SECTION 2     Installing TASM 5.0
              A)   Pre-Installation Notes
                   1)   Backup Disks
                   2)   Disk Compressions
                   4)   Network Installation
              B)   Where to install
              C)   Installation Instructions
              D)   After Installation

SECTION 3     Minimum and Selected Installation Options


SECTION 4     Troubleshooting - Install Issues
              A)   Data Integrity or Bad Section Errors
              B)   Disk Full or Insufficient Disk Space
                   Errors
              C)   GP Fault or Unhandled Exception Errors

SECTION 5     Troubleshooting - Run Time Problems
              A)   Out of Memory Errors
              B)   GP Fault or Unhandled Exception Errors
              C)   Turbo Debugger for Windows

SECTION 6     Icons in the TASM Group Window
              A)   Creating a Program Group Window for TASM
              B)   List of Icons and Executable Files

SECTION 7     Using TASM from Windows

SECTION 8     How to Get A Technical Information Document
              A)   From TechFax
              B)   From Bulletin Boards

SECTION 9     Boot Clean
--------------------------------------------------------------------

SEARCH INSTRUCTIONS:  To go directly to a specific
section, use your editor's search utility and search on
"SECTION -#-" replacing the # with the appropriate section
number.


SECTION -1-  SYSTEM REQUIREMENTS
================================
Before installing TASM please review the minimum
system requirements listed below:

System requirements for a generic full installation
(both 16- and 32-bit installation):
   8 MB system memory  (req. to run Win32)
   Intel 386 or higher
   DOS 5.01 or later
   Windows 3.1 or later (to access Turbo Assembler help file)
   Windows '95 or Windows NT (for targeting those environments)
   Approximately 10 MB hard disk space
   3.5" High Density Disk Drive

Generally, you should use a host environment with a capability that is
equal to or greater than capability of the system you plan to target.
For example, if you are building 32-bit applications for Windows 95 or
Windows NT, you should use TD32 in a Win32 environment.

NOTE: On a compressed hard disk the installation process
might need additional hard disk space. If you are using
a disk compression utility, refer to Section 2, part A.


SECTION -2-  INSTALLING TASM 5.0
================================

A) Pre-Installation Notes
-------------------------
1) Backup Disks
   If you wish to make backup copies of your original disks
   use the DOS DISKCOPY command. You must use the same disk
   size and media (density) when you make your backup set of
   disks. Attempting to copy from 3.5" to 5.25" will cause
   the install program to fail. If you have a bad disk
   contact Borland's Disk Replacement line at (800) 621-3132.

2) Disk Compression
   If you are using a disk compression utility (such as
   Stacker[tm], DoubleSpace[tm], XtraDrive[tm],
   SuperStor[tm], etc.) the estimated available hard disk
   space reported might not be sufficient to install the
   product. During installation, TASM 5.0 copies compressed
   files onto your hard disk. Disk compression utilities
   report available hard disk space assuming that the files
   copied onto the disk can be compressed. Since the files
   that are copied by the installation program are already
   compressed, the disk compression utility cannot compress
   them any further. To solve this, you might need to free
   additional hard disk space for the installation.

3) Network Installation
   If you are installing TASM 5.0 on a network, you may wish
   to consult Technical Information Document number 1738. For
   information on how to receive this document, refer to
   Section 10.


B) Where to Install:
--------------------
This product is designed to be used as a standalone product or in
conjunction with Delphi 2.0 or Borland C++ 5.0.  It can also be used
with Borland/Turbo C++ 4.x, Borland Pascal 7 or Delphi 1.0.  If you are
using Turbo Assembler 5.0 in conjunction with any of these Borland
compilers, you can install Turbo Assembler atop the same directory
heirarchy as your other Borland Tools.

If you use Turbo Assembler 5.0 with any other Borland development tools or
versions, then it is best to install Turbo Assembler to a unique
directory, such as c:\tasm.  Both tool sets should be referenced in your
dos path with the most recent version being first in the path.  For custom
configuration requirements, please contact Technical Support.


C) Installation Instructions:
-----------------------------
1. Boot Clean
   It is highly recommended that you boot clean before
   installing TASM 5.0. Booting your system with a clean
   configuration will eliminate any potential software
   conflicts that might arise during installation. Refer to
   Section 10 for instructions on how to boot clean.

2. Insert the TASM 5.0 installation disk into drive A or B.

3. From the DOS prompt type A:INSTALL (or B:INSTALL)
   and press <ENTER>. Do not install from a Windows DOS prompt.

4. Select installation options from the install menu. See
   Section 3 for more details on the installation instructions.

5. Choose START INSTALLATION to begin installation. If problems
   occur during installation, note any error messages and refer to
   Section 5.


D) After Installation:
----------------------
1. After the install has completed, the README file appears.
   The README file contains important information about
   configuring and using TASM 5.0, including late changes
   which might have occurred after the manuals were printed.

2. Modify your CONFIG.SYS so that files and buffers are set
   to at least 40. For example:

	FILES=40
	BUFFERS=40

   Also modify your AUTOEXEC.BAT file by adding to your path
   statement the TASM 5.0 bin directory. For example:

	PATH C:\TASM\BIN;C:\;C:\DOS;C:\WINDOWS

3. If you are installing Delphi 1.0, or Borland C++ 4.x AFTER
   Turbo Assembler 5.0 has been installed, you will have to manually
   change the system settings that allow these products to coexist:

   In your system.ini file, check your [386Enh] section for multiple
   entries for the device TDDEBUG.386.  Remove duplicate entries of
   TDDEBUG.386 so that only the version from this product is loaded.
   On disk, you may also want to rename or remove the BP7 or BC4.x
   versions of TDDEBUG.386 and TDWINTH.DLL to avoid their accidental
   loading.  You must restart Windows after making changes to system.ini.


4. Changes to SYSTEM.INI file:
   Presuming you have installed Turbo Assembler and Tools to "c:\tasm",
   The install program makes these changes to the SYSTEM.INI file:

   1) Adds "device=c:\tasm\bin\windpmi.386" to support our 32-bit tools.
   2) Adds "device=c:\tasm\bin\tddebug.386" to support our debugger.


5. Configuring the Windows NT command prompt:
   To run 16-bit protected-mode programs (tlink) under an NT command
   prompt you need to add the following line to CONFIG.NT:

      ntcmdprompt

    Under the default NT command-line prompt, DOS COMMAND.COM is run
    after returning from a TSR (such as RTM.EXE which bcc and tlink load).
    Adding the above line will cause the original NT CMD.EXE to be run.


SECTION -3-  MINIMUM AND SELECTIVE INSTALLATION OPTIONS
=======================================================
This section outlines the minimum and selective install
options available for TASM 5.0.

There are some files that are common to more than one option.
For example, MAKE.EXE will be installed if either the 16-bit or
the 32-bit command line tools are installed. { Common to 16-bit
and 32-bit tools is [2360K] of files ; Common to the TDWIN and
TDWIN32 options is [504K] of files } Those common files are
included in all the following estimates.

16-bit command line tools        [3085K]
    Install the 16-bit tools (TASM, TLINK).
    (Minimum installation option)

32-bit command line tools        [3163K]
    Install the 32-bit tools (TASM32, TLINK32).

Turbo Debugger for DOS           [1041K]
    Install Turbo Debugger for DOS.
    (Minimum installation option)

Turbo Debugger for Windows       [1533K]
    Install Turbo Debugger for Windows and associated Debugger
    tools (TDWINI setup, wremote).

Turbo Debugger for Win32         [1502K]
    Install Turbo Debugger for Win32 programs.

Examples                         [580K]
    Install Borland TASM examples.

Documentation Files              [6K]
    Install documentation files.



SECTION -4-  TROUBLESHOOTING - INSTALL PROBLEMS
===============================================
This section explains a few common errors encountered during
installation. System configuration and software conflicts
might cause the installation process to fail. If the
installation fails, follow the instructions in Section 10
on how to boot clean. This will eliminate any possible
software conflicts. If booting clean doesn't solve the
problem, or you encounter a problem not mentioned here,
contact Borland Technical Support.

With any of the following installation errors there are
several common steps that can be taken to enable the
installation to complete.

   - Make sure your system meets the minimum requirements.
     Refer to Section 1 for a list of the minimum
     installation requirements.

   - Boot your system with a clean configuration. Refer to
     Section 10 for instructions on how to boot clean.

   - Install the product from your local hard drive. Sometimes
     a timing error between the hard drive and a disk drive will
     generate an error from the TASM install. Installing from
     the hard drive can solve this problem. (Especially in
     conjunction with a clean boot)

     1) Copy the contents of all the diskettes to a temporary
        directory on your hard drive. The following is an example
        of the command:

		COPY *.* c:\temp

        If you should get an error during the copying process see
        below for information on how to get a replacement disk set.

     2) Change directories to the temp directory and then type
        install. For example:

	CD c:\temp
	INSTALL


A) Data Integrity or Bad Sector on Disk Errors
----------------------------------------------
If you receive either one of these error messages, you
need to get a replacement disk set. Contact Borland's
Disk Replacement Line at (800-621-3132).


B) Disk Full or Insufficient Disk Space Errors
----------------------------------------------
You could also get this error if there is insufficient
hard disk space available to install TASM 5.0.

   - If you are using disk compression read Section -2-
     part A) on reported available disk space when using
     disk compression.


C) GP Fault/Unhandled Exception
-------------------------------
GP Fault or Unhandled Exception errors can occur for a
variety of reasons. Possible reasons for these errors are
explained in Technical Information Document number 649.
Refer to Section 9 for instructions on how to obtain
this document.

   - Turn off Disk Caching and Video/Shadow RAM in CMOS.
     Refer to the documentation for your computer.


SECTION -5-  TROUBLESHOOTING - RUN TIME PROBLEMS
================================================
This section describes common errors encountered when
trying to use tools included in TASM 5.0. System configuration
and software conflicts might cause one of the tools to fail.
If a tool fails, you should boot your system clean to eliminate
any possible software conflicts. Refer to Section 10 for
instructions on how to boot clean. If booting clean does not
solve the problem or you encounter a problem not mentioned here,
contact Borland Technical Support.


A) Out of Memory
----------------
If you are using command-line tools and are getting
"Out of Memory" errors you might have exhausted your
extended (or XMS) memory pool. This is especially true if
you only have 2MB available extended RAM and do not have
a memory manager that provides virtual memory. If you are
experiencing this, please consult the TASM readme file that
can be found in the TASM directory, under the section General,
Out of Memory. This information can also be found in the
Technical Information Document number 1737. For information
on how to receive this document, refer to Section 9.


B) GP Fault/Unhandled Exception/System Hang
-------------------------------------------
GP Fault or Unhandled Exception errors can occur for a
variety of reasons including: not enough memory
available, not enough hard disk space available,
conflicts with optimizations set in the CMOS, and
software conflicts. Technical Information Document
numbers 649 and 1328 address these issues. Refer to
Section 9 for information on how to obtain these files.


C) Turbo Debugger for Windows
-----------------------------
If you experience any strange behavior from the Turbo
Debugger, such as a garbled screen or a system hang upon
execution or exit:

   1)  Make sure that you have the latest Windows drivers
       for your video card.

   2)  Run TDWINI and test a different DLL to resolve a
       possible compatibility problem with your specific
       card.

   3)  Check README.TXT for additional information.

   4)  If you are still experiencing difficulties your
       problem might not be related to the video mode. At
       this point contact Borland Technical Support via
       phone or online help. Refer to Section 10 for more
       information about online options and procedures.


SECTION -6-  ICONS IN THE TASM GROUP WINDOW
===========================================

A) Creating a Program Group Window for TASM 5.0.
------------------------------------------------
If the Borland C++ Program Group Window didn't appear
after installation you can create one by choosing one of
the following options:

   - Generate icons by running the groups.exe:
     From within Windows, choose File|Run, and type:

	   c:\windows\groups.exe groups.b$$

     If nothing appears to happen, it is possible that the
     data file (groups.b$$) was not created properly.

   - Manually creating the icons. Load Windows, choose
     File|New|Program Group, and click on OK. Type the
     name you want for the program group window in the
     "Description:" text box, such as Borland TASM 5.0. Leave
     "Group File" line blank. Click OK. A new Window appears.
     Choose File|New|Program Item to create icons for the
     Windows programs and click OK. Select one of the
     Windows executable programs to create an icon for, such
     as TDW.EXE (you can also use the Browse button). Type
     the name of that executable program in the Description
     text box. Type the full path name to the executable in
     the Command Line text box. Typing a path name for the
     working directory is optional. The default is the
     WINDOWS directory. Click OK. The icon appears in
     the active program group window. Repeat these steps
     for executable program you want to use.


B) List of Icons and Executable Files
-------------------------------------
The following table contains a list of executable files that
each icon calls, as well as the name of the icon for that
executable, if there is one:

    TASM.HLP=F:\TASM\BIN, Tasm Reference, HELP.ICO
    TDW.EXE=F:\TASM\BIN, Turbo Debugger for Windows, TDW.ICO
    TDWINST.EXE=F:\TASM\BIN, TDW Configuration, TDWINST.ICO
    WREMOTE.EXE=F:\TASM\BIN, Remote Debugging
    WRSETUP.EXE=F:\TASM\BIN, Remote Setup
    TD.PIF=F:\TASM\BIN, Turbo Debugger for DOS, TDDOS.ICO
    TDINST.EXE=F:\TASM\BIN, TD Configuration, TDOSINST.ICO
    TD32.EXE=F:\TASM\BIN, Turbo Debugger for Win32, TD32.ICO
    TD32INST.EXE=F:\TASM\BIN, TD32 Configuration, TD32INST.ICO
    TDWINI.EXE=F:\TASM\BIN, TD Video Configuration


SECTION -7-  USING TASM FROM WINDOWS
====================================
The TASM installation creates a TASM 5.0 group in the Windows
Program Manager. However, the installation program does not
create Windows PIF files to run any of the command line tools.

TASM.EXE and all other 16-bit executable tools can be run through
a regular Windows DOS box.

To run TASM32 from a Windows DOS box, you need to use an icon
created with a PIF file. You can use the PIF file B32TOOLS.PIF
(located in the TASM\BIN directory) to run the 32-bit tools
from a Windows DOS box. This PIF file references COMMAND.COM.
When you double click the icon, a DOS box activates, and you
can run TASM32.EXE and TLINK32.EXE from it.


SECTION -8-  HOW TO GET A TECHNICAL INFORMATION DOCUMENT
========================================================
Technical Information Documents contain tips, techniques,
and enhanced information on using Borland development tools,
and information on commonly asked programming questions.
Such documents often include programming examples. These
documents can be accessed via modem or fax. Technical
files which contain binary modules, such as patches for
released Borland products, are normally available only from
those services that can be accessed by modem. Documents can
be accessed from the following sources:


A) Fax the document from Borland's TechFax Service
--------------------------------------------------
Call (800) 822-4269 from a touch-tone phone. When
prompted, enter your FAX number, then enter the document
number you want to receive. The document will be faxed to
you shortly.

Here is a list of common Technical Information Documents:

      * 3       General Catalog of All Documents Available
      * 649     General Protection Faults
      * 1171    Problem Report Form
      * 1010    Installing and Configuring BC++
      * 806     Network Installations
      * 738     Memory Corruption
      * 1561    Clean Boot


B) Download the document from
-----------------------------
   -The Borland Download Bulletin Board Service (DLBBS)
    (408) 431-5096, protocol 8N1
   -The Borland Automated Online Service (OAS)
    (408) 431-5250, protocol 8N1
   -The Borland-supported FTP site on Internet
    ftp.cica.indiana.edu, IP address [129.79.20.27]
   -Borland-supported forums on CompuServe, Genie, BIX.
	For CIS type:
	   go BCPPWIN
             or
	   go BCPPDOS
	and choose library 2

	For BIX type: join Borland

	For GENIE type: Borland

   Below are steps to download a Technical Information
   Document from the Borland DLBBS.

   For proper display, your communication software should
   provide ANSI terminal support. Most packages provide
   VT-100 terminal emulation, which is fine for the DLBBS.
   If you're using a Windows based package, select a screen
   font (such as: Terminal) that includes extended ASCII
   characters.

   Once connected, you'll be prompted to enter your first
   and last name and a password. If you haven't used the
   service before, you'll be asked to verify your name and
   then answer a few questions. The menu-driven system
   guides you through the various product and file
   areas. You'll always receive a list of options when you
   are prompted to make any choice.


   MANEUVERING THE MAIN MENU
   - - - - - - - - - - - - -
   First join the C++ Conference. The Main Menu shows the
   product whose files you can access. At the Main menu,
   type "F" to select the Files menu.


   DOWNLOADING FILES
   - - - - - - - - -
   Once you know the name of the file you want to download,
   type "D" for download at the File menu. When prompted,
   type the full name of the file or files. All Technical
   Information Documents have the form "TI#.ZIP". Replace
   the # with the appropriate document number. For example,
   to download Technical Information Document number 649,
   the full name of the file is TI649.ZIP. If you do not
   know the protocol or download keys to press, refer to
   your telecommunications manual.


   WORKING WITH DOWNLOADED FILES
   - - - - - - - - - - - - - - -
   Most of the files on the Download BBS are stored and
   transferred in an archived (compressed) format and need
   to be unarchived before they can be used. If you don't
   have the unarchiving utility PKUNZIP v.204G or newer,
   download PKZ204G.EXE from the DLBBS and execute it.
   You'll receive PKUNZIP and PKZIP utilities. To unarchive
   the file, type the name of an unarchive utility
   (UNPACK, UNZIP or PKUNZIP) and then the name of the
   archived file. For example:

	PKUNZIP TI649.ZIP


SECTION -9-  BOOT CLEAN
========================
This section describes the process of "booting clean" on
IBM PC's and compatible computers with DOS and/or windows.
This document assumes you have MS-DOS version 5.00 or higher.
"Booting Clean" is the process of booting without loading
device drivers and TSRs. Device drivers such as mouse
drivers, network drivers, TSRs, etc. can cause memory
conflicts.

These device drivers and TSRs are usually loaded in two
files (AUTOEXEC.BAT and CONFIG.SYS typically located on
the root directory of your hard disk). The safest
method of booting clean is to create a "bootable" floppy
disk in drive A:. See the "Making a Boot Disk" section
below.

If you are using a program that runs under Microsoft
Windows, then you might need to make changes to some Windows
configuration files in order to ensure a "clean system
configuration" under Windows. The two files you will need
to examine are WIN.INI and SYSTEM.INI. These files are
located in the WINDOWS subdirectory on your hard disk. The
changes that you will need to make to these files (if any)
are outlined below.


Making a Boot Disk
- - - - - - - - - -
In order to make a bootable floppy disk, follow the
instructions below. NOTE: These instructions assume that
your hard disk is C: and your DOS and WINDOWS subdirectories
appear on this disk. (Most cases):

     1) Place a blank disk in drive A:
     2) type  format a: /s (format the disk)

At this point you now have a bootable floppy disk. Using
EDIT, ensure your AUTOEXEC.BAT and CONFIG.SYS look like
one of the configuration choices below.

Your "clean" system configuration should be exactly like
one of the choices below except replace "<Insert REQUIRED
drivers here>" with any required drivers. The ONLY
required drivers are, for example, disk compression and/or
hard disk access drivers. This does not include mouse
drivers and disk caching utilities such as SmartDrive.


Clean Configuration DOS 5.0 and DOS 6.x running Windows
-------------------------------------------------------
   1) Insert your "bootable floppy" in drive A.
   2) Type "EDIT A:\CONFIG.SYS"
   3) Type in the following:

          <Insert REQUIRED drivers here>
          DEVICE=C:\DOS\HIMEM.SYS
          FILES=40
          BUFFERS=40

   4) Exit the editor (Alt-F, then X, then Y).
   5) Type "EDIT A:\AUTOEXEC.BAT"
   6) Type in the following:

          <Insert REQUIRED drivers here>
          PATH=C:\WINDOWS;C:\DOS;C:\BC4\BIN
          PROMPT $P$G

   7) Exit the editor (Alt-F, then X, then Y).
   8) Type "CD \WINDOWS:
   9) Type "COPY WIN.INI WIN.BAK"
  10) Type "COPY SYSTEM.INI SYSTEM.BAK"
  11) Type "EDIT WIN.INI"
  12) Make sure that the "load=" and "run=" lines in your
      WIN.INI file match the following lines:

          [windows]
          spooler=yes
          load=
          run=
          Beep=yes

  13) Exit the editor (Alt-F, then X, then Y).
  14) Type "EDIT system.ini"
  15) Ensure that your "shell=" line in your SYSTEM.INI file
       matches the following:

          [boot]
          shell=progman.exe

  16) Exit the editor (Alt-F, then X, then Y).
  17) Make sure your "Bootable floppy" is in drive A: and
      reboot your computer.

/**************************** END OF FILE ********************************/

