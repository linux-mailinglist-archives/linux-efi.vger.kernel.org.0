Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A70B1D87E6
	for <lists+linux-efi@lfdr.de>; Mon, 18 May 2020 21:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbgERTHe (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 18 May 2020 15:07:34 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:34133 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726553AbgERTHc (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 18 May 2020 15:07:32 -0400
Received: by mail-qt1-f195.google.com with SMTP id a23so3344057qto.1
        for <linux-efi@vger.kernel.org>; Mon, 18 May 2020 12:07:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dm0AWhZq933OVtCzy7CiAJHP7WTrC8LBHUbou1f2eHs=;
        b=SAVRkyK6f8yEfcHdMnO9Oy9T17yEDZWkIMUTLaY/SiEz8ihdd9G5Jb8RCPPq4zMb6M
         WYNqEVYgnqgrA/xHpnO8WlpcEVfOozvHM0XcO4ep3qjaVfX8MX7xxbh/0s3hmbgs/OiD
         v7gg5Z2SfZar2QBdDhaUtLX3+pTVEJGU+oK6a3Ro8OfG6464rUQ08QIXWr1DDeCztXFf
         wyuBcQsKreSt/+K+q51AW7CkYoyHq92M0H8kg8o0yerFUIE1J6mc8hpPKro2xbX26db3
         qCmUfGCYG9qcT69CWpT8JTVHsVnix8kLeMLM5DJE4BBO7aIZ0viz5M0PtY1XOvdwdINv
         qJ5g==
X-Gm-Message-State: AOAM5309Bd+v9by6bWBScU3H6zfp7KDWRfMar8664KatfdR6w5sZRRgs
        3oqlwGKu/gBeQlrntE0/Kg0=
X-Google-Smtp-Source: ABdhPJw3Sjojo555zD1ikEXymd8al7QJDECVe7hMym+WS8+1A+YSBiTsEBkerVQ3FVVSx4Rl8+9txA==
X-Received: by 2002:ac8:3173:: with SMTP id h48mr18209305qtb.179.1589828850114;
        Mon, 18 May 2020 12:07:30 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id a1sm9862811qtj.65.2020.05.18.12.07.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 12:07:29 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [PATCH 16/24] efi/printf: Turn vsprintf into vsnprintf
Date:   Mon, 18 May 2020 15:07:08 -0400
Message-Id: <20200518190716.751506-17-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200518190716.751506-1-nivedita@alum.mit.edu>
References: <20200518190716.751506-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Implement vsnprintf instead of vsprintf to avoid the possibility of a
buffer overflow.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 .../firmware/efi/libstub/efi-stub-helper.c    |  6 ++-
 drivers/firmware/efi/libstub/vsprintf.c       | 42 +++++++++++--------
 2 files changed, 30 insertions(+), 18 deletions(-)

diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index 56b3b84fd3bd..5ecafc57619a 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -60,10 +60,14 @@ int efi_printk(const char *fmt, ...)
 	int printed;
 
 	va_start(args, fmt);
-	printed = vsprintf(printf_buf, fmt, args);
+	printed = vsnprintf(printf_buf, sizeof(printf_buf), fmt, args);
 	va_end(args);
 
 	efi_puts(printf_buf);
+	if (printed >= sizeof(printf_buf)) {
+		efi_puts("[Message truncated]\n");
+		return -1;
+	}
 
 	return printed;
 }
diff --git a/drivers/firmware/efi/libstub/vsprintf.c b/drivers/firmware/efi/libstub/vsprintf.c
index 7dcbc04498e7..36f2f4cf7434 100644
--- a/drivers/firmware/efi/libstub/vsprintf.c
+++ b/drivers/firmware/efi/libstub/vsprintf.c
@@ -17,6 +17,7 @@
 #include <linux/kernel.h>
 #include <linux/limits.h>
 #include <linux/string.h>
+#include <linux/types.h>
 
 static
 int skip_atoi(const char **s)
@@ -237,16 +238,22 @@ char get_sign(long long *num, int flags)
 	return 0;
 }
 
-int vsprintf(char *buf, const char *fmt, va_list ap)
+#define PUTC(c) \
+do {				\
+	if (pos < size)		\
+		buf[pos] = (c);	\
+	++pos;			\
+} while (0);
+
+int vsnprintf(char *buf, size_t size, const char *fmt, va_list ap)
 {
 	/* The maximum space required is to print a 64-bit number in octal */
 	char tmp[(sizeof(unsigned long long) * 8 + 2) / 3];
 	char *tmp_end = &tmp[ARRAY_SIZE(tmp)];
 	long long num;
 	int base;
-	char *str;
 	const char *s;
-	int len;
+	size_t len, pos;
 	char sign;
 
 	int flags;		/* flags to number() */
@@ -274,9 +281,9 @@ int vsprintf(char *buf, const char *fmt, va_list ap)
 	 */
 	va_copy(args, ap);
 
-	for (str = buf; *fmt; ++fmt) {
+	for (pos = 0; *fmt; ++fmt) {
 		if (*fmt != '%' || *++fmt == '%') {
-			*str++ = *fmt;
+			PUTC(*fmt);
 			continue;
 		}
 
@@ -415,40 +422,41 @@ int vsprintf(char *buf, const char *fmt, va_list ap)
 		/* Leading padding with ' ' */
 		if (!(flags & LEFT))
 			while (field_width-- > 0)
-				*str++ = ' ';
+				PUTC(' ');
 		/* sign */
 		if (sign)
-			*str++ = sign;
+			PUTC(sign);
 		/* 0x/0X for hexadecimal */
 		if (flags & SPECIAL) {
-			*str++ = '0';
-			*str++ = 'X' | (flags & SMALL);
+			PUTC('0');
+			PUTC( 'X' | (flags & SMALL));
 		}
 		/* Zero padding and excess precision */
 		while (precision-- > len)
-			*str++ = '0';
+			PUTC('0');
 		/* Actual output */
 		while (len-- > 0)
-			*str++ = *s++;
+			PUTC(*s++);
 		/* Trailing padding with ' ' */
 		while (field_width-- > 0)
-			*str++ = ' ';
+			PUTC(' ');
 	}
 fail:
-	*str = '\0';
-
 	va_end(args);
 
-	return str - buf;
+	if (size)
+		buf[min(pos, size-1)] = '\0';
+
+	return pos;
 }
 
-int sprintf(char *buf, const char *fmt, ...)
+int snprintf(char *buf, size_t size, const char *fmt, ...)
 {
 	va_list args;
 	int i;
 
 	va_start(args, fmt);
-	i = vsprintf(buf, fmt, args);
+	i = vsnprintf(buf, size, fmt, args);
 	va_end(args);
 	return i;
 }
-- 
2.26.2

