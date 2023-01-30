Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48D1C681794
	for <lists+linux-efi@lfdr.de>; Mon, 30 Jan 2023 18:28:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235545AbjA3R2k (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 30 Jan 2023 12:28:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235920AbjA3R2g (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 30 Jan 2023 12:28:36 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 887A727D6A
        for <linux-efi@vger.kernel.org>; Mon, 30 Jan 2023 09:28:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0B044B8159F
        for <linux-efi@vger.kernel.org>; Mon, 30 Jan 2023 17:28:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED3FDC433D2;
        Mon, 30 Jan 2023 17:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675099712;
        bh=jvOZ8o6utLG1K5vwVeYiPeqS68YTbFUEszi3MQ5cT4U=;
        h=From:To:Cc:Subject:Date:From;
        b=VY0i9MdQJsMC4Q4xnr4T2b4PoMpTwxbd23cU0C1D9jKhhyAgjtVWtIITv2wnjBO5P
         GonUIH05bkEnf34gMIyTcbzqC30mGBFDZ8l8oamxqlPoOzVFLRjQlXVutzGwM4ZXbU
         Jf/jKG2VgsTJvdBtpN93KfooVGBcajDUJm5suAq3EmLHdWVeOpoTCzBetDs/DSnsH1
         E2jAeIbayjwiXCdmyt4HFostdMbaQ+1YNpYnoBOZhvCsK5bHeLg6mb17JUg882iwpC
         z8kg727JQnn+L6D3mRiqYRqj13bm5BJ7lMeISEBHKG9PPKTfN9PoKl8aV12VaZyXk7
         /e7BYj69lW4vQ==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>, Evgeniy Baskov <baskov@ispras.ru>
Subject: [PATCH] efi: zboot: Use EFI protocol to remap code/data with the right attributes
Date:   Mon, 30 Jan 2023 18:28:26 +0100
Message-Id: <20230130172826.1634412-1-ardb@kernel.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2985; i=ardb@kernel.org; h=from:subject; bh=jvOZ8o6utLG1K5vwVeYiPeqS68YTbFUEszi3MQ5cT4U=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBj1/45mRKnt2C9S7hQK9spDlO0GgwEKOE6GBXoI rqjD5K+H96JAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCY9f+OQAKCRDDTyI5ktmP JD3QC/4senVgDuw7YSk/ukXzGnvTSnrwlS1REXJ6Lu4N+p7fU7b+9J3T5GF6FY5KvR6fJf3hThq WEV5uqev5IWurdJxBixTf2KlNI8uY3h+foFXPVQNiPKo5GeoZO5LFMZacuztF2Mc6hHgPyS1UTZ PtZwU5EgFooU6zo7JOOY5XzMRQTn2swUb+RLj8mQ4k6RGLKocepsTAmAHm2FJmOcTSGK2Y3wDgV +t3jmKK8UfB1IEfxB5GzKGT3CDh5F28WB5GH2qN/Y6PkAaKlXBzlP3tax0OB4OL2cMR3k1TF+OX PzhChgblbFYdPI2syz9TW7ELdYLKoiDTnIN9MRsK05uYnt1PnAN9OgPfM0wrHTdp2nlWssK7/ZQ B1YKH11+xqRUIxOb3yzRaiHGlShqQXcZFLi71+S5K216apgWEA/+5oOucOL175+dyU5d92BQNOu XPBcwkuCrtLBaA97fEttZ7yp2oHwAUz3AjWH0248uwxj8bLbchhxWF9j5EvMIZVUIPciQ=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Use the recently introduced EFI_MEMORY_ATTRIBUTES_PROTOCOL in the zboot
implementation to set the right attributes for the code and data
sections of the decompressed image, i.e., EFI_MEMORY_RO for code and
EFI_MEMORY_XP for data.

Cc: Evgeniy Baskov <baskov@ispras.ru>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/zboot.c | 55 ++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/drivers/firmware/efi/libstub/zboot.c b/drivers/firmware/efi/libstub/zboot.c
index 66be5fdc6b5885b7..89ad9204807b0477 100644
--- a/drivers/firmware/efi/libstub/zboot.c
+++ b/drivers/firmware/efi/libstub/zboot.c
@@ -49,6 +49,59 @@ static unsigned long alloc_preferred_address(unsigned long alloc_size)
 	return ULONG_MAX;
 }
 
+static void efi_remap_image(unsigned long image_base, unsigned alloc_size,
+			    unsigned long code_size)
+{
+	efi_memory_attribute_protocol_t *memattr;
+	efi_status_t status;
+	u64 attr;
+
+	/*
+	 * If the firmware implements the EFI_MEMORY_ATTRIBUTE_PROTOCOL, let's
+	 * invoke it to remap the text/rodata region of the decompressed image
+	 * as read-only and the data/bss region as non-executable.
+	 */
+	status = efi_bs_call(locate_protocol, &EFI_MEMORY_ATTRIBUTE_PROTOCOL_GUID,
+			     NULL, (void **)&memattr);
+	if (status != EFI_SUCCESS)
+		return;
+
+	// Get the current attributes for the entire region
+	status = memattr->get_memory_attributes(memattr, image_base,
+						alloc_size, &attr);
+	if (status != EFI_SUCCESS) {
+		efi_warn("Failed to retrieve memory attributes for image region: 0x%lx\n",
+			 status);
+		return;
+	}
+
+	// Mark the code region as read-only
+	status = memattr->set_memory_attributes(memattr, image_base, code_size,
+						EFI_MEMORY_RO);
+	if (status != EFI_SUCCESS) {
+		efi_warn("Failed to remap code region read-only\n");
+		return;
+	}
+
+	// If the entire region was already mapped as non-exec, clear the
+	// attribute from the code region. Otherwise, set it on the data
+	// region.
+	if (attr & EFI_MEMORY_XP) {
+		status = memattr->clear_memory_attributes(memattr, image_base,
+							  code_size,
+							  EFI_MEMORY_XP);
+		if (status != EFI_SUCCESS)
+			efi_warn("Failed to remap code region executable\n");
+	} else {
+		status = memattr->set_memory_attributes(memattr,
+							image_base + code_size,
+							alloc_size - code_size,
+							EFI_MEMORY_XP);
+		if (status != EFI_SUCCESS)
+			efi_warn("Failed to remap data region non-executable\n");
+	}
+}
+
 void __weak efi_cache_sync_image(unsigned long image_base,
 				 unsigned long alloc_size,
 				 unsigned long code_size)
@@ -137,6 +190,8 @@ efi_zboot_entry(efi_handle_t handle, efi_system_table_t *systab)
 
 	efi_cache_sync_image(image_base, alloc_size, code_size);
 
+	efi_remap_image(image_base, alloc_size, code_size);
+
 	status = efi_stub_common(handle, image, image_base, cmdline_ptr);
 
 free_image:
-- 
2.39.0

