Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4412E1D87DD
	for <lists+linux-efi@lfdr.de>; Mon, 18 May 2020 21:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbgERTH0 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 18 May 2020 15:07:26 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:42474 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726505AbgERTHY (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 18 May 2020 15:07:24 -0400
Received: by mail-qk1-f194.google.com with SMTP id s1so11438862qkf.9
        for <linux-efi@vger.kernel.org>; Mon, 18 May 2020 12:07:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sOuk3ReJ22pNmIEvA2WQj393XxOd96mR6sC1C9ggUK0=;
        b=qubSOVzUp3RSMolKosR8/ZS+AeL+q8jqXZS6l7BTuZju6zbV7yNOvJ71/8r1Q9dll6
         mtN1dqivviLj1uGhg/KWZ51b2Q4MVPai2UBUfoeZOtWksPFNYy+MNcxJ4A9VVm4iohCh
         X7P0j3YPSLNmr1xDzcpMFXCwXtRjby6dcjX91ncqTv0UFhXy2C13OYZ82XWvoBLy9i+7
         e1jYa3Gtpvqt3ULtJdEvfOlYkFWsHxQofjGcByuugDh0oOVURn9nPW0strKDigsRoZj1
         bkdELY5y8sPl7f5Js+eJMDP8U9qbTcrACKL0Agnjn0MBo21doXp4Cdf1XNvfjHCjZL7G
         xTAQ==
X-Gm-Message-State: AOAM533Bd9HiJF44x8kVPAfDMXgJuHSqRgxH9maSZbEHygWMyfBwia5y
        04EXbMxnt+Gf2CwZigLmhgY=
X-Google-Smtp-Source: ABdhPJxyep4BUUTDULvrTdCL9NLW4eV50F/HvKHCUx6FnN/nY4ZzeeqyZ1+RSuwzT29wonLMezlcXQ==
X-Received: by 2002:a37:a58:: with SMTP id 85mr15928801qkk.404.1589828843536;
        Mon, 18 May 2020 12:07:23 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id a1sm9862811qtj.65.2020.05.18.12.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 12:07:23 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [PATCH 08/24] efi/printf: Factor out flags parsing and handle '%' earlier
Date:   Mon, 18 May 2020 15:07:00 -0400
Message-Id: <20200518190716.751506-9-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200518190716.751506-1-nivedita@alum.mit.edu>
References: <20200518190716.751506-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Move flags parsing code out into a helper function.

The '%%' case can be handled up front: it is not allowed to have flags,
width etc.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 drivers/firmware/efi/libstub/vsprintf.c | 56 ++++++++++++++-----------
 1 file changed, 31 insertions(+), 25 deletions(-)

diff --git a/drivers/firmware/efi/libstub/vsprintf.c b/drivers/firmware/efi/libstub/vsprintf.c
index 20fc2530f805..b3ed4af77af5 100644
--- a/drivers/firmware/efi/libstub/vsprintf.c
+++ b/drivers/firmware/efi/libstub/vsprintf.c
@@ -201,6 +201,35 @@ static char *number(char *str, long long num, int base, int size, int precision,
 	return str;
 }
 
+static
+int get_flags(const char **fmt)
+{
+	int flags = 0;
+
+	do {
+		switch (**fmt) {
+		case '-':
+			flags |= LEFT;
+			break;
+		case '+':
+			flags |= PLUS;
+			break;
+		case ' ':
+			flags |= SPACE;
+			break;
+		case '#':
+			flags |= SPECIAL;
+			break;
+		case '0':
+			flags |= ZEROPAD;
+			break;
+		default:
+			return flags;
+		}
+		++(*fmt);
+	} while (1);
+}
+
 int vsprintf(char *buf, const char *fmt, va_list args)
 {
 	int len;
@@ -217,32 +246,13 @@ int vsprintf(char *buf, const char *fmt, va_list args)
 	int qualifier;		/* 'h', 'hh', 'l' or 'll' for integer fields */
 
 	for (str = buf; *fmt; ++fmt) {
-		if (*fmt != '%') {
+		if (*fmt != '%' || *++fmt == '%') {
 			*str++ = *fmt;
 			continue;
 		}
 
 		/* process flags */
-		flags = 0;
-	      repeat:
-		++fmt;		/* this also skips first '%' */
-		switch (*fmt) {
-		case '-':
-			flags |= LEFT;
-			goto repeat;
-		case '+':
-			flags |= PLUS;
-			goto repeat;
-		case ' ':
-			flags |= SPACE;
-			goto repeat;
-		case '#':
-			flags |= SPECIAL;
-			goto repeat;
-		case '0':
-			flags |= ZEROPAD;
-			goto repeat;
-		}
+		flags = get_flags(&fmt);
 
 		/* get field width */
 		field_width = -1;
@@ -320,10 +330,6 @@ int vsprintf(char *buf, const char *fmt, va_list args)
 				     field_width, precision, flags);
 			continue;
 
-		case '%':
-			*str++ = '%';
-			continue;
-
 			/* integer number formats - set up the flags and "break" */
 		case 'o':
 			base = 8;
-- 
2.26.2

