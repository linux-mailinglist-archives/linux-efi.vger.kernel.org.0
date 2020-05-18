Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76D3C1D87E4
	for <lists+linux-efi@lfdr.de>; Mon, 18 May 2020 21:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbgERTHc (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 18 May 2020 15:07:32 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:33917 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbgERTHb (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 18 May 2020 15:07:31 -0400
Received: by mail-qk1-f194.google.com with SMTP id 190so11494936qki.1
        for <linux-efi@vger.kernel.org>; Mon, 18 May 2020 12:07:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oK/JS8JFefZGjFuuEOCa4qvugMfmPh8fl1DUkLqdGmA=;
        b=Pz+0kvYtHegdt5T9aj6BAok5XVxy03LRKpVILpWaXziWSA2mZPvfapEfgpjjL2GAgD
         ClSUBZmOYBHdekXd2HfnoZe9CnZUtUTZpMsctjGdlr0yAEYKpwudzKfVwVMkkzcdz6q4
         vgy7h2R/n6hRSlgvUn5c96xWCHj9H2RXQnC1JC3RKojUK0ZwT1pBxGeUlV/RsWfp3y7s
         DEMaa+M59ovZaRITxa1V+/CT5TTSPKimZDHQzuY4JE5CKK1PtvqDu4cN3ceLTx5M9OAq
         3LrAlLTRdfZE3jWE8kNgIXsfTYof5N5xPwh6pQx7e8iT9wy1DprOiyirHYmGgDs/IZKS
         ovtw==
X-Gm-Message-State: AOAM5314joSykr77r85Ww9+DzFV7MRJk1PvpvYHIYo6KH3CRznL9Iu5C
        FDTI8JCpAM5ePHppdgxuQGs=
X-Google-Smtp-Source: ABdhPJytmhHerfBCYOTxWn4d3Oc6gRe6w81+bxxnxrA25+Cr+HYHWZBjxiuz6XvRP8ORvirVfDhGDg==
X-Received: by 2002:a37:6e42:: with SMTP id j63mr17201660qkc.495.1589828848808;
        Mon, 18 May 2020 12:07:28 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id a1sm9862811qtj.65.2020.05.18.12.07.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 12:07:28 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [PATCH 14/24] efi/printf: Refactor code to consolidate padding and output
Date:   Mon, 18 May 2020 15:07:06 -0400
Message-Id: <20200518190716.751506-15-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200518190716.751506-1-nivedita@alum.mit.edu>
References: <20200518190716.751506-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Consolidate the actual output of the formatted text into one place.

Fix a couple of edge cases:
1. If 0 is printed with a precision of 0, the printf specification says
   that nothing should be output, with one exception (2b).
2. The specification for octal alternate format (%#o) adds the leading
   zero not as a prefix as the 0x for hexadecimal is, but by increasing
   the precision if necessary to add the zero. This means that
   a. %#.2o turns 8 into "010", but 1 into "01" rather than "001".
   b. %#.o prints 0 as "0" rather than "", unlike the situation for
      decimal, hexadecimal and regular octal format, which all output an
      empty string.

Reduce the space allocated for printing a number to the maximum actually
required (22 bytes for a 64-bit number in octal), instead of the 66
bytes previously allocated.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 drivers/firmware/efi/libstub/vsprintf.c | 273 +++++++++++++-----------
 1 file changed, 148 insertions(+), 125 deletions(-)

diff --git a/drivers/firmware/efi/libstub/vsprintf.c b/drivers/firmware/efi/libstub/vsprintf.c
index 048276d9c376..3352ba394797 100644
--- a/drivers/firmware/efi/libstub/vsprintf.c
+++ b/drivers/firmware/efi/libstub/vsprintf.c
@@ -14,10 +14,12 @@
 
 #include <linux/compiler.h>
 #include <linux/ctype.h>
+#include <linux/kernel.h>
 #include <linux/limits.h>
 #include <linux/string.h>
 
-static int skip_atoi(const char **s)
+static
+int skip_atoi(const char **s)
 {
 	int i = 0;
 
@@ -32,16 +34,16 @@ static int skip_atoi(const char **s)
  * r/10 == (r * 0xccd) >> 15 is exact for all r < 16389.
  */
 static
-void put_dec_full4(char *buf, unsigned int r)
+void put_dec_full4(char *end, unsigned int r)
 {
 	int i;
 
 	for (i = 0; i < 3; i++) {
 		unsigned int q = (r * 0xccd) >> 15;
-		*buf++ = '0' + (r - q * 10);
+		*--end = '0' + (r - q * 10);
 		r = q;
 	}
-	*buf++ = '0' + r;
+	*--end = '0' + r;
 }
 
 /* put_dec is copied from lib/vsprintf.c with small modifications */
@@ -54,11 +56,11 @@ void put_dec_full4(char *buf, unsigned int r)
  * (second call in the put_dec code, assuming n is all-ones).
  */
 static
-unsigned int put_dec_helper4(char *buf, unsigned int x)
+unsigned int put_dec_helper4(char *end, unsigned int x)
 {
 	unsigned int q = (x * 0x346DC5D7ULL) >> 43;
 
-	put_dec_full4(buf, x - q * 10000);
+	put_dec_full4(end, x - q * 10000);
 	return q;
 }
 
@@ -68,10 +70,10 @@ unsigned int put_dec_helper4(char *buf, unsigned int x)
  * Performs no 64-bit division and hence should be fast on 32-bit machines.
  */
 static
-int put_dec(char *buf, unsigned long long n)
+char *put_dec(char *end, unsigned long long n)
 {
 	unsigned int d3, d2, d1, q, h;
-	char *p = buf;
+	char *p = end;
 
 	d1  = ((unsigned int)n >> 16); /* implicit "& 0xffff" */
 	h   = (n >> 32);
@@ -82,28 +84,59 @@ int put_dec(char *buf, unsigned long long n)
 	     = 281_4749_7671_0656 d3 + 42_9496_7296 d2 + 6_5536 d1 + d0 */
 	q = 656 * d3 + 7296 * d2 + 5536 * d1 + ((unsigned int)n & 0xffff);
 	q = put_dec_helper4(p, q);
-	p += 4;
+	p -= 4;
 
 	q += 7671 * d3 + 9496 * d2 + 6 * d1;
 	q = put_dec_helper4(p, q);
-	p += 4;
+	p -= 4;
 
 	q += 4749 * d3 + 42 * d2;
 	q = put_dec_helper4(p, q);
-	p += 4;
+	p -= 4;
 
 	q += 281 * d3;
 	q = put_dec_helper4(p, q);
-	p += 4;
+	p -= 4;
 
 	put_dec_full4(p, q);
-	p += 4;
+	p -= 4;
 
 	/* strip off the extra 0's we printed */
-	while (p > buf && p[-1] == '0')
-		--p;
+	while (p < end && *p == '0')
+		++p;
 
-	return p - buf;
+	return p;
+}
+
+static
+char *number(char *end, unsigned long long num, int base, char locase)
+{
+	/*
+	 * locase = 0 or 0x20. ORing digits or letters with 'locase'
+	 * produces same digits or (maybe lowercased) letters
+	 */
+
+	/* we are called with base 8, 10 or 16, only, thus don't need "G..."  */
+	static const char digits[16] = "0123456789ABCDEF"; /* "GHIJKLMNOPQRSTUVWXYZ"; */
+
+	switch (base) {
+	case 10:
+		if (num != 0)
+			end = put_dec(end, num);
+		break;
+	case 8:
+		for (; num != 0; num >>= 3)
+			*--end = '0' + (num & 07);
+		break;
+	case 16:
+		for (; num != 0; num >>= 4)
+			*--end = digits[num & 0xf] | locase;
+		break;
+	default:
+		unreachable();
+	};
+
+	return end;
 }
 
 #define ZEROPAD	1		/* pad with zero */
@@ -114,94 +147,6 @@ int put_dec(char *buf, unsigned long long n)
 #define SMALL	32		/* Must be 32 == 0x20 */
 #define SPECIAL	64		/* 0x */
 
-static char *number(char *str, long long num, int base, int size, int precision,
-		    int type)
-{
-	/* we are called with base 8, 10 or 16, only, thus don't need "G..."  */
-	static const char digits[16] = "0123456789ABCDEF"; /* "GHIJKLMNOPQRSTUVWXYZ"; */
-
-	char tmp[66];
-	char c, sign, locase;
-	int i;
-
-	/* locase = 0 or 0x20. ORing digits or letters with 'locase'
-	 * produces same digits or (maybe lowercased) letters */
-	locase = (type & SMALL);
-	if (type & LEFT)
-		type &= ~ZEROPAD;
-	c = (type & ZEROPAD) ? '0' : ' ';
-	sign = 0;
-	if (type & SIGN) {
-		if (num < 0) {
-			sign = '-';
-			num = -num;
-			size--;
-		} else if (type & PLUS) {
-			sign = '+';
-			size--;
-		} else if (type & SPACE) {
-			sign = ' ';
-			size--;
-		}
-	}
-	if (type & SPECIAL) {
-		if (base == 16)
-			size -= 2;
-		else if (base == 8)
-			size--;
-	}
-	i = 0;
-	if (num == 0)
-		tmp[i++] = '0';
-	else switch (base) {
-		case 10:
-			i += put_dec(&tmp[i], num);
-			break;
-		case 8:
-			while (num != 0) {
-				tmp[i++] = '0' + (num & 07);
-				num = (unsigned long long)num >> 3;
-			}
-			break;
-		case 16:
-			while (num != 0) {
-				tmp[i++] = digits[num & 0xf] | locase;
-				num = (unsigned long long)num >> 4;
-			}
-			break;
-
-		default:
-			unreachable();
-	}
-
-	if (i > precision)
-		precision = i;
-	size -= precision;
-	if (!(type & (ZEROPAD + LEFT)))
-		while (size-- > 0)
-			*str++ = ' ';
-	if (sign)
-		*str++ = sign;
-	if (type & SPECIAL) {
-		if (base == 8)
-			*str++ = '0';
-		else if (base == 16) {
-			*str++ = '0';
-			*str++ = ('X' | locase);
-		}
-	}
-	if (!(type & LEFT))
-		while (size-- > 0)
-			*str++ = c;
-	while (i < precision--)
-		*str++ = '0';
-	while (i-- > 0)
-		*str++ = tmp[i];
-	while (size-- > 0)
-		*str++ = ' ';
-	return str;
-}
-
 static
 int get_flags(const char **fmt)
 {
@@ -276,13 +221,33 @@ unsigned long long get_number(int sign, int qualifier, va_list *ap)
 	}
 }
 
+static
+char get_sign(long long *num, int flags)
+{
+	if (!(flags & SIGN))
+		return 0;
+	if (*num < 0) {
+		*num = -(*num);
+		return '-';
+	}
+	if (flags & PLUS)
+		return '+';
+	if (flags & SPACE)
+		return ' ';
+	return 0;
+}
+
 int vsprintf(char *buf, const char *fmt, va_list ap)
 {
-	int len;
-	unsigned long long num;
-	int i, base;
+	/* The maximum space required is to print a 64-bit number in octal */
+	char tmp[(sizeof(unsigned long long) * 8 + 2) / 3];
+	char *tmp_end = &tmp[ARRAY_SIZE(tmp)];
+	long long num;
+	int base;
 	char *str;
 	const char *s;
+	int len;
+	char sign;
 
 	int flags;		/* flags to number() */
 
@@ -325,6 +290,9 @@ int vsprintf(char *buf, const char *fmt, va_list ap)
 			flags |= LEFT;
 		}
 
+		if (flags & LEFT)
+			flags &= ~ZEROPAD;
+
 		/* get the precision */
 		precision = -1;
 		if (*fmt == '.') {
@@ -345,32 +313,25 @@ int vsprintf(char *buf, const char *fmt, va_list ap)
 			}
 		}
 
+		sign = 0;
+
 		switch (*fmt) {
 		case 'c':
-			if (!(flags & LEFT))
-				while (--field_width > 0)
-					*str++ = ' ';
-			*str++ = (unsigned char)va_arg(args, int);
-			while (--field_width > 0)
-				*str++ = ' ';
-			continue;
+			flags &= LEFT;
+			tmp[0] = (unsigned char)va_arg(args, int);
+			s = tmp;
+			precision = len = 1;
+			goto output;
 
 		case 's':
+			flags &= LEFT;
 			if (precision < 0)
 				precision = INT_MAX;
 			s = va_arg(args, char *);
 			if (!s)
 				s = precision < 6 ? "" : "(null)";
-			len = strnlen(s, precision);
-
-			if (!(flags & LEFT))
-				while (len < field_width--)
-					*str++ = ' ';
-			for (i = 0; i < len; ++i)
-				*str++ = *s++;
-			while (len < field_width--)
-				*str++ = ' ';
-			continue;
+			precision = len = strnlen(s, precision);
+			goto output;
 
 			/* integer number formats - set up the flags and "break" */
 		case 'o':
@@ -393,6 +354,7 @@ int vsprintf(char *buf, const char *fmt, va_list ap)
 			flags |= SIGN;
 			fallthrough;
 		case 'u':
+			flags &= ~SPECIAL;
 			base = 10;
 			break;
 
@@ -408,7 +370,68 @@ int vsprintf(char *buf, const char *fmt, va_list ap)
 			num = (unsigned long)va_arg(args, void *);
 		else
 			num = get_number(flags & SIGN, qualifier, &args);
-		str = number(str, num, base, field_width, precision, flags);
+
+		sign = get_sign(&num, flags);
+		if (sign)
+			--field_width;
+
+		s = number(tmp_end, num, base, flags & SMALL);
+		len = tmp_end - s;
+		/* default precision is 1 */
+		if (precision < 0)
+			precision = 1;
+		/* precision is minimum number of digits to print */
+		if (precision < len)
+			precision = len;
+		if (flags & SPECIAL) {
+			/*
+			 * For octal, a leading 0 is printed only if necessary,
+			 * i.e. if it's not already there because of the
+			 * precision.
+			 */
+			if (base == 8 && precision == len)
+				++precision;
+			/*
+			 * For hexadecimal, the leading 0x is skipped if the
+			 * output is empty, i.e. both the number and the
+			 * precision are 0.
+			 */
+			if (base == 16 && precision > 0)
+				field_width -= 2;
+			else
+				flags &= ~SPECIAL;
+		}
+		/*
+		 * For zero padding, increase the precision to fill the field
+		 * width.
+		 */
+		if ((flags & ZEROPAD) && field_width > precision)
+			precision = field_width;
+
+output:
+		/* Calculate the padding necessary */
+		field_width -= precision;
+		/* Leading padding with ' ' */
+		if (!(flags & LEFT))
+			while (field_width-- > 0)
+				*str++ = ' ';
+		/* sign */
+		if (sign)
+			*str++ = sign;
+		/* 0x/0X for hexadecimal */
+		if (flags & SPECIAL) {
+			*str++ = '0';
+			*str++ = 'X' | (flags & SMALL);
+		}
+		/* Zero padding and excess precision */
+		while (precision-- > len)
+			*str++ = '0';
+		/* Actual output */
+		while (len-- > 0)
+			*str++ = *s++;
+		/* Trailing padding with ' ' */
+		while (field_width-- > 0)
+			*str++ = ' ';
 	}
 	*str = '\0';
 
-- 
2.26.2

