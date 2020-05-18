Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77EE41D87E8
	for <lists+linux-efi@lfdr.de>; Mon, 18 May 2020 21:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbgERTHg (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 18 May 2020 15:07:36 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:35128 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbgERTHe (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 18 May 2020 15:07:34 -0400
Received: by mail-qt1-f195.google.com with SMTP id z18so9086362qto.2
        for <linux-efi@vger.kernel.org>; Mon, 18 May 2020 12:07:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z4y1pOdOwajAoLihdlLLsO4GCoph5ivswXQkRlTr2MM=;
        b=QEnvGIqsfMFr7yfEQibzzOZ5ZR6JVbWIrxvcDTYLAUN7j+TCphxSUco8cD0w7gdwcP
         GswrZAo79K93b+facvhcBcR18UE7yNQpEf2TDSjhlQu+hh7j+bj0tZDw1GukX/fMBYuV
         8qbb1aZ7gsHzkJoKASTCjrZOmqNa5seeCPfwG1M98BoTOj8d16CTMEdF5C+NESnI4uav
         yR58xzJHQogrImgfMv8iDiZXg023WD4xsnI4PBVyYRtUnyA0NiRpRSP8dNnwEauU3/N5
         +fQKbqdgEuX4lsLC2SXa6EBow3L09Zh4+IbUA/YuYudup8K9T0NpJ4fQcYQSClgvmb9s
         QTvA==
X-Gm-Message-State: AOAM533pNLXDyqv9KK9xA2IEnkirDHz9XX+zcNJiGWe8VOS8wKRb7l12
        NEj4/H3RMv7Jgw97VL2KoWS6xjmv/VQ=
X-Google-Smtp-Source: ABdhPJw/oec/sRNwJ7muDT+S2f70WZwndeM7ZyXmPNxM29b9svGGIo9lgVpNesGLp38eFeIl6eYu0Q==
X-Received: by 2002:aed:374a:: with SMTP id i68mr17988936qtb.69.1589828853128;
        Mon, 18 May 2020 12:07:33 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id a1sm9862811qtj.65.2020.05.18.12.07.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 12:07:32 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [PATCH 20/24] efi/printf: Add support for wchar_t (UTF-16)
Date:   Mon, 18 May 2020 15:07:12 -0400
Message-Id: <20200518190716.751506-21-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200518190716.751506-1-nivedita@alum.mit.edu>
References: <20200518190716.751506-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Support %lc and %ls to output UTF-16 strings (converted to UTF-8).

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 drivers/firmware/efi/libstub/vsprintf.c | 111 ++++++++++++++++++++++--
 1 file changed, 106 insertions(+), 5 deletions(-)

diff --git a/drivers/firmware/efi/libstub/vsprintf.c b/drivers/firmware/efi/libstub/vsprintf.c
index 36f2f4cf7434..136ec18e2f46 100644
--- a/drivers/firmware/efi/libstub/vsprintf.c
+++ b/drivers/firmware/efi/libstub/vsprintf.c
@@ -147,6 +147,7 @@ char *number(char *end, unsigned long long num, int base, char locase)
 #define LEFT	16		/* left justified */
 #define SMALL	32		/* Must be 32 == 0x20 */
 #define SPECIAL	64		/* 0x */
+#define WIDE	128		/* UTF-16 string */
 
 static
 int get_flags(const char **fmt)
@@ -238,6 +239,58 @@ char get_sign(long long *num, int flags)
 	return 0;
 }
 
+static
+size_t utf16s_utf8nlen(const u16 *s16, size_t maxlen)
+{
+	size_t len, clen;
+
+	for (len = 0; len < maxlen && *s16; len += clen) {
+		u16 c0 = *s16++;
+
+		/* First, get the length for a BMP character */
+		clen = 1 + (c0 >= 0x80) + (c0 >= 0x800);
+		if (len + clen > maxlen)
+			break;
+		/*
+		 * If this is a high surrogate, and we're already at maxlen, we
+		 * can't include the character if it's a valid surrogate pair.
+		 * Avoid accessing one extra word just to check if it's valid
+		 * or not.
+		 */
+		if ((c0 & 0xfc00) == 0xd800) {
+			if (len + clen == maxlen)
+				break;
+			if ((*s16 & 0xfc00) == 0xdc00) {
+				++s16;
+				++clen;
+			}
+		}
+	}
+
+	return len;
+}
+
+static
+u32 utf16_to_utf32(const u16 **s16)
+{
+	u16 c0, c1;
+
+	c0 = *(*s16)++;
+	/* not a surrogate */
+	if ((c0 & 0xf800) != 0xd800)
+		return c0;
+	/* invalid: low surrogate instead of high */
+	if (c0 & 0x0400)
+		return 0xfffd;
+	c1 = **s16;
+	/* invalid: missing low surrogate */
+	if ((c1 & 0xfc00) != 0xdc00)
+		return 0xfffd;
+	/* valid surrogate pair */
+	++(*s16);
+	return (0x10000 - (0xd800 << 10) - 0xdc00) + (c0 << 10) + c1;
+}
+
 #define PUTC(c) \
 do {				\
 	if (pos < size)		\
@@ -325,18 +378,31 @@ int vsnprintf(char *buf, size_t size, const char *fmt, va_list ap)
 		switch (*fmt) {
 		case 'c':
 			flags &= LEFT;
-			tmp[0] = (unsigned char)va_arg(args, int);
 			s = tmp;
-			precision = len = 1;
+			if (qualifier == 'l') {
+				((u16 *)tmp)[0] = (u16)va_arg(args, unsigned int);
+				((u16 *)tmp)[1] = L'\0';
+				precision = INT_MAX;
+				goto wstring;
+			} else {
+				tmp[0] = (unsigned char)va_arg(args, int);
+				precision = len = 1;
+			}
 			goto output;
 
 		case 's':
 			flags &= LEFT;
 			if (precision < 0)
 				precision = INT_MAX;
-			s = va_arg(args, char *);
+			s = va_arg(args, void *);
 			if (!s)
 				s = precision < 6 ? "" : "(null)";
+			else if (qualifier == 'l') {
+		wstring:
+				flags |= WIDE;
+				precision = len = utf16s_utf8nlen((const u16 *)s, precision);
+				goto output;
+			}
 			precision = len = strnlen(s, precision);
 			goto output;
 
@@ -435,8 +501,43 @@ int vsnprintf(char *buf, size_t size, const char *fmt, va_list ap)
 		while (precision-- > len)
 			PUTC('0');
 		/* Actual output */
-		while (len-- > 0)
-			PUTC(*s++);
+		if (flags & WIDE) {
+			const u16 *ws = (const u16 *)s;
+
+			while (len-- > 0) {
+				u32 c32 = utf16_to_utf32(&ws);
+				u8 *s8;
+				size_t clen;
+
+				if (c32 < 0x80) {
+					PUTC(c32);
+					continue;
+				}
+
+				/* Number of trailing octets */
+				clen = 1 + (c32 >= 0x800) + (c32 >= 0x10000);
+
+				len -= clen;
+				s8 = (u8 *)&buf[pos];
+
+				/* Avoid writing partial character */
+				PUTC('\0');
+				pos += clen;
+				if (pos >= size)
+					continue;
+
+				/* Set high bits of leading octet */
+				*s8 = (0xf00 >> 1) >> clen;
+				/* Write trailing octets in reverse order */
+				for (s8 += clen; clen; --clen, c32 >>= 6)
+					*s8-- = 0x80 | (c32 & 0x3f);
+				/* Set low bits of leading octet */
+				*s8 |= c32;
+			}
+		} else {
+			while (len-- > 0)
+				PUTC(*s++);
+		}
 		/* Trailing padding with ' ' */
 		while (field_width-- > 0)
 			PUTC(' ');
-- 
2.26.2

