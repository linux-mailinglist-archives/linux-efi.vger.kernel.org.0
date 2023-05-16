Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EE5E705323
	for <lists+linux-efi@lfdr.de>; Tue, 16 May 2023 18:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234419AbjEPQHg (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 16 May 2023 12:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234437AbjEPQHd (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 16 May 2023 12:07:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A508B9012;
        Tue, 16 May 2023 09:07:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3E67B63BED;
        Tue, 16 May 2023 16:07:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14EA4C433A8;
        Tue, 16 May 2023 16:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684253240;
        bh=cYFmzH9FV4Ur5p0DAU7gs+tfA3BDiik1KhVfqrr2Y+c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L7odbrekxCr+WdXsacMNFYgcL87tFzIydgjXfJfghOud/Or+/fLTisR5cCFmhD4xm
         zGMGpWatlFXDTYKOeijO/Qq3Og5f0gly2trNoQieyPhOrXBT+q7D/5F46pY5IAyWZY
         UZFQnBj8hdkFvucYcygeZACvWbHh3ERgVfbboPit0TDD1UibUqUAqTVpU3Fr5kQyII
         SxArngncxrbh+ozlZ0Wm1N5guqOfnsByoybPZIgrX073iMWCgeYUApZ37KYPqP0aRb
         dcunCI2jajzK1QiBDtG8X3o6iB+wh8BsMRzn3y41hRnEje2Y1YiGmjXeGBvf9jAlly
         FnoWszL29Od0A==
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
Subject: [PATCH 06/15] arm64: kvm: add prototypes for functions called in asm
Date:   Tue, 16 May 2023 18:06:33 +0200
Message-Id: <20230516160642.523862-7-arnd@kernel.org>
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

A lot of kvm specific functions are called only from assembler
and have no extern prototype, but that causes a W=1 warnings:

arch/arm64/kvm/handle_exit.c:365:24: error: no previous prototype for 'nvhe_hyp_panic_handler' [-Werror=missing-prototypes]
arch/arm64/kvm/va_layout.c:188:6: error: no previous prototype for 'kvm_patch_vector_branch' [-Werror=mi
ssing-prototypes]
arch/arm64/kvm/va_layout.c:287:6: error: no previous prototype for 'kvm_get_kimage_voffset' [-Werror=mis
sing-prototypes]
arch/arm64/kvm/va_layout.c:293:6: error: no previous prototype for 'kvm_compute_final_ctr_el0' [-Werror=
missing-prototypes]
arch/arm64/kvm/hyp/vhe/switch.c:259:17: error: no previous prototype for 'hyp_panic' [-Werror=missing-pr
arch/arm64/kvm/hyp/nvhe/switch.c:389:17: error: no previous prototype for 'kvm_unexpected_el2_exception'
arch/arm64/kvm/hyp/nvhe/switch.c:384:28: error: no previous prototype for 'hyp_panic_bad_stack' [-Werror
arch/arm64/kvm/hyp/nvhe/hyp-main.c:383:6: error: no previous prototype for 'handle_trap' [-Werror=missin
arch/arm64/kvm/hyp/nvhe/psci-relay.c:203:28: error: no previous prototype for 'kvm_host_psci_cpu_entry' [-Werror=missing-prototypes]

Declare those in asm/kvm_asm.h, which already has related declarations.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm64/include/asm/kvm_asm.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
index 43c3bc0f9544..86042afa86c3 100644
--- a/arch/arm64/include/asm/kvm_asm.h
+++ b/arch/arm64/include/asm/kvm_asm.h
@@ -267,6 +267,24 @@ extern u64 __kvm_get_mdcr_el2(void);
 	__kvm_at_err;							\
 } )
 
+void __noreturn hyp_panic(void);
+asmlinkage void kvm_unexpected_el2_exception(void);
+asmlinkage void __noreturn hyp_panic(void);
+asmlinkage void __noreturn hyp_panic_bad_stack(void);
+asmlinkage void kvm_unexpected_el2_exception(void);
+struct kvm_cpu_context;
+void handle_trap(struct kvm_cpu_context *host_ctxt);
+asmlinkage void __noreturn kvm_host_psci_cpu_entry(bool is_cpu_on);
+void __noreturn __pkvm_init_finalise(void);
+void kvm_nvhe_prepare_backtrace(unsigned long fp, unsigned long pc);
+void kvm_patch_vector_branch(struct alt_instr *alt,
+	__le32 *origptr, __le32 *updptr, int nr_inst);
+void kvm_get_kimage_voffset(struct alt_instr *alt,
+	__le32 *origptr, __le32 *updptr, int nr_inst);
+void kvm_compute_final_ctr_el0(struct alt_instr *alt,
+	__le32 *origptr, __le32 *updptr, int nr_inst);
+void __noreturn __cold nvhe_hyp_panic_handler(u64 esr, u64 spsr, u64 elr_virt,
+	u64 elr_phys, u64 par, uintptr_t vcpu, u64 far, u64 hpfar);
 
 #else /* __ASSEMBLY__ */
 
-- 
2.39.2

