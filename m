Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D374A6B12F5
	for <lists+linux-efi@lfdr.de>; Wed,  8 Mar 2023 21:22:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbjCHUWn (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 8 Mar 2023 15:22:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbjCHUWf (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 8 Mar 2023 15:22:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40B8DBAD2E
        for <linux-efi@vger.kernel.org>; Wed,  8 Mar 2023 12:22:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D146961934
        for <linux-efi@vger.kernel.org>; Wed,  8 Mar 2023 20:22:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC503C4339B;
        Wed,  8 Mar 2023 20:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678306941;
        bh=dCFnCjx8rLSr7OtWUXyw/SvWurTkdS3FNJ7m/wpzFY4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IHUip3yo34W5K8xpqJbpRsysG/I4J99i8ZfkPVEcsgDvgUEGJdKsOFl7i1yAdgH0g
         0bI1IcxLRH2DhLMX08gGAENfXSgkreFY5quE+LSPZbt35S08rtOV279BhyWSSJh239
         rVKXZGdBO+kh3eHApseU6qspOcV+Me0UR8S2u8WPwIfPLKtOYzlV8ndzzIOv0YciP9
         uNpDU1pD17lEHN1CUhhzBOuijLdlHTL25eNcxgpsJuS+KNy+kmiYklHtr7goOWUoG1
         u+LuISGjgG15kdCLQh1T2+benexzzWG3AdIv5lDNKjjO9z5ygwlad5Xgse5EpoGET+
         sWZwE3L3Y3QzA==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Evgeniy Baskov <baskov@ispras.ru>,
        Borislav Petkov <bp@alien8.de>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Peter Jones <pjones@redhat.com>,
        "Limonciello, Mario" <mario.limonciello@amd.com>
Subject: [RFC PATCH 1/4] efi: x86: Use private copy of struct setup_header
Date:   Wed,  8 Mar 2023 21:22:06 +0100
Message-Id: <20230308202209.2980947-2-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230308202209.2980947-1-ardb@kernel.org>
References: <20230308202209.2980947-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7169; i=ardb@kernel.org; h=from:subject; bh=dCFnCjx8rLSr7OtWUXyw/SvWurTkdS3FNJ7m/wpzFY4=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIYXjXX691Y/dPa8O9qw1lei0+uMvzfI30/LHgnZPoao3V 50dzy3sKGVhEONgkBVTZBGY/ffdztMTpWqdZ8nCzGFlAhnCwMUpABOp1mVkeB3Qs8bq17prZbNS pibYfVbwvKlUEsC076RY5MzyXFWJOEaGhob1vDmaF9rni1m+jzswVe+wudC9nLe96TfUilUmClm yAgA=
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

The native EFI entrypoint does not take a struct boot_params from the
loader, but instead, it constructs one from scratch, using the setup
header data from the start of the image.

This setup header is placed in a way that permits legacy loaders to
manipulate the contents (i.e., to pass the kernel command line or the
address and size of an initial ramdisk), but EFI boot does not use it in
that way - it only copies the contents that were placed there at build
time, but EFI loaders will not (and should not) manipulate the setup
header to configure the boot. (Commit 63bf28ceb3ebbe76 "efi: x86: Wipe
setup_data on pure EFI boot" deals with some of the fallout of using
setup_data in a way that breaks EFI boot.) So having a pristine, private
copy of the setup header rather than copying the one legacy boot loaders
use would be an advantage for EFI boot.

As it turns out, there is another reason why copying this header is
slightly problematic: the fixed offset of 0x1f1 bytes into the image
makes it difficult to describe all the sections of the image, as we are
running out of space. We could mitigate this by placing some parts of
the PE/COFF header after this setup header (which will happen in a
subsequent patch), but this makes the setup_header fundamentally part of
the PE header as well, which means that it is no longer part of the
'in-memory' representation of the PE image, but only part of the
'on-disk' representation. This means copying the setup header from the
running image may not work, as the PE loader may not have put it in
memory to begin with.

So let's work around this, and simplify things at the same time, by just
copying the setup header into a EFI stub private allocation at build
time, and use that instead of copying it from the loaded image after it
has been started.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/Makefile                  |  2 +-
 arch/x86/boot/tools/build.c             |  8 ++++
 drivers/firmware/efi/libstub/x86-stub.c | 43 +++-----------------
 3 files changed, 15 insertions(+), 38 deletions(-)

diff --git a/arch/x86/boot/Makefile b/arch/x86/boot/Makefile
index 9e38ffaadb5d972e..8203f1a23f7a1734 100644
--- a/arch/x86/boot/Makefile
+++ b/arch/x86/boot/Makefile
@@ -91,7 +91,7 @@ $(obj)/vmlinux.bin: $(obj)/compressed/vmlinux FORCE
 
 SETUP_OBJS = $(addprefix $(obj)/,$(setup-y))
 
-sed-zoffset := -e 's/^\([0-9a-fA-F]*\) [a-zA-Z] \(startup_32\|startup_64\|efi32_stub_entry\|efi64_stub_entry\|efi_pe_entry\|efi32_pe_entry\|input_data\|kernel_info\|_end\|_ehead\|_text\|z_.*\)$$/\#define ZO_\2 0x\1/p'
+sed-zoffset := -e 's/^\([0-9a-fA-F]*\) [a-zA-Z] \(startup_32\|startup_64\|efi32_stub_entry\|efi64_stub_entry\|efi_pe_entry\|efi32_pe_entry\|efi_boot_params\|input_data\|kernel_info\|_end\|_ehead\|_text\|z_.*\)$$/\#define ZO_\2 0x\1/p'
 
 quiet_cmd_zoffset = ZOFFSET $@
       cmd_zoffset = $(NM) $< | sed -n $(sed-zoffset) > $@
diff --git a/arch/x86/boot/tools/build.c b/arch/x86/boot/tools/build.c
index a25c0c5efda95989..e6fd09789482ed04 100644
--- a/arch/x86/boot/tools/build.c
+++ b/arch/x86/boot/tools/build.c
@@ -115,6 +115,7 @@ static unsigned long efi32_stub_entry;
 static unsigned long efi64_stub_entry;
 static unsigned long efi_pe_entry;
 static unsigned long efi32_pe_entry;
+static unsigned long efi_boot_params;
 static unsigned long kernel_info;
 static unsigned long startup_64;
 static unsigned long _ehead;
@@ -453,6 +454,7 @@ static void parse_zoffset(char *fname)
 		PARSE_ZOFS(p, efi64_stub_entry);
 		PARSE_ZOFS(p, efi_pe_entry);
 		PARSE_ZOFS(p, efi32_pe_entry);
+		PARSE_ZOFS(p, efi_boot_params);
 		PARSE_ZOFS(p, kernel_info);
 		PARSE_ZOFS(p, startup_64);
 		PARSE_ZOFS(p, _ehead);
@@ -589,6 +591,12 @@ int main(int argc, char **argv)
 	memcpy(output + setup_size, kernel, kern_file_size);
 	memset(output + setup_size + kern_file_size, 0, kern_size - kern_file_size);
 
+#ifdef CONFIG_EFI_STUB
+	/* Copy the setup header */
+	memcpy(output + setup_size + efi_boot_params + 0x1f1, &buf[0x1f1],
+	       0x290 - 0x1f1 /* == max possible sizeof(struct setup_header) */);
+#endif
+
 	/* Calculate and write kernel checksum. */
 	crc = partial_crc32(output, total_size - 4, crc);
 	put_unaligned_le32(crc, &output[total_size - 4]);
diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index 1d1ab1911fd37767..5dbc9c7a4aa3aee7 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -347,6 +347,8 @@ void __noreturn efi_stub_entry(efi_handle_t handle,
 			       efi_system_table_t *sys_table_arg,
 			       struct boot_params *boot_params);
 
+struct boot_params efi_boot_params __section(".data") __aligned(SZ_4K);
+
 /*
  * Because the x86 boot code expects to be passed a boot_params we
  * need to create one ourselves (usually the bootloader would create
@@ -355,7 +357,6 @@ void __noreturn efi_stub_entry(efi_handle_t handle,
 efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 				   efi_system_table_t *sys_table_arg)
 {
-	struct boot_params *boot_params;
 	struct setup_header *hdr;
 	void *image_base;
 	efi_guid_t proto = LOADED_IMAGE_PROTOCOL_GUID;
@@ -378,55 +379,23 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 	image_base = efi_table_attr(image, image_base);
 	image_offset = (void *)startup_32 - image_base;
 
-	status = efi_allocate_pages(sizeof(struct boot_params),
-				    (unsigned long *)&boot_params, ULONG_MAX);
-	if (status != EFI_SUCCESS) {
-		efi_err("Failed to allocate lowmem for boot params\n");
-		efi_exit(handle, status);
-	}
-
-	memset(boot_params, 0x0, sizeof(struct boot_params));
-
-	hdr = &boot_params->hdr;
-
-	/* Copy the setup header from the second sector to boot_params */
-	memcpy(&hdr->jump, image_base + 512,
-	       sizeof(struct setup_header) - offsetof(struct setup_header, jump));
-
-	/*
-	 * Fill out some of the header fields ourselves because the
-	 * EFI firmware loader doesn't load the first sector.
-	 */
-	hdr->root_flags	= 1;
-	hdr->vid_mode	= 0xffff;
-	hdr->boot_flag	= 0xAA55;
-
-	hdr->type_of_loader = 0x21;
+	hdr = &efi_boot_params.hdr;
 
 	/* Convert unicode cmdline to ascii */
 	cmdline_ptr = efi_convert_cmdline(image, &options_size);
 	if (!cmdline_ptr)
 		goto fail;
 
-	efi_set_u64_split((unsigned long)cmdline_ptr,
-			  &hdr->cmd_line_ptr, &boot_params->ext_cmd_line_ptr);
+	efi_set_u64_split((unsigned long)cmdline_ptr, &hdr->cmd_line_ptr,
+			  &efi_boot_params.ext_cmd_line_ptr);
 
 	hdr->ramdisk_image = 0;
 	hdr->ramdisk_size = 0;
 
-	/*
-	 * Disregard any setup data that was provided by the bootloader:
-	 * setup_data could be pointing anywhere, and we have no way of
-	 * authenticating or validating the payload.
-	 */
-	hdr->setup_data = 0;
-
-	efi_stub_entry(handle, sys_table_arg, boot_params);
+	efi_stub_entry(handle, sys_table_arg, &efi_boot_params);
 	/* not reached */
 
 fail:
-	efi_free(sizeof(struct boot_params), (unsigned long)boot_params);
-
 	efi_exit(handle, status);
 }
 
-- 
2.39.2

