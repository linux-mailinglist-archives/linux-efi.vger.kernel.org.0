Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B7E81750C4
	for <lists+linux-efi@lfdr.de>; Mon,  2 Mar 2020 00:04:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbgCAXEj (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 1 Mar 2020 18:04:39 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:45462 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbgCAXEj (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 1 Mar 2020 18:04:39 -0500
Received: by mail-qt1-f195.google.com with SMTP id a4so244113qto.12;
        Sun, 01 Mar 2020 15:04:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C2HmEVacpCeNVROWUW3imBIREt8ehqj0b5VDMkdPw9g=;
        b=uKI6U92EZYcHCCb0jX8ilfYbBk6QChOAj9hZbwVW0x5aQtyUP+OYzKb9HC/jpn6Z7u
         k337mf907/SGfm0Apy21GNO22NTyUzvXxMOWPtY1OwKfzzM4KKnC3CDZmduhIWOYTMQb
         Tv/nzYgQEaFQcjQ3Yvu2sO3g8bI92CpnH0niW21dBoZb3hWaWN/oDK1D6cXDOkqWVd3c
         lxL1Od/I3c2C+6LhJtAu81rdmY6IKMYtCKmEFwqcxcsqTCymdJ8Am4AZsEumVXebpEay
         sfrO1nSJps7SVfarx0FESjjJX7UXyC7jVQxmlj8/GW14TG0lfcgvYiDxTeQo0V3issMG
         6UiA==
X-Gm-Message-State: ANhLgQ2GtE9pfuQgXPzoAje0aUThKTvAahn7Bbfqb1/CLbCmRL2aGYnE
        GW3Y0MEOnJJ5mp320jriboQ=
X-Google-Smtp-Source: ADFU+vs+PYZdoswlZQRkLI8zoJa2RTwrXRH+5MMYD0Umhz5klBjre82JQyqQzhESv7qRXH0jAQcd4g==
X-Received: by 2002:ac8:4d4b:: with SMTP id x11mr3034758qtv.171.1583103878384;
        Sun, 01 Mar 2020 15:04:38 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id n138sm9065082qkn.33.2020.03.01.15.04.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2020 15:04:37 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] efi/x86: Annotate the LOADED_IMAGE_PROTOCOL_GUID with SYM_DATA
Date:   Sun,  1 Mar 2020 18:04:32 -0500
Message-Id: <20200301230436.2246909-2-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200301230436.2246909-1-nivedita@alum.mit.edu>
References: <20200301230436.2246909-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Use SYM_DATA* macro to annotate this constant, and explicitly align it
to 4-byte boundary. Use lower-case for hexadecimal data.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 arch/x86/boot/compressed/head_64.S | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index fcf8feaa57ea..8105e8348607 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -672,7 +672,7 @@ SYM_FUNC_START(efi32_pe_entry)
 	/* Get the loaded image protocol pointer from the image handle */
 	subl	$12, %esp			// space for the loaded image pointer
 	pushl	%esp				// pass its address
-	leal	4f(%ebp), %eax
+	leal	loaded_image_proto(%ebp), %eax
 	pushl	%eax				// pass the GUID address
 	pushl	28(%esp)			// pass the image handle
 
@@ -695,9 +695,12 @@ SYM_FUNC_END(efi32_pe_entry)
 
 	.section ".rodata"
 	/* EFI loaded image protocol GUID */
-4:	.long	0x5B1B31A1
+	.balign 4
+SYM_DATA_START_LOCAL(loaded_image_proto)
+	.long	0x5b1b31a1
 	.word	0x9562, 0x11d2
-	.byte	0x8E, 0x3F, 0x00, 0xA0, 0xC9, 0x69, 0x72, 0x3B
+	.byte	0x8e, 0x3f, 0x00, 0xa0, 0xc9, 0x69, 0x72, 0x3b
+SYM_DATA_END(loaded_image_proto)
 #endif
 
 /*
-- 
2.24.1

