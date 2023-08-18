Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0775D780B31
	for <lists+linux-efi@lfdr.de>; Fri, 18 Aug 2023 13:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376690AbjHRLhp (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 18 Aug 2023 07:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376689AbjHRLhh (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 18 Aug 2023 07:37:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F18F12112
        for <linux-efi@vger.kernel.org>; Fri, 18 Aug 2023 04:37:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 85F8161182
        for <linux-efi@vger.kernel.org>; Fri, 18 Aug 2023 11:37:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 224DDC433C7;
        Fri, 18 Aug 2023 11:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692358654;
        bh=xcln59B/D8FFhOimrm9JH6nQYEfph3E/w+u5VM9RpVc=;
        h=From:To:Cc:Subject:Date:From;
        b=pGwuoR2As36xjopUMBWI35yqE5WaNaRQOuMjEha245eOPRI69HFhPEKGuw1rBxaFi
         b2oE7U6yFsMcCIzEsnVTzOimLeFTSB8edtyV+36qbaQd43vUAMfwo8XscvDNw+0Ms5
         yGkkZ2HZUF0ov0heWwC/vPkzvWeMBvzhVBQLiZYdrQWlRFJ319zbMBgjKw+Bxl+BB/
         CPd+sA/eAR9zbhW+6Zh2LigJtcrMarRrtrepgNfX0YoXxMldYB8VEEL9jnp3pWlGOm
         d1wgmhTciN93HIfal9/GII/3p3ue/DTRpHZD674p5+7To7soIaQwFjBpf7t08QoaOW
         eEjzBBYii/PiA==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH v2 00/11] efi: Clean up runtime wrapper and wire it up for PRM
Date:   Fri, 18 Aug 2023 13:37:13 +0200
Message-Id: <20230818113724.368492-1-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3585; i=ardb@kernel.org; h=from:subject; bh=xcln59B/D8FFhOimrm9JH6nQYEfph3E/w+u5VM9RpVc=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIeV++OuE1Jnvy/w4A9XTpksdrl07w7z1ZHj9SembKwvXy j4P/3aso5SFQYyDQVZMkUVg9t93O09PlKp1niULM4eVCWQIAxenAExkZgEjw92OLLbdU89ty1r0 +9L0v6rJT55WmUzoDFKpEK5aGnXgpTojw6PN+Smhy012LOpznabTEhTk9thp9am4FtaDCU7PVF8 7swIA
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

ACPI PRM uses the EFI runtime services infrastructure, but currently, it
issues the firmware calls directly, instead of going through the
wrappers and handing off the call to the EFI workqueue.

Given that ACPI PRM is used for vendor code rather than core EFI runtime
services, it would be nice if these calls get sandboxed in the same way
as EFI runtime services calls are. This ensures that any faults
occurring in the firmware are handled gracefully and don't bring down
the kernel.

Another reason for using the work queue is the fact that on some
platforms, the EFI memory regions are remapped into the lower address
space, and this means that sampling the instruction pointer in a perf
interrupt may cause confusion about whether the task is running in user
space or in the firmware.

So let's move the ACPI PRM calls into the EFI runtime wrapper
infrastructure. Before that, let's clean it up a bit.

Changes since v2:
- add patches to move EFI runtime setup/teardown sequences out of line
- add patch to deduplicate setup/teardown function calls in the
  workqueue handler
- some whitespace cleanup and added a missing __init
- add RFC patches to drop EFI runtime asm trampoline from x86
- add Rafael's ack to the patch that touches drivers/acpi/

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>

Ard Biesheuvel (11):
  efi/x86: Move EFI runtime call setup/teardown helpers out of line
  efi/arm64: Move EFI runtime call setup/teardown helpers out of line
  efi/riscv: Move EFI runtime call setup/teardown helpers out of line
  efi/runtime-wrappers: Use type safe encapsulation of call arguments
  efi/runtime-wrapper: Move workqueue manipulation out of line
  efi/runtime-wrappers: Remove duplicated macro for service returning
    void
  efi/runtime-wrappers: Don't duplicate setup/teardown code
  acpi/prmt: Use EFI runtime sandbox to invoke PRM handlers
  efi/runtime-wrappers: Clean up white space and add __init annotation
  efi/x86: Realign EFI runtime stack
  efi/x86: Rely on compiler to emit MS ABI calls

 arch/arm64/include/asm/efi.h            |  18 +-
 arch/arm64/kernel/efi.c                 |  16 +-
 arch/riscv/include/asm/efi.h            |  10 +-
 arch/x86/Makefile                       |   3 +
 arch/x86/include/asm/efi.h              |  43 +--
 arch/x86/include/asm/uv/bios.h          |   3 +-
 arch/x86/platform/efi/Makefile          |   6 +-
 arch/x86/platform/efi/efi_32.c          |  12 +
 arch/x86/platform/efi/efi_64.c          |  21 +-
 arch/x86/platform/efi/efi_stub_64.S     |  27 --
 arch/x86/platform/uv/Makefile           |   1 +
 arch/x86/platform/uv/bios_uv.c          |   4 +-
 drivers/acpi/Kconfig                    |   2 +-
 drivers/acpi/prmt.c                     |   8 +-
 drivers/firmware/efi/Makefile           |   1 +
 drivers/firmware/efi/riscv-runtime.c    |  15 +-
 drivers/firmware/efi/runtime-wrappers.c | 376 +++++++++++++-------
 include/linux/efi.h                     |  52 ++-
 18 files changed, 353 insertions(+), 265 deletions(-)
 delete mode 100644 arch/x86/platform/efi/efi_stub_64.S

-- 
2.39.2

