Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13D1D76D2EB
	for <lists+linux-efi@lfdr.de>; Wed,  2 Aug 2023 17:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231751AbjHBPvU (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 2 Aug 2023 11:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235402AbjHBPuq (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 2 Aug 2023 11:50:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEE4A3596;
        Wed,  2 Aug 2023 08:50:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BDB9D61A10;
        Wed,  2 Aug 2023 15:50:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B040C433D9;
        Wed,  2 Aug 2023 15:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690991406;
        bh=Fk0lLfubzCQVs/j9K2oCq55VjZoVRLPQJNzwiQAW0qQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pM2dh/VqIQP2foHklYhi2bz1N/K1e/kApDhtEK6uWahoySFf6DH+bIBmYtveEJQPZ
         SQMnRKw/1zg5frs8h77kxJhY55Z0Fxut199fn56+qQOjxgQmwuugf0bLFVaVoHRCd6
         eT6Kzs4vNxOo9GvyS4fNMLiINxvAsLFOATnpW3oiyZZji9Yjl5qnQFIs5Xh4TCXlow
         9AVbL/XK9oZ8ZCw3wmTMhTH25t8gRmh5BWA6hT1xV8Bu005BfTXXZ8nqhqwctjfqoS
         KCGmXmzfgxAue6FXEXLEsYP1v4HNXJ2D26fT9OX/IDnQaTgtzUfRIOF9uGGxs6zyDC
         Ro+nAcq46OC7w==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Evgeniy Baskov <baskov@ispras.ru>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Peter Jones <pjones@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Dave Young <dyoung@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Kees Cook <keescook@chromium.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>
Subject: [PATCH v8 17/23] x86/efistub: Prefer EFI memory attributes protocol over DXE services
Date:   Wed,  2 Aug 2023 17:48:25 +0200
Message-Id: <20230802154831.2147855-18-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230802154831.2147855-1-ardb@kernel.org>
References: <20230802154831.2147855-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3324; i=ardb@kernel.org; h=from:subject; bh=Fk0lLfubzCQVs/j9K2oCq55VjZoVRLPQJNzwiQAW0qQ=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIeVU1XGjg1fOWCn3NX05sEWyV9qN9/0Xz8bHhkyeG3S7f Y0nel/pKGVhEONgkBVTZBGY/ffdztMTpWqdZ8nCzGFlAhnCwMUpABPRzGP4w7OwMJnFZJbhzrkl JgGVa1ad2xlTssymR/nR2+5ivrQrfxkZ/nPsaPrwcxrjYrX2Rd4deZ58npNfr8nw+ZEv3/3+1MW XHAA=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

