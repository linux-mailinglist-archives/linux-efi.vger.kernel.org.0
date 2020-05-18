Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30A5B1D87DF
	for <lists+linux-efi@lfdr.de>; Mon, 18 May 2020 21:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbgERTH3 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 18 May 2020 15:07:29 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:39382 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726504AbgERTH0 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 18 May 2020 15:07:26 -0400
Received: by mail-qk1-f193.google.com with SMTP id r187so8554327qkf.6
        for <linux-efi@vger.kernel.org>; Mon, 18 May 2020 12:07:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6R029e71hJTHox5v5rllTutY6nr/0P3QmyUf4o25p5o=;
        b=fVoc4IRhqrod1FyvMR6ANOznG5WhYLQV85tm3z6TuqlbMyl2AKpIEgEYbxBGVbc/n8
         iWx6UdlPckW6NZkVjVOLzJBB9v9RDK8MQp2Od9phPnw1PYSBP1UX7efBisBeVuNIHNr1
         uNSTfLzPWGh3i9ftfDQX+1WpYnetPKeY8TTWhdMdWc25ByLqz48ZP3GpUdq6KE/3mFc/
         DymSVzoHAfza8OEk3DG6twraYW3Ax6Ss/rB0SVicqR3BdWAGdGeScNjvtGxHpCcPhEl6
         pKU6Jq7PMQGSmqZLDrMPDfcmBBMSv+8zzrenAG16hgc1GgzhbP31nq4Lo/NePWDDGXsk
         kYBA==
X-Gm-Message-State: AOAM530SjXpO0gieD0joD4jAN03bgigXHHuo+4uTJ5kGzB1wpOY23348
        td0lOT+vIxssMSqo+Nkljk0=
X-Google-Smtp-Source: ABdhPJzERaSumq5GEeVJjMzilKb5nlmuNcanNie6SVfGvBOsx6mZRmMdnDxU8XrMhkkG1JQM9rGkbQ==
X-Received: by 2002:a37:742:: with SMTP id 63mr17060905qkh.361.1589828845482;
        Mon, 18 May 2020 12:07:25 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id a1sm9862811qtj.65.2020.05.18.12.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 12:07:24 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [PATCH 10/24] efi/printf: Merge 'p' with the integer formats
Date:   Mon, 18 May 2020 15:07:02 -0400
Message-Id: <20200518190716.751506-11-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200518190716.751506-1-nivedita@alum.mit.edu>
References: <20200518190716.751506-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Treat 'p' as a hexadecimal integer with precision equal to the number of
digits in void *.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 drivers/firmware/efi/libstub/vsprintf.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/firmware/efi/libstub/vsprintf.c b/drivers/firmware/efi/libstub/vsprintf.c
index d7938e44f067..88c503077b92 100644
--- a/drivers/firmware/efi/libstub/vsprintf.c
+++ b/drivers/firmware/efi/libstub/vsprintf.c
@@ -295,9 +295,6 @@ int vsprintf(char *buf, const char *fmt, va_list args)
 			}
 		}
 
-		/* default base */
-		base = 10;
-
 		switch (*fmt) {
 		case 'c':
 			if (!(flags & LEFT))
@@ -321,21 +318,15 @@ int vsprintf(char *buf, const char *fmt, va_list args)
 				*str++ = ' ';
 			continue;
 
-		case 'p':
-			if (field_width == -1) {
-				field_width = 2 * sizeof(void *);
-				flags |= ZEROPAD;
-			}
-			str = number(str,
-				     (unsigned long)va_arg(args, void *), 16,
-				     field_width, precision, flags);
-			continue;
-
 			/* integer number formats - set up the flags and "break" */
 		case 'o':
 			base = 8;
 			break;
 
+		case 'p':
+			if (precision < 0)
+				precision = 2 * sizeof(void *);
+			fallthrough;
 		case 'x':
 			flags |= SMALL;
 			fallthrough;
@@ -348,6 +339,7 @@ int vsprintf(char *buf, const char *fmt, va_list args)
 			flags |= SIGN;
 			fallthrough;
 		case 'u':
+			base = 10;
 			break;
 
 		default:
@@ -358,7 +350,9 @@ int vsprintf(char *buf, const char *fmt, va_list args)
 				--fmt;
 			continue;
 		}
-		if (flags & SIGN) {
+		if (*fmt == 'p')
+			num = (unsigned long)va_arg(args, void *);
+		else if (flags & SIGN) {
 			switch (qualifier) {
 			case 'L':
 				num = va_arg(args, long long);
-- 
2.26.2

