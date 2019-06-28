Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B185959BDC
	for <lists+linux-efi@lfdr.de>; Fri, 28 Jun 2019 14:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbfF1Mne (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 28 Jun 2019 08:43:34 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:39295 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726564AbfF1Mnd (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 28 Jun 2019 08:43:33 -0400
Received: from localhost (alyon-656-1-672-152.w92-137.abo.wanadoo.fr [92.137.69.152])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 2985A10000C;
        Fri, 28 Jun 2019 12:43:02 +0000 (UTC)
Date:   Fri, 28 Jun 2019 14:43:02 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Willy Tarreau <willy@haproxy.com>,
        Ksenija Stanojevic <ksenija.stanojevic@gmail.com>,
        "Richard Russon (FlatCap)" <ldm@flatcap.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Martin Mares <mj@ucw.cz>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Russell King <linux@armlinux.org.uk>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jens Axboe <axboe@kernel.dk>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-efi@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net, linux-rtc@vger.kernel.org,
        linux-video@atrey.karlin.mff.cuni.cz,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 28/39] docs: admin-guide: add a series of orphaned
 documents
Message-ID: <20190628124302.GS3692@piout.net>
References: <cover.1561724493.git.mchehab+samsung@kernel.org>
 <7ee0e33575633f689203f582259c2cbdce477176.1561724493.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ee0e33575633f689203f582259c2cbdce477176.1561724493.git.mchehab+samsung@kernel.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 28/06/2019 09:30:21-0300, Mauro Carvalho Chehab wrote:
> There are lots of documents that belong to the admin-guide but
> are on random places (most under Documentation root dir).
> 
> Move them to the admin guide.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

> ---
>  Documentation/ABI/stable/sysfs-devices-node     |  2 +-
>  Documentation/ABI/testing/procfs-diskstats      |  2 +-
>  Documentation/ABI/testing/sysfs-block           |  2 +-
>  .../ABI/testing/sysfs-devices-system-cpu        |  4 ++--
>  .../{btmrvl.txt => admin-guide/btmrvl.rst}      |  0
>  .../clearing-warn-once.rst}                     |  0
>  .../{cpu-load.txt => admin-guide/cpu-load.rst}  |  0
>  .../cputopology.rst}                            |  0
>  .../admin-guide/device-mapper/statistics.rst    |  4 ++--
>  .../{efi-stub.txt => admin-guide/efi-stub.rst}  |  0
>  .../{highuid.txt => admin-guide/highuid.rst}    |  0
>  Documentation/admin-guide/hw-vuln/l1tf.rst      |  2 +-
>  .../hw_random.rst}                              |  0
>  Documentation/admin-guide/index.rst             | 17 +++++++++++++++++
>  .../{iostats.txt => admin-guide/iostats.rst}    |  0
>  Documentation/admin-guide/kernel-parameters.txt |  2 +-
>  .../kernel-per-CPU-kthreads.rst}                |  0
>  .../lcd-panel-cgram.rst                         |  2 --
>  Documentation/{ldm.txt => admin-guide/ldm.rst}  |  0
>  .../lockup-watchdogs.rst}                       |  0
>  .../mm/cma_debugfs.rst}                         |  2 --
>  Documentation/admin-guide/mm/index.rst          |  1 +
>  .../{numastat.txt => admin-guide/numastat.rst}  |  0
>  Documentation/{pnp.txt => admin-guide/pnp.rst}  |  0
>  Documentation/{rtc.txt => admin-guide/rtc.rst}  |  0
>  .../{svga.txt => admin-guide/svga.rst}          |  0
>  Documentation/admin-guide/sysctl/kernel.rst     |  2 +-
>  .../video-output.rst}                           |  0
>  Documentation/fb/vesafb.rst                     |  2 +-
>  Documentation/x86/topology.rst                  |  2 +-
>  MAINTAINERS                                     | 12 ++++++------
>  arch/arm/Kconfig                                |  2 +-
>  arch/parisc/Kconfig                             |  2 +-
>  arch/sh/Kconfig                                 |  2 +-
>  arch/sparc/Kconfig                              |  2 +-
>  arch/x86/Kconfig                                |  4 ++--
>  block/partitions/Kconfig                        |  2 +-
>  drivers/char/Kconfig                            |  4 ++--
>  drivers/char/hw_random/core.c                   |  2 +-
>  include/linux/hw_random.h                       |  2 +-
>  40 files changed, 47 insertions(+), 33 deletions(-)
>  rename Documentation/{btmrvl.txt => admin-guide/btmrvl.rst} (100%)
>  rename Documentation/{clearing-warn-once.txt => admin-guide/clearing-warn-once.rst} (100%)
>  rename Documentation/{cpu-load.txt => admin-guide/cpu-load.rst} (100%)
>  rename Documentation/{cputopology.txt => admin-guide/cputopology.rst} (100%)
>  rename Documentation/{efi-stub.txt => admin-guide/efi-stub.rst} (100%)
>  rename Documentation/{highuid.txt => admin-guide/highuid.rst} (100%)
>  rename Documentation/{hw_random.txt => admin-guide/hw_random.rst} (100%)
>  rename Documentation/{iostats.txt => admin-guide/iostats.rst} (100%)
>  rename Documentation/{kernel-per-CPU-kthreads.txt => admin-guide/kernel-per-CPU-kthreads.rst} (100%)
>  rename Documentation/{auxdisplay => admin-guide}/lcd-panel-cgram.rst (99%)
>  rename Documentation/{ldm.txt => admin-guide/ldm.rst} (100%)
>  rename Documentation/{lockup-watchdogs.txt => admin-guide/lockup-watchdogs.rst} (100%)
>  rename Documentation/{cma/debugfs.rst => admin-guide/mm/cma_debugfs.rst} (98%)
>  rename Documentation/{numastat.txt => admin-guide/numastat.rst} (100%)
>  rename Documentation/{pnp.txt => admin-guide/pnp.rst} (100%)
>  rename Documentation/{rtc.txt => admin-guide/rtc.rst} (100%)
>  rename Documentation/{svga.txt => admin-guide/svga.rst} (100%)
>  rename Documentation/{video-output.txt => admin-guide/video-output.rst} (100%)
> 
> diff --git a/Documentation/ABI/stable/sysfs-devices-node b/Documentation/ABI/stable/sysfs-devices-node
> index f7ce68fbd4b9..df8413cf1468 100644
> --- a/Documentation/ABI/stable/sysfs-devices-node
> +++ b/Documentation/ABI/stable/sysfs-devices-node
> @@ -61,7 +61,7 @@ Date:		October 2002
>  Contact:	Linux Memory Management list <linux-mm@kvack.org>
>  Description:
>  		The node's hit/miss statistics, in units of pages.
> -		See Documentation/numastat.txt
> +		See Documentation/admin-guide/numastat.rst
>  
>  What:		/sys/devices/system/node/nodeX/distance
>  Date:		October 2002
> diff --git a/Documentation/ABI/testing/procfs-diskstats b/Documentation/ABI/testing/procfs-diskstats
> index abac31d216de..2c44b4f1b060 100644
> --- a/Documentation/ABI/testing/procfs-diskstats
> +++ b/Documentation/ABI/testing/procfs-diskstats
> @@ -29,4 +29,4 @@ Description:
>  		17 - sectors discarded
>  		18 - time spent discarding
>  
> -		For more details refer to Documentation/iostats.txt
> +		For more details refer to Documentation/admin-guide/iostats.rst
> diff --git a/Documentation/ABI/testing/sysfs-block b/Documentation/ABI/testing/sysfs-block
> index dfad7427817c..f8c7c7126bb1 100644
> --- a/Documentation/ABI/testing/sysfs-block
> +++ b/Documentation/ABI/testing/sysfs-block
> @@ -15,7 +15,7 @@ Description:
>  		 9 - I/Os currently in progress
>  		10 - time spent doing I/Os (ms)
>  		11 - weighted time spent doing I/Os (ms)
> -		For more details refer Documentation/iostats.txt
> +		For more details refer Documentation/admin-guide/iostats.rst
>  
>  
>  What:		/sys/block/<disk>/<part>/stat
> diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
> index d404603c6b52..5f7d7b14fa44 100644
> --- a/Documentation/ABI/testing/sysfs-devices-system-cpu
> +++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
> @@ -34,7 +34,7 @@ Description:	CPU topology files that describe kernel limits related to
>  		present: cpus that have been identified as being present in
>  		the system.
>  
> -		See Documentation/cputopology.txt for more information.
> +		See Documentation/admin-guide/cputopology.rst for more information.
>  
>  
>  What:		/sys/devices/system/cpu/probe
> @@ -103,7 +103,7 @@ Description:	CPU topology files that describe a logical CPU's relationship
>  		thread_siblings_list: human-readable list of cpu#'s hardware
>  		threads within the same core as cpu#
>  
> -		See Documentation/cputopology.txt for more information.
> +		See Documentation/admin-guide/cputopology.rst for more information.
>  
>  
>  What:		/sys/devices/system/cpu/cpuidle/current_driver
> diff --git a/Documentation/btmrvl.txt b/Documentation/admin-guide/btmrvl.rst
> similarity index 100%
> rename from Documentation/btmrvl.txt
> rename to Documentation/admin-guide/btmrvl.rst
> diff --git a/Documentation/clearing-warn-once.txt b/Documentation/admin-guide/clearing-warn-once.rst
> similarity index 100%
> rename from Documentation/clearing-warn-once.txt
> rename to Documentation/admin-guide/clearing-warn-once.rst
> diff --git a/Documentation/cpu-load.txt b/Documentation/admin-guide/cpu-load.rst
> similarity index 100%
> rename from Documentation/cpu-load.txt
> rename to Documentation/admin-guide/cpu-load.rst
> diff --git a/Documentation/cputopology.txt b/Documentation/admin-guide/cputopology.rst
> similarity index 100%
> rename from Documentation/cputopology.txt
> rename to Documentation/admin-guide/cputopology.rst
> diff --git a/Documentation/admin-guide/device-mapper/statistics.rst b/Documentation/admin-guide/device-mapper/statistics.rst
> index 3d80a9f850cc..41ded0bc5933 100644
> --- a/Documentation/admin-guide/device-mapper/statistics.rst
> +++ b/Documentation/admin-guide/device-mapper/statistics.rst
> @@ -13,7 +13,7 @@ the range specified.
>  
>  The I/O statistics counters for each step-sized area of a region are
>  in the same format as `/sys/block/*/stat` or `/proc/diskstats` (see:
> -Documentation/iostats.txt).  But two extra counters (12 and 13) are
> +Documentation/admin-guide/iostats.rst).  But two extra counters (12 and 13) are
>  provided: total time spent reading and writing.  When the histogram
>  argument is used, the 14th parameter is reported that represents the
>  histogram of latencies.  All these counters may be accessed by sending
> @@ -151,7 +151,7 @@ Messages
>  	  The first 11 counters have the same meaning as
>  	  `/sys/block/*/stat or /proc/diskstats`.
>  
> -	  Please refer to Documentation/iostats.txt for details.
> +	  Please refer to Documentation/admin-guide/iostats.rst for details.
>  
>  	  1. the number of reads completed
>  	  2. the number of reads merged
> diff --git a/Documentation/efi-stub.txt b/Documentation/admin-guide/efi-stub.rst
> similarity index 100%
> rename from Documentation/efi-stub.txt
> rename to Documentation/admin-guide/efi-stub.rst
> diff --git a/Documentation/highuid.txt b/Documentation/admin-guide/highuid.rst
> similarity index 100%
> rename from Documentation/highuid.txt
> rename to Documentation/admin-guide/highuid.rst
> diff --git a/Documentation/admin-guide/hw-vuln/l1tf.rst b/Documentation/admin-guide/hw-vuln/l1tf.rst
> index 656aee262e23..f83212fae4d5 100644
> --- a/Documentation/admin-guide/hw-vuln/l1tf.rst
> +++ b/Documentation/admin-guide/hw-vuln/l1tf.rst
> @@ -241,7 +241,7 @@ Guest mitigation mechanisms
>     For further information about confining guests to a single or to a group
>     of cores consult the cpusets documentation:
>  
> -   https://www.kernel.org/doc/Documentation/cgroup-v1/cpusets.rst
> +   https://www.kernel.org/doc/Documentation/admin-guide/cgroup-v1/cpusets.rst
>  
>  .. _interrupt_isolation:
>  
> diff --git a/Documentation/hw_random.txt b/Documentation/admin-guide/hw_random.rst
> similarity index 100%
> rename from Documentation/hw_random.txt
> rename to Documentation/admin-guide/hw_random.rst
> diff --git a/Documentation/admin-guide/index.rst b/Documentation/admin-guide/index.rst
> index d5064f1802c1..2c20607e90cd 100644
> --- a/Documentation/admin-guide/index.rst
> +++ b/Documentation/admin-guide/index.rst
> @@ -84,8 +84,25 @@ configure specific aspects of kernel behavior to your liking.
>     perf-security
>     acpi/index
>     aoe/index
> +   btmrvl
> +   clearing-warn-once
> +   cpu-load
> +   cputopology
>     device-mapper/index
> +   efi-stub
> +   highuid
> +   hw_random
> +   iostats
> +   kernel-per-CPU-kthreads
>     laptops/index
> +   lcd-panel-cgram
> +   ldm
> +   lockup-watchdogs
> +   numastat
> +   pnp
> +   rtc
> +   svga
> +   video-output
>  
>  .. only::  subproject and html
>  
> diff --git a/Documentation/iostats.txt b/Documentation/admin-guide/iostats.rst
> similarity index 100%
> rename from Documentation/iostats.txt
> rename to Documentation/admin-guide/iostats.rst
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index e833133c8897..713d6f378fbe 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -5092,7 +5092,7 @@
>  
>  	vga=		[BOOT,X86-32] Select a particular video mode
>  			See Documentation/x86/boot.rst and
> -			Documentation/svga.txt.
> +			Documentation/admin-guide/svga.rst.
>  			Use vga=ask for menu.
>  			This is actually a boot loader parameter; the value is
>  			passed to the kernel using a special protocol.
> diff --git a/Documentation/kernel-per-CPU-kthreads.txt b/Documentation/admin-guide/kernel-per-CPU-kthreads.rst
> similarity index 100%
> rename from Documentation/kernel-per-CPU-kthreads.txt
> rename to Documentation/admin-guide/kernel-per-CPU-kthreads.rst
> diff --git a/Documentation/auxdisplay/lcd-panel-cgram.rst b/Documentation/admin-guide/lcd-panel-cgram.rst
> similarity index 99%
> rename from Documentation/auxdisplay/lcd-panel-cgram.rst
> rename to Documentation/admin-guide/lcd-panel-cgram.rst
> index dfef50286018..a3eb00c62f53 100644
> --- a/Documentation/auxdisplay/lcd-panel-cgram.rst
> +++ b/Documentation/admin-guide/lcd-panel-cgram.rst
> @@ -1,5 +1,3 @@
> -:orphan:
> -
>  ======================================
>  Parallel port LCD/Keypad Panel support
>  ======================================
> diff --git a/Documentation/ldm.txt b/Documentation/admin-guide/ldm.rst
> similarity index 100%
> rename from Documentation/ldm.txt
> rename to Documentation/admin-guide/ldm.rst
> diff --git a/Documentation/lockup-watchdogs.txt b/Documentation/admin-guide/lockup-watchdogs.rst
> similarity index 100%
> rename from Documentation/lockup-watchdogs.txt
> rename to Documentation/admin-guide/lockup-watchdogs.rst
> diff --git a/Documentation/cma/debugfs.rst b/Documentation/admin-guide/mm/cma_debugfs.rst
> similarity index 98%
> rename from Documentation/cma/debugfs.rst
> rename to Documentation/admin-guide/mm/cma_debugfs.rst
> index 518fe401b5ee..4e06ffabd78a 100644
> --- a/Documentation/cma/debugfs.rst
> +++ b/Documentation/admin-guide/mm/cma_debugfs.rst
> @@ -1,5 +1,3 @@
> -:orphan:
> -
>  =====================
>  CMA Debugfs Interface
>  =====================
> diff --git a/Documentation/admin-guide/mm/index.rst b/Documentation/admin-guide/mm/index.rst
> index 5f61a6c429e0..11db46448354 100644
> --- a/Documentation/admin-guide/mm/index.rst
> +++ b/Documentation/admin-guide/mm/index.rst
> @@ -26,6 +26,7 @@ the Linux memory management.
>     :maxdepth: 1
>  
>     concepts
> +   cma_debugfs
>     hugetlbpage
>     idle_page_tracking
>     ksm
> diff --git a/Documentation/numastat.txt b/Documentation/admin-guide/numastat.rst
> similarity index 100%
> rename from Documentation/numastat.txt
> rename to Documentation/admin-guide/numastat.rst
> diff --git a/Documentation/pnp.txt b/Documentation/admin-guide/pnp.rst
> similarity index 100%
> rename from Documentation/pnp.txt
> rename to Documentation/admin-guide/pnp.rst
> diff --git a/Documentation/rtc.txt b/Documentation/admin-guide/rtc.rst
> similarity index 100%
> rename from Documentation/rtc.txt
> rename to Documentation/admin-guide/rtc.rst
> diff --git a/Documentation/svga.txt b/Documentation/admin-guide/svga.rst
> similarity index 100%
> rename from Documentation/svga.txt
> rename to Documentation/admin-guide/svga.rst
> diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
> index a0c1d4ce403a..032c7cd3cede 100644
> --- a/Documentation/admin-guide/sysctl/kernel.rst
> +++ b/Documentation/admin-guide/sysctl/kernel.rst
> @@ -327,7 +327,7 @@ when a hard lockup is detected.
>     0 - don't panic on hard lockup
>     1 - panic on hard lockup
>  
> -See Documentation/lockup-watchdogs.txt for more information.  This can
> +See Documentation/admin-guide/lockup-watchdogs.rst for more information.  This can
>  also be set using the nmi_watchdog kernel parameter.
>  
>  
> diff --git a/Documentation/video-output.txt b/Documentation/admin-guide/video-output.rst
> similarity index 100%
> rename from Documentation/video-output.txt
> rename to Documentation/admin-guide/video-output.rst
> diff --git a/Documentation/fb/vesafb.rst b/Documentation/fb/vesafb.rst
> index 2ed0dfb661cf..6821c87b7893 100644
> --- a/Documentation/fb/vesafb.rst
> +++ b/Documentation/fb/vesafb.rst
> @@ -30,7 +30,7 @@ How to use it?
>  ==============
>  
>  Switching modes is done using the vga=... boot parameter.  Read
> -Documentation/svga.txt for details.
> +Documentation/admin-guide/svga.rst for details.
>  
>  You should compile in both vgacon (for text mode) and vesafb (for
>  graphics mode). Which of them takes over the console depends on
> diff --git a/Documentation/x86/topology.rst b/Documentation/x86/topology.rst
> index 8e9704f61017..e29739904e37 100644
> --- a/Documentation/x86/topology.rst
> +++ b/Documentation/x86/topology.rst
> @@ -9,7 +9,7 @@ representation in the kernel. Update/change when doing changes to the
>  respective code.
>  
>  The architecture-agnostic topology definitions are in
> -Documentation/cputopology.txt. This file holds x86-specific
> +Documentation/admin-guide/cputopology.rst. This file holds x86-specific
>  differences/specialities which must not necessarily apply to the generic
>  definitions. Thus, the way to read up on Linux topology on x86 is to start
>  with the generic one and look at this one in parallel for the x86 specifics.
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 82222aa618c5..76b52a20663e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6054,7 +6054,7 @@ M:	Ard Biesheuvel <ard.biesheuvel@linaro.org>
>  L:	linux-efi@vger.kernel.org
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git
>  S:	Maintained
> -F:	Documentation/efi-stub.txt
> +F:	Documentation/admin-guide/efi-stub.rst
>  F:	arch/*/kernel/efi.c
>  F:	arch/x86/boot/compressed/eboot.[ch]
>  F:	arch/*/include/asm/efi.h
> @@ -7033,7 +7033,7 @@ M:	Herbert Xu <herbert@gondor.apana.org.au>
>  L:	linux-crypto@vger.kernel.org
>  S:	Odd fixes
>  F:	Documentation/devicetree/bindings/rng/
> -F:	Documentation/hw_random.txt
> +F:	Documentation/admin-guide/hw_random.rst
>  F:	drivers/char/hw_random/
>  F:	include/linux/hw_random.h
>  
> @@ -9347,7 +9347,7 @@ M:	"Richard Russon (FlatCap)" <ldm@flatcap.org>
>  L:	linux-ntfs-dev@lists.sourceforge.net
>  W:	http://www.linux-ntfs.org/content/view/19/37/
>  S:	Maintained
> -F:	Documentation/ldm.txt
> +F:	Documentation/admin-guide/ldm.rst
>  F:	block/partitions/ldm.*
>  
>  LSILOGIC MPT FUSION DRIVERS (FC/SAS/SPI)
> @@ -12000,7 +12000,7 @@ PARALLEL LCD/KEYPAD PANEL DRIVER
>  M:	Willy Tarreau <willy@haproxy.com>
>  M:	Ksenija Stanojevic <ksenija.stanojevic@gmail.com>
>  S:	Odd Fixes
> -F:	Documentation/auxdisplay/lcd-panel-cgram.rst
> +F:	Documentation/admin-guide/lcd-panel-cgram.rst
>  F:	drivers/auxdisplay/panel.c
>  
>  PARALLEL PORT SUBSYSTEM
> @@ -13419,7 +13419,7 @@ Q:	http://patchwork.ozlabs.org/project/rtc-linux/list/
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/rtc/
> -F:	Documentation/rtc.txt
> +F:	Documentation/admin-guide/rtc.rst
>  F:	drivers/rtc/
>  F:	include/linux/rtc.h
>  F:	include/uapi/linux/rtc.h
> @@ -15248,7 +15248,7 @@ SVGA HANDLING
>  M:	Martin Mares <mj@ucw.cz>
>  L:	linux-video@atrey.karlin.mff.cuni.cz
>  S:	Maintained
> -F:	Documentation/svga.txt
> +F:	Documentation/admin-guide/svga.rst
>  F:	arch/x86/boot/video*
>  
>  SWIOTLB SUBSYSTEM
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index d5bd4350fcbd..b1ab350b9d60 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1286,7 +1286,7 @@ config SMP
>  	  will run faster if you say N here.
>  
>  	  See also <file:Documentation/x86/i386/IO-APIC.rst>,
> -	  <file:Documentation/lockup-watchdogs.txt> and the SMP-HOWTO available at
> +	  <file:Documentation/admin-guide/lockup-watchdogs.rst> and the SMP-HOWTO available at
>  	  <http://tldp.org/HOWTO/SMP-HOWTO.html>.
>  
>  	  If you don't know what to do here, say N.
> diff --git a/arch/parisc/Kconfig b/arch/parisc/Kconfig
> index 42875ff15671..6d732e451071 100644
> --- a/arch/parisc/Kconfig
> +++ b/arch/parisc/Kconfig
> @@ -277,7 +277,7 @@ config SMP
>  	  machines, but will use only one CPU of a multiprocessor machine.
>  	  On a uniprocessor machine, the kernel will run faster if you say N.
>  
> -	  See also <file:Documentation/lockup-watchdogs.txt> and the SMP-HOWTO
> +	  See also <file:Documentation/admin-guide/lockup-watchdogs.rst> and the SMP-HOWTO
>  	  available at <http://www.tldp.org/docs.html#howto>.
>  
>  	  If you don't know what to do here, say N.
> diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
> index c2858ac6a46a..6b1b5941b618 100644
> --- a/arch/sh/Kconfig
> +++ b/arch/sh/Kconfig
> @@ -679,7 +679,7 @@ config SMP
>  	  People using multiprocessor machines who say Y here should also say
>  	  Y to "Enhanced Real Time Clock Support", below.
>  
> -	  See also <file:Documentation/lockup-watchdogs.txt> and the SMP-HOWTO
> +	  See also <file:Documentation/admin-guide/lockup-watchdogs.rst> and the SMP-HOWTO
>  	  available at <http://www.tldp.org/docs.html#howto>.
>  
>  	  If you don't know what to do here, say N.
> diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
> index e9f5d62e9817..7926a2e11bdc 100644
> --- a/arch/sparc/Kconfig
> +++ b/arch/sparc/Kconfig
> @@ -180,7 +180,7 @@ config SMP
>  	  Y to "Enhanced Real Time Clock Support", below. The "Advanced Power
>  	  Management" code will be disabled if you say Y here.
>  
> -	  See also <file:Documentation/lockup-watchdogs.txt> and the SMP-HOWTO
> +	  See also <file:Documentation/admin-guide/lockup-watchdogs.rst> and the SMP-HOWTO
>  	  available at <http://www.tldp.org/docs.html#howto>.
>  
>  	  If you don't know what to do here, say N.
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 489fd833b980..2ca471ae6756 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -402,7 +402,7 @@ config SMP
>  	  Management" code will be disabled if you say Y here.
>  
>  	  See also <file:Documentation/x86/i386/IO-APIC.rst>,
> -	  <file:Documentation/lockup-watchdogs.txt> and the SMP-HOWTO available at
> +	  <file:Documentation/admin-guide/lockup-watchdogs.rst> and the SMP-HOWTO available at
>  	  <http://www.tldp.org/docs.html#howto>.
>  
>  	  If you don't know what to do here, say N.
> @@ -1959,7 +1959,7 @@ config EFI_STUB
>            This kernel feature allows a bzImage to be loaded directly
>  	  by EFI firmware without the use of a bootloader.
>  
> -	  See Documentation/efi-stub.txt for more information.
> +	  See Documentation/admin-guide/efi-stub.rst for more information.
>  
>  config EFI_MIXED
>  	bool "EFI mixed-mode support"
> diff --git a/block/partitions/Kconfig b/block/partitions/Kconfig
> index 37b9710cc80a..702689a628f0 100644
> --- a/block/partitions/Kconfig
> +++ b/block/partitions/Kconfig
> @@ -194,7 +194,7 @@ config LDM_PARTITION
>  	  Normal partitions are now called Basic Disks under Windows 2000, XP,
>  	  and Vista.
>  
> -	  For a fuller description read <file:Documentation/ldm.txt>.
> +	  For a fuller description read <file:Documentation/admin-guide/ldm.rst>.
>  
>  	  If unsure, say N.
>  
> diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
> index 442403abd73a..3e866885a405 100644
> --- a/drivers/char/Kconfig
> +++ b/drivers/char/Kconfig
> @@ -291,7 +291,7 @@ config RTC
>  	  and set the RTC in an SMP compatible fashion.
>  
>  	  If you think you have a use for such a device (such as periodic data
> -	  sampling), then say Y here, and read <file:Documentation/rtc.txt>
> +	  sampling), then say Y here, and read <file:Documentation/admin-guide/rtc.rst>
>  	  for details.
>  
>  	  To compile this driver as a module, choose M here: the
> @@ -313,7 +313,7 @@ config JS_RTC
>  	  /dev/rtc.
>  
>  	  If you think you have a use for such a device (such as periodic data
> -	  sampling), then say Y here, and read <file:Documentation/rtc.txt>
> +	  sampling), then say Y here, and read <file:Documentation/admin-guide/rtc.rst>
>  	  for details.
>  
>  	  To compile this driver as a module, choose M here: the
> diff --git a/drivers/char/hw_random/core.c b/drivers/char/hw_random/core.c
> index 95be7228f327..9044d31ab1a1 100644
> --- a/drivers/char/hw_random/core.c
> +++ b/drivers/char/hw_random/core.c
> @@ -4,7 +4,7 @@
>   * Copyright 2006 Michael Buesch <m@bues.ch>
>   * Copyright 2005 (c) MontaVista Software, Inc.
>   *
> - * Please read Documentation/hw_random.txt for details on use.
> + * Please read Documentation/admin-guide/hw_random.rst for details on use.
>   *
>   * This software may be used and distributed according to the terms
>   * of the GNU General Public License, incorporated herein by reference.
> diff --git a/include/linux/hw_random.h b/include/linux/hw_random.h
> index c0b93e0ff0c0..8e6dd908da21 100644
> --- a/include/linux/hw_random.h
> +++ b/include/linux/hw_random.h
> @@ -1,7 +1,7 @@
>  /*
>  	Hardware Random Number Generator
>  
> -	Please read Documentation/hw_random.txt for details on use.
> +	Please read Documentation/admin-guide/hw_random.rst for details on use.
>  
>  	----------------------------------------------------------
>  	This software may be used and distributed according to the terms
> -- 
> 2.21.0
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
