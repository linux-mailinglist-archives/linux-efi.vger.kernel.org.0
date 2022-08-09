Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D42F358D52D
	for <lists+linux-efi@lfdr.de>; Tue,  9 Aug 2022 10:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236554AbiHIIKy (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 9 Aug 2022 04:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233351AbiHIIKy (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 9 Aug 2022 04:10:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D1A9B7D1
        for <linux-efi@vger.kernel.org>; Tue,  9 Aug 2022 01:10:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 88544612EC
        for <linux-efi@vger.kernel.org>; Tue,  9 Aug 2022 08:10:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12877C43140;
        Tue,  9 Aug 2022 08:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660032652;
        bh=YebYGkVXz0BIYXQ8WMmB082vbKpbUX4LS7xWcvfr/oI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hJLBzjCfsDISxFlHfDgSWbijk5HHggB19Z844zMfMTb+2FBUSJNIUsQJ+v44s+5gN
         LTQWbZ2U+8Be/pIrn9+JCsE1tEFi+/dO1i8uIfwj3Bg/6eoWBGJdasvlf6Jf1zOQLj
         U/0GQTWWTRd11muI15Ky9rp6MHiF+ZCg4okRSDVFhgVyD0lw0iXC3/5iLHTHtCBrN9
         TE4aiphatR8CJvEHItpNvj20V871EEJMI4HGmxWRc5vBrqXo/Zi4S/fI3DWWV4/vLD
         VTD046sRZSY9GdrZVfnoBHWIy//3MxuoIW94G5l5tCE6SNOg9GXlZtW6ZhAjLAvAnS
         7KQSx7LXXTs7w==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     catalin.marinas@arm.com, will@kernel.org,
        Ard Biesheuvel <ardb@kernel.org>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Peter Jones <pjones@redhat.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Atish Patra <atishp@atishpatra.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Lennart Poettering <lennart@poettering.net>
Subject: [PATCH v2 2/6] efi: stub: split off printk() routines
Date:   Tue,  9 Aug 2022 10:09:40 +0200
Message-Id: <20220809080944.1119654-3-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220809080944.1119654-1-ardb@kernel.org>
References: <20220809080944.1119654-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9433; i=ardb@kernel.org; h=from:subject; bh=YebYGkVXz0BIYXQ8WMmB082vbKpbUX4LS7xWcvfr/oI=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBi8hY+Q/OizInYfU1uC10/UXxL3iteMblB3xvhNvoS 1C1j/0+JAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYvIWPgAKCRDDTyI5ktmPJMYFC/ 9BaO3qgevL/xuAZ9AWDOyAO5x2sUoJPVVO6fZeJvPvWajP+afeC3RE61YwOYm7HtWMNBnEJDgLDDfE UTuKtrlFf8o48SsCWopbsFIolVTNtZB6Dk5SCRchn6CAAIPVaw27leLq3m45wXivZUA0baFVzuw/mn zruu/f8HMCSax9QpQE5cVDWbxXBqRG2/N9qX6cwOkCxrXMPUWNMcqR0db2w8XcxmUYFyz/S0us5vRT yq//bEzv5sjmOKcPkCI9/iEctRDX1zBHtrD8S8NHBMp2kQAD7QQOL/sFj5eqNIWhHYFURxw5sxsOWk sa7D9WEIrkcwS9+arShVSD/vYyCcqG5Yt6/oATBlSU1lW3GVjYqhyD3bHtYmWWv5hhZ9QDNjdz6pcg +ELKzJcuQhKIOgjbMVBiF79Jdfn6CLBUcNVPZ5FnOAvVzkKMXiRyr/1sR7hgEa+p7DvuSsRNIS3Fn4 yIk4L6z33k2dP6KovA4i43FfmC0/EbTBWdTpMf9g7FGkE=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

We will be using the libstub static library also to build the EFI zboot
decompressor, which is a separate binary and does not carry all the
dependencies of efi-stub-helper.c, which is where efi_printk() currently
lives.

So split it off into printk.c so we can incorporate it separately.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/Makefile          |   2 +-
 drivers/firmware/efi/libstub/efi-stub-helper.c | 141 -----------------
 drivers/firmware/efi/libstub/printk.c          | 158 ++++++++++++++++++++
 3 files changed, 159 insertions(+), 142 deletions(-)

diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index d0537573501e..475224be08e1 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -55,7 +55,7 @@ KCOV_INSTRUMENT			:= n
 lib-y				:= efi-stub-helper.o gop.o secureboot.o tpm.o \
 				   file.o mem.o random.o randomalloc.o pci.o \
 				   skip_spaces.o lib-cmdline.o lib-ctype.o \
-				   alignedmem.o relocate.o vsprintf.o
+				   alignedmem.o relocate.o vsprintf.o printk.o
 
 # include the stub's generic dependencies from lib/ when building for ARM/arm64
 efi-deps-y := fdt_rw.c fdt_ro.c fdt_wip.c fdt.c fdt_empty_tree.c fdt_sw.c
diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index 3d972061c1b0..45910c834133 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -20,7 +20,6 @@
 
 bool efi_nochunk;
 bool efi_nokaslr = !IS_ENABLED(CONFIG_RANDOMIZE_BASE);
-int efi_loglevel = CONSOLE_LOGLEVEL_DEFAULT;
 bool efi_novamap;
 
 static bool efi_noinitrd;
@@ -32,146 +31,6 @@ bool __pure __efi_soft_reserve_enabled(void)
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
index 000000000000..ec09bf895c1a
--- /dev/null
+++ b/drivers/firmware/efi/libstub/printk.c
@@ -0,0 +1,158 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Helper functions used by the EFI stub on multiple
+ * architectures. This should be #included by the EFI stub
+ * implementation files.
+ *
+ * Copyright 2011 Intel Corporation; author Matt Fleming
+ */
+
+#include <linux/ctype.h>
+#include <linux/efi.h>
+#include <linux/kernel.h>
+#include <linux/printk.h> /* For CONSOLE_LOGLEVEL_* */
+#include <asm/efi.h>
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
-- 
2.35.1

