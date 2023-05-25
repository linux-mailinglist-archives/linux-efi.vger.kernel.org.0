Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74CAF71092F
	for <lists+linux-efi@lfdr.de>; Thu, 25 May 2023 11:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240604AbjEYJu1 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 25 May 2023 05:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232749AbjEYJuZ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 25 May 2023 05:50:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97092A9
        for <linux-efi@vger.kernel.org>; Thu, 25 May 2023 02:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685008181;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=hAxjra5W1+1SvpBMN22QXJJOi5JB+teXZgPwJvUgVGE=;
        b=Kmwd+wvxWqDUV043xADs4AQF7OCjAgtgMWQZWA6nmV6J41ZoaPemquHysNTMvGCZtXgIyG
        NyMcF2MLDxzDUCajh/0eO0eC64fwaSXwR/Q1VlCq7+d/zRiUwzT4l4hX4+XQ9OdjhFlLPW
        1hhgT1KtE9RQwvz5CMuQijhbSIcEyC8=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-T7JHzsX-NyeFIdqsEyqKlg-1; Thu, 25 May 2023 05:49:38 -0400
X-MC-Unique: T7JHzsX-NyeFIdqsEyqKlg-1
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-517bfcfe83fso902086a12.2
        for <linux-efi@vger.kernel.org>; Thu, 25 May 2023 02:49:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685008177; x=1687600177;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hAxjra5W1+1SvpBMN22QXJJOi5JB+teXZgPwJvUgVGE=;
        b=cITb/bjinTWgRNPO8zsmLMulpIjqCegVFAldFYuND91Mp3y/D7STR48EPaPYaOHgt5
         83QxI8lSMRsH5c+AdBirpOWIwtaaaK/wuYVsPt8NVvJoaBiCrkJQlBhf0WfgQSpeJDTl
         DHY2aPYPDEksIFsxNfuV51R2I8WwvzIFEQqwJTRkK/e0jJiLXzH7WgxMZ04u1ZN6WcXt
         RKGM0XEAeKp2JK8DNLMXd/YX9GJdEetB0/wm3M4XCmpYlbItx6YOCmgzj96Pi4Nf/P2I
         8+BdjJg9eXHJpuIkQF8WpiGKG+YrMQzEGAWHF+khJlwwjLlnIC4yhXOVOpbq4jpVJMh1
         79aQ==
X-Gm-Message-State: AC+VfDxB1f8KgCjOoQbbDeBqqH9Rr3ZgnqD8gFEDUD9hKlcb6gPJGFmR
        iC0Cjza7nwIRbrZVmom8+PXzf5rT3f2FByA9Zckqs0/sqmd8M5ieKtFWerf14c/YGttYPXo/e47
        osdbaoj7lf2n5crCufdW9
X-Received: by 2002:a17:903:230f:b0:1af:a03:8d82 with SMTP id d15-20020a170903230f00b001af0a038d82mr1149850plh.57.1685008177409;
        Thu, 25 May 2023 02:49:37 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ64F7+wAhODeQTh71SkG9KiZ+8BDhumZp7KJkEik3KY4RGXnQjHL9XswjQ5pC+GeNWlMRi+Sg==
X-Received: by 2002:a17:903:230f:b0:1af:a03:8d82 with SMTP id d15-20020a170903230f00b001af0a038d82mr1149833plh.57.1685008177110;
        Thu, 25 May 2023 02:49:37 -0700 (PDT)
Received: from localhost.localdomain.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id c10-20020a170903234a00b001ab2b4105ddsm1008282plh.60.2023.05.25.02.49.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 02:49:36 -0700 (PDT)
From:   Tao Liu <ltao@redhat.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com
Cc:     linux-kernel@vger.kernel.org, bhe@redhat.com, dyoung@redhat.com,
        kexec@lists.infradead.org, linux-efi@vger.kernel.org,
        Tao Liu <ltao@redhat.com>
Subject: [PATCH] x86/kexec: Add EFI config table identity mapping for kexec kernel
Date:   Thu, 25 May 2023 17:49:14 +0800
Message-Id: <20230525094914.23420-1-ltao@redhat.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
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

In this patch, we will make sure the EFI config table is always mapped.

Signed-off-by: Tao Liu <ltao@redhat.com>
---
 arch/x86/kernel/machine_kexec_64.c | 35 ++++++++++++++++++++++++++----
 1 file changed, 31 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index 1a3e2c05a8a5..755aa12f583f 100644
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
+map_efi_sys_cfg_tab(struct x86_mapping_info *info, pgd_t *level4p)
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
+	result = map_efi_sys_cfg_tab(&info, level4p);
 	if (result)
 		return result;
 
-- 
2.33.1

