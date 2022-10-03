Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C9575F2F91
	for <lists+linux-efi@lfdr.de>; Mon,  3 Oct 2022 13:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbiJCL0l (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 3 Oct 2022 07:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbiJCL0f (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 3 Oct 2022 07:26:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1B622A96C
        for <linux-efi@vger.kernel.org>; Mon,  3 Oct 2022 04:26:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9D017B8105A
        for <linux-efi@vger.kernel.org>; Mon,  3 Oct 2022 11:26:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEFAFC433C1;
        Mon,  3 Oct 2022 11:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664796391;
        bh=wDKdvPqZk8WFP3BSEQAf+e1kb18kQtYKCBG/O7eLNv0=;
        h=From:To:Cc:Subject:Date:From;
        b=Ox1XEvSG5hre/gdrN8BcIEz5750FiEiwpqaTtH1yliO3nlxMWBlgLqBEP5e+DE03L
         v90fR6LmgX3pmCD68wFhPw52XWpwjN7AtUxY/C6T4OhaC8IJ7mueTOxoRBhZV/bjZR
         sHBJWb+xThSAUWMBUTBo5yCKmmhJVcaj5//6OJTiylgOZijQg6dDnDR870yDZP9vBB
         EruxTPvCJNuxS6rbfAntaK3i3lBF39S9Os1oFxTvGF5x4pw9HvXPUU3lt21bb+9qTz
         Qx0AFO/N5h0m9LJK2DUJq00+LzV7T56zwOTzist88UVsTx36ao1RaGFe73f0SaPDPL
         /6joHonQhT0qA==
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
Subject: [PATCH v2 0/6] efi/x86: Avoid corrupted config tables under Xen
Date:   Mon,  3 Oct 2022 13:26:19 +0200
Message-Id: <20221003112625.972646-1-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4415; i=ardb@kernel.org; h=from:subject; bh=wDKdvPqZk8WFP3BSEQAf+e1kb18kQtYKCBG/O7eLNv0=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjOsbUkV47vOIBB1yBzipVxR5+t08QxSlOcR7wO8t8 rB2jnJ2JAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYzrG1AAKCRDDTyI5ktmPJKXNC/ 4rqTC55/+RKNpsaZYCqdCfNe63UwVnTnjPbkbRZpnd1HZHDobN5uCK/Scgvs1lJzCwy9sP1/m2E5Yg L3ODc9VWyIAzw+23tHHYjh5y0f0s0uz3ZeKAFvZfijcuVHQxcMRPnyLZ9Rw9swyA7MFn62CZEiPO7n Yzp7ZfSMNgn2C9PbztvXbT8wOVpZTbOqcSpAZ3aEUc4qJmvcAYyAnGGAa11f9lGbyvqWUjXAWPxraA VgHZktlLipkXG/fUbz0pvIKd52bSamLGC781kUr2w6hntbI/gVpr2VUuMYhAkn2gUxMvSYkLEhKSgA Qa1DdsFZiJODc41MuBwKn/oLwWKO4gmpMwdvpFx6Lv5BMTFMa3aYH9aPX9+aWeHrbNCt4RYX8X3mLa lyV4lr0XPQFHKhLvMnq5QO3tLe/y+etF1IsUkc2fA0kk0lfhcnKjB8j3Dhl8pq6vC8DiN/4CwIMeBe T4lYzxP2oKyxRfFUOf9CX/QhXswyXc9139KispRVezaqw=
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

Patch #4 refactors the ESRT sanity checks on the memory descriptor, by
moving them into the efi_mem_desc_lookup() helper, which should not
return corrupted descriptors in the first place.

Patch #5 adds a Xen hypercall fallback to efi_mem_desc_lookup() when
running under Xen without a EFI memory map, so that, e.g., the existing
ESRT code will perform its validation against the Xen provided
descriptor if no memory map is available.

Patch #6 updates the config table traversal code so that the Xen glue
code can force them to be disregarded, which happens when the table in
question points into a memory region that is not of a type that Xen
automatically reserves. Future changes can refine this logic if needed.

Changes since v1:
- add patch #4
- move Xen descriptor lookup into efi_mem_desc_lookup()
- drop allowlist for ACPI and SMBIOS tables

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

Ard Biesheuvel (6):
  efi: Move EFI fake memmap support into x86 arch tree
  efi: memmap: Move manipulation routines into x86 arch tree
  efi: xen: Set EFI_PARAVIRT for Xen dom0 boot on all architectures
  efi: memmap: Disregard bogus entries instead of returning them
  efi: xen: Implement memory descriptor lookup based on hypercall
  efi: Apply allowlist to EFI configuration tables when running under
    Xen

 arch/x86/Kconfig                                       |  20 ++
 arch/x86/include/asm/efi.h                             |  16 ++
 arch/x86/kernel/setup.c                                |   1 +
 arch/x86/platform/efi/Makefile                         |   4 +-
 arch/x86/platform/efi/efi.c                            |   8 +-
 {drivers/firmware => arch/x86/platform}/efi/fake_mem.c |  79 ++++++-
 arch/x86/platform/efi/memmap.c                         | 238 ++++++++++++++++++++
 drivers/firmware/efi/Kconfig                           |  22 --
 drivers/firmware/efi/Makefile                          |   4 -
 drivers/firmware/efi/efi.c                             |  25 +-
 drivers/firmware/efi/esrt.c                            |  18 +-
 drivers/firmware/efi/fake_mem.h                        |  10 -
 drivers/firmware/efi/fdtparams.c                       |   4 +
 drivers/firmware/efi/memmap.c                          | 224 +-----------------
 drivers/firmware/efi/x86_fake_mem.c                    |  75 ------
 drivers/xen/efi.c                                      |  58 +++++
 include/linux/efi.h                                    |  19 +-
 17 files changed, 446 insertions(+), 379 deletions(-)
 rename {drivers/firmware => arch/x86/platform}/efi/fake_mem.c (58%)
 create mode 100644 arch/x86/platform/efi/memmap.c
 delete mode 100644 drivers/firmware/efi/fake_mem.h
 delete mode 100644 drivers/firmware/efi/x86_fake_mem.c

-- 
2.35.1

