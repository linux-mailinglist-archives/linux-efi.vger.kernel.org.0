Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 715C461DF2F
	for <lists+linux-efi@lfdr.de>; Sat,  5 Nov 2022 23:52:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbiKEWwn (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 5 Nov 2022 18:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbiKEWwn (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 5 Nov 2022 18:52:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54A9812A8C
        for <linux-efi@vger.kernel.org>; Sat,  5 Nov 2022 15:52:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DBB7B60BC7
        for <linux-efi@vger.kernel.org>; Sat,  5 Nov 2022 22:52:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89B78C433D6;
        Sat,  5 Nov 2022 22:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667688761;
        bh=OdC/x6CRP1Q6DzJ2wktgiugPDGhj7AalzRHBSkGJxD0=;
        h=From:To:Cc:Subject:Date:From;
        b=LWsGaNyP/mFuyBSDsRu/CQgdNo5jg5uPDtR5AZzVl8HRSKgWJSwdYSE7jzoV8iqfP
         5dKwfDdjpWB/r4unJzVuU4Y1SbR7rm9Wyu4ao6f2dnVGJk3bwr5V8Sc/TNMtaYIN51
         hWghRW22JPMOSdOGfWSKf61xvQunzzAOVeQOJgndUzplqrUi8J0INlLIYY7LFwD589
         rwBwRg6kWJUnhw0Tc4wLm53GUhlVu4FtMxVc/HNm+PTvcGxfOVhrSzfpamWmsi2YlH
         qdfOcMKy9taU2YWaJYqmxdwRwRgZDNolytVBKGPGf2g9PWoKC28WrkFDewEg3M6CCX
         XHwWg4GCy/AMQ==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        catalin.marinas@arm.com, will@kernel.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH] arm64: efi: Make runtime region misalignment warning less noisy
Date:   Sat,  5 Nov 2022 23:52:33 +0100
Message-Id: <20221105225234.3089177-1-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2001; i=ardb@kernel.org; h=from:subject; bh=OdC/x6CRP1Q6DzJ2wktgiugPDGhj7AalzRHBSkGJxD0=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjZukx6SKgMKw3LlKkQp2pxi87rwuExZ4iSWvVGqHl 0Z0T+3OJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCY2bpMQAKCRDDTyI5ktmPJJ8LC/ 9jCy4inYywhm11pl9pnWZlsM6YNwFUKEweZhfKY5B7pLqxCWiuzyx1PNyIk3i8JcAaQsWzGQ/0WAmS WxoGi7V4VBVihq8b+5vipPh12GaM/cDAYFnMm6l0wU4EiHmkRlKnrlFtrTH9BeVmXYRKQUEnroDLRL bmx7x5rmW5Pv4ETJjrlmP7DZjbrCbzeqavKtH1C6Ge0rP0fyWaRnZpCKww2gZfOlTx8L9Xyw4y/mZK pY2IKPSua5RX4LOMPe318hoebBe/WcF1CS3WcwB/4qk7xA+hsuNGDMzum3O9B+mgXSxijBlKzy8/gc irF0aUMxJlOmodRVMP7tXLby9vt3P9WLRYIf9Juqc228LT8jOnHOSe++brsVBPRJq3jSLbz71eHd3u hhzhskPxpTSvXMn7QtPU/spCQK2lhFRnzdqtRKTi9c8pWvDTanE6SFJ++7Qj+JOVKnzL4MCVIKQtiL jpo9KZWMyNs0GbxXIbQaslUFlP/UZPyQpJB+6aNVS2ALk=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The EFI spec requires that on arm64 systems, all runtime code and data
regions that share a 64k page can be mapped with the same memory type
attributes. Unfortunately, this does not take permission attributes into
account, and so the firmware is permitted to expose runtime code and
data regions that share 64k pages, and this may prevent the OS from
using restricted permissions in such cases, e.g., map data regions with
non-exec attributes.

We currently emit a warning when hitting this at boot, but the warning
is problematic for a number of reasons:
- it uses WARN() which spews a lot of irrelevant information into the
  log about the execution context where the issue was detected;
- it only takes the start of the region into account and not the size

Let's just drop the warning, as the condition does not strictly violate
the spec (although it only occurs with U-Boot), and fix the check to
take both the start and the end addresses into account.

Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/kernel/efi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/efi.c b/arch/arm64/kernel/efi.c
index e1be6c429810d0d5..3dd6f0c66f8aeb78 100644
--- a/arch/arm64/kernel/efi.c
+++ b/arch/arm64/kernel/efi.c
@@ -25,8 +25,8 @@ static __init pteval_t create_mapping_protection(efi_memory_desc_t *md)
 	if (type == EFI_MEMORY_MAPPED_IO)
 		return PROT_DEVICE_nGnRE;
 
-	if (WARN_ONCE(!PAGE_ALIGNED(md->phys_addr),
-		      "UEFI Runtime regions are not aligned to 64 KB -- buggy firmware?"))
+	if (!PAGE_ALIGNED(md->phys_addr) ||
+	    !PAGE_ALIGNED(md->num_pages * EFI_PAGE_SIZE))
 		/*
 		 * If the region is not aligned to the page size of the OS, we
 		 * can not use strict permissions, since that would also affect
-- 
2.35.1

