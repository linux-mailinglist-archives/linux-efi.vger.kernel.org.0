Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1329266E0A3
	for <lists+linux-efi@lfdr.de>; Tue, 17 Jan 2023 15:29:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231661AbjAQO3E (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 17 Jan 2023 09:29:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232692AbjAQO2c (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 17 Jan 2023 09:28:32 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA45914481
        for <linux-efi@vger.kernel.org>; Tue, 17 Jan 2023 06:27:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 72208B8164E
        for <linux-efi@vger.kernel.org>; Tue, 17 Jan 2023 14:27:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88326C433F1;
        Tue, 17 Jan 2023 14:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673965655;
        bh=at5daBIYclFSc720o8eNGxPkszsuMCaZodHbMl2VuNQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rY985D7b21H1aj4afRocsRRk2Q4pQqgufD50wFCmUF3Je4lCnE7qLfSe45W8cmGNT
         AQlXr4riVBmzN0Nbzl0Qd/Z1iNicq1aIhHDxX4jEHlPze3JIBpNYS4gVEaOjPROitg
         zRF1T3t3FTG4Kq8hL2g3SdkibRuoKtwobYiMen9VctciCmTfX+KKjDf2enCDNLQW6f
         AMV2+EVtuX+fwd+29utn/i9YtJOW5nkfJxLf4iG/5AetQAzfVYPTEwqZS97Cvg1b0q
         q9xoRrZQof6OfbAfJrAUXDDv9IskiKqS8OGPEKwjO/tOViRoZwAN80/0llkGW1eI1D
         JEcpCHMb0h4wQ==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Steev Klimaszewski <steev@kali.org>,
        Shawn Guo <shawn.guo@linaro.org>
Subject: [RFT PATCH 1/2] arm64: efi: Prefer a flat virtual mapping of the runtime services
Date:   Tue, 17 Jan 2023 15:27:17 +0100
Message-Id: <20230117142718.564299-2-ardb@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230117142718.564299-1-ardb@kernel.org>
References: <20230117142718.564299-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1866; i=ardb@kernel.org; h=from:subject; bh=at5daBIYclFSc720o8eNGxPkszsuMCaZodHbMl2VuNQ=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjxrBDVPNsFo47Pm6ql6dwsBM5Nx3PKVwlp6CtTTHY MGa9YoCJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCY8awQwAKCRDDTyI5ktmPJOsvDA C9kurjZydKeMEvvrS1NhLllsLLPfbNFzceCgAnBptA2ks/revipjbhgGNpfP7sS8SflOLsK2kVVWR+ GHIHFEUC/2z3fWtxnR3IjeXVCxtanHXN9kbMnjB+ZBEq2YTFtsAv1W7tSObAJyR9jsDsDTJ0wlhXua ZBHEfROYAUXse/9/wy3+Vjazcmgs6+NKKE83i/Eoxqj8uKCH72OzkXtZHIVSg9btfPKtsD4KPsszWJ 81DCH2tsncjawLPZmHS3VAV1q7fitP94sCgseih+mRkM4vf5hpTl4lVQYvztnJb81ELe2jcSP61wG/ ofwtEfz4wG/f6t91OlvIASRbfxiT6TlFVUbTAu1TedCqIPnbGnAiT75YKaM4Cvvo6qFPaPaAjuXBEm qUON5PL2N4wBX2a4UUy6U7vWmF6qmC2nq/eUZbXueDtnIEzFKMms4BclZQJ0VBiqwUjhH090JIT3z8 3WvmoxeJrKDGeGhQpBMfyYXRDLPedAiRMY1ZpJ/hGhimk=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

With some systems, we cannot omit the boot time call to
SetVirtualAddressMap() even if the kernel VA space is sufficiently
large, because some buggy EFI implementations exist that misbehave if
SetVirtualAddressMap() is never called.

However, this does not mean we must reshuffle the EFI memory map: we can
simply invoke SetVirtualAddressMap() with a memory map that places each
EFI runtime region at the same virtual address that it takes up in the
physical address map.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/include/asm/efi.h            | 2 ++
 drivers/firmware/efi/libstub/efi-stub.c | 6 +++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/efi.h b/arch/arm64/include/asm/efi.h
index de4ff90785b2c96a..98c4dc4da5a90e8c 100644
--- a/arch/arm64/include/asm/efi.h
+++ b/arch/arm64/include/asm/efi.h
@@ -114,6 +114,8 @@ static inline unsigned long efi_get_kimg_min_align(void)
 #define EFI_ALLOC_ALIGN		SZ_64K
 #define EFI_ALLOC_LIMIT		((1UL << 48) - 1)
 
+#define EFI_USE_FLAT_VA_MAPPING	(VA_BITS_MIN >= 48)
+
 /*
  * On ARM systems, virtually remapped UEFI runtime services are set up in two
  * distinct stages:
diff --git a/drivers/firmware/efi/libstub/efi-stub.c b/drivers/firmware/efi/libstub/efi-stub.c
index 2955c1ac6a36ee00..40869320d601492a 100644
--- a/drivers/firmware/efi/libstub/efi-stub.c
+++ b/drivers/firmware/efi/libstub/efi-stub.c
@@ -44,8 +44,12 @@
 #define EFI_RT_VIRTUAL_OFFSET	0
 #endif
 
+#ifndef EFI_USE_FLAT_VA_MAPPING
+#define EFI_USE_FLAT_VA_MAPPING	(EFI_RT_VIRTUAL_OFFSET != 0)
+#endif
+
 static u64 virtmap_base = EFI_RT_VIRTUAL_BASE;
-static bool flat_va_mapping = (EFI_RT_VIRTUAL_OFFSET != 0);
+static bool flat_va_mapping = EFI_USE_FLAT_VA_MAPPING;
 
 struct screen_info * __weak alloc_screen_info(void)
 {
-- 
2.39.0

