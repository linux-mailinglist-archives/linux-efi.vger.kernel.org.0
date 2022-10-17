Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B67D5601492
	for <lists+linux-efi@lfdr.de>; Mon, 17 Oct 2022 19:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbiJQRSB (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 17 Oct 2022 13:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbiJQRSA (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 17 Oct 2022 13:18:00 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAC7371BF7
        for <linux-efi@vger.kernel.org>; Mon, 17 Oct 2022 10:17:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 3B9C7CE1814
        for <linux-efi@vger.kernel.org>; Mon, 17 Oct 2022 17:17:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87833C433C1;
        Mon, 17 Oct 2022 17:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666027071;
        bh=gSnarPOSL3Og8Y9mR28FyiBDyzPQrKtYvlJH0Jt5nSs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ELb3L0eT2vYlysV0B7gXip6zNVnUgoNDAxigD1qOO3CyboBy0OX7StI2F/wWCkhOJ
         mj2VEud949h2CIzhb3iKehNTb3hVAe4aaF31rEFiaQ4+i1QT3uO2PEYFbBV0d2FeKT
         RB236cYHGKumBX5xBqy1lydJ8YlidaG8uUZt+an7fszSzlY83FSVS4pQZ1d5qKL+BO
         eRFVK7bUChFwxpOg/BzAxkY0iy2YR1K92D6hTvb0/eLrCtoBJS/AqpNevRtKIYZ1I2
         KgtGXlN0HKUOtCY4N5AHT6vNVbG0yNxSATrr9Oz3/USPaVzNpQOD8NXbttg8UjnhTw
         a30U9CW2B0GxQ==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     keescook@chromium.org, Ard Biesheuvel <ardb@kernel.org>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Peter Jones <pjones@redhat.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Atish Patra <atishp@atishpatra.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Xi Ruoyao <xry111@xry111.site>,
        Lennart Poettering <lennart@poettering.net>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 10/21] efi: libstub: Enable efi_printk() in zboot decompressor
Date:   Mon, 17 Oct 2022 19:16:49 +0200
Message-Id: <20221017171700.3736890-11-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221017171700.3736890-1-ardb@kernel.org>
References: <20221017171700.3736890-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=16619; i=ardb@kernel.org; h=from:subject; bh=gSnarPOSL3Og8Y9mR28FyiBDyzPQrKtYvlJH0Jt5nSs=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjTY35LjS+mFvDktsdCAxY2JtP7ronKYMRxtGvD5Qb APnIiJSJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCY02N+QAKCRDDTyI5ktmPJIplC/ 4hbeWXCxtD53ojPJzExHXiLXXLWW/MUh5/xJO5tGpajbswEVM/Y3OzRcZq5G54l6OIjX00Z4ub1Q6P VmWd+JQNIl1CgJg/nXxbTifHA9vOOSS3KVbGgGmeg6vdX7i/aaz3mspFdeRyHyo5As1sbxpI/bO1Ns a82+/12thLUebuwz2vL8Fth31H8a9tzltsMlPtPfiVX2mIShGM6OcKjSxOc43j7lywpkB7x5IzSxB7 m3suQl8b67WHs3AOGg4qgcDGwFaGcbpk47czv5wpWtcmlBUpQL/eQte2upQQH9Kd0JViFu93qgwcI1 jM2eOkNPBGOqfELU2stHgmdKAmTw007/HamBGhPBqrn02UUCw9bFo/buUKoSBy8ES9wS4E6zjRyqXS vcpsVA8awWcF3wp9Fd33b2X21W5C2y2FWmqe5hCBQqee3HPO6N6PYSb9nYuR8tIRBlkzt4V/krCR5N +vbcZBhF/XKg9Yp8QJYvd3pe1obhTVOntKxUh/P00YaFQ=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Split the efi_printk() routine into its own source file, and provide
local implementations of strlen() and strnlen() so that the standalone
zboot app can efi_err and efi_info etc.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/kernel/image-vars.h                 |   2 -
 arch/loongarch/kernel/image-vars.h             |   2 -
 arch/riscv/kernel/image-vars.h                 |   2 -
 drivers/firmware/efi/libstub/Makefile          |   5 +-
 drivers/firmware/efi/libstub/efi-stub-helper.c | 143 ------------------
 drivers/firmware/efi/libstub/printk.c          | 154 ++++++++++++++++++++
 drivers/firmware/efi/libstub/string.c          |  33 ++++-
 drivers/firmware/efi/libstub/zboot.c           |  30 ++--
 8 files changed, 198 insertions(+), 173 deletions(-)

diff --git a/arch/arm64/kernel/image-vars.h b/arch/arm64/kernel/image-vars.h
index f7c8cdf0c302..ace584e0b065 100644
--- a/arch/arm64/kernel/image-vars.h
+++ b/arch/arm64/kernel/image-vars.h
@@ -22,8 +22,6 @@ PROVIDE(__efistub_primary_entry_offset	= primary_entry - _text);
  * position independent manner
  */
 PROVIDE(__efistub_memchr		= __pi_memchr);
-PROVIDE(__efistub_strlen		= __pi_strlen);
-PROVIDE(__efistub_strnlen		= __pi_strnlen);
 PROVIDE(__efistub_strcmp		= __pi_strcmp);
 PROVIDE(__efistub_strrchr		= __pi_strrchr);
 PROVIDE(__efistub_dcache_clean_poc	= __pi_dcache_clean_poc);
diff --git a/arch/loongarch/kernel/image-vars.h b/arch/loongarch/kernel/image-vars.h
index 5b6c7f079942..28bc632ec296 100644
--- a/arch/loongarch/kernel/image-vars.h
+++ b/arch/loongarch/kernel/image-vars.h
@@ -10,10 +10,8 @@
 __efistub_memchr		= memchr;
 __efistub_strcat		= strcat;
 __efistub_strcmp		= strcmp;
-__efistub_strlen		= strlen;
 __efistub_strncat		= strncat;
 __efistub_strnstr		= strnstr;
-__efistub_strnlen		= strnlen;
 __efistub_strrchr		= strrchr;
 __efistub_kernel_entry		= kernel_entry;
 __efistub_kernel_asize		= kernel_asize;
diff --git a/arch/riscv/kernel/image-vars.h b/arch/riscv/kernel/image-vars.h
index 9229cfe0754d..4913abd6dd10 100644
--- a/arch/riscv/kernel/image-vars.h
+++ b/arch/riscv/kernel/image-vars.h
@@ -24,8 +24,6 @@
  * position independent manner
  */
 __efistub_memchr		= memchr;
-__efistub_strlen		= strlen;
-__efistub_strnlen		= strnlen;
 __efistub_strcmp		= strcmp;
 __efistub_strrchr		= strrchr;
 
diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index 5246d69d9abf..cb600c7a14de 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -20,7 +20,8 @@ cflags-$(CONFIG_X86)		+= -m$(BITS) -D__KERNEL__ \
 # disable the stackleak plugin
 cflags-$(CONFIG_ARM64)		:= -fpie $(DISABLE_STACKLEAK_PLUGIN) \
 				   $(call cc-option,-mbranch-protection=none)
-cflags-$(CONFIG_ARM)		:= -fno-builtin -fpic \
+cflags-$(CONFIG_ARM)		:= -DEFI_HAVE_STRLEN -DEFI_HAVE_STRNLEN \
+				   -fno-builtin -fpic \
 				   $(call cc-option,-mno-single-pic-base)
 cflags-$(CONFIG_RISCV)		:= -fpic
 cflags-$(CONFIG_LOONGARCH)	:= -fpie
@@ -64,7 +65,7 @@ KCOV_INSTRUMENT			:= n
 lib-y				:= efi-stub-helper.o gop.o secureboot.o tpm.o \
 				   file.o mem.o random.o randomalloc.o pci.o \
 				   skip_spaces.o lib-cmdline.o lib-ctype.o \
-				   alignedmem.o relocate.o vsprintf.o
+				   alignedmem.o relocate.o printk.o vsprintf.o
 
 # include the stub's libfdt dependencies from lib/ when needed
 libfdt-deps			:= fdt_rw.c fdt_ro.c fdt_wip.c fdt.c \
diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index 54ab9638477b..01680b11d46d 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -9,10 +9,8 @@
 
 #include <linux/stdarg.h>
 
-#include <linux/ctype.h>
 #include <linux/efi.h>
 #include <linux/kernel.h>
-#include <linux/printk.h> /* For CONSOLE_LOGLEVEL_* */
 #include <asm/efi.h>
 #include <asm/setup.h>
 
@@ -20,7 +18,6 @@
 
 bool efi_nochunk;
 bool efi_nokaslr = !IS_ENABLED(CONFIG_RANDOMIZE_BASE);
-int efi_loglevel = CONSOLE_LOGLEVEL_DEFAULT;
 bool efi_novamap;
 
 static bool efi_noinitrd;
@@ -32,146 +29,6 @@ bool __pure __efi_soft_reserve_enabled(void)
 	return !efi_nosoftreserve;
 }
 
