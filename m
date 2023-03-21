Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17B4C6C36C9
	for <lists+linux-efi@lfdr.de>; Tue, 21 Mar 2023 17:18:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbjCUQS2 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 21 Mar 2023 12:18:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjCUQS1 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 21 Mar 2023 12:18:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6D732127
        for <linux-efi@vger.kernel.org>; Tue, 21 Mar 2023 09:18:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8D4EE61D1D
        for <linux-efi@vger.kernel.org>; Tue, 21 Mar 2023 16:18:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0145FC4339C;
        Tue, 21 Mar 2023 16:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679415490;
        bh=kcQcpLl/g+mSgfiafsN4yuibM6kuFy26F9+w/ioXlX4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dnKslAjblcqIzf/QLudfNM4rRrbsjwogir+qs0qdbD88WiMEJT+cAUP4L4NKk2hCC
         4G1FdUGD/YIetirJEToQf15SVnM7m8zbiQOxTFnzlziCXwf5+lLa2segkDNARfgeQ7
         N8+Bcrz4Hc3WJAHr9w0xYrk74dfbAQCGDl8DM6hMgOi/8BJIB8lE9Z98Mihn8fXFLb
         5wHvLICaICJjfBePi4IIYda+hWZP2tJVPsODho6l1lHqqXHbfpwPFMT5B3Ofr1cjld
         PAN57wj475drYkgm8uK4HXVyhzXdtSI+Na98rC3vu9MNFPtS53Fvfzc4I1VzHBUPQl
         OPQXsCSJa3Gbw==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>, Michael Brown <mcb30@ipxe.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH v2 2/3] efi/libstub: Pass loaded image EFI handle to efi_load_initrd()
Date:   Tue, 21 Mar 2023 17:18:02 +0100
Message-Id: <20230321161803.3289140-3-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230321161803.3289140-1-ardb@kernel.org>
References: <20230321161803.3289140-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3364; i=ardb@kernel.org; h=from:subject; bh=kcQcpLl/g+mSgfiafsN4yuibM6kuFy26F9+w/ioXlX4=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIUXyxk4RuVq5+7Hn9rwIiG0/UpmSuur+6mvOqpasV1tqz eSFdll3lLIwiHEwyIopsgjM/vtu5+mJUrXOs2Rh5rAygQxh4OIUgInELWJkeFBp7rOqUfMGX8oB ySmJRcxZEdIhmez+X6VKD6/ca/65iOGfpmDP1xXvFFbHG5z798XVwJrLbUd3jPCSrhtH+6LkK8v 5AA==
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

In preparation for allowing loaders to pass the initrd loadfile2
protocol implementation via the loaded image handle instead of a global
singleton device path, pass the loaded image EFI handle down to the code
that loads the initrd.

Tested-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/efi-stub-helper.c | 3 ++-
 drivers/firmware/efi/libstub/efi-stub.c        | 4 ++--
 drivers/firmware/efi/libstub/efistub.h         | 3 ++-
 drivers/firmware/efi/libstub/x86-stub.c        | 4 ++--
 4 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index ff60e3a78337ce5c..d1026c6a544058b4 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -554,7 +554,8 @@ efi_status_t efi_load_initrd_cmdline(efi_loaded_image_t *image,
  *
  * Return:	status code
  */
-efi_status_t efi_load_initrd(efi_loaded_image_t *image,
+efi_status_t efi_load_initrd(efi_handle_t handle,
+			     efi_loaded_image_t *image,
 			     unsigned long soft_limit,
 			     unsigned long hard_limit,
 			     const struct linux_efi_initrd **out)
diff --git a/drivers/firmware/efi/libstub/efi-stub.c b/drivers/firmware/efi/libstub/efi-stub.c
index 2955c1ac6a36ee00..a5eb773a574143cf 100644
--- a/drivers/firmware/efi/libstub/efi-stub.c
+++ b/drivers/firmware/efi/libstub/efi-stub.c
@@ -177,8 +177,8 @@ efi_status_t efi_stub_common(efi_handle_t handle,
 	/* Ask the firmware to clear memory on unclean shutdown */
 	efi_enable_reset_attack_mitigation();
 
-	efi_load_initrd(image, ULONG_MAX, efi_get_max_initrd_addr(image_addr),
-			NULL);
+	efi_load_initrd(handle, image, ULONG_MAX,
+			efi_get_max_initrd_addr(image_addr), NULL);
 
 	efi_random_get_seed();
 
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index 96a04ee05cdbb8bf..d772f2e33af7c270 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -1019,7 +1019,8 @@ static inline efi_status_t efi_load_dtb(efi_loaded_image_t *image,
 				    ULONG_MAX, ULONG_MAX, load_addr, load_size);
 }
 
-efi_status_t efi_load_initrd(efi_loaded_image_t *image,
+efi_status_t efi_load_initrd(efi_handle_t handle,
+			     efi_loaded_image_t *image,
 			     unsigned long soft_limit,
 			     unsigned long hard_limit,
 			     const struct linux_efi_initrd **out);
diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index a0bfd31358ba97b1..e79f6977b41c15c2 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -867,8 +867,8 @@ asmlinkage unsigned long efi_main(efi_handle_t handle,
 	 * arguments will be processed only if image is not NULL, which will be
 	 * the case only if we were loaded via the PE entry point.
 	 */
-	status = efi_load_initrd(image, hdr->initrd_addr_max, ULONG_MAX,
-				 &initrd);
+	status = efi_load_initrd(handle, image, hdr->initrd_addr_max,
+				 ULONG_MAX, &initrd);
 	if (status != EFI_SUCCESS)
 		goto fail;
 	if (initrd && initrd->size > 0) {
-- 
2.39.2

