Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF8B059805F
	for <lists+linux-efi@lfdr.de>; Thu, 18 Aug 2022 10:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241348AbiHRIzz (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 18 Aug 2022 04:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235263AbiHRIzy (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 18 Aug 2022 04:55:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85DC4B07E9
        for <linux-efi@vger.kernel.org>; Thu, 18 Aug 2022 01:55:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2B9D061303
        for <linux-efi@vger.kernel.org>; Thu, 18 Aug 2022 08:55:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DC11C433D6;
        Thu, 18 Aug 2022 08:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660812952;
        bh=k2UO8HelSkz+8GRaRPGWyK8im8ylx1c2njdpoI2nOpU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DcqUIsPlBOaS50uRmOOBdwsEcurT0MyOrflb/x0elsocQ3PtoQxkCbpsPGiCL9nPn
         iGQTxTauT5f65idC60m6mA1J4j4DEw/KeBPjLD5uxh6vghbg74Q81sIvOwh/xXKGhb
         Wl+3k9hNPolKcQa9PpCa+JijzzDIXkiLCVusQ7KWURwgDeZW0kG000gKWOH53l2csA
         MWhMrQMt/Oom/DxPEEs4IyRwH1ViU4tQKyqInok9GrL/InH7y2/ycpXhMKrv7oanxV
         JAZzcfFnh5YhSnBiwn+E7Fb+GeNEGng7KNpd77bZJ3NboETMayJmiOF6wABCPStymj
         GgxuxP59fMStg==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     grub-devel@nongnu.org
Cc:     linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        grub-devel@gnu.org, Daniel Kiper <daniel.kiper@oracle.com>,
        Nikita Ermakov <arei@altlinux.org>,
        Atish Patra <atishp@atishpatra.org>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        dann frazier <dann.frazier@canonical.com>,
        Julian Andres Klode <julian.klode@canonical.com>
Subject: [PATCH resend 2/9] efi: move MS-DOS stub out of generic PE header definition
Date:   Thu, 18 Aug 2022 10:55:32 +0200
Message-Id: <20220818085540.2075028-3-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220818085540.2075028-1-ardb@kernel.org>
References: <20220818085540.2075028-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2567; i=ardb@kernel.org; h=from:subject; bh=k2UO8HelSkz+8GRaRPGWyK8im8ylx1c2njdpoI2nOpU=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBi/f56QdqCnOdynwO+RnWMsZoYnJV20mPQ/Lae/HQB bKHn2jiJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYv3+egAKCRDDTyI5ktmPJKs8C/ 0YWR2+S0Ee4+hBFdguiDzMuGbTNIiU/O0N3hrHqBWzRgYcK4W6tDwFKDeDCwjL3L8AJW0qugdmw6v8 3cAQkccamZOdtR6OqjUNqvmk9wGlGx8c/afLzac1C4ZSZO6a88ZRahMmjfWJE/syz0UXPyjP+wk0OG WQnGYrywimRpm8n3t2s/hdTdwGWdKcbkaMjP7dQKcjZ53rfz2zJ81zwCmmihDXzxBn3P52xMqnAK6l Xk0mPOkBjF/m972LDE4el3lu4n2okGxjHurnCLeLlhL9NYwOjPfHdGIix7lAx1leo0SKXHHjOiPdG4 nxIB04AWGLdK+9jPNjzXcnvQFfjUGgliT1duByVTvwTPFogj320BFIHXrFvf5QSug5v77383EhpuWQ jlCMwuwBNNCzlvtfGm7Lq6h+YIFgpZvs+1kXaGT7Tcjyc7U+tMAcK5AapQ/iLqqRyZeVJrepBPghW5 MD6zgtLgzkTRBRXu1aRq9JDmF9LFY+OLtklOfazbl5muc=
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

The PE/COFF spec permits the COFF signature and file header to appear
anywhere in the file, and the actual offset is recorded in 4 byte
little endian field at offset 0x3c of the image.

When GRUB is emitted as a PE/COFF binary, we reuse the 128 byte MS-DOS
stub (even for non-x86 architectures), putting the COFF signature and
file header at offset 0x80. However, other PE/COFF images may use
different values, and non-x86 Linux kernels use an offset of 0x40
instead.

So let's get rid of the grub_pe32_header struct from pe32.h, given that
it does not represent anything defined by the PE/COFF spec. Instead,
use the GRUB_PE32_MSDOS_STUB_SIZE macro explicitly to reference the
COFF header in the only place in the code where we rely on this.

The remaining fields are moved into a struct grub_coff_image_header,
which we will use later to access COFF header fields of arbitrary
images (and which may therefore appear at different offsets)

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 grub-core/kern/efi/efi.c | 5 +++--
 include/grub/efi/pe32.h  | 5 +----
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/grub-core/kern/efi/efi.c b/grub-core/kern/efi/efi.c
index e8a976a22f15..8bef81663853 100644
--- a/grub-core/kern/efi/efi.c
+++ b/grub-core/kern/efi/efi.c
@@ -302,7 +302,7 @@ grub_addr_t
 grub_efi_modules_addr (void)
 {
   grub_efi_loaded_image_t *image;
-  struct grub_pe32_header *header;
+  struct grub_coff_image_header *header;
   struct grub_pe32_coff_header *coff_header;
   struct grub_pe32_section_table *sections;
   struct grub_pe32_section_table *section;
@@ -313,7 +313,8 @@ grub_efi_modules_addr (void)
   if (! image)
     return 0;
 
-  header = image->image_base;
+  header = (struct grub_coff_image_header *) ((char *) image->image_base
+                                             + GRUB_PE32_MSDOS_STUB_SIZE);
   coff_header = &(header->coff_header);
   sections
     = (struct grub_pe32_section_table *) ((char *) coff_header
diff --git a/include/grub/efi/pe32.h b/include/grub/efi/pe32.h
index 0ed8781f0376..a2da4b318c85 100644
--- a/include/grub/efi/pe32.h
+++ b/include/grub/efi/pe32.h
@@ -254,11 +254,8 @@ struct grub_pe32_section_table
 
 #define GRUB_PE32_SIGNATURE_SIZE 4
 
-struct grub_pe32_header
+struct grub_coff_image_header
 {
-  /* This should be filled in with GRUB_PE32_MSDOS_STUB.  */
-  grub_uint8_t msdos_stub[GRUB_PE32_MSDOS_STUB_SIZE];
-
   /* This is always PE\0\0.  */
   char signature[GRUB_PE32_SIGNATURE_SIZE];
 
-- 
2.35.1

