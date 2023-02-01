Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA2D16866CD
	for <lists+linux-efi@lfdr.de>; Wed,  1 Feb 2023 14:25:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbjBANZz (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 1 Feb 2023 08:25:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232329AbjBANZx (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 1 Feb 2023 08:25:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5217A64693
        for <linux-efi@vger.kernel.org>; Wed,  1 Feb 2023 05:25:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D553EB82188
        for <linux-efi@vger.kernel.org>; Wed,  1 Feb 2023 13:25:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 146C4C433A0;
        Wed,  1 Feb 2023 13:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675257949;
        bh=WsMYBTzQwtfr7VHa+Yp3YtdRpvv4/gcwXOJNhdMaYF4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t226Jetz03M9YbM8jju1oIRhMYFPojBiOTUzY0iCOKSifUlTKRVXKASzhzHFIFHyw
         qboIMjx1yyIkEEDTWnmI352IxKis8t43pKXM3jExeMYahwHjvy+YZG8UcODJxvOrRp
         eMbiBzd37+vlYYFCy15PaT3nWt3PeHOJSXVHdWkyVJMY4vgg4Z/v0q2laRhSKtY0Zf
         KUGumMPZuS7BBWxCL9RvwJL2tWFr5892rOQmWgNKRnzVfJ9TYFYQAVNtAYjKbZQYAZ
         kXbdckakSIvgkBwwF8m3leyQtkgs9vQarNNy1RegQhaIXV3MI0vkhvuKA8amySDr4J
         591QAjOhrLoqg==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 2/2] efi: arm64: Wire up BTI annotation in memory attributes table
Date:   Wed,  1 Feb 2023 14:25:40 +0100
Message-Id: <20230201132540.2196065-3-ardb@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230201132540.2196065-1-ardb@kernel.org>
References: <20230201132540.2196065-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1976; i=ardb@kernel.org; h=from:subject; bh=WsMYBTzQwtfr7VHa+Yp3YtdRpvv4/gcwXOJNhdMaYF4=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBj2mhTE35eHSzyUwwIe7ahC7aV00BTCDk70Hkfr C0SIlWB6L6JAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCY9poUwAKCRDDTyI5ktmP JI+bC/9Hvi9k74QktoS0ap39LVhC39lghnseJ6rw25VLpyJ/AfN8ELq8HLIYs//7i6vwzQ8/btm KP2+yZfoeNvV7JUKjmWegSrfPMXZ6ypbhF9jgKQ7Cm7EdSv12h1ej614U2LwQ163jEF+Eet2HSK jS7hVfSIMHbzL4utLGCTO8jXY7apKC5EVMx/IBtrRMaPPIqwUlpueGpCc4fb0S8Rc3/DWA1jpEv cS+9saZimBsQWMpnyhikAkL5XPqat7IhlCFGCWZK1mQBamY5FqrIcpPG1eRKQTbwEYJg2g9gTGD Y2vO1OVHOyN6lyoaISj3PGA1t+tyRjNP6p457/WksKys9bSgE7iPUKyu5/PHhnOK10zGgDzl3Cl Lm5RNseGa8Fcya++0nNzXuyrmhv9t8RcKGLcocW2FQ/TD7hFzlE9K5ndz5sTjvnMxf1xjRPrR8O lSqIAKReVwWEv+nhEN5L5m7pJ9Slu/7cm7i/QxAUNp81DOyItty4XPv+B81yjQ5nI+Hvc=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

UEFI v2.10 extends the EFI memory attributes table with a flag that
indicates whether or not all RuntimeServicesCode regions were
constructed with BTI landing pads, permitting the OS to map these
regions with BTI restrictions enabled.

So let's take this into account on arm64.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/kernel/efi.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/efi.c b/arch/arm64/kernel/efi.c
index 908499486b00274e..6a61553b64c51dcd 100644
--- a/arch/arm64/kernel/efi.c
+++ b/arch/arm64/kernel/efi.c
@@ -97,15 +97,24 @@ int __init efi_create_mapping(struct mm_struct *mm, efi_memory_desc_t *md)
 	return 0;
 }
 
+struct set_perm_data {
+	const efi_memory_desc_t	*md;
+	bool			has_bti;
+};
+
 static int __init set_permissions(pte_t *ptep, unsigned long addr, void *data)
 {
-	efi_memory_desc_t *md = data;
+	struct set_perm_data *spd = data;
+	const efi_memory_desc_t *md = spd->md;
 	pte_t pte = READ_ONCE(*ptep);
 
 	if (md->attribute & EFI_MEMORY_RO)
 		pte = set_pte_bit(pte, __pgprot(PTE_RDONLY));
 	if (md->attribute & EFI_MEMORY_XP)
 		pte = set_pte_bit(pte, __pgprot(PTE_PXN));
+	else if (IS_ENABLED(CONFIG_ARM64_BTI_KERNEL) &&
+		 system_supports_bti() && spd->has_bti)
+		pte = set_pte_bit(pte, __pgprot(PTE_GP));
 	set_pte(ptep, pte);
 	return 0;
 }
@@ -114,6 +123,8 @@ int __init efi_set_mapping_permissions(struct mm_struct *mm,
 				       efi_memory_desc_t *md,
 				       bool has_bti)
 {
+	struct set_perm_data data = { md, has_bti };
+
 	BUG_ON(md->type != EFI_RUNTIME_SERVICES_CODE &&
 	       md->type != EFI_RUNTIME_SERVICES_DATA);
 
@@ -129,7 +140,7 @@ int __init efi_set_mapping_permissions(struct mm_struct *mm,
 	 */
 	return apply_to_page_range(mm, md->virt_addr,
 				   md->num_pages << EFI_PAGE_SHIFT,
-				   set_permissions, md);
+				   set_permissions, &data);
 }
 
 /*
-- 
2.39.0

