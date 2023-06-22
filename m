Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D526739AD8
	for <lists+linux-efi@lfdr.de>; Thu, 22 Jun 2023 10:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbjFVIx6 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 22 Jun 2023 04:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231321AbjFVIxF (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 22 Jun 2023 04:53:05 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0EDA210A
        for <linux-efi@vger.kernel.org>; Thu, 22 Jun 2023 01:53:03 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1b516978829so53897675ad.1
        for <linux-efi@vger.kernel.org>; Thu, 22 Jun 2023 01:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687423983; x=1690015983;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=liuthB6FVlJk3VZZwK7QDBE7dTzWXLlSNT3A/53JsYo=;
        b=hdLTNgmfUDlss+P4w085KQ7k0O7v872Qg7Cn0d6e6Ki1cMORUSj2TVgAFl7zVj4aQS
         GDdIrAfDtraZX9vWlp+SMagNbJ7psVGsdp4kHBIw8Ie1cMdU6Obts67bKslvcN2dbHI7
         VjQz6r8I+CI3413S5nS3oq/aWhQb2eBaihaKJXRs1Q//4wSq8yfBc2MvHVsUhHm/yb2A
         iWveiOmB6hXJR7xdPkBVDsDqnDz42fuLzs8o5OsTCnGUwMlACHIfwK1K0GUQIL7FOHiS
         oXxzt+p2/WpMcB4jSfaGpHxVklaLBGw2QSnJQBGHYtdWT8M0izbiqzPyrNykQqBeoVKa
         Cy6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687423983; x=1690015983;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=liuthB6FVlJk3VZZwK7QDBE7dTzWXLlSNT3A/53JsYo=;
        b=PLY0N0vXATvuTLqQcnn3jV4S9QeOHUiAIco5vcwGXQWsV0H5KvdJuDDGtZAbdQR7i5
         BSLhe3OW9HPZ2xq4XydInauz5xReUHUPphpM79K62gJhm3Z/2rCHO23MuIsnyWcyv7YQ
         Ycuy1G0/IqkpREp30EdXJUS139G6ayEXBcqRVCvz3hA8TW1Ge7lFD4IXAbYpDAX+iMH/
         jOP/0/2wKzjay6il0M7bnFgTqa/JKy9soFMIeMdXyIebW9MKHozy9fyXFukrhC8w0Obg
         heOOpGqKAgqX0YsSZ7c3hcw7qfA9D8Q6w/P7yCB3YEUEWLyrt1+38kwcl0VzPt6BAw8E
         KGeQ==
X-Gm-Message-State: AC+VfDztySU5UDSMJTA4I0ENZXiL/xA5elqILBfVm7YmiESCeWpitVm0
        ATEGbLYM0isStRD3rj/qZXMphw==
X-Google-Smtp-Source: ACHHUZ4tUbop3jil87fbhuyep6GDmdUxsTLvachCXXgEIYu3z6jYZBBrFotbtYuzT3Bhw4WH/4kRGQ==
X-Received: by 2002:a17:902:e843:b0:1ac:7405:d3ba with SMTP id t3-20020a170902e84300b001ac7405d3bamr22554283plg.40.1687423983333;
        Thu, 22 Jun 2023 01:53:03 -0700 (PDT)
Received: from localhost.localdomain (fp9875a45d.knge128.ap.nuro.jp. [152.117.164.93])
        by smtp.gmail.com with ESMTPSA id z6-20020a170903018600b001b02bd00c61sm4820154plg.237.2023.06.22.01.53.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 01:53:02 -0700 (PDT)
From:   Masahisa Kojima <masahisa.kojima@linaro.org>
To:     Ard Biesheuvel <ardb@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
Cc:     Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Masahisa Kojima <masahisa.kojima@linaro.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Jeremy Kerr <jk@ozlabs.org>, linux-efi@vger.kernel.org
Subject: [PATCH v6 4/4] efivarfs: automatically update super block flag
Date:   Thu, 22 Jun 2023 17:51:11 +0900
Message-Id: <20230622085112.1521-5-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230622085112.1521-1-masahisa.kojima@linaro.org>
References: <20230622085112.1521-1-masahisa.kojima@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

efivar operation is updated when the tee_stmm_efi module is probed.
tee_stmm_efi module supports SetVariable runtime service,
but user needs to manually remount the efivarfs as RW to enable
the write access if the previous efivar operation does not support
SerVariable and efivarfs is mounted as read-only.

This commit notifies the update of efivar operation to
efivarfs subsystem, then drops SB_RDONLY flag if the efivar
operation supports SetVariable.

Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
---
 drivers/firmware/efi/efi.c  |  6 ++++++
 drivers/firmware/efi/vars.c |  8 ++++++++
 fs/efivarfs/super.c         | 33 +++++++++++++++++++++++++++++++++
 include/linux/efi.h         |  8 ++++++++
 4 files changed, 55 insertions(+)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index d108cf03e19d..00494fcf16ba 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -32,6 +32,7 @@
 #include <linux/ucs2_string.h>
 #include <linux/memblock.h>
 #include <linux/security.h>
+#include <linux/notifier.h>
 
 #include <asm/early_ioremap.h>
 
@@ -184,6 +185,9 @@ static const struct attribute_group efi_subsys_attr_group = {
 	.is_visible = efi_attr_is_visible,
 };
 
+struct blocking_notifier_head efivar_ops_nh;
+EXPORT_SYMBOL_GPL(efivar_ops_nh);
+
 static struct efivars generic_efivars;
 static struct efivar_operations generic_ops;
 
@@ -442,6 +446,8 @@ static int __init efisubsys_init(void)
 		platform_device_register_simple("efivars", 0, NULL, 0);
 	}
 
