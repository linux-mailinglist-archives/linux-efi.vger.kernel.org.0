Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 250331A4315
	for <lists+linux-efi@lfdr.de>; Fri, 10 Apr 2020 09:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725912AbgDJHnd (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 10 Apr 2020 03:43:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:36406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725776AbgDJHnd (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 10 Apr 2020 03:43:33 -0400
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7EA1420787;
        Fri, 10 Apr 2020 07:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586504613;
        bh=O4sEanPgCo1lB0VrgCWXgeWGopzIofEHfpCTa4vyuX0=;
        h=From:To:Cc:Subject:Date:From;
        b=cxi4yaVXlz6aDCRADSw+2/v0G0en3J7CjS0K0EpyTCK1nDg/gJr0yomm3HHU+TglJ
         ooQB4BEYxCPW1ll96digPIN2SmRxoRUNZ8rkUzV2ut6fHtpDWrNL6i1QQWL7GjnQ9+
         KYOpkKxc0u502bw2bwFJj+9xrhDHUz9X2FA4Jv+E=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     x86@kernel.org, tytso@mit.edu, bp@alien8.de, mingo@kernel.org,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH] efi/x86: Revert struct layout change to fix kexec boot regression
Date:   Fri, 10 Apr 2020 09:43:20 +0200
Message-Id: <20200410074320.16589-1-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Commit

  0a67361dcdaa29 ("efi/x86: Remove runtime table address from kexec EFI setup data")

removed the code that retrieves the non-remapped UEFI runtime services
pointer from the data structure provided by kexec, as it was never really
needed on the kexec boot path: mapping the runtime services table at its
non-remapped address is only needed when calling SetVirtualAddressMap(),
which never happens during a kexec boot in the first place.

However, dropping the 'runtime' member from struct efi_setup_data was a
mistake. That struct is shared ABI between the kernel and the kexec tooling
for x86, and so we cannot simply change its layout. So let's put back the
removed field, but call it 'unused' to reflect the fact that we never look
at its contents. While at it, add a comment to remind our future selves
that the layout is external ABI.

Reported-by: Theodore Ts'o <tytso@mit.edu>
Tested-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---

Ingo, Thomas, Boris: I sent out my efi-urgent pull request just yesterday,
so please take this directly into tip:efi/urgent - no need to wait for the
next batch.

 arch/x86/include/asm/efi.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
index 781170d36f50..96044c8d8600 100644
--- a/arch/x86/include/asm/efi.h
+++ b/arch/x86/include/asm/efi.h
@@ -178,8 +178,10 @@ extern void efi_free_boot_services(void);
 extern pgd_t * __init efi_uv1_memmap_phys_prolog(void);
 extern void __init efi_uv1_memmap_phys_epilog(pgd_t *save_pgd);
 
+/* kexec external ABI */
 struct efi_setup_data {
 	u64 fw_vendor;
+	u64 unused;
 	u64 tables;
 	u64 smbios;
 	u64 reserved[8];
-- 
2.17.1

