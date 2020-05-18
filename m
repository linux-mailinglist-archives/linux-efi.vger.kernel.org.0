Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62BD31D87DB
	for <lists+linux-efi@lfdr.de>; Mon, 18 May 2020 21:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbgERTHi (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 18 May 2020 15:07:38 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:33945 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726624AbgERTHi (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 18 May 2020 15:07:38 -0400
Received: by mail-qk1-f196.google.com with SMTP id 190so11495472qki.1
        for <linux-efi@vger.kernel.org>; Mon, 18 May 2020 12:07:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tbZMwgKJ/LdGGx9fmnjvotHzb0DNCb0XBvaE5b8TaUc=;
        b=pcYPmlBzBNTaRS3w4Rjh5/7gurSSdxysRNh81La/5Ykmq557VucHWGU9PHf4TKB7+M
         u+g03GwPNGsJGBbpk4PFCOSFQRkQxnGoqv/rH0myxyrkSVJLqASYx8O9VfYXIOxOyfty
         3keAniAVrU7Jyhl+o5tXEx3Nbqzm2Zrmq13Bi7IfAzYBPf0BIri5zz6mkUO2Mho75i/H
         bPCsDN9OfUCL6CspRyJNMBof1S8Z2tR4Zc75+7SPRcy3WsrVgphFDqN4U24wVi8Zi52z
         /SaosMDNOjHKUOwlBoJ2DHtakfXFg69lIzTUZ5UhgOXqjdzZayOsE3UbspUv+etgRMd3
         4tGw==
X-Gm-Message-State: AOAM531b6lVsz3wST/CU1WSZTAo5GbOSzSQcCkIu3DHz1HVibFkTeZu5
        1sg0D+r0pI/C8cZffecZyMc=
X-Google-Smtp-Source: ABdhPJzGvyZq6vCLIF41axgLjqGdRUNBypOUw8jpGWw3FOygNXgHuri6S+XkuESukjjLERxhlowmug==
X-Received: by 2002:a37:434b:: with SMTP id q72mr18286532qka.352.1589828855547;
        Mon, 18 May 2020 12:07:35 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id a1sm9862811qtj.65.2020.05.18.12.07.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 12:07:35 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [PATCH 24/24] efi/libstub: Use snprintf with %ls to convert the command line
Date:   Mon, 18 May 2020 15:07:16 -0400
Message-Id: <20200518190716.751506-25-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200518190716.751506-1-nivedita@alum.mit.edu>
References: <20200518190716.751506-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Now we can use snprintf to do the UTF-16 to UTF-8 translation for the
command line.

Drop the special "zero" trick to handle an empty command line. This was
unnecessary even before this since with options_chars == 0,
efi_utf16_to_utf8 would not have accessed options at all. snprintf won't
access it either with a precision of 0.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 .../firmware/efi/libstub/efi-stub-helper.c    | 68 ++-----------------
 1 file changed, 7 insertions(+), 61 deletions(-)

diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index 01476d8f8edf..e3324f7b38b8 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -205,46 +205,6 @@ efi_status_t efi_parse_options(char const *cmdline)
 	return EFI_SUCCESS;
 }
 
-/*
- * Convert an UTF-16 string, not necessarily null terminated, to UTF-8.
- */
-static u8 *efi_utf16_to_utf8(u8 *dst, const u16 *src, int n)
-{
-	unsigned int c;
-
-	while (n--) {
-		c = *src++;
-		if (n && c >= 0xd800 && c <= 0xdbff &&
-		    *src >= 0xdc00 && *src <= 0xdfff) {
-			c = 0x10000 + ((c & 0x3ff) << 10) + (*src & 0x3ff);
-			src++;
-			n--;
-		}
-		if (c >= 0xd800 && c <= 0xdfff)
-			c = 0xfffd; /* Unmatched surrogate */
-		if (c < 0x80) {
-			*dst++ = c;
-			continue;
-		}
-		if (c < 0x800) {
-			*dst++ = 0xc0 + (c >> 6);
-			goto t1;
-		}
-		if (c < 0x10000) {
-			*dst++ = 0xe0 + (c >> 12);
-			goto t2;
-		}
-		*dst++ = 0xf0 + (c >> 18);
-		*dst++ = 0x80 + ((c >> 12) & 0x3f);
-	t2:
-		*dst++ = 0x80 + ((c >> 6) & 0x3f);
-	t1:
-		*dst++ = 0x80 + (c & 0x3f);
-	}
-
-	return dst;
-}
-
 /*
  * Convert the unicode UEFI command line to ASCII to pass to kernel.
  * Size of memory allocated return in *cmd_line_len.
@@ -254,18 +214,15 @@ char *efi_convert_cmdline(efi_loaded_image_t *image,
 			  int *cmd_line_len, unsigned long max_addr)
 {
 	const u16 *s2;
-	u8 *s1 = NULL;
 	unsigned long cmdline_addr = 0;
-	int load_options_chars = efi_table_attr(image, load_options_size) / 2;
+	int options_chars = efi_table_attr(image, load_options_size) / 2;
 	const u16 *options = efi_table_attr(image, load_options);
 	int options_bytes = 0;  /* UTF-8 bytes */
-	int options_chars = 0;  /* UTF-16 chars */
 	efi_status_t status;
-	u16 zero = 0;
 
 	if (options) {
 		s2 = options;
-		while (options_chars < load_options_chars) {
+		while (options_chars--) {
 			u16 c = *s2++;
 
 			if (c == L'\0' || c == L'\n')
@@ -276,7 +233,6 @@ char *efi_convert_cmdline(efi_loaded_image_t *image,
 			 * The first part handles everything in the BMP.
 			 */
 			options_bytes += 1 + (c >= 0x80) + (c >= 0x800);
-			options_chars++;
 			/*
 			 * Add one more byte for valid surrogate pairs. Invalid
 			 * surrogates will be replaced with 0xfffd and take up
@@ -288,35 +244,25 @@ char *efi_convert_cmdline(efi_loaded_image_t *image,
 				 * we must ignore it since we can't access the
 				 * low surrogate.
 				 */
-				if (options_chars == load_options_chars) {
+				if (!options_chars)
 					options_bytes -= 3;
-					options_chars--;
-					break;
-				} else if ((*s2 & 0xfc00) == 0xdc00) {
+				else if ((*s2 & 0xfc00) == 0xdc00) {
 					options_bytes++;
-					options_chars++;
+					options_chars--;
 					s2++;
 				}
 			}
 		}
 	}
 
-	if (!options_chars) {
-		/* No command line options, so return empty string*/
-		options = &zero;
-	}
-
 	options_bytes++;	/* NUL termination */
 
 	status = efi_allocate_pages(options_bytes, &cmdline_addr, max_addr);
 	if (status != EFI_SUCCESS)
 		return NULL;
 
-	s1 = (u8 *)cmdline_addr;
-	s2 = (const u16 *)options;
-
-	s1 = efi_utf16_to_utf8(s1, s2, options_chars);
-	*s1 = '\0';
+	snprintf((char *)cmdline_addr, options_bytes,
+		 "%.*ls", options_bytes-1, options);
 
 	*cmd_line_len = options_bytes;
 	return (char *)cmdline_addr;
-- 
2.26.2

