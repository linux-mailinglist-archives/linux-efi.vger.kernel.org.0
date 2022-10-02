Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C907D5F2269
	for <lists+linux-efi@lfdr.de>; Sun,  2 Oct 2022 11:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229441AbiJBJ4j (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 2 Oct 2022 05:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiJBJ4i (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 2 Oct 2022 05:56:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D4BE2409F
        for <linux-efi@vger.kernel.org>; Sun,  2 Oct 2022 02:56:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AC26360EA4
        for <linux-efi@vger.kernel.org>; Sun,  2 Oct 2022 09:56:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29E61C433D6;
        Sun,  2 Oct 2022 09:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664704595;
        bh=7esb6YPYkrd+cv3sS3o+s4EfXDusBD+g0wEqShG+32A=;
        h=From:To:Cc:Subject:Date:From;
        b=Ss07N6JmrKfUNdOIENH6an0d3hWbHND736qLLMDXCxQM2oV4U1cDSRv6nJxu2LLEq
         Mk7qpOotNHug4RUHT4u9kC57w/LglOizLgvaOIUPvnmy477ScfkxZrR0kDD2LAR6cI
         LtpD0H8D1PQIpzPIMImjJ9t6yR/akd05lY4iDQwZnOVgP8nDkGmeSKX145fcXRZ0gG
         Zk3cKVHe+uonWMKGYcGLVT43hcoQmc106v+uVRfSods3/DldarES6io6joTfzUI+sq
         xYpePyNbazkr8V9aN7N6Dq5QUZrwPHIxBVDD0oHx/RY9WE4DV1NCHF2q4RHkmcRFmE
         QgTGDwUVsCBzg==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     xen-devel@lists.xenproject.org, Ard Biesheuvel <ardb@kernel.org>,
        Demi Marie Obenour <demi@invisiblethingslab.com>,
        Peter Jones <pjones@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        =?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>
Subject: [RFC PATCH 0/5] efi/x86: Avoid corrupted config tables under Xen
Date:   Sun,  2 Oct 2022 11:56:21 +0200
Message-Id: <20221002095626.484279-1-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4408; i=ardb@kernel.org; h=from:subject; bh=7esb6YPYkrd+cv3sS3o+s4EfXDusBD+g0wEqShG+32A=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjOWA6KKLbNxdyE3WYFUnkIoD4K2KMxMzVqnB/MmcB FkQw2BSJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYzlgOgAKCRDDTyI5ktmPJJY3DA CAD6udbDfm1DhJmdyq4SARqiM82Wf/BNTqMuN4SnN/W8hyK1eNLXIbdtLOGZlIuoRe+ZXTt+DOWT21 T7JZjSQV3RCEayhduxEVc10dD2b4ILPXhBQYZ4Exe38ieW66inG3Ce4WB2w/o5xx6w6GthtAk9ndQu LT7hDZymIoqNDFWxqq6qVfdTSGAgLPF35zZAMYOXT1RJ8RI4o0O9p4SsFBtaLFhunDZSrmmCkGZ5Kj FXwUQET3WbaQLR72VXK3H4izixs9JuWMEg6gi/JppvQvIhTpIjtw6fO1lLJm4LSBzdAEulZePxi1ch sEy9MiI42BFPJ1yphzQGD9OqVQiYck5F5UM3IrTCJFDrvlb8BcWsrbXAipOCZt0SBJkEEF+BzKfqS3 i2WnhhgDt/8MMEURMV2s+F7BzgwFv1ShoUXY03AstIYkIHOt6OTKf1S6GcKMA0dd6GE2WSbaplWkRd tFf+MQOdFpOKBDKn4rHpP2vXo/DsbpuHgD5U+H7xmMOyk=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

This is an alternate approach to addressing the issue that Demi Marie is
attempting to fix in [0] (i.e., ESRT config table exposed to a x86 dom0
is corrupted because it resides in boot services memory as per the EFI
spec, where it gets corrupted by Xen). My main objection to that approach
is that it needs Xen-specific fixes in multiple different places, but we
still end up only fixing the ESRT case specifically.

So instead, I am proposing this series as a more generic way to handle
configuration tables that reside in boot services memory, and confining
the Xen specific logic to the Xen EFI glue code.

Given that EFI boot without a memory map is only permitted on x86 and
only when doing Xen boot, let's clear up some inconsistencies there
first so we can set the EFI_PARAVIRT flag on all architectures that do
pseudo-EFI boot straight into the core kernel (i.e., without going
through the stub). This moves a good chunk of EFI memory map
manipulation code into the x86 arch tree, where it arguably belongs as
no other architectures rely on it. This is implemented in patches 1 - 3.

Patch #4 updates the configuration table iteration logic so that only
ACPI and SMBIOS tables are exposed automatically when EFI_PARAVIRT is
set, and other config tables only if they reside in a memory region of a
EFI memory type that is guaranteed to be preserved. This effectively
hides the ESRT, but also the memory attributes table and the runtime
properties (and potentially others) when doing Xen dom0 boot unless they
have been moved out of EFI boot services memory.

The final patch relaxes the ESRT sanity check so that the ESRT is parsed
and exposed even if EFI_MEMMAP is not set, which is the case with Xen
dom0 on x86. If additional memory map checks are required in this code
path, the best way to achieve this is for Xen to expose a EFI memory map
on x86 just like it does on other architectures that support Xen (ARM
and arm64)

[0] https://lore.kernel.org/all/cover.1664298147.git.demi@invisiblethingslab.com/

Cc: Demi Marie Obenour <demi@invisiblethingslab.com>
Cc: Peter Jones <pjones@redhat.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Anton Vorontsov <anton@enomsg.org>
Cc: Colin Cross <ccross@android.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Marek Marczykowski-Górecki <marmarek@invisiblethingslab.com>

Ard Biesheuvel (5):
  efi: Move EFI fake memmap support into x86 arch tree
  efi: memmap: Move manipulation routines into x86 arch tree
  efi: xen: Set EFI_PARAVIRT for Xen dom0 boot on all architectures
  efi: Apply allowlist to EFI configuration tables when running under
    Xen
  efi: esrt: Omit region sanity check when no memory map is available

 arch/x86/Kconfig                                       |  20 ++
 arch/x86/include/asm/efi.h                             |  16 ++
 arch/x86/kernel/setup.c                                |   1 +
 arch/x86/platform/efi/Makefile                         |   4 +-
 arch/x86/platform/efi/efi.c                            |   8 +-
 {drivers/firmware => arch/x86/platform}/efi/fake_mem.c |  79 ++++++-
 arch/x86/platform/efi/memmap.c                         | 238 ++++++++++++++++++++
 arch/x86/platform/efi/quirks.c                         |   3 +
 drivers/firmware/efi/Kconfig                           |  22 --
 drivers/firmware/efi/Makefile                          |   4 -
 drivers/firmware/efi/efi.c                             |   7 +
 drivers/firmware/efi/esrt.c                            |  61 ++---
 drivers/firmware/efi/fake_mem.h                        |  10 -
 drivers/firmware/efi/fdtparams.c                       |   4 +
 drivers/firmware/efi/memmap.c                          | 224 +-----------------
 drivers/firmware/efi/x86_fake_mem.c                    |  75 ------
 drivers/xen/efi.c                                      |  69 ++++++
 include/linux/efi.h                                    |  18 +-
 18 files changed, 481 insertions(+), 382 deletions(-)
 rename {drivers/firmware => arch/x86/platform}/efi/fake_mem.c (58%)
 create mode 100644 arch/x86/platform/efi/memmap.c
 delete mode 100644 drivers/firmware/efi/fake_mem.h
 delete mode 100644 drivers/firmware/efi/x86_fake_mem.c

-- 
2.35.1

