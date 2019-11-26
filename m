Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 017CD10A2C9
	for <lists+linux-efi@lfdr.de>; Tue, 26 Nov 2019 17:56:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728525AbfKZQyn (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 26 Nov 2019 11:54:43 -0500
Received: from mga17.intel.com ([192.55.52.151]:10925 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727756AbfKZQym (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 26 Nov 2019 11:54:42 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Nov 2019 08:54:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,246,1571727600"; 
   d="scan'208";a="217197185"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.41])
  by fmsmga001.fm.intel.com with ESMTP; 26 Nov 2019 08:54:41 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
Cc:     Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Nadav Amit <nadav.amit@gmail.com>,
        "VMware, Inc." <pv-drivers@vmware.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-acpi@vger.kernel.org, alsa-devel@alsa-project.org
Subject: [PATCH v2 00/12] treewide: break dependencies on x86's RM header
Date:   Tue, 26 Nov 2019 08:54:05 -0800
Message-Id: <20191126165417.22423-1-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

x86's asm/realmode.h, which defines low level structures, variables and
helpers used to bring up APs during SMP boot, ends up getting included in
practically every nook and cranny of the kernel because the address used
by ACPI for resuming from S3 also happens to be stored in the real mode
header, and ACPI bleeds the dependency into its widely included headers.

As a result, modifying realmode.h for even the most trivial change to the
boot code triggers a full kernel rebuild, which is frustrating to say the
least as it some of the most difficult code to get exactly right *and* is
also some of the most functionally isolated code in the kernel.

To break the kernel's widespread dependency on realmode.h, add a wrapper
in the aforementioned ACPI S3 code to access the real mode header instead
of derefencing the header directly in asm/acpi.h and thereby exposing it
to the world via linux/acpi.h.

v2:
  - Rebased on tip/x86/cleanups, commit b74374fef924 ("x86/setup: Enhance
    the comments").
  - Use acpi_get_wakeup_address() as new function name. [Boris and Pavel]
  - Capture acpi_get_wakeup_address() in a local address. [Pavel]
  - Collect acks.  I didn't add Rafael's acks on patches 11 and 12 due to
    the above changes.
  - Explicitly call out the removal of <asm/realmode.h> from <asm/acpi.h>
    in patch 12. [Ingo]
  - Remove superfluous Fixes: tags. [Ard]

Patch Synopsis:
  - Patches 01-09 fix a variety of build errors that arise when patch 12
    drops realmode.h from asm/acpi.h.  Most of the errors are quite absurb
    as they have no relation whatsoever to x86's RM boot code, but occur
    because realmode.h happens to include asm/io.h.

  - Patch 10 removes a spurious include of realmode.h from an ACPI header.

  - Patches 11 and 12 implement the wrapper and move it out of acpi.h.


Sean Christopherson (12):
  x86/efi: Explicitly include realmode.h to handle RM trampoline quirk
  x86/boot: Explicitly include realmode.h to handle RM reservations
  x86/ftrace: Explicitly include vmalloc.h for
    set_vm_flush_reset_perms()
  x86/kprobes: Explicitly include vmalloc.h for
    set_vm_flush_reset_perms()
  perf/x86/intel: Explicitly include asm/io.h to use virt_to_phys()
  efi/capsule-loader: Explicitly include linux/io.h for page_to_phys()
  virt: vbox: Explicitly include linux/io.h to pick up various defs
  vmw_balloon: Explicitly include linux/io.h for virt_to_phys()
  ASoC: Intel: Skylake: Explicitly include linux/io.h for virt_to_phys()
  x86/ACPI/sleep: Remove an unnecessary include of asm/realmode.h
  ACPI/sleep: Convert acpi_wakeup_address into a function
  x86/ACPI/sleep: Move acpi_get_wakeup_address() into sleep.c, remove
    <asm/realmode.h> from <asm/acpi.h>

 arch/ia64/include/asm/acpi.h             |  5 ++++-
 arch/ia64/kernel/acpi.c                  |  2 --
 arch/x86/events/intel/ds.c               |  1 +
 arch/x86/include/asm/acpi.h              |  3 +--
 arch/x86/kernel/acpi/sleep.c             | 11 +++++++++++
 arch/x86/kernel/acpi/sleep.h             |  2 +-
 arch/x86/kernel/ftrace.c                 |  1 +
 arch/x86/kernel/kprobes/core.c           |  1 +
 arch/x86/kernel/setup.c                  |  1 +
 arch/x86/platform/efi/quirks.c           |  1 +
 drivers/acpi/sleep.c                     |  3 +++
 drivers/firmware/efi/capsule-loader.c    |  1 +
 drivers/misc/vmw_balloon.c               |  1 +
 drivers/virt/vboxguest/vboxguest_core.c  |  1 +
 drivers/virt/vboxguest/vboxguest_utils.c |  1 +
 sound/soc/intel/skylake/skl-sst-cldma.c  |  1 +
 16 files changed, 30 insertions(+), 6 deletions(-)

-- 
2.24.0

