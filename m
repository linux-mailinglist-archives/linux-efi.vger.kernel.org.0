Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9071A698035
	for <lists+linux-efi@lfdr.de>; Wed, 15 Feb 2023 17:11:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbjBOQLM (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 15 Feb 2023 11:11:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbjBOQLL (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 15 Feb 2023 11:11:11 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5ECC13B0DB;
        Wed, 15 Feb 2023 08:10:59 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C98571042;
        Wed, 15 Feb 2023 08:11:41 -0800 (PST)
Received: from cam-smtp0.cambridge.arm.com (pierre123.nice.arm.com [10.34.100.128])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id EEC963F881;
        Wed, 15 Feb 2023 08:10:57 -0800 (PST)
From:   Pierre Gondois <pierre.gondois@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Pierre Gondois <pierre.gondois@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-efi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v1] arm64: efi: Make efi_rt_lock a raw_spinlock
Date:   Wed, 15 Feb 2023 17:10:47 +0100
Message-Id: <20230215161047.94803-1-pierre.gondois@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Running a rt-kernel base on 6.2.0-rc3-rt1 on an Ampere Altra outputs
the following:
  BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:46
  in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 9, name: kworker/u320:0
  preempt_count: 2, expected: 0
  RCU nest depth: 0, expected: 0
  3 locks held by kworker/u320:0/9:
  #0: ffff3fff8c27d128 ((wq_completion)efi_rts_wq){+.+.}-{0:0}, at: process_one_work (./include/linux/atomic/atomic-long.h:41)
  #1: ffff80000861bdd0 ((work_completion)(&efi_rts_work.work)){+.+.}-{0:0}, at: process_one_work (./include/linux/atomic/atomic-long.h:41)
  #2: ffffdf7e1ed3e460 (efi_rt_lock){+.+.}-{3:3}, at: efi_call_rts (drivers/firmware/efi/runtime-wrappers.c:101)
  Preemption disabled at:
  efi_virtmap_load (./arch/arm64/include/asm/mmu_context.h:248)
  CPU: 0 PID: 9 Comm: kworker/u320:0 Tainted: G        W          6.2.0-rc3-rt1
  Hardware name: WIWYNN Mt.Jade Server System B81.03001.0005/Mt.Jade Motherboard, BIOS 1.08.20220218 (SCP: 1.08.20220218) 2022/02/18
  Workqueue: efi_rts_wq efi_call_rts
  Call trace:
  dump_backtrace (arch/arm64/kernel/stacktrace.c:158)
  show_stack (arch/arm64/kernel/stacktrace.c:165)
  dump_stack_lvl (lib/dump_stack.c:107 (discriminator 4))
  dump_stack (lib/dump_stack.c:114)
  __might_resched (kernel/sched/core.c:10134)
  rt_spin_lock (kernel/locking/rtmutex.c:1769 (discriminator 4))
  efi_call_rts (drivers/firmware/efi/runtime-wrappers.c:101)
  [...]

This seems to come from commit ff7a167961d1 ("arm64: efi: Execute
runtime services from a dedicated stack") which adds a spinlock. This
spinlock is taken through:
efi_call_rts()
\-efi_call_virt()
  \-efi_call_virt_pointer()
    \-arch_efi_call_virt_setup()

Make 'efi_rt_lock' a raw_spinlock to avoid being preempted.

Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
---
 arch/arm64/include/asm/efi.h | 6 +++---
 arch/arm64/kernel/efi.c      | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/efi.h b/arch/arm64/include/asm/efi.h
index 31d13a6001df..37dc2e8c3500 100644
--- a/arch/arm64/include/asm/efi.h
+++ b/arch/arm64/include/asm/efi.h
@@ -33,7 +33,7 @@ int efi_set_mapping_permissions(struct mm_struct *mm, efi_memory_desc_t *md);
 ({									\
 	efi_virtmap_load();						\
 	__efi_fpsimd_begin();						\
-	spin_lock(&efi_rt_lock);					\
+	raw_spin_lock(&efi_rt_lock);					\
 })
 
 #undef arch_efi_call_virt
@@ -42,12 +42,12 @@ int efi_set_mapping_permissions(struct mm_struct *mm, efi_memory_desc_t *md);
 
 #define arch_efi_call_virt_teardown()					\
 ({									\
-	spin_unlock(&efi_rt_lock);					\
+	raw_spin_unlock(&efi_rt_lock);					\
 	__efi_fpsimd_end();						\
 	efi_virtmap_unload();						\
 })
 
-extern spinlock_t efi_rt_lock;
+extern raw_spinlock_t efi_rt_lock;
 efi_status_t __efi_rt_asm_wrapper(void *, const char *, ...);
 
 #define ARCH_EFI_IRQ_FLAGS_MASK (PSR_D_BIT | PSR_A_BIT | PSR_I_BIT | PSR_F_BIT)
diff --git a/arch/arm64/kernel/efi.c b/arch/arm64/kernel/efi.c
index fab05de2e12d..216933cf47ee 100644
--- a/arch/arm64/kernel/efi.c
+++ b/arch/arm64/kernel/efi.c
@@ -145,7 +145,7 @@ asmlinkage efi_status_t efi_handle_corrupted_x18(efi_status_t s, const char *f)
 	return s;
 }
 
-DEFINE_SPINLOCK(efi_rt_lock);
+DEFINE_RAW_SPINLOCK(efi_rt_lock);
 
 asmlinkage u64 *efi_rt_stack_top __ro_after_init;
 
-- 
2.25.1

