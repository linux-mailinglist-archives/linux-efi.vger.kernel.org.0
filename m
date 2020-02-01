Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36B1C14FAF4
	for <lists+linux-efi@lfdr.de>; Sun,  2 Feb 2020 00:33:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbgBAXdK (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 1 Feb 2020 18:33:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:45402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726487AbgBAXdK (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sat, 1 Feb 2020 18:33:10 -0500
Received: from e123331-lin.c.hoisthospitality.com (dc3829c8a.static.telenet.be [195.130.156.138])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 399B920661;
        Sat,  1 Feb 2020 23:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580599989;
        bh=ibe5zB2LbJa9M16STV/YOipNz1Z/ySZpDzrVbsEINmw=;
        h=From:To:Cc:Subject:Date:From;
        b=GBdP1Kq5tcMphjjYV89zzrRs4EuDpeKKIm1QCK0tdy+gvcZX8B5Z7GT3lkb2zLmNw
         YnlubFz5cmaDpFN6Zhw9hwt+SJs+36Q/+6zIJT4jFgogZNDmsdfNQ0sGjFgB56Fdt0
         f+L4FxvCyM+EmZ91miH97xxmyBX019Bs9XHXW/O8=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     x86@kernel.org, dan.j.williams@intel.com, jrg.otte@gmail.com,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        mingo@kernel.org, Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH] efi/x86: fix boot regression on systems with invalid memmap entries
Date:   Sun,  2 Feb 2020 00:33:04 +0100
Message-Id: <20200201233304.18322-1-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

In efi_clean_memmap(), we do a pass over the EFI memory map to remove
bogus entries that may be returned on certain systems.

Commit 1db91035d01aa8bf ("efi: Add tracking for dynamically allocated
memmaps") refactored this code to pass the input to efi_memmap_install()
via a temporary struct on the stack, which is populated using an
initializer which inadvertently defines the value of its size field
in terms of its desc_size field, which value cannot be relied upon yet
in the initializer itself.

Fix this by using efi.memmap.desc_size instead, which is where we get
the value for desc_size from in the first place.

Tested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/platform/efi/efi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
index 59f7f6d60cf6..ae923ee8e2b4 100644
--- a/arch/x86/platform/efi/efi.c
+++ b/arch/x86/platform/efi/efi.c
@@ -308,7 +308,7 @@ static void __init efi_clean_memmap(void)
 			.phys_map = efi.memmap.phys_map,
 			.desc_version = efi.memmap.desc_version,
 			.desc_size = efi.memmap.desc_size,
-			.size = data.desc_size * (efi.memmap.nr_map - n_removal),
+			.size = efi.memmap.desc_size * (efi.memmap.nr_map - n_removal),
 			.flags = 0,
 		};
 
-- 
2.17.1

