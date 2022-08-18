Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB359598069
	for <lists+linux-efi@lfdr.de>; Thu, 18 Aug 2022 10:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243588AbiHRI4P (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 18 Aug 2022 04:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239820AbiHRI4O (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 18 Aug 2022 04:56:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF08FB07F0
        for <linux-efi@vger.kernel.org>; Thu, 18 Aug 2022 01:56:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9222EB81DEB
        for <linux-efi@vger.kernel.org>; Thu, 18 Aug 2022 08:56:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01D8DC433D6;
        Thu, 18 Aug 2022 08:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660812971;
        bh=qcwQefREXPmKgrFWHMrnNH4iddUEkHLg9MKUfINhGnE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KK2Y3Li9gbm+9FqhUtcJAlaPGbz5TxGqxWQRRIvAVsAZESubAB261L0UAnMBBb1g2
         V7eTkTK26VXW2ktelR8IAVGARC0pz8JMfRDOBRswuofottahq89R8FNnlfaBRqhhbz
         vUU9fMnyb3u32m0/1f+/rFusfAbZvr+uq4Ab/5arrT6kqXdviq923BCyyU2aU5XxNO
         oXxAiOMIWD+UOx7CqmVQL7gTIn/mPw4lvArrnHnSM9T+87q80cuqwVSvahYPus/Dsk
         Zx+zmqmFXaxMQUMRBZFa+Z+gPs+OlrLkueJiiN/PVliPG/Wk5ed82uDdjEVpXVDvWG
         U7FzLQs2X0kHw==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     grub-devel@nongnu.org
Cc:     linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        grub-devel@gnu.org, Daniel Kiper <daniel.kiper@oracle.com>,
        Nikita Ermakov <arei@altlinux.org>,
        Atish Patra <atishp@atishpatra.org>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        dann frazier <dann.frazier@canonical.com>,
        Julian Andres Klode <julian.klode@canonical.com>,
        Leif Lindholm <leif@nuviainc.com>
Subject: [PATCH resend 9/9] linux: ignore FDT unless we need to modify it
Date:   Thu, 18 Aug 2022 10:55:39 +0200
Message-Id: <20220818085540.2075028-10-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220818085540.2075028-1-ardb@kernel.org>
References: <20220818085540.2075028-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2654; i=ardb@kernel.org; h=from:subject; bh=qcwQefREXPmKgrFWHMrnNH4iddUEkHLg9MKUfINhGnE=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBi/f6KK1CRae61+/Iolc7eh6UzH7SGMFIoyBvop4T/ a2gB3+OJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYv3+igAKCRDDTyI5ktmPJOikDA CHGZvj03/pzJJdxwOHb78R8JOV/Exd1Ce84KNmgdNIUZSbQvD+nVzs9j9sh6niHLLDHTUJ3F7tVLlD F3Il8YItbUiBPhn2nDdCslGCVfJl/clY5b8CWk3cqUP2OIr+jxPT/NhTusaJTuzLNJtx+InKe081N6 4B/023wJ2xyFHW5VwOXwgOLNf8WddkbEHRL1tWAgK/evlZgmdBVbCiPqVqYJ5Wu0bT2dz6wUk7vzdP 36sCay8xbWaZkKlB9NISDqQVlmSo4yfBc1jnNHZ+g36Mst+NZouhH9qb+jwOzyMfcdjXdqLBLh9YRi LpVhIoTv8jpEomx7w/dKavoYnZ2y9+GHAuxshj4HsTJRQkHuHl1YnkJv50Z8JjcFB2MHwgULXNGjEC /R8cWBfLWmQQxE0SH/qZO65j58mjyBSaqZH7Iexb34AZ1tHeIOoRpKZQ5be+LscALPscg5IRCjbqM9 zPjDXG+0i1Zxtbn31W8AdY+pBykUcDMCX9Qv3fGw4tB4Y=
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

Now that we implemented supported for the LoadFile2 protocol for initrd
loading, there is no longer a need to pass the initrd parameters via
the device tree. This means there is no longer a reason to update the
device tree in the first place, and so we can ignore it entirely.

The only remaining reason to deal with the devicetree is if we are
using the 'devicetree' command to load one from disk, so tweak the
logic in grub_fdt_install() to take that into account.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Reviewed-by: Leif Lindholm <leif@nuviainc.com>
---
 grub-core/loader/arm64/linux.c | 22 ++++++++++----------
 grub-core/loader/efi/fdt.c     |  7 +++++--
 2 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/grub-core/loader/arm64/linux.c b/grub-core/loader/arm64/linux.c
index 82c7558b4c4c..68ed1502c68a 100644
--- a/grub-core/loader/arm64/linux.c
+++ b/grub-core/loader/arm64/linux.c
@@ -142,21 +142,21 @@ finalize_params_linux (void)
 
   void *fdt;
 
-  fdt = grub_fdt_load (GRUB_EFI_LINUX_FDT_EXTRA_SPACE);
+  /* Set initrd info */
+  if (initrd_start && initrd_end > initrd_start)
+    {
+      fdt = grub_fdt_load (GRUB_EFI_LINUX_FDT_EXTRA_SPACE);
 
-  if (!fdt)
-    goto failure;
+      if (!fdt)
+       goto failure;
 
-  node = grub_fdt_find_subnode (fdt, 0, "chosen");
-  if (node < 0)
-    node = grub_fdt_add_subnode (fdt, 0, "chosen");
+      node = grub_fdt_find_subnode (fdt, 0, "chosen");
+      if (node < 0)
+       node = grub_fdt_add_subnode (fdt, 0, "chosen");
 
-  if (node < 1)
-    goto failure;
+      if (node < 1)
+       goto failure;
 
-  /* Set initrd info */
-  if (initrd_start && initrd_end > initrd_start)
-    {
       grub_dprintf ("linux", "Initrd @ %p-%p\n",
 		    (void *) initrd_start, (void *) initrd_end);
 
diff --git a/grub-core/loader/efi/fdt.c b/grub-core/loader/efi/fdt.c
index c86f283d756b..771d455c7319 100644
--- a/grub-core/loader/efi/fdt.c
+++ b/grub-core/loader/efi/fdt.c
@@ -89,13 +89,16 @@ grub_fdt_install (void)
   grub_efi_guid_t fdt_guid = GRUB_EFI_DEVICE_TREE_GUID;
   grub_efi_status_t status;
 
+  if (!fdt && !loaded_fdt)
+    return GRUB_ERR_NONE;
+
   b = grub_efi_system_table->boot_services;
-  status = b->install_configuration_table (&fdt_guid, fdt);
+  status = b->install_configuration_table (&fdt_guid, fdt ?: loaded_fdt);
   if (status != GRUB_EFI_SUCCESS)
     return grub_error (GRUB_ERR_IO, "failed to install FDT");
 
   grub_dprintf ("fdt", "Installed/updated FDT configuration table @ %p\n",
-		fdt);
+		fdt ?: loaded_fdt);
   return GRUB_ERR_NONE;
 }
 
-- 
2.35.1

