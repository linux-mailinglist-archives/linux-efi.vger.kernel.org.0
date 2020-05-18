Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E78E1D87DA
	for <lists+linux-efi@lfdr.de>; Mon, 18 May 2020 21:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbgERTHY (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 18 May 2020 15:07:24 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:38808 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbgERTHX (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 18 May 2020 15:07:23 -0400
Received: by mail-qk1-f195.google.com with SMTP id f189so11453404qkd.5
        for <linux-efi@vger.kernel.org>; Mon, 18 May 2020 12:07:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pTPDOaRxKOCuKruamlS+/pcEj8EnVB4SkdQgfaS27nc=;
        b=LspY+EZjVBAYcPsW5aipRqUlH72zgN6SSQRyNmxIGv99CLOUbST5AEF42SUVtt7STX
         24DB5GgI3gY+E9/67zBMqX0pJLz7jscsV4VOSU4AN7bqkSfD2TJNiicnv+BY8r1DYFef
         qujtsONeqXtPYXXp0Sx3UYKKrjmZEKY8hiumtRAx63J2FOSOXn6EoWqAnBGG3NBc1o3W
         xk7kVtwwcPKbH5YJPVxYtpKXpK3Yuxv7Yj0lx/TmOClc7bb3MUFSgCU7u7t0d3e3npTp
         gcel5aV1pPU/bfyA3zQBATFaXPQhZkngOjgwikublRooogpn+sSYvE4UWbIOQLq4Hfkp
         obLg==
X-Gm-Message-State: AOAM532ytVaM5Cqpg3/zID3ql9ETE36DGWz94FU+Gw6TrNqo5/0mG//G
        0bBYkTIVWZdFCdSCBgp+VhFcGVKFc2I=
X-Google-Smtp-Source: ABdhPJw/RlU69ORrvk0PfXkiiSg/+y1Nzw5/mpjFjpwXSLlHysTaxyUr1pyO1iu4hMjojpIH0d44Jw==
X-Received: by 2002:a05:620a:108e:: with SMTP id g14mr17286309qkk.337.1589828842158;
        Mon, 18 May 2020 12:07:22 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id a1sm9862811qtj.65.2020.05.18.12.07.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 12:07:21 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [PATCH 06/24] efi/printf: Drop %n format and L qualifier
Date:   Mon, 18 May 2020 15:06:58 -0400
Message-Id: <20200518190716.751506-7-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200518190716.751506-1-nivedita@alum.mit.edu>
References: <20200518190716.751506-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

%n is unused and deprecated.

The L qualifer is parsed but not actually implemented.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 drivers/firmware/efi/libstub/vsprintf.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/firmware/efi/libstub/vsprintf.c b/drivers/firmware/efi/libstub/vsprintf.c
index 88483a49bac4..2815196de40b 100644
--- a/drivers/firmware/efi/libstub/vsprintf.c
+++ b/drivers/firmware/efi/libstub/vsprintf.c
@@ -127,7 +127,7 @@ int vsprintf(char *buf, const char *fmt, va_list args)
 	int field_width;	/* width of output field */
 	int precision;		/* min. # of digits for integers; max
 				   number of chars for from string */
-	int qualifier;		/* 'h', 'l', or 'L' for integer fields */
+	int qualifier;		/* 'h' or 'l' for integer fields */
 
 	for (str = buf; *fmt; ++fmt) {
 		if (*fmt != '%') {
@@ -188,7 +188,7 @@ int vsprintf(char *buf, const char *fmt, va_list args)
 
 		/* get the conversion qualifier */
 		qualifier = -1;
-		if (*fmt == 'h' || *fmt == 'l' || *fmt == 'L') {
+		if (*fmt == 'h' || *fmt == 'l') {
 			qualifier = *fmt;
 			++fmt;
 		}
@@ -229,16 +229,6 @@ int vsprintf(char *buf, const char *fmt, va_list args)
 				     field_width, precision, flags);
 			continue;
 
-		case 'n':
-			if (qualifier == 'l') {
-				long *ip = va_arg(args, long *);
-				*ip = (str - buf);
-			} else {
-				int *ip = va_arg(args, int *);
-				*ip = (str - buf);
-			}
-			continue;
-
 		case '%':
 			*str++ = '%';
 			continue;
-- 
2.26.2

