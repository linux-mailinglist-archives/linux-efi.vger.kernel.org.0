Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D4DE6B3921
	for <lists+linux-efi@lfdr.de>; Fri, 10 Mar 2023 09:48:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231392AbjCJIsW (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 10 Mar 2023 03:48:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbjCJIrl (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 10 Mar 2023 03:47:41 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C290D158BA
        for <linux-efi@vger.kernel.org>; Fri, 10 Mar 2023 00:45:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 1BEEFCE27CF
        for <linux-efi@vger.kernel.org>; Fri, 10 Mar 2023 08:45:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6263AC433D2;
        Fri, 10 Mar 2023 08:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678437943;
        bh=elO3qInaM2gpe7rFA+FIwrgw1qdAciQ7UnQws3lQAVc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UuZynnYLgvFbMNaxoEBmDqaB67w03MwAIsPO/TvN8JWHRXm8Y3jPkXRU5QY6qDvR+
         ZN8/MFqmzVQ+nNs+QZ63FwGoeyb7+BNtfWGSdvxL2i6z84L5Ebf+9yew1l2HZW1RWK
         XBUprQ3gqcJGnFEHIcwD7tjGhmDH2u7Xp+ZhtCafpaAyhGcKq7Q5kz1zDcrjxiyV04
         Lb23iC6hcSNeRVvwoPpSaSsdkh2zAE4Zka9jhlrgzlPcWURfkQC9fBT593hM+VP1Nk
         r9gvu0LSI4AgfzTqu2Y9dl8siLRxdCGq/6l+RmXSafdXv9MkeP7HFnzNBdCMj3d9h4
         enij6ReVinx0w==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>, Michael Brown <mcb30@ipxe.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH 1/2] efi: libstub: Pass loaded image EFI handle to efi_load_initrd()
Date:   Fri, 10 Mar 2023 09:45:28 +0100
Message-Id: <20230310084529.3229983-2-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230310084529.3229983-1-ardb@kernel.org>
References: <20230310084529.3229983-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3244; i=ardb@kernel.org; h=from:subject; bh=elO3qInaM2gpe7rFA+FIwrgw1qdAciQ7UnQws3lQAVc=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIYXrnca++KRfMg/eWbBN/vaOd/3pmLneGqd21PF82rl7T aja78cPOkpZGMQ4GGTFFFkEZv99t/P0RKla51myMHNYmUCGMHBxCsBEas8w/BUukN3BkVW5sK8n ymBnTNQty+63Cicvv5RLfv0mZVtTwwKGf6bH3DfEC5b+evDn+Y7KFh/1wt5Hfl/N5v/xLdZJst+ lxQoA
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

In preparation for allowing loaders to pass the initrd loadfile2
protocol implementation via the loaded image handle instead of a global
singleton device path, pass the loaded image EFI handle down to the code
that loads the initrd.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/efi-stub-helper.c | 3 ++-
 drivers/firmware/efi/libstub/efi-stub.c        | 4 ++--
 drivers/firmware/efi/libstub/efistub.h         | 3 ++-
 drivers/firmware/efi/libstub/x86-stub.c        | 4 ++--
 4 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index 1e0203d74691ffcc..d47aa855398b39a6 100644
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
index 6bd3bb86d9679a1c..8a77aeae9e2215a5 100644
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

