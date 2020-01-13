Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A211913978F
	for <lists+linux-efi@lfdr.de>; Mon, 13 Jan 2020 18:24:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729009AbgAMRYA (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 13 Jan 2020 12:24:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:41764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728850AbgAMRXS (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 13 Jan 2020 12:23:18 -0500
Received: from dogfood.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 10C43206DA;
        Mon, 13 Jan 2020 17:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578936197;
        bh=f7ymohb97S6b58KJNRXy0ZTCMS6AMDRFCM6vKzcZbSc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=z2fLnfDjeLLXm+R00A0QgLFKw1e9CTcm2vmKN1TxwkXfNKHwDPibnlyE1BTgJF1rm
         IPl0O6ezRM94ccQvwNGFbeO6CcVDzVea5DCRo9a2RWXrjSNMDKh8NFWx26iCweqxm/
         3WZFHeKW88kbnS2nKpTEc7N8hseF+VEHS+UA0EOk=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Young <dyoung@redhat.com>,
        Saravana Kannan <saravanak@google.com>
Subject: [PATCH 05/13] efi/x86: don't map the entire kernel text RW for mixed mode
Date:   Mon, 13 Jan 2020 18:22:37 +0100
Message-Id: <20200113172245.27925-6-ardb@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200113172245.27925-1-ardb@kernel.org>
References: <20200113172245.27925-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The mixed mode thunking routine requires a part of it to be
mapped 1:1, and for this reason, we currently map the entire
kernel .text read/write in the EFI page tables, which is bad.

In fact, the kernel_map_pages_in_pgd() invocation that installs
this mapping is entirely redundant, since all of DRAM is already
1:1 mapped read/write in the EFI page tables when we reach this
point, which means that .rodata is mapped read-write as well.

So let's remap both .text and .rodata read-only in the EFI
page tables.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/platform/efi/efi_64.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/platform/efi/efi_64.c b/arch/x86/platform/efi/efi_64.c
index c13fa2150976..6ec58ff60b56 100644
--- a/arch/x86/platform/efi/efi_64.c
+++ b/arch/x86/platform/efi/efi_64.c
@@ -391,11 +391,11 @@ int __init efi_setup_page_tables(unsigned long pa_memmap, unsigned num_pages)
 
 	efi_scratch.phys_stack = page_to_phys(page + 1); /* stack grows down */
 
-	npages = (_etext - _text) >> PAGE_SHIFT;
+	npages = (__end_rodata_aligned - _text) >> PAGE_SHIFT;
 	text = __pa(_text);
 	pfn = text >> PAGE_SHIFT;
 
-	pf = _PAGE_RW | _PAGE_ENC;
+	pf = _PAGE_ENC;
 	if (kernel_map_pages_in_pgd(pgd, pfn, text, npages, pf)) {
 		pr_err("Failed to map kernel text 1:1\n");
 		return 1;
-- 
2.20.1

