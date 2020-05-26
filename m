Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C19A1D87D7
	for <lists+linux-efi@lfdr.de>; Mon, 18 May 2020 21:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbgERTHY (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 18 May 2020 15:07:24 -0400
Received: from mail-qv1-f45.google.com ([209.85.219.45]:45962 "EHLO
        mail-qv1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726378AbgERTHX (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 18 May 2020 15:07:23 -0400
Received: by mail-qv1-f45.google.com with SMTP id z9so5255341qvi.12
        for <linux-efi@vger.kernel.org>; Mon, 18 May 2020 12:07:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NOMON+Ljq6WVzv+1Sx0wYZZOIIW4Y0cgjLbZcHGXUB0=;
        b=lwpNqo5P+aivwW4Df6w31q4+jL7QndditAOeDop6biUSiofyXdotK6Ktr9G7chX/et
         gjHJVHcklfBuGBmNiDCFV3Y0wFhj7Bw+CH22dD6TCEwY2+ofUPeFv4+PC/Vvm//zbarF
         +M2a92LXf2wWaVk/aMEffwg5xd3uOq7ticyOzmubMEe6hDRuz0Hmw9WIGLYJ5h3Z52Sv
         t7oN079tESInUlOo/VTCSNAoPhWTILIdPbEQjHTx2pJf+oBcRxaD7X7fyNsFK1d1XWcf
         efQLYulKPsObWOcDBSgZUo2Cm5W0M548P5pNDBxTAp8Fd3Kit3/OHfjWaJtnk197NVHF
         f7wg==
X-Gm-Message-State: AOAM531T2BODbClDDu3sAOwIcVBoBs8Vg5pJMbBk6vFKyvfKC/uTzts8
        QZDNhfMadC2jln/vqNXWAlsquqcXPh0=
X-Google-Smtp-Source: ABdhPJx1uqbEv9xQkSpBCm7vVB7ZtlptsrtnhwHoCQC8MnndnixSpKCD2aZ9hpApsEYucIGcR5CSUw==
X-Received: by 2002:ad4:404b:: with SMTP id r11mr15607393qvp.44.1589828840725;
        Mon, 18 May 2020 12:07:20 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id a1sm9862811qtj.65.2020.05.18.12.07.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 12:07:20 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [PATCH 04/24] efi/libstub: Add a basic printf implementation
Date:   Mon, 18 May 2020 15:06:56 -0400
Message-Id: <20200518190716.751506-5-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200518190716.751506-1-nivedita@alum.mit.edu>
References: <20200518190716.751506-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Copy vsprintf from arch/x86/boot/printf.c to get a simple printf
implementation.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 drivers/firmware/efi/libstub/Makefile         |   2 +-
 .../firmware/efi/libstub/efi-stub-helper.c    |  17 +
 drivers/firmware/efi/libstub/efistub.h        |   3 +
 drivers/firmware/efi/libstub/vsprintf.c       | 298 ++++++++++++++++++
 4 files changed, 319 insertions(+), 1 deletion(-)
 create mode 100644 drivers/firmware/efi/libstub/vsprintf.c

diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index e5a49dc8e9bc..fb34c9d14a3c 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -44,7 +44,7 @@ KCOV_INSTRUMENT			:= n
 lib-y				:= efi-stub-helper.o gop.o secureboot.o tpm.o \
 				   file.o mem.o random.o randomalloc.o pci.o \
 				   skip_spaces.o lib-cmdline.o lib-ctype.o \
-				   alignedmem.o relocate.o
+				   alignedmem.o relocate.o vsprintf.o
 
 # include the stub's generic dependencies from lib/ when building for ARM/arm64
 efi-deps-y := fdt_rw.c fdt_ro.c fdt_wip.c fdt.c fdt_empty_tree.c fdt_sw.c
diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index 3cf506ab9ead..56b3b84fd3bd 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -7,6 +7,8 @@
  * Copyright 2011 Intel Corporation; author Matt Fleming
  */
 
+#include <stdarg.h>
+
 #include <linux/efi.h>
 #include <linux/kernel.h>
 #include <asm/efi.h>
@@ -51,6 +53,21 @@ void efi_puts(const char *str)
 	}
 }
 
+int efi_printk(const char *fmt, ...)
+{
+	char printf_buf[256];
+	va_list args;
+	int printed;
+
+	va_start(args, fmt);
+	printed = vsprintf(printf_buf, fmt, args);
+	va_end(args);
+
+	efi_puts(printf_buf);
+
+	return printed;
+}
+
 /*
  * Parse the ASCII string 'cmdline' for EFI options, denoted by the efi=
  * option, e.g. efi=nochunk.
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index 4f57611a65f2..caa7dcc71c69 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -3,6 +3,7 @@
 #ifndef _DRIVERS_FIRMWARE_EFI_EFISTUB_H
 #define _DRIVERS_FIRMWARE_EFI_EFISTUB_H
 
+#include <linux/compiler.h>
 #include <linux/efi.h>
 #include <linux/kernel.h>
 #include <linux/types.h>
@@ -632,6 +633,8 @@ void *get_efi_config_table(efi_guid_t guid);
 void efi_char16_puts(efi_char16_t *);
 void efi_puts(const char *str);
 
+__printf(1, 2) int efi_printk(char const *fmt, ...);
+
 void efi_free(unsigned long size, unsigned long addr);
 
 char *efi_convert_cmdline(efi_loaded_image_t *image, int *cmd_line_len,
diff --git a/drivers/firmware/efi/libstub/vsprintf.c b/drivers/firmware/efi/libstub/vsprintf.c
new file mode 100644
index 000000000000..88483a49bac4
--- /dev/null
+++ b/drivers/firmware/efi/libstub/vsprintf.c
@@ -0,0 +1,298 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* -*- linux-c -*- ------------------------------------------------------- *
+ *
+ *   Copyright (C) 1991, 1992 Linus Torvalds
+ *   Copyright 2007 rPath, Inc. - All Rights Reserved
+ *
+ * ----------------------------------------------------------------------- */
+
+/*
+ * Oh, it's a waste of space, but oh-so-yummy for debugging.  This
+ * version of printf() does not include 64-bit support.  "Live with
+ * it."
+ *
+ */
+
+#include <stdarg.h>
+
+#include <linux/compiler.h>
+#include <linux/ctype.h>
+#include <linux/string.h>
+
+static int skip_atoi(const char **s)
+{
+	int i = 0;
+
+	while (isdigit(**s))
+		i = i * 10 + *((*s)++) - '0';
+	return i;
+}
+
+#define ZEROPAD	1		/* pad with zero */
+#define SIGN	2		/* unsigned/signed long */
+#define PLUS	4		/* show plus */
+#define SPACE	8		/* space if plus */
+#define LEFT	16		/* left justified */
+#define SMALL	32		/* Must be 32 == 0x20 */
+#define SPECIAL	64		/* 0x */
+
+#define __do_div(n, base) ({ \
+int __res; \
+__res = ((unsigned long) n) % (unsigned) base; \
+n = ((unsigned long) n) / (unsigned) base; \
+__res; })
+
+static char *number(char *str, long num, int base, int size, int precision,
+		    int type)
+{
+	/* we are called with base 8, 10 or 16, only, thus don't need "G..."  */
+	static const char digits[16] = "0123456789ABCDEF"; /* "GHIJKLMNOPQRSTUVWXYZ"; */
+
+	char tmp[66];
+	char c, sign, locase;
+	int i;
+
+	/* locase = 0 or 0x20. ORing digits or letters with 'locase'
+	 * produces same digits or (maybe lowercased) letters */
+	locase = (type & SMALL);
+	if (type & LEFT)
+		type &= ~ZEROPAD;
+	if (base < 2 || base > 16)
+		return NULL;
+	c = (type & ZEROPAD) ? '0' : ' ';
+	sign = 0;
+	if (type & SIGN) {
+		if (num < 0) {
+			sign = '-';
+			num = -num;
+			size--;
+		} else if (type & PLUS) {
+			sign = '+';
+			size--;
+		} else if (type & SPACE) {
+			sign = ' ';
+			size--;
+		}
+	}
+	if (type & SPECIAL) {
+		if (base == 16)
+			size -= 2;
+		else if (base == 8)
+			size--;
+	}
+	i = 0;
+	if (num == 0)
+		tmp[i++] = '0';
+	else
+		while (num != 0)
+			tmp[i++] = (digits[__do_div(num, base)] | locase);
+	if (i > precision)
+		precision = i;
+	size -= precision;
+	if (!(type & (ZEROPAD + LEFT)))
+		while (size-- > 0)
+			*str++ = ' ';
+	if (sign)
+		*str++ = sign;
+	if (type & SPECIAL) {
+		if (base == 8)
+			*str++ = '0';
+		else if (base == 16) {
+			*str++ = '0';
+			*str++ = ('X' | locase);
+		}
+	}
+	if (!(type & LEFT))
+		while (size-- > 0)
+			*str++ = c;
+	while (i < precision--)
+		*str++ = '0';
+	while (i-- > 0)
+		*str++ = tmp[i];
+	while (size-- > 0)
+		*str++ = ' ';
+	return str;
+}
+
+int vsprintf(char *buf, const char *fmt, va_list args)
+{
+	int len;
+	unsigned long num;
+	int i, base;
+	char *str;
+	const char *s;
+
+	int flags;		/* flags to number() */
+
+	int field_width;	/* width of output field */
+	int precision;		/* min. # of digits for integers; max
+				   number of chars for from string */
+	int qualifier;		/* 'h', 'l', or 'L' for integer fields */
+
+	for (str = buf; *fmt; ++fmt) {
+		if (*fmt != '%') {
+			*str++ = *fmt;
+			continue;
+		}
+
+		/* process flags */
+		flags = 0;
+	      repeat:
+		++fmt;		/* this also skips first '%' */
+		switch (*fmt) {
+		case '-':
+			flags |= LEFT;
+			goto repeat;
+		case '+':
+			flags |= PLUS;
+			goto repeat;
+		case ' ':
+			flags |= SPACE;
+			goto repeat;
+		case '#':
+			flags |= SPECIAL;
+			goto repeat;
+		case '0':
+			flags |= ZEROPAD;
+			goto repeat;
+		}
+
+		/* get field width */
+		field_width = -1;
+		if (isdigit(*fmt))
+			field_width = skip_atoi(&fmt);
+		else if (*fmt == '*') {
+			++fmt;
+			/* it's the next argument */
+			field_width = va_arg(args, int);
+			if (field_width < 0) {
+				field_width = -field_width;
+				flags |= LEFT;
+			}
+		}
+
+		/* get the precision */
+		precision = -1;
+		if (*fmt == '.') {
+			++fmt;
+			if (isdigit(*fmt))
+				precision = skip_atoi(&fmt);
+			else if (*fmt == '*') {
+				++fmt;
+				/* it's the next argument */
+				precision = va_arg(args, int);
+			}
+			if (precision < 0)
+				precision = 0;
+		}
+
+		/* get the conversion qualifier */
+		qualifier = -1;
+		if (*fmt == 'h' || *fmt == 'l' || *fmt == 'L') {
+			qualifier = *fmt;
+			++fmt;
+		}
+
+		/* default base */
+		base = 10;
+
+		switch (*fmt) {
+		case 'c':
+			if (!(flags & LEFT))
+				while (--field_width > 0)
+					*str++ = ' ';
+			*str++ = (unsigned char)va_arg(args, int);
+			while (--field_width > 0)
+				*str++ = ' ';
+			continue;
+
+		case 's':
+			s = va_arg(args, char *);
+			len = strnlen(s, precision);
+
+			if (!(flags & LEFT))
+				while (len < field_width--)
+					*str++ = ' ';
+			for (i = 0; i < len; ++i)
+				*str++ = *s++;
+			while (len < field_width--)
+				*str++ = ' ';
+			continue;
+
+		case 'p':
+			if (field_width == -1) {
+				field_width = 2 * sizeof(void *);
+				flags |= ZEROPAD;
+			}
+			str = number(str,
+				     (unsigned long)va_arg(args, void *), 16,
+				     field_width, precision, flags);
+			continue;
+
+		case 'n':
+			if (qualifier == 'l') {
+				long *ip = va_arg(args, long *);
+				*ip = (str - buf);
+			} else {
+				int *ip = va_arg(args, int *);
+				*ip = (str - buf);
+			}
+			continue;
+
+		case '%':
+			*str++ = '%';
+			continue;
+
+			/* integer number formats - set up the flags and "break" */
+		case 'o':
+			base = 8;
+			break;
+
+		case 'x':
+			flags |= SMALL;
+			fallthrough;
+		case 'X':
+			base = 16;
+			break;
+
+		case 'd':
+		case 'i':
+			flags |= SIGN;
+			fallthrough;
+		case 'u':
+			break;
+
+		default:
+			*str++ = '%';
+			if (*fmt)
+				*str++ = *fmt;
+			else
+				--fmt;
+			continue;
+		}
+		if (qualifier == 'l')
+			num = va_arg(args, unsigned long);
+		else if (qualifier == 'h') {
+			num = (unsigned short)va_arg(args, int);
+			if (flags & SIGN)
+				num = (short)num;
+		} else if (flags & SIGN)
+			num = va_arg(args, int);
+		else
+			num = va_arg(args, unsigned int);
+		str = number(str, num, base, field_width, precision, flags);
+	}
+	*str = '\0';
+	return str - buf;
+}
+
+int sprintf(char *buf, const char *fmt, ...)
+{
+	va_list args;
+	int i;
+
+	va_start(args, fmt);
+	i = vsprintf(buf, fmt, args);
+	va_end(args);
+	return i;
+}
-- 
2.26.2

