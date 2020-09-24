Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE34A276BDD
	for <lists+linux-efi@lfdr.de>; Thu, 24 Sep 2020 10:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727305AbgIXI2l (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 24 Sep 2020 04:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727243AbgIXI2l (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 24 Sep 2020 04:28:41 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 304FDC0613CE;
        Thu, 24 Sep 2020 01:28:41 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id 7so1442468pgm.11;
        Thu, 24 Sep 2020 01:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=pyynvcyJWw45RLcJFif3rkDMjfz40Acej1BG50rYExA=;
        b=fN0FVsVK6/aLfutTaXeWwikNpMEBP+1eq1lmhEibKxDp+B2s5B0nby8i7PUKsRUOVW
         kvfXzqox3S31Gf04mzKtpC6SODD+Qx9MVT5cRLXCURcO6+YBEiP3cunBc45STaMW/U03
         vGLmzVabDF0AoXcBbWHF9kcg19aSxTi/Y2q/9UbAAmshopEDTch/41+mCagp3EmqhB/1
         nwQEyCCu8IhX8fU37C8Sw6vCUvW7HHoNTSu//SGM6+P4AKBWR6fOuLMrIRJPC67agH1H
         8cqGlAiZW7DtiORk3Si7drRtbZlqersnaAni07UAQKt1keDcjUg1Z3OL1PlvLJUycumz
         rAIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=pyynvcyJWw45RLcJFif3rkDMjfz40Acej1BG50rYExA=;
        b=JI0ersJhVXkmuIgNGjCdqs4PnbBbSxnVLTHk8cKdHQ5QNYS/I766FKPTqK1VsxGug+
         xd4TVCBub2+hOA8IU6nhH+ocDwKR5k9F0pMGZ7Viw8x9Ov23l+frszuMg1RJ47qQwFMi
         Sr6XqQCj0aQ7D/I/JTh10U8FPtxlj1wI6JeRm3VJ8fe0lNgS1Ubr7L+pcwHEpRH7ZgbC
         uRS9p7dkaWgwr6IybKfyCVm2PKaOAKgt7fkOU06tVT4KgYo3fUCZD63sV5hLmvDqagHx
         mgSSngKhmTvw7ZUUyTmmhX2RzBbGAmGJSz0tb1sNYrvetKK4ZgvEhsNGxXWkrbRDvfBJ
         5dTw==
X-Gm-Message-State: AOAM533jVQ3+RaBKLCb9Ov3szMw5rOI3zkZIy1Fj/NccjGx5wdpC9Hq2
        VY6JgrhWuVNgTT2vqO7Vo7Y=
X-Google-Smtp-Source: ABdhPJx4++bBA0jGaoHN8SfJhMUfWfNCku4D/ZxUWGP29UmLRoeE4/H7/HUsd42eMrRuBb2RzcsSBw==
X-Received: by 2002:aa7:9635:0:b029:142:2501:3980 with SMTP id r21-20020aa796350000b029014225013980mr3482317pfg.69.1600936120751;
        Thu, 24 Sep 2020 01:28:40 -0700 (PDT)
Received: from linux-691t.suse.de ([124.11.22.254])
        by smtp.gmail.com with ESMTPSA id 11sm2079260pgp.21.2020.09.24.01.28.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Sep 2020 01:28:39 -0700 (PDT)
From:   "Lee, Chun-Yi" <joeyli.kernel@gmail.com>
X-Google-Original-From: "Lee, Chun-Yi" <jlee@suse.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Lee, Chun-Yi" <jlee@suse.com>, Ard Biesheuvel <ardb@kernel.org>,
        Matthias Brugger <mbrugger@suse.com>,
        Fabian Vogt <fvogt@suse.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arthur Heymans <arthur@aheymans.xyz>,
        Patrick Rudolph <patrick.rudolph@9elements.com>
Subject: [PATCH] efi/efivars: Create efivars mount point in the registration of efivars abstraction
Date:   Thu, 24 Sep 2020 16:28:33 +0800
Message-Id: <20200924082833.12722-1-jlee@suse.com>
X-Mailer: git-send-email 2.16.4
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

This patch moved the logic of creating efivars mount point to the
registration of efivars abstraction. It's useful for userland to
determine the availability of efivars filesystem by checking the
existence of mount point.

The 'efivars' platform device be created on generic EFI runtime services
platform, so it can be used to determine the availability of efivarfs.
But this approach is not available for google gsmi efivars abstraction.

This patch be tested on Here on qemu-OVMF and qemu-uboot.

Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Matthias Brugger <mbrugger@suse.com>
Cc: Fabian Vogt <fvogt@suse.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arthur Heymans <arthur@aheymans.xyz>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>
Signed-off-by: "Lee, Chun-Yi" <jlee@suse.com>
---
 drivers/firmware/efi/efi.c  |  7 -------
 drivers/firmware/efi/vars.c | 17 +++++++++++++++++
 2 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 3aa07c3b5136..23c11a2a3f4d 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -405,13 +405,6 @@ static int __init efisubsys_init(void)
 	if (error)
 		goto err_remove_group;
 
-	/* and the standard mountpoint for efivarfs */
-	error = sysfs_create_mount_point(efi_kobj, "efivars");
-	if (error) {
-		pr_err("efivars: Subsystem registration failed.\n");
-		goto err_remove_group;
-	}
-
 	if (efi_enabled(EFI_DBG) && efi_enabled(EFI_PRESERVE_BS_REGIONS))
 		efi_debugfs_init();
 
diff --git a/drivers/firmware/efi/vars.c b/drivers/firmware/efi/vars.c
index 973eef234b36..6fa7f288d635 100644
--- a/drivers/firmware/efi/vars.c
+++ b/drivers/firmware/efi/vars.c
@@ -1179,6 +1179,8 @@ int efivars_register(struct efivars *efivars,
 		     const struct efivar_operations *ops,
 		     struct kobject *kobject)
 {
+	int error;
+
 	if (down_interruptible(&efivars_lock))
 		return -EINTR;
 
@@ -1191,6 +1193,19 @@ int efivars_register(struct efivars *efivars,
 
 	up(&efivars_lock);
 
+	/* and the standard mountpoint for efivarfs */
+	if (efi_kobj) {
+		error = sysfs_create_mount_point(efi_kobj, "efivars");
+		if (error) {
+			if (down_interruptible(&efivars_lock))
+				return -EINTR;
+			__efivars = NULL;
+			up(&efivars_lock);
+			pr_err("efivars: Subsystem registration failed.\n");
+			return error;
+		}
+	}
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(efivars_register);
@@ -1222,6 +1237,8 @@ int efivars_unregister(struct efivars *efivars)
 
 	pr_info("Unregistered efivars operations\n");
 	__efivars = NULL;
+	if (efi_kobj)
+		sysfs_remove_mount_point(efi_kobj, "efivars");
 
 	rv = 0;
 out:
-- 
2.16.4

