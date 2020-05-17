Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B7821D6820
	for <lists+linux-efi@lfdr.de>; Sun, 17 May 2020 14:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727910AbgEQM66 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 17 May 2020 08:58:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:51956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728035AbgEQM65 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sun, 17 May 2020 08:58:57 -0400
Received: from e123331-lin.nice.arm.com (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7AB0420825;
        Sun, 17 May 2020 12:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589720336;
        bh=oOhRo7vJXpfA5fYUJ8MfcQCIzfp14pkZq5YYCY2YfQk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kPDf7YbdxbPax5Dz2wQzwEmVSWDMhDPpi8e+2b2+vjC2WaPVeu361iLSqaf3+MzNZ
         UeD9vAY2NM3XvEVeeyo7SwvFRsAI/c0eMVTQsvSdo4pA7+Vuy3MrbXPenaI79ZB6a1
         jokICm1lL/JnreJIIOGfiMOhW/hNlYLBuyc88bXM=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Benjamin Thiel <b.thiel@posteo.de>,
        Borislav Petkov <bp@alien8.de>, Dave Young <dyoung@redhat.com>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Lenny Szubowicz <lszubowi@redhat.com>,
        linux-acpi@vger.kernel.org, Loic Yhuel <loic.yhuel@gmail.com>,
        Matthew Garrett <mjg59@google.com>,
        Mike Lothian <mike@fireburn.co.uk>,
        Punit Agrawal <punit1.agrawal@toshiba.co.jp>
Subject: [PATCH 6/7] efi: Pull up arch-specific prototype efi_systab_show_arch()
Date:   Sun, 17 May 2020 14:57:53 +0200
Message-Id: <20200517125754.8934-7-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200517125754.8934-1-ardb@kernel.org>
References: <20200517125754.8934-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Benjamin Thiel <b.thiel@posteo.de>

Pull up arch-specific prototype efi_systab_show_arch() in order to
fix a -Wmissing-prototypes warning:

arch/x86/platform/efi/efi.c:957:7: warning: no previous prototype for
‘efi_systab_show_arch’ [-Wmissing-prototypes]
char *efi_systab_show_arch(char *str)

Signed-off-by: Benjamin Thiel <b.thiel@posteo.de>
Link: https://lore.kernel.org/r/20200516132647.14568-1-b.thiel@posteo.de
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/efi.c | 5 +----
 include/linux/efi.h        | 2 ++
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 911a2bd0f6b7..4e3055238f31 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -130,11 +130,8 @@ static ssize_t systab_show(struct kobject *kobj,
 	if (efi.smbios != EFI_INVALID_TABLE_ADDR)
 		str += sprintf(str, "SMBIOS=0x%lx\n", efi.smbios);
 
-	if (IS_ENABLED(CONFIG_IA64) || IS_ENABLED(CONFIG_X86)) {
-		extern char *efi_systab_show_arch(char *str);
-
+	if (IS_ENABLED(CONFIG_IA64) || IS_ENABLED(CONFIG_X86))
 		str = efi_systab_show_arch(str);
-	}
 
 	return str - buf;
 }
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 251f1f783cdf..9430d01c0c3d 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1245,4 +1245,6 @@ struct linux_efi_memreserve {
 
 void __init efi_arch_mem_reserve(phys_addr_t addr, u64 size);
 
+char *efi_systab_show_arch(char *str);
+
 #endif /* _LINUX_EFI_H */
-- 
2.17.1

