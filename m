Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C91841D87DC
	for <lists+linux-efi@lfdr.de>; Mon, 18 May 2020 21:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbgERTHZ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 18 May 2020 15:07:25 -0400
Received: from mail-qv1-f66.google.com ([209.85.219.66]:33299 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726504AbgERTHY (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 18 May 2020 15:07:24 -0400
Received: by mail-qv1-f66.google.com with SMTP id er16so4753078qvb.0
        for <linux-efi@vger.kernel.org>; Mon, 18 May 2020 12:07:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OdWv53aOsYn+9JIlJue3CzOaq+P0SlK+EOPe4XlEZJk=;
        b=XvjgHX+dnj54vP0fr8B2Nj4HVHf4IRcNDp7qnTWf0C6M6mwDcW8H29B/frCdEboR2l
         kB6FT1+SCLDcQKgtMkfRcN/ShLf0UHVsGypK+m4jtookspnuOYg5picUa/2AfLDJkC0z
         Yvqt9PK9Sf/iqNauBSD6RSnhkHnEaCdCF+RX8hqGcFtu3Z7YWcxZOkVxVGwlNN77cuoi
         1IBXLwEMhoxP3/17kngCswnUQCXSXf2eJzjEH1D66wimSvNSgaQ50JnN0aHqxvVXXlGJ
         qak/Go2TKgnEIbJ1qYjftI+Zr/+KsJ+7RT9rC/Z0bhL54AHx+UmUWsrsmZc5DSr8f6DG
         8F2Q==
X-Gm-Message-State: AOAM530beD0vOa4MKSXYjxwtO6tYznL4uscdZWX3UIUDbo9nMopVzFnT
        1ZmFDZcSgzimCrJGMjDOkfbdGgbVAGc=
X-Google-Smtp-Source: ABdhPJwX8V8zFA6rI6A+8FLi6f2vqw0B/TJFA3lIja4dkhIKNmi/8IghPoMSW14rMkMfh4gaxGd3CQ==
X-Received: by 2002:a0c:c342:: with SMTP id j2mr17104208qvi.209.1589828842984;
        Mon, 18 May 2020 12:07:22 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id a1sm9862811qtj.65.2020.05.18.12.07.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 12:07:22 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [PATCH 07/24] efi/printf: Add 64-bit and 8-bit integer support
Date:   Mon, 18 May 2020 15:06:59 -0400
Message-Id: <20200518190716.751506-8-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200518190716.751506-1-nivedita@alum.mit.edu>
References: <20200518190716.751506-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Support 'll' qualifier for long long by copying the decimal printing
code from lib/vsprintf.c. For simplicity, the 32-bit code is used on
64-bit architectures as well.

Support 'hh' qualifier for signed/unsigned char type integers.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 drivers/firmware/efi/libstub/vsprintf.c | 172 ++++++++++++++++++++----
 1 file changed, 144 insertions(+), 28 deletions(-)

diff --git a/drivers/firmware/efi/libstub/vsprintf.c b/drivers/firmware/efi/libstub/vsprintf.c
index 2815196de40b..20fc2530f805 100644
--- a/drivers/firmware/efi/libstub/vsprintf.c
+++ b/drivers/firmware/efi/libstub/vsprintf.c
@@ -7,10 +7,7 @@
  * ----------------------------------------------------------------------- */
 
 /*
- * Oh, it's a waste of space, but oh-so-yummy for debugging.  This
- * version of printf() does not include 64-bit support.  "Live with
- * it."
- *
+ * Oh, it's a waste of space, but oh-so-yummy for debugging.
  */
 
 #include <stdarg.h>
@@ -28,6 +25,86 @@ static int skip_atoi(const char **s)
 	return i;
 }
 
+/*
+ * put_dec_full4 handles numbers in the range 0 <= r < 10000.
+ * The multiplier 0xccd is round(2^15/10), and the approximation
+ * r/10 == (r * 0xccd) >> 15 is exact for all r < 16389.
+ */
+static
+void put_dec_full4(char *buf, unsigned int r)
+{
+	int i;
+
+	for (i = 0; i < 3; i++) {
+		unsigned int q = (r * 0xccd) >> 15;
+		*buf++ = '0' + (r - q * 10);
+		r = q;
+	}
+	*buf++ = '0' + r;
+}
+
+/* put_dec is copied from lib/vsprintf.c with small modifications */
+
+/*
+ * Call put_dec_full4 on x % 10000, return x / 10000.
+ * The approximation x/10000 == (x * 0x346DC5D7) >> 43
+ * holds for all x < 1,128,869,999.  The largest value this
+ * helper will ever be asked to convert is 1,125,520,955.
+ * (second call in the put_dec code, assuming n is all-ones).
+ */
+static
+unsigned int put_dec_helper4(char *buf, unsigned int x)
+{
+	unsigned int q = (x * 0x346DC5D7ULL) >> 43;
+
+	put_dec_full4(buf, x - q * 10000);
+	return q;
+}
+
+/* Based on code by Douglas W. Jones found at
+ * <http://www.cs.uiowa.edu/~jones/bcd/decimal.html#sixtyfour>
+ * (with permission from the author).
+ * Performs no 64-bit division and hence should be fast on 32-bit machines.
+ */
+static
+int put_dec(char *buf, unsigned long long n)
+{
+	unsigned int d3, d2, d1, q, h;
+	char *p = buf;
+
+	d1  = ((unsigned int)n >> 16); /* implicit "& 0xffff" */
+	h   = (n >> 32);
+	d2  = (h      ) & 0xffff;
+	d3  = (h >> 16); /* implicit "& 0xffff" */
+
+	/* n = 2^48 d3 + 2^32 d2 + 2^16 d1 + d0
+	     = 281_4749_7671_0656 d3 + 42_9496_7296 d2 + 6_5536 d1 + d0 */
+	q = 656 * d3 + 7296 * d2 + 5536 * d1 + ((unsigned int)n & 0xffff);
+	q = put_dec_helper4(p, q);
+	p += 4;
+
+	q += 7671 * d3 + 9496 * d2 + 6 * d1;
+	q = put_dec_helper4(p, q);
+	p += 4;
+
+	q += 4749 * d3 + 42 * d2;
+	q = put_dec_helper4(p, q);
+	p += 4;
+
+	q += 281 * d3;
+	q = put_dec_helper4(p, q);
+	p += 4;
+
+	put_dec_full4(p, q);
+	p += 4;
+
+	/* strip off the extra 0's we printed */
+	while (p > buf && p[-1] == '0')
+		--p;
+
+	return p - buf;
+}
+
 #define ZEROPAD	1		/* pad with zero */
 #define SIGN	2		/* unsigned/signed long */
 #define PLUS	4		/* show plus */
@@ -36,13 +113,7 @@ static int skip_atoi(const char **s)
 #define SMALL	32		/* Must be 32 == 0x20 */
 #define SPECIAL	64		/* 0x */
 
-#define __do_div(n, base) ({ \
-int __res; \
-__res = ((unsigned long) n) % (unsigned) base; \
-n = ((unsigned long) n) / (unsigned) base; \
-__res; })
-
-static char *number(char *str, long num, int base, int size, int precision,
+static char *number(char *str, long long num, int base, int size, int precision,
 		    int type)
 {
 	/* we are called with base 8, 10 or 16, only, thus don't need "G..."  */
@@ -57,8 +128,6 @@ static char *number(char *str, long num, int base, int size, int precision,
 	locase = (type & SMALL);
 	if (type & LEFT)
 		type &= ~ZEROPAD;
-	if (base < 2 || base > 16)
-		return NULL;
 	c = (type & ZEROPAD) ? '0' : ' ';
 	sign = 0;
 	if (type & SIGN) {
@@ -83,9 +152,27 @@ static char *number(char *str, long num, int base, int size, int precision,
 	i = 0;
 	if (num == 0)
 		tmp[i++] = '0';
-	else
-		while (num != 0)
-			tmp[i++] = (digits[__do_div(num, base)] | locase);
+	else switch (base) {
+		case 10:
+			i += put_dec(&tmp[i], num);
+			break;
+		case 8:
+			while (num != 0) {
+				tmp[i++] = '0' + (num & 07);
+				num = (unsigned long long)num >> 3;
+			}
+			break;
+		case 16:
+			while (num != 0) {
+				tmp[i++] = digits[num & 0xf] | locase;
+				num = (unsigned long long)num >> 4;
+			}
+			break;
+
+		default:
+			unreachable();
+	}
+
 	if (i > precision)
 		precision = i;
 	size -= precision;
@@ -117,7 +204,7 @@ static char *number(char *str, long num, int base, int size, int precision,
 int vsprintf(char *buf, const char *fmt, va_list args)
 {
 	int len;
-	unsigned long num;
+	unsigned long long num;
 	int i, base;
 	char *str;
 	const char *s;
@@ -127,7 +214,7 @@ int vsprintf(char *buf, const char *fmt, va_list args)
 	int field_width;	/* width of output field */
 	int precision;		/* min. # of digits for integers; max
 				   number of chars for from string */
-	int qualifier;		/* 'h' or 'l' for integer fields */
+	int qualifier;		/* 'h', 'hh', 'l' or 'll' for integer fields */
 
 	for (str = buf; *fmt; ++fmt) {
 		if (*fmt != '%') {
@@ -191,6 +278,10 @@ int vsprintf(char *buf, const char *fmt, va_list args)
 		if (*fmt == 'h' || *fmt == 'l') {
 			qualifier = *fmt;
 			++fmt;
+			if (qualifier == *fmt) {
+				qualifier -= 'a'-'A';
+				++fmt;
+			}
 		}
 
 		/* default base */
@@ -260,16 +351,41 @@ int vsprintf(char *buf, const char *fmt, va_list args)
 				--fmt;
 			continue;
 		}
-		if (qualifier == 'l')
-			num = va_arg(args, unsigned long);
-		else if (qualifier == 'h') {
-			num = (unsigned short)va_arg(args, int);
-			if (flags & SIGN)
-				num = (short)num;
-		} else if (flags & SIGN)
-			num = va_arg(args, int);
-		else
-			num = va_arg(args, unsigned int);
+		if (flags & SIGN) {
+			switch (qualifier) {
+			case 'L':
+				num = va_arg(args, long long);
+				break;
+			case 'l':
+				num = va_arg(args, long);
+				break;
+			case 'h':
+				num = (short)va_arg(args, int);
+				break;
+			case 'H':
+				num = (signed char)va_arg(args, int);
+				break;
+			default:
+				num = va_arg(args, int);
+			}
+		} else {
+			switch (qualifier) {
+			case 'L':
+				num = va_arg(args, unsigned long long);
+				break;
+			case 'l':
+				num = va_arg(args, unsigned long);
+				break;
+			case 'h':
+				num = (unsigned short)va_arg(args, int);
+				break;
+			case 'H':
+				num = (unsigned char)va_arg(args, int);
+				break;
+			default:
+				num = va_arg(args, unsigned int);
+			}
+		}
 		str = number(str, num, base, field_width, precision, flags);
 	}
 	*str = '\0';
-- 
2.26.2

