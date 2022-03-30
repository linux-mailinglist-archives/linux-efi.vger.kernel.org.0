Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7C784EC891
	for <lists+linux-efi@lfdr.de>; Wed, 30 Mar 2022 17:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348357AbiC3PoO (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 30 Mar 2022 11:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348355AbiC3PoN (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 30 Mar 2022 11:44:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B8AD35AB8
        for <linux-efi@vger.kernel.org>; Wed, 30 Mar 2022 08:42:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DE244616D1
        for <linux-efi@vger.kernel.org>; Wed, 30 Mar 2022 15:42:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8654C34114;
        Wed, 30 Mar 2022 15:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648654947;
        bh=sBwYXDl/hoZE0hxvjqpVZXzIWdBo8d5kBq1sUC2nsKw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dNolZDKDy9F54pqyHqgpUg2bp0uFrkda8Vmf8yI0wjoo9ntPFWCfAnvpVr8qzmj1a
         EysDjTylz8GC+v8XdbCjOnucAnwRQeDTk/GbyUCFO/aPMgJNTj/gD0HMljYzgIXa2b
         lqB0xjTNvigcFPxaUemzW2HR119+PVY2TwmQ6pd4fd7G07VIgNNmyi2lcugOMKkRa5
         n70FE/Cy7724IDM5iA7oH+J8LZBknnpW1UZOSVnHLSBZ0QdjxLk4S8d1vAj12ixJeE
         1wNJe0AitR+wcsdaMY4xMFuktcL3tKR/qMwovHdWoGsZsTV4zchpg4IcaxteXfO8vE
         jvo5QEzKaEDpA==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, keescook@chromium.org,
        mark.rutland@arm.com, catalin.marinas@arm.com,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [RFC PATCH v2 08/18] arm64: setup: defer R/O remapping of FDT
Date:   Wed, 30 Mar 2022 17:41:55 +0200
Message-Id: <20220330154205.2483167-9-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220330154205.2483167-1-ardb@kernel.org>
References: <20220330154205.2483167-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2415; h=from:subject; bh=sBwYXDl/hoZE0hxvjqpVZXzIWdBo8d5kBq1sUC2nsKw=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBiRHo7LjHU/WqxAPJBoP1hgK1CAW+hGG/fCgWsnqJe XaOBABuJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYkR6OwAKCRDDTyI5ktmPJF7QC/ 0cKBuOKD5rPYxq9NXKCVEUttLdOprhElSpoGU9dCbudzJqintq2//ePXn8gMeknIn/7NNiR0FidaYc dbhaFqSS2+fcScZSC6+v/+iQJ+usGFcB+J92n7TUVn/3JaWsWpg6YqQhBHKXppGSglnEFmAphTA9jO ClYqbUlC4KVnk1XEgVLH73Z1aprg5Ev4ew/iEaQ8yoXTvQCwG1N5s7DtywfuxdbjnDrVuAv3k5wVdS CeAEpE0BpghGl52z3gPHKGrNCX+p2DtLnfECO8JOrFs512lbSDGcpfoO4NSiMQqbFo4+uOHcuO+JSV hchue5g7BikNqeVWowNMXy9/NPIAkkGAeA+BQ1q1q3sqL6+2QnNn3lyemR3U0X8BZXY0wLG1VzuZHe u11vuE8keFg92lg7l2GBBgdOrOUE062Nd1bDRhwc0gjlwDJxrpFOxPH77DLcMuRx8GgSoU1UjVLwsK b0djZUT65+NOa84pXt6KyJ0yYIUoat3EDX6szrxinbKUg=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

We will be moving the call to kaslr_init() into setup_arch() in an
upcoming patch, and this needs the FDT to be writable so the KASLR seed
can be wiped from it.

So break out the R/O remapping of the FDT from setup_machine_fdt() and
call it explicitly from setup_arch().

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/kernel/setup.c |  6 +++---
 arch/arm64/mm/mmu.c       | 12 +++++++-----
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index 3505789cf4bd..ebf69312eabf 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -203,9 +203,6 @@ static void __init setup_machine_fdt(phys_addr_t dt_phys)
 			cpu_relax();
 	}
 
-	/* Early fixups are done, map the FDT as read-only now */
-	fixmap_remap_fdt(dt_phys, &size, PAGE_KERNEL_RO);
-
 	name = of_flat_dt_get_machine_name();
 	if (!name)
 		return;
@@ -316,6 +313,9 @@ void __init __no_sanitize_address setup_arch(char **cmdline_p)
 
 	setup_machine_fdt(__fdt_pointer);
 
+	/* Early fixups are done, map the FDT as read-only now */
+	fixmap_remap_fdt(__fdt_pointer, NULL, PAGE_KERNEL_RO);
+
 	/*
 	 * Initialise the static keys early as they may be enabled by the
 	 * cpufeature code and early parameters.
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index e74a6453cb14..20dd95a750bc 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1324,7 +1324,7 @@ void __set_fixmap(enum fixed_addresses idx,
 void *__init fixmap_remap_fdt(phys_addr_t dt_phys, int *size, pgprot_t prot)
 {
 	const u64 dt_virt_base = __fix_to_virt(FIX_FDT);
-	int offset;
+	int offset, dt_size;
 	void *dt_virt;
 
 	/*
@@ -1363,13 +1363,15 @@ void *__init fixmap_remap_fdt(phys_addr_t dt_phys, int *size, pgprot_t prot)
 	if (fdt_magic(dt_virt) != FDT_MAGIC)
 		return NULL;
 
-	*size = fdt_totalsize(dt_virt);
-	if (*size > MAX_FDT_SIZE)
+	dt_size = fdt_totalsize(dt_virt);
+	if (size)
+		*size = dt_size;
+	if (dt_size > MAX_FDT_SIZE)
 		return NULL;
 
-	if (offset + *size > SWAPPER_BLOCK_SIZE)
+	if (offset + dt_size > SWAPPER_BLOCK_SIZE)
 		create_mapping_noalloc(round_down(dt_phys, SWAPPER_BLOCK_SIZE), dt_virt_base,
-			       round_up(offset + *size, SWAPPER_BLOCK_SIZE), prot);
+			       round_up(offset + dt_size, SWAPPER_BLOCK_SIZE), prot);
 
 	return dt_virt;
 }
-- 
2.30.2

