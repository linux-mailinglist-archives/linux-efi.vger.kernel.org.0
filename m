Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF276536BD1
	for <lists+linux-efi@lfdr.de>; Sat, 28 May 2022 11:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232443AbiE1JPD (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 28 May 2022 05:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350466AbiE1JOv (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 28 May 2022 05:14:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 605B212AFF
        for <linux-efi@vger.kernel.org>; Sat, 28 May 2022 02:14:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9B75A60C5E
        for <linux-efi@vger.kernel.org>; Sat, 28 May 2022 09:14:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 528ACC34100;
        Sat, 28 May 2022 09:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653729286;
        bh=yCAE2V8GHOKSESnFT1awaNz6crl1SymY3o7FvM04iwg=;
        h=From:To:Cc:Subject:Date:From;
        b=cydht5ydijvCBAY4P2a2NPkENK9kZWkiHWkCmr+7k+9Zrj9muFkR+aJGMnXFKoT2u
         oRQMwTJ6SCTCf7OhhRMsgVre19t+o1seUP8+/h7PvhDyADfW3vg63HPeY0LxCsTcro
         CjU/YqB8j7edutrDYKxcCCNC/Zycgv79jtu7oDSS1697rNzmKFQhyVxLFOk+rgMrkA
         HBY/IAYf0f2g7rzDFZKs0aTriERgbtrq3M1p/u/3ITAWbRzrAstTKi70Qlt+akdV7t
         bMMmxe4X0vSk1y75XI4QCOJQulnZAoYqvXzwbqUEUs2mIw+0i6cDp4dBn85/+I3H0c
         IohYUyaeqAyzQ==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH] efi/x86: libstub: Make DXE calls mixed mode safe
Date:   Sat, 28 May 2022 11:14:28 +0200
Message-Id: <20220528091428.1957448-1-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2428; h=from:subject; bh=yCAE2V8GHOKSESnFT1awaNz6crl1SymY3o7FvM04iwg=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBikefwKoYsFC/EuCezbpSfS3GO/qjJo4JQgZkK35Q9 AESTGBKJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYpHn8AAKCRDDTyI5ktmPJK7zDA CFC1QoFtmiZbqtUCm3q3hxAWFkxb8U1YEdWJCApCSj1grZ7itc0Ri5QcMX9ujj8L8PZEk+2F73jNeQ pQJr2rXK/JPRLxn0hQzMAYgmvAx9ka/o0Ln2gWc9+8BGsx5sxFbLt7+lJWvu8zjOSv7JVL8c3Uo3AU C7X7gDrSR7pSlLb8D88RuKw+2SG7/tnxrKDjJ1PFmLDfp+kwl0RNaIDLHYyFEm+9S0yHSAzQ1RN5hY qmYizOwZ2blTlg6nxmwZvFuLy0UzAtaSV4Nwh9RM1vq90GyY+C50gOO/lVgNDMm5xJlXYVRifDfiEq nH4kNNFAdCPB2WWkKCymlXn24XWFbuxWCK6M21qRrUTCrq7PJ9e0+epEZuRz7h7cFp8WzixUU/2DNx NLWkYYRo4ucj04L/GYXmnk5CLlVzfN/ZFNuBpmY2Xd75owWg0A8thNF91kfFHQs9WBnFCm6wYViIDk zgbZ9HvY+8vUxlj4ttsY3S0f/iBHPLUpFfGtsLZ57IXTs=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The newly added DXE calls use 64-bit quantities, which means we need to
marshall them explicitly when running in mixed mode. Currently, we get
away without it because we just bail when GetMemorySpaceDescriptor()
fails, which is guaranteed to happen due to the function argument mixup.

Let's fix this properly, though, by defining the macros that describe
how to marshall the arguments. While at it, drop an incorrect cast on a
status variable.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/include/asm/efi.h              | 9 +++++++++
 drivers/firmware/efi/libstub/x86-stub.c | 4 ++--
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
index bed74a0f2932..71943dce691e 100644
--- a/arch/x86/include/asm/efi.h
+++ b/arch/x86/include/asm/efi.h
@@ -270,6 +270,8 @@ static inline u32 efi64_convert_status(efi_status_t status)
 	return (u32)(status | (u64)status >> 32);
 }
 
+#define __efi64_split(val)		(val) & U32_MAX, (u64)(val) >> 32
+
 #define __efi64_argmap_free_pages(addr, size)				\
 	((addr), 0, (size))
 
@@ -317,6 +319,13 @@ static inline u32 efi64_convert_status(efi_status_t status)
 #define __efi64_argmap_hash_log_extend_event(prot, fl, addr, size, ev)	\
 	((prot), (fl), 0ULL, (u64)(addr), 0ULL, (u64)(size), 0ULL, ev)
 
+/* DXE services */
+#define __efi64_argmap_get_memory_space_descriptor(phys, desc) \
+	(__efi64_split(phys), (desc))
+
+#define __efi64_argmap_set_memory_space_descriptor(phys, size, flags) \
+	(__efi64_split(phys), __efi64_split(size), __efi64_split(flags))
+
 /*
  * The macros below handle the plumbing for the argument mapping. To add a
  * mapping for a specific EFI method, simply define a macro
diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index b14e88ccefca..05ae8bcc9d67 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -260,10 +260,10 @@ adjust_memory_range_protection(unsigned long start, unsigned long size)
 				      EFI_MEMORY_WB);
 
 		if (status != EFI_SUCCESS) {
-			efi_warn("Unable to unprotect memory range [%08lx,%08lx]: %d\n",
+			efi_warn("Unable to unprotect memory range [%08lx,%08lx]: %lx\n",
 				 unprotect_start,
 				 unprotect_start + unprotect_size,
-				 (int)status);
+				 status);
 		}
 	}
 }
-- 
2.30.2

