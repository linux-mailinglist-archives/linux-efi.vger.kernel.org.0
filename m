Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E60A01D87D9
	for <lists+linux-efi@lfdr.de>; Mon, 18 May 2020 21:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbgERTHh (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 18 May 2020 15:07:37 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:34141 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726553AbgERTHg (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 18 May 2020 15:07:36 -0400
Received: by mail-qt1-f196.google.com with SMTP id a23so3344236qto.1
        for <linux-efi@vger.kernel.org>; Mon, 18 May 2020 12:07:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n2+mp2oioqnXLDd7lyopk0p21Q0yaRtmEUZkcAcyKHs=;
        b=L7O3Da3jCxJT/NBkQLcoU5m9Zy2OMqYfoMRiZgNejmyo+2MkKFokHiG5VrYhnTWCJB
         xX+JbCU+pmsLMGLCYixlOzBLqwNjcCKC9r7Mdam/EMpetQBpmS9DHUIct4ORd9GJWeem
         wP/2aLBsiw48iHiXZjcwzuWRssdlpzBBgHmc6pZpg878VPf/DM0kzBAPciGRN6G7z9YJ
         do5QxYEyRBKpuQk+rrazNz1Ee/4lJnE/WEGh+o4nF0J1wPmGZp+hal7AUsslpGacKoge
         ipGOSFPn9wvQr4WODG4nJ+kor9YX3T1ZoKyjl3f+IhUYHVRh7hjtUDlENnn9sbLnUjJM
         qCyA==
X-Gm-Message-State: AOAM531gF9/zEOC6r1uGOA0yWtXTjRcNvdzxGZeeD5OQMq9uwmwDgv+4
        Dv2ZBFLuwrMm/OnrGhUenpBkhHL6wA4=
X-Google-Smtp-Source: ABdhPJyR9CAINp36UApb7bKPnaxMcVuASzginpQY9h3gjw0E7rXTlKG9GA8cYsZN1gLi37Qwf6tu+A==
X-Received: by 2002:ac8:6615:: with SMTP id c21mr10374210qtp.185.1589828854960;
        Mon, 18 May 2020 12:07:34 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id a1sm9862811qtj.65.2020.05.18.12.07.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 12:07:34 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [PATCH 23/24] efi/libstub: Get the exact UTF-8 length
Date:   Mon, 18 May 2020 15:07:15 -0400
Message-Id: <20200518190716.751506-24-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200518190716.751506-1-nivedita@alum.mit.edu>
References: <20200518190716.751506-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

efi_convert_cmdline currently overestimates the length of the equivalent
UTF-8 encoding.

snprintf can now be used to do the conversion to UTF-8, however, it does
not have a way to specify the size of the UTF-16 string, only the size
of the resulting UTF-8 string. So in order to use it, we need to
precalculate the exact UTF-8 size.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 .../firmware/efi/libstub/efi-stub-helper.c    | 44 ++++++++++++++-----
 1 file changed, 32 insertions(+), 12 deletions(-)

diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index 48242bc982a3..01476d8f8edf 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -205,15 +205,6 @@ efi_status_t efi_parse_options(char const *cmdline)
 	return EFI_SUCCESS;
 }
 
-/*
- * Get the number of UTF-8 bytes corresponding to an UTF-16 character.
- * This overestimates for surrogates, but that is okay.
- */
-static int efi_utf8_bytes(u16 c)
-{
-	return 1 + (c >= 0x80) + (c >= 0x800);
-}
-
 /*
  * Convert an UTF-16 string, not necessarily null terminated, to UTF-8.
  */
@@ -274,10 +265,39 @@ char *efi_convert_cmdline(efi_loaded_image_t *image,
 
 	if (options) {
 		s2 = options;
-		while (*s2 && *s2 != '\n'
-		       && options_chars < load_options_chars) {
-			options_bytes += efi_utf8_bytes(*s2++);
+		while (options_chars < load_options_chars) {
+			u16 c = *s2++;
+
+			if (c == L'\0' || c == L'\n')
+				break;
+			/*
+			 * Get the number of UTF-8 bytes corresponding to a
+			 * UTF-16 character.
+			 * The first part handles everything in the BMP.
+			 */
+			options_bytes += 1 + (c >= 0x80) + (c >= 0x800);
 			options_chars++;
+			/*
+			 * Add one more byte for valid surrogate pairs. Invalid
+			 * surrogates will be replaced with 0xfffd and take up
+			 * only 3 bytes.
+			 */
+			if ((c & 0xfc00) == 0xd800) {
+				/*
+				 * If the very last word is a high surrogate,
+				 * we must ignore it since we can't access the
+				 * low surrogate.
+				 */
+				if (options_chars == load_options_chars) {
+					options_bytes -= 3;
+					options_chars--;
+					break;
+				} else if ((*s2 & 0xfc00) == 0xdc00) {
+					options_bytes++;
+					options_chars++;
+					s2++;
+				}
+			}
 		}
 	}
 
-- 
2.26.2

