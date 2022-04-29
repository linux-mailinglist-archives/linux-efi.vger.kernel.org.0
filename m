Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97626515564
	for <lists+linux-efi@lfdr.de>; Fri, 29 Apr 2022 22:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380671AbiD2UVu (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 29 Apr 2022 16:21:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345389AbiD2UVt (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 29 Apr 2022 16:21:49 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F819CFE7C
        for <linux-efi@vger.kernel.org>; Fri, 29 Apr 2022 13:18:30 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-deb9295679so9218182fac.6
        for <linux-efi@vger.kernel.org>; Fri, 29 Apr 2022 13:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2VGMhr11GA+eGLRm5CsL28eo528BHkwYTiIF+ncvNsE=;
        b=BvRseK4OxKadqHo12yNsfQ37dcGHfwzf2NABqSmUh4dW14GFsCZ9lNoqxOaprhkpIt
         RD4NewzP3DKtjv3EXexgwnPx9/D0SPPyIwy17W+pLoOmfBWGYsEfnwEcCoqicMULz7s7
         xgniOuDmDzPksbBOjq8y3XGwMK8aG73pFr7TQbKHrtYnU5S3KN9v9vUdtdfvpBBLl6pG
         /+bPXmuJin8w9zaqauKrTz+CbnNMDCN4Mue5L9B5DMPEnXDbpbTYpDkcgT11Ay11MmVy
         mMF1NeIq5CeN9ZfsuwJpnFNuT3ReobQHJCtBWNx1hbcv8Gc1Y6Hc7fGasrUup9XPtJfy
         F/uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2VGMhr11GA+eGLRm5CsL28eo528BHkwYTiIF+ncvNsE=;
        b=4ood9fPpTRn2Y8res9d4v3h9rR5lTu4QTdrDOxPi24Z9BLJDwfKaIyM6G00JtcK0RK
         GcQLjLu6GT4GdyAIRgLVO4sdq488eirCMLXSi5QwDdtP1zOimEy0M/vRLtmntZrDTUNb
         esXENS4sNUqYYYzReHWhNNmel31s3SyO7MKwzhfS865zBNkAGBPeh96UVy1zDx7vbin2
         /WDfntdI3q7Wcw1QgUzx0FRHCvkCd/5aSkvjm42vdEJq6Z2Fp6FEYkHynjDt0dP9Zfo4
         KYB8HOqSlwx+ZtdRr7Re9axlKmaex9D3/fMGgI+ZBxNDVMpDnCNvOoK1b0SDaQ2D/LLg
         cYTQ==
X-Gm-Message-State: AOAM532nlcBQgqviT+JAcu0t7XftiQlwJG1fXdWyv9olu90v1wrkIPc5
        4j7Sy1jzrnPo5Ro6dZKZW03S9w==
X-Google-Smtp-Source: ABdhPJyOyF9wWfauAE59YnbOyJwYqFYAmT+C3XLQZ8NncYYCmkw0OS1bL4ZQfw7qqScQqcZUkl025g==
X-Received: by 2002:a05:6870:b023:b0:db:78e:7197 with SMTP id y35-20020a056870b02300b000db078e7197mr2135132oae.36.1651263509453;
        Fri, 29 Apr 2022 13:18:29 -0700 (PDT)
Received: from localhost ([181.97.174.128])
        by smtp.gmail.com with ESMTPSA id i6-20020a9d6506000000b0060603221255sm84923otl.37.2022.04.29.13.18.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Apr 2022 13:18:29 -0700 (PDT)
From:   Martin Fernandez <martin.fernandez@eclypsium.com>
To:     linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-mm@kvack.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        ardb@kernel.org, dvhart@infradead.org, andy@infradead.org,
        gregkh@linuxfoundation.org, rafael@kernel.org, rppt@kernel.org,
        akpm@linux-foundation.org, daniel.gutson@eclypsium.com,
        hughsient@gmail.com, alex.bazhaniuk@eclypsium.com,
        alison.schofield@intel.com, keescook@chromium.org,
        Martin Fernandez <martin.fernandez@eclypsium.com>
Subject: [PATCH v8 7/8] x86/efi: Mark e820_entries as crypto capable from EFI memmap
Date:   Fri, 29 Apr 2022 17:17:16 -0300
Message-Id: <20220429201717.1946178-8-martin.fernandez@eclypsium.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220429201717.1946178-1-martin.fernandez@eclypsium.com>
References: <20220429201717.1946178-1-martin.fernandez@eclypsium.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Add a function to iterate over the EFI Memory Map and mark the regions
tagged with EFI_MEMORY_CPU_CRYPTO in the e820_table; and call it from
efi_init if add_efi_memmap is disabled.

Also modify do_add_efi_memmap to mark the regions there.

If add_efi_memmap is false, also check that the e820_table has enough
size to (possibly) store also the EFI memmap.

Signed-off-by: Martin Fernandez <martin.fernandez@eclypsium.com>
---
 arch/x86/platform/efi/efi.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
index 147c30a81f15..3efa1c620c75 100644
--- a/arch/x86/platform/efi/efi.c
+++ b/arch/x86/platform/efi/efi.c
@@ -184,6 +184,8 @@ static void __init do_add_efi_memmap(void)
 		}
 
 		e820__range_add(start, size, e820_type);
+		if (md->attribute & EFI_MEMORY_CPU_CRYPTO)
+			e820__range_set_crypto_capable(start, size);
 	}
 	e820__update_table(e820_table);
 }
@@ -441,6 +443,34 @@ static int __init efi_config_init(const efi_config_table_type_t *arch_tables)
 	return ret;
 }
 
+static void __init efi_mark_e820_regions_as_crypto_capable(void)
+{
+	efi_memory_desc_t *md;
+
+	/*
+	 * Calling e820__range_set_crypto_capable several times
+	 * creates a bunch of entries in the E820 table. They probably
+	 * will get merged when calling update_table but we need the
+	 * space there anyway
+	 */
+	if (efi.memmap.nr_map + e820_table->nr_entries >= E820_MAX_ENTRIES) {
+		pr_err_once("E820 table is not large enough to fit EFI memmap; not marking entries as crypto capable\n");
+		return;
+	}
+
+	for_each_efi_memory_desc(md) {
+		if (md->attribute & EFI_MEMORY_CPU_CRYPTO)
+			e820__range_set_crypto_capable(md->phys_addr,
+						       md->num_pages << EFI_PAGE_SHIFT);
+	}
+
+	/*
+	 * We added and modified regions so it's good to update the
+	 * table to merge/sort
+	 */
+	e820__update_table(e820_table);
+}
+
 void __init efi_init(void)
 {
 	if (IS_ENABLED(CONFIG_X86_32) &&
@@ -494,6 +524,13 @@ void __init efi_init(void)
 	set_bit(EFI_RUNTIME_SERVICES, &efi.flags);
 	efi_clean_memmap();
 
+	/*
+	 * If add_efi_memmap then there is no need to mark the regions
+	 * again
+	 */
+	if (!add_efi_memmap)
+		efi_mark_e820_regions_as_crypto_capable();
+
 	if (efi_enabled(EFI_DBG))
 		efi_print_memmap();
 }
-- 
2.30.2

