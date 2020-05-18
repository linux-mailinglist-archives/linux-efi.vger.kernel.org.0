Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3531D87E2
	for <lists+linux-efi@lfdr.de>; Mon, 18 May 2020 21:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbgERTHa (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 18 May 2020 15:07:30 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:46335 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbgERTH1 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 18 May 2020 15:07:27 -0400
Received: by mail-qt1-f195.google.com with SMTP id p12so9022363qtn.13
        for <linux-efi@vger.kernel.org>; Mon, 18 May 2020 12:07:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0x0nqDDMF4dHcnE6V7iQ+GVCAY1e0HZWp+v/+DLW0rU=;
        b=BgHZpkRe653+csAVUh8/XZIzPUPM4WOvWArA/zDxzwjz0une7vDJJIxmrZc+pJSVWK
         w2gZAvYwJxU9qIEohNis16JCufZLgk6rnuTSzSDuHByRB9p1dGxIOZVOXNZxrCv4MypQ
         HJCHe42C3SeqIzhbNlyyOh6KPra5Ntl0DeXPm5wdesjp2jxoHu84PNkaExc7I/76iQni
         EAlLAQYXEG5botOviPwHD3mCws54PgZE/s+s3qOwnL6uqCUn7nRG3pqGyQ8rbkJy5uD1
         7+wfe2PTMYo+CLNmba8fNhPJfE27N574baQxB981woU5SFJ4Vs2M0TtpftgFMzdN6C6g
         ECkA==
X-Gm-Message-State: AOAM530QSlLMhULeGJv7lTuh1NpSFOrDplm9gbM14REPKROzC8ibX9Dg
        329yGPlz7nG/assvfyPE7DEewWUvTYw=
X-Google-Smtp-Source: ABdhPJw04OQz/RB2aTGvOKSwk88p1M8cVq4LmbHL/sQi1Os7ZRp7T1TefvwRn0GPoYJsDMh9HJ7NEg==
X-Received: by 2002:ac8:1c3d:: with SMTP id a58mr18618889qtk.52.1589828846296;
        Mon, 18 May 2020 12:07:26 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id a1sm9862811qtj.65.2020.05.18.12.07.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 12:07:25 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [PATCH 11/24] efi/printf: Factor out width/precision parsing
Date:   Mon, 18 May 2020 15:07:03 -0400
Message-Id: <20200518190716.751506-12-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200518190716.751506-1-nivedita@alum.mit.edu>
References: <20200518190716.751506-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Factor out the width/precision parsing into a helper function.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 drivers/firmware/efi/libstub/vsprintf.c | 60 ++++++++++++++++---------
 1 file changed, 40 insertions(+), 20 deletions(-)

diff --git a/drivers/firmware/efi/libstub/vsprintf.c b/drivers/firmware/efi/libstub/vsprintf.c
index 88c503077b92..1b71651fe6bc 100644
--- a/drivers/firmware/efi/libstub/vsprintf.c
+++ b/drivers/firmware/efi/libstub/vsprintf.c
@@ -230,7 +230,20 @@ int get_flags(const char **fmt)
 	} while (1);
 }
 
-int vsprintf(char *buf, const char *fmt, va_list args)
+static
+int get_int(const char **fmt, va_list *ap)
+{
+	if (isdigit(**fmt))
+		return skip_atoi(fmt);
+	if (**fmt == '*') {
+		++(*fmt);
+		/* it's the next argument */
+		return va_arg(*ap, int);
+	}
+	return 0;
+}
+
+int vsprintf(char *buf, const char *fmt, va_list ap)
 {
 	int len;
 	unsigned long long num;
@@ -245,6 +258,24 @@ int vsprintf(char *buf, const char *fmt, va_list args)
 				   number of chars for from string */
 	int qualifier;		/* 'h', 'hh', 'l' or 'll' for integer fields */
 
+	va_list args;
+
+	/*
+	 * We want to pass our input va_list to helper functions by reference,
+	 * but there's an annoying edge case. If va_list was originally passed
+	 * to us by value, we could just pass &ap down to the helpers. This is
+	 * the case on, for example, X86_32.
+	 * However, on X86_64 (and possibly others), va_list is actually a
+	 * size-1 array containing a structure. Our function parameter ap has
+	 * decayed from T[1] to T*, and &ap has type T** rather than T(*)[1],
+	 * which is what will be expected by a function taking a va_list *
+	 * parameter.
+	 * One standard way to solve this mess is by creating a copy in a local
+	 * variable of type va_list and then passing a pointer to that local
+	 * copy instead, which is what we do here.
+	 */
+	va_copy(args, ap);
+
 	for (str = buf; *fmt; ++fmt) {
 		if (*fmt != '%' || *++fmt == '%') {
 			*str++ = *fmt;
@@ -255,31 +286,17 @@ int vsprintf(char *buf, const char *fmt, va_list args)
 		flags = get_flags(&fmt);
 
 		/* get field width */
-		field_width = -1;
-		if (isdigit(*fmt))
-			field_width = skip_atoi(&fmt);
-		else if (*fmt == '*') {
-			++fmt;
-			/* it's the next argument */
-			field_width = va_arg(args, int);
-			if (field_width < 0) {
-				field_width = -field_width;
-				flags |= LEFT;
-			}
+		field_width = get_int(&fmt, &args);
+		if (field_width < 0) {
+			field_width = -field_width;
+			flags |= LEFT;
 		}
 
 		/* get the precision */
 		precision = -1;
 		if (*fmt == '.') {
 			++fmt;
-			if (isdigit(*fmt))
-				precision = skip_atoi(&fmt);
-			else if (*fmt == '*') {
-				++fmt;
-				/* it's the next argument */
-				precision = va_arg(args, int);
-			} else
-				precision = 0;
+			precision = get_int(&fmt, &args);
 			if (precision >= 0)
 				flags &= ~ZEROPAD;
 		}
@@ -390,6 +407,9 @@ int vsprintf(char *buf, const char *fmt, va_list args)
 		str = number(str, num, base, field_width, precision, flags);
 	}
 	*str = '\0';
+
+	va_end(args);
+
 	return str - buf;
 }
 
-- 
2.26.2

