Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2DA5275D1C
	for <lists+linux-efi@lfdr.de>; Wed, 23 Sep 2020 18:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbgIWQPL (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 23 Sep 2020 12:15:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:42036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726727AbgIWQPF (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 23 Sep 2020 12:15:05 -0400
Received: from e123331-lin.nice.arm.com (lfbn-nic-1-188-42.w2-15.abo.wanadoo.fr [2.15.37.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 07EFC221EF;
        Wed, 23 Sep 2020 16:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600877704;
        bh=mSwhGjWwRcUITwEDcMNnwemJl4eKgnir10Nm9DDTW/A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uGFfHb4kVusgZ/YTlY7ZvoeXP4XxFdYHq19r831O6CCVEASKcGBOtkxEAd1HMFzwv
         +9q+X9SSJwOuG+u9PG1MpW87wVx7x8hQf3F90S6t8b8owJg6MMni+ecoDDPhdcCZLX
         /kZPU6+STiAv8Kf0swxTsqbH/gCj/SeV2EK2QX0k=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Matthew Garrett <mjg59@google.com>,
        Peter Jones <pjones@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>
Subject: [PATCH 4/7] efi: gsmi: fix false dependency on CONFIG_EFI_VARS
Date:   Wed, 23 Sep 2020 18:14:01 +0200
Message-Id: <20200923161404.17811-5-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200923161404.17811-1-ardb@kernel.org>
References: <20200923161404.17811-1-ardb@kernel.org>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The gsmi code does not actually rely on CONFIG_EFI_VARS, since it only
uses the efivars abstraction that is included unconditionally when
CONFIG_EFI is defined. CONFIG_EFI_VARS controls the inclusion of the
code that exposes the sysfs entries, and which has been deprecated for
some time.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/google/Kconfig | 2 +-
 drivers/firmware/google/gsmi.c  | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/firmware/google/Kconfig b/drivers/firmware/google/Kconfig
index a3a6ca659ffa..97968aece54f 100644
--- a/drivers/firmware/google/Kconfig
+++ b/drivers/firmware/google/Kconfig
@@ -15,7 +15,7 @@ config GOOGLE_SMI
 	help
 	  Say Y here if you want to enable SMI callbacks for Google
 	  platforms.  This provides an interface for writing to and
-	  clearing the event log.  If EFI_VARS is also enabled this
+	  clearing the event log.  If CONFIG_EFI is also enabled this
 	  driver provides an interface for reading and writing NVRAM
 	  variables.
 
diff --git a/drivers/firmware/google/gsmi.c b/drivers/firmware/google/gsmi.c
index 5b2011ebbe26..7d9367b22010 100644
--- a/drivers/firmware/google/gsmi.c
+++ b/drivers/firmware/google/gsmi.c
@@ -302,7 +302,7 @@ static int gsmi_exec(u8 func, u8 sub)
 	return rc;
 }
 
-#ifdef CONFIG_EFI_VARS
+#ifdef CONFIG_EFI
 
 static struct efivars efivars;
 
@@ -483,7 +483,7 @@ static const struct efivar_operations efivar_ops = {
 	.get_next_variable = gsmi_get_next_variable,
 };
 
-#endif /* CONFIG_EFI_VARS */
+#endif /* CONFIG_EFI */
 
 static ssize_t eventlog_write(struct file *filp, struct kobject *kobj,
 			       struct bin_attribute *bin_attr,
@@ -1007,7 +1007,7 @@ static __init int gsmi_init(void)
 		goto out_remove_bin_file;
 	}
 
-#ifdef CONFIG_EFI_VARS
+#ifdef CONFIG_EFI
 	ret = efivars_register(&efivars, &efivar_ops, gsmi_kobj);
 	if (ret) {
 		printk(KERN_INFO "gsmi: Failed to register efivars\n");
@@ -1047,7 +1047,7 @@ static void __exit gsmi_exit(void)
 	unregister_die_notifier(&gsmi_die_notifier);
 	atomic_notifier_chain_unregister(&panic_notifier_list,
 					 &gsmi_panic_notifier);
-#ifdef CONFIG_EFI_VARS
+#ifdef CONFIG_EFI
 	efivars_unregister(&efivars);
 #endif
 
-- 
2.17.1

