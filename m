Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C7BF598067
	for <lists+linux-efi@lfdr.de>; Thu, 18 Aug 2022 10:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243348AbiHRIzx (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 18 Aug 2022 04:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243575AbiHRIzv (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 18 Aug 2022 04:55:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04CF6B07EF
        for <linux-efi@vger.kernel.org>; Thu, 18 Aug 2022 01:55:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 85C566124A
        for <linux-efi@vger.kernel.org>; Thu, 18 Aug 2022 08:55:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7574C433B5;
        Thu, 18 Aug 2022 08:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660812949;
        bh=niZBhpkIdscPcN208ArKi+A6d3GsNSweCzX3nRlNVU0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s/jGf+iXDlaucr52n07TwBPBEYTwYtd6xTpfzVWAV4k/Ywc4lVOoMadj3bWKwWf31
         XQAfOC8+RU6kybvtdRp9dgUwFBmtE5KyMCEmtn8x1BhEYnkJYMysgbcrwxGQdFImNI
         cLbfG4Ty/f+eLs2HrIJY/YH/s9iV0Psj64kHRYcg/AhI5XkPVgHgcEtOIOSI8zJlVj
         NlG6FzSbboyr1X4JaQsYz0cOc9OH7rcW7Rnghx1RUaeefPa/7DmyjOKeAqe0Lkqqn/
         bTP3x9/KYV1DppbmOGBEjLnz4l4rvl0Awmxlr6Kz3XSwtszcmtVISaVPJZDDN5zahW
         N6N6GtfU4rzMQ==
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
Subject: [PATCH resend 1/9] loader: drop argv[] argument in grub_initrd_load()
Date:   Thu, 18 Aug 2022 10:55:31 +0200
Message-Id: <20220818085540.2075028-2-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220818085540.2075028-1-ardb@kernel.org>
References: <20220818085540.2075028-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6961; i=ardb@kernel.org; h=from:subject; bh=wQFzLxMZkWavlzJH8Og0nbf4Zqw+CNHB0gdJJ0VYcRY=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBi/f54vyc/5gAIH8tbljhw9fftrlbKH9aFI02A4l14 WVG0zQOJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYv3+eAAKCRDDTyI5ktmPJN75C/ 9rBG8POkI63bZ1k///q43La/3UJVVoKG7MvhrA1rs3A7ZqDYRPSPR3XwbCD5GnYd85+4hq/So6kjzN 77Mi/MR5tCTabPV8tBSCdXEgkg6MLpKCxcfaAJEFxLHM878BOZFCBxlHEXD+ZaKe4aItOv0g1Bq297 O768a2ypEHSVuiF371N63sNAPQ3RrLnvEYBS+zKD9zXT+VxrSw+BVLb2PGux8IrUIejLINvun7Xqcb Ocih5yKgS+P2X3FtM3vEd0CTbwn3a6PB0gMLikCyUuDcnEuMlHk4B9UBPNfROXnnH2NmTulrJMtjAQ XozufayXHoeG5OWJ5jmIsUDC88v4JWImNS1k5yhiRNWC019f8FnRmVooV3L6Vs7R+N/99ZbJLgPpYs Ug8k18+A2WzLt1BkdGlcqvO/RYAcIlCQM5/zmI3eFp+IDogeT7uHKUeFwpuPrJRr4rGtafpxhL2LeY /h/Xbnp+qBTZyfPjYjewzUMxzDsmtGoWUI5T2X6uhJew8=
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

From: Nikita Ermakov <arei@altlinux.org>

In the case of an error grub_initrd_load() uses argv[] to print the
filename that caused the error. It is also possible to obtain the
filename from the file handles and there is no need to duplicate that
information in argv[], so let's drop it.

Signed-off-by: Nikita Ermakov <arei@altlinux.org>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 grub-core/loader/arm/linux.c              | 2 +-
 grub-core/loader/arm64/linux.c            | 2 +-
 grub-core/loader/i386/linux.c             | 2 +-
 grub-core/loader/i386/pc/linux.c          | 2 +-
 grub-core/loader/i386/xen.c               | 3 +--
 grub-core/loader/ia64/efi/linux.c         | 2 +-
 grub-core/loader/linux.c                  | 4 ++--
 grub-core/loader/mips/linux.c             | 2 +-
 grub-core/loader/powerpc/ieee1275/linux.c | 2 +-
 grub-core/loader/sparc64/ieee1275/linux.c | 2 +-
 include/grub/linux.h                      | 2 +-
 11 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/grub-core/loader/arm/linux.c b/grub-core/loader/arm/linux.c
index 30b366601c39..f00b538ebad0 100644
--- a/grub-core/loader/arm/linux.c
+++ b/grub-core/loader/arm/linux.c
@@ -422,7 +422,7 @@ grub_cmd_initrd (grub_command_t cmd __attribute__ ((unused)),
   grub_dprintf ("loader", "Loading initrd to 0x%08x\n",
 		(grub_addr_t) initrd_start);
 
-  if (grub_initrd_load (&initrd_ctx, argv, (void *) initrd_start))
+  if (grub_initrd_load (&initrd_ctx, (void *) initrd_start))
     goto fail;
 
   initrd_end = initrd_start + size;
diff --git a/grub-core/loader/arm64/linux.c b/grub-core/loader/arm64/linux.c
index ef3e9f9444ca..aed7a200b848 100644
--- a/grub-core/loader/arm64/linux.c
+++ b/grub-core/loader/arm64/linux.c
@@ -266,7 +266,7 @@ grub_cmd_initrd (grub_command_t cmd __attribute__ ((unused)),
       goto fail;
     }
 
-  if (grub_initrd_load (&initrd_ctx, argv, initrd_mem))
+  if (grub_initrd_load (&initrd_ctx, initrd_mem))
     goto fail;
 
   initrd_start = (grub_addr_t) initrd_mem;
diff --git a/grub-core/loader/i386/linux.c b/grub-core/loader/i386/linux.c
index c5984d4b27e9..edd6c2bb1d23 100644
--- a/grub-core/loader/i386/linux.c
+++ b/grub-core/loader/i386/linux.c
@@ -1107,7 +1107,7 @@ grub_cmd_initrd (grub_command_t cmd __attribute__ ((unused)),
     initrd_mem_target = get_physical_target_address (ch);
   }
 
-  if (grub_initrd_load (&initrd_ctx, argv, initrd_mem))
+  if (grub_initrd_load (&initrd_ctx, initrd_mem))
     goto fail;
 
   grub_dprintf ("linux", "Initrd, addr=0x%x, size=0x%x\n",
diff --git a/grub-core/loader/i386/pc/linux.c b/grub-core/loader/i386/pc/linux.c
index 7b89d431051e..4adeee9ae001 100644
--- a/grub-core/loader/i386/pc/linux.c
+++ b/grub-core/loader/i386/pc/linux.c
@@ -462,7 +462,7 @@ grub_cmd_initrd (grub_command_t cmd __attribute__ ((unused)),
     initrd_addr = get_physical_target_address (ch);
   }
 
-  if (grub_initrd_load (&initrd_ctx, argv, initrd_chunk))
+  if (grub_initrd_load (&initrd_ctx, initrd_chunk))
     goto fail;
 
   lh->ramdisk_image = initrd_addr;
diff --git a/grub-core/loader/i386/xen.c b/grub-core/loader/i386/xen.c
index cd24874ca324..3b856e842709 100644
--- a/grub-core/loader/i386/xen.c
+++ b/grub-core/loader/i386/xen.c
@@ -809,8 +809,7 @@ grub_cmd_initrd (grub_command_t cmd __attribute__ ((unused)),
       if (err)
 	goto fail;
 
-      if (grub_initrd_load (&initrd_ctx, argv,
-			    get_virtual_current_address (ch)))
+      if (grub_initrd_load (&initrd_ctx, get_virtual_current_address (ch)))
 	goto fail;
     }
 
diff --git a/grub-core/loader/ia64/efi/linux.c b/grub-core/loader/ia64/efi/linux.c
index 41266109e03c..fb9b961f71a2 100644
--- a/grub-core/loader/ia64/efi/linux.c
+++ b/grub-core/loader/ia64/efi/linux.c
@@ -563,7 +563,7 @@ grub_cmd_initrd (grub_command_t cmd __attribute__ ((unused)),
   grub_dprintf ("linux", "[addr=0x%lx, size=0x%lx]\n",
 		(grub_uint64_t) initrd_mem, initrd_size);
 
-  if (grub_initrd_load (&initrd_ctx, argv, initrd_mem))
+  if (grub_initrd_load (&initrd_ctx, initrd_mem))
     goto fail;
  fail:
   grub_initrd_close (&initrd_ctx);
diff --git a/grub-core/loader/linux.c b/grub-core/loader/linux.c
index ade9b2fef470..830360172c3d 100644
--- a/grub-core/loader/linux.c
+++ b/grub-core/loader/linux.c
@@ -271,7 +271,7 @@ grub_initrd_close (struct grub_linux_initrd_context *initrd_ctx)
 
 grub_err_t
 grub_initrd_load (struct grub_linux_initrd_context *initrd_ctx,
-		  char *argv[], void *target)
+		  void *target)
 {
   grub_uint8_t *ptr = target;
   int i;
@@ -317,7 +317,7 @@ grub_initrd_load (struct grub_linux_initrd_context *initrd_ctx,
 	{
 	  if (!grub_errno)
 	    grub_error (GRUB_ERR_FILE_READ_ERROR, N_("premature end of file %s"),
-			argv[i]);
+			initrd_ctx->components[i].file->name);
 	  grub_initrd_close (initrd_ctx);
 	  return grub_errno;
 	}
diff --git a/grub-core/loader/mips/linux.c b/grub-core/loader/mips/linux.c
index 2f912c61ccda..7264ba2b663b 100644
--- a/grub-core/loader/mips/linux.c
+++ b/grub-core/loader/mips/linux.c
@@ -452,7 +452,7 @@ grub_cmd_initrd (grub_command_t cmd __attribute__ ((unused)),
     initrd_dest = get_physical_target_address (ch) | 0x80000000;
   }
 
-  if (grub_initrd_load (&initrd_ctx, argv, initrd_src))
+  if (grub_initrd_load (&initrd_ctx, initrd_src))
     goto fail;
 
 #ifdef GRUB_MACHINE_MIPS_QEMU_MIPS
diff --git a/grub-core/loader/powerpc/ieee1275/linux.c b/grub-core/loader/powerpc/ieee1275/linux.c
index 6fdd86313083..e6d071508d8d 100644
--- a/grub-core/loader/powerpc/ieee1275/linux.c
+++ b/grub-core/loader/powerpc/ieee1275/linux.c
@@ -349,7 +349,7 @@ grub_cmd_initrd (grub_command_t cmd __attribute__ ((unused)),
 
   grub_dprintf ("loader", "Loading initrd at 0x%x, size 0x%x\n", addr, size);
 
-  if (grub_initrd_load (&initrd_ctx, argv, (void *) addr))
+  if (grub_initrd_load (&initrd_ctx, (void *) addr))
     goto fail;
 
   initrd_addr = addr;
diff --git a/grub-core/loader/sparc64/ieee1275/linux.c b/grub-core/loader/sparc64/ieee1275/linux.c
index bb47ee0cc640..ac2206f3c051 100644
--- a/grub-core/loader/sparc64/ieee1275/linux.c
+++ b/grub-core/loader/sparc64/ieee1275/linux.c
@@ -413,7 +413,7 @@ grub_cmd_initrd (grub_command_t cmd __attribute__ ((unused)),
   grub_dprintf ("loader", "Loading initrd at vaddr 0x%lx, paddr 0x%lx, size 0x%lx\n",
 		addr, paddr, size);
 
-  if (grub_initrd_load (&initrd_ctx, argv, (void *) addr))
+  if (grub_initrd_load (&initrd_ctx, (void *) addr))
     goto fail;
 
   initrd_addr = addr;
diff --git a/include/grub/linux.h b/include/grub/linux.h
index 594a3f3079b0..a96ac20483d3 100644
--- a/include/grub/linux.h
+++ b/include/grub/linux.h
@@ -21,4 +21,4 @@ grub_initrd_close (struct grub_linux_initrd_context *initrd_ctx);
 
 grub_err_t
 grub_initrd_load (struct grub_linux_initrd_context *initrd_ctx,
-		  char *argv[], void *target);
+		  void *target);
-- 
2.35.1

