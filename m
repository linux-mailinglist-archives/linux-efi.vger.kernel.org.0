Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E883C705317
	for <lists+linux-efi@lfdr.de>; Tue, 16 May 2023 18:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233831AbjEPQG7 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 16 May 2023 12:06:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234100AbjEPQG6 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 16 May 2023 12:06:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70CBA10FA;
        Tue, 16 May 2023 09:06:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0E4AE632E4;
        Tue, 16 May 2023 16:06:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8143C433D2;
        Tue, 16 May 2023 16:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684253216;
        bh=8HcNSfxmpWpIs1lFwEOw18x/wQfzM+YqaT6AxhudRyk=;
        h=From:To:Cc:Subject:Date:From;
        b=G9bvLv12GxvOE8xwKHj1jJBgw2cqEOTCsWdkgFCYbx21nU08VqqPMEdcbJAmdEua/
         ll9u5r2DLzDVsQCRC8nbvMJv90oOzo/i0D4IDbAbktftEBC0oGczCWGqAGxVLIemKP
         L0HG6k8IAqY86XzrGsZfiNe2z52IAlkbwrI5LT52dJONLxYmpFalCkW1p4Cg/SPehQ
         UqLZ3rFbRcoNL3Pd1lQLhoau2RAoANPeayPWFZu0x97vtKtbqv7Ikc66R9kl684f0A
         YbyVQ7/4IyUmESWqir8zrIrjuuhbztqDMjC4WHLe1j7DkHVshG3WBmfjQ7LEt3h1DF
         iIHIJDkfbYnUA==
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
Subject: [PATCH 00/15] arm64: address -Wmissing-prototype warnings
Date:   Tue, 16 May 2023 18:06:27 +0200
Message-Id: <20230516160642.523862-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
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

This addresses all arm64 specific protype warnings. As with the arm32
patches, the majority of them  should be straightforward, either adding
an #include statement to get the right header, or ensuring that an unused
global function is left out of the build when the prototype is hidden.

The ones that are a bit awkward are those that just add a prototype to
shut up the warning, but the prototypes are never used for calling the
function because the only caller is in assembler code. I tried to come
up with other ways to shut up the compiler, and ideally this would be
triggered by the 'asmlinkage' keyword as Ard suggested in the past, but
I could not come up with a way to do this.

All of the warnings have to be addressed in some form before the
warning can be enabled by default.

    Arnd

Link: https://people.kernel.org/arnd/missing-prototype-warnings-in-the-kernel


Arnd Bergmann (15):
  arm64: xor-neon: mark xor_arm64_neon_*() static
  arm64: add scs_patch_vmlinux prototype
  arm64: avoid prototype warnings for syscalls
  arm64: move cpu_suspend_set_dbg_restorer() prototype to header
  arm64: spectre: provide prototypes for internal functions
  arm64: kvm: add prototypes for functions called in asm
  arm64: cpuidle: fix #ifdef for acpi functions
  arm64: efi: add efi_handle_corrupted_x18 prototype
  arm64: hide unused is_valid_bugaddr()
  arm64: module-plts: inline linux/moduleloader.h
  arm64: flush: include linux/libnvdimm.h
  arm64: kaslr: add kaslr_early_init() declaration
  arm64: signal: include asm/exception.h
  arm64: move early_brk64 prototype to header
  arm64: add alt_cb_patch_nops prototype

 arch/arm64/include/asm/alternative.h     |  3 +++
 arch/arm64/include/asm/archrandom.h      |  2 ++
 arch/arm64/include/asm/compat.h          |  2 ++
 arch/arm64/include/asm/efi.h             |  2 ++
 arch/arm64/include/asm/hw_breakpoint.h   |  8 ++++++++
 arch/arm64/include/asm/kvm_asm.h         | 18 ++++++++++++++++++
 arch/arm64/include/asm/scs.h             |  1 +
 arch/arm64/include/asm/spectre.h         | 16 ++++++++++++++++
 arch/arm64/include/asm/syscall_wrapper.h |  4 ++++
 arch/arm64/include/asm/traps.h           |  2 ++
 arch/arm64/kernel/cpuidle.c              |  2 +-
 arch/arm64/kernel/hw_breakpoint.c        |  8 --------
 arch/arm64/kernel/module-plts.c          |  1 +
 arch/arm64/kernel/signal.c               |  1 +
 arch/arm64/kernel/traps.c                |  3 ++-
 arch/arm64/lib/xor-neon.c                |  8 ++++----
 arch/arm64/mm/fault.c                    |  3 ---
 arch/arm64/mm/flush.c                    |  1 +
 18 files changed, 68 insertions(+), 17 deletions(-)

-- 
2.39.2

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Oliver Upton <oliver.upton@linux.dev>
Cc: James Morse <james.morse@arm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Zenghui Yu <yuzenghui@huawei.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-efi@vger.kernel.org
Cc: kvmarm@lists.linux.dev

