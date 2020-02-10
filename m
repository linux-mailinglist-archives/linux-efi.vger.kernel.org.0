Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B48AF157F68
	for <lists+linux-efi@lfdr.de>; Mon, 10 Feb 2020 17:03:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727818AbgBJQD2 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 10 Feb 2020 11:03:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:52936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727800AbgBJQD2 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 10 Feb 2020 11:03:28 -0500
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C249124682;
        Mon, 10 Feb 2020 16:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581350607;
        bh=UbCcj5n4Mbv2U7Aw9CzwFygS+HWXQ/cH8FomEHAeWrg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lfgsBA8Vf9EjFQR6IXEQIul7vNZo8F2jBlSwKiYTrt52rQDveL0DgfUCyVBmWYkn7
         VXgDXZuqONTU6Z18e4adtRbsL+sx+RvYlBzd+ZaT5txJWaJuUoCtE5zgQpivX9+wDe
         2pzkWU1hk9jDo/PeySGH2+dS7cf9Vx0cqvJ3WFIY=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>, nivedita@alum.mit.edu,
        mingo@kernel.org, lukas@wunner.de, atish.patra@wdc.com
Subject: [PATCH 17/19] efi/libstub: Clean up command line parsing routine
Date:   Mon, 10 Feb 2020 17:02:46 +0100
Message-Id: <20200210160248.4889-18-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200210160248.4889-1-ardb@kernel.org>
References: <20200210160248.4889-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

We currently parse the command non-destructively, to avoid having to
allocate memory for a copy before passing it to the standard parsing
routines that are used by the core kernel, and which modify the input
to delineate the parsed tokens with NUL characters.

Instead, we call strstr() and strncmp() to go over the input multiple
times, and match prefixes rather than tokens, which implies that we
would match, e.g., 'nokaslrfoo' in the stub and disable KASLR, while
the kernel would disregard the option and run with KASLR enabled.

In order to avoid having to reason about whether and how this behavior
may be abused, let's clean up the parsing routines, and rebuild them
on top of the existing helpers.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/Makefile          |  3 +-
 drivers/firmware/efi/libstub/efi-stub-helper.c | 79 +++++++-------------
 drivers/firmware/efi/libstub/string.c          | 63 ++++++++++++++++
 3 files changed, 91 insertions(+), 54 deletions(-)

diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index 74a097ef1780..82cb9f9c08ce 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -39,7 +39,8 @@ OBJECT_FILES_NON_STANDARD	:= y
 KCOV_INSTRUMENT			:= n
 
 lib-y				:= efi-stub-helper.o gop.o secureboot.o tpm.o \
-				   file.o mem.o random.o randomalloc.o pci.o
+				   file.o mem.o random.o randomalloc.o pci.o \
+				   lib-cmdline.o lib-ctype.o
 
 # include the stub's generic dependencies from lib/ when building for ARM/arm64
 arm-deps-y := fdt_rw.c fdt_ro.c fdt_wip.c fdt.c fdt_empty_tree.c fdt_sw.c
diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index db23be5dc69b..b3621ceb3480 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -68,66 +68,39 @@ void efi_printk(char *str)
  */
 efi_status_t efi_parse_options(char const *cmdline)
 {
-	char *str;
-
-	str = strstr(cmdline, "nokaslr");
-	if (str == cmdline || (str && str > cmdline && *(str - 1) == ' '))
-		efi_nokaslr = true;
-
-	str = strstr(cmdline, "quiet");
-	if (str == cmdline || (str && str > cmdline && *(str - 1) == ' '))
-		efi_quiet = true;
-
-	/*
-	 * If no EFI parameters were specified on the cmdline we've got
-	 * nothing to do.
-	 */
-	str = strstr(cmdline, "efi=");
-	if (!str)
-		return EFI_SUCCESS;
-
-	/* Skip ahead to first argument */
-	str += strlen("efi=");
-
-	/*
-	 * Remember, because efi= is also used by the kernel we need to
-	 * skip over arguments we don't understand.
-	 */
-	while (*str && *str != ' ') {
-		if (!strncmp(str, "nochunk", 7)) {
-			str += strlen("nochunk");
-			efi_nochunk = true;
-		}
+	size_t len = strlen(cmdline);
+	efi_status_t status;
+	char *str, *buf;
 
-		if (!strncmp(str, "novamap", 7)) {
-			str += strlen("novamap");
-			efi_novamap = true;
-		}
+	status = efi_bs_call(allocate_pool, EFI_LOADER_DATA, len, (void **)&buf);
+	if (status != EFI_SUCCESS)
+		return status;
 
-		if (IS_ENABLED(CONFIG_EFI_SOFT_RESERVE) &&
-		    !strncmp(str, "nosoftreserve", 7)) {
-			str += strlen("nosoftreserve");
-			efi_nosoftreserve = true;
-		}
+	str = skip_spaces(memcpy(buf, cmdline, len + 1));
 
-		if (!strncmp(str, "disable_early_pci_dma", 21)) {
-			str += strlen("disable_early_pci_dma");
-			efi_disable_pci_dma = true;
-		}
+	while (*str) {
+		char *param, *val;
 
-		if (!strncmp(str, "no_disable_early_pci_dma", 24)) {
-			str += strlen("no_disable_early_pci_dma");
-			efi_disable_pci_dma = false;
-		}
+		str = next_arg(str, &param, &val);
 
-		/* Group words together, delimited by "," */
-		while (*str && *str != ' ' && *str != ',')
-			str++;
+		if (!strcmp(param, "nokaslr")) {
+			efi_nokaslr = true;
+		} else if (!strcmp(param, "quiet")) {
+			efi_quiet = true;
+		} else if (!strcmp(param, "efi") && val) {
+			efi_nochunk = parse_option_str(val, "nochunk");
+			efi_novamap = parse_option_str(val, "novamap");
 
-		if (*str == ',')
-			str++;
-	}
+			efi_nosoftreserve = IS_ENABLED(CONFIG_EFI_SOFT_RESERVE) &&
+					    parse_option_str(val, "nosoftreserve");
 
+			if (parse_option_str(val, "disable_early_pci_dma"))
+				efi_disable_pci_dma = true;
+			if (parse_option_str(val, "no_disable_early_pci_dma"))
+				efi_disable_pci_dma = false;
+		}
+	}
+	efi_bs_call(free_pool, buf);
 	return EFI_SUCCESS;
 }
 
diff --git a/drivers/firmware/efi/libstub/string.c b/drivers/firmware/efi/libstub/string.c
index ed10e3f602c5..33dfb83be239 100644
--- a/drivers/firmware/efi/libstub/string.c
+++ b/drivers/firmware/efi/libstub/string.c
@@ -6,6 +6,7 @@
  *  Copyright (C) 1991, 1992  Linus Torvalds
  */
 
+#include <linux/ctype.h>
 #include <linux/types.h>
 #include <linux/string.h>
 
@@ -56,3 +57,65 @@ int strncmp(const char *cs, const char *ct, size_t count)
 	return 0;
 }
 #endif
+
+char *skip_spaces(const char *str)
+{
+	while (isspace(*str))
+		++str;
+	return (char *)str;
+}
+
+/* Works only for digits and letters, but small and fast */
+#define TOLOWER(x) ((x) | 0x20)
+
+static unsigned int simple_guess_base(const char *cp)
+{
+	if (cp[0] == '0') {
+		if (TOLOWER(cp[1]) == 'x' && isxdigit(cp[2]))
+			return 16;
+		else
+			return 8;
+	} else {
+		return 10;
+	}
+}
+
+/**
+ * simple_strtoull - convert a string to an unsigned long long
+ * @cp: The start of the string
+ * @endp: A pointer to the end of the parsed string will be placed here
+ * @base: The number base to use
+ */
+
+unsigned long long simple_strtoull(const char *cp, char **endp, unsigned int base)
+{
+	unsigned long long result = 0;
+
+	if (!base)
+		base = simple_guess_base(cp);
+
+	if (base == 16 && cp[0] == '0' && TOLOWER(cp[1]) == 'x')
+		cp += 2;
+
+	while (isxdigit(*cp)) {
+		unsigned int value;
+
+		value = isdigit(*cp) ? *cp - '0' : TOLOWER(*cp) - 'a' + 10;
+		if (value >= base)
+			break;
+		result = result * base + value;
+		cp++;
+	}
+	if (endp)
+		*endp = (char *)cp;
+
+	return result;
+}
+
+long simple_strtol(const char *cp, char **endp, unsigned int base)
+{
+	if (*cp == '-')
+		return -simple_strtoull(cp + 1, endp, base);
+
+	return simple_strtoull(cp, endp, base);
+}
-- 
2.17.1

