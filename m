Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7C3160568
	for <lists+linux-efi@lfdr.de>; Sun, 16 Feb 2020 19:24:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728116AbgBPSYe (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 16 Feb 2020 13:24:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:33566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728011AbgBPSYJ (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sun, 16 Feb 2020 13:24:09 -0500
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2223522B48;
        Sun, 16 Feb 2020 18:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581877448;
        bh=VYuJuZnaa051raJcxOzrSPyvqDyaPJlw5R0zDN1unHw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XJsmffHbmCBdu7JcFJ4AtluEOljB9p+FpodsStoYzM1kZcZvTtV2p9zvBvQ0zk40w
         8ylvOxwyByUk3XTUgse1ulLm6wGJ19alcZdVxNs1kiX1AXolaFY8eC75KWeez4Q5RQ
         hHs8oavQvDBuPU62ACbf2DHdvkpHoHV/d1MVSKOU=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>, nivedita@alum.mit.edu,
        x86@kernel.org
Subject: [PATCH 13/18] efi/x86: remove runtime table address from kexec EFI setup data
Date:   Sun, 16 Feb 2020 19:23:29 +0100
Message-Id: <20200216182334.8121-14-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200216182334.8121-1-ardb@kernel.org>
References: <20200216182334.8121-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Since commit 33b85447fa61946b ("efi/x86: Drop two near identical versions
of efi_runtime_init()"), we no longer map the EFI runtime services table
before calling SetVirtualAddressMap(), which means we don't need the 1:1
mapped physical address of this table, and so there is no point in passing
the address via EFI setup data on kexec boot.

Note that the kexec tools will still look for this address in sysfs, so
we still need to provide it.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/include/asm/efi.h        | 1 -
 arch/x86/kernel/kexec-bzimage64.c | 1 -
 arch/x86/platform/efi/efi.c       | 4 +---
 3 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
index fcb21e3d13c5..ee867f01b2f6 100644
--- a/arch/x86/include/asm/efi.h
+++ b/arch/x86/include/asm/efi.h
@@ -178,7 +178,6 @@ extern void __init efi_uv1_memmap_phys_epilog(pgd_t *save_pgd);
 
 struct efi_setup_data {
 	u64 fw_vendor;
-	u64 runtime;
 	u64 tables;
 	u64 smbios;
 	u64 reserved[8];
diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
index f293d872602a..f400678bd345 100644
--- a/arch/x86/kernel/kexec-bzimage64.c
+++ b/arch/x86/kernel/kexec-bzimage64.c
@@ -142,7 +142,6 @@ prepare_add_efi_setup_data(struct boot_params *params,
 	struct efi_setup_data *esd = (void *)sd + sizeof(struct setup_data);
 
 	esd->fw_vendor = efi.fw_vendor;
-	esd->runtime = efi.runtime;
 	esd->tables = efi.config_table;
 	esd->smbios = efi.smbios;
 
diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
index f7025b9075b4..c1f5f229cb02 100644
--- a/arch/x86/platform/efi/efi.c
+++ b/arch/x86/platform/efi/efi.c
@@ -379,6 +379,7 @@ static int __init efi_systab_init(u64 phys)
 			 systab64->con_out		> U32_MAX ||
 			 systab64->stderr_handle	> U32_MAX ||
 			 systab64->stderr		> U32_MAX ||
+			 systab64->runtime		> U32_MAX ||
 			 systab64->boottime		> U32_MAX;
 
 		if (efi_setup) {
@@ -391,17 +392,14 @@ static int __init efi_systab_init(u64 phys)
 			}
 
 			efi_systab.fw_vendor	= (unsigned long)data->fw_vendor;
-			efi_systab.runtime	= (void *)(unsigned long)data->runtime;
 			efi_systab.tables	= (unsigned long)data->tables;
 
 			over4g |= data->fw_vendor	> U32_MAX ||
-				  data->runtime		> U32_MAX ||
 				  data->tables		> U32_MAX;
 
 			early_memunmap(data, sizeof(*data));
 		} else {
 			over4g |= systab64->fw_vendor	> U32_MAX ||
-				  systab64->runtime	> U32_MAX ||
 				  systab64->tables	> U32_MAX;
 		}
 	} else {
-- 
2.17.1

