Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4685B70531D
	for <lists+linux-efi@lfdr.de>; Tue, 16 May 2023 18:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234396AbjEPQHS (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 16 May 2023 12:07:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234275AbjEPQHO (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 16 May 2023 12:07:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 998CF10FA;
        Tue, 16 May 2023 09:07:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 22D5C63461;
        Tue, 16 May 2023 16:07:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04AD0C4339E;
        Tue, 16 May 2023 16:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684253228;
        bh=dDeWGPu2Qoc+fpFOXn3k7Xys2RqMy0OtpAINFOM+y3M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EfUMaEOWjknj06edFveCWT/Zhn6aROXJypSejnFAcBfV22UlNyvV4+f4TmPARYnIi
         wGr0ikh464bEhSqc1BTBJ863A8ccvyNk7aTxPvIVN7H+aGiU/Kp4ay8oXIauPtPc4u
         5mtjD6x9V5WNnDrPU0txgQrpTZcRCAK7CB2BHeE04BJzybY68SpmpHbN+aoOmsQFID
         70844Ej95iG7N5ivr4FykIPpb3tLoRkJ9J7ANI0VXNVVGCT6Xx3cAEC24sE056yZR+
         BCbbpCbg1Tbi8eX6tLxMJY5Q3azUj1Uqvyk/4yrJKueesKkuLpkD2T4Xp7txCk0Mus
         uEZAyPpD0STAA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Suren Baghdasaryan <surenb@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org, kvmarm@lists.linux.dev
Subject: [PATCH 03/15] arm64: avoid prototype warnings for syscalls
Date:   Tue, 16 May 2023 18:06:30 +0200
Message-Id: <20230516160642.523862-4-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230516160642.523862-1-arnd@kernel.org>
References: <20230516160642.523862-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

With W=1 warnings enabled, there are lots of complaints about
missing prototypes for system calls, plus a few other related
ones:

arch/arm64/kernel/sys_compat.c:68:6: error: no previous prototype for 'compat_arm_syscall' [-Werror=missing-prototypes]
arch/arm64/include/asm/syscall_wrapper.h:76:32: error: no previous prototype for '__arm64_sys_io_setup' [-Werror=missing-prototypes]
arch/arm64/include/asm/syscall_wrapper.h:41:32: error: no previous prototype for '__arm64_compat_sys_io_setup' [-Werror=missing-prototypes]
arch/arm64/include/asm/syscall_wrapper.h:76:32: error: no previous prototype for '__arm64_sys_io_destroy' [-Werror=missing-prototypes]
arch/arm64/include/asm/syscall_wrapper.h:76:32: error: no previous prototype for '__arm64_sys_io_submit' [-Werror=missing-prototypes]

Add declarations to the syscall macros to avoid all of these, plus
one for the compat syscall entry.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm64/include/asm/compat.h          | 2 ++
 arch/arm64/include/asm/syscall_wrapper.h | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/arch/arm64/include/asm/compat.h b/arch/arm64/include/asm/compat.h
index 74575c3d6987..ae904a1ad529 100644
--- a/arch/arm64/include/asm/compat.h
+++ b/arch/arm64/include/asm/compat.h
@@ -96,6 +96,8 @@ static inline int is_compat_thread(struct thread_info *thread)
 	return test_ti_thread_flag(thread, TIF_32BIT);
 }
 
+long compat_arm_syscall(struct pt_regs *regs, int scno);
+
 #else /* !CONFIG_COMPAT */
 
 static inline int is_compat_thread(struct thread_info *thread)
diff --git a/arch/arm64/include/asm/syscall_wrapper.h b/arch/arm64/include/asm/syscall_wrapper.h
index d30217c21eff..17f687510c48 100644
--- a/arch/arm64/include/asm/syscall_wrapper.h
+++ b/arch/arm64/include/asm/syscall_wrapper.h
@@ -38,6 +38,7 @@
 	asmlinkage long __arm64_compat_sys_##sname(const struct pt_regs *__unused)
 
 #define COND_SYSCALL_COMPAT(name) 							\
+	asmlinkage long __arm64_compat_sys_##name(const struct pt_regs *regs);		\
 	asmlinkage long __weak __arm64_compat_sys_##name(const struct pt_regs *regs)	\
 	{										\
 		return sys_ni_syscall();						\
@@ -53,6 +54,7 @@
 	ALLOW_ERROR_INJECTION(__arm64_sys##name, ERRNO);			\
 	static long __se_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__));		\
 	static inline long __do_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__));	\
+	asmlinkage long __arm64_sys##name(const struct pt_regs *regs);		\
 	asmlinkage long __arm64_sys##name(const struct pt_regs *regs)		\
 	{									\
 		return __se_sys##name(SC_ARM64_REGS_TO_ARGS(x,__VA_ARGS__));	\
@@ -73,11 +75,13 @@
 	asmlinkage long __arm64_sys_##sname(const struct pt_regs *__unused)
 
 #define COND_SYSCALL(name)							\
+	asmlinkage long __arm64_sys_##name(const struct pt_regs *regs);		\
 	asmlinkage long __weak __arm64_sys_##name(const struct pt_regs *regs)	\
 	{									\
 		return sys_ni_syscall();					\
 	}
 
+asmlinkage long __arm64_sys_ni_syscall(const struct pt_regs *__unused);
 #define SYS_NI(name) SYSCALL_ALIAS(__arm64_sys_##name, sys_ni_posix_timers);
 
 #endif /* __ASM_SYSCALL_WRAPPER_H */
-- 
2.39.2

