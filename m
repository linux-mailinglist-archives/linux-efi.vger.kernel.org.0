Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87DD54FB870
	for <lists+linux-efi@lfdr.de>; Mon, 11 Apr 2022 11:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344875AbiDKJx4 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 11 Apr 2022 05:53:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344839AbiDKJwI (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 11 Apr 2022 05:52:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6AE04162A
        for <linux-efi@vger.kernel.org>; Mon, 11 Apr 2022 02:49:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2887EB80F97
        for <linux-efi@vger.kernel.org>; Mon, 11 Apr 2022 09:49:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 099B8C385AD;
        Mon, 11 Apr 2022 09:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649670578;
        bh=YtSuSXiDuWch666ErRH9dPdBAf8I6jd+Df9mu/gOaZw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DzLw3aWBy8WmRMoMjWoqIcOelOmc7L1YCVZO87zpXRuv7AQfJhAoKh9XgmWGLXbQg
         1s0Rxku6fCCVr1cfEvyngjAwWXap3S5+R25Xow4Lr+s5VZjvURR1ODfMrRL+iC3QAT
         tXRDd67rvKibOmOkwksJ2IpCVDMw0/cR98e+KiXCptX3ON4UwIdzo+K7defpnD351c
         SK9PO65fFW9VN6tKyEUnaA8xO9qwEfJcnaYQwqNfk4A6+USAdnZTAji07U6Wsgqj0l
         AKQ0/bJVAKkWdfPG1Rs506goNeoBKp67y8Y6iuIQxLVt4S+6M+d2DGASlYVYRyWDnz
         yYKHIphhJH8OA==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v3 23/30] arm64: mm: move ro_after_init section into the data segment
Date:   Mon, 11 Apr 2022 11:48:17 +0200
Message-Id: <20220411094824.4176877-24-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220411094824.4176877-1-ardb@kernel.org>
References: <20220411094824.4176877-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5001; h=from:subject; bh=YtSuSXiDuWch666ErRH9dPdBAf8I6jd+Df9mu/gOaZw=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBiU/lbsbTLg/fLmyhtxio90Ih3mCllrNJrjvzr0JA3 YnjysQGJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYlP5WwAKCRDDTyI5ktmPJO44C/ 99Mc64RsrOpbZiSXzUz24edLR0Dx3KSU/rQpBTVvLaCGh4xktmqYkCltVxTlYkDcb8ncSYOBvgN/Wu Zviqaxhfm5iWgQHVwcL8b0cVieNBTLgud6/hPQWcHPwfnW+Cny4oCnpbwQCj4iayX1wI+xG7tFgoab jHLDtbnBxtKRy0uKNfuFlKHKmOFxQDReXQQlz2FzRlw5/x2gcxddiouIAMpBvvWML0Zwlkp1aTPkLG NUw3u5aOFA/BmAEG+WjT3ZjymCSpRMuBjB1eBFN5EDs5P0vBQAp+OSzzmwpl3vQBQvOSVSeuAI2epo SJZ1fyZEfWXMH2eAGUvjVyCs7umdHxmYSe7HpILabyL/WpvpTm9W1XnREeHcKg1Vz5Eii18TgTycNG 1//gYVgoXlQrsYUUo/FeBRhXTdpZF27/HCh43x/sgPB6E0TtDKa7hE5zeCd+Cs5ms1UuDgSjDVZJSp KJ04aIiU+zC3rm99GbxEtHoc3VfKxfrOKGRMQt0wH46l8=
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

Currently, the ro_after_init sections sits right in the middle of the
text/rodata/inittext segment, making it difficult to map any of those
non-writable during early boot. So instead, move it to the start of
.data, and update the init sequences so that the section is remapped
read-only once startup completes.

Note that this moves the entire HYP data section into .data as well -
this likely needs to remain as a single block for now, but could perhaps
split into a .rodata and .data..ro_after_init section later.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/kernel/vmlinux.lds.S | 41 ++++++++++++--------
 arch/arm64/mm/mmu.c             | 29 ++++++++------
 2 files changed, 42 insertions(+), 28 deletions(-)

diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index cb4821c411f4..5b465295335a 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -59,6 +59,7 @@
 
 #define RO_EXCEPTION_TABLE_ALIGN	4
 #define RUNTIME_DISCARD_EXIT
+#define RO_AFTER_INIT_DATA
 
 #include <asm-generic/vmlinux.lds.h>
 #include <asm/cache.h>
@@ -192,22 +193,6 @@ SECTIONS
 	/* everything from this point to __init_begin will be marked RO NX */
 	RO_DATA(PAGE_SIZE)
 
