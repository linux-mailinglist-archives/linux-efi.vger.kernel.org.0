Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53F85315D6E
	for <lists+linux-efi@lfdr.de>; Wed, 10 Feb 2021 03:39:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234909AbhBJCiJ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 9 Feb 2021 21:38:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:34224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234667AbhBJCgZ (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 9 Feb 2021 21:36:25 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id BF11264E7D;
        Wed, 10 Feb 2021 02:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612924439;
        bh=Yu+QDXIs3dOtbcDL0dcGyJyQIcgaRLTuAmkYXbv0uAk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uxq96gQZSqnsnLyhlwPB9J2byoHf2IddScJ2qPfc1aFjm2sFpfa7D3EoEJnodXOW0
         avjbwm0w5q6ETbmPGSNXBEaxWV0YRxA7RX4wbIgJe6DLVkNChb8HiEdkkn0ezXd3YD
         SuXx4zCBMo6usviIJG2hzrGVNhQ3FsCUbDt0GUEnDu8G6KUgQJxg1yp1K/Z+f4FDzL
         B0iLODC0zGlrReZh0BzIUASVM8Ca+yNcQAtrKuu47e8VJRCBwVc3CMp4N/iDmNqr85
         VjLD9oYy1VYNlqc8pXi1WyZutSTSxSmUf8KYZgEZz2/XCv6Ohr8AqxuiXvKo+KG+4K
         VSKESExWFpcOw==
From:   Andy Lutomirski <luto@kernel.org>
To:     x86@kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yonghong Song <yhs@fb.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org
Subject: [PATCH v2 14/14] x86/fault, x86/efi: Fix and rename efi_recover_from_page_fault()
Date:   Tue,  9 Feb 2021 18:33:46 -0800
Message-Id: <f43b1e80830dc78ed60ed8b0826f4f189254570c.1612924255.git.luto@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1612924255.git.luto@kernel.org>
References: <cover.1612924255.git.luto@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

efi_recover_from_page_fault() doesn't recover -- it does a special EFI
mini-oops.  Rename it to make it clear that it crashes.

While renaming it, I noticed a blatant bug: a page fault oops in a
different thread happening concurrently with an EFI runtime service call
would be misinterpreted as an EFI page fault.  Fix that.

This isn't quite exact.  We could do better by using a special CS for
calls into EFI.

Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org
Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 arch/x86/include/asm/efi.h     |  2 +-
 arch/x86/mm/fault.c            | 11 ++++++-----
 arch/x86/platform/efi/quirks.c | 16 ++++++++++++----
 3 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
index c98f78330b09..4b7706ddd8b6 100644
--- a/arch/x86/include/asm/efi.h
+++ b/arch/x86/include/asm/efi.h
@@ -150,7 +150,7 @@ extern void __init efi_apply_memmap_quirks(void);
 extern int __init efi_reuse_config(u64 tables, int nr_tables);
 extern void efi_delete_dummy_variable(void);
 extern void efi_switch_mm(struct mm_struct *mm);
-extern void efi_recover_from_page_fault(unsigned long phys_addr);
+extern void efi_crash_gracefully_on_page_fault(unsigned long phys_addr);
 extern void efi_free_boot_services(void);
 
 /* kexec external ABI */
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index eed217d4a877..dfdd56d9c020 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -16,7 +16,7 @@
 #include <linux/prefetch.h>		/* prefetchw			*/
 #include <linux/context_tracking.h>	/* exception_enter(), ...	*/
 #include <linux/uaccess.h>		/* faulthandler_disabled()	*/
-#include <linux/efi.h>			/* efi_recover_from_page_fault()*/
+#include <linux/efi.h>			/* efi_crash_gracefully_on_page_fault()*/
 #include <linux/mm_types.h>
 
 #include <asm/cpufeature.h>		/* boot_cpu_has, ...		*/
@@ -25,7 +25,7 @@
 #include <asm/vsyscall.h>		/* emulate_vsyscall		*/
 #include <asm/vm86.h>			/* struct vm86			*/
 #include <asm/mmu_context.h>		/* vma_pkey()			*/
-#include <asm/efi.h>			/* efi_recover_from_page_fault()*/
+#include <asm/efi.h>			/* efi_crash_gracefully_on_page_fault()*/
 #include <asm/desc.h>			/* store_idt(), ...		*/
 #include <asm/cpu_entry_area.h>		/* exception stack		*/
 #include <asm/pgtable_areas.h>		/* VMALLOC_START, ...		*/
@@ -700,11 +700,12 @@ page_fault_oops(struct pt_regs *regs, unsigned long error_code,
 #endif
 
 	/*
-	 * Buggy firmware could access regions which might page fault, try to
-	 * recover from such faults.
+	 * Buggy firmware could access regions which might page fault.  If
+	 * this happens, EFI has a special OOPS path that will try to
+	 * avoid hanging the system.
 	 */
 	if (IS_ENABLED(CONFIG_EFI))
-		efi_recover_from_page_fault(address);
+		efi_crash_gracefully_on_page_fault(address);
 
 oops:
 	/*
diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
index 5a40fe411ebd..0463ef9cddd6 100644
--- a/arch/x86/platform/efi/quirks.c
+++ b/arch/x86/platform/efi/quirks.c
@@ -687,15 +687,25 @@ int efi_capsule_setup_info(struct capsule_info *cap_info, void *kbuff,
  * @return: Returns, if the page fault is not handled. This function
  * will never return if the page fault is handled successfully.
  */
-void efi_recover_from_page_fault(unsigned long phys_addr)
+void efi_crash_gracefully_on_page_fault(unsigned long phys_addr)
 {
 	if (!IS_ENABLED(CONFIG_X86_64))
 		return;
 
+	/*
+	 * If we are in an interrupt nested inside an EFI runtime service,
+	 * then this is a regular OOPS, not an EFI failure.
+	 */
+	if (in_interrupt() || in_nmi() || in_softirq())
+		return;
+
 	/*
 	 * Make sure that an efi runtime service caused the page fault.
+	 * READ_ONCE() because we might be OOPSing in a different thread,
+	 * and we don't want to trip KTSAN while trying to OOPS.
 	 */
-	if (efi_rts_work.efi_rts_id == EFI_NONE)
+	if (READ_ONCE(efi_rts_work.efi_rts_id) == EFI_NONE ||
+	    current_work() != &efi_rts_work.work)
 		return;
 
 	/*
@@ -747,6 +757,4 @@ void efi_recover_from_page_fault(unsigned long phys_addr)
 		set_current_state(TASK_IDLE);
 		schedule();
 	}
-
-	return;
 }
-- 
2.29.2

