Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDFC118C057
	for <lists+linux-efi@lfdr.de>; Thu, 19 Mar 2020 20:29:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728093AbgCST3f (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 19 Mar 2020 15:29:35 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:41086 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727721AbgCST3G (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 19 Mar 2020 15:29:06 -0400
Received: by mail-qk1-f195.google.com with SMTP id s11so4398233qks.8;
        Thu, 19 Mar 2020 12:29:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2CiSuKaNodoKyjnGemNKoIzUpiAYvV52BwWj4otjji0=;
        b=lRHlKMhbrRb01jT25sqpnqPRK8ello5cKqPBZVxcHNkGQbpdOqsqwFK6uMnLnMJVzI
         dlEfxjd3lyH05V/AruZ2gTibT+TKqRiSXZfI6x5AIByBcHLXQUj6sfyYd9/Zh5/9xrSu
         uLOOlZ9P4fpLYaayPWNM9fQPfavWKPKQQ+ki2ccsr3ZW1VWDFSsJcmtUC8Soa45KSvgT
         uQlEejJAwZXLHKTSdHs/Zjqf1/NvXsEjgwt+40s68I0GZfukNZZePlVQgtrGi4mDZsB4
         WyRyePiy57hOcrD5xYlDQDq6C9CksYmIJBk5f1fDwL6iVU5gS4Mq1pekWpsrUZfPsQAz
         DpiQ==
X-Gm-Message-State: ANhLgQ3QAw2FDScLyoZ+mv8R3m1Yy4xDttuuXNPzOu2fEl2VaX1eJ6OH
        bNEo1HwXFtb7fnhbMP8o2iA=
X-Google-Smtp-Source: ADFU+vsF4algkLeM+wEB0rtZUc61drslQA9sQtOPkswLxQEGPHbEoX9OAcoSQcMqreoK/ZJ44orDSg==
X-Received: by 2002:a37:981:: with SMTP id 123mr4653512qkj.154.1584646145999;
        Thu, 19 Mar 2020 12:29:05 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id x89sm2292649qtd.43.2020.03.19.12.29.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 12:29:05 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 10/14] efi/gop: Add prototypes for query_mode and set_mode
Date:   Thu, 19 Mar 2020 15:28:51 -0400
Message-Id: <20200319192855.29876-11-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200319192855.29876-1-nivedita@alum.mit.edu>
References: <20200319192855.29876-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Add prototypes and argmap for the Graphics Output Protocol's QueryMode
and SetMode functions.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 arch/x86/include/asm/efi.h             | 4 ++++
 drivers/firmware/efi/libstub/efistub.h | 6 ++++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
index cdcf48d52a12..781170d36f50 100644
--- a/arch/x86/include/asm/efi.h
+++ b/arch/x86/include/asm/efi.h
@@ -305,6 +305,10 @@ static inline u32 efi64_convert_status(efi_status_t status)
 #define __efi64_argmap_load_file(protocol, path, policy, bufsize, buf)	\
 	((protocol), (path), (policy), efi64_zero_upper(bufsize), (buf))
 
+/* Graphics Output Protocol */
+#define __efi64_argmap_query_mode(gop, mode, size, info)		\
+	((gop), (mode), efi64_zero_upper(size), efi64_zero_upper(info))
+
 /*
  * The macros below handle the plumbing for the argument mapping. To add a
  * mapping for a specific EFI method, simply define a macro
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index cc90a748bcf0..c400fd88fe38 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -298,8 +298,10 @@ typedef union efi_graphics_output_protocol efi_graphics_output_protocol_t;
 
 union efi_graphics_output_protocol {
 	struct {
-		void *query_mode;
-		void *set_mode;
+		efi_status_t (__efiapi *query_mode)(efi_graphics_output_protocol_t *,
+						    u32, unsigned long *,
+						    efi_graphics_output_mode_info_t **);
+		efi_status_t (__efiapi *set_mode)  (efi_graphics_output_protocol_t *, u32);
 		void *blt;
 		efi_graphics_output_protocol_mode_t *mode;
 	};
-- 
2.24.1

