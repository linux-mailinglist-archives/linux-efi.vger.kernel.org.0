Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76EE244BF41
	for <lists+linux-efi@lfdr.de>; Wed, 10 Nov 2021 11:56:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231464AbhKJK7j (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 10 Nov 2021 05:59:39 -0500
Received: from mail.ispras.ru ([83.149.199.84]:53892 "EHLO mail.ispras.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231248AbhKJK7i (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 10 Nov 2021 05:59:38 -0500
X-Greylist: delayed 585 seconds by postgrey-1.27 at vger.kernel.org; Wed, 10 Nov 2021 05:59:35 EST
Received: from localhost.localdomain (unknown [80.240.223.29])
        by mail.ispras.ru (Postfix) with ESMTPSA id EB4B640A2BCC;
        Wed, 10 Nov 2021 10:47:02 +0000 (UTC)
From:   Baskov Evgeniy <baskov@ispras.ru>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Baskov Evgeniy <baskov@ispras.ru>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-doc@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH RFC 4/5] efi: Add option for handling efi memory protection
Date:   Wed, 10 Nov 2021 13:46:12 +0300
Message-Id: <20211110104613.23881-5-baskov@ispras.ru>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211110104613.23881-1-baskov@ispras.ru>
References: <20211110104613.23881-1-baskov@ispras.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Add option to enable handling strict page table permissions
added in previous patches.

Signed-off-by: Baskov Evgeniy <baskov@ispras.ru>
---
 drivers/firmware/efi/Kconfig | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
index 2c3dac5ecb36..f57a9c865dce 100644
--- a/drivers/firmware/efi/Kconfig
+++ b/drivers/firmware/efi/Kconfig
@@ -243,6 +243,23 @@ config EFI_DISABLE_PCI_DMA
 	  options "efi=disable_early_pci_dma" or "efi=no_disable_early_pci_dma"
 	  may be used to override this option.
 
+config EFI_STRICT_PGTABLE
+	bool "Handle strict page table permissions in libstub"
+	depends on EFI_STUB && X86
+	default y
+	help
+	  Some firmware disables execution of memory allocated in boot loader
+	  and/or lower megabyte of physical address space, since it is allowed
+	  by specification. That prevents Linux kernel from booting.
+
+	  This option makes libstub either create temporary identity mapped
+	  page tables with unset non-executable flag  on x86_64 or just disable
+	  paging altogether on i386 to overcome the issue.
+
+	  If firmware does not restrict permissions on identity page tables,
+	  temporary page table creation may be disabled with kernel command
+	  line option "efi=notemppt".
+
 endmenu
 
 config EFI_EMBEDDED_FIRMWARE
-- 
2.33.1

