Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62E7D1D87EA
	for <lists+linux-efi@lfdr.de>; Mon, 18 May 2020 21:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbgERTHh (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 18 May 2020 15:07:37 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:42519 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726596AbgERTHe (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 18 May 2020 15:07:34 -0400
Received: by mail-qk1-f193.google.com with SMTP id s1so11439866qkf.9
        for <linux-efi@vger.kernel.org>; Mon, 18 May 2020 12:07:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w+iG1P6JmDBl3cKGR2MtVKJJGjxVfQhIfjLESQws+zM=;
        b=CnDbQgaIZPDCO5C/bDVyLl91HU9Sc3NYfmepyRTX29FFyynP25PvhmNogREGRhW2NJ
         JySO2FA8UrWZ7O8JGLY00xzJmHfUYzy8CgB0ZE1pev1x6oiGjiei3vj+lAWSuqFeyEtk
         zY5QsSylL2p+DzJ7ck2lvp5zzibiUNl1/TBbdoiwCm7yy7GF0u03qxLWhH5UqcWIaPb7
         mFxcOnO1weiUSLVOF2SvvW/EfA5DJYH5aJxe0YxRe+GOhwientG8HkDttNQsoFJplumX
         Fv1aMRw6P3+N9J3uksnWipdU+TbQmB5Y74049vEDzWwXZJpy0eHO25aFD5sHkvcgkSSt
         LVGQ==
X-Gm-Message-State: AOAM533Xk+Qcg7qsaeHNhTZlkv+GXUqpSX9s33m9EWWgtJDOTMnBSudP
        rfgfkYYo1/GUlJfF9wbAfzE=
X-Google-Smtp-Source: ABdhPJxdv8jCzWl2XhXXaDGnWF5HxkVmU2ko4k12CdLrUkSl1UheWSx2KzmQmFX1TUNLBtG/XjiRCw==
X-Received: by 2002:a37:61d8:: with SMTP id v207mr16461775qkb.146.1589828853692;
        Mon, 18 May 2020 12:07:33 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id a1sm9862811qtj.65.2020.05.18.12.07.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 12:07:33 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [PATCH 21/24] efi/libstub: Add UTF-8 decoding to efi_puts
Date:   Mon, 18 May 2020 15:07:13 -0400
Message-Id: <20200518190716.751506-22-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200518190716.751506-1-nivedita@alum.mit.edu>
References: <20200518190716.751506-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

In order to be able to use the UTF-16 support added to vsprintf in the
previous commit, enhance efi_puts to decode UTF-8 into UTF-16. Invalid
UTF-8 encodings are passed through unchanged.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 .../firmware/efi/libstub/efi-stub-helper.c    | 67 +++++++++++++++++--
 1 file changed, 62 insertions(+), 5 deletions(-)

diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index a36f3af6e130..48242bc982a3 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -36,17 +36,74 @@ void efi_char16_puts(efi_char16_t *str)
 		       output_string, str);
 }
 
+static
+u32 utf8_to_utf32(const u8 **s8)
+{
+	u32 c32;
+	u8 c0, cx;
+	size_t clen, i;
+
+	c0 = cx = *(*s8)++;
+	/*
+	 * The position of the most-significant 0 bit gives us the length of
+	 * a multi-octet encoding.
+	 */
+	for (clen = 0; cx & 0x80; ++clen)
+		cx <<= 1;
+	/*
+	 * If the 0 bit is in position 8, this is a valid single-octet
+	 * encoding. If the 0 bit is in position 7 or positions 1-3, the
+	 * encoding is invalid.
+	 * In either case, we just return the first octet.
+	 */
+	if (clen < 2 || clen > 4)
+		return c0;
+	/* Get the bits from the first octet. */
+	c32 = cx >> clen--;
+	for (i = 0; i < clen; ++i) {
+		/* Trailing octets must have 10 in most significant bits. */
+		cx = (*s8)[i] ^ 0x80;
+		if (cx & 0xc0)
+			return c0;
+		c32 = (c32 << 6) | cx;
+	}
+	/*
+	 * Check for validity:
+	 * - The character must be in the Unicode range.
+	 * - It must not be a surrogate.
+	 * - It must be encoded using the correct number of octets.
+	 */
+	if (c32 > 0x10ffff ||
+	    (c32 & 0xf800) == 0xd800 ||
+	    clen != (c32 >= 0x80) + (c32 >= 0x800) + (c32 >= 0x10000))
+		return c0;
+	*s8 += clen;
+	return c32;
+}
+
 void efi_puts(const char *str)
 {
 	efi_char16_t buf[128];
 	size_t pos = 0, lim = ARRAY_SIZE(buf);
+	const u8 *s8 = (const u8 *)str;
+	u32 c32;
 
-	while (*str) {
-		if (*str == '\n')
+	while (*s8) {
+		if (*s8 == '\n')
 			buf[pos++] = L'\r';
-		/* Cast to unsigned char to avoid sign-extension */
-		buf[pos++] = (unsigned char)(*str++);
-		if (*str == '\0' || pos >= lim - 2) {
+		c32 = utf8_to_utf32(&s8);
+		if (c32 < 0x10000)
+			/* Characters in plane 0 use a single word. */
+			buf[pos++] = c32;
+		else {
+			/*
+			 * Characters in other planes encode into a surrogate
+			 * pair.
+			 */
+			buf[pos++] = (0xd800 - (0x10000 >> 10)) + (c32 >> 10);
+			buf[pos++] = 0xdc00 + (c32 & 0x3ff);
+		}
+		if (*s8 == '\0' || pos >= lim - 2) {
 			buf[pos] = L'\0';
 			efi_char16_puts(buf);
 			pos = 0;
-- 
2.26.2

