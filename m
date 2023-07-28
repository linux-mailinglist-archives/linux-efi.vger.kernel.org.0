Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23D4276687F
	for <lists+linux-efi@lfdr.de>; Fri, 28 Jul 2023 11:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233472AbjG1JNi (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 28 Jul 2023 05:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235455AbjG1JND (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 28 Jul 2023 05:13:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5119749E4;
        Fri, 28 Jul 2023 02:11:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BD70562086;
        Fri, 28 Jul 2023 09:11:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6530FC433C7;
        Fri, 28 Jul 2023 09:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690535510;
        bh=2+7iwEobaM7sVn9y3ZDpX6mWLwOi48XQ2V4eIw6Xv00=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r/Ry7g4M2JyKRAprdaf8CjNvMTK66dOKkNyOWQmZ/ZOAbPn7aO8+xLesw2AO56fem
         myrvWUb1JCsTZ+GaZkzu7XAg6eUzT1X1OZoTQMuRpuNKOJbpL3HHwS4UAYIBNmDwLm
         13wkKW38tTzU4inGH8e1hjqQuA4VEPUs0X3J/asgr4qXJNPfogPFY90G2mCPQpJSTl
         +FN+9jvcFq0TH4dWpVxzq7zXbPbDwpFEmR7RZQl+qDDy+ZVBFxqZo7xpzYzquwRXRs
         q3maT+ro4Rn4flmn48+q2qpiovLIimhwJbuNTS8lfe148AsaX1HbdbZU2fcHjiC8eq
         8bbLwxhidvRdQ==
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
Subject: [PATCH v7 16/22] x86/efistub: Prefer EFI memory attributes protocol over DXE services
Date:   Fri, 28 Jul 2023 11:09:10 +0200
Message-Id: <20230728090916.1538550-17-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230728090916.1538550-1-ardb@kernel.org>
References: <20230728090916.1538550-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3324; i=ardb@kernel.org; h=from:subject; bh=2+7iwEobaM7sVn9y3ZDpX6mWLwOi48XQ2V4eIw6Xv00=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIeVw65YPyiURGQ+6Hp43STs0P11B6qDF6UVtIYaKqkd8b FyKirM6SlkYxDgYZMUUWQRm/3238/REqVrnWbIwc1iZQIYwcHEKwES0LRj+V02f+n277kqhjGRt j9y2QvZmxciAoC3ndvneSGQzFwyJZvgrJnzBQrMrs5ZxwaGNrQ+02tY8d3S9uVvsgj+//4Tgm2n 8AA==
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
index 961ae3bd87058a45..efb4f5eda6784026 100644
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

