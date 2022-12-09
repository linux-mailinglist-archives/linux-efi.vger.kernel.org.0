Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAB8D6482D1
	for <lists+linux-efi@lfdr.de>; Fri,  9 Dec 2022 14:34:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbiLINe2 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 9 Dec 2022 08:34:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbiLINeY (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 9 Dec 2022 08:34:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 531EA6152D
        for <linux-efi@vger.kernel.org>; Fri,  9 Dec 2022 05:34:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EC7BFB82784
        for <linux-efi@vger.kernel.org>; Fri,  9 Dec 2022 13:34:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EE33C433D2;
        Fri,  9 Dec 2022 13:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670592860;
        bh=3C7oNDWScP0BNZiXI605o9QpBTHk0+kuskw3IH8ZZ6M=;
        h=From:To:Cc:Subject:Date:From;
        b=BqqpUfgd6zdSRayNElijFnCS9ec0Z1gwVU9LCvETy6Wqokj2ChSvlAhmHjSLxtOEO
         rqSgL58ULANeHJY2MTmcs2ofhuOOgLkpWv4Dr+RmOLYaS6zNOfKcLhOnvyTuLrsw4C
         pHsV+lFtzF70KyuCmQkqJHuLYKHoeq5lyOHFYK6nGDPhruo6G68HLA+vidMbE1u/l3
         0Ydu1TPt7GCJcWYZtcCXqeYOdAHgZdVX5SE+9pNqFX4nZuOMKYZzHptH/oDimHn/Rf
         oYFURVTl7e2Mg084D4AUIT8Cy/JgGYPCIr/iq4IDMBbNvR/wz0R84ykLy8hnmoFd8o
         8mYB1kAHft4/A==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-efi@vger.kernel.org, mark.rutland@arm.com, will@kernel.org,
        catalin.marinas@arm.com, Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH] arm64: efi: Account for the EFI runtime stack in stack unwinder
Date:   Fri,  9 Dec 2022 14:34:14 +0100
Message-Id: <20221209133414.3330761-1-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3138; i=ardb@kernel.org; h=from:subject; bh=3C7oNDWScP0BNZiXI605o9QpBTHk0+kuskw3IH8ZZ6M=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjkzlVnrH9hiukEfDjj/XBQU4U2xMCHZpsqpevf3ET bw7nAreJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCY5M5VQAKCRDDTyI5ktmPJCWPC/ 4sRAbLUI/NLvEhJjONdnQY0Jb+WSwBbNLAdrQgZ82n/KIjQSRQ9DRUimyR4KpixrNTpPhWcQpg0ek6 ALs4JVqJp+QVnCm0BzIhtVEfdHg8vDajDwLLRA4KawOV42T2YhbYBuYeCa5MQeflCgKFlGae45FPjN 6NGQ/7oB01FGiIAgNVrtW1CCK90JQjcFOKLqSbJrCqf+mJbdPRmrUKz1Ys96Wx7zfKEiHdqT8D649k zQ5Un5eM/WBfbTmueI1eDFaW8uun3naJcS1VyF5eGGHCvsgttAQqPa1Gai9g3n7wcCzy2RRqZ8+dsc 8qWDgGmbnlc/MUmfmxqun4qFbcmKrc2GnwJtrfHczuA0wxf0dt/2rbRlRn2OO6xLst5um1S/RL3uiZ e1tyz4CqIjXXQaHh7GYUAYCIQ1pxxDb5XE1uZe/dejNFo4JUXhFH9hFXhCm0C6OVtMoL/m9LXtpZJx OmENhF6HZRtHd9Oloxaz3xgW2aIZKWiO1u4KPHeas7z1A=
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

The EFI runtime services run from a dedicated stack now, and so the
stack unwinder needs to be informed about this.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---

I realised while looking into this that comparing current_work() against
efi_rts_work.work is not sufficient to decide whether current is running
EFI code, given that the ACPI subsystem will call efi_call_virt_pointer()
directly.

So instead, we can check whether the stashed thread stack pointer value
matches current's thread stack if the EFI runtime stack is currently in
use:

#define current_in_efi()                                               \
       (!preemptible() && spin_is_locked(&efi_rt_lock) &&              \
        on_task_stack(current, efi_rt_stack_top[-1], 1))

but this will be folded into the preceding patch, which I am not
reproducing here.

 arch/arm64/include/asm/stacktrace.h | 15 +++++++++++++++
 arch/arm64/kernel/stacktrace.c      | 12 ++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/arch/arm64/include/asm/stacktrace.h b/arch/arm64/include/asm/stacktrace.h
index 5a0edb064ea478bb..327cdcfcb1db0ad5 100644
--- a/arch/arm64/include/asm/stacktrace.h
+++ b/arch/arm64/include/asm/stacktrace.h
@@ -104,4 +104,19 @@ static inline struct stack_info stackinfo_get_sdei_critical(void)
 #define stackinfo_get_sdei_critical()	stackinfo_get_unknown()
 #endif
 
+#ifdef CONFIG_EFI
+extern u64 *efi_rt_stack_top;
+
+static inline struct stack_info stackinfo_get_efi(void)
+{
+	unsigned long high = (u64)efi_rt_stack_top;
+	unsigned long low = high - THREAD_SIZE;
+
+	return (struct stack_info) {
+		.low = low,
+		.high = high,
+	};
+}
+#endif
+
 #endif	/* __ASM_STACKTRACE_H */
diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
index 634279b3b03d1b07..ee9fd2018cd75ed2 100644
--- a/arch/arm64/kernel/stacktrace.c
+++ b/arch/arm64/kernel/stacktrace.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2012 ARM Ltd.
  */
 #include <linux/kernel.h>
+#include <linux/efi.h>
 #include <linux/export.h>
 #include <linux/ftrace.h>
 #include <linux/sched.h>
@@ -12,6 +13,7 @@
 #include <linux/sched/task_stack.h>
 #include <linux/stacktrace.h>
 
+#include <asm/efi.h>
 #include <asm/irq.h>
 #include <asm/stack_pointer.h>
 #include <asm/stacktrace.h>
@@ -186,6 +188,13 @@ void show_stack(struct task_struct *tsk, unsigned long *sp, const char *loglvl)
 			: stackinfo_get_unknown();		\
 	})
 
+#define STACKINFO_EFI						\
+	({							\
+		((task == current) && current_in_efi())		\
+			? stackinfo_get_efi()			\
+			: stackinfo_get_unknown();		\
+	})
+
 noinline notrace void arch_stack_walk(stack_trace_consume_fn consume_entry,
 			      void *cookie, struct task_struct *task,
 			      struct pt_regs *regs)
@@ -199,6 +208,9 @@ noinline notrace void arch_stack_walk(stack_trace_consume_fn consume_entry,
 #if defined(CONFIG_VMAP_STACK) && defined(CONFIG_ARM_SDE_INTERFACE)
 		STACKINFO_SDEI(normal),
 		STACKINFO_SDEI(critical),
+#endif
+#ifdef CONFIG_EFI
+		STACKINFO_EFI,
 #endif
 	};
 	struct unwind_state state = {
-- 
2.35.1

