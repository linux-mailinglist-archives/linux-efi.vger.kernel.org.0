Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8F212B5DB
	for <lists+linux-efi@lfdr.de>; Fri, 27 Dec 2019 17:34:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbfL0QeQ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 27 Dec 2019 11:34:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:46562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726379AbfL0QeQ (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 27 Dec 2019 11:34:16 -0500
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B69A2173E;
        Fri, 27 Dec 2019 16:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577464455;
        bh=/ce2ChLDw0QLOYk5XALfZjodb4g3teQx58NEvyAvA88=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Cn7oT7Fv+pSN16jfqC2ChE2cGsRJpggMf8O5vSCs6LVtg89SmB/vEF3uTPeK9cvpg
         DBgHc6nTBeJBTa52W48Kr+oflyEjUHr3XFkZdqX6n49WxOOX3HG9r0J613EYTLzyGf
         vZ/J/u70f9YW1XN1Jtx+fnIkxyX27MiPVMIpR+zI=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     nivedita@alum.mit.edu, hdegoede@redhat.com,
        Ard Biesheuvel <ardb@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: [PATCH 1/3] x86/mm: fix NX bit clearing issue in kernel_map_pages_in_pgd
Date:   Fri, 27 Dec 2019 17:34:16 +0100
Message-Id: <20191227163418.16139-2-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191227163418.16139-1-ardb@kernel.org>
References: <20191227163418.16139-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Commit 15f003d20782 ("x86/mm/pat: Don't implicitly allow _PAGE_RW in
kernel_map_pages_in_pgd()") modified kernel_map_pages_in_pgd() to
manage writable permissions of memory mappings in the EFI page
table in a different way, but in the process, it removed the
ability to clear NX attributes from read-only mappings, by
clobbering the clear mask if _PAGE_RW is not being requested.

Failure to remove the NX attribute from read-only mappings is
unlikely to be a security issue, but it does prevent us from
tightening the permissions in the EFI page tables going forward,
so let's fix it now.

Fixes: 15f003d20782 ("x86/mm/pat: Don't implicitly allow _PAGE_RW in kernel_map_pages_in_pgd()
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/mm/pageattr.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/x86/mm/pageattr.c b/arch/x86/mm/pageattr.c
index 1b99ad05b117..f42780ba0893 100644
--- a/arch/x86/mm/pageattr.c
+++ b/arch/x86/mm/pageattr.c
@@ -2215,7 +2215,7 @@ int __init kernel_map_pages_in_pgd(pgd_t *pgd, u64 pfn, unsigned long address,
 		.pgd = pgd,
 		.numpages = numpages,
 		.mask_set = __pgprot(0),
-		.mask_clr = __pgprot(0),
+		.mask_clr = __pgprot(~page_flags & (_PAGE_NX|_PAGE_RW)),
 		.flags = 0,
 	};
 
@@ -2224,12 +2224,6 @@ int __init kernel_map_pages_in_pgd(pgd_t *pgd, u64 pfn, unsigned long address,
 	if (!(__supported_pte_mask & _PAGE_NX))
 		goto out;
 
-	if (!(page_flags & _PAGE_NX))
-		cpa.mask_clr = __pgprot(_PAGE_NX);
-
-	if (!(page_flags & _PAGE_RW))
-		cpa.mask_clr = __pgprot(_PAGE_RW);
-
 	if (!(page_flags & _PAGE_ENC))
 		cpa.mask_clr = pgprot_encrypted(cpa.mask_clr);
 
-- 
2.17.1

