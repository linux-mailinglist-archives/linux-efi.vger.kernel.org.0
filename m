Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7998D7194E8
	for <lists+linux-efi@lfdr.de>; Thu,  1 Jun 2023 10:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231203AbjFAIAG (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 1 Jun 2023 04:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231791AbjFAH7s (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 1 Jun 2023 03:59:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EAAB10E4
        for <linux-efi@vger.kernel.org>; Thu,  1 Jun 2023 00:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685606159;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=v0btJxCCZe43YDGHsdR9uwY7u4rDiYwVgo7mtVALHgE=;
        b=IcqXZ4TiJcvMSPg1YtpiiqbF03SiSJst7vYTcr9PEizDRNUeFgbWaLDnt+v4ZfgYLv27F2
        t/OUiirqhjSPCyEHDCGTGfwH1/LneHO/9VblKha535k9hAQtTQ8JLUwB/wUj2+l0olLJy9
        nIb6O4seJKqL4wtK24ceI14GPWF4Uec=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-sho9xq3wPY2heQQh3n0eQg-1; Thu, 01 Jun 2023 03:55:58 -0400
X-MC-Unique: sho9xq3wPY2heQQh3n0eQg-1
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-64d2f088dc2so672903b3a.3
        for <linux-efi@vger.kernel.org>; Thu, 01 Jun 2023 00:55:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685606157; x=1688198157;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v0btJxCCZe43YDGHsdR9uwY7u4rDiYwVgo7mtVALHgE=;
        b=k2Wfffd758xU1MjlpjZot+1ERNSTWYxanWYhZN349B8I6htKtRDuOz6/tFBTEsgxXF
         OHKIT7TbUEhorAn/we4y0nQc4oNsPrkL8L7+qHRjOQDj0BrZ0to1wZSSFMnzIrmnYkSF
         pl7w6Z7VhPPCPZBcH+8XhiFkErWmageDCRof3zqfpvWXGOdJKVftLlmjeQFI/4Ez6/2P
         aDY+qOZR8QMDhkdiphaSvV4ZDGvvMLkBLA9Xu72Blb9cFNeLqe+dhhhE54ohsdzxp3nK
         ffcYKqX7MCfg5GxcAm0Bj82GPebdOPQERaL5lVXzE/AZbnuohiM7dylH/eJwF60Lr8xN
         sldQ==
X-Gm-Message-State: AC+VfDw/TFIBHW4ItXAG2mfAckpuIqZfz/5qZu3zW9LhYKcRjS3YbMR3
        Ho+FPH8aU2+o17jZBXD7uZF4fF2p8h1G1UbZ/CuZUqhJeHVz17XMViTMstmrI++4zW2kXqQKkS+
        8ppvAuZmAMkWkQDV4DHOY
X-Received: by 2002:a05:6a00:3910:b0:64f:7c9d:9c09 with SMTP id fh16-20020a056a00391000b0064f7c9d9c09mr11549190pfb.32.1685606157377;
        Thu, 01 Jun 2023 00:55:57 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7AFiGmMIL5yucVf1xXEUVV0IZpvnTGUsiZsNXeIglwrAEjmuisCODxuG3g3iCemJzBVxOWkw==
X-Received: by 2002:a05:6a00:3910:b0:64f:7c9d:9c09 with SMTP id fh16-20020a056a00391000b0064f7c9d9c09mr11549178pfb.32.1685606157062;
        Thu, 01 Jun 2023 00:55:57 -0700 (PDT)
Received: from localhost.localdomain.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id 17-20020aa79211000000b00643355ff6a6sm4600773pfo.99.2023.06.01.00.55.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 00:55:56 -0700 (PDT)
From:   Tao Liu <ltao@redhat.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        ardb@kernel.org
Cc:     linux-kernel@vger.kernel.org, bhe@redhat.com, dyoung@redhat.com,
        kexec@lists.infradead.org, linux-efi@vger.kernel.org,
        Tao Liu <ltao@redhat.com>
Subject: [PATCH v2] x86/kexec: Add EFI config table identity mapping for kexec kernel
Date:   Thu,  1 Jun 2023 15:20:44 +0800
Message-Id: <20230601072043.24439-1-ltao@redhat.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

A kexec kernel bootup hang is observed on Intel Atom cpu due to unmapped
EFI config table.

Currently EFI system table is identity-mapped for the kexec kernel, but EFI
config table is not mapped explicitly:

    commit 6bbeb276b71f ("x86/kexec: Add the EFI system tables and ACPI
                          tables to the ident map")

Later in the following 2 commits, EFI config table will be accessed when
enabling sev at kernel startup. This may result in a page fault due to EFI
config table's unmapped address. Since the page fault occurs at an early
stage, it is unrecoverable and kernel hangs.

    commit ec1c66af3a30 ("x86/compressed/64: Detect/setup SEV/SME features
                          earlier during boot")
    commit c01fce9cef84 ("x86/compressed: Add SEV-SNP feature
                          detection/setup")

In addition, the issue doesn't appear on all systems, because the kexec
kernel uses Page Size Extension (PSE) for identity mapping. In most cases,
EFI config table can end up to be mapped into due to 1 GB page size.
However if nogbpages is set, or cpu doesn't support pdpe1gb feature
(e.g Intel Atom x6425RE cpu), EFI config table may not be mapped into
due to 2 MB page size, thus a page fault hang is more likely to happen.

This patch will make sure the EFI config table is always mapped.

Signed-off-by: Tao Liu <ltao@redhat.com>
---
Changes in v2:
- Rephrase the change log based on Baoquan's suggestion.
- Rename map_efi_sys_cfg_tab() to map_efi_tables().
- Link to v1: https://lore.kernel.org/kexec/20230525094914.23420-1-ltao@redhat.com/
---
 arch/x86/kernel/machine_kexec_64.c | 35 ++++++++++++++++++++++++++----
 1 file changed, 31 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index 1a3e2c05a8a5..664aefa6e896 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -28,6 +28,7 @@
 #include <asm/setup.h>
 #include <asm/set_memory.h>
 #include <asm/cpu.h>
+#include <asm/efi.h>
 
 #ifdef CONFIG_ACPI
 /*
@@ -86,10 +87,12 @@ const struct kexec_file_ops * const kexec_file_loaders[] = {
 #endif
 
 static int
-map_efi_systab(struct x86_mapping_info *info, pgd_t *level4p)
+map_efi_tables(struct x86_mapping_info *info, pgd_t *level4p)
 {
 #ifdef CONFIG_EFI
 	unsigned long mstart, mend;
+	void *kaddr;
+	int ret;
 
 	if (!efi_enabled(EFI_BOOT))
 		return 0;
@@ -105,6 +108,30 @@ map_efi_systab(struct x86_mapping_info *info, pgd_t *level4p)
 	if (!mstart)
 		return 0;
 
+	ret = kernel_ident_mapping_init(info, level4p, mstart, mend);
+	if (ret)
+		return ret;
+
+	kaddr = memremap(mstart, mend - mstart, MEMREMAP_WB);
+	if (!kaddr) {
+		pr_err("Could not map UEFI system table\n");
+		return -ENOMEM;
+	}
+
+	mstart = efi_config_table;
+
+	if (efi_enabled(EFI_64BIT)) {
+		efi_system_table_64_t *stbl = (efi_system_table_64_t *)kaddr;
+
+		mend = mstart + sizeof(efi_config_table_64_t) * stbl->nr_tables;
+	} else {
+		efi_system_table_32_t *stbl = (efi_system_table_32_t *)kaddr;
+
+		mend = mstart + sizeof(efi_config_table_32_t) * stbl->nr_tables;
+	}
+
+	memunmap(kaddr);
+
 	return kernel_ident_mapping_init(info, level4p, mstart, mend);
 #endif
 	return 0;
@@ -244,10 +271,10 @@ static int init_pgtable(struct kimage *image, unsigned long start_pgtable)
 	}
 
 	/*
-	 * Prepare EFI systab and ACPI tables for kexec kernel since they are
-	 * not covered by pfn_mapped.
+	 * Prepare EFI systab, config table and ACPI tables for kexec kernel
+	 * since they are not covered by pfn_mapped.
 	 */
-	result = map_efi_systab(&info, level4p);
+	result = map_efi_tables(&info, level4p);
 	if (result)
 		return result;
 
-- 
2.33.1

