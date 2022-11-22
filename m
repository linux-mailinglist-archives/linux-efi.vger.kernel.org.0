Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 325D4633ADE
	for <lists+linux-efi@lfdr.de>; Tue, 22 Nov 2022 12:13:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233085AbiKVLNC (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 22 Nov 2022 06:13:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233035AbiKVLMu (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 22 Nov 2022 06:12:50 -0500
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5ABC26E7;
        Tue, 22 Nov 2022 03:12:48 -0800 (PST)
Received: from localhost.localdomain (unknown [83.149.199.65])
        by mail.ispras.ru (Postfix) with ESMTPSA id 0EA8940737D3;
        Tue, 22 Nov 2022 11:12:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 0EA8940737D3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1669115563;
        bh=JKR4+ObQtQjwfYYyUcXe53+b720hGz8SOe315kCniAg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k4Abx8h56041Vq0U7YfMBwa3ZyQpLeGUi9nHJQRAKJc0apeT9oSeCEasQ1JPH1llt
         OeJjy3sOgtT16CpHIqFLQwcX5yOeZ+Ht7otPJ7EXOy5UlpnQYyZps+WxJ+bTQqEGe3
         Q8RGjV1KB/cdNjIAseSi6o2/fRWnG8w1h2hlEHQ0=
From:   Evgeniy Baskov <baskov@ispras.ru>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Evgeniy Baskov <baskov@ispras.ru>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Peter Jones <pjones@redhat.com>,
        "Limonciello, Mario" <mario.limonciello@amd.com>,
        joeyli <jlee@suse.com>, lvc-project@linuxtesting.org,
        x86@kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH v3 11/24] x86/boot: Make console interface more abstract
Date:   Tue, 22 Nov 2022 14:12:20 +0300
Message-Id: <3b10a3a30ed854e42291c64cc4446c3711a48bcf.1668958803.git.baskov@ispras.ru>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <cover.1668958803.git.baskov@ispras.ru>
References: <cover.1668958803.git.baskov@ispras.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

To be able to extract kernel from EFI, console output functions
need to be replaceable by alternative implementations.

Make all of those functions pointers.
Move serial console code to separate file.

Tested-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Evgeniy Baskov <baskov@ispras.ru>
---
 arch/x86/boot/compressed/Makefile |   2 +-
 arch/x86/boot/compressed/misc.c   | 109 +------------------------
 arch/x86/boot/compressed/misc.h   |   9 ++-
 arch/x86/boot/compressed/putstr.c | 130 ++++++++++++++++++++++++++++++
 4 files changed, 139 insertions(+), 111 deletions(-)
 create mode 100644 arch/x86/boot/compressed/putstr.c

diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 64de6c2b1740..f79273f46cc7 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -93,7 +93,7 @@ $(obj)/misc.o: $(obj)/../voffset.h
 
 vmlinux-objs-y := $(obj)/vmlinux.lds $(obj)/kernel_info.o $(obj)/head_$(BITS).o \
 	$(obj)/misc.o $(obj)/string.o $(obj)/cmdline.o $(obj)/error.o \
-	$(obj)/piggy.o $(obj)/cpuflags.o
+	$(obj)/piggy.o $(obj)/cpuflags.o $(obj)/putstr.o
 
 vmlinux-objs-$(CONFIG_EARLY_PRINTK) += $(obj)/early_serial_console.o
 vmlinux-objs-$(CONFIG_RANDOMIZE_BASE) += $(obj)/kaslr.o
diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
index 0c7ec290044d..aa4a22bc9cf9 100644
--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -53,13 +53,6 @@ struct port_io_ops pio_ops;
 memptr free_mem_ptr;
 memptr free_mem_end_ptr;
 
-static char *vidmem;
-static int vidport;
-
-/* These might be accessed before .bss is cleared, so use .data instead. */
-static int lines __section(".data");
-static int cols __section(".data");
-
 #ifdef CONFIG_KERNEL_GZIP
 #include "../../../../lib/decompress_inflate.c"
 #endif
@@ -92,95 +85,6 @@ static int cols __section(".data");
  * ../header.S.
  */
 
-static void scroll(void)
-{
-	int i;
-
-	memmove(vidmem, vidmem + cols * 2, (lines - 1) * cols * 2);
-	for (i = (lines - 1) * cols * 2; i < lines * cols * 2; i += 2)
-		vidmem[i] = ' ';
-}
-
-#define XMTRDY          0x20
-
-#define TXR             0       /*  Transmit register (WRITE) */
-#define LSR             5       /*  Line Status               */
-static void serial_putchar(int ch)
-{
-	unsigned timeout = 0xffff;
-
-	while ((inb(early_serial_base + LSR) & XMTRDY) == 0 && --timeout)
-		cpu_relax();
-
-	outb(ch, early_serial_base + TXR);
-}
-
-void __putstr(const char *s)
-{
-	int x, y, pos;
-	char c;
-
-	if (early_serial_base) {
-		const char *str = s;
-		while (*str) {
-			if (*str == '\n')
-				serial_putchar('\r');
-			serial_putchar(*str++);
-		}
-	}
-
-	if (lines == 0 || cols == 0)
-		return;
-
-	x = boot_params->screen_info.orig_x;
-	y = boot_params->screen_info.orig_y;
-
-	while ((c = *s++) != '\0') {
-		if (c == '\n') {
-			x = 0;
-			if (++y >= lines) {
-				scroll();
-				y--;
-			}
-		} else {
-			vidmem[(x + cols * y) * 2] = c;
-			if (++x >= cols) {
-				x = 0;
-				if (++y >= lines) {
-					scroll();
-					y--;
-				}
-			}
-		}
-	}
-
-	boot_params->screen_info.orig_x = x;
-	boot_params->screen_info.orig_y = y;
-
-	pos = (x + cols * y) * 2;	/* Update cursor position */
-	outb(14, vidport);
-	outb(0xff & (pos >> 9), vidport+1);
-	outb(15, vidport);
-	outb(0xff & (pos >> 1), vidport+1);
-}
-
-void __puthex(unsigned long value)
-{
-	char alpha[2] = "0";
-	int bits;
-
-	for (bits = sizeof(value) * 8 - 4; bits >= 0; bits -= 4) {
-		unsigned long digit = (value >> bits) & 0xf;
-
-		if (digit < 0xA)
-			alpha[0] = '0' + digit;
-		else
-			alpha[0] = 'a' + (digit - 0xA);
-
-		__putstr(alpha);
-	}
-}
-
 #ifdef CONFIG_X86_NEED_RELOCS
 static void handle_relocations(void *output, unsigned long output_len,
 			       unsigned long virt_addr)
@@ -406,17 +310,6 @@ asmlinkage __visible void *extract_kernel(void *rmode, memptr heap,
 
 	sanitize_boot_params(boot_params);
 
-	if (boot_params->screen_info.orig_video_mode == 7) {
-		vidmem = (char *) 0xb0000;
-		vidport = 0x3b4;
-	} else {
-		vidmem = (char *) 0xb8000;
-		vidport = 0x3d4;
-	}
-
-	lines = boot_params->screen_info.orig_video_lines;
-	cols = boot_params->screen_info.orig_video_cols;
-
 	init_default_io_ops();
 
 	/*
@@ -427,7 +320,7 @@ asmlinkage __visible void *extract_kernel(void *rmode, memptr heap,
 	 */
 	early_tdx_detect();
 
-	console_init();
+	init_bare_console();
 
 	/*
 	 * Save RSDP address for later use. Have this after console_init()
diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index 033db9b536e6..38d31bec062d 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -57,8 +57,8 @@ extern memptr free_mem_end_ptr;
 void *malloc(int size);
 void free(void *where);
 extern struct boot_params *boot_params;
-void __putstr(const char *s);
-void __puthex(unsigned long value);
+extern void (*__putstr)(const char *s);
+extern void (*__puthex)(unsigned long value);
 #define error_putstr(__x)  __putstr(__x)
 #define error_puthex(__x)  __puthex(__x)
 
@@ -128,6 +128,11 @@ static inline void console_init(void)
 { }
 #endif
 
+/* putstr.c */
+void init_bare_console(void);
+void init_console_func(void (*putstr_)(const char *),
+		       void (*puthex_)(unsigned long));
+
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 void sev_enable(struct boot_params *bp);
 void sev_es_shutdown_ghcb(void);
diff --git a/arch/x86/boot/compressed/putstr.c b/arch/x86/boot/compressed/putstr.c
new file mode 100644
index 000000000000..44a4c3dacec5
--- /dev/null
+++ b/arch/x86/boot/compressed/putstr.c
@@ -0,0 +1,130 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "misc.h"
+
+/* These might be accessed before .bss is cleared, so use .data instead. */
+static char *vidmem __section(".data");
+static int vidport __section(".data");
+static int lines __section(".data");
+static int cols __section(".data");
+
+void (*__putstr)(const char *s);
+void (*__puthex)(unsigned long value);
+
+static void putstr(const char *s);
+static void puthex(unsigned long value);
+
+void init_console_func(void (*putstr_)(const char *),
+		       void (*puthex_)(unsigned long))
+{
+	__putstr = putstr_;
+	__puthex = puthex_;
+}
+
+void init_bare_console(void)
+{
+	init_console_func(putstr, puthex);
+
+	if (boot_params->screen_info.orig_video_mode == 7) {
+		vidmem = (char *) 0xb0000;
+		vidport = 0x3b4;
+	} else {
+		vidmem = (char *) 0xb8000;
+		vidport = 0x3d4;
+	}
+
+	lines = boot_params->screen_info.orig_video_lines;
+	cols = boot_params->screen_info.orig_video_cols;
+
+	console_init();
+}
+
+static void scroll(void)
+{
+	int i;
+
+	memmove(vidmem, vidmem + cols * 2, (lines - 1) * cols * 2);
+	for (i = (lines - 1) * cols * 2; i < lines * cols * 2; i += 2)
+		vidmem[i] = ' ';
+}
+
+#define XMTRDY          0x20
+
+#define TXR             0       /*  Transmit register (WRITE) */
+#define LSR             5       /*  Line Status               */
+
+static void serial_putchar(int ch)
+{
+	unsigned int timeout = 0xffff;
+
+	while ((inb(early_serial_base + LSR) & XMTRDY) == 0 && --timeout)
+		cpu_relax();
+
+	outb(ch, early_serial_base + TXR);
+}
+
+static void putstr(const char *s)
+{
+	int x, y, pos;
+	char c;
+
+	if (early_serial_base) {
+		const char *str = s;
+
+		while (*str) {
+			if (*str == '\n')
+				serial_putchar('\r');
+			serial_putchar(*str++);
+		}
+	}
+
+	if (lines == 0 || cols == 0)
+		return;
+
+	x = boot_params->screen_info.orig_x;
+	y = boot_params->screen_info.orig_y;
+
+	while ((c = *s++) != '\0') {
+		if (c == '\n') {
+			x = 0;
+			if (++y >= lines) {
+				scroll();
+				y--;
+			}
+		} else {
+			vidmem[(x + cols * y) * 2] = c;
+			if (++x >= cols) {
+				x = 0;
+				if (++y >= lines) {
+					scroll();
+					y--;
+				}
+			}
+		}
+	}
+
+	boot_params->screen_info.orig_x = x;
+	boot_params->screen_info.orig_y = y;
+
+	pos = (x + cols * y) * 2;	/* Update cursor position */
+	outb(14, vidport);
+	outb(0xff & (pos >> 9), vidport+1);
+	outb(15, vidport);
+	outb(0xff & (pos >> 1), vidport+1);
+}
+
+static void puthex(unsigned long value)
+{
+	char alpha[2] = "0";
+	int bits;
+
+	for (bits = sizeof(value) * 8 - 4; bits >= 0; bits -= 4) {
+		unsigned long digit = (value >> bits) & 0xf;
+
+		if (digit < 0xA)
+			alpha[0] = '0' + digit;
+		else
+			alpha[0] = 'a' + (digit - 0xA);
+
+		putstr(alpha);
+	}
+}
-- 
2.37.4

