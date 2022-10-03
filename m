Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7AF95F2F95
	for <lists+linux-efi@lfdr.de>; Mon,  3 Oct 2022 13:26:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229446AbiJCL0q (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 3 Oct 2022 07:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiJCL0o (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 3 Oct 2022 07:26:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F3232A94E
        for <linux-efi@vger.kernel.org>; Mon,  3 Oct 2022 04:26:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BDBE46103A
        for <linux-efi@vger.kernel.org>; Mon,  3 Oct 2022 11:26:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD778C433D6;
        Mon,  3 Oct 2022 11:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664796403;
        bh=W8obWGwmcyzn5+VXhc6GfBg92Z+wLrsUyqrdMHjxep0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YTGegz+V40gx32fSy3+ERPuWauQ9SGX/uyZftYxZvb467SzxmwKVEXTMytzhQH7M4
         1V2VKfiVYH7TcozRWRHaiRvjYuXJnU7IvA2olmMY0WGaftBs2Wudq34NFeznUROMkf
         eEKT2c2BHrvwIO56Rzxa+c2tXnHsopKi5rFQ8dcQVnCQmh0iLDqkj0BYghKh88t0pV
         ULDcjx0TaFehBTvC0LpqUhrWXl8AuGFXSEa+GLPK6LQT0oJW1e//vLHd+Ci6+dIj7n
         xxJvJpZglhpkIcm+iL9P6RnGDwu7fekz6jzPSYG5rUJjgpQsCa8Ggp2E/znkC/Nfmw
         X2n7ROAkqY1Aw==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     xen-devel@lists.xenproject.org, Ard Biesheuvel <ardb@kernel.org>,
        Demi Marie Obenour <demi@invisiblethingslab.com>,
        Peter Jones <pjones@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        =?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>
Subject: [PATCH v2 4/6] efi: memmap: Disregard bogus entries instead of returning them
Date:   Mon,  3 Oct 2022 13:26:23 +0200
Message-Id: <20221003112625.972646-5-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221003112625.972646-1-ardb@kernel.org>
References: <20221003112625.972646-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2717; i=ardb@kernel.org; h=from:subject; bh=W8obWGwmcyzn5+VXhc6GfBg92Z+wLrsUyqrdMHjxep0=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjOsbbl+ejDPGi0x7EecnkWLLI5uBb8hfx+mNuYEHL SGFCPwKJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYzrG2wAKCRDDTyI5ktmPJBDfC/ 9BMiukxbjQZgrq2K+4VvI3jjsxzxCI4AmtyKuHFCUBrg62qhcftHWoNGouY0pXptyDabOuNA8Tczdq x93UinMLN5X0NyKvuGmQty4oFhA8rEpRD6B2KX/VHKtu6kwGFBF8gaXmWeGfFv8ZNaQUzZCW51+Ah6 xt81Vx4p8RGFSrmoIzV6bamToULbrhLug9i/9Jsd6mg7Ggpisdj5E2rLXjTIYgtsnnoEXnwZsp9gXW PeBo+4rcj7CsYM7PfupkE6/uX6qAiYPA3UV2nJ9mBJTahiFmwKA58HVUtsv3j16lIEdROHb/bqPvTY /Iw/rmhC+gDxqBhlWoytmTnJWKB1EZpKPo3WESWHuZFKxwFAoqgMWHTFXe5dTWPeEsDBh6rC4WLY7q ylZMZsE9c0QQw1zdPhqNFcK1cGUaorxsMrxlPNm8LYO+qpRsl4HaWKrvSoGF9BMB8PI9R2X+LmbP2Y lhrKABraz+MgDmjFbkI55I1cVGbvO3j4AVGjPmERfskUM=
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

The ESRT code currently contains some sanity checks on the memory
descriptor it obtains, but these can only trigger when the descriptor is
invalid (if at all).

So let's drop these checks, and instead, disregard descriptors entirely
if the start address is misaligned, or the number of pages reaches
beyond the end of the address space. Note that the memory map as a whole
could still be inconsistent, i.e., multiple entries might cover the same
area, or the address could be outside of the addressable VA space, but
validating that goes beyond the scope of these helpers.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/efi.c  | 13 +++++++------
 drivers/firmware/efi/esrt.c | 18 +-----------------
 2 files changed, 8 insertions(+), 23 deletions(-)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 11857af72859..55bd3f4aab28 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -461,19 +461,20 @@ int efi_mem_desc_lookup(u64 phys_addr, efi_memory_desc_t *out_md)
 	efi_memory_desc_t *md;
 
 	if (!efi_enabled(EFI_MEMMAP)) {
-		pr_err_once("EFI_MEMMAP is not enabled.\n");
+		pr_warn_once("EFI_MEMMAP is not enabled.\n");
 		return -EINVAL;
 	}
 
-	if (!out_md) {
-		pr_err_once("out_md is null.\n");
-		return -EINVAL;
-        }
-
 	for_each_efi_memory_desc(md) {
 		u64 size;
 		u64 end;
 
+		/* skip bogus entries */
+		if ((md->phys_addr & (EFI_PAGE_SIZE - 1)) ||
+		    (md->phys_addr > 0 &&
+		     (md->num_pages > (U64_MAX - md->phys_addr + 1) >> EFI_PAGE_SHIFT)))
+			continue;
+
 		size = md->num_pages << EFI_PAGE_SHIFT;
 		end = md->phys_addr + size;
 		if (phys_addr >= md->phys_addr && phys_addr < end) {
diff --git a/drivers/firmware/efi/esrt.c b/drivers/firmware/efi/esrt.c
index 2a2f52b017e7..8f86f2b0734b 100644
--- a/drivers/firmware/efi/esrt.c
+++ b/drivers/firmware/efi/esrt.c
@@ -247,9 +247,6 @@ void __init efi_esrt_init(void)
 	int rc;
 	phys_addr_t end;
 
-	if (!efi_enabled(EFI_MEMMAP))
-		return;
-
 	pr_debug("esrt-init: loading.\n");
 	if (!esrt_table_exists())
 		return;
@@ -263,21 +260,8 @@ void __init efi_esrt_init(void)
 		return;
 	}
 
-	max = efi_mem_desc_end(&md);
-	if (max < efi.esrt) {
-		pr_err("EFI memory descriptor is invalid. (esrt: %p max: %p)\n",
-		       (void *)efi.esrt, (void *)max);
-		return;
-	}
-
+	max = efi_mem_desc_end(&md) - efi.esrt;
 	size = sizeof(*esrt);
-	max -= efi.esrt;
-
-	if (max < size) {
-		pr_err("ESRT header doesn't fit on single memory map entry. (size: %zu max: %zu)\n",
-		       size, max);
-		return;
-	}
 
 	va = early_memremap(efi.esrt, size);
 	if (!va) {
-- 
2.35.1

