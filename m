Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 400DB70533A
	for <lists+linux-efi@lfdr.de>; Tue, 16 May 2023 18:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234265AbjEPQJP (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 16 May 2023 12:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234418AbjEPQIk (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 16 May 2023 12:08:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E64411BF2;
        Tue, 16 May 2023 09:08:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B70A763BEB;
        Tue, 16 May 2023 16:07:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C92CC433D2;
        Tue, 16 May 2023 16:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684253273;
        bh=h0fpkbLAOr0hALEk6kCEy5MAyU8tR08UpwZWaWzGWr8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G2YspC5jTHUuOJUI4EhhBUyFCOOKFZLkbqD8w9Riw21cTSw3fKo729EaQIG7drJkp
         s7H4r1X18FAn3mK3PbP6eGqd4lmiZwH8emoPTvUbYIZ2yHGKzhg02SuTVrMl6NxFDu
         Qw5IHyESKe0mBsXwq4sFHGZpnlkrHlm99GnnwZa5monJzLE/ojsflhI390GG4PsKWP
         aYtkKc/WJRhJc101pMIaAlg60JJ3KO2ri2eJNR19r0Ynt/YelPVvaVbL6CM4fGm1Gn
         g+KT47Tvzsd/OhDaHS3u7Ruhw4FIwYik84yYUKg/MixP7GzLkx60SAFQuHfrUiphCG
         DHPcVcgCM29iA==
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
Subject: [PATCH 14/15] arm64: move early_brk64 prototype to header
Date:   Tue, 16 May 2023 18:06:41 +0200
Message-Id: <20230516160642.523862-15-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230516160642.523862-1-arnd@kernel.org>
References: <20230516160642.523862-1-arnd@kernel.org>
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

From: Arnd Bergmann <arnd@arndb.de>

The prototype used for calling early_brk64() is in the file that calls
it, which is the wrong place, as it is not included for the definition:

arch/arm64/kernel/traps.c:1100:12: error: no previous prototype for 'early_brk64' [-Werror=missing-prototypes]

Move it to an appropriate header instead.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm64/include/asm/traps.h | 2 ++
 arch/arm64/mm/fault.c          | 3 ---
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/traps.h b/arch/arm64/include/asm/traps.h
index 1f361e2da516..d66dfb3a72dd 100644
--- a/arch/arm64/include/asm/traps.h
+++ b/arch/arm64/include/asm/traps.h
@@ -29,6 +29,8 @@ void arm64_force_sig_fault(int signo, int code, unsigned long far, const char *s
 void arm64_force_sig_mceerr(int code, unsigned long far, short lsb, const char *str);
 void arm64_force_sig_ptrace_errno_trap(int errno, unsigned long far, const char *str);
 
+int early_brk64(unsigned long addr, unsigned long esr, struct pt_regs *regs);
+
 /*
  * Move regs->pc to next instruction and do necessary setup before it
  * is executed.
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 5ccdba7132ca..940391ec5e1e 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -886,9 +886,6 @@ void do_sp_pc_abort(unsigned long addr, unsigned long esr, struct pt_regs *regs)
 }
 NOKPROBE_SYMBOL(do_sp_pc_abort);
 
-int __init early_brk64(unsigned long addr, unsigned long esr,
-		       struct pt_regs *regs);
-
 /*
  * __refdata because early_brk64 is __init, but the reference to it is
  * clobbered at arch_initcall time.
-- 
2.39.2

