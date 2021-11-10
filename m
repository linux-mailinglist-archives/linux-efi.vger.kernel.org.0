Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A4C644BF40
	for <lists+linux-efi@lfdr.de>; Wed, 10 Nov 2021 11:56:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231393AbhKJK7i (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 10 Nov 2021 05:59:38 -0500
Received: from mail.ispras.ru ([83.149.199.84]:53914 "EHLO mail.ispras.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231398AbhKJK7i (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 10 Nov 2021 05:59:38 -0500
X-Greylist: delayed 586 seconds by postgrey-1.27 at vger.kernel.org; Wed, 10 Nov 2021 05:59:37 EST
Received: from localhost.localdomain (unknown [80.240.223.29])
        by mail.ispras.ru (Postfix) with ESMTPSA id A635440A2BD7;
        Wed, 10 Nov 2021 10:47:03 +0000 (UTC)
From:   Baskov Evgeniy <baskov@ispras.ru>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Baskov Evgeniy <baskov@ispras.ru>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-doc@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH RFC 5/5] Docs: document notemppt option
Date:   Wed, 10 Nov 2021 13:46:13 +0300
Message-Id: <20211110104613.23881-6-baskov@ispras.ru>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211110104613.23881-1-baskov@ispras.ru>
References: <20211110104613.23881-1-baskov@ispras.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

This option allows to disable building temporary page tables when
booting via efistub with CONFIG_EFI_STRICT_PGTABLE enabled.

Signed-off-by: Baskov Evgeniy <baskov@ispras.ru>
---
 Documentation/admin-guide/kernel-parameters.txt | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 43dc35fe5bc0..0c4ed43cd13c 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1294,7 +1294,8 @@
 	efi=		[EFI]
 			Format: { "debug", "disable_early_pci_dma",
 				  "nochunk", "noruntime", "nosoftreserve",
-				  "novamap", "no_disable_early_pci_dma" }
+				  "novamap", "no_disable_early_pci_dma",
+				  "notemppt" }
 			debug: enable misc debug output.
 			disable_early_pci_dma: disable the busmaster bit on all
 			PCI bridges while in the EFI boot stub.
@@ -1311,6 +1312,10 @@
 			novamap: do not call SetVirtualAddressMap().
 			no_disable_early_pci_dma: Leave the busmaster bit set
 			on all PCI bridges while in the EFI boot stub
+			notemppt: disable temporary page table creation in EFISTUB
+			for CONFIG_EFI_STRICT_PGTABLE on x86_64. Can very slightly
+			increase boot speed. Page copying is not required by most
+			EFI implementations.
 
 	efi_no_storage_paranoia [EFI; X86]
 			Using this parameter you can use more than 50% of
-- 
2.33.1