+	BLOCKING_INIT_NOTIFIER_HEAD(&efivar_ops_nh);
+
 	error = sysfs_create_group(efi_kobj, &efi_subsys_attr_group);
 	if (error) {
 		pr_err("efi: Sysfs attribute export failed with error %d.\n",
diff --git a/drivers/firmware/efi/vars.c b/drivers/firmware/efi/vars.c
index e9dc7116daf1..f654e6f6af87 100644
--- a/drivers/firmware/efi/vars.c
+++ b/drivers/firmware/efi/vars.c
@@ -63,6 +63,7 @@ int efivars_register(struct efivars *efivars,
 		     const struct efivar_operations *ops)
 {
 	int rv;
+	int event;
 
 	if (down_interruptible(&efivars_lock))
 		return -EINTR;
@@ -77,6 +78,13 @@ int efivars_register(struct efivars *efivars,
 
 	__efivars = efivars;
 
+	if (efivar_supports_writes())
+		event = EFIVAR_OPS_RDWR;
+	else
+		event = EFIVAR_OPS_RDONLY;
+
+	blocking_notifier_call_chain(&efivar_ops_nh, event, NULL);
+
 	pr_info("Registered efivars operations\n");
 	rv = 0;
 out:
diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
index e028fafa04f3..0f6e4d223aea 100644
--- a/fs/efivarfs/super.c
+++ b/fs/efivarfs/super.c
@@ -14,11 +14,36 @@
 #include <linux/slab.h>
 #include <linux/magic.h>
 #include <linux/statfs.h>
+#include <linux/notifier.h>
 
 #include "internal.h"
 
 LIST_HEAD(efivarfs_list);
 
+struct efivarfs_info {
+	struct super_block *sb;
+	struct notifier_block nb;
+};
+
+static struct efivarfs_info info;
+
+static int efivarfs_ops_notifier(struct notifier_block *nb, unsigned long event,
+				 void *data)
+{
+	switch (event) {
+	case EFIVAR_OPS_RDONLY:
+		info.sb->s_flags |= SB_RDONLY;
+		break;
+	case EFIVAR_OPS_RDWR:
+		info.sb->s_flags &= ~SB_RDONLY;
+		break;
+	default:
+		return NOTIFY_DONE;
+	}
+
+	return NOTIFY_OK;
+}
+
 static void efivarfs_evict_inode(struct inode *inode)
 {
 	clear_inode(inode);
@@ -255,6 +280,12 @@ static int efivarfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	if (!root)
 		return -ENOMEM;
 
+	info.sb = sb;
+	info.nb.notifier_call = efivarfs_ops_notifier;
+	err = blocking_notifier_chain_register(&efivar_ops_nh, &info.nb);
+	if (err)
+		return err;
+
 	INIT_LIST_HEAD(&efivarfs_list);
 
 	err = efivar_init(efivarfs_callback, (void *)sb, true, &efivarfs_list);
@@ -281,6 +312,8 @@ static int efivarfs_init_fs_context(struct fs_context *fc)
 
 static void efivarfs_kill_sb(struct super_block *sb)
 {
+	blocking_notifier_chain_unregister(&efivar_ops_nh, &info.nb);
+	info.sb = NULL;
 	kill_litter_super(sb);
 
 	if (!efivar_is_available())
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 657f7e203374..2533e4f2547f 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1350,6 +1350,14 @@ bool efi_config_table_is_usable(const efi_guid_t *guid, unsigned long table)
 	return xen_efi_config_table_is_usable(guid, table);
 }
 
+/*
+ * efivar ops event type
+ */
+#define EFIVAR_OPS_RDONLY 0
+#define EFIVAR_OPS_RDWR 1
+
+extern struct blocking_notifier_head efivar_ops_nh;
+
 void efivars_generic_ops_register(void);
 void efivars_generic_ops_unregister(void);
 
-- 
2.30.2

