Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF68E5BAB55
	for <lists+linux-efi@lfdr.de>; Fri, 16 Sep 2022 12:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbiIPKe3 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 16 Sep 2022 06:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231837AbiIPKd3 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 16 Sep 2022 06:33:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A6E36394
        for <linux-efi@vger.kernel.org>; Fri, 16 Sep 2022 03:19:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6C91FB82572
        for <linux-efi@vger.kernel.org>; Fri, 16 Sep 2022 10:19:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5229EC433C1;
        Fri, 16 Sep 2022 10:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663323541;
        bh=ArJ0Aq/uRByH2p0oRANc/9e+rySb1VN37gb9AK9FVJs=;
        h=From:To:Cc:Subject:Date:From;
        b=mMPeKsbu6S6MdnWzvPnhv7WHA/bN5bCLuUKuYJaO/7FdncJX00DMYgg2XZPsSzFbh
         8EMaYvWP8/il9pUN0zOujgMWQjPPgxccR0BeOlWhf4jtv6W+5N9fFDxeYWddNnV1N2
         5zTGqWw2szXmrQOj819QfqRbD2IjlkdFoBtl2FCbX6XyEx/pbvBy5lfrXKjJyorpw6
         4Bx0tFRmcNX8XqVZZ/QAFJ2sXpLuTRaheDrbs8Vk7QgoldtwXt3cE6yY3iEwX7Dvff
         1PrS4RchaSRAjpmgpiemD4b2ToGCU6NiHgTX5VRPkCnROy0HyO/O/NlHCjXDhRhI9h
         6ULs8T9sOJSfg==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com,
        probinson@gmail.com, andersson@kernel.org, catalin.marinas@arm.com,
        will@kernel.org, Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH] efi/libstub: arm64: avoid SetVirtualAddressMap() when possible
Date:   Fri, 16 Sep 2022 12:18:43 +0200
Message-Id: <20220916101843.495879-1-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1930; i=ardb@kernel.org; h=from:subject; bh=ArJ0Aq/uRByH2p0oRANc/9e+rySb1VN37gb9AK9FVJs=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjJE2Cou4slodCTvcpov6C34JFi70JaD9PhOanWIgf 4MTLxeuJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYyRNggAKCRDDTyI5ktmPJCKeC/ 0ekQEjJgqxQ8MOatq+grhrCBtZdiKr2ORm88O4fFCt1m3pnNANNV47MMv95sgFVAIVP2nEuZ9+jSsn ROwJ/n8wJ0mPEemybS8u2NwDuU2oLdiHr3W5K09sLc9fRGGVEeT5rGvBZW9i2neu0PhFuyrXeq0lx+ pa0KDWnDbq41ItwyyTTwk6P/UPOwojKwb9sQF/wZgAfltLb5h3vMCMk9uRz1mSkw7YyJ4woqGWI2h/ dS5Hk0XO1JynK71+d7TGieQztW61kY+EoOOD2FiAHoFQkBfnrZzRUIUId+LDwNJTU02C2uFyUPf73b 5yZH/UJOkDH4ozgKxdB4MlhHF0xr4f0xBT/USKlvy1k4R37EBu1CBwq8rKonPDstkiXcO/qpzeVTnC Rt1zQmbKNRTQ8M6zWOsATPHC4TMAVcxn3BAw0Qn9qvLe2SZ5BeXDSOr48iy9ddi9m7RDLqtpH+rJzh t8FWWoMWnH3o0Gu1aAB1xPzgLqGksHUJ+tiXkAZabVh1w=
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

EFI's SetVirtualAddressMap() runtime service is a horrid hack that we'd
like to avoid using, if possible. For 64-bit architectures such as
arm64, the user and kernel mappings are entirely disjoint, and given
that we use the user region for mapping the UEFI runtime regions when
running under the OS, we don't rely on SetVirtualAddressMap() in the
conventional way, i.e., to permit kernel mappings of the OS to coexist
with kernel region mappings of the firmware regions. This means that, in
principle, we should be able to avoid SetVirtualAddressMap() altogether,
and simply use the 1:1 mapping that UEFI uses at boot time. (Note that
omitting SetVirtualAddressMap() is explicitly permitted by the UEFI
spec).

However, there is a corner case on arm64, which, if configured for
3-level paging (or 2-level paging when using 64k pages), may not be able
to cover the entire range of firmware mappings (which might contain both
memory and MMIO peripheral mappings).

So let's avoid SetVirtualAddressMap() on arm64, but only if the VA space
is guaranteed to be of sufficient size.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/arm64-stub.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/firmware/efi/libstub/arm64-stub.c b/drivers/firmware/efi/libstub/arm64-stub.c
index cd3bea25c762..4fff6c32899e 100644
--- a/drivers/firmware/efi/libstub/arm64-stub.c
+++ b/drivers/firmware/efi/libstub/arm64-stub.c
@@ -31,6 +31,15 @@ efi_status_t check_platform_features(void)
 			efi_err("This 16 KB granular kernel is not supported by your CPU\n");
 		return EFI_UNSUPPORTED;
 	}
+
+	/*
+	 * If we have 48 bits of VA space for TTBR0 mappings, we can map the
+	 * UEFI runtime regions 1:1 and so calling SetVirtualAddressMap() is
+	 * unnecessary.
+	 */
+	if (VA_BITS_MIN >= 48)
+		efi_novamap = true;
+
 	return EFI_SUCCESS;
 }
 
-- 
2.35.1

