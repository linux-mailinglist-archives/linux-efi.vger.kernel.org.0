Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 956EC65DB6D
	for <lists+linux-efi@lfdr.de>; Wed,  4 Jan 2023 18:44:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235338AbjADRow (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 4 Jan 2023 12:44:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235135AbjADRou (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 4 Jan 2023 12:44:50 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7B9E1AA2A
        for <linux-efi@vger.kernel.org>; Wed,  4 Jan 2023 09:44:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5F894B817B0
        for <linux-efi@vger.kernel.org>; Wed,  4 Jan 2023 17:44:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 039DBC433D2;
        Wed,  4 Jan 2023 17:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672854287;
        bh=zLoq7rh6ScCHPZAIwnMyOMYtt4LObBNVb50PEjsCMO4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TkjjtbVhvm7y6BrLK/JIutVKbhkb/iI1jjqXaMaqMPwJXwXmHOQIoFHs6voBFXfpD
         sNWCT1yyxH0Xm8mE6qnOdOBXbWehGPV8mb3r986AKkEfdG0KAafREr/KMi+6sTlbVj
         2pyn4l6IdTiLnbb6GBk9af8s0beoNYM33lICoDcbvOoTogLpOEmiCHrdH05GcJyh86
         Aa3raCWj778enkKGLJSSK84oKmQ5xcbg93M75kdBrmwon3lzH9Tp0VZlTtTY3jc1FX
         zZbCJKMpm4nytUW7QG7iGE4FhyXBmI5biS3H+LuzkqvET4ihfCnWRrfIGhskXR4lq6
         HT7HuyV7ptFmA==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-efi@vger.kernel.org, catalin.marinas@arm.com,
        will@kernel.org, Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH v2 2/2] arm64: efi: Account for the EFI runtime stack in stack unwinder
Date:   Wed,  4 Jan 2023 18:44:33 +0100
Message-Id: <20230104174433.1259428-3-ardb@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230104174433.1259428-1-ardb@kernel.org>
References: <20230104174433.1259428-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2451; i=ardb@kernel.org; h=from:subject; bh=zLoq7rh6ScCHPZAIwnMyOMYtt4LObBNVb50PEjsCMO4=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjtbsAKsux2GnbGItRO4bTstltLeejaKlQ2jZlbxHU duGvq9GJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCY7W7AAAKCRDDTyI5ktmPJH/QC/ 40BVyTgbU9WcPUL8vgnzKPNg6kfH6vVDQQIh1M1j5otlrcinpjKMg92e3wPYMBq11w1+CRStzBjKSr gudVIrmYmDsohFZDDVxWixMU8WTR92mN6Rh7YwXRYL0ASsrbvFaRVeBqFPUTz8NDk0s3gueljAuZM9 EkFYAOmigpNc33dUtIhnPhti6ir4TqnD7yFPczbu+cJ6kgz6ZLXAnTUykmeJZYmG8s3OByZpDfa7Ff E9vfRnXEXI4teGqRpp3Yk1XLQdbLoFwLQ5BWdu4mGW50ZM5R+fhpHrPSzSxbHsngJHPpgfUlYzqgOe 99wIZMUNjaDHtfavtf7FQHvNbHhstqzdF2c5nkXZR1SxkCBIsJ30l9pyNQJ9KDQP6gAQ8wMl0sRpUs bSjl9v31a4mY9yCAO7HPnuF1tz6hewx3E/LxDzJi2tHe+w1X/2PJXb6aF2G8tq/5EnLW+ZRIDuMblv KzEY9PBIQY1xv0kbGQ1fodLuyNSCAkU4WlnCDmWDe5t8I=
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
 arch/arm64/include/asm/stacktrace.h | 15 +++++++++++++++
 arch/arm64/kernel/stacktrace.c      | 12 ++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/arch/arm64/include/asm/stacktrace.h b/arch/arm64/include/asm/stacktrace.h
index 4e5354beafb01bac..66ec8caa6ac07fa0 100644
--- a/arch/arm64/include/asm/stacktrace.h
+++ b/arch/arm64/include/asm/stacktrace.h
@@ -106,4 +106,19 @@ static inline struct stack_info stackinfo_get_sdei_critical(void)
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
index 117e2c180f3c77d8..83154303e682c8b6 100644
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
 noinline noinstr void arch_stack_walk(stack_trace_consume_fn consume_entry,
 			      void *cookie, struct task_struct *task,
 			      struct pt_regs *regs)
@@ -199,6 +208,9 @@ noinline noinstr void arch_stack_walk(stack_trace_consume_fn consume_entry,
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
2.39.0