-	HYPERVISOR_DATA_SECTIONS
-
-	idmap_pg_dir = .;
-	. += PAGE_SIZE;
-
-#ifdef CONFIG_UNMAP_KERNEL_AT_EL0
-	tramp_pg_dir = .;
-	. += PAGE_SIZE;
-#endif
-
-	reserved_pg_dir = .;
-	. += PAGE_SIZE;
-
-	swapper_pg_dir = .;
-	. += PAGE_SIZE;
-
 	. = ALIGN(SEGMENT_ALIGN);
 	__init_begin = .;
 	__inittext_begin = .;
@@ -270,6 +255,30 @@ SECTIONS
 
 	_data = .;
 	_sdata = .;
+
+	__start_ro_after_init = .;
+	idmap_pg_dir = .;
+	. += PAGE_SIZE;
+
+#ifdef CONFIG_UNMAP_KERNEL_AT_EL0
+	tramp_pg_dir = .;
+	. += PAGE_SIZE;
+#endif
+	reserved_pg_dir = .;
+	. += PAGE_SIZE;
+
+	swapper_pg_dir = .;
+	. += PAGE_SIZE;
+
+	HYPERVISOR_DATA_SECTIONS
+
+	.data.ro_after_init : {
+		*(.data..ro_after_init)
+		JUMP_TABLE_DATA
+		. = ALIGN(SEGMENT_ALIGN);
+		__end_ro_after_init = .;
+	}
+
 	RW_DATA(L1_CACHE_BYTES, PAGE_SIZE, THREAD_ALIGN)
 
 	/*
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index e7145f0281be..ef1f01da387d 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -488,11 +488,17 @@ static void __init __map_memblock(pgd_t *pgdp, phys_addr_t start,
 void __init mark_linear_text_alias_ro(void)
 {
 	/*
-	 * Remove the write permissions from the linear alias of .text/.rodata
+	 * Remove the write permissions from the linear alias of .text/.rodata/ro_after_init
 	 */
 	update_mapping_prot(__pa_symbol(_stext), (unsigned long)lm_alias(_stext),
 			    (unsigned long)__init_begin - (unsigned long)_stext,
 			    PAGE_KERNEL_RO);
+
+	update_mapping_prot(__pa_symbol(__start_ro_after_init),
+			    (unsigned long)lm_alias(__start_ro_after_init),
+			    (unsigned long)__end_ro_after_init -
+			    (unsigned long)__start_ro_after_init,
+			    PAGE_KERNEL_RO);
 }
 
 static bool crash_mem_map __initdata;
@@ -601,12 +607,10 @@ void mark_rodata_ro(void)
 {
 	unsigned long section_size;
 
-	/*
-	 * mark .rodata as read only. Use __init_begin rather than __end_rodata
-	 * to cover NOTES and EXCEPTION_TABLE.
-	 */
-	section_size = (unsigned long)__init_begin - (unsigned long)__start_rodata;
-	update_mapping_prot(__pa_symbol(__start_rodata), (unsigned long)__start_rodata,
+	section_size = (unsigned long)__end_ro_after_init -
+		       (unsigned long)__start_ro_after_init;
+	update_mapping_prot(__pa_symbol(__start_ro_after_init),
+			    (unsigned long)__start_ro_after_init,
 			    section_size, PAGE_KERNEL_RO);
 
 	debug_checkwx();
@@ -730,18 +734,19 @@ static void __init map_kernel(pgd_t *pgdp)
 		text_prot = __pgprot_modify(text_prot, PTE_GP, PTE_GP);
 
 	/*
-	 * Only rodata will be remapped with different permissions later on,
-	 * all other segments are allowed to use contiguous mappings.
+	 * Only data will be partially remapped with different permissions
+	 * later on, all other segments are allowed to use contiguous mappings.
 	 */
 	map_kernel_segment(pgdp, _stext, _etext, text_prot, &vmlinux_text, 0,
 			   VM_NO_GUARD);
-	map_kernel_segment(pgdp, __start_rodata, __inittext_begin, PAGE_KERNEL,
-			   &vmlinux_rodata, NO_CONT_MAPPINGS, VM_NO_GUARD);
+	map_kernel_segment(pgdp, __start_rodata, __inittext_begin, PAGE_KERNEL_RO,
+			   &vmlinux_rodata, 0, VM_NO_GUARD);
 	map_kernel_segment(pgdp, __inittext_begin, __inittext_end, text_prot,
 			   &vmlinux_inittext, 0, VM_NO_GUARD);
 	map_kernel_segment(pgdp, __initdata_begin, __initdata_end, PAGE_KERNEL,
 			   &vmlinux_initdata, 0, VM_NO_GUARD);
-	map_kernel_segment(pgdp, _data, _end, PAGE_KERNEL, &vmlinux_data, 0, 0);
+	map_kernel_segment(pgdp, _data, _end, PAGE_KERNEL, &vmlinux_data,
+			   NO_CONT_MAPPINGS | NO_BLOCK_MAPPINGS, 0);
 
 	if (!READ_ONCE(pgd_val(*pgd_offset_pgd(pgdp, FIXADDR_START)))) {
 		/*
-- 
2.30.2

