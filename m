Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 208067C7EDC
	for <lists+linux-efi@lfdr.de>; Fri, 13 Oct 2023 09:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbjJMHr4 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 13 Oct 2023 03:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbjJMHrx (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 13 Oct 2023 03:47:53 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06045CC
        for <linux-efi@vger.kernel.org>; Fri, 13 Oct 2023 00:47:40 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1c9de3f66e5so12931585ad.3
        for <linux-efi@vger.kernel.org>; Fri, 13 Oct 2023 00:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697183259; x=1697788059; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jIMHOnYKgrKZVI5d8A5nr31GCdEXvfO3UnWIc+HhE5Q=;
        b=JbB7a2Z8oAg0fjKqqlkbE8P6uOJcJJA3026EpcN/+p76GCPijWGLnz/QxZs0HiUB06
         bp7Cb6xR8xXl3pv8TzF6j93uRrA64qhUd6SCqGOBiNYZXqATK3Elo1vR3frtZWlBo4mx
         BP3r6AA57u8Hh61W/lUcfvOGdoqeUTfgm09s62aLxaNUw0Z5y6AqJnA5TRELTfYLwPhH
         lDPMLQW7QuCXu+S9vbTt0GRBGyWDdy1f/pNy7xcRxrIchzshBQWvVZD4Hc+3o/aagDqT
         UcNhyb3u/cldx5W/P8d8hcRjOZpXyfp2UW6qoCVD2OlqCtVkXwYGKuQCtrmE4CgsNamw
         ovow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697183259; x=1697788059;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jIMHOnYKgrKZVI5d8A5nr31GCdEXvfO3UnWIc+HhE5Q=;
        b=X747qJz4ngVvNZdwwwPPT5rr+KR0ORL2+hPUK5aCQA7xzlXRmhxcfOoTC24PcdKo+J
         suPjlhHgSQfGf/zNVFJJC+tbbqVPCriWcdj7noH7GzBzcVZd+P8VnR+ZlSiuh7q+uKWH
         BGzqgZ6suIRa/5KLQjjxxvMvDctev/eMhY0G2ak3mhVn+1yVXO0UTx3C0ORVX9JXq9VP
         7EWFpTpS10KZfFUNQzF5E/KnziYpzhQMN76knyeXdvB8HusMYQhRciD1ra8DKBOEUdQA
         GxI4urROKccJqNETVcZQ7ltYdxx0hEXLvmi74HkylTkBPyssBKsAP8Ninop3Oy9FSqTo
         fnig==
X-Gm-Message-State: AOJu0YwUIqJhDryAmjfmIuChEDYUdBUA8Dae1PxkgerurtbEyZjmmqdF
        JxEvoOnQUSFL/psuj1OIOdGchA==
X-Google-Smtp-Source: AGHT+IFl4rcN2gaB0oyR9/CV9GGSy5tbgKYcR2/c+DzHnBC6SxqpBtUaTvXPfQW0WVKSKr8QHOmhvw==
X-Received: by 2002:a17:902:ea11:b0:1c8:7d21:fc63 with SMTP id s17-20020a170902ea1100b001c87d21fc63mr25083841plg.56.1697183259386;
        Fri, 13 Oct 2023 00:47:39 -0700 (PDT)
Received: from localhost.localdomain (fp9875a45d.knge128.ap.nuro.jp. [152.117.164.93])
        by smtp.gmail.com with ESMTPSA id z8-20020a170903018800b001c9ccbb8fdasm3200548plg.260.2023.10.13.00.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 00:47:38 -0700 (PDT)
From:   Masahisa Kojima <masahisa.kojima@linaro.org>
To:     Ard Biesheuvel <ardb@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
Cc:     Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Masahisa Kojima <masahisa.kojima@linaro.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jeremy Kerr <jk@ozlabs.org>, linux-efi@vger.kernel.org
Subject: [PATCH v9 4/6] efivarfs: automatically update super block flag
Date:   Fri, 13 Oct 2023 16:45:37 +0900
Message-Id: <20231013074540.8980-5-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231013074540.8980-1-masahisa.kojima@linaro.org>
References: <20231013074540.8980-1-masahisa.kojima@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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
index 53ae25bbb6ac..d2eec5ed8e5e 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -32,6 +32,7 @@
 #include <linux/ucs2_string.h>
 #include <linux/memblock.h>
 #include <linux/security.h>
+#include <linux/notifier.h>
 
 #include <asm/early_ioremap.h>
 
@@ -187,6 +188,9 @@ static const struct attribute_group efi_subsys_attr_group = {
 	.is_visible = efi_attr_is_visible,
 };
 
+struct blocking_notifier_head efivar_ops_nh;
+EXPORT_SYMBOL_GPL(efivar_ops_nh);
+
 static struct efivars generic_efivars;
 static struct efivar_operations generic_ops;
 
@@ -427,6 +431,8 @@ static int __init efisubsys_init(void)
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
index 4776a3dd9a72..489707b9b0b0 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1355,6 +1355,14 @@ bool efi_config_table_is_usable(const efi_guid_t *guid, unsigned long table)
 
 umode_t efi_attr_is_visible(struct kobject *kobj, struct attribute *attr, int n);
 
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

