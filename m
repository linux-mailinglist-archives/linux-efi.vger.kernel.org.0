Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 442AD4AC43
	for <lists+linux-efi@lfdr.de>; Tue, 18 Jun 2019 22:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730932AbfFRUyn (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 18 Jun 2019 16:54:43 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51080 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730789AbfFRUyA (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 18 Jun 2019 16:54:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=itVVmUj1d9OSkVZl/zzSQ3iI9c2SY4cubmTBhtAor+M=; b=oyDGFD5mechR6Vzx+YCVnUoeNn
        6z/STfMn2bylZvczMKutv/eUkcP0LUK8g9z7QpXJd0XT7Xkum/iE4G2ZcntJ7loLTo5FiJaMUfEQT
        RKrWFx/Vo8dD5G0sIIXChvcOxQPmNmm5F4neY3Wr3JkIQbTYnVHxd2K8SXO8woD98tvduj/7IlmQb
        1jlRiFTnSi4TZ+5p2DE3EoAq2upHDtoVok0rK0QUYp42EWh5STb1ke7fakkB81vSz802iiQ9vxsUx
        KbZyvI5BY6ANDnOJ05T5Du5W7BAkXR7udxGEC0qh78tdRS9oy8LeYLEHVIr8bfUKvO631/0CMKpuI
        9ZD8F7Uw==;
Received: from 177.133.86.196.dynamic.adsl.gvt.net.br ([177.133.86.196] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hdL77-0008SX-Jr; Tue, 18 Jun 2019 20:53:58 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hdL70-000206-5U; Tue, 18 Jun 2019 17:53:50 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Pat Gefre <pfg@sgi.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>, linux-ia64@vger.kernel.org,
        linux-efi@vger.kernel.org
Subject: [PATCH v2 19/29] docs: ia64: convert to ReST
Date:   Tue, 18 Jun 2019 17:53:37 -0300
Message-Id: <87fcaf5ae3c2d189300d72041635d133d9cb3d66.1560890801.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1560890800.git.mchehab+samsung@kernel.org>
References: <cover.1560890800.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Rename the ia64 documentation files to ReST, add an
index for them and adjust in order to produce a nice html
output via the Sphinx build system.

There are two upper case file names. Rename them to
lower case, as we're working to avoid upper case file
names at Documentation.

At its new index.rst, let's add a :orphan: while this is not linked to
the main index.rst file, in order to avoid build warnings.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 .../ia64/{aliasing.txt => aliasing.rst}       |  73 ++--
 Documentation/ia64/{efirtc.txt => efirtc.rst} | 118 +++---
 .../ia64/{err_inject.txt => err_inject.rst}   | 349 +++++++++---------
 Documentation/ia64/{fsys.txt => fsys.rst}     | 127 ++++---
 Documentation/ia64/{README => ia64.rst}       |  26 +-
 Documentation/ia64/index.rst                  |  18 +
 .../ia64/{IRQ-redir.txt => irq-redir.rst}     |  31 +-
 Documentation/ia64/{mca.txt => mca.rst}       |  10 +-
 Documentation/ia64/{serial.txt => serial.rst} |  36 +-
 Documentation/ia64/xen.rst                    | 206 +++++++++++
 Documentation/ia64/xen.txt                    | 183 ---------
 MAINTAINERS                                   |   2 +-
 arch/ia64/kernel/efi.c                        |   2 +-
 arch/ia64/kernel/fsys.S                       |   2 +-
 arch/ia64/mm/ioremap.c                        |   2 +-
 arch/ia64/pci/pci.c                           |   2 +-
 16 files changed, 660 insertions(+), 527 deletions(-)
 rename Documentation/ia64/{aliasing.txt => aliasing.rst} (83%)
 rename Documentation/ia64/{efirtc.txt => efirtc.rst} (70%)
 rename Documentation/ia64/{err_inject.txt => err_inject.rst} (82%)
 rename Documentation/ia64/{fsys.txt => fsys.rst} (76%)
 rename Documentation/ia64/{README => ia64.rst} (61%)
 create mode 100644 Documentation/ia64/index.rst
 rename Documentation/ia64/{IRQ-redir.txt => irq-redir.rst} (86%)
 rename Documentation/ia64/{mca.txt => mca.rst} (96%)
 rename Documentation/ia64/{serial.txt => serial.rst} (87%)
 create mode 100644 Documentation/ia64/xen.rst
 delete mode 100644 Documentation/ia64/xen.txt

diff --git a/Documentation/ia64/aliasing.txt b/Documentation/ia64/aliasing.rst
similarity index 83%
rename from Documentation/ia64/aliasing.txt
rename to Documentation/ia64/aliasing.rst
index 5a4dea6abebd..a08b36aba015 100644
--- a/Documentation/ia64/aliasing.txt
+++ b/Documentation/ia64/aliasing.rst
@@ -1,20 +1,25 @@
-	         MEMORY ATTRIBUTE ALIASING ON IA-64
+==================================
+Memory Attribute Aliasing on IA-64
+==================================
 
-			   Bjorn Helgaas
-		       <bjorn.helgaas@hp.com>
-			    May 4, 2006
+Bjorn Helgaas <bjorn.helgaas@hp.com>
 
+May 4, 2006
 
-MEMORY ATTRIBUTES
+
+Memory Attributes
+=================
 
     Itanium supports several attributes for virtual memory references.
     The attribute is part of the virtual translation, i.e., it is
     contained in the TLB entry.  The ones of most interest to the Linux
     kernel are:
 
-	WB		Write-back (cacheable)
+	==		======================
+        WB		Write-back (cacheable)
 	UC		Uncacheable
 	WC		Write-coalescing
+	==		======================
 
     System memory typically uses the WB attribute.  The UC attribute is
     used for memory-mapped I/O devices.  The WC attribute is uncacheable
@@ -29,7 +34,8 @@ MEMORY ATTRIBUTES
     support either WB or UC access to main memory, while others support
     only WB access.
 
-MEMORY MAP
+Memory Map
+==========
 
     Platform firmware describes the physical memory map and the
     supported attributes for each region.  At boot-time, the kernel uses
@@ -55,7 +61,8 @@ MEMORY MAP
     The efi_memmap table is preserved unmodified because the original
     boot-time information is required for kexec.
 
-KERNEL IDENTITY MAPPINGS
+Kernel Identify Mappings
+========================
 
     Linux/ia64 identity mappings are done with large pages, currently
     either 16MB or 64MB, referred to as "granules."  Cacheable mappings
@@ -74,17 +81,20 @@ KERNEL IDENTITY MAPPINGS
     are only partially populated, or populated with a combination of UC
     and WB regions.
 
-USER MAPPINGS
+User Mappings
+=============
 
     User mappings are typically done with 16K or 64K pages.  The smaller
     page size allows more flexibility because only 16K or 64K has to be
     homogeneous with respect to memory attributes.
 
-POTENTIAL ATTRIBUTE ALIASING CASES
+Potential Attribute Aliasing Cases
+==================================
 
     There are several ways the kernel creates new mappings:
 
-    mmap of /dev/mem
+mmap of /dev/mem
+----------------
 
 	This uses remap_pfn_range(), which creates user mappings.  These
 	mappings may be either WB or UC.  If the region being mapped
@@ -98,7 +108,8 @@ POTENTIAL ATTRIBUTE ALIASING CASES
 	Since the EFI memory map does not describe MMIO on some
 	machines, this should use an uncacheable mapping as a fallback.
 
-    mmap of /sys/class/pci_bus/.../legacy_mem
+mmap of /sys/class/pci_bus/.../legacy_mem
+-----------------------------------------
 
 	This is very similar to mmap of /dev/mem, except that legacy_mem
 	only allows mmap of the one megabyte "legacy MMIO" area for a
@@ -112,9 +123,10 @@ POTENTIAL ATTRIBUTE ALIASING CASES
 
 	The /dev/mem mmap constraints apply.
 
-    mmap of /proc/bus/pci/.../??.?
+mmap of /proc/bus/pci/.../??.?
+------------------------------
 
-    	This is an MMIO mmap of PCI functions, which additionally may or
+	This is an MMIO mmap of PCI functions, which additionally may or
 	may not be requested as using the WC attribute.
 
 	If WC is requested, and the region in kern_memmap is either WC
@@ -124,7 +136,8 @@ POTENTIAL ATTRIBUTE ALIASING CASES
 	Otherwise, the user mapping must use the same attribute as the
 	kernel mapping.
 
-    read/write of /dev/mem
+read/write of /dev/mem
+----------------------
 
 	This uses copy_from_user(), which implicitly uses a kernel
 	identity mapping.  This is obviously safe for things in
@@ -138,7 +151,8 @@ POTENTIAL ATTRIBUTE ALIASING CASES
 	eight-byte accesses, and the copy_from_user() path doesn't allow
 	any control over the access size, so this would be dangerous.
 
-    ioremap()
+ioremap()
+---------
 
 	This returns a mapping for use inside the kernel.
 
@@ -155,9 +169,11 @@ POTENTIAL ATTRIBUTE ALIASING CASES
 
 	Failing all of the above, we have to fall back to a UC mapping.
 
-PAST PROBLEM CASES
+Past Problem Cases
+==================
 
-    mmap of various MMIO regions from /dev/mem by "X" on Intel platforms
+mmap of various MMIO regions from /dev/mem by "X" on Intel platforms
+--------------------------------------------------------------------
 
       The EFI memory map may not report these MMIO regions.
 
@@ -166,12 +182,16 @@ PAST PROBLEM CASES
       succeed.  It may create either WB or UC user mappings, depending
       on whether the region is in kern_memmap or the EFI memory map.
 
-    mmap of 0x0-0x9FFFF /dev/mem by "hwinfo" on HP sx1000 with VGA enabled
+mmap of 0x0-0x9FFFF /dev/mem by "hwinfo" on HP sx1000 with VGA enabled
+----------------------------------------------------------------------
 
       The EFI memory map reports the following attributes:
+
+        =============== ======= ==================
         0x00000-0x9FFFF WB only
         0xA0000-0xBFFFF UC only (VGA frame buffer)
         0xC0000-0xFFFFF WB only
+        =============== ======= ==================
 
       This mmap is done with user pages, not kernel identity mappings,
       so it is safe to use WB mappings.
@@ -182,7 +202,8 @@ PAST PROBLEM CASES
       never generate an uncacheable reference to the WB-only areas unless
       the driver explicitly touches them.
 
-    mmap of 0x0-0xFFFFF legacy_mem by "X"
+mmap of 0x0-0xFFFFF legacy_mem by "X"
+-------------------------------------
 
       If the EFI memory map reports that the entire range supports the
       same attributes, we can allow the mmap (and we will prefer WB if
@@ -197,15 +218,18 @@ PAST PROBLEM CASES
       that doesn't report the VGA frame buffer at all), we should fail the
       mmap and force the user to map just the specific region of interest.
 
-    mmap of 0xA0000-0xBFFFF legacy_mem by "X" on HP sx1000 with VGA disabled
+mmap of 0xA0000-0xBFFFF legacy_mem by "X" on HP sx1000 with VGA disabled
+------------------------------------------------------------------------
+
+      The EFI memory map reports the following attributes::
 
-      The EFI memory map reports the following attributes:
         0x00000-0xFFFFF WB only (no VGA MMIO hole)
 
       This is a special case of the previous case, and the mmap should
       fail for the same reason as above.
 
-    read of /sys/devices/.../rom
+read of /sys/devices/.../rom
+----------------------------
 
       For VGA devices, this may cause an ioremap() of 0xC0000.  This
       used to be done with a UC mapping, because the VGA frame buffer
@@ -215,7 +239,8 @@ PAST PROBLEM CASES
       We should use WB page table mappings to avoid covering the VGA
       frame buffer.
 
-NOTES
+Notes
+=====
 
     [1] SDM rev 2.2, vol 2, sec 4.4.1.
     [2] SDM rev 2.2, vol 2, sec 4.4.6.
diff --git a/Documentation/ia64/efirtc.txt b/Documentation/ia64/efirtc.rst
similarity index 70%
rename from Documentation/ia64/efirtc.txt
rename to Documentation/ia64/efirtc.rst
index 057e6bebda8f..2f7ff5026308 100644
--- a/Documentation/ia64/efirtc.txt
+++ b/Documentation/ia64/efirtc.rst
@@ -1,12 +1,16 @@
+==========================
 EFI Real Time Clock driver
--------------------------------
+==========================
+
 S. Eranian <eranian@hpl.hp.com>
+
 March 2000
 
-I/ Introduction
+1. Introduction
+===============
 
 This document describes the efirtc.c driver has provided for
-the IA-64 platform. 
+the IA-64 platform.
 
 The purpose of this driver is to supply an API for kernel and user applications
 to get access to the Time Service offered by EFI version 0.92.
@@ -16,112 +20,124 @@ SetTime(), GetWakeupTime(), SetWakeupTime() which are all supported by this
 driver. We describe those calls as well the design of the driver in the
 following sections.
 
-II/ Design Decisions
+2. Design Decisions
+===================
 
-The original ideas was to provide a very simple driver to get access to, 
-at first, the time of day service. This is required in order to access, in a 
-portable way, the CMOS clock. A program like /sbin/hwclock uses such a clock 
+The original ideas was to provide a very simple driver to get access to,
+at first, the time of day service. This is required in order to access, in a
+portable way, the CMOS clock. A program like /sbin/hwclock uses such a clock
 to initialize the system view of the time during boot.
 
 Because we wanted to minimize the impact on existing user-level apps using
 the CMOS clock, we decided to expose an API that was very similar to the one
-used today with the legacy RTC driver (driver/char/rtc.c). However, because 
+used today with the legacy RTC driver (driver/char/rtc.c). However, because
 EFI provides a simpler services, not all ioctl() are available. Also
-new ioctl()s have been introduced for things that EFI provides but not the 
+new ioctl()s have been introduced for things that EFI provides but not the
 legacy.
 
 EFI uses a slightly different way of representing the time, noticeably
 the reference date is different. Year is the using the full 4-digit format.
 The Epoch is January 1st 1998. For backward compatibility reasons we don't
-expose this new way of representing time. Instead we use something very 
+expose this new way of representing time. Instead we use something very
 similar to the struct tm, i.e. struct rtc_time, as used by hwclock.
 One of the reasons for doing it this way is to allow for EFI to still evolve
 without necessarily impacting any of the user applications. The decoupling
 enables flexibility and permits writing wrapper code is ncase things change.
 
 The driver exposes two interfaces, one via the device file and a set of
-ioctl()s. The other is read-only via the /proc filesystem. 
+ioctl()s. The other is read-only via the /proc filesystem.
 
 As of today we don't offer a /proc/sys interface.
 
 To allow for a uniform interface between the legacy RTC and EFI time service,
-we have created the include/linux/rtc.h header file to contain only the 
-"public" API of the two drivers.  The specifics of the legacy RTC are still 
+we have created the include/linux/rtc.h header file to contain only the
+"public" API of the two drivers.  The specifics of the legacy RTC are still
 in include/linux/mc146818rtc.h.
 
- 
-III/ Time of day service
+
+3. Time of day service
+======================
 
 The part of the driver gives access to the time of day service of EFI.
 Two ioctl()s, compatible with the legacy RTC calls:
 
-	Read the CMOS clock: ioctl(d, RTC_RD_TIME, &rtc);
+	Read the CMOS clock::
 
-	Write the CMOS clock: ioctl(d, RTC_SET_TIME, &rtc);
+		ioctl(d, RTC_RD_TIME, &rtc);
+
+	Write the CMOS clock::
+
+		ioctl(d, RTC_SET_TIME, &rtc);
 
 The rtc is a pointer to a data structure defined in rtc.h which is close
-to a struct tm:
+to a struct tm::
 
-struct rtc_time {
-        int tm_sec;
-        int tm_min;
-        int tm_hour;
-        int tm_mday;
-        int tm_mon;
-        int tm_year;
-        int tm_wday;
-        int tm_yday;
-        int tm_isdst;
-};
+  struct rtc_time {
+          int tm_sec;
+          int tm_min;
+          int tm_hour;
+          int tm_mday;
+          int tm_mon;
+          int tm_year;
+          int tm_wday;
+          int tm_yday;
+          int tm_isdst;
+  };
 
 The driver takes care of converting back an forth between the EFI time and
 this format.
 
 Those two ioctl()s can be exercised with the hwclock command:
 
-For reading:
-# /sbin/hwclock --show
-Mon Mar  6 15:32:32 2000  -0.910248 seconds
+For reading::
 
-For setting:
-# /sbin/hwclock --systohc
+	# /sbin/hwclock --show
+	Mon Mar  6 15:32:32 2000  -0.910248 seconds
+
+For setting::
+
+	# /sbin/hwclock --systohc
 
 Root privileges are required to be able to set the time of day.
 
-IV/ Wakeup Alarm service
+4. Wakeup Alarm service
+=======================
 
 EFI provides an API by which one can program when a machine should wakeup,
 i.e. reboot. This is very different from the alarm provided by the legacy
 RTC which is some kind of interval timer alarm. For this reason we don't use
 the same ioctl()s to get access to the service. Instead we have
-introduced 2 news ioctl()s to the interface of an RTC. 
+introduced 2 news ioctl()s to the interface of an RTC.
 
 We have added 2 new ioctl()s that are specific to the EFI driver:
 
-	Read the current state of the alarm
-	ioctl(d, RTC_WKLAM_RD, &wkt)
+	Read the current state of the alarm::
 
-	Set the alarm or change its status
-	ioctl(d, RTC_WKALM_SET, &wkt)
+		ioctl(d, RTC_WKLAM_RD, &wkt)
 
-The wkt structure encapsulates a struct rtc_time + 2 extra fields to get 
-status information:
-	
-struct rtc_wkalrm {
+	Set the alarm or change its status::
 
-        unsigned char enabled; /* =1 if alarm is enabled */
-        unsigned char pending; /* =1 if alarm is pending  */
+		ioctl(d, RTC_WKALM_SET, &wkt)
 
-        struct rtc_time time;
-} 
+The wkt structure encapsulates a struct rtc_time + 2 extra fields to get
+status information::
+
+  struct rtc_wkalrm {
+
+          unsigned char enabled; /* =1 if alarm is enabled */
+          unsigned char pending; /* =1 if alarm is pending  */
+
+          struct rtc_time time;
+  }
 
 As of today, none of the existing user-level apps supports this feature.
-However writing such a program should be hard by simply using those two 
-ioctl(). 
+However writing such a program should be hard by simply using those two
+ioctl().
 
 Root privileges are required to be able to set the alarm.
 
-V/ References.
+5. References
+=============
 
 Checkout the following Web site for more information on EFI:
 
diff --git a/Documentation/ia64/err_inject.txt b/Documentation/ia64/err_inject.rst
similarity index 82%
rename from Documentation/ia64/err_inject.txt
rename to Documentation/ia64/err_inject.rst
index 9f651c181429..900f71e93a29 100644
--- a/Documentation/ia64/err_inject.txt
+++ b/Documentation/ia64/err_inject.rst
@@ -1,4 +1,4 @@
-
+========================================
 IPF Machine Check (MC) error inject tool
 ========================================
 
@@ -32,94 +32,94 @@ Errata: Itanium 2 Processors Specification Update lists some errata against
 the pal_mc_error_inject PAL procedure. The following err.conf has been tested
 on latest Montecito PAL.
 
-err.conf:
+err.conf::
 
-#This is configuration file for err_inject_tool.
-#The format of the each line is:
-#cpu, loop, interval, err_type_info, err_struct_info, err_data_buffer
-#where
-#	cpu: logical cpu number the error will be inject in.
-#	loop: times the error will be injected.
-#	interval: In second. every so often one error is injected.
-#	err_type_info, err_struct_info: PAL parameters.
-#
-#Note: All values are hex w/o or w/ 0x prefix.
+  #This is configuration file for err_inject_tool.
+  #The format of the each line is:
+  #cpu, loop, interval, err_type_info, err_struct_info, err_data_buffer
+  #where
+  #	cpu: logical cpu number the error will be inject in.
+  #	loop: times the error will be injected.
+  #	interval: In second. every so often one error is injected.
+  #	err_type_info, err_struct_info: PAL parameters.
+  #
+  #Note: All values are hex w/o or w/ 0x prefix.
 
 
-#On cpu2, inject only total 0x10 errors, interval 5 seconds
-#corrected, data cache, hier-2, physical addr(assigned by tool code).
-#working on Montecito latest PAL.
-2, 10, 5, 4101, 95
+  #On cpu2, inject only total 0x10 errors, interval 5 seconds
+  #corrected, data cache, hier-2, physical addr(assigned by tool code).
+  #working on Montecito latest PAL.
+  2, 10, 5, 4101, 95
 
-#On cpu4, inject and consume total 0x10 errors, interval 5 seconds
-#corrected, data cache, hier-2, physical addr(assigned by tool code).
-#working on Montecito latest PAL.
-4, 10, 5, 4109, 95
+  #On cpu4, inject and consume total 0x10 errors, interval 5 seconds
+  #corrected, data cache, hier-2, physical addr(assigned by tool code).
+  #working on Montecito latest PAL.
+  4, 10, 5, 4109, 95
 
-#On cpu15, inject and consume total 0x10 errors, interval 5 seconds
-#recoverable, DTR0, hier-2.
-#working on Montecito latest PAL.
-0xf, 0x10, 5, 4249, 15
+  #On cpu15, inject and consume total 0x10 errors, interval 5 seconds
+  #recoverable, DTR0, hier-2.
+  #working on Montecito latest PAL.
+  0xf, 0x10, 5, 4249, 15
 
 The sample application source code:
 
-err_injection_tool.c:
+err_injection_tool.c::
 
-/*
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE, GOOD TITLE or
- * NON INFRINGEMENT.  See the GNU General Public License for more
- * details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
- *
- * Copyright (C) 2006 Intel Co
- *	Fenghua Yu <fenghua.yu@intel.com>
- *
- */
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <fcntl.h>
-#include <stdio.h>
-#include <sched.h>
-#include <unistd.h>
-#include <stdlib.h>
-#include <stdarg.h>
-#include <string.h>
-#include <errno.h>
-#include <time.h>
-#include <sys/ipc.h>
-#include <sys/sem.h>
-#include <sys/wait.h>
-#include <sys/mman.h>
-#include <sys/shm.h>
+  /*
+   * This program is free software; you can redistribute it and/or modify
+   * it under the terms of the GNU General Public License as published by
+   * the Free Software Foundation; either version 2 of the License, or
+   * (at your option) any later version.
+   *
+   * This program is distributed in the hope that it will be useful, but
+   * WITHOUT ANY WARRANTY; without even the implied warranty of
+   * MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE, GOOD TITLE or
+   * NON INFRINGEMENT.  See the GNU General Public License for more
+   * details.
+   *
+   * You should have received a copy of the GNU General Public License
+   * along with this program; if not, write to the Free Software
+   * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+   *
+   * Copyright (C) 2006 Intel Co
+   *	Fenghua Yu <fenghua.yu@intel.com>
+   *
+   */
+  #include <sys/types.h>
+  #include <sys/stat.h>
+  #include <fcntl.h>
+  #include <stdio.h>
+  #include <sched.h>
+  #include <unistd.h>
+  #include <stdlib.h>
+  #include <stdarg.h>
+  #include <string.h>
+  #include <errno.h>
+  #include <time.h>
+  #include <sys/ipc.h>
+  #include <sys/sem.h>
+  #include <sys/wait.h>
+  #include <sys/mman.h>
+  #include <sys/shm.h>
 
-#define MAX_FN_SIZE 		256
-#define MAX_BUF_SIZE 		256
-#define DATA_BUF_SIZE 		256
-#define NR_CPUS 		512
-#define MAX_TASK_NUM		2048
-#define MIN_INTERVAL		5	// seconds
-#define	ERR_DATA_BUFFER_SIZE 	3	// Three 8-byte.
-#define PARA_FIELD_NUM		5
-#define MASK_SIZE		(NR_CPUS/64)
-#define PATH_FORMAT "/sys/devices/system/cpu/cpu%d/err_inject/"
+  #define MAX_FN_SIZE 		256
+  #define MAX_BUF_SIZE 		256
+  #define DATA_BUF_SIZE 		256
+  #define NR_CPUS 		512
+  #define MAX_TASK_NUM		2048
+  #define MIN_INTERVAL		5	// seconds
+  #define	ERR_DATA_BUFFER_SIZE 	3	// Three 8-byte.
+  #define PARA_FIELD_NUM		5
+  #define MASK_SIZE		(NR_CPUS/64)
+  #define PATH_FORMAT "/sys/devices/system/cpu/cpu%d/err_inject/"
 
-int sched_setaffinity(pid_t pid, unsigned int len, unsigned long *mask);
+  int sched_setaffinity(pid_t pid, unsigned int len, unsigned long *mask);
 
-int verbose;
-#define vbprintf if (verbose) printf
+  int verbose;
+  #define vbprintf if (verbose) printf
 
-int log_info(int cpu, const char *fmt, ...)
-{
+  int log_info(int cpu, const char *fmt, ...)
+  {
 	FILE *log;
 	char fn[MAX_FN_SIZE];
 	char buf[MAX_BUF_SIZE];
@@ -142,12 +142,12 @@ int log_info(int cpu, const char *fmt, ...)
 	fclose(log);
 
 	return 0;
-}
+  }
 
-typedef unsigned long u64;
-typedef unsigned int  u32;
+  typedef unsigned long u64;
+  typedef unsigned int  u32;
 
-typedef union err_type_info_u {
+  typedef union err_type_info_u {
 	struct {
 		u64	mode		: 3,	/* 0-2 */
 			err_inj		: 3,	/* 3-5 */
@@ -157,9 +157,9 @@ typedef union err_type_info_u {
 			reserved	: 48;	/* 16-63 */
 	} err_type_info_u;
 	u64	err_type_info;
-} err_type_info_t;
+  } err_type_info_t;
 
-typedef union err_struct_info_u {
+  typedef union err_struct_info_u {
 	struct {
 		u64	siv		: 1,	/* 0	 */
 			c_t		: 2,	/* 1-2	 */
@@ -197,9 +197,9 @@ typedef union err_struct_info_u {
 		u64	reserved;
 	} err_struct_info_bus_processor_interconnect;
 	u64	err_struct_info;
-} err_struct_info_t;
+  } err_struct_info_t;
 
-typedef union err_data_buffer_u {
+  typedef union err_data_buffer_u {
 	struct {
 		u64	trigger_addr;		/* 0-63		*/
 		u64	inj_addr;		/* 64-127 	*/
@@ -221,9 +221,9 @@ typedef union err_data_buffer_u {
 		u64	reserved;		/* 0-63		*/
 	} err_data_buffer_bus_processor_interconnect;
 	u64 err_data_buffer[ERR_DATA_BUFFER_SIZE];
-} err_data_buffer_t;
+  } err_data_buffer_t;
 
-typedef union capabilities_u {
+  typedef union capabilities_u {
 	struct {
 		u64	i		: 1,
 			d		: 1,
@@ -276,9 +276,9 @@ typedef union capabilities_u {
 	struct {
 		u64	reserved;
 	} capabilities_bus_processor_interconnect;
-} capabilities_t;
+  } capabilities_t;
 
-typedef struct resources_s {
+  typedef struct resources_s {
 	u64	ibr0		: 1,
 		ibr2		: 1,
 		ibr4		: 1,
@@ -288,24 +288,24 @@ typedef struct resources_s {
 		dbr4		: 1,
 		dbr6		: 1,
 		reserved	: 48;
-} resources_t;
+  } resources_t;
 
 
-long get_page_size(void)
-{
+  long get_page_size(void)
+  {
 	long page_size=sysconf(_SC_PAGESIZE);
 	return page_size;
-}
+  }
 
-#define PAGE_SIZE (get_page_size()==-1?0x4000:get_page_size())
-#define SHM_SIZE (2*PAGE_SIZE*NR_CPUS)
-#define SHM_VA 0x2000000100000000
+  #define PAGE_SIZE (get_page_size()==-1?0x4000:get_page_size())
+  #define SHM_SIZE (2*PAGE_SIZE*NR_CPUS)
+  #define SHM_VA 0x2000000100000000
 
-int shmid;
-void *shmaddr;
+  int shmid;
+  void *shmaddr;
 
-int create_shm(void)
-{
+  int create_shm(void)
+  {
 	key_t key;
 	char fn[MAX_FN_SIZE];
 
@@ -343,34 +343,34 @@ int create_shm(void)
 	mlock(shmaddr, SHM_SIZE);
 
 	return 0;
-}
+  }
 
-int free_shm()
-{
+  int free_shm()
+  {
 	munlock(shmaddr, SHM_SIZE);
-        shmdt(shmaddr);
+          shmdt(shmaddr);
 	semctl(shmid, 0, IPC_RMID);
 
 	return 0;
-}
+  }
 
-#ifdef _SEM_SEMUN_UNDEFINED
-union semun
-{
+  #ifdef _SEM_SEMUN_UNDEFINED
+  union semun
+  {
 	int val;
 	struct semid_ds *buf;
 	unsigned short int *array;
 	struct seminfo *__buf;
-};
-#endif
+  };
+  #endif
 
-u32 mode=1; /* 1: physical mode; 2: virtual mode. */
-int one_lock=1;
-key_t key[NR_CPUS];
-int semid[NR_CPUS];
+  u32 mode=1; /* 1: physical mode; 2: virtual mode. */
+  int one_lock=1;
+  key_t key[NR_CPUS];
+  int semid[NR_CPUS];
 
-int create_sem(int cpu)
-{
+  int create_sem(int cpu)
+  {
 	union semun arg;
 	char fn[MAX_FN_SIZE];
 	int sid;
@@ -407,37 +407,37 @@ int create_sem(int cpu)
 	}
 
 	return 0;
-}
+  }
 
-static int lock(int cpu)
-{
+  static int lock(int cpu)
+  {
 	struct sembuf lock;
 
 	lock.sem_num = cpu;
 	lock.sem_op = 1;
 	semop(semid[cpu], &lock, 1);
 
-        return 0;
-}
+          return 0;
+  }
 
-static int unlock(int cpu)
-{
+  static int unlock(int cpu)
+  {
 	struct sembuf unlock;
 
 	unlock.sem_num = cpu;
 	unlock.sem_op = -1;
 	semop(semid[cpu], &unlock, 1);
 
-        return 0;
-}
+          return 0;
+  }
 
-void free_sem(int cpu)
-{
+  void free_sem(int cpu)
+  {
 	semctl(semid[cpu], 0, IPC_RMID);
-}
+  }
 
-int wr_multi(char *fn, unsigned long *data, int size)
-{
+  int wr_multi(char *fn, unsigned long *data, int size)
+  {
 	int fd;
 	char buf[MAX_BUF_SIZE];
 	int ret;
@@ -459,15 +459,15 @@ int wr_multi(char *fn, unsigned long *data, int size)
 	ret=write(fd, buf, sizeof(buf));
 	close(fd);
 	return ret;
-}
+  }
 
-int wr(char *fn, unsigned long data)
-{
+  int wr(char *fn, unsigned long data)
+  {
 	return wr_multi(fn, &data, 1);
-}
+  }
 
-int rd(char *fn, unsigned long *data)
-{
+  int rd(char *fn, unsigned long *data)
+  {
 	int fd;
 	char buf[MAX_BUF_SIZE];
 
@@ -480,10 +480,10 @@ int rd(char *fn, unsigned long *data)
 	*data=strtoul(buf, NULL, 16);
 	close(fd);
 	return 0;
-}
+  }
 
-int rd_status(char *path, int *status)
-{
+  int rd_status(char *path, int *status)
+  {
 	char fn[MAX_FN_SIZE];
 	sprintf(fn, "%s/status", path);
 	if (rd(fn, (u64*)status)<0) {
@@ -492,10 +492,10 @@ int rd_status(char *path, int *status)
 	}
 
 	return 0;
-}
+  }
 
-int rd_capabilities(char *path, u64 *capabilities)
-{
+  int rd_capabilities(char *path, u64 *capabilities)
+  {
 	char fn[MAX_FN_SIZE];
 	sprintf(fn, "%s/capabilities", path);
 	if (rd(fn, capabilities)<0) {
@@ -504,10 +504,10 @@ int rd_capabilities(char *path, u64 *capabilities)
 	}
 
 	return 0;
-}
+  }
 
-int rd_all(char *path)
-{
+  int rd_all(char *path)
+  {
 	unsigned long err_type_info, err_struct_info, err_data_buffer;
 	int status;
 	unsigned long capabilities, resources;
@@ -556,11 +556,11 @@ int rd_all(char *path)
 	printf("resources=%lx\n", resources);
 
 	return 0;
-}
+  }
 
-int query_capabilities(char *path, err_type_info_t err_type_info,
+  int query_capabilities(char *path, err_type_info_t err_type_info,
 			u64 *capabilities)
-{
+  {
 	char fn[MAX_FN_SIZE];
 	err_struct_info_t err_struct_info;
 	err_data_buffer_t err_data_buffer;
@@ -583,10 +583,10 @@ int query_capabilities(char *path, err_type_info_t err_type_info,
 		return -1;
 
 	return 0;
-}
+  }
 
-int query_all_capabilities()
-{
+  int query_all_capabilities()
+  {
 	int status;
 	err_type_info_t err_type_info;
 	int err_sev, err_struct, struct_hier;
@@ -629,12 +629,12 @@ int query_all_capabilities()
 	}
 
 	return 0;
-}
+  }
 
-int err_inject(int cpu, char *path, err_type_info_t err_type_info,
+  int err_inject(int cpu, char *path, err_type_info_t err_type_info,
 		err_struct_info_t err_struct_info,
 		err_data_buffer_t err_data_buffer)
-{
+  {
 	int status;
 	char fn[MAX_FN_SIZE];
 
@@ -667,13 +667,13 @@ int err_inject(int cpu, char *path, err_type_info_t err_type_info,
 	}
 
 	return status;
-}
+  }
 
-static int construct_data_buf(char *path, err_type_info_t err_type_info,
+  static int construct_data_buf(char *path, err_type_info_t err_type_info,
 		err_struct_info_t err_struct_info,
 		err_data_buffer_t *err_data_buffer,
 		void *va1)
-{
+  {
 	char fn[MAX_FN_SIZE];
 	u64 virt_addr=0, phys_addr=0;
 
@@ -710,22 +710,22 @@ static int construct_data_buf(char *path, err_type_info_t err_type_info,
 	}
 
 	return 0;
-}
+  }
 
-typedef struct {
+  typedef struct {
 	u64 cpu;
 	u64 loop;
 	u64 interval;
 	u64 err_type_info;
 	u64 err_struct_info;
 	u64 err_data_buffer[ERR_DATA_BUFFER_SIZE];
-} parameters_t;
+  } parameters_t;
 
-parameters_t line_para;
-int para;
+  parameters_t line_para;
+  int para;
 
-static int empty_data_buffer(u64 *err_data_buffer)
-{
+  static int empty_data_buffer(u64 *err_data_buffer)
+  {
 	int empty=1;
 	int i;
 
@@ -734,10 +734,10 @@ static int empty_data_buffer(u64 *err_data_buffer)
 		empty=0;
 
 	return empty;
-}
+  }
 
-int err_inj()
-{
+  int err_inj()
+  {
 	err_type_info_t err_type_info;
 	err_struct_info_t err_struct_info;
 	err_data_buffer_t err_data_buffer;
@@ -951,10 +951,10 @@ int err_inj()
 	printf("All done.\n");
 
 	return 0;
-}
+  }
 
-void help()
-{
+  void help()
+  {
 	printf("err_inject_tool:\n");
 	printf("\t-q: query all capabilities. default: off\n");
 	printf("\t-m: procedure mode. 1: physical 2: virtual. default: 1\n");
@@ -977,10 +977,10 @@ void help()
 	printf("The tool will take err.conf file as ");
 	printf("input to inject single or multiple errors ");
 	printf("on one or multiple cpus in parallel.\n");
-}
+  }
 
-int main(int argc, char **argv)
-{
+  int main(int argc, char **argv)
+  {
 	char c;
 	int do_err_inj=0;
 	int do_query_all=0;
@@ -1031,7 +1031,7 @@ int main(int argc, char **argv)
 				if (count!=PARA_FIELD_NUM+3) {
 				    line_para.err_data_buffer[0]=-1,
 				    line_para.err_data_buffer[1]=-1,
-			 	    line_para.err_data_buffer[2]=-1;
+				    line_para.err_data_buffer[2]=-1;
 				    count=sscanf(optarg, "%lx, %lx, %lx, %lx, %lx\n",
 						&line_para.cpu,
 						&line_para.loop,
@@ -1064,5 +1064,4 @@ int main(int argc, char **argv)
 		help();
 
 	return 0;
-}
-
+  }
diff --git a/Documentation/ia64/fsys.txt b/Documentation/ia64/fsys.rst
similarity index 76%
rename from Documentation/ia64/fsys.txt
rename to Documentation/ia64/fsys.rst
index 59dd689d9b86..a702d2cc94b6 100644
--- a/Documentation/ia64/fsys.txt
+++ b/Documentation/ia64/fsys.rst
@@ -1,9 +1,9 @@
--*-Mode: outline-*-
-
-		Light-weight System Calls for IA-64
-		-----------------------------------
+===================================
+Light-weight System Calls for IA-64
+===================================
 
 		        Started: 13-Jan-2003
+
 		    Last update: 27-Sep-2003
 
 	              David Mosberger-Tang
@@ -52,12 +52,13 @@ privilege level is at level 0, this means that fsys-mode requires some
 care (see below).
 
 
-* How to tell fsys-mode
+How to tell fsys-mode
+=====================
 
 Linux operates in fsys-mode when (a) the privilege level is 0 (most
 privileged) and (b) the stacks have NOT been switched to kernel memory
 yet.  For convenience, the header file <asm-ia64/ptrace.h> provides
-three macros:
+three macros::
 
 	user_mode(regs)
 	user_stack(task,regs)
@@ -70,11 +71,12 @@ to by "regs" was executing in user mode (privilege level 3).
 user_stack() returns TRUE if the state pointed to by "regs" was
 executing on the user-level stack(s).  Finally, fsys_mode() returns
 TRUE if the CPU state pointed to by "regs" was executing in fsys-mode.
-The fsys_mode() macro is equivalent to the expression:
+The fsys_mode() macro is equivalent to the expression::
 
 	!user_mode(regs) && user_stack(task,regs)
 
-* How to write an fsyscall handler
+How to write an fsyscall handler
+================================
 
 The file arch/ia64/kernel/fsys.S contains a table of fsyscall-handlers
 (fsyscall_table).  This table contains one entry for each system call.
@@ -87,66 +89,72 @@ of the getpid() system call.
 
 The entry and exit-state of an fsyscall handler is as follows:
 
-** Machine state on entry to fsyscall handler:
+Machine state on entry to fsyscall handler
+------------------------------------------
 
- - r10	  = 0
- - r11	  = saved ar.pfs (a user-level value)
- - r15	  = system call number
- - r16	  = "current" task pointer (in normal kernel-mode, this is in r13)
- - r32-r39 = system call arguments
- - b6	  = return address (a user-level value)
- - ar.pfs = previous frame-state (a user-level value)
- - PSR.be = cleared to zero (i.e., little-endian byte order is in effect)
- - all other registers may contain values passed in from user-mode
+  ========= ===============================================================
+  r10	    0
+  r11	    saved ar.pfs (a user-level value)
+  r15	    system call number
+  r16	    "current" task pointer (in normal kernel-mode, this is in r13)
+  r32-r39   system call arguments
+  b6	    return address (a user-level value)
+  ar.pfs    previous frame-state (a user-level value)
+  PSR.be    cleared to zero (i.e., little-endian byte order is in effect)
+  -         all other registers may contain values passed in from user-mode
+  ========= ===============================================================
 
-** Required machine state on exit to fsyscall handler:
+Required machine state on exit to fsyscall handler
+--------------------------------------------------
 
- - r11	  = saved ar.pfs (as passed into the fsyscall handler)
- - r15	  = system call number (as passed into the fsyscall handler)
- - r32-r39 = system call arguments (as passed into the fsyscall handler)
- - b6	  = return address (as passed into the fsyscall handler)
- - ar.pfs = previous frame-state (as passed into the fsyscall handler)
+  ========= ===========================================================
+  r11	    saved ar.pfs (as passed into the fsyscall handler)
+  r15	    system call number (as passed into the fsyscall handler)
+  r32-r39   system call arguments (as passed into the fsyscall handler)
+  b6	    return address (as passed into the fsyscall handler)
+  ar.pfs    previous frame-state (as passed into the fsyscall handler)
+  ========= ===========================================================
 
 Fsyscall handlers can execute with very little overhead, but with that
 speed comes a set of restrictions:
 
- o Fsyscall-handlers MUST check for any pending work in the flags
+ * Fsyscall-handlers MUST check for any pending work in the flags
    member of the thread-info structure and if any of the
    TIF_ALLWORK_MASK flags are set, the handler needs to fall back on
    doing a full system call (by calling fsys_fallback_syscall).
 
- o Fsyscall-handlers MUST preserve incoming arguments (r32-r39, r11,
+ * Fsyscall-handlers MUST preserve incoming arguments (r32-r39, r11,
    r15, b6, and ar.pfs) because they will be needed in case of a
    system call restart.  Of course, all "preserved" registers also
    must be preserved, in accordance to the normal calling conventions.
 
- o Fsyscall-handlers MUST check argument registers for containing a
+ * Fsyscall-handlers MUST check argument registers for containing a
    NaT value before using them in any way that could trigger a
    NaT-consumption fault.  If a system call argument is found to
    contain a NaT value, an fsyscall-handler may return immediately
    with r8=EINVAL, r10=-1.
 
- o Fsyscall-handlers MUST NOT use the "alloc" instruction or perform
+ * Fsyscall-handlers MUST NOT use the "alloc" instruction or perform
    any other operation that would trigger mandatory RSE
    (register-stack engine) traffic.
 
- o Fsyscall-handlers MUST NOT write to any stacked registers because
+ * Fsyscall-handlers MUST NOT write to any stacked registers because
    it is not safe to assume that user-level called a handler with the
    proper number of arguments.
 
- o Fsyscall-handlers need to be careful when accessing per-CPU variables:
+ * Fsyscall-handlers need to be careful when accessing per-CPU variables:
    unless proper safe-guards are taken (e.g., interruptions are avoided),
    execution may be pre-empted and resumed on another CPU at any given
    time.
 
- o Fsyscall-handlers must be careful not to leak sensitive kernel'
+ * Fsyscall-handlers must be careful not to leak sensitive kernel'
    information back to user-level.  In particular, before returning to
    user-level, care needs to be taken to clear any scratch registers
    that could contain sensitive information (note that the current
    task pointer is not considered sensitive: it's already exposed
    through ar.k6).
 
- o Fsyscall-handlers MUST NOT access user-memory without first
+ * Fsyscall-handlers MUST NOT access user-memory without first
    validating access-permission (this can be done typically via
    probe.r.fault and/or probe.w.fault) and without guarding against
    memory access exceptions (this can be done with the EX() macros
@@ -162,7 +170,8 @@ fast system call execution (while fully preserving system call
 semantics), but there is also a lot of flexibility in handling more
 complicated cases.
 
-* Signal handling
+Signal handling
+===============
 
 The delivery of (asynchronous) signals must be delayed until fsys-mode
 is exited.  This is accomplished with the help of the lower-privilege
@@ -173,7 +182,8 @@ PSR.lp and returns immediately.  When fsys-mode is exited via the
 occur.  The trap handler clears PSR.lp again and returns immediately.
 The kernel exit path then checks for and delivers any pending signals.
 
-* PSR Handling
+PSR Handling
+============
 
 The "epc" instruction doesn't change the contents of PSR at all.  This
 is in contrast to a regular interruption, which clears almost all
@@ -181,6 +191,7 @@ bits.  Because of that, some care needs to be taken to ensure things
 work as expected.  The following discussion describes how each PSR bit
 is handled.
 
+======= =======================================================================
 PSR.be	Cleared when entering fsys-mode.  A srlz.d instruction is used
 	to ensure the CPU is in little-endian mode before the first
 	load/store instruction is executed.  PSR.be is normally NOT
@@ -202,7 +213,8 @@ PSR.pp	Unchanged.
 PSR.di	Unchanged.
 PSR.si	Unchanged.
 PSR.db	Unchanged.  The kernel prevents user-level from setting a hardware
-	breakpoint that triggers at any privilege level other than 3 (user-mode).
+	breakpoint that triggers at any privilege level other than
+	3 (user-mode).
 PSR.lp	Unchanged.
 PSR.tb	Lazy redirect.  If a taken-branch trap occurs while in
 	fsys-mode, the trap-handler modifies the saved machine state
@@ -235,47 +247,52 @@ PSR.ed	Unchanged.  Note: This bit could only have an effect if an fsys-mode
 PSR.bn	Unchanged.  Note: fsys-mode handlers may clear the bit, if needed.
 	Doing so requires clearing PSR.i and PSR.ic as well.
 PSR.ia	Unchanged.  Note: the ia64 linux kernel never sets this bit.
+======= =======================================================================
 
-* Using fast system calls
+Using fast system calls
+=======================
 
 To use fast system calls, userspace applications need simply call
 __kernel_syscall_via_epc().  For example
 
 -- example fgettimeofday() call --
+
 -- fgettimeofday.S --
 
-#include <asm/asmmacro.h>
+::
 
-GLOBAL_ENTRY(fgettimeofday)
-.prologue
-.save ar.pfs, r11
-mov r11 = ar.pfs
-.body 
+  #include <asm/asmmacro.h>
 
-mov r2 = 0xa000000000020660;;  // gate address 
-			       // found by inspection of System.map for the 
+  GLOBAL_ENTRY(fgettimeofday)
+  .prologue
+  .save ar.pfs, r11
+  mov r11 = ar.pfs
+  .body
+
+  mov r2 = 0xa000000000020660;;  // gate address
+			       // found by inspection of System.map for the
 			       // __kernel_syscall_via_epc() function.  See
 			       // below for how to do this for real.
 
-mov b7 = r2
-mov r15 = 1087		       // gettimeofday syscall
-;;
-br.call.sptk.many b6 = b7
-;;
+  mov b7 = r2
+  mov r15 = 1087		       // gettimeofday syscall
+  ;;
+  br.call.sptk.many b6 = b7
+  ;;
 
-.restore sp
+  .restore sp
 
-mov ar.pfs = r11
-br.ret.sptk.many rp;;	      // return to caller
-END(fgettimeofday)
+  mov ar.pfs = r11
+  br.ret.sptk.many rp;;	      // return to caller
+  END(fgettimeofday)
 
 -- end fgettimeofday.S --
 
 In reality, getting the gate address is accomplished by two extra
 values passed via the ELF auxiliary vector (include/asm-ia64/elf.h)
 
- o AT_SYSINFO : is the address of __kernel_syscall_via_epc()
- o AT_SYSINFO_EHDR : is the address of the kernel gate ELF DSO
+ * AT_SYSINFO : is the address of __kernel_syscall_via_epc()
+ * AT_SYSINFO_EHDR : is the address of the kernel gate ELF DSO
 
 The ELF DSO is a pre-linked library that is mapped in by the kernel at
 the gate page.  It is a proper ELF shared object so, with a dynamic
diff --git a/Documentation/ia64/README b/Documentation/ia64/ia64.rst
similarity index 61%
rename from Documentation/ia64/README
rename to Documentation/ia64/ia64.rst
index aa17f2154cba..b725019a9492 100644
--- a/Documentation/ia64/README
+++ b/Documentation/ia64/ia64.rst
@@ -1,43 +1,49 @@
-        Linux kernel release 2.4.xx for the IA-64 Platform
+===========================================
+Linux kernel release for the IA-64 Platform
+===========================================
 
-   These are the release notes for Linux version 2.4 for IA-64
+   These are the release notes for Linux since version 2.4 for IA-64
    platform.  This document provides information specific to IA-64
    ONLY, to get additional information about the Linux kernel also
    read the original Linux README provided with the kernel.
 
-INSTALLING the kernel:
+Installing the Kernel
+=====================
 
  - IA-64 kernel installation is the same as the other platforms, see
    original README for details.
 
 
-SOFTWARE REQUIREMENTS
+Software Requirements
+=====================
 
    Compiling and running this kernel requires an IA-64 compliant GCC
    compiler.  And various software packages also compiled with an
    IA-64 compliant GCC compiler.
 
 
-CONFIGURING the kernel:
+Configuring the Kernel
+======================
 
    Configuration is the same, see original README for details.
 
 
-COMPILING the kernel:
+Compiling the Kernel:
 
  - Compiling this kernel doesn't differ from other platform so read
    the original README for details BUT make sure you have an IA-64
    compliant GCC compiler.
 
-IA-64 SPECIFICS
+IA-64 Specifics
+===============
 
  - General issues:
 
-    o Hardly any performance tuning has been done. Obvious targets
+    * Hardly any performance tuning has been done. Obvious targets
       include the library routines (IP checksum, etc.). Less
       obvious targets include making sure we don't flush the TLB
       needlessly, etc.
 
-    o SMP locks cleanup/optimization
+    * SMP locks cleanup/optimization
 
-    o IA32 support.  Currently experimental.  It mostly works.
+    * IA32 support.  Currently experimental.  It mostly works.
diff --git a/Documentation/ia64/index.rst b/Documentation/ia64/index.rst
new file mode 100644
index 000000000000..a3e3052ad6e2
--- /dev/null
+++ b/Documentation/ia64/index.rst
@@ -0,0 +1,18 @@
+:orphan:
+
+==================
+IA-64 Architecture
+==================
+
+.. toctree::
+   :maxdepth: 1
+
+   ia64
+   aliasing
+   efirtc
+   err_inject
+   fsys
+   irq-redir
+   mca
+   serial
+   xen
diff --git a/Documentation/ia64/IRQ-redir.txt b/Documentation/ia64/irq-redir.rst
similarity index 86%
rename from Documentation/ia64/IRQ-redir.txt
rename to Documentation/ia64/irq-redir.rst
index f7bd72261283..39bf94484a15 100644
--- a/Documentation/ia64/IRQ-redir.txt
+++ b/Documentation/ia64/irq-redir.rst
@@ -1,6 +1,8 @@
+==============================
 IRQ affinity on IA64 platforms
-------------------------------
-                           07.01.2002, Erich Focht <efocht@ess.nec.de>
+==============================
+
+07.01.2002, Erich Focht <efocht@ess.nec.de>
 
 
 By writing to /proc/irq/IRQ#/smp_affinity the interrupt routing can be
@@ -12,22 +14,27 @@ IRQ target is one particular CPU and cannot be a mask of several
 CPUs. Only the first non-zero bit is taken into account.
 
 
-Usage examples:
+Usage examples
+==============
 
 The target CPU has to be specified as a hexadecimal CPU mask. The
 first non-zero bit is the selected CPU. This format has been kept for
 compatibility reasons with i386.
 
 Set the delivery mode of interrupt 41 to fixed and route the
-interrupts to CPU #3 (logical CPU number) (2^3=0x08):
+interrupts to CPU #3 (logical CPU number) (2^3=0x08)::
+
      echo "8" >/proc/irq/41/smp_affinity
 
 Set the default route for IRQ number 41 to CPU 6 in lowest priority
-delivery mode (redirectable):
+delivery mode (redirectable)::
+
      echo "r 40" >/proc/irq/41/smp_affinity
 
-The output of the command
+The output of the command::
+
      cat /proc/irq/IRQ#/smp_affinity
+
 gives the target CPU mask for the specified interrupt vector. If the CPU
 mask is preceded by the character "r", the interrupt is redirectable
 (i.e. lowest priority mode routing is used), otherwise its route is
@@ -35,7 +42,8 @@ fixed.
 
 
 
-Initialization and default behavior:
+Initialization and default behavior
+===================================
 
 If the platform features IRQ redirection (info provided by SAL) all
 IO-SAPIC interrupts are initialized with CPU#0 as their default target
@@ -43,9 +51,11 @@ and the routing is the so called "lowest priority mode" (actually
 fixed SAPIC mode with hint). The XTP chipset registers are used as hints
 for the IRQ routing. Currently in Linux XTP registers can have three
 values:
+
 	- minimal for an idle task,
 	- normal if any other task runs,
 	- maximal if the CPU is going to be switched off.
+
 The IRQ is routed to the CPU with lowest XTP register value, the
 search begins at the default CPU. Therefore most of the interrupts
 will be handled by CPU #0.
@@ -53,12 +63,14 @@ will be handled by CPU #0.
 If the platform doesn't feature interrupt redirection IOSAPIC fixed
 routing is used. The target CPUs are distributed in a round robin
 manner. IRQs will be routed only to the selected target CPUs. Check
-with
+with::
+
         cat /proc/interrupts
 
 
 
-Comments:
+Comments
+========
 
 On large (multi-node) systems it is recommended to route the IRQs to
 the node to which the corresponding device is connected.
@@ -66,4 +78,3 @@ For systems like the NEC AzusA we get IRQ node-affinity for free. This
 is because usually the chipsets on each node redirect the interrupts
 only to their own CPUs (as they cannot see the XTP registers on the
 other nodes).
-
diff --git a/Documentation/ia64/mca.txt b/Documentation/ia64/mca.rst
similarity index 96%
rename from Documentation/ia64/mca.txt
rename to Documentation/ia64/mca.rst
index f097c60cba1b..08270bba44a4 100644
--- a/Documentation/ia64/mca.txt
+++ b/Documentation/ia64/mca.rst
@@ -1,5 +1,8 @@
-An ad-hoc collection of notes on IA64 MCA and INIT processing.  Feel
-free to update it with notes about any area that is not clear.
+=============================================================
+An ad-hoc collection of notes on IA64 MCA and INIT processing
+=============================================================
+
+Feel free to update it with notes about any area that is not clear.
 
 ---
 
@@ -82,7 +85,8 @@ if we have a choice here.
   own stack as running on that cpu.  Then a recursive error gets a
   trace of the failing handler's "task".
 
-[1] My (Keith Owens) original design called for ia64 to separate its
+[1]
+    My (Keith Owens) original design called for ia64 to separate its
     struct task and the kernel stacks.  Then the MCA/INIT data would be
     chained stacks like i386 interrupt stacks.  But that required
     radical surgery on the rest of ia64, plus extra hard wired TLB
diff --git a/Documentation/ia64/serial.txt b/Documentation/ia64/serial.rst
similarity index 87%
rename from Documentation/ia64/serial.txt
rename to Documentation/ia64/serial.rst
index a63d2c54329b..1de70c305a79 100644
--- a/Documentation/ia64/serial.txt
+++ b/Documentation/ia64/serial.rst
@@ -1,4 +1,9 @@
-SERIAL DEVICE NAMING
+==============
+Serial Devices
+==============
+
+Serial Device Naming
+====================
 
     As of 2.6.10, serial devices on ia64 are named based on the
     order of ACPI and PCI enumeration.  The first device in the
@@ -30,17 +35,21 @@ SERIAL DEVICE NAMING
     (described in the ACPI namespace) plus an MP[2] (a PCI device) has
     these ports:
 
-                                  pre-2.6.10      pre-2.6.10
-                    MMIO         (EFI console    (EFI console
-                   address        on builtin)     on MP port)    2.6.10
-                  ==========      ==========      ==========     ======
+      ==========  ==========     ============    ============   =======
+      Type        MMIO           pre-2.6.10      pre-2.6.10     2.6.10+
+		  address
+				 (EFI console    (EFI console
+                                 on builtin)     on MP port)
+      ==========  ==========     ============    ============   =======
       builtin     0xff5e0000        ttyS0           ttyS1         ttyS0
       MP UPS      0xf8031000        ttyS1           ttyS2         ttyS1
       MP Console  0xf8030000        ttyS2           ttyS0         ttyS2
       MP 2        0xf8030010        ttyS3           ttyS3         ttyS3
       MP 3        0xf8030038        ttyS4           ttyS4         ttyS4
+      ==========  ==========     ============    ============   =======
 
-CONSOLE SELECTION
+Console Selection
+=================
 
     EFI knows what your console devices are, but it doesn't tell the
     kernel quite enough to actually locate them.  The DIG64 HCDP
@@ -67,7 +76,8 @@ CONSOLE SELECTION
     entries in /etc/inittab (for getty) and /etc/securetty (to allow
     root login).
 
-EARLY SERIAL CONSOLE
+Early Serial Console
+====================
 
     The kernel can't start using a serial console until it knows where
     the device lives.  Normally this happens when the driver enumerates
@@ -80,7 +90,8 @@ EARLY SERIAL CONSOLE
     or if the EFI console path contains only a UART device and the
     firmware supplies an HCDP.
 
-TROUBLESHOOTING SERIAL CONSOLE PROBLEMS
+Troubleshooting Serial Console Problems
+=======================================
 
     No kernel output after elilo prints "Uncompressing Linux... done":
 
@@ -133,19 +144,22 @@ TROUBLESHOOTING SERIAL CONSOLE PROBLEMS
 
 
 
-[1] http://www.dig64.org/specifications/agreement 
+[1]
+    http://www.dig64.org/specifications/agreement
     The table was originally defined as the "HCDP" for "Headless
     Console/Debug Port."  The current version is the "PCDP" for
     "Primary Console and Debug Port Devices."
 
-[2] The HP MP (management processor) is a PCI device that provides
+[2]
+    The HP MP (management processor) is a PCI device that provides
     several UARTs.  One of the UARTs is often used as a console; the
     EFI Boot Manager identifies it as "Acpi(HWP0002,700)/Pci(...)/Uart".
     The external connection is usually a 25-pin connector, and a
     special dongle converts that to three 9-pin connectors, one of
     which is labelled "Console."
 
-[3] EFI console devices are configured using the EFI Boot Manager
+[3]
+    EFI console devices are configured using the EFI Boot Manager
     "Boot option maintenance" menu.  You may have to interrupt the
     boot sequence to use this menu, and you will have to reset the
     box after changing console configuration.
diff --git a/Documentation/ia64/xen.rst b/Documentation/ia64/xen.rst
new file mode 100644
index 000000000000..831339c74441
--- /dev/null
+++ b/Documentation/ia64/xen.rst
@@ -0,0 +1,206 @@
+********************************************************
+Recipe for getting/building/running Xen/ia64 with pv_ops
+********************************************************
+This recipe describes how to get xen-ia64 source and build it,
+and run domU with pv_ops.
+
+Requirements
+============
+
+  - python
+  - mercurial
+    it (aka "hg") is an open-source source code
+    management software. See the below.
+    http://www.selenic.com/mercurial/wiki/
+  - git
+  - bridge-utils
+
+Getting and Building Xen and Dom0
+=================================
+
+  My environment is:
+
+    - Machine  : Tiger4
+    - Domain0 OS  : RHEL5
+    - DomainU OS  : RHEL5
+
+ 1. Download source::
+
+	# hg clone http://xenbits.xensource.com/ext/ia64/xen-unstable.hg
+	# cd xen-unstable.hg
+	# hg clone http://xenbits.xensource.com/ext/ia64/linux-2.6.18-xen.hg
+
+ 2. # make world
+
+ 3. # make install-tools
+
+ 4. copy kernels and xen::
+
+	# cp xen/xen.gz /boot/efi/efi/redhat/
+	# cp build-linux-2.6.18-xen_ia64/vmlinux.gz \
+	/boot/efi/efi/redhat/vmlinuz-2.6.18.8-xen
+
+ 5. make initrd for Dom0/DomU::
+
+	# make -C linux-2.6.18-xen.hg ARCH=ia64 modules_install \
+          O=$(pwd)/build-linux-2.6.18-xen_ia64
+	# mkinitrd -f /boot/efi/efi/redhat/initrd-2.6.18.8-xen.img \
+	  2.6.18.8-xen --builtin mptspi --builtin mptbase \
+	  --builtin mptscsih --builtin uhci-hcd --builtin ohci-hcd \
+	  --builtin ehci-hcd
+
+Making a disk image for guest OS
+================================
+
+ 1. make file::
+
+      # dd if=/dev/zero of=/root/rhel5.img bs=1M seek=4096 count=0
+      # mke2fs -F -j /root/rhel5.img
+      # mount -o loop /root/rhel5.img /mnt
+      # cp -ax /{dev,var,etc,usr,bin,sbin,lib} /mnt
+      # mkdir /mnt/{root,proc,sys,home,tmp}
+
+      Note: You may miss some device files. If so, please create them
+      with mknod. Or you can use tar instead of cp.
+
+ 2. modify DomU's fstab::
+
+      # vi /mnt/etc/fstab
+         /dev/xvda1  /            ext3    defaults        1 1
+         none        /dev/pts     devpts  gid=5,mode=620  0 0
+         none        /dev/shm     tmpfs   defaults        0 0
+         none        /proc        proc    defaults        0 0
+         none        /sys         sysfs   defaults        0 0
+
+ 3. modify inittab
+
+    set runlevel to 3 to avoid X trying to start::
+
+      # vi /mnt/etc/inittab
+         id:3:initdefault:
+
+    Start a getty on the hvc0 console::
+
+       X0:2345:respawn:/sbin/mingetty hvc0
+
+    tty1-6 mingetty can be commented out
+
+ 4. add hvc0 into /etc/securetty::
+
+      # vi /mnt/etc/securetty (add hvc0)
+
+ 5. umount::
+
+      # umount /mnt
+
+FYI, virt-manager can also make a disk image for guest OS.
+It's GUI tools and easy to make it.
+
+Boot Xen & Domain0
+==================
+
+ 1. replace elilo
+    elilo of RHEL5 can boot Xen and Dom0.
+    If you use old elilo (e.g RHEL4), please download from the below
+    http://elilo.sourceforge.net/cgi-bin/blosxom
+    and copy into /boot/efi/efi/redhat/::
+
+      # cp elilo-3.6-ia64.efi /boot/efi/efi/redhat/elilo.efi
+
+ 2. modify elilo.conf (like the below)::
+
+      # vi /boot/efi/efi/redhat/elilo.conf
+      prompt
+      timeout=20
+      default=xen
+      relocatable
+
+      image=vmlinuz-2.6.18.8-xen
+             label=xen
+             vmm=xen.gz
+             initrd=initrd-2.6.18.8-xen.img
+             read-only
+             append=" -- rhgb root=/dev/sda2"
+
+The append options before "--" are for xen hypervisor,
+the options after "--" are for dom0.
+
+FYI, your machine may need console options like
+"com1=19200,8n1 console=vga,com1". For example,
+append="com1=19200,8n1 console=vga,com1 -- rhgb console=tty0 \
+console=ttyS0 root=/dev/sda2"
+
+Getting and Building domU with pv_ops
+=====================================
+
+ 1. get pv_ops tree::
+
+      # git clone http://people.valinux.co.jp/~yamahata/xen-ia64/linux-2.6-xen-ia64.git/
+
+ 2. git branch (if necessary)::
+
+      # cd linux-2.6-xen-ia64/
+      # git checkout -b your_branch origin/xen-ia64-domu-minimal-2008may19
+
+   Note:
+     The current branch is xen-ia64-domu-minimal-2008may19.
+     But you would find the new branch. You can see with
+     "git branch -r" to get the branch lists.
+
+       http://people.valinux.co.jp/~yamahata/xen-ia64/for_eagl/linux-2.6-ia64-pv-ops.git/
+
+     is also available.
+
+     The tree is based on
+
+      git://git.kernel.org/pub/scm/linux/kernel/git/aegl/linux-2.6 test)
+
+ 3. copy .config for pv_ops of domU::
+
+      # cp arch/ia64/configs/xen_domu_wip_defconfig .config
+
+ 4. make kernel with pv_ops::
+
+      # make oldconfig
+      # make
+
+ 5. install the kernel and initrd::
+
+      # cp vmlinux.gz /boot/efi/efi/redhat/vmlinuz-2.6-pv_ops-xenU
+      # make modules_install
+      # mkinitrd -f /boot/efi/efi/redhat/initrd-2.6-pv_ops-xenU.img \
+        2.6.26-rc3xen-ia64-08941-g1b12161 --builtin mptspi \
+        --builtin mptbase --builtin mptscsih --builtin uhci-hcd \
+        --builtin ohci-hcd --builtin ehci-hcd
+
+Boot DomainU with pv_ops
+========================
+
+ 1. make config of DomU::
+
+     # vi /etc/xen/rhel5
+       kernel = "/boot/efi/efi/redhat/vmlinuz-2.6-pv_ops-xenU"
+       ramdisk = "/boot/efi/efi/redhat/initrd-2.6-pv_ops-xenU.img"
+       vcpus = 1
+       memory = 512
+       name = "rhel5"
+       disk = [ 'file:/root/rhel5.img,xvda1,w' ]
+       root = "/dev/xvda1 ro"
+       extra= "rhgb console=hvc0"
+
+ 2. After boot xen and dom0, start xend::
+
+	# /etc/init.d/xend start
+
+   ( In the debugging case, `# XEND_DEBUG=1 xend trace_start` )
+
+ 3. start domU::
+
+	# xm create -c rhel5
+
+Reference
+=========
+- Wiki of Xen/IA64 upstream merge
+  http://wiki.xensource.com/xenwiki/XenIA64/UpstreamMerge
+
+Written by Akio Takebe <takebe_akio@jp.fujitsu.com> on 28 May 2008
diff --git a/Documentation/ia64/xen.txt b/Documentation/ia64/xen.txt
deleted file mode 100644
index a12c74ce2773..000000000000
--- a/Documentation/ia64/xen.txt
+++ /dev/null
@@ -1,183 +0,0 @@
-       Recipe for getting/building/running Xen/ia64 with pv_ops
-       --------------------------------------------------------
-
-This recipe describes how to get xen-ia64 source and build it,
-and run domU with pv_ops.
-
-============
-Requirements
-============
-
-  - python
-  - mercurial
-    it (aka "hg") is an open-source source code
-    management software. See the below.
-    http://www.selenic.com/mercurial/wiki/
-  - git
-  - bridge-utils
-
-=================================
-Getting and Building Xen and Dom0
-=================================
-
-  My environment is;
-    Machine  : Tiger4
-    Domain0 OS  : RHEL5
-    DomainU OS  : RHEL5
-
- 1. Download source
-    # hg clone http://xenbits.xensource.com/ext/ia64/xen-unstable.hg
-    # cd xen-unstable.hg
-    # hg clone http://xenbits.xensource.com/ext/ia64/linux-2.6.18-xen.hg
-
- 2. # make world
-
- 3. # make install-tools
-
- 4. copy kernels and xen
-    # cp xen/xen.gz /boot/efi/efi/redhat/
-    # cp build-linux-2.6.18-xen_ia64/vmlinux.gz \
-      /boot/efi/efi/redhat/vmlinuz-2.6.18.8-xen
-
- 5. make initrd for Dom0/DomU
-    # make -C linux-2.6.18-xen.hg ARCH=ia64 modules_install \
-      O=$(pwd)/build-linux-2.6.18-xen_ia64
-    # mkinitrd -f /boot/efi/efi/redhat/initrd-2.6.18.8-xen.img \
-      2.6.18.8-xen --builtin mptspi --builtin mptbase \
-      --builtin mptscsih --builtin uhci-hcd --builtin ohci-hcd \
-      --builtin ehci-hcd
-
-================================
-Making a disk image for guest OS
-================================
-
- 1. make file
-    # dd if=/dev/zero of=/root/rhel5.img bs=1M seek=4096 count=0
-    # mke2fs -F -j /root/rhel5.img
-    # mount -o loop /root/rhel5.img /mnt
-    # cp -ax /{dev,var,etc,usr,bin,sbin,lib} /mnt
-    # mkdir /mnt/{root,proc,sys,home,tmp}
-
-    Note: You may miss some device files. If so, please create them
-    with mknod. Or you can use tar instead of cp.
-
- 2. modify DomU's fstab
-    # vi /mnt/etc/fstab
-       /dev/xvda1  /            ext3    defaults        1 1
-       none        /dev/pts     devpts  gid=5,mode=620  0 0
-       none        /dev/shm     tmpfs   defaults        0 0
-       none        /proc        proc    defaults        0 0
-       none        /sys         sysfs   defaults        0 0
-
- 3. modify inittab
-    set runlevel to 3 to avoid X trying to start
-    # vi /mnt/etc/inittab
-       id:3:initdefault:
-    Start a getty on the hvc0 console
-       X0:2345:respawn:/sbin/mingetty hvc0
-    tty1-6 mingetty can be commented out
-
- 4. add hvc0 into /etc/securetty
-    # vi /mnt/etc/securetty (add hvc0)
-
- 5. umount
-    # umount /mnt
-
-FYI, virt-manager can also make a disk image for guest OS.
-It's GUI tools and easy to make it.
-
-==================
-Boot Xen & Domain0
-==================
-
- 1. replace elilo
-    elilo of RHEL5 can boot Xen and Dom0.
-    If you use old elilo (e.g RHEL4), please download from the below
-    http://elilo.sourceforge.net/cgi-bin/blosxom
-    and copy into /boot/efi/efi/redhat/
-    # cp elilo-3.6-ia64.efi /boot/efi/efi/redhat/elilo.efi
-
- 2. modify elilo.conf (like the below)
-    # vi /boot/efi/efi/redhat/elilo.conf
-     prompt
-     timeout=20
-     default=xen
-     relocatable
-
-     image=vmlinuz-2.6.18.8-xen
-             label=xen
-             vmm=xen.gz
-             initrd=initrd-2.6.18.8-xen.img
-             read-only
-             append=" -- rhgb root=/dev/sda2"
-
-The append options before "--" are for xen hypervisor,
-the options after "--" are for dom0.
-
-FYI, your machine may need console options like
-"com1=19200,8n1 console=vga,com1". For example,
-append="com1=19200,8n1 console=vga,com1 -- rhgb console=tty0 \
-console=ttyS0 root=/dev/sda2"
-
-=====================================
-Getting and Building domU with pv_ops
-=====================================
-
- 1. get pv_ops tree
-    # git clone http://people.valinux.co.jp/~yamahata/xen-ia64/linux-2.6-xen-ia64.git/
-
- 2. git branch (if necessary)
-    # cd linux-2.6-xen-ia64/
-    # git checkout -b your_branch origin/xen-ia64-domu-minimal-2008may19
-    (Note: The current branch is xen-ia64-domu-minimal-2008may19.
-    But you would find the new branch. You can see with
-    "git branch -r" to get the branch lists.
-    http://people.valinux.co.jp/~yamahata/xen-ia64/for_eagl/linux-2.6-ia64-pv-ops.git/
-    is also available. The tree is based on
-    git://git.kernel.org/pub/scm/linux/kernel/git/aegl/linux-2.6 test)
-
-
- 3. copy .config for pv_ops of domU
-    # cp arch/ia64/configs/xen_domu_wip_defconfig .config
-
- 4. make kernel with pv_ops
-    # make oldconfig
-    # make
-
- 5. install the kernel and initrd
-    # cp vmlinux.gz /boot/efi/efi/redhat/vmlinuz-2.6-pv_ops-xenU
-    # make modules_install
-    # mkinitrd -f /boot/efi/efi/redhat/initrd-2.6-pv_ops-xenU.img \
-      2.6.26-rc3xen-ia64-08941-g1b12161 --builtin mptspi \
-      --builtin mptbase --builtin mptscsih --builtin uhci-hcd \
-      --builtin ohci-hcd --builtin ehci-hcd
-
-========================
-Boot DomainU with pv_ops
-========================
-
- 1. make config of DomU
-   # vi /etc/xen/rhel5
-     kernel = "/boot/efi/efi/redhat/vmlinuz-2.6-pv_ops-xenU"
-     ramdisk = "/boot/efi/efi/redhat/initrd-2.6-pv_ops-xenU.img"
-     vcpus = 1
-     memory = 512
-     name = "rhel5"
-     disk = [ 'file:/root/rhel5.img,xvda1,w' ]
-     root = "/dev/xvda1 ro"
-     extra= "rhgb console=hvc0"
-
- 2. After boot xen and dom0, start xend
-   # /etc/init.d/xend start
-   ( In the debugging case, # XEND_DEBUG=1 xend trace_start )
-
- 3. start domU
-   # xm create -c rhel5
-
-=========
-Reference
-=========
-- Wiki of Xen/IA64 upstream merge
-  http://wiki.xensource.com/xenwiki/XenIA64/UpstreamMerge
-
-Written by Akio Takebe <takebe_akio@jp.fujitsu.com> on 28 May 2008
diff --git a/MAINTAINERS b/MAINTAINERS
index 8941a73880e6..f27f50f88638 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14266,7 +14266,7 @@ SGI SN-IA64 (Altix) SERIAL CONSOLE DRIVER
 M:	Pat Gefre <pfg@sgi.com>
 L:	linux-ia64@vger.kernel.org
 S:	Supported
-F:	Documentation/ia64/serial.txt
+F:	Documentation/ia64/serial.rst
 F:	drivers/tty/serial/ioc?_serial.c
 F:	include/linux/ioc?.h
 
diff --git a/arch/ia64/kernel/efi.c b/arch/ia64/kernel/efi.c
index 8f106638913c..3795d18276c4 100644
--- a/arch/ia64/kernel/efi.c
+++ b/arch/ia64/kernel/efi.c
@@ -852,7 +852,7 @@ valid_phys_addr_range (phys_addr_t phys_addr, unsigned long size)
 	 * /dev/mem reads and writes use copy_to_user(), which implicitly
 	 * uses a granule-sized kernel identity mapping.  It's really
 	 * only safe to do this for regions in kern_memmap.  For more
-	 * details, see Documentation/ia64/aliasing.txt.
+	 * details, see Documentation/ia64/aliasing.rst.
 	 */
 	attr = kern_mem_attribute(phys_addr, size);
 	if (attr & EFI_MEMORY_WB || attr & EFI_MEMORY_UC)
diff --git a/arch/ia64/kernel/fsys.S b/arch/ia64/kernel/fsys.S
index d80c99a5f55d..0750a716adc7 100644
--- a/arch/ia64/kernel/fsys.S
+++ b/arch/ia64/kernel/fsys.S
@@ -28,7 +28,7 @@
 #include <asm/native/inst.h>
 
 /*
- * See Documentation/ia64/fsys.txt for details on fsyscalls.
+ * See Documentation/ia64/fsys.rst for details on fsyscalls.
  *
  * On entry to an fsyscall handler:
  *   r10	= 0 (i.e., defaults to "successful syscall return")
diff --git a/arch/ia64/mm/ioremap.c b/arch/ia64/mm/ioremap.c
index 43964cde6214..c7da3376b6f8 100644
--- a/arch/ia64/mm/ioremap.c
+++ b/arch/ia64/mm/ioremap.c
@@ -45,7 +45,7 @@ ioremap (unsigned long phys_addr, unsigned long size)
 	/*
 	 * For things in kern_memmap, we must use the same attribute
 	 * as the rest of the kernel.  For more details, see
-	 * Documentation/ia64/aliasing.txt.
+	 * Documentation/ia64/aliasing.rst.
 	 */
 	attr = kern_mem_attribute(phys_addr, size);
 	if (attr & EFI_MEMORY_WB)
diff --git a/arch/ia64/pci/pci.c b/arch/ia64/pci/pci.c
index e308196c2229..165e561dc81a 100644
--- a/arch/ia64/pci/pci.c
+++ b/arch/ia64/pci/pci.c
@@ -450,7 +450,7 @@ pci_mmap_legacy_page_range(struct pci_bus *bus, struct vm_area_struct *vma,
 		return -ENOSYS;
 
 	/*
-	 * Avoid attribute aliasing.  See Documentation/ia64/aliasing.txt
+	 * Avoid attribute aliasing.  See Documentation/ia64/aliasing.rst
 	 * for more details.
 	 */
 	if (!valid_mmap_phys_addr_range(vma->vm_pgoff, size))
-- 
2.21.0