-/**
- * efi_char16_puts() - Write a UCS-2 encoded string to the console
- * @str:	UCS-2 encoded string
- */
-void efi_char16_puts(efi_char16_t *str)
-{
-	efi_call_proto(efi_table_attr(efi_system_table, con_out),
-		       output_string, str);
-}
-
-static
-u32 utf8_to_utf32(const u8 **s8)
-{
-	u32 c32;
-	u8 c0, cx;
-	size_t clen, i;
-
-	c0 = cx = *(*s8)++;
-	/*
-	 * The position of the most-significant 0 bit gives us the length of
-	 * a multi-octet encoding.
-	 */
-	for (clen = 0; cx & 0x80; ++clen)
-		cx <<= 1;
-	/*
-	 * If the 0 bit is in position 8, this is a valid single-octet
-	 * encoding. If the 0 bit is in position 7 or positions 1-3, the
-	 * encoding is invalid.
-	 * In either case, we just return the first octet.
-	 */
-	if (clen < 2 || clen > 4)
-		return c0;
-	/* Get the bits from the first octet. */
-	c32 = cx >> clen--;
-	for (i = 0; i < clen; ++i) {
-		/* Trailing octets must have 10 in most significant bits. */
-		cx = (*s8)[i] ^ 0x80;
-		if (cx & 0xc0)
-			return c0;
-		c32 = (c32 << 6) | cx;
-	}
-	/*
-	 * Check for validity:
-	 * - The character must be in the Unicode range.
-	 * - It must not be a surrogate.
-	 * - It must be encoded using the correct number of octets.
-	 */
-	if (c32 > 0x10ffff ||
-	    (c32 & 0xf800) == 0xd800 ||
-	    clen != (c32 >= 0x80) + (c32 >= 0x800) + (c32 >= 0x10000))
-		return c0;
-	*s8 += clen;
-	return c32;
-}
-
-/**
- * efi_puts() - Write a UTF-8 encoded string to the console
- * @str:	UTF-8 encoded string
- */
-void efi_puts(const char *str)
-{
-	efi_char16_t buf[128];
-	size_t pos = 0, lim = ARRAY_SIZE(buf);
-	const u8 *s8 = (const u8 *)str;
-	u32 c32;
-
-	while (*s8) {
-		if (*s8 == '\n')
-			buf[pos++] = L'\r';
-		c32 = utf8_to_utf32(&s8);
-		if (c32 < 0x10000) {
-			/* Characters in plane 0 use a single word. */
-			buf[pos++] = c32;
-		} else {
-			/*
-			 * Characters in other planes encode into a surrogate
-			 * pair.
-			 */
-			buf[pos++] = (0xd800 - (0x10000 >> 10)) + (c32 >> 10);
-			buf[pos++] = 0xdc00 + (c32 & 0x3ff);
-		}
-		if (*s8 == '\0' || pos >= lim - 2) {
-			buf[pos] = L'\0';
-			efi_char16_puts(buf);
-			pos = 0;
-		}
-	}
-}
-
-/**
- * efi_printk() - Print a kernel message
- * @fmt:	format string
- *
- * The first letter of the format string is used to determine the logging level
- * of the message. If the level is less then the current EFI logging level, the
- * message is suppressed. The message will be truncated to 255 bytes.
- *
- * Return:	number of printed characters
- */
-int efi_printk(const char *fmt, ...)
-{
-	char printf_buf[256];
-	va_list args;
-	int printed;
-	int loglevel = printk_get_level(fmt);
-
-	switch (loglevel) {
-	case '0' ... '9':
-		loglevel -= '0';
-		break;
-	default:
-		/*
-		 * Use loglevel -1 for cases where we just want to print to
-		 * the screen.
-		 */
-		loglevel = -1;
-		break;
-	}
-
-	if (loglevel >= efi_loglevel)
-		return 0;
-
-	if (loglevel >= 0)
-		efi_puts("EFI stub: ");
-
-	fmt = printk_skip_level(fmt);
-
-	va_start(args, fmt);
-	printed = vsnprintf(printf_buf, sizeof(printf_buf), fmt, args);
-	va_end(args);
-
-	efi_puts(printf_buf);
-	if (printed >= sizeof(printf_buf)) {
-		efi_puts("[Message truncated]\n");
-		return -1;
-	}
-
-	return printed;
-}
-
 /**
  * efi_parse_options() - Parse EFI command line options
  * @cmdline:	kernel command line
diff --git a/drivers/firmware/efi/libstub/printk.c b/drivers/firmware/efi/libstub/printk.c
new file mode 100644
index 000000000000..3a67a2cea7bd
--- /dev/null
+++ b/drivers/firmware/efi/libstub/printk.c
@@ -0,0 +1,154 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/stdarg.h>
+
+#include <linux/ctype.h>
+#include <linux/efi.h>
+#include <linux/kernel.h>
+#include <linux/printk.h> /* For CONSOLE_LOGLEVEL_* */
+#include <asm/efi.h>
+#include <asm/setup.h>
+
+#include "efistub.h"
+
+int efi_loglevel = CONSOLE_LOGLEVEL_DEFAULT;
+
+/**
+ * efi_char16_puts() - Write a UCS-2 encoded string to the console
+ * @str:	UCS-2 encoded string
+ */
+void efi_char16_puts(efi_char16_t *str)
+{
+	efi_call_proto(efi_table_attr(efi_system_table, con_out),
+		       output_string, str);
+}
+
+static
+u32 utf8_to_utf32(const u8 **s8)
+{
+	u32 c32;
+	u8 c0, cx;
+	size_t clen, i;
+
+	c0 = cx = *(*s8)++;
+	/*
+	 * The position of the most-significant 0 bit gives us the length of
+	 * a multi-octet encoding.
+	 */
+	for (clen = 0; cx & 0x80; ++clen)
+		cx <<= 1;
+	/*
+	 * If the 0 bit is in position 8, this is a valid single-octet
+	 * encoding. If the 0 bit is in position 7 or positions 1-3, the
+	 * encoding is invalid.
+	 * In either case, we just return the first octet.
+	 */
+	if (clen < 2 || clen > 4)
+		return c0;
+	/* Get the bits from the first octet. */
+	c32 = cx >> clen--;
+	for (i = 0; i < clen; ++i) {
+		/* Trailing octets must have 10 in most significant bits. */
+		cx = (*s8)[i] ^ 0x80;
+		if (cx & 0xc0)
+			return c0;
+		c32 = (c32 << 6) | cx;
+	}
+	/*
+	 * Check for validity:
+	 * - The character must be in the Unicode range.
+	 * - It must not be a surrogate.
+	 * - It must be encoded using the correct number of octets.
+	 */
+	if (c32 > 0x10ffff ||
+	    (c32 & 0xf800) == 0xd800 ||
+	    clen != (c32 >= 0x80) + (c32 >= 0x800) + (c32 >= 0x10000))
+		return c0;
+	*s8 += clen;
+	return c32;
+}
+
+/**
+ * efi_puts() - Write a UTF-8 encoded string to the console
+ * @str:	UTF-8 encoded string
+ */
+void efi_puts(const char *str)
+{
+	efi_char16_t buf[128];
+	size_t pos = 0, lim = ARRAY_SIZE(buf);
+	const u8 *s8 = (const u8 *)str;
+	u32 c32;
+
+	while (*s8) {
+		if (*s8 == '\n')
+			buf[pos++] = L'\r';
+		c32 = utf8_to_utf32(&s8);
+		if (c32 < 0x10000) {
+			/* Characters in plane 0 use a single word. */
+			buf[pos++] = c32;
+		} else {
+			/*
+			 * Characters in other planes encode into a surrogate
+			 * pair.
+			 */
+			buf[pos++] = (0xd800 - (0x10000 >> 10)) + (c32 >> 10);
+			buf[pos++] = 0xdc00 + (c32 & 0x3ff);
+		}
+		if (*s8 == '\0' || pos >= lim - 2) {
+			buf[pos] = L'\0';
+			efi_char16_puts(buf);
+			pos = 0;
+		}
+	}
+}
+
+/**
+ * efi_printk() - Print a kernel message
+ * @fmt:	format string
+ *
+ * The first letter of the format string is used to determine the logging level
+ * of the message. If the level is less then the current EFI logging level, the
+ * message is suppressed. The message will be truncated to 255 bytes.
+ *
+ * Return:	number of printed characters
+ */
+int efi_printk(const char *fmt, ...)
+{
+	char printf_buf[256];
+	va_list args;
+	int printed;
+	int loglevel = printk_get_level(fmt);
+
+	switch (loglevel) {
+	case '0' ... '9':
+		loglevel -= '0';
+		break;
+	default:
+		/*
+		 * Use loglevel -1 for cases where we just want to print to
+		 * the screen.
+		 */
+		loglevel = -1;
+		break;
+	}
+
+	if (loglevel >= efi_loglevel)
+		return 0;
+
+	if (loglevel >= 0)
+		efi_puts("EFI stub: ");
+
+	fmt = printk_skip_level(fmt);
+
+	va_start(args, fmt);
+	printed = vsnprintf(printf_buf, sizeof(printf_buf), fmt, args);
+	va_end(args);
+
+	efi_puts(printf_buf);
+	if (printed >= sizeof(printf_buf)) {
+		efi_puts("[Message truncated]\n");
+		return -1;
+	}
+
+	return printed;
+}
diff --git a/drivers/firmware/efi/libstub/string.c b/drivers/firmware/efi/libstub/string.c
index 9f5810d86646..5a1519d435bf 100644
--- a/drivers/firmware/efi/libstub/string.c
+++ b/drivers/firmware/efi/libstub/string.c
@@ -11,7 +11,37 @@
 #include <linux/types.h>
 #include <linux/string.h>
 
