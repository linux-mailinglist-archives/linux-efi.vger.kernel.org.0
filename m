Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06F905AF972
	for <lists+linux-efi@lfdr.de>; Wed,  7 Sep 2022 03:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbiIGBsV (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 6 Sep 2022 21:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiIGBsV (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 6 Sep 2022 21:48:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 921D0832E3;
        Tue,  6 Sep 2022 18:48:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 27B52616EB;
        Wed,  7 Sep 2022 01:48:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8543C433D6;
        Wed,  7 Sep 2022 01:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662515299;
        bh=t0Bxth8FdzneHjCPM3qPz7rrGj6ZZLOPNu/D055k2Rk=;
        h=From:To:Cc:Subject:Date:From;
        b=dkqwzy2EekUlmtvtOnaFGKlnP2G8hjNUGqKmPiR9Tb7NOu1cFbmZiq9olQIcpd35V
         1CqL8B5Hf7u3LGeQvRtb9ducJkSz2MZeZYQ6snuLRcpiFCwrdTXBW69rWXuJrqBK98
         McJ+1pJSQS2iVsMTtXubIxBsG0xIEIfquBbV+6EeK4wj4+36zq5r0U2zA0AwB21Dco
         mqHKC5QisDCEI9RLc4VWRrlwBmbh8CyZIOwu4a4q7ARNwqSgvQwd/3SAguIUHKD2xI
         nTSNlYOkCvznpWefQgKFhzTTUGiJt/Sdx6BsKvWlxN7GYKWU8LJrDdjfoEcH0aQMqx
         M3QxFrjQceFpg==
From:   guoren@kernel.org
To:     tglx@linutronix.de, peterz@infradead.org, luto@kernel.org,
        Conor.Dooley@microchip.com, xianting.tian@linux.alibaba.com,
        daolu@rivosinc.com, arnd@arndb.de
Cc:     linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>, Guo Ren <guoren@kernel.org>
Subject: [RFC PATCH] generic_entry: Add stackleak support
Date:   Tue,  6 Sep 2022 21:48:09 -0400
Message-Id: <20220907014809.919979-1-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
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

From: Guo Ren <guoren@linux.alibaba.com>

Make generic_entry supports basic STACKLEAK, and no arch custom
code is needed.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
 drivers/firmware/efi/libstub/Makefile | 4 +++-
 include/linux/stackleak.h             | 3 +++
 kernel/entry/common.c                 | 5 +++++
 security/Kconfig.hardening            | 2 +-
 4 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index d0537573501e..bb6ad37a9690 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -19,7 +19,7 @@ cflags-$(CONFIG_X86)		+= -m$(BITS) -D__KERNEL__ \
 # arm64 uses the full KBUILD_CFLAGS so it's necessary to explicitly
 # disable the stackleak plugin
 cflags-$(CONFIG_ARM64)		:= $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) \
-				   -fpie $(DISABLE_STACKLEAK_PLUGIN) \
+				   -fpie \
 				   $(call cc-option,-mbranch-protection=none)
 cflags-$(CONFIG_ARM)		:= $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) \
 				   -fno-builtin -fpic \
@@ -27,6 +27,8 @@ cflags-$(CONFIG_ARM)		:= $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) \
 cflags-$(CONFIG_RISCV)		:= $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) \
 				   -fpic
 
+cflags-$(CONFIG_GCC_PLUGIN_STACKLEAK) += $(DISABLE_STACKLEAK_PLUGIN)
+
 cflags-$(CONFIG_EFI_GENERIC_STUB) += -I$(srctree)/scripts/dtc/libfdt
 
 KBUILD_CFLAGS			:= $(cflags-y) -Os -DDISABLE_BRANCH_PROFILING \
diff --git a/include/linux/stackleak.h b/include/linux/stackleak.h
index c36e7a3b45e7..9890802a5868 100644
--- a/include/linux/stackleak.h
+++ b/include/linux/stackleak.h
@@ -76,8 +76,11 @@ static inline void stackleak_task_init(struct task_struct *t)
 # endif
 }
 
+void noinstr stackleak_erase(void);
+
 #else /* !CONFIG_GCC_PLUGIN_STACKLEAK */
 static inline void stackleak_task_init(struct task_struct *t) { }
+static inline void stackleak_erase(void) {}
 #endif
 
 #endif
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index 063068a9ea9b..6acb1d6a1396 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -8,6 +8,7 @@
 #include <linux/livepatch.h>
 #include <linux/audit.h>
 #include <linux/tick.h>
+#include <linux/stackleak.h>
 
 #include "common.h"
 
@@ -194,6 +195,10 @@ static void exit_to_user_mode_prepare(struct pt_regs *regs)
 
 	lockdep_assert_irqs_disabled();
 
+#ifndef CONFIG_HAVE_ARCH_STACKLEAK
+	stackleak_erase();
+#endif
+
 	/* Flush pending rcuog wakeup before the last need_resched() check */
 	tick_nohz_user_enter_prepare();
 
diff --git a/security/Kconfig.hardening b/security/Kconfig.hardening
index bd2aabb2c60f..3329482beb8d 100644
--- a/security/Kconfig.hardening
+++ b/security/Kconfig.hardening
@@ -152,7 +152,7 @@ config GCC_PLUGIN_STRUCTLEAK_VERBOSE
 config GCC_PLUGIN_STACKLEAK
 	bool "Poison kernel stack before returning from syscalls"
 	depends on GCC_PLUGINS
-	depends on HAVE_ARCH_STACKLEAK
+	depends on HAVE_ARCH_STACKLEAK || GENERIC_ENTRY
 	help
 	  This option makes the kernel erase the kernel stack before
 	  returning from system calls. This has the effect of leaving
-- 
2.36.1

