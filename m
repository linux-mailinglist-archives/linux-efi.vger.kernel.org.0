Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3264330B886
	for <lists+linux-efi@lfdr.de>; Tue,  2 Feb 2021 08:20:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbhBBHT0 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 2 Feb 2021 02:19:26 -0500
Received: from condef-03.nifty.com ([202.248.20.68]:39875 "EHLO
        condef-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbhBBHT0 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 2 Feb 2021 02:19:26 -0500
X-Greylist: delayed 439 seconds by postgrey-1.27 at vger.kernel.org; Tue, 02 Feb 2021 02:19:24 EST
Received: from conuserg-10.nifty.com ([10.126.8.73])by condef-03.nifty.com with ESMTP id 11277FMo011668;
        Tue, 2 Feb 2021 16:08:23 +0900
Received: from oscar.flets-west.jp (softbank126026094251.bbtec.net [126.26.94.251]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id 11274eAp003392;
        Tue, 2 Feb 2021 16:04:40 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 11274eAp003392
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1612249482;
        bh=b2jPOlkmNQEQwNHcvOIubOJ6oDXT0fTKYaGEmlHljAI=;
        h=From:To:Cc:Subject:Date:From;
        b=ueStfIRG5Kl3BNbhbUI+1XErXYBed+C5Jh8MnATHP9lkxK1OPYAlfvj/RtamHV8zj
         9Q/n6GroGELc152fNd91JuIgemZpOSKoDrYe2lBHtgZoEVoBFA9mXcgX10QqawDv1W
         Xkvrdpy911mi+dNTLCX7d9TGTkt+1gchbISTycZ6/o0LLSxp3l6qG0JFb/Qu9WAZ2U
         q63DivUoTZYnQmRFXgehWgq7ugRH/r05woY9m3GcizA4e3HmJO1Nq/+GjpvvJvx928
         rmgl8QfD3vEHFz0gyu483qLBzG++IuO5AuKr/mRPbysfs5S2yZnraS+0pcbZvmzYqR
         I5t+s0cWbt1fA==
X-Nifty-SrcIP: [126.26.94.251]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Andy Shevchenko <andy@infradead.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Darren Hart <dvhart@infradead.org>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Mike Travis <mike.travis@hpe.com>,
        Peter Jones <pjones@redhat.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Steve Wahl <steve.wahl@hpe.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        dri-devel@lists.freedesktop.org, linux-efi@vger.kernel.org,
        linux-fbdev@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        x86@kernel.org
Subject: [PATCH 1/3] printk: use CONFIG_CONSOLE_LOGLEVEL_* directly
Date:   Tue,  2 Feb 2021 16:02:16 +0900
Message-Id: <20210202070218.856847-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

CONSOLE_LOGLEVEL_DEFAULT is nothing more than a shorthand of
CONFIG_CONSOLE_LOGLEVEL_DEFAULT.

When you change CONFIG_CONSOLE_LOGLEVEL_DEFAULT from Kconfig, almost
all objects are rebuilt because CONFIG_CONSOLE_LOGLEVEL_DEFAULT is
used in <linux/printk.h>, which is included from most of source files.

In fact, there are only 4 users of CONSOLE_LOGLEVEL_DEFAULT:

  arch/x86/platform/uv/uv_nmi.c
  drivers/firmware/efi/libstub/efi-stub-helper.c
  drivers/tty/sysrq.c
  kernel/printk/printk.c

So, when you change CONFIG_CONSOLE_LOGLEVEL_DEFAULT and rebuild the
kernel, it is enough to recompile those 4 files.

Remove the CONSOLE_LOGLEVEL_DEFAULT definition from <linux/printk.h>,
and use CONFIG_CONSOLE_LOGLEVEL_DEFAULT directly.

With this, the build system will rebuild the minimal number of objects.

Steps to confirm it:

  [1] Do the full build
  [2] Change CONFIG_CONSOLE_LOGLEVEL_DEFAULT from 'make menuconfig' etc.
  [3] Rebuild

  $ make
    SYNC    include/config/auto.conf
    CALL    scripts/checksyscalls.sh
    CALL    scripts/atomic/check-atomics.sh
    DESCEND  objtool
    CHK     include/generated/compile.h
    CC      kernel/printk/printk.o
    AR      kernel/printk/built-in.a
    AR      kernel/built-in.a
    CC      drivers/tty/sysrq.o
    AR      drivers/tty/built-in.a
    CC      drivers/firmware/efi/libstub/efi-stub-helper.o
    STUBCPY drivers/firmware/efi/libstub/efi-stub-helper.stub.o
    AR      drivers/firmware/efi/libstub/lib.a
    AR      drivers/built-in.a
    GEN     .version
    CHK     include/generated/compile.h
    UPD     include/generated/compile.h
    CC      init/version.o
    AR      init/built-in.a
    LD      vmlinux.o
    ...

For the same reason, do likewise for CONSOLE_LOGLEVEL_QUIET and
MESSAGE_LOGLEVEL_DEFAULT.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/x86/platform/uv/uv_nmi.c                  |  2 +-
 drivers/firmware/efi/libstub/efi-stub-helper.c |  6 +++---
 drivers/tty/sysrq.c                            |  4 ++--
 drivers/video/fbdev/core/fbcon.c               |  2 +-
 drivers/video/fbdev/efifb.c                    |  2 +-
 include/linux/printk.h                         | 10 ----------
 init/main.c                                    |  2 +-
 kernel/printk/printk.c                         |  6 +++---
 8 files changed, 12 insertions(+), 22 deletions(-)

diff --git a/arch/x86/platform/uv/uv_nmi.c b/arch/x86/platform/uv/uv_nmi.c
index eafc530c8767..4751299c7416 100644
--- a/arch/x86/platform/uv/uv_nmi.c
+++ b/arch/x86/platform/uv/uv_nmi.c
@@ -100,7 +100,7 @@ static cpumask_var_t uv_nmi_cpu_mask;
  * Default is all stack dumps go to the console and buffer.
  * Lower level to send to log buffer only.
  */
-static int uv_nmi_loglevel = CONSOLE_LOGLEVEL_DEFAULT;
+static int uv_nmi_loglevel = CONFIG_CONSOLE_LOGLEVEL_DEFAULT;
 module_param_named(dump_loglevel, uv_nmi_loglevel, int, 0644);
 
 /*
diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index aa8da0a49829..3e8d8f706589 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -12,7 +12,7 @@
 #include <linux/ctype.h>
 #include <linux/efi.h>
 #include <linux/kernel.h>
-#include <linux/printk.h> /* For CONSOLE_LOGLEVEL_* */
+#include <linux/printk.h> /* For CONSOLE_LOGLEVEL_DEBUG */
 #include <asm/efi.h>
 #include <asm/setup.h>
 
@@ -21,7 +21,7 @@
 bool efi_nochunk;
 bool efi_nokaslr = !IS_ENABLED(CONFIG_RANDOMIZE_BASE);
 bool efi_noinitrd;
-int efi_loglevel = CONSOLE_LOGLEVEL_DEFAULT;
+int efi_loglevel = CONFIG_CONSOLE_LOGLEVEL_DEFAULT;
 bool efi_novamap;
 
 static bool efi_nosoftreserve;
@@ -213,7 +213,7 @@ efi_status_t efi_parse_options(char const *cmdline)
 		if (!strcmp(param, "nokaslr")) {
 			efi_nokaslr = true;
 		} else if (!strcmp(param, "quiet")) {
-			efi_loglevel = CONSOLE_LOGLEVEL_QUIET;
+			efi_loglevel = CONFIG_CONSOLE_LOGLEVEL_QUIET;
 		} else if (!strcmp(param, "noinitrd")) {
 			efi_noinitrd = true;
 		} else if (!strcmp(param, "efi") && val) {
diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index 959f9e121cc6..e0ae7793155e 100644
--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -103,7 +103,7 @@ static void sysrq_handle_loglevel(int key)
 	int i;
 
 	i = key - '0';
-	console_loglevel = CONSOLE_LOGLEVEL_DEFAULT;
+	console_loglevel = CONFIG_CONSOLE_LOGLEVEL_DEFAULT;
 	pr_info("Loglevel set to %d\n", i);
 	console_loglevel = i;
 }
@@ -584,7 +584,7 @@ void __handle_sysrq(int key, bool check_mask)
 	 * routing in the consumers of /proc/kmsg.
 	 */
 	orig_log_level = console_loglevel;
-	console_loglevel = CONSOLE_LOGLEVEL_DEFAULT;
+	console_loglevel = CONFIG_CONSOLE_LOGLEVEL_DEFAULT;
 
         op_p = __sysrq_get_key_op(key);
         if (op_p) {
diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index bf61598bf1c3..75b97268663f 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -1043,7 +1043,7 @@ static void fbcon_init(struct vc_data *vc, int init)
 
 	info = registered_fb[con2fb_map[vc->vc_num]];
 
-	if (logo_shown < 0 && console_loglevel <= CONSOLE_LOGLEVEL_QUIET)
+	if (logo_shown < 0 && console_loglevel <= CONFIG_CONSOLE_LOGLEVEL_QUIET)
 		logo_shown = FBCON_LOGO_DONTSHOW;
 
 	if (vc != svc || logo_shown == FBCON_LOGO_DONTSHOW ||
diff --git a/drivers/video/fbdev/efifb.c b/drivers/video/fbdev/efifb.c
index e57c00824965..dfb234a0a59d 100644
--- a/drivers/video/fbdev/efifb.c
+++ b/drivers/video/fbdev/efifb.c
@@ -160,7 +160,7 @@ static void efifb_show_boot_graphics(struct fb_info *info)
 	}
 
 	/* Avoid flashing the logo if we're going to print std probe messages */
-	if (console_loglevel > CONSOLE_LOGLEVEL_QUIET)
+	if (console_loglevel > CONFIG_CONSOLE_LOGLEVEL_QUIET)
 		return;
 
 	/* bgrt_tab.status is unreliable, so we don't check it */
diff --git a/include/linux/printk.h b/include/linux/printk.h
index fe7eb2351610..fd34b3aa2f90 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -46,22 +46,12 @@ static inline const char *printk_skip_headers(const char *buffer)
 
 #define CONSOLE_EXT_LOG_MAX	8192
 
-/* printk's without a loglevel use this.. */
-#define MESSAGE_LOGLEVEL_DEFAULT CONFIG_MESSAGE_LOGLEVEL_DEFAULT
-
 /* We show everything that is MORE important than this.. */
 #define CONSOLE_LOGLEVEL_SILENT  0 /* Mum's the word */
 #define CONSOLE_LOGLEVEL_MIN	 1 /* Minimum loglevel we let people use */
 #define CONSOLE_LOGLEVEL_DEBUG	10 /* issue debug messages */
 #define CONSOLE_LOGLEVEL_MOTORMOUTH 15	/* You can't shut this one up */
 
-/*
- * Default used to be hard-coded at 7, quiet used to be hardcoded at 4,
- * we're now allowing both to be set from kernel config.
- */
-#define CONSOLE_LOGLEVEL_DEFAULT CONFIG_CONSOLE_LOGLEVEL_DEFAULT
-#define CONSOLE_LOGLEVEL_QUIET	 CONFIG_CONSOLE_LOGLEVEL_QUIET
-
 extern int console_printk[];
 
 #define console_loglevel (console_printk[0])
diff --git a/init/main.c b/init/main.c
index c68d784376ca..4dfcbf7f24c6 100644
--- a/init/main.c
+++ b/init/main.c
@@ -236,7 +236,7 @@ static int __init debug_kernel(char *str)
 
 static int __init quiet_kernel(char *str)
 {
-	console_loglevel = CONSOLE_LOGLEVEL_QUIET;
+	console_loglevel = CONFIG_CONSOLE_LOGLEVEL_QUIET;
 	return 0;
 }
 
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 5a95c688621f..92b93340905c 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -61,10 +61,10 @@
 #include "internal.h"
 
 int console_printk[4] = {
-	CONSOLE_LOGLEVEL_DEFAULT,	/* console_loglevel */
-	MESSAGE_LOGLEVEL_DEFAULT,	/* default_message_loglevel */
+	CONFIG_CONSOLE_LOGLEVEL_DEFAULT,	/* console_loglevel */
+	CONFIG_MESSAGE_LOGLEVEL_DEFAULT,	/* default_message_loglevel */
 	CONSOLE_LOGLEVEL_MIN,		/* minimum_console_loglevel */
-	CONSOLE_LOGLEVEL_DEFAULT,	/* default_console_loglevel */
+	CONFIG_CONSOLE_LOGLEVEL_DEFAULT,	/* default_console_loglevel */
 };
 EXPORT_SYMBOL_GPL(console_printk);
 
-- 
2.27.0

