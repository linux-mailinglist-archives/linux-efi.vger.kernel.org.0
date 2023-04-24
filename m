Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 758826ED2FB
	for <lists+linux-efi@lfdr.de>; Mon, 24 Apr 2023 18:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232272AbjDXQ6R (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 24 Apr 2023 12:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232222AbjDXQ6D (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 24 Apr 2023 12:58:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B644A7D89;
        Mon, 24 Apr 2023 09:57:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2D55862209;
        Mon, 24 Apr 2023 16:57:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 296C8C4339C;
        Mon, 24 Apr 2023 16:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682355476;
        bh=+UAx1b4wALU5+iWX8voL/AzXHT4rT38dEfcqRFfOVjw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p06tU5UCRqKvj2ttM49GPkKyGllkbg+S7TjvhD4H3NoTsw6Pc5usF0D1J7UG1YvPo
         tXeNFlCeU4Gpu2bP6nSaUiJXJGDbOqOkFpv+fJLKFC+r4msnfvdy2hbJfL2Ak3bkEt
         Sl2XIt7Q/KteAWoQjxunBZVMiHpK8WTW2sIlDSR3DqQA54CNL3zBrkuvkzlJYGvxW2
         v1svK4pCCw7/PyzsaPDFc7wEdIjyBWw7Q2HBDbZUsSgoVgiPn0rWIkE/UkF8RS8p+D
         Q5CpVHDh37Mx7gJ4HxftpNu+FOKTtKPCWuyqqFUNdjlGvEuLkT0/cRAHXYy0Cz4cFX
         c+u3Ur2VHjcpw==
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
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 5/6] x86: efistub: Prefer EFI memory attributes protocol over DXE services
Date:   Mon, 24 Apr 2023 18:57:25 +0200
Message-Id: <20230424165726.2245548-6-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230424165726.2245548-1-ardb@kernel.org>
References: <20230424165726.2245548-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2947; i=ardb@kernel.org; h=from:subject; bh=+UAx1b4wALU5+iWX8voL/AzXHT4rT38dEfcqRFfOVjw=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIcVtyxddNYUPXzIfuR9fYxqd/Kk4QSEinuNH7O6y+sUvf +S1T47uKGVhEONgkBVTZBGY/ffdztMTpWqdZ8nCzGFlAhnCwMUpABM5OofhD1cCx4WPZ002xDtb FZStWOyw/Di74UfTCQ8ZZnTHf72uN5Phr+yU/vTIpuSDHBxn4x6qMM4tWBUrqO0x7WpwvzW3c0g NHwA=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Currently, we rely on DXE services in some cases to clear non-execute
restrictions from page allocations that need to be executable. This is
dodgy, because DXE services are not specified by UEFI but by PI, and
they are not intended for consumption by OS loaders. However, no
alternative existed at the time.

Now, there is a new UEFI protocol that should be used instead, so if it
exists, prefer it over the DXE services calls.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/x86-stub.c | 28 ++++++++++++++------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index 7b8717cbb96a1246..ea4024a6a04e507f 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -25,6 +25,7 @@ const efi_system_table_t *efi_system_table;
 const efi_dxe_services_table_t *efi_dxe_table;
 u32 image_offset __section(".data");
 static efi_loaded_image_t *image = NULL;
+static efi_memory_attribute_protocol_t *memattr;
 
 static efi_status_t
 preserve_pci_rom_image(efi_pci_io_protocol_t *pci, struct pci_setup_rom **__rom)
@@ -221,12 +222,18 @@ adjust_memory_range_protection(unsigned long start, unsigned long size)
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
@@ -913,13 +920,18 @@ asmlinkage unsigned long efi_main(efi_handle_t handle,
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
 	if (!boot_params->acpi_rsdp_addr)
 		boot_params->acpi_rsdp_addr = (unsigned long)
 				(get_efi_config_table(ACPI_20_TABLE_GUID) ?:
-- 
2.39.2

