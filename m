Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD23054D3D8
	for <lists+linux-efi@lfdr.de>; Wed, 15 Jun 2022 23:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349453AbiFOVjB (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 15 Jun 2022 17:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347144AbiFOVjA (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 15 Jun 2022 17:39:00 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0056836E1A
        for <linux-efi@vger.kernel.org>; Wed, 15 Jun 2022 14:38:59 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id e9so12331717pju.5
        for <linux-efi@vger.kernel.org>; Wed, 15 Jun 2022 14:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gC84s41Zaxxa1lPfDnoe4PzMOU98OViDZBtfZzfaxqE=;
        b=hak3x7CQPOZ17oTZdiDXTakM0+LsHCGPgAKyehraVf4cuOt1nroXU1A3ocqe5bqgoq
         pRTnUTa68gzzNmy9DT6XQmey0U5d1UgEWvxtjuA/oT4yvVwO1+cKscli/cnB+CBHGxVY
         TnkTIw6VwwcS6Ui4ak7hreRoJwj0vBEwwXF5NYgGV9Kuuy8NeUVHrMRK7rMTyGJ8aZRD
         /ZJbcvYTkf38YAOYAUcZU8Yl79oYJbmfjKogdOGadPfO+Tx4fViND3cTScC98H6yZh6m
         WVjObg0be3Ij9xFgNxZgA4UncoAbJEXGy1LGLgg1acVjeNDVhxIao8m7XKVLxVsPbalw
         PXmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gC84s41Zaxxa1lPfDnoe4PzMOU98OViDZBtfZzfaxqE=;
        b=hVed+pLAKDKDk//XkQt6kVXl9mF76RPdp4DkyLGb+YZCotM+N+21iMsErCEkWhUxw+
         RQTthAUO5y0cEXLR+pYi9Y76T82xqFrmSDl4b59xjEzxz72lI4Y3Eqf7ydc7MzarSTbO
         8HGxc5qdCCNRV1KPNd6cjKXD5w25+yWOFH9eSbN2ueGZaf07nL+TydcchpNO/zDJS4hM
         Vx+2vAgajKyjiqYVXgRC76i+OU479otvw20LFp6GZWn692QOldpNivJv+Xy0WCErikRR
         6eOcyqstJ1zLl272kKFYvG616h9+g11cGNnl6K6+ufPD0OqfYMC3XMK+YMMo2y6jSj9P
         oRdQ==
X-Gm-Message-State: AJIora9pDuzs3SRFhYGo0i/8+ilC8uvVM8avXdsNIivGipsjN0Hiqsx4
        L+6cKFYLSXXZT8iPGX+IDK/bYw==
X-Google-Smtp-Source: AGRyM1vK4XSotEPkhRtgiK9nP+9n2opB+jjdjVDdP638l86ZVB2PevwkmqsA9lvLXKLEbH6TR0GS6w==
X-Received: by 2002:a17:90b:1bc1:b0:1e6:9a00:5d63 with SMTP id oa1-20020a17090b1bc100b001e69a005d63mr12160399pjb.154.1655329139462;
        Wed, 15 Jun 2022 14:38:59 -0700 (PDT)
Received: from daolu.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id je11-20020a170903264b00b0016223016d79sm100757plb.90.2022.06.15.14.38.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 14:38:58 -0700 (PDT)
From:   Dao Lu <daolu@rivosinc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dao Lu <daolu@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ard Biesheuvel <ardb@kernel.org>, Guo Ren <guoren@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Tong Tiangen <tongtiangen@huawei.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Changbin Du <changbin.du@intel.com>,
        Vincent Chen <vincent.chen@sifive.com>,
        linux-riscv@lists.infradead.org (open list:RISC-V ARCHITECTURE),
        linux-efi@vger.kernel.org (open list:EXTENSIBLE FIRMWARE INTERFACE
        (EFI))
Subject: [PATCH] arch/riscv: Add support for STACKLEAK gcc plugin
Date:   Wed, 15 Jun 2022 14:38:29 -0700
Message-Id: <20220615213834.3116135-1-daolu@rivosinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

This adds support for STACKLEAK gcc plugin to ricv by implementing
stackleak_check_alloca, based heavily on the arm64 version, and adding
the two helpers used by the stackleak common code:
current_top_of_stack() and on_thread_stack(). This also adds the missing
helper functions for riscv, on_stack() and on_task_stack().
Additionally, this disables the plugin for EFI stub code for riscv.

Signed-off-by: Dao Lu <daolu@rivosinc.com>
---
 arch/riscv/Kconfig                    |  1 +
 arch/riscv/include/asm/processor.h    | 18 ++++++++++++++++++
 arch/riscv/include/asm/stacktrace.h   | 27 +++++++++++++++++++++++++++
 arch/riscv/kernel/entry.S             |  3 +++
 drivers/firmware/efi/libstub/Makefile |  2 +-
 5 files changed, 50 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index c22f58155948..22aa146acd25 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -80,6 +80,7 @@ config RISCV
 	select HAVE_ARCH_MMAP_RND_BITS if MMU
 	select HAVE_ARCH_MMAP_RND_COMPAT_BITS if COMPAT
 	select HAVE_ARCH_SECCOMP_FILTER
+	select HAVE_ARCH_STACKLEAK
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_ARCH_TRANSPARENT_HUGEPAGE if 64BIT && MMU
 	select ARCH_ENABLE_THP_MIGRATION if TRANSPARENT_HUGEPAGE
diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
index 21c8072dce17..3a7505ab7f58 100644
--- a/arch/riscv/include/asm/processor.h
+++ b/arch/riscv/include/asm/processor.h
@@ -85,6 +85,24 @@ int riscv_of_parent_hartid(struct device_node *node);
 extern void riscv_fill_hwcap(void);
 extern int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src);
 
+/*
+ * For CONFIG_GCC_PLUGIN_STACKLEAK
+ *
+ * These need to be macros because otherwise we get stuck in a nightmare
+ * of header definitions for the use of task_stack_page.
+ */
+
+struct stack_info {
+	unsigned long low;
+	unsigned long high;
+};
+
+/*
+ * The top of the current task's task stack
+ */
+#define current_top_of_stack()	((unsigned long)current->stack + THREAD_SIZE)
+#define on_thread_stack()	(on_task_stack(current, current_stack_pointer, 1, NULL))
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* _ASM_RISCV_PROCESSOR_H */
diff --git a/arch/riscv/include/asm/stacktrace.h b/arch/riscv/include/asm/stacktrace.h
index 3450c1912afd..afb66b677b6a 100644
--- a/arch/riscv/include/asm/stacktrace.h
+++ b/arch/riscv/include/asm/stacktrace.h
@@ -16,4 +16,31 @@ extern void notrace walk_stackframe(struct task_struct *task, struct pt_regs *re
 extern void dump_backtrace(struct pt_regs *regs, struct task_struct *task,
 			   const char *loglvl);
 
+static inline bool on_stack(unsigned long sp, unsigned long size,
+			    unsigned long low, unsigned long high,
+			    struct stack_info *info)
+{
+	if (!low)
+		return false;
+
+	if (sp < low || sp + size < sp || sp + size > high)
+		return false;
+
+	if (info) {
+		info->low = low;
+		info->high = high;
+	}
+	return true;
+}
+
+static inline bool on_task_stack(const struct task_struct *tsk,
+				 unsigned long sp, unsigned long size,
+				 struct stack_info *info)
+{
+	unsigned long low = (unsigned long)task_stack_page(tsk);
+	unsigned long high = low + THREAD_SIZE;
+
+	return on_stack(sp, size, low, high, info);
+}
+
 #endif /* _ASM_RISCV_STACKTRACE_H */
diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
index 2e5b88ca11ce..65d441cb560f 100644
--- a/arch/riscv/kernel/entry.S
+++ b/arch/riscv/kernel/entry.S
@@ -264,6 +264,9 @@ ret_from_exception:
 	bnez s0, resume_kernel
 
 resume_userspace:
+#ifdef CONFIG_GCC_PLUGIN_STACKLEAK
+	call stackleak_erase
+#endif
 	/* Interrupts must be disabled here so flags are checked atomically */
 	REG_L s0, TASK_TI_FLAGS(tp) /* current_thread_info->flags */
 	andi s1, s0, _TIF_WORK_MASK
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
2.25.1

