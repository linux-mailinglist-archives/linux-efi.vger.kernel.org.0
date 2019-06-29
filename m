Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41D4D5A993
	for <lists+linux-efi@lfdr.de>; Sat, 29 Jun 2019 10:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbfF2IYA (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 29 Jun 2019 04:24:00 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36246 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726872AbfF2IYA (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 29 Jun 2019 04:24:00 -0400
Received: by mail-wr1-f67.google.com with SMTP id n4so8558482wrs.3;
        Sat, 29 Jun 2019 01:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=wz9MuRcRQHuFynHDJ998w7L3YyTkzZbxNSj8T+XmXCU=;
        b=cwCqQLBLaWrQCVEjQwflsfJk4+ID2tkdbAi+qpTbDnbACvrB7KF6Ag5wGY+KGewn/O
         3z34KSm0VQRMASKhIke9Fal1ZIVyQCduGfEwbxJOMVaaeyBiGpHgxm7vjQZJyhv0AOB4
         cExOwG4aNPxrQGkZCwWbCxgTEhBs50Qjfg+2TBvsQER0dStQ61p1pi24Sr5HEnlQHZIi
         s8+4skiIs56RcJGT2k/i2KidJNW/iHmVX8OrKGsJpChzS8ZMyMOPl+6RQFLpEHmntCUS
         XciFMzG3sd9ayd8cbrndcsoOUWmwKwmJmtxuyykd39fGW4d1uUv34z+3Um7D4DdUOUqP
         zBbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=wz9MuRcRQHuFynHDJ998w7L3YyTkzZbxNSj8T+XmXCU=;
        b=ZK9kUY+YO73iPrlTglLCuE3Wxl7t7btwDeinVKNiWta9g/tIDgE42rcK9Wj1M2N8id
         58R/PhtK091FHpDISds6W8+usGVSrx3puAvQBY3tzvLAi2rXvHWe/tBzQFgC9YWPEaE+
         1p67ikHlscDy2Q588rFFiJl9jVA6yIC4PrIUAos8KosYgm4R466fGzO11VsTmr/cfSY3
         hAkZ2aVQvhkyOUZFyuRIH0AYiZRptW83SDCsKIXtyJTHxB8PUBgUvoLLFtx4TnLvXj/H
         CSV6Vw2KbwGkiSPxrF+Yar79TkMDAer9xcmsOBYEd2FlEV7SKgKso7EHYkKPRsN8I6r8
         7t0Q==
X-Gm-Message-State: APjAAAVQ5mgSrsc2X+co8RxbCbBFKIcNtwVG8Gzq6cp9zeGgOhLgfOHE
        gXTjQ4za65KJKQ/ZfIzd4ZM=
X-Google-Smtp-Source: APXvYqx3NLOHdkEYwP922BKThLfnrgG2MwfuMZ6rRtgZ/1xTtxr1hpNhdp1jOgDepuoCZi4ujmNVQA==
X-Received: by 2002:adf:ea87:: with SMTP id s7mr11321350wrm.24.1561796637189;
        Sat, 29 Jun 2019 01:23:57 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id r79sm4071532wme.2.2019.06.29.01.23.56
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 29 Jun 2019 01:23:56 -0700 (PDT)
Date:   Sat, 29 Jun 2019 10:23:54 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-efi@vger.kernel.org
Subject: [GIT PULL] EFI fixes
Message-ID: <20190629082354.GA128031@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Linus,

Please pull the latest efi-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git efi-urgent-for-linus

   # HEAD: 48c7d73b2362ce61503551ad70052617b3e8857d Merge tag 'efi-urgent' of git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi into efi/urgent

Four fixes:

 - fix a kexec crash on arm64
 - fix a reboot crash on some Android platforms
 - future-proof the code for upcoming ACPI 6.2 changes
 - fix a build warning on x86

 Thanks,

	Ingo

------------------>
Ard Biesheuvel (1):
      efi/memreserve: deal with memreserve entries in unmapped memory

Hans de Goede (1):
      efi/bgrt: Drop BGRT status field reserved bits check

Qian Cai (1):
      x86/efi: fix a -Wtype-limits compilation warning

Tian Baofeng (1):
      efibc: Replace variable set function in notifier call


 arch/x86/platform/efi/quirks.c  |  2 +-
 drivers/firmware/efi/efi-bgrt.c |  5 -----
 drivers/firmware/efi/efi.c      | 12 ++++++++++--
 drivers/firmware/efi/efibc.c    | 12 +++++++-----
 4 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
index 632b83885867..3b9fd679cea9 100644
--- a/arch/x86/platform/efi/quirks.c
+++ b/arch/x86/platform/efi/quirks.c
@@ -728,7 +728,7 @@ void efi_recover_from_page_fault(unsigned long phys_addr)
 	 * Address range 0x0000 - 0x0fff is always mapped in the efi_pgd, so
 	 * page faulting on these addresses isn't expected.
 	 */
-	if (phys_addr >= 0x0000 && phys_addr <= 0x0fff)
+	if (phys_addr <= 0x0fff)
 		return;
 
 	/*
diff --git a/drivers/firmware/efi/efi-bgrt.c b/drivers/firmware/efi/efi-bgrt.c
index a2384184a7de..b07c17643210 100644
--- a/drivers/firmware/efi/efi-bgrt.c
+++ b/drivers/firmware/efi/efi-bgrt.c
@@ -47,11 +47,6 @@ void __init efi_bgrt_init(struct acpi_table_header *table)
 		       bgrt->version);
 		goto out;
 	}
-	if (bgrt->status & 0xfe) {
-		pr_notice("Ignoring BGRT: reserved status bits are non-zero %u\n",
-		       bgrt->status);
-		goto out;
-	}
 	if (bgrt->image_type != 0) {
 		pr_notice("Ignoring BGRT: invalid image type %u (expected 0)\n",
 		       bgrt->image_type);
diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 16b2137d117c..4b7cf7bc0ded 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -1009,14 +1009,16 @@ int __ref efi_mem_reserve_persistent(phys_addr_t addr, u64 size)
 
 	/* first try to find a slot in an existing linked list entry */
 	for (prsv = efi_memreserve_root->next; prsv; prsv = rsv->next) {
-		rsv = __va(prsv);
+		rsv = memremap(prsv, sizeof(*rsv), MEMREMAP_WB);
 		index = atomic_fetch_add_unless(&rsv->count, 1, rsv->size);
 		if (index < rsv->size) {
 			rsv->entry[index].base = addr;
 			rsv->entry[index].size = size;
 
+			memunmap(rsv);
 			return 0;
 		}
+		memunmap(rsv);
 	}
 
 	/* no slot found - allocate a new linked list entry */
@@ -1024,7 +1026,13 @@ int __ref efi_mem_reserve_persistent(phys_addr_t addr, u64 size)
 	if (!rsv)
 		return -ENOMEM;
 
-	rsv->size = EFI_MEMRESERVE_COUNT(PAGE_SIZE);
+	/*
+	 * The memremap() call above assumes that a linux_efi_memreserve entry
+	 * never crosses a page boundary, so let's ensure that this remains true
+	 * even when kexec'ing a 4k pages kernel from a >4k pages kernel, by
+	 * using SZ_4K explicitly in the size calculation below.
+	 */
+	rsv->size = EFI_MEMRESERVE_COUNT(SZ_4K);
 	atomic_set(&rsv->count, 1);
 	rsv->entry[0].base = addr;
 	rsv->entry[0].size = size;
diff --git a/drivers/firmware/efi/efibc.c b/drivers/firmware/efi/efibc.c
index 61e099826cbb..35dccc88ac0a 100644
--- a/drivers/firmware/efi/efibc.c
+++ b/drivers/firmware/efi/efibc.c
@@ -43,11 +43,13 @@ static int efibc_set_variable(const char *name, const char *value)
 	efibc_str_to_str16(value, (efi_char16_t *)entry->var.Data);
 	memcpy(&entry->var.VendorGuid, &guid, sizeof(guid));
 
-	ret = efivar_entry_set(entry,
-			       EFI_VARIABLE_NON_VOLATILE
-			       | EFI_VARIABLE_BOOTSERVICE_ACCESS
-			       | EFI_VARIABLE_RUNTIME_ACCESS,
-			       size, entry->var.Data, NULL);
+	ret = efivar_entry_set_safe(entry->var.VariableName,
+				    entry->var.VendorGuid,
+				    EFI_VARIABLE_NON_VOLATILE
+				    | EFI_VARIABLE_BOOTSERVICE_ACCESS
+				    | EFI_VARIABLE_RUNTIME_ACCESS,
+				    false, size, entry->var.Data);
+
 	if (ret)
 		pr_err("failed to set %s EFI variable: 0x%x\n",
 		       name, ret);
