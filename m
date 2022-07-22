Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F59157E41C
	for <lists+linux-efi@lfdr.de>; Fri, 22 Jul 2022 18:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234717AbiGVQG6 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 22 Jul 2022 12:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235110AbiGVQGm (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 22 Jul 2022 12:06:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 958A12CE31
        for <linux-efi@vger.kernel.org>; Fri, 22 Jul 2022 09:06:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 247CFB82967
        for <linux-efi@vger.kernel.org>; Fri, 22 Jul 2022 16:06:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 152EAC341CA;
        Fri, 22 Jul 2022 16:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658505991;
        bh=EJHBuxChM+NAH3O85qfWLA2F5qwJSKyKUhMXpCNoyWM=;
        h=From:To:Cc:Subject:Date:From;
        b=rpuZVW7QbiLhuk/2dQ9DZW6/UzkCfL9RVxOj7Iv1yH0Orbl8DDrervWwGju/cu6X1
         ngXNWybydsyjZHdTYwXB/8MEIYBggtLoe1q/4m+LzHGc/nat/C/A5sGNFBMJrH2sm5
         jmo0gHYIJQtRlwAQzGRE2QF8KDG0SBaxMlZhtbORppNUU2ElVQ4cWW0IccyEB3Mu0K
         9X1E+0VMgbc6P3LxYRiTvhVNXSHmV5sfX/tPIjUGtqWH3XcRTi/8MfyP82z+heKV70
         G0q4faPJOpaYx34GkV4Uw4zEpYeSrXdheC2UPBBDibJW0d06ysOt0uCcUUxU7pt0oV
         A1ID8DDs9z03Q==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>, tglx@linutronix.de,
        torvalds@linux-foundation.org,
        Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@suse.de>,
        Josh Poimboeuf <jpoimboe@kernel.org>
Subject: [PATCH] efi/x86-mixed: leave RET unmitigated but move it into .rodata
Date:   Fri, 22 Jul 2022 18:06:12 +0200
Message-Id: <20220722160612.2976-1-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4210; h=from:subject; bh=EJHBuxChM+NAH3O85qfWLA2F5qwJSKyKUhMXpCNoyWM=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBi2srzdnYnkcllKgNaotFJGbnbleypYhIaeuEUjG/y uwzMDQ+JAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYtrK8wAKCRDDTyI5ktmPJKh3DA C8wxFlkBaZREac8xX4MNbyKP6epOYfRJplPueiCCWb7qzoj62tONsNXn9SjBOPlcaITIFIW5cu5avL dNKKdQczftDPtmLbXYJOUTbGlYimsqz5e1I292xuqL4A/A4bja1p/COFdn6tVBTImA/pb3ZeIZZOHd QUWSp3DzA633VaN/yvmPeKJzbmYQ8n2oRcF/QA6e4cDXi3GITPnZWDPaBqNOvDO6840GbrTe3QHZ2u kVLCXgxfLdIWgyoeFhi7UbXfG+GWXTvJiDXUv5jfSvblxR9bwxUffBNKaE0Up+vgildrtddox0JVJg +fFNdGsmsn+HbUjqxEV3mwzeL0V2tLrJgyLkdp8btjA6Jt68ntuagVEZvTe3w6AS0bnJErqPOnO9ja hBMv8XmJy7tsfcDx/GZ/cgXYc/627ix+3rWh6zuBD+DHqM05T78GVG7ESTKmMRQqT+T+WHz+qnzOYj il9xhViwokFqtANJxHQwdrfCpmqczZefnzEnkRZO9Hzvs=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Thadeu reports that the retbleed mitigations have broken EFI runtime
services in mixed mode, as the RET macro now expands to a relative
branch that jumps to nowhere when executed from the 1:1 mapping of the
kernel text that the EFI mixed mode thunk uses on its return back to the
caller.

So as Thadeu suggested in [1], we should switch to a bare 'ret' opcode
followed by 'int3' (to limit straight line speculation). However, doing
so leaves an unmitigated RET in the kernel text that is always present,
even on non-EFI or non-mixed mode systems (which are quite rare these
days to begin with)

So let's take Thadeu's fix a bit further, and move the EFI mixed mode
return trampoline that contains the RET into .rodata, so it is normally
mapped without executable permissions. And given that this snippet of
code is really the only kernel code that we ever execute via this 1:1
mapping, let's make the 1:1 mapping of the kernel .text non-executable
as well, and only map the page that covers the return trampoline with
executable permissions.

Note that mapping .text and .rodata is still necessary, as otherwise,
they will be covered by the default 1:1 mapping of the RAM below 4 GB,
which uses read-write permissions. Also note that merging the mappings
of .text and .rodata is not possible, even if they now use the same
permissions, due to the fact that the hole in the middle may contain
read-write data (such as the mixed mode stack)

[1] https://lore.kernel.org/linux-efi/20220715194550.793957-1-cascardo@canonical.com/

Cc: tglx@linutronix.de
Cc: torvalds@linux-foundation.org
Cc: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Borislav Petkov <bp@suse.de>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/platform/efi/efi_64.c       | 15 ++++++++++++---
 arch/x86/platform/efi/efi_thunk_64.S |  9 +++++++--
 2 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/arch/x86/platform/efi/efi_64.c b/arch/x86/platform/efi/efi_64.c
index 1f3675453a57..d8661fb31c76 100644
--- a/arch/x86/platform/efi/efi_64.c
+++ b/arch/x86/platform/efi/efi_64.c
@@ -176,7 +176,8 @@ virt_to_phys_or_null_size(void *va, unsigned long size)
 
 int __init efi_setup_page_tables(unsigned long pa_memmap, unsigned num_pages)
 {
-	unsigned long pfn, text, pf, rodata;
+	extern const u8 __efi64_thunk_ret_tramp[];
+	unsigned long pfn, text, pf, rodata, tramp;
 	struct page *page;
 	unsigned npages;
 	pgd_t *pgd = efi_mm.pgd;
@@ -240,7 +241,7 @@ int __init efi_setup_page_tables(unsigned long pa_memmap, unsigned num_pages)
 	text = __pa(_text);
 	pfn = text >> PAGE_SHIFT;
 
-	pf = _PAGE_ENC;
+	pf = _PAGE_NX | _PAGE_ENC;
 	if (kernel_map_pages_in_pgd(pgd, pfn, text, npages, pf)) {
 		pr_err("Failed to map kernel text 1:1\n");
 		return 1;
@@ -250,12 +251,20 @@ int __init efi_setup_page_tables(unsigned long pa_memmap, unsigned num_pages)
 	rodata = __pa(__start_rodata);
 	pfn = rodata >> PAGE_SHIFT;
 
-	pf = _PAGE_NX | _PAGE_ENC;
 	if (kernel_map_pages_in_pgd(pgd, pfn, rodata, npages, pf)) {
 		pr_err("Failed to map kernel rodata 1:1\n");
 		return 1;
 	}
 
+	tramp = __pa(__efi64_thunk_ret_tramp);
+	pfn = tramp >> PAGE_SHIFT;
+
+	pf = _PAGE_ENC;
+	if (kernel_map_pages_in_pgd(pgd, pfn, tramp, 1, pf)) {
+		pr_err("Failed to map kernel rodata 1:1\n");
+		return 1;
+	}
+
 	return 0;
 }
 
diff --git a/arch/x86/platform/efi/efi_thunk_64.S b/arch/x86/platform/efi/efi_thunk_64.S
index 9ffe2bad27d5..e436ce03741e 100644
--- a/arch/x86/platform/efi/efi_thunk_64.S
+++ b/arch/x86/platform/efi/efi_thunk_64.S
@@ -71,17 +71,22 @@ STACK_FRAME_NON_STANDARD __efi64_thunk
 	pushq	$__KERNEL32_CS
 	pushq	%rdi			/* EFI runtime service address */
 	lretq
+SYM_FUNC_END(__efi64_thunk)
 
+	.section ".rodata", "a", @progbits
+	.balign	16
+SYM_DATA_START(__efi64_thunk_ret_tramp)
 1:	movq	0x20(%rsp), %rsp
 	pop	%rbx
 	pop	%rbp
-	RET
+	ret
+	int3
 
 	.code32
 2:	pushl	$__KERNEL_CS
 	pushl	%ebp
 	lret
-SYM_FUNC_END(__efi64_thunk)
+SYM_DATA_END(__efi64_thunk_ret_tramp)
 
 	.bss
 	.balign 8
-- 
2.35.1

