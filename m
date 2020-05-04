Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 866231C3DFF
	for <lists+linux-efi@lfdr.de>; Mon,  4 May 2020 17:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728165AbgEDPCw (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 4 May 2020 11:02:52 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:35305 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727884AbgEDPCw (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 4 May 2020 11:02:52 -0400
Received: by mail-qk1-f193.google.com with SMTP id f13so5478819qkh.2
        for <linux-efi@vger.kernel.org>; Mon, 04 May 2020 08:02:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L+RfquI3dSeK53Rjy2yM8mHDf4XUnTp57qliNzTcHXM=;
        b=uZ2f38sb5RZIAgiEO1dpd4RjLCtqSUGn8/UPhxNyUrulKhV4CijfSFayUFcGDHWLUW
         rkrCpvAUDE4BbMMWLuyaDloKu5beNDniVSWIbVW2bLguMOofUkrdqys6ezWgTCk5ETPt
         8E/QA2KfIcE1hjNMPwTXNrmOkIJcwC2y7B+5CUWHf/RRSmHE5PCOtRZmvTz3HLD8MV2B
         91xBtC0pAbCPioEL5m6tBEQuo9NaL3FXd/tNgbySzg6sPCdyNNHBLpENf535i95ISM6z
         Iu++2kkevjsDNWoIboOLR/fQ5m1kauUDhexXryhRv0vTPiWH5NTX1tbEdn9beGze98DB
         Daqg==
X-Gm-Message-State: AGi0Pua0wojp9uZ5fiy1dUyGAEgiuXILTKy1apY/mW8DGgOaL3JNxXwD
        ln5gtkWnebZXd+X5IknH9koe6HL2RYs=
X-Google-Smtp-Source: APiQypKfvmlWgvYc8VLbK99lTmpkvtmZHY0X1y2vB+w/AprtUdGFSOiZAQRYvmpxYZuIx5j3QgTSqQ==
X-Received: by 2002:a05:620a:1101:: with SMTP id o1mr1470690qkk.387.1588604570604;
        Mon, 04 May 2020 08:02:50 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id g8sm9170449qtq.27.2020.05.04.08.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 08:02:49 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v2] efi/libstub: Fix mixed mode boot issue after macro refactor
Date:   Mon,  4 May 2020 11:02:48 -0400
Message-Id: <20200504150248.62482-1-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <CAMj1kXES5qXEdtHCUoV8Oy6ZukWL=iQh+ppVo777LNtRG+kH6A@mail.gmail.com>
References: <CAMj1kXES5qXEdtHCUoV8Oy6ZukWL=iQh+ppVo777LNtRG+kH6A@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Commit
  22090f84bc3f ("efi/libstub: unify EFI call wrappers for non-x86")

refactored the macros that are used to provide wrappers for mixed-mode
calls on x86, allowing us to boot a 64-bit kernel on 32-bit firmware.

Unfortunately, this broke mixed mode boot due to the fact that
efi_is_native() is not a macro on x86.

All of these macros should go together, so rather than testing each one
to see if it is defined, condition the generic macro definitions on a
new ARCH_HAS_EFISTUB_WRAPPERS, and remove the wrapper definitions on x86
as well if CONFIG_EFI_MIXED is not enabled.

Fixes: 22090f84bc3f ("efi/libstub: unify EFI call wrappers for non-x86")
Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 arch/x86/include/asm/efi.h             | 19 +++++++++++++++----
 drivers/firmware/efi/libstub/efistub.h | 14 ++++----------
 2 files changed, 19 insertions(+), 14 deletions(-)

diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
index cd0c3fbf6156..6b9ab0d8b2a7 100644
--- a/arch/x86/include/asm/efi.h
+++ b/arch/x86/include/asm/efi.h
@@ -225,13 +225,15 @@ efi_status_t efi_set_virtual_address_map(unsigned long memory_map_size,
 
 /* arch specific definitions used by the stub code */
 
-extern const bool efi_is64;
+#ifdef CONFIG_EFI_MIXED
+
+#define ARCH_HAS_EFISTUB_WRAPPERS
 
 static inline bool efi_is_64bit(void)
 {
-	if (IS_ENABLED(CONFIG_EFI_MIXED))
-		return efi_is64;
-	return IS_ENABLED(CONFIG_X86_64);
+	extern const bool efi_is64;
+
+	return efi_is64;
 }
 
 static inline bool efi_is_native(void)
@@ -356,6 +358,15 @@ static inline u32 efi64_convert_status(efi_status_t status)
 						   runtime),		\
 				    func, __VA_ARGS__))
 
+#else /* CONFIG_EFI_MIXED */
+
+static inline bool efi_is_64bit(void)
+{
+	return IS_ENABLED(CONFIG_X86_64);
+}
+
+#endif /* CONFIG_EFI_MIXED */
+
 extern bool efi_reboot_required(void);
 extern bool efi_is_table_address(unsigned long phys_addr);
 
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index 874233cf8820..4f10a09563f3 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -33,20 +33,14 @@ extern bool efi_novamap;
 
 extern const efi_system_table_t *efi_system_table;
 
-#ifndef efi_bs_call
+#ifndef ARCH_HAS_EFISTUB_WRAPPERS
+
+#define efi_is_native()		(true)
 #define efi_bs_call(func, ...)	efi_system_table->boottime->func(__VA_ARGS__)
-#endif
-#ifndef efi_rt_call
 #define efi_rt_call(func, ...)	efi_system_table->runtime->func(__VA_ARGS__)
-#endif
-#ifndef efi_is_native
-#define efi_is_native()		(true)
-#endif
-#ifndef efi_table_attr
 #define efi_table_attr(inst, attr)	(inst->attr)
-#endif
-#ifndef efi_call_proto
 #define efi_call_proto(inst, func, ...) inst->func(inst, ##__VA_ARGS__)
+
 #endif
 
 #define efi_info(msg)		do {			\
-- 
2.26.2

