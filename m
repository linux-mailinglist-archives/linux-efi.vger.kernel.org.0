Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A246C1D87E0
	for <lists+linux-efi@lfdr.de>; Mon, 18 May 2020 21:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbgERTH3 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 18 May 2020 15:07:29 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:46398 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726374AbgERTH2 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 18 May 2020 15:07:28 -0400
Received: by mail-qk1-f195.google.com with SMTP id f83so11404771qke.13
        for <linux-efi@vger.kernel.org>; Mon, 18 May 2020 12:07:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O8XrfycEIcko67P/+2vaSkuEOC/bC3iipVXq8ggqVEc=;
        b=RDpkv4E7ReflB6vE9PdmJQ9t1vlRkIRARyjasdZQ4AZWQRvp0UPnWlv8MOrcy6i0fN
         V725pusK5Hs/dia8zwz/Ns332uWrWU2cTmGp5Gvm30m7XOU/Bdc/JqumqCWv3UcubuuM
         69qgE95BXNOa/6L4bcgf4er8LkQv9zCL2Pl/hTurGplf1AtkZAz3U6UPhFjj7eJjU0Gw
         oSbuukOIq9uGjBYQlwX6zYRfYIPTFmKquyObo0GErb3cFHs2c6MGeKAV3D/GYr3O4Yx6
         kTjEHti7H3y3LLk5mmDPRRudXBPUyHKRyQahvsgGiZWuNs7e/RYnbuF4/7xTV163kdYt
         2OVQ==
X-Gm-Message-State: AOAM530m8j3OxfJHE2rPFqLqKn8xPweAPRsqJKPepTxdddKxA9KQRn36
        6nzPMwVboJBrPu32mNKjMeU=
X-Google-Smtp-Source: ABdhPJwYzl1cWw1wKtls3UiSopO/nWEFNr9D21bL/0X3OWHkQ0O73YSpw1BHn9hHICwxe7MYRfdJMQ==
X-Received: by 2002:a37:66d5:: with SMTP id a204mr17002208qkc.188.1589828847179;
        Mon, 18 May 2020 12:07:27 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id a1sm9862811qtj.65.2020.05.18.12.07.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 12:07:26 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [PATCH 12/24] efi/printf: Factor out integer argument retrieval
Date:   Mon, 18 May 2020 15:07:04 -0400
Message-Id: <20200518190716.751506-13-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200518190716.751506-1-nivedita@alum.mit.edu>
References: <20200518190716.751506-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Factor out the code to get the correct type of numeric argument into a
helper function.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 drivers/firmware/efi/libstub/vsprintf.c | 69 ++++++++++++-------------
 1 file changed, 34 insertions(+), 35 deletions(-)

diff --git a/drivers/firmware/efi/libstub/vsprintf.c b/drivers/firmware/efi/libstub/vsprintf.c
index 1b71651fe6bc..dee9bd068cb6 100644
--- a/drivers/firmware/efi/libstub/vsprintf.c
+++ b/drivers/firmware/efi/libstub/vsprintf.c
@@ -243,6 +243,38 @@ int get_int(const char **fmt, va_list *ap)
 	return 0;
 }
 
+static
+unsigned long long get_number(int sign, int qualifier, va_list *ap)
+{
+	if (sign) {
+		switch (qualifier) {
+		case 'L':
+			return va_arg(*ap, long long);
+		case 'l':
+			return va_arg(*ap, long);
+		case 'h':
+			return (short)va_arg(*ap, int);
+		case 'H':
+			return (signed char)va_arg(*ap, int);
+		default:
+			return va_arg(*ap, int);
+		};
+	} else {
+		switch (qualifier) {
+		case 'L':
+			return va_arg(*ap, unsigned long long);
+		case 'l':
+			return va_arg(*ap, unsigned long);
+		case 'h':
+			return (unsigned short)va_arg(*ap, int);
+		case 'H':
+			return (unsigned char)va_arg(*ap, int);
+		default:
+			return va_arg(*ap, unsigned int);
+		}
+	}
+}
+
 int vsprintf(char *buf, const char *fmt, va_list ap)
 {
 	int len;
@@ -369,41 +401,8 @@ int vsprintf(char *buf, const char *fmt, va_list ap)
 		}
 		if (*fmt == 'p')
 			num = (unsigned long)va_arg(args, void *);
-		else if (flags & SIGN) {
-			switch (qualifier) {
-			case 'L':
-				num = va_arg(args, long long);
-				break;
-			case 'l':
-				num = va_arg(args, long);
-				break;
-			case 'h':
-				num = (short)va_arg(args, int);
-				break;
-			case 'H':
-				num = (signed char)va_arg(args, int);
-				break;
-			default:
-				num = va_arg(args, int);
-			}
-		} else {
-			switch (qualifier) {
-			case 'L':
-				num = va_arg(args, unsigned long long);
-				break;
-			case 'l':
-				num = va_arg(args, unsigned long);
-				break;
-			case 'h':
-				num = (unsigned short)va_arg(args, int);
-				break;
-			case 'H':
-				num = (unsigned char)va_arg(args, int);
-				break;
-			default:
-				num = va_arg(args, unsigned int);
-			}
-		}
+		else
+			num = get_number(flags & SIGN, qualifier, &args);
 		str = number(str, num, base, field_width, precision, flags);
 	}
 	*str = '\0';
-- 
2.26.2

