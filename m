Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C90A5160560
	for <lists+linux-efi@lfdr.de>; Sun, 16 Feb 2020 19:24:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728088AbgBPSYM (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 16 Feb 2020 13:24:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:33644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728086AbgBPSYM (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sun, 16 Feb 2020 13:24:12 -0500
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 799F2208C4;
        Sun, 16 Feb 2020 18:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581877451;
        bh=OxGn9R5ntWFnT5wJ6BdqGbw1uixdFfwfbWefP91OvJs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JnsxNCD+1RLneTNgq/CogMRQxYifR6C7GyaugkwWdw/+gaqMhMpEPZKvjCCGbOX9c
         Pd7L6rWpuxTlucWjnFEMqJaJjSDjgtFRnve0YDty6fAdZpvuDc4qstmhQGQCtZ+M80
         oMMvPD93iiq+y9hPh6mlYvncMNJw4vYs20zRtSdM=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>, nivedita@alum.mit.edu,
        x86@kernel.org
Subject: [PATCH 15/18] efi/x86: merge assignments of efi.runtime_version
Date:   Sun, 16 Feb 2020 19:23:31 +0100
Message-Id: <20200216182334.8121-16-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200216182334.8121-1-ardb@kernel.org>
References: <20200216182334.8121-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

efi.runtime_version is always set to the same value on both
existing code paths, so just set it earlier from a shared one.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/platform/efi/efi.c | 19 ++-----------------
 1 file changed, 2 insertions(+), 17 deletions(-)

diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
index 54ada9f9612e..57651facb99d 100644
--- a/arch/x86/platform/efi/efi.c
+++ b/arch/x86/platform/efi/efi.c
@@ -423,6 +423,8 @@ static int __init efi_systab_init(u64 phys)
 		efi_systab.tables		= systab32->tables;
 	}
 
+	efi.runtime_version = hdr->revision;
+
 	efi_systab_report_header(hdr, efi_systab.fw_vendor);
 	early_memunmap(p, size);
 
@@ -873,15 +875,6 @@ static void __init kexec_enter_virtual_mode(void)
 	}
 
 	efi_sync_low_kernel_mappings();
-
-	/*
-	 * Now that EFI is in virtual mode, update the function
-	 * pointers in the runtime service table to the new virtual addresses.
-	 *
-	 * Call EFI services through wrapper functions.
-	 */
-	efi.runtime_version = efi_systab.hdr.revision;
-
 	efi_native_runtime_setup();
 #endif
 }
@@ -968,14 +961,6 @@ static void __init __efi_enter_virtual_mode(void)
 
 	efi_free_boot_services();
 
-	/*
-	 * Now that EFI is in virtual mode, update the function
-	 * pointers in the runtime service table to the new virtual addresses.
-	 *
-	 * Call EFI services through wrapper functions.
-	 */
-	efi.runtime_version = efi_systab.hdr.revision;
-
 	if (!efi_is_mixed())
 		efi_native_runtime_setup();
 	else
-- 
2.17.1