-#ifndef __HAVE_ARCH_STRSTR
+#ifndef EFI_HAVE_STRLEN
+/**
+ * strlen - Find the length of a string
+ * @s: The string to be sized
+ */
+size_t strlen(const char *s)
+{
+	const char *sc;
+
+	for (sc = s; *sc != '\0'; ++sc)
+		/* nothing */;
+	return sc - s;
+}
+#endif
+
+#ifndef EFI_HAVE_STRNLEN
+/**
+ * strnlen - Find the length of a length-limited string
+ * @s: The string to be sized
+ * @count: The maximum number of bytes to search
+ */
+size_t strnlen(const char *s, size_t count)
+{
+	const char *sc;
+
+	for (sc = s; count-- && *sc != '\0'; ++sc)
+		/* nothing */;
+	return sc - s;
+}
+#endif
+
 /**
  * strstr - Find the first substring in a %NUL terminated string
  * @s1: The string to be searched
@@ -33,7 +63,6 @@ char *strstr(const char *s1, const char *s2)
 	}
 	return NULL;
 }
-#endif
 
 /**
  * strncmp - Compare two length-limited strings
diff --git a/drivers/firmware/efi/libstub/zboot.c b/drivers/firmware/efi/libstub/zboot.c
index 38173ec29cd5..5f41a5b17d6e 100644
--- a/drivers/firmware/efi/libstub/zboot.c
+++ b/drivers/firmware/efi/libstub/zboot.c
@@ -32,19 +32,9 @@ static unsigned long free_mem_ptr, free_mem_end_ptr;
 extern char efi_zboot_header[];
 extern char _gzdata_start[], _gzdata_end[];
 
-static void log(efi_char16_t str[])
-{
-	efi_call_proto(efi_table_attr(efi_system_table, con_out),
-		       output_string, L"EFI decompressor: ");
-	efi_call_proto(efi_table_attr(efi_system_table, con_out),
-		       output_string, str);
-	efi_call_proto(efi_table_attr(efi_system_table, con_out),
-		       output_string, L"\n");
-}
-
 static void error(char *x)
 {
-	log(L"error() called from decompressor library\n");
+	efi_err("EFI decompressor: %s\n", x);
 }
 
 static efi_status_t __efiapi
@@ -91,7 +81,7 @@ load_file(efi_load_file_protocol_t *this, efi_device_path_protocol_t *rem,
 		ret = __decompress(_gzdata_start, compressed_size, NULL, NULL,
 				   buffer, size, NULL, error);
 		if (ret	< 0) {
-			log(L"Decompression failed");
+			error("Decompression failed");
 			return EFI_DEVICE_ERROR;
 		}
 	} else {
@@ -180,7 +170,7 @@ efi_zboot_entry(efi_handle_t handle, efi_system_table_t *systab)
 	status = efi_bs_call(handle_protocol, handle,
 			     &LOADED_IMAGE_PROTOCOL_GUID, (void **)&parent);
 	if (status != EFI_SUCCESS) {
-		log(L"Failed to locate parent's loaded image protocol");
+		error("Failed to locate parent's loaded image protocol");
 		return status;
 	}
 
@@ -207,7 +197,7 @@ efi_zboot_entry(efi_handle_t handle, efi_system_table_t *systab)
 			     sizeof(struct efi_vendor_dev_path),
 			     (void **)&dp_alloc);
 	if (status != EFI_SUCCESS) {
-		log(L"Failed to allocate device path pool memory");
+		error("Failed to allocate device path pool memory");
 		return status;
 	}
 
@@ -236,21 +226,21 @@ efi_zboot_entry(efi_handle_t handle, efi_system_table_t *systab)
 			     &EFI_LOAD_FILE2_PROTOCOL_GUID, &zboot_load_file2,
 			     NULL);
 	if (status != EFI_SUCCESS) {
-		log(L"Failed to install LoadFile2 protocol and device path");
+		error("Failed to install LoadFile2 protocol and device path");
 		goto free_dpalloc;
 	}
 
 	status = efi_bs_call(load_image, false, handle, li_dp, NULL, 0,
 			     &child_handle);
 	if (status != EFI_SUCCESS) {
-		log(L"Failed to load image");
+		error("Failed to load image");
 		goto uninstall_lf2;
 	}
 
 	status = efi_bs_call(handle_protocol, child_handle,
 			     &LOADED_IMAGE_PROTOCOL_GUID, (void **)&child);
 	if (status != EFI_SUCCESS) {
-		log(L"Failed to locate child's loaded image protocol");
+		error("Failed to locate child's loaded image protocol");
 		goto unload_image;
 	}
 
@@ -261,9 +251,9 @@ efi_zboot_entry(efi_handle_t handle, efi_system_table_t *systab)
 	status = efi_bs_call(start_image, child_handle, &exit_data_size,
 			     &exit_data);
 	if (status != EFI_SUCCESS) {
-		log(L"StartImage() returned with error");
+		error("StartImage() returned with error:");
 		if (exit_data_size > 0)
-			log(exit_data);
+			efi_err("%ls\n", exit_data);
 
 		// If StartImage() returns EFI_SECURITY_VIOLATION, the image is
 		// not unloaded so we need to do it by hand.
@@ -286,7 +276,7 @@ efi_zboot_entry(efi_handle_t handle, efi_system_table_t *systab)
 
 	// Free ExitData in case Exit() returned with a failure code,
 	// but return the original status code.
-	log(L"Exit() returned with failure code");
+	error("Exit() returned with failure code");
 	if (exit_data != NULL)
 		efi_bs_call(free_pool, exit_data);
 	return status;
-- 
2.35.1

