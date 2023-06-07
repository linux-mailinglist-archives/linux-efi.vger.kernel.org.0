Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52764725592
	for <lists+linux-efi@lfdr.de>; Wed,  7 Jun 2023 09:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239155AbjFGH0X (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 7 Jun 2023 03:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239159AbjFGHZx (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 7 Jun 2023 03:25:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB2022114;
        Wed,  7 Jun 2023 00:24:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4FF1363A8C;
        Wed,  7 Jun 2023 07:24:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E97D9C4339C;
        Wed,  7 Jun 2023 07:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686122695;
        bh=Pxc47KrrrsEBit8kTu0GOtEy/tpcGOklzRJpkQn39Y8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s4/EYgFdfjtIzQr8yP0jJgCBjOtdFWT/UO3ocuWZPAWZ/D3wWDLFy9FuM/L7bt+GC
         wBQ/dSV7INcCqA6rmO4Q43naX5ZtpU43WGVrF5Io8ITV4hHR6+gpVvG0wIZhZdXOI1
         DD86kzwbVG573B9nBbEU6rZZJ/4rOF2UdEXYyu7mdU9NvFGoxNrKidYbVaGKxz+7H8
         KUFrEUNd/As06wURitXLr7SoM8T7S/otVfnj/xu/Q4jDKPfT/M4D7SkJ6zAf5AmOqZ
         hGmb4I5j2TK5zq4lF4aWDfYgMLKXp0pDIjmK+2ZV+8OAns4A2fW4lngT8SSJyvFs5K
         bO6t2fkKk1Tng==
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
Subject: [PATCH v5 14/20] x86/efistub: Prefer EFI memory attributes protocol over DXE services
Date:   Wed,  7 Jun 2023 09:23:36 +0200
Message-Id: <20230607072342.4054036-15-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230607072342.4054036-1-ardb@kernel.org>
References: <20230607072342.4054036-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3324; i=ardb@kernel.org; h=from:subject; bh=Pxc47KrrrsEBit8kTu0GOtEy/tpcGOklzRJpkQn39Y8=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIaXBoOz034gVyw6flmTJ+t7ddUx6iu3Xx57bZnhesgk9l nz/7AGpjlIWBjEOBlkxRRaB2X/f7Tw9UarWeZYszBxWJpAhDFycAjCRxUIM/5TfFSw73Sx2+fj/ S3b82w2OdOp7JThnMwY9qmKbX19rl83IsNdg+uF/E+9WO0/2XSrQsa8w4o3sU9733/VVjghdfu/ LwwUA
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
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
index f48a2e795d885af8..abcd5703e9f3f980 100644
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

