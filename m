Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92165597EE2
	for <lists+linux-efi@lfdr.de>; Thu, 18 Aug 2022 09:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242093AbiHRHFC (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 18 Aug 2022 03:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243755AbiHRHFB (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 18 Aug 2022 03:05:01 -0400
X-Greylist: delayed 414 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 18 Aug 2022 00:04:58 PDT
Received: from mail.inso.tuwien.ac.at (omega.inso.tuwien.ac.at [128.130.59.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B06C79EC6
        for <linux-efi@vger.kernel.org>; Thu, 18 Aug 2022 00:04:58 -0700 (PDT)
Received: from thinkpad-p14s.risedev.at (188-23-212-6.adsl.highway.telekom.at [188.23.212.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.inso.tuwien.ac.at (Postfix) with ESMTPSA id BE291C0EC9;
        Thu, 18 Aug 2022 08:58:01 +0200 (CEST)
From:   Daniel Marth <daniel.marth@inso.tuwien.ac.at>
Cc:     ardb@kernel.org, linux-efi@vger.kernel.org,
        clemens.hlauschek@inso.tuwien.ac.at,
        Daniel Marth <daniel.marth@inso.tuwien.ac.at>
Subject: [PATCH] efi/libstub: Disable RNG structure randomization
Date:   Thu, 18 Aug 2022 08:56:35 +0200
Message-Id: <20220818065635.243057-1-daniel.marth@inso.tuwien.ac.at>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Randstruct by default randomizes structures that consist entirely of
function pointers, even if they are not explicitly labeled for
randomization. efi_rng_protocol contains an anonymous structure that is
affected by this implicit selection process. Randomization of this
structure causes a data layout inconsistency between the kernel and the
EFI. In this scenario the Arm64 boot process fails with the following
output:
    EFI stub: Booting Linux Kernel...
    EFI stub: ERROR: efi_get_random_bytes() failed (0x8000000000000002)
    EFI stub: Using DTB from configuration table
    EFI stub: Loaded initrd from LINUX_EFI_INITRD_MEDIA_GUID device path
    Synchronous Exception at 0x0000000081310C90
    Synchronous Exception at 0x0000000081310C90

efi_get_random_bytes() fails in handle_kernel_image (arm64-stub.c)
because it uses an incorrect structure layout for efi_call_proto. Add
the __no_randomize_layout annotation to the anonymous structure within
efi_rng_protocol to prevent its randomization and resolve this issue.

This patch was tested for the Arm64 architecture using QEMU. In
addition to the current next branch of this subsystem, also minor
versions 4.16 to 5.1, 5.5 and 5.6 were tested successfully with a
(backported) version of this patch.

Signed-off-by: Daniel Marth <daniel.marth@inso.tuwien.ac.at>
---
 drivers/firmware/efi/libstub/random.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/libstub/random.c b/drivers/firmware/efi/libstub/random.c
index 24aa37535372..54fa980cf1af 100644
--- a/drivers/firmware/efi/libstub/random.c
+++ b/drivers/firmware/efi/libstub/random.c
@@ -18,7 +18,7 @@ union efi_rng_protocol {
 		efi_status_t (__efiapi *get_rng)(efi_rng_protocol_t *,
 						 efi_guid_t *, unsigned long,
 						 u8 *out);
-	};
+	} __no_randomize_layout;
 	struct {
 		u32 get_info;
 		u32 get_rng;
-- 
2.37.2

