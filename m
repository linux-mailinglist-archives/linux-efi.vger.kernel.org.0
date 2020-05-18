Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43BDA1D87D4
	for <lists+linux-efi@lfdr.de>; Mon, 18 May 2020 21:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbgERTHV (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 18 May 2020 15:07:21 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:33854 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726374AbgERTHV (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 18 May 2020 15:07:21 -0400
Received: by mail-qk1-f193.google.com with SMTP id 190so11493970qki.1
        for <linux-efi@vger.kernel.org>; Mon, 18 May 2020 12:07:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KNt8xSFOeACzamGszyWkjjITHV6tNlwlTbwDDnXubWM=;
        b=HIhlyCs2KVkcfpfpR0sFv8ei05QxCRjWzicc+CzzLbT1GhRO1hCHMhdu+ZZazFFZ74
         cPXtgElpY6YyRSctUdzNZ1j8lN7bbKENlgs7SQXFPi0S/JftGt1eKNVHV/Nec1ViUnke
         1QvptfPYU3PXOXfUWrFUyepH/x1qT2YGEhMKZ2yg6jZI7H3sIp4UcqpA0s7HXavaSY8V
         s7zHLf4zFEg/yJ/a4o/gSlGYbyf0VkRAbpWRcciImQVgMoCIYujcKVxU9neigF/6Pyiw
         CKEG3GRLafhp9jTAn0LU7r1NJ/OBWz/w4OgepxuQsZ7Vdmlv5lp9dJhXVyYuh7KLh+Rl
         nvkA==
X-Gm-Message-State: AOAM532ZVfGA2RMDpHiz9eCX4hDQSxPCvNYt6je+pyegPhqTAHOIKFXW
        RNRmu25MNDpQmBxXFygRliI=
X-Google-Smtp-Source: ABdhPJzkFod1ZyEwDCU12Z3qIpMo2eJHUiV2r0lUZwSG41RaN1YuFZ4MXz3n7/6CSpf690W0RH1Aaw==
X-Received: by 2002:a05:620a:1312:: with SMTP id o18mr17762193qkj.277.1589828839848;
        Mon, 18 May 2020 12:07:19 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id a1sm9862811qtj.65.2020.05.18.12.07.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 12:07:19 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [PATCH 03/24] efi/libstub: Buffer output of efi_puts
Date:   Mon, 18 May 2020 15:06:55 -0400
Message-Id: <20200518190716.751506-4-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200518190716.751506-1-nivedita@alum.mit.edu>
References: <20200518190716.751506-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Use a buffer to convert the string to UTF-16. This will reduce the
number of firmware calls required to print the string from one per
character to one per string in most cases.

Cast the input char to unsigned char before converting to efi_char16_t
to avoid sign-extension in case there are any non-ASCII characters in
the input.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 .../firmware/efi/libstub/efi-stub-helper.c    | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index c6d7ef35e9f7..3cf506ab9ead 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -8,6 +8,7 @@
  */
 
 #include <linux/efi.h>
+#include <linux/kernel.h>
 #include <asm/efi.h>
 
 #include "efistub.h"
@@ -34,13 +35,19 @@ void efi_char16_puts(efi_char16_t *str)
 
 void efi_puts(const char *str)
 {
-	while (*str) {
-		efi_char16_t ch[] = { *str++, L'\0' };
+	efi_char16_t buf[128];
+	size_t pos = 0, lim = ARRAY_SIZE(buf);
 
-		if (ch[0] == L'\n')
-			efi_char16_puts(L"\r\n");
-		else
-			efi_char16_puts(ch);
+	while (*str) {
+		if (*str == '\n')
+			buf[pos++] = L'\r';
+		/* Cast to unsigned char to avoid sign-extension */
+		buf[pos++] = (unsigned char)(*str++);
+		if (*str == '\0' || pos >= lim - 2) {
+			buf[pos] = L'\0';
+			efi_char16_puts(buf);
+			pos = 0;
+		}
 	}
 }
 
-- 
2.26.2

