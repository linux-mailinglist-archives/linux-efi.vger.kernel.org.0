Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A00506605E6
	for <lists+linux-efi@lfdr.de>; Fri,  6 Jan 2023 18:47:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234279AbjAFRrp (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 6 Jan 2023 12:47:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235605AbjAFRrg (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 6 Jan 2023 12:47:36 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24DD265BA
        for <linux-efi@vger.kernel.org>; Fri,  6 Jan 2023 09:47:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D1242B810A7
        for <linux-efi@vger.kernel.org>; Fri,  6 Jan 2023 17:47:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 163DCC433D2;
        Fri,  6 Jan 2023 17:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673027252;
        bh=7Q6T2+dAG5RTQ5otwWhdPAprwZG6MtnTSG2Wd496obk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KiywsNxTkfvT7jL/c5vmpW4/4Vap7TlFdGRBif0enkZvR9O9+L+fmF4NpkYxnDayf
         lN0pNfhsEWuNRuTR+vBIczSNZPh6U6wc9RmcSz++Gb9SaBFN2WeGmHkFOBiExnhuOW
         5ez+yzmdTkiodq1mQfFuR8ytUYPe6W1lyaVULiI8UOos6EgFKm92W29VZJvPmYXa/c
         oc6XUrlOxeFuLxLL1AZASip1y9NRzra6FXQi24sKhOo+pSwMBlziS7QD1fZ90bBESu
         eph6uc6NfuNRrsdo+iTQ/3+z92xihbCHEslaS10XXk+wflB9l9j0lCq9SjZioKvLh6
         7Aau3gDYurRLQ==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, will@kernel.org,
        catalin.marinas@arm.com, Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Lee Jones <lee@kernel.org>
Subject: [PATCH v3 2/2] arm64: efi: Account for the EFI runtime stack in stack unwinder
Date:   Fri,  6 Jan 2023 18:47:03 +0100
Message-Id: <20230106174703.1883495-3-ardb@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230106174703.1883495-1-ardb@kernel.org>
References: <20230106174703.1883495-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2498; i=ardb@kernel.org; h=from:subject; bh=7Q6T2+dAG5RTQ5otwWhdPAprwZG6MtnTSG2Wd496obk=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjuF6Wyf5bE8mwEUlA/nkr4xivwidcpjXnJoBlk0EE FAY6p+2JAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCY7helgAKCRDDTyI5ktmPJIxxDA CEGcEjOgRQ6hvtSsybFXrsifFquZt6LL6RSoqe3SbfQNCcpACfPPoD3nYAd5rYeOLT9zcbgb7EYDyr CH+CJgRvb/reSVn5hpz+Z80B6OiCka7h/JhVZcgA6fQqenWry4GDSILLFyfVvaRDJTyyHBcqE9sjwj MR20ulHy47SjYiTW/mQJ+WVAS121jlNh510q3n0UIQGoh1ddjlermZT3tWa2XoTOeI01FyPwNhFCP6 WenFL7e2UfPgwoqSLz1eBWUQT4+PXS5D1CJ+iC8QP2WbJNVwFjyr2S0+pZVyUCp/nnOuXJqii3v3N+ DAqpBff7AmRnveETdCoEi2hj6rVVNQqP7CdskIdxI/1G9HTsYGArtv/aQ/poEaiIOwaCIC9fRRIGsz y6ID5pRZd9R06xWGybze8489Lu3ZAmRSDZQp/PI5gYXz21suk0cd4BKfFk3nAasTtH5d744ftshwrn 2gbKaaVnAjxlvcqGFODNKf5MnDsdeVfaAsEjV9djxG0SU=
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

Acked-by: Mark Rutland <mark.rutland@arm.com>
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

