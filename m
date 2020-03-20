Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D3E318C514
	for <lists+linux-efi@lfdr.de>; Fri, 20 Mar 2020 03:01:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbgCTCBG (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 19 Mar 2020 22:01:06 -0400
Received: from mail-qv1-f65.google.com ([209.85.219.65]:33416 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727495AbgCTCAj (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 19 Mar 2020 22:00:39 -0400
Received: by mail-qv1-f65.google.com with SMTP id cz10so2215565qvb.0;
        Thu, 19 Mar 2020 19:00:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2CiSuKaNodoKyjnGemNKoIzUpiAYvV52BwWj4otjji0=;
        b=SbujHbbC3l7V0tdYekxluu1+Eqzu+qdK5JusSAPVsLsOUg2Pp9aD090//Pdfjk3bLh
         GC8O6zMKvevHuBOOCT+VU19Wp+Ns4GkSC8ACmUJFywoZC6tUfGDi+2vJrWp9d+ZFRXbs
         Kf2uuMfB28cAJUF2lpirdssiiRv2/q+BKnMYKsA9tarmN6gNcVihOtc8rLFYGFmk7n3B
         WA0ZeiU9KE1X7+pCVjn+n7VW2xcdaDy26ha2UwCeWmKieKegEkWja9Jvnltg7CSaTV5k
         IjHyIDIlnFCJjbvzrujmlar1/fgcrBEhqay1/PqGlLMaWLsxvRt0r+FoLDC8LiKjABmp
         LzBQ==
X-Gm-Message-State: ANhLgQ09ZbOUALqdLHoEFDtd/J5Thn+Xt9gtJ6Dw9yeG7CINyaZdTRwh
        fVxlMDEsSVUkvPZxVaLgBT/6yKpo
X-Google-Smtp-Source: ADFU+vu/uLEb0GA1GTjWPEY73nBpCRn3qHfDnHrJbK8Bk1P+o3ZEspfpmWUQhOWyb/K08Ru4EUtaAA==
X-Received: by 2002:ad4:57b3:: with SMTP id g19mr6057877qvx.87.1584669638524;
        Thu, 19 Mar 2020 19:00:38 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id n46sm3342198qtb.48.2020.03.19.19.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 19:00:38 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 10/14] efi/gop: Add prototypes for query_mode and set_mode
Date:   Thu, 19 Mar 2020 22:00:24 -0400
Message-Id: <20200320020028.1936003-11-nivedita@alum.mit.edu>
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

