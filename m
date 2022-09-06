Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A9035AE59D
	for <lists+linux-efi@lfdr.de>; Tue,  6 Sep 2022 12:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239574AbiIFKmI (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 6 Sep 2022 06:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239449AbiIFKl7 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 6 Sep 2022 06:41:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A754A5F224;
        Tue,  6 Sep 2022 03:41:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E66146148B;
        Tue,  6 Sep 2022 10:41:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FD60C433D7;
        Tue,  6 Sep 2022 10:41:54 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="N/lSShvq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1662460912;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sxwyXgPnrfZoO4XIqVDt6gjxOKUSRHK702YIPLqC1Ic=;
        b=N/lSShvq9fxySefxYGSkHa25GjAlvdsMcoIy5rKkxWgt27H8ifhPgrxC8s/uSChk5kJhFb
        ZeBKJjL7icS4Ch7/LyYTc8HyPWqutJN3nFMi3m/M+H4s6tcc5TRlrgpjNE/qnOckzJkwh5
        0ZorBg57L0779IP4AqXayvUH8iNNycE=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id c1062930 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 6 Sep 2022 10:41:52 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     ardb@kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org, bp@alien8.de
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Borislav Petkov <bp@suse.de>
Subject: [PATCH v2] efi: x86: Wipe setup_data on pure EFI boot
Date:   Tue,  6 Sep 2022 12:41:47 +0200
Message-Id: <20220906104147.287726-1-Jason@zx2c4.com>
In-Reply-To: <CAHmME9ozPTL7tpj-QoFK3Dfyq58VAJgmM6MjUBW4VVM_TXo3VA@mail.gmail.com>
References: <CAHmME9ozPTL7tpj-QoFK3Dfyq58VAJgmM6MjUBW4VVM_TXo3VA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

When booting the x86 kernel via EFI using the LoadImage/StartImage boot
services [as opposed to the deprecated EFI handover protocol], the setup
header is taken from the image directly, and given that EFI's LoadImage
has no Linux/x86 specific knowledge regarding struct bootparams or
struct setup_header, any absolute addresses in the setup header must
originate from the file and not from a prior loading stage.

Since we cannot generally predict where LoadImage() decides to load an
image (*), such absolute addresses must be treated as suspect: even if a
prior boot stage intended to make them point somewhere inside the
[signed] image, there is no way to validate that, and if they point at
an arbitrary location in memory, the setup_data nodes will not be
covered by any signatures or TPM measurements either, and could be made
to contain an arbitrary sequence of SETUP_xxx nodes, which could
interfere quite badly with the early x86 boot sequence.

(*) Note that, while LoadImage() does take a buffer/size tuple in
addition to a device path, which can be used to provide the image
contents directly, it will re-allocate such images, as the memory
footprint of an image is generally larger than the PE/COFF file
representation.

Next, in order to allow hypervisors to still use setup_data in scenarios
where it may be useful, bump the x86 boot protocol version, so that
hypervisors, e.g. QEMU in the linked patch, can do the right thing
automatically depending on whether it is safe.

Link: https://lore.kernel.org/qemu-devel/20220904165058.1140503-1-Jason@zx2c4.com/
Coauthored-by: Ard Biesheuvel <ardb@kernel.org>
Cc: Borislav Petkov <bp@suse.de>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 Documentation/x86/boot.rst              | 2 ++
 arch/x86/boot/header.S                  | 2 +-
 drivers/firmware/efi/libstub/x86-stub.c | 7 +++++++
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/Documentation/x86/boot.rst b/Documentation/x86/boot.rst
index 894a19897005..9181f905937d 100644
--- a/Documentation/x86/boot.rst
+++ b/Documentation/x86/boot.rst
@@ -75,6 +75,8 @@ Protocol 2.14	BURNT BY INCORRECT COMMIT
 		DO NOT USE!!! ASSUME SAME AS 2.13.
 
 Protocol 2.15	(Kernel 5.5) Added the kernel_info and kernel_info.setup_type_max.
+
+Protocol 2.16   (Kernel 6.0) EFI stub loader ignores setup_data pointer.
 =============	============================================================
 
 .. note::
diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
index f912d7770130..e4e2d6e33924 100644
--- a/arch/x86/boot/header.S
+++ b/arch/x86/boot/header.S
@@ -307,7 +307,7 @@ _start:
 	# Part 2 of the header, from the old setup.S
 
 		.ascii	"HdrS"		# header signature
-		.word	0x020f		# header version number (>= 0x0105)
+		.word	0x0210		# header version number (>= 0x0105)
 					# or else old loadlin-1.5 will fail)
 		.globl realmode_swtch
 realmode_swtch:	.word	0, 0		# default_switch, SETUPSEG
diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index 05ae8bcc9d67..9780f32a9f24 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -517,6 +517,13 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 	hdr->ramdisk_image = 0;
 	hdr->ramdisk_size = 0;
 
+	/*
+	 * Disregard any setup data that was provided by the bootloader:
+	 * setup_data could be pointing anywhere, and we have no way of
+	 * authenticating or validating the payload.
+	 */
+	hdr->setup_data = 0;
+
 	efi_stub_entry(handle, sys_table_arg, boot_params);
 	/* not reached */
 
-- 
2.37.3

