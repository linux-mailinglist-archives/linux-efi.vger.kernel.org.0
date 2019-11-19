Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14DB1100FF0
	for <lists+linux-efi@lfdr.de>; Tue, 19 Nov 2019 01:22:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727456AbfKSAVy (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 18 Nov 2019 19:21:54 -0500
Received: from mga18.intel.com ([134.134.136.126]:64626 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727446AbfKSAVx (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 18 Nov 2019 19:21:53 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Nov 2019 16:21:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,321,1569308400"; 
   d="scan'208";a="215412063"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.41])
  by fmsmga001.fm.intel.com with ESMTP; 18 Nov 2019 16:21:51 -0800
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
        Ard Biesheuvel <ardb@kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Nadav Amit <namit@vmware.com>,
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
Subject: [PATCH 12/12] x86/ACPI/sleep: Move acpi_wakeup_address() definition into sleep.c
Date:   Mon, 18 Nov 2019 16:21:21 -0800
Message-Id: <20191119002121.4107-13-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191119002121.4107-1-sean.j.christopherson@intel.com>
References: <20191119002121.4107-1-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Move the definition of acpi_wakeup_address() into sleep.c to break
linux/acpi.h's dependency (by way of asm/acpi.h) on asm/realmode.h.
Everyone and their mother includes linux/acpi.h, i.e. modifying
realmode.h results in a full kernel rebuild, which makes the already
inscrutable real mode boot code even more difficult to understand and is
positively rage inducing when trying to make changes to x86's boot flow.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 arch/x86/include/asm/acpi.h  |  6 +-----
 arch/x86/kernel/acpi/sleep.c | 11 +++++++++++
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/acpi.h b/arch/x86/include/asm/acpi.h
index 57788ec6fa82..0cae3f773d44 100644
--- a/arch/x86/include/asm/acpi.h
+++ b/arch/x86/include/asm/acpi.h
@@ -13,7 +13,6 @@
 #include <asm/processor.h>
 #include <asm/mmu.h>
 #include <asm/mpspec.h>
-#include <asm/realmode.h>
 #include <asm/x86_init.h>
 
 #ifdef CONFIG_ACPI_APEI
@@ -62,10 +61,7 @@ static inline void acpi_disable_pci(void)
 extern int (*acpi_suspend_lowlevel)(void);
 
 /* Physical address to resume after wakeup */
-static inline unsigned long acpi_wakeup_address(void)
-{
-	return ((unsigned long)(real_mode_header->wakeup_start));
-}
+unsigned long acpi_wakeup_address(void);
 
 /*
  * Check if the CPU can handle C2 and deeper
diff --git a/arch/x86/kernel/acpi/sleep.c b/arch/x86/kernel/acpi/sleep.c
index ca13851f0570..44d3fb1a1de3 100644
--- a/arch/x86/kernel/acpi/sleep.c
+++ b/arch/x86/kernel/acpi/sleep.c
@@ -26,6 +26,17 @@ unsigned long acpi_realmode_flags;
 static char temp_stack[4096];
 #endif
 
+/**
+ * acpi_wakeup_address - provide physical address for S3 wakeup
+ *
+ * Returns the physical address where the kernel should be resumed after the
+ * system awakes from S3, e.g. for programming into the firmware waking vector.
+ */
+unsigned long acpi_wakeup_address(void)
+{
+	return ((unsigned long)(real_mode_header->wakeup_start));
+}
+
 /**
  * x86_acpi_enter_sleep_state - enter sleep state
  * @state: Sleep state to enter.
-- 
2.24.0

