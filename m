Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9008263C6E3
	for <lists+linux-efi@lfdr.de>; Tue, 29 Nov 2022 18:56:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233673AbiK2R4h (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 29 Nov 2022 12:56:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236718AbiK2R42 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 29 Nov 2022 12:56:28 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87C7669ABF
        for <linux-efi@vger.kernel.org>; Tue, 29 Nov 2022 09:56:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 22BAC61883
        for <linux-efi@vger.kernel.org>; Tue, 29 Nov 2022 17:56:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDAEFC433D6;
        Tue, 29 Nov 2022 17:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669744585;
        bh=sJWC16ILyfOZbxbYy2fDoMRiovsRGsCARg2aTQp3F7w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eFgtduMxiw/oWvzdPa3/ta8K9yNNPqSrp7FhvkoV62mImIJmZaAJId/xe1P54I0q0
         Di62i/2jIUq9iKsuEXccAMgjxJ93MW8NRy0x6FvbagbMGkqrR31YB6CRPhE7ueiwTw
         75kQX0BIfQFXZSLMT3HbcJDBo493g5rh0KZ+Yi4N5mQxUxlucWS5p+Aqyk6hoEgzGa
         BiMPSFKzh278eejPyiJpQB8yohIGdytnnt77ZFGQpo68xANcz0PbLrIPaU1EwO+Ek6
         SQaXdMlGnhaF7aH0OVoYzhV226VAr3hdctYeamNoZDAfAVVjhxihD3bB4fl4E0DcDn
         hisXCcK9Ywbjg==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     grub-devel@gnu.org, Ard Biesheuvel <ardb@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        Leif Lindholm <quic_llindhol@quicinc.com>
Subject: [PATCH v2 1/2] efi: libstub: Always enable initrd command line loader and bump version
Date:   Tue, 29 Nov 2022 18:56:15 +0100
Message-Id: <20221129175616.2089294-2-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221129175616.2089294-1-ardb@kernel.org>
References: <20221129175616.2089294-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2817; i=ardb@kernel.org; h=from:subject; bh=sJWC16ILyfOZbxbYy2fDoMRiovsRGsCARg2aTQp3F7w=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjhke9Kz2RUlfp+gIYhmk64X5pkVsVyFWPV20I4WZH Q6FAh8yJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCY4ZHvQAKCRDDTyI5ktmPJJP0C/ 9xhsRl0z2uL+HnC9hp1kb2Q+Qc6QCLJoCMX9m63FAMhjXJpSJ3wJspyG+Tm6Or5DCy8yXiwKEeGhkT FCZTYrOG8rrv2ouYKeNivNi0klw/nPhYlV8yekTbuQCTle2GiYVq6f8BfvzklH3NooSCLpsBoWpKbU sa4hKMQVDx03MXUkuIZRee1hFpWTED1k8Qw2i3PuvegrER/2kV1DUoqaGpLiXIjDtipBsDUnvo3gEI lwwp0rEUiS+eTtMiePEXa94JwTDC6+y90NB+a8/epaVOqxXBKhbaLMexcFn1JSuJR5R9rltbrbCy0p 6cYqv/90De4nHh+31we1w1EQFJH47c2YowyMi5HqtoCcaUZ8NK+sTf/751SvzhUrmHrl6IC5QdKBv8 cykX1FuiXDKOCy6vC+qur936OWmADx4sju99QnDQ+6fkrSFhQNSkz0gJv863oGvVa2sOJzJAhq2Tse ID36gncfYdALPTUkwPx5E9+9BeRfGDQLkaHPdCWbA1hzY=
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

In preparation for setting a cross-architecture baseline for EFI boot
support, remove the Kconfig option that permits the command line initrd
loader to be disabled. Also, bump the minor version so that any image
built with the new version can be identified as supporting this.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/Kconfig                   | 15 ---------------
 drivers/firmware/efi/libstub/efi-stub-helper.c |  3 +--
 include/linux/pe.h                             |  2 +-
 3 files changed, 2 insertions(+), 18 deletions(-)

diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
index 08ed88e49ea307b0..043ca31c114ebf2a 100644
--- a/drivers/firmware/efi/Kconfig
+++ b/drivers/firmware/efi/Kconfig
@@ -106,21 +106,6 @@ config EFI_ARMSTUB_DTB_LOADER
 	  functionality for bootloaders that do not have such support
 	  this option is necessary.
 
-config EFI_GENERIC_STUB_INITRD_CMDLINE_LOADER
-	bool "Enable the command line initrd loader" if !X86
-	depends on EFI_STUB && (EFI_GENERIC_STUB || X86)
-	default y if X86
-	help
-	  Select this config option to add support for the initrd= command
-	  line parameter, allowing an initrd to be loaded into memory that
-	  resides on a file system backed by an implementation of
-	  EFI_SIMPLE_FILE_SYSTEM_PROTOCOL.
-
-	  This method has been superseded by the simpler LoadFile2 based
-	  initrd loading method, but the initrd= loader is retained as it
-	  can be used from the UEFI Shell or other generic loaders that
-	  don't implement the Linux specific LoadFile2 method.
-
 config EFI_BOOTLOADER_CONTROL
 	tristate "EFI Bootloader Control"
 	select UCS2_STRING
diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index 739454d8063af8b1..f5a4bdacac642846 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -538,8 +538,7 @@ efi_status_t efi_load_initrd_cmdline(efi_loaded_image_t *image,
 				     unsigned long soft_limit,
 				     unsigned long hard_limit)
 {
-	if (!IS_ENABLED(CONFIG_EFI_GENERIC_STUB_INITRD_CMDLINE_LOADER) ||
-	    (IS_ENABLED(CONFIG_X86) && image == NULL))
+	if (image == NULL)
 		return EFI_UNSUPPORTED;
 
 	return handle_cmdline_files(image, L"initrd=", sizeof(L"initrd=") - 2,
diff --git a/include/linux/pe.h b/include/linux/pe.h
index 1d3836ef9d92dcd8..056a1762de904fc1 100644
--- a/include/linux/pe.h
+++ b/include/linux/pe.h
@@ -29,7 +29,7 @@
  * handover_offset and xloadflags fields in the bootparams structure.
  */
 #define LINUX_EFISTUB_MAJOR_VERSION		0x1
-#define LINUX_EFISTUB_MINOR_VERSION		0x0
+#define LINUX_EFISTUB_MINOR_VERSION		0x1
 
 #define MZ_MAGIC	0x5a4d	/* "MZ" */
 
-- 
2.35.1

