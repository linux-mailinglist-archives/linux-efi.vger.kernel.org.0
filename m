Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58F3E5A3DE1
	for <lists+linux-efi@lfdr.de>; Sun, 28 Aug 2022 15:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbiH1NyT (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 28 Aug 2022 09:54:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiH1NyS (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 28 Aug 2022 09:54:18 -0400
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C28F830574;
        Sun, 28 Aug 2022 06:54:16 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=xianting.tian@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0VNSFve4_1661694851;
Received: from localhost(mailfrom:xianting.tian@linux.alibaba.com fp:SMTPD_---0VNSFve4_1661694851)
          by smtp.aliyun-inc.com;
          Sun, 28 Aug 2022 21:54:12 +0800
From:   Xianting Tian <xianting.tian@linux.alibaba.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, ardb@kernel.org, guoren@kernel.org,
        heiko@sntech.de
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org,
        Xianting Tian <xianting.tian@linux.alibaba.com>
Subject: [PATCH] RISC-V: Add STACKLEAK erasing the kernel stack at the end of syscalls
Date:   Sun, 28 Aug 2022 21:54:07 +0800
Message-Id: <20220828135407.3897717-1-xianting.tian@linux.alibaba.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

This adds support for the STACKLEAK gcc plugin to RISC-V and disables
the plugin in EFI stub code, which is out of scope for the protection.

For the benefits of STACKLEAK feature, please check the commit
afaef01c0015 ("x86/entry: Add STACKLEAK erasing the kernel stack at the end of syscalls")

Performance impact (tested on qemu env with 1 riscv64 hart, 1GB mem)
    hackbench -s 512 -l 200 -g 15 -f 25 -P
    2.0% slowdown

Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>
---
 arch/riscv/Kconfig                    | 1 +
 arch/riscv/include/asm/processor.h    | 4 ++++
 arch/riscv/kernel/entry.S             | 3 +++
 drivers/firmware/efi/libstub/Makefile | 2 +-
 4 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index ed66c31e4655..61fd0dad4463 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -85,6 +85,7 @@ config RISCV
 	select ARCH_ENABLE_THP_MIGRATION if TRANSPARENT_HUGEPAGE
 	select HAVE_ARCH_THREAD_STRUCT_WHITELIST
 	select HAVE_ARCH_VMAP_STACK if MMU && 64BIT
+	select HAVE_ARCH_STACKLEAK
 	select HAVE_ASM_MODVERSIONS
 	select HAVE_CONTEXT_TRACKING_USER
 	select HAVE_DEBUG_KMEMLEAK
diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
index 19eedd4af4cd..75620c467d25 100644
--- a/arch/riscv/include/asm/processor.h
+++ b/arch/riscv/include/asm/processor.h
@@ -85,6 +85,10 @@ int riscv_of_parent_hartid(struct device_node *node, unsigned long *hartid);
 extern void riscv_fill_hwcap(void);
 extern int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src);
 
+#define current_top_of_stack()	((unsigned long)current->stack + THREAD_SIZE)
+#define on_thread_stack()	((unsigned long)((current_top_of_stack() \
+				     - current_stack_pointer) < THREAD_SIZE))
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* _ASM_RISCV_PROCESSOR_H */
diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
index b9eda3fcbd6d..5f98660b46d4 100644
--- a/arch/riscv/kernel/entry.S
+++ b/arch/riscv/kernel/entry.S
@@ -233,6 +233,9 @@ check_syscall_nr:
 ret_from_syscall:
 	/* Set user a0 to kernel a0 */
 	REG_S a0, PT_A0(sp)
+#ifdef CONFIG_GCC_PLUGIN_STACKLEAK
+	call stackleak_erase_on_task_stack
+#endif
 	/*
 	 * We didn't execute the actual syscall.
 	 * Seccomp already set return value for the current task pt_regs.
diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index d0537573501e..5e1fc4f82883 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -25,7 +25,7 @@ cflags-$(CONFIG_ARM)		:= $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) \
 				   -fno-builtin -fpic \
 				   $(call cc-option,-mno-single-pic-base)
 cflags-$(CONFIG_RISCV)		:= $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) \
-				   -fpic
+				   -fpic $(DISABLE_STACKLEAK_PLUGIN)
 
 cflags-$(CONFIG_EFI_GENERIC_STUB) += -I$(srctree)/scripts/dtc/libfdt
 
-- 
2.17.1

