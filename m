Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 073C32ADC3D
	for <lists+linux-efi@lfdr.de>; Tue, 10 Nov 2020 17:39:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbgKJQjW (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 10 Nov 2020 11:39:22 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:33533 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbgKJQjW (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 10 Nov 2020 11:39:22 -0500
Received: by mail-qk1-f194.google.com with SMTP id l2so12053158qkf.0;
        Tue, 10 Nov 2020 08:39:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Mum+EXUAEWW4zILejNRY9dmdB2uIFkWT5LhupsX/sdM=;
        b=oQbUO4QIN31gEpRcVrVThdVOMsUh7HX2UFJg3HGM1/FYVbDWw+e/oIGGmCdwAkAiis
         46jm4ponVkgQEBPR/iMYqFGhgZluE0sj1m1f2XNl3BEKn+f7REtlFSlEYkTifOo7IiKZ
         IkF9NTFVZccyhetefXHIY+hwlIHgzp5GZsi4jIv0JZfh/rlCAYAF6gkjFZ3VelOiDkgI
         IF47Z87wElobM7eNwjIyPtoNTmdtRFnctClh50gnb1IAbLF+JBDwfAYNDHq/9B9Ju3gg
         Oa5EdlKmYiq6y7IWvmK/+L0zuPLhgUbQNzyDlpz4hyYoTvaxCdwTdsFsNZvavBOG1ijp
         +xQQ==
X-Gm-Message-State: AOAM533UZ0yJpyCY5OFhmS1loK9+I94ZH/zcB3s6mLEWbysCGLG81DBk
        46nvl0CW3RMMRNA6U1l+Nas=
X-Google-Smtp-Source: ABdhPJzPxHDtnv5E87PT/3xX6VPCskLgdJ90rnt6wApB74b/qanMQ9ZXb1tRyM56Tzrp0coMfTpfzA==
X-Received: by 2002:a37:9c16:: with SMTP id f22mr13193482qke.67.1605026361455;
        Tue, 10 Nov 2020 08:39:21 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id p8sm8579994qtc.37.2020.11.10.08.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 08:39:20 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] efi/x86: Free efi_pgd with free_pages()
Date:   Tue, 10 Nov 2020 11:39:19 -0500
Message-Id: <20201110163919.1134431-1-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Commit
  d9e9a6418065 ("x86/mm/pti: Allocate a separate user PGD")
changed the PGD allocation to allocate PGD_ALLOCATION_ORDER pages, so in
the error path it should be freed using free_pages() rather than
free_page().

Commit
  06ace26f4e6f ("x86/efi: Free efi_pgd with free_pages()")
fixed one instance of this, but missed another.

Move the freeing out-of-line to avoid code duplication and fix this bug.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
Fixes: d9e9a6418065 ("x86/mm/pti: Allocate a separate user PGD")
---
 arch/x86/platform/efi/efi_64.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/arch/x86/platform/efi/efi_64.c b/arch/x86/platform/efi/efi_64.c
index 8f5759df7776..e1e8d4e3a213 100644
--- a/arch/x86/platform/efi/efi_64.c
+++ b/arch/x86/platform/efi/efi_64.c
@@ -78,28 +78,30 @@ int __init efi_alloc_page_tables(void)
 	gfp_mask = GFP_KERNEL | __GFP_ZERO;
 	efi_pgd = (pgd_t *)__get_free_pages(gfp_mask, PGD_ALLOCATION_ORDER);
 	if (!efi_pgd)
-		return -ENOMEM;
+		goto fail;
 
 	pgd = efi_pgd + pgd_index(EFI_VA_END);
 	p4d = p4d_alloc(&init_mm, pgd, EFI_VA_END);
-	if (!p4d) {
-		free_page((unsigned long)efi_pgd);
-		return -ENOMEM;
-	}
+	if (!p4d)
+		goto free_pgd;
 
 	pud = pud_alloc(&init_mm, p4d, EFI_VA_END);
-	if (!pud) {
-		if (pgtable_l5_enabled())
-			free_page((unsigned long) pgd_page_vaddr(*pgd));
-		free_pages((unsigned long)efi_pgd, PGD_ALLOCATION_ORDER);
-		return -ENOMEM;
-	}
+	if (!pud)
+		goto free_p4d;
 
 	efi_mm.pgd = efi_pgd;
 	mm_init_cpumask(&efi_mm);
 	init_new_context(NULL, &efi_mm);
 
 	return 0;
+
+free_p4d:
+	if (pgtable_l5_enabled())
+		free_page((unsigned long)pgd_page_vaddr(*pgd));
+free_pgd:
+	free_pages((unsigned long)efi_pgd, PGD_ALLOCATION_ORDER);
+fail:
+	return -ENOMEM;
 }
 
 /*
-- 
2.26.2

