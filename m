Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C5C014188B
	for <lists+linux-efi@lfdr.de>; Sat, 18 Jan 2020 17:57:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbgARQ5f (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 18 Jan 2020 11:57:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:52660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726413AbgARQ5f (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sat, 18 Jan 2020 11:57:35 -0500
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B62342469D;
        Sat, 18 Jan 2020 16:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579366655;
        bh=jIKAE/pvL06pbHIdOe3fF7yPZ7jOPYgt5n/SJ2vH6kE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ofvV3RE3h2E/ElsMlou3YwXrraZfOth4u78Q4aauCu1xWN559u89IG0dS9XyuGrRB
         rpzlcSV6J2guHEHPVMriIMKdJBMttAurI2vGxgybeW3Lzwfs8XyZAj/rnTNoldepLJ
         scXWA1vpPqJtXm0zJYaNJDvY4LVX57OMCY7paGMA=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     mingo@kernel.org, x86@kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>
Subject: [PATCH 1/3] efi/x86: avoid KASAN false positives when accessing the 1:1 mapping
Date:   Sat, 18 Jan 2020 17:57:03 +0100
Message-Id: <20200118165705.16544-2-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200118165705.16544-1-ardb@kernel.org>
References: <20200118165705.16544-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

When installing the EFI virtual address map during early boot, we
access the EFI system table to retrieve the 1:1 mapped address of
the SetVirtualAddressMap() EFI runtime service. This memory is not
known to KASAN, so on KASAN enabled builds, this may result in a
splat like

  ==================================================================
  BUG: KASAN: user-memory-access in efi_set_virtual_address_map+0x141/0x354
  Read of size 4 at addr 000000003fbeef38 by task swapper/0/0

  CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.5.0-rc5+ #758
  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
  Call Trace:
   dump_stack+0x8b/0xbb
   ? efi_set_virtual_address_map+0x141/0x354
   ? efi_set_virtual_address_map+0x141/0x354
   __kasan_report+0x176/0x192
   ? efi_set_virtual_address_map+0x141/0x354
   kasan_report+0xe/0x20
   efi_set_virtual_address_map+0x141/0x354
   ? efi_thunk_runtime_setup+0x148/0x148
   ? __inc_numa_state+0x19/0x90
   ? memcpy+0x34/0x50
   efi_enter_virtual_mode+0x5fd/0x67d
   start_kernel+0x5cd/0x682
   ? mem_encrypt_init+0x6/0x6
   ? x86_family+0x5/0x20
   ? load_ucode_bsp+0x46/0x154
   secondary_startup_64+0xa4/0xb0
  ==================================================================

Since this code runs only a single time during early boot, let's annotate
it as __no_sanitize_address so KASAN disregards it entirely.

Fixes: 698294704573 ("efi/x86: Split SetVirtualAddresMap() wrappers into ...")
Reported-by: Qian Cai <cai@lca.pw>
Cc: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/platform/efi/efi_64.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/x86/platform/efi/efi_64.c b/arch/x86/platform/efi/efi_64.c
index 8d1869ff1033..e2accfe636bd 100644
--- a/arch/x86/platform/efi/efi_64.c
+++ b/arch/x86/platform/efi/efi_64.c
@@ -543,7 +543,7 @@ static DEFINE_SPINLOCK(efi_runtime_lock);
 	__s;								\
 })
 
-static efi_status_t __init
+static efi_status_t __init __no_sanitize_address
 efi_thunk_set_virtual_address_map(unsigned long memory_map_size,
 				  unsigned long descriptor_size,
 				  u32 descriptor_version,
@@ -882,10 +882,11 @@ void __init efi_thunk_runtime_setup(void)
 	efi.query_capsule_caps = efi_thunk_query_capsule_caps;
 }
 
-efi_status_t __init efi_set_virtual_address_map(unsigned long memory_map_size,
-						unsigned long descriptor_size,
-						u32 descriptor_version,
-						efi_memory_desc_t *virtual_map)
+efi_status_t __init __no_sanitize_address
+efi_set_virtual_address_map(unsigned long memory_map_size,
+			    unsigned long descriptor_size,
+			    u32 descriptor_version,
+			    efi_memory_desc_t *virtual_map)
 {
 	efi_status_t status;
 	unsigned long flags;
-- 
2.17.1

