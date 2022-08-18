Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2324E598060
	for <lists+linux-efi@lfdr.de>; Thu, 18 Aug 2022 10:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243575AbiHRI4E (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 18 Aug 2022 04:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243498AbiHRI4D (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 18 Aug 2022 04:56:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE1AB50703
        for <linux-efi@vger.kernel.org>; Thu, 18 Aug 2022 01:56:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 110A261237
        for <linux-efi@vger.kernel.org>; Thu, 18 Aug 2022 08:56:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4781DC433C1;
        Thu, 18 Aug 2022 08:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660812960;
        bh=a+eFr/WWVWSZD8tqmOLBJll8Nv1OKzhzVxe2gHJjaUY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IaZmpsY3ST2AXJ47TQ22gRS1OfX8nJ5xh3WwOsWAt+KVf5QIV6iazGGAQrsBbU32K
         4eyCmddvUCy7vHj2E1r6/OkXRSgDV7SkAWs9yMMR/WGsCHoYWqkGeEYnZhoh0k/h3k
         zzOGDmJdLHvm8Hu4vMJFZz9tcGMEuGnCi0HNg+3YyOIrspqib601hEmPCKHT3wHHMw
         jFQgHw+acpv6409i4laJBcMG40mB0C6XIZNbylg4eN3D3i35zgO6Gltz8JB6oD1+jN
         qcXKG+UX5bkG+2B0xj+pmKX+Ma+G4B+FiEUthsc9wl/y3iWIu1IsiojnLB7C0/m8J+
         mRWSgIPYLsg8g==
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
Subject: [PATCH resend 5/9] linux/arm: account for COFF headers appearing at unexpected offsets
Date:   Thu, 18 Aug 2022 10:55:35 +0200
Message-Id: <20220818085540.2075028-6-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220818085540.2075028-1-ardb@kernel.org>
References: <20220818085540.2075028-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1728; i=ardb@kernel.org; h=from:subject; bh=a+eFr/WWVWSZD8tqmOLBJll8Nv1OKzhzVxe2gHJjaUY=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBi/f6BfuSyB/c1hJQvT4WLgOeT3CQgUVdcUMdP0I4U 6vQwkCWJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYv3+gQAKCRDDTyI5ktmPJHTZDA COKTzz8eiwQda7wzX7CEGwq1qjPrYtILKOH2IKixjq15gbO287HgaCNVdYfH+zN3CAQB3nAGoA6sR7 vzlXzxLrhB6WicLirVyxS9k6in6K0RtUqBSZcmYhBuJMj0HScMEn+/G2Vf29plHyYrl31/6hJP9TnD wBP4vbWZtfpiCMn9DJLq63vL4dLxwkLN5VUjT8eZ5zNywogzc6Fe2/zTTUjNPIReK66XF5vuSI7fB0 8vlnlRqrSMewSmisEi2D1SVO355x3kYOW6fotRk2gsCQ35naUnDVzlW04mLyE6uI0/DHXlvn0fv2hS vD+khlodNoDEAN9r7HAU3iXeycR138PouwfwJpS82znkehHV5mNXZcGoDb3ftrVa6f476FyMF1hVwh ACDzYc/qKELufH/XH66bAV9kHH46H0xszWJBtF0Rzlq+07VkO6eRTQfIUzxtO9eCRMbzXqan6IbHyU la3msqCx2JlDHezocBBzUbdrdH3MhzRUuGrOwIGSF9uEs=
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

The way we load the Linux and PE/COFF image headers depends on a fixed
placement of the COFF header at offset 0x40 into the file. This is a
reasonable default, given that this is where Linux emits it today.
However, in order to comply with the PE/COFF spec, which allows this
header to appear anywhere in the file, let's ensure that we read the
header from where it actually appears in the file if it is not located
at offset 0x40.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 grub-core/loader/arm64/linux.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/grub-core/loader/arm64/linux.c b/grub-core/loader/arm64/linux.c
index 7c0f17cf933d..56ba8d0a6ea3 100644
--- a/grub-core/loader/arm64/linux.c
+++ b/grub-core/loader/arm64/linux.c
@@ -63,6 +63,21 @@ grub_arch_efi_linux_load_image_header (grub_file_t file,
   grub_dprintf ("linux", "UEFI stub kernel:\n");
   grub_dprintf ("linux", "PE/COFF header @ %08x\n", lh->hdr_offset);
 
+  /*
+   * The PE/COFF spec permits the COFF header to appear anywhere in the file, so
+   * we need to double check whether it was where we expected it, and if not, we
+   * must load it from the correct offset into the coff_image_header field of
+   * struct linux_arch_kernel_header.
+   */
+  if ((grub_uint8_t *) lh + lh->hdr_offset != (grub_uint8_t *) &lh->coff_image_header)
+    {
+      grub_file_seek (file, lh->hdr_offset);
+
+      if (grub_file_read (file, &lh->coff_image_header, sizeof(struct grub_coff_image_header))
+         != sizeof(struct grub_coff_image_header))
+       return grub_error(GRUB_ERR_FILE_READ_ERROR, "failed to read COFF image header");
+    }
+
   return GRUB_ERR_NONE;
 }
 
-- 
2.35.1

