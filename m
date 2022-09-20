Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D46625BEA59
	for <lists+linux-efi@lfdr.de>; Tue, 20 Sep 2022 17:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbiITPh6 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 20 Sep 2022 11:37:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiITPh5 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 20 Sep 2022 11:37:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 791076172A
        for <linux-efi@vger.kernel.org>; Tue, 20 Sep 2022 08:37:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 30125B82A9A
        for <linux-efi@vger.kernel.org>; Tue, 20 Sep 2022 15:37:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5A68C433D7;
        Tue, 20 Sep 2022 15:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663688273;
        bh=sEQUnLa6WsmKJz2gRQEnFY02HQKwwDS3OPdQPV8+AXk=;
        h=From:To:Cc:Subject:Date:From;
        b=FXqJsj8Zive9P/Kxt4/fZfoRbDjQLP9HGjCfEU0vrZD/kkTuLUTB53B3YG/7dtYKi
         taFwmn8pmR9SCMizypQK3CsTHy25d5TaPILmeL+inhkYp8zZ4wSjQ26je4MbZ6bV7E
         ZUYSQqCoDOkX4+x9FbSis1Y+VgcIBe+Oy9rWVYsqMCXUhLYCzfIrS508RLAaosIM3n
         Pwf0WPhC2yqnvNrtA3UzNuuK04RGr0xbnkDV/yqPknLItM/Bg3PCib9wzPLpxbfj+0
         2d1aCGA0MazkOKEj80PK0z1320wZuY0iYW1fMAgHgVfs5aom/s8Ik3u0d7rU7wsoYq
         JrLTFahmwjH6w==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     pjones@redhat.com, ilias.apalodimas@linaro.org,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH] efi: libstub: check Shim mode using MokSBStateRT
Date:   Tue, 20 Sep 2022 17:37:43 +0200
Message-Id: <20220920153743.3598053-1-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3377; i=ardb@kernel.org; h=from:subject; bh=sEQUnLa6WsmKJz2gRQEnFY02HQKwwDS3OPdQPV8+AXk=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjKd5GlorvrSqK1rcw10RoCxuRyGv+e6AK2bXl6Po3 duTEYY2JAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYyneRgAKCRDDTyI5ktmPJABLDA CzJePpnpN3UF9T4dX1Dx6MaxtTOxww+/27DwkEB5xRkvvLepRIikdLHQNM/1ZjtDvOI7DKk2VOafLj sj5dH76k0hJcBUgGVyKzy4mu0rtqI/GfpL8+tk86nL5DaQQxLn9zGmexOpPx18rLJh+K+7owdxwiWf PsIrDRDbugzjQLx9aO91WdnxaoJAU8iWHVniJxKdKp4vg+ToeX8nhrUmSRAYtr3gixKBwJ90BHVFf2 gssJoZFovsWRrzkRnZbA01CljB2K80JcYQ25bM0YuCQ6Jo8hxZN7hQb/K90QBPK36aYHgsMJ1sL/H2 HbqHficguGkkfwOqXsfkE7lGxOd15TGY07xfbw/ca+/ymBewFLWSKZJQFr9Hn+8aTUqbVL3tLUKwUG u0CuX2NbGAJDtaIJZ7e/Qrk99B9metJ3S4SVRn75qIvjshPPUPK0WB0ARTKiG+WHgJhQ4D649hZgWG +WfueO87pttv8sCx9f2dlGX+TxBszF3jOJcvedNJL/jcs=
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

We currently check the MokSBState variable to decide whether we should
treat UEFI secure boot as being disabled, even if the firmware thinks
otherwise. This is used by shim to indicate that it is not checking
signatures on boot images. In the kernel, we use this to relax lockdown
policies.

However, in cases where shim is not even being used, we don't want this
variable to interfere with lockdown, given that the variable is
non-volatile variable and therefore persists across a reboot. This means
setting it once will persistently disable lockdown checks on a given
system.

So switch to the mirrored version of this variable, called MokSBStateRT,
which is supposed to be volatile, and this is something we can check.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/xen/efi.c                        | 5 +++--
 drivers/firmware/efi/libstub/secureboot.c | 8 ++++----
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/x86/xen/efi.c b/arch/x86/xen/efi.c
index 7d7ffb9c826a..8bd65f2900b9 100644
--- a/arch/x86/xen/efi.c
+++ b/arch/x86/xen/efi.c
@@ -100,6 +100,7 @@ static enum efi_secureboot_mode xen_efi_get_secureboot(void)
 	enum efi_secureboot_mode mode;
 	efi_status_t status;
 	u8 moksbstate;
+	u32 attr;
 	unsigned long size;
 
 	mode = efi_get_secureboot_mode(efi.get_variable);
@@ -113,13 +114,13 @@ static enum efi_secureboot_mode xen_efi_get_secureboot(void)
 	/* See if a user has put the shim into insecure mode. */
 	size = sizeof(moksbstate);
 	status = efi.get_variable(L"MokSBStateRT", &shim_guid,
-				  NULL, &size, &moksbstate);
+				  &attr, &size, &moksbstate);
 
 	/* If it fails, we don't care why. Default to secure. */
 	if (status != EFI_SUCCESS)
 		goto secure_boot_enabled;
 
-	if (moksbstate == 1)
+	if (!(attr & EFI_VARIABLE_NON_VOLATILE) && moksbstate == 1)
 		return efi_secureboot_mode_disabled;
 
  secure_boot_enabled:
diff --git a/drivers/firmware/efi/libstub/secureboot.c b/drivers/firmware/efi/libstub/secureboot.c
index 8a18930f3eb6..516f4f0069bd 100644
--- a/drivers/firmware/efi/libstub/secureboot.c
+++ b/drivers/firmware/efi/libstub/secureboot.c
@@ -14,7 +14,7 @@
 
 /* SHIM variables */
 static const efi_guid_t shim_guid = EFI_SHIM_LOCK_GUID;
-static const efi_char16_t shim_MokSBState_name[] = L"MokSBState";
+static const efi_char16_t shim_MokSBState_name[] = L"MokSBStateRT";
 
 static efi_status_t get_var(efi_char16_t *name, efi_guid_t *vendor, u32 *attr,
 			    unsigned long *data_size, void *data)
@@ -43,8 +43,8 @@ enum efi_secureboot_mode efi_get_secureboot(void)
 
 	/*
 	 * See if a user has put the shim into insecure mode. If so, and if the
-	 * variable doesn't have the runtime attribute set, we might as well
-	 * honor that.
+	 * variable doesn't have the non-volatile attribute set, we might as
+	 * well honor that.
 	 */
 	size = sizeof(moksbstate);
 	status = get_efi_var(shim_MokSBState_name, &shim_guid,
@@ -53,7 +53,7 @@ enum efi_secureboot_mode efi_get_secureboot(void)
 	/* If it fails, we don't care why. Default to secure */
 	if (status != EFI_SUCCESS)
 		goto secure_boot_enabled;
-	if (!(attr & EFI_VARIABLE_RUNTIME_ACCESS) && moksbstate == 1)
+	if (!(attr & EFI_VARIABLE_NON_VOLATILE) && moksbstate == 1)
 		return efi_secureboot_mode_disabled;
 
 secure_boot_enabled:
-- 
2.35.1

