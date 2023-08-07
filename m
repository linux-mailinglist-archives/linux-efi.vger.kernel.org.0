Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91142772ACD
	for <lists+linux-efi@lfdr.de>; Mon,  7 Aug 2023 18:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231586AbjHGQ3C (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 7 Aug 2023 12:29:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231731AbjHGQ2r (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 7 Aug 2023 12:28:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E55A119A6;
        Mon,  7 Aug 2023 09:28:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A8F2F61F2D;
        Mon,  7 Aug 2023 16:28:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EC8EC433C9;
        Mon,  7 Aug 2023 16:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691425697;
        bh=Fk0lLfubzCQVs/j9K2oCq55VjZoVRLPQJNzwiQAW0qQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZUWfxdxH8cx9OrRrG0ELLmZKSZEKPqP9lsMVUiHaUB9SRuz31SuNPiS/W3tOm98CQ
         6hKzTFm0sgF2Z9NPYmRP3xFrxW63BOcWyxQc/N8Ie6zx9GJHoNn6B2kpgimCtWD3M+
         lhPPzHC3jxzrwDY38v+EVV36BRBenKmxHQcag7G6vucGtHKnRRRvnftmS4Tbmzf/c7
         7+p9yITnMfeW7lfcgTgIX2BQ0V5o8FnO4AViE7qYD1MqHPu7IH4XHVSZihNSxZRrwz
         iYbXuQAtOfRBrE2L0wVHwZniFF3z65o2Gi/iYmw1GazYqDF9GIEbfY15HxsN1IJxZ0
         TP4MRXHrGuKpw==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v9 17/23] x86/efistub: Prefer EFI memory attributes protocol over DXE services
Date:   Mon,  7 Aug 2023 18:27:14 +0200
Message-Id: <20230807162720.545787-18-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230807162720.545787-1-ardb@kernel.org>
References: <20230807162720.545787-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3324; i=ardb@kernel.org; h=from:subject; bh=Fk0lLfubzCQVs/j9K2oCq55VjZoVRLPQJNzwiQAW0qQ=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIeWidILRwStnrJT7mr4c2CLZK+3G+/6LZ+NjQybPDbrdv sYTva90lLIwiHEwyIopsgjM/vtu5+mJUrXOs2Rh5rAygQxh4OIUgIkIqzMyTPkze9WFq80Mbe/O f3mexnGz4aLjlpNR9y8vuu5hxmypzMrwP3jiMYtvXNPf7Pn3JT2heemL6J93vuRE2Rmd0brgE3X OghkA
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

Currently, the EFI stub relies on DXE services in some cases to clear
non-execute restrictions from page allocations that need to be
executable. This is dodgy, because DXE services are not specified by
UEFI but by PI, and they are not intended for consumption by OS loaders.
However, no alternative existed at the time.

Now, there is a new UEFI protocol that should be used instead, so if it
exists, prefer it over the DXE services calls.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/x86-stub.c | 29 ++++++++++++++------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index af5f50617a5b4c59..acb1c65bf8ac6fb3 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -26,6 +26,7 @@ const efi_system_table_t *efi_system_table;
 const efi_dxe_services_table_t *efi_dxe_table;
 u32 image_offset __section(".data");
 static efi_loaded_image_t *image = NULL;
+static efi_memory_attribute_protocol_t *memattr;
 
 typedef union sev_memory_acceptance_protocol sev_memory_acceptance_protocol_t;
 union sev_memory_acceptance_protocol {
@@ -233,12 +234,18 @@ void efi_adjust_memory_range_protection(unsigned long start,
 	unsigned long rounded_start, rounded_end;
 	unsigned long unprotect_start, unprotect_size;
 
-	if (efi_dxe_table == NULL)
-		return;
-
 	rounded_start = rounddown(start, EFI_PAGE_SIZE);
 	rounded_end = roundup(start + size, EFI_PAGE_SIZE);
 
+	if (memattr != NULL) {
+		efi_call_proto(memattr, clear_memory_attributes, rounded_start,
+			       rounded_end - rounded_start, EFI_MEMORY_XP);
+		return;
+	}
+
+	if (efi_dxe_table == NULL)
+		return;
+
 	/*
 	 * Don't modify memory region attributes, they are
 	 * already suitable, to lower the possibility to
@@ -801,6 +808,7 @@ void __noreturn efi_stub_entry(efi_handle_t handle,
 			       efi_system_table_t *sys_table_arg,
 			       struct boot_params *boot_params)
 {
+	efi_guid_t guid = EFI_MEMORY_ATTRIBUTE_PROTOCOL_GUID;
 	unsigned long bzimage_addr = (unsigned long)startup_32;
 	unsigned long buffer_start, buffer_end;
 	struct setup_header *hdr = &boot_params->hdr;
@@ -812,13 +820,18 @@ void __noreturn efi_stub_entry(efi_handle_t handle,
 	if (efi_system_table->hdr.signature != EFI_SYSTEM_TABLE_SIGNATURE)
 		efi_exit(handle, EFI_INVALID_PARAMETER);
 
-	efi_dxe_table = get_efi_config_table(EFI_DXE_SERVICES_TABLE_GUID);
-	if (efi_dxe_table &&
-	    efi_dxe_table->hdr.signature != EFI_DXE_SERVICES_TABLE_SIGNATURE) {
-		efi_warn("Ignoring DXE services table: invalid signature\n");
-		efi_dxe_table = NULL;
+	if (IS_ENABLED(CONFIG_EFI_DXE_MEM_ATTRIBUTES)) {
+		efi_dxe_table = get_efi_config_table(EFI_DXE_SERVICES_TABLE_GUID);
+		if (efi_dxe_table &&
+		    efi_dxe_table->hdr.signature != EFI_DXE_SERVICES_TABLE_SIGNATURE) {
+			efi_warn("Ignoring DXE services table: invalid signature\n");
+			efi_dxe_table = NULL;
+		}
 	}
 
+	/* grab the memory attributes protocol if it exists */
+	efi_bs_call(locate_protocol, &guid, NULL, (void **)&memattr);
+
 	status = efi_setup_5level_paging();
 	if (status != EFI_SUCCESS) {
 		efi_err("efi_setup_5level_paging() failed!\n");
-- 
2.39.2

