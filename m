Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83B16771894
	for <lists+linux-efi@lfdr.de>; Mon,  7 Aug 2023 04:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbjHGC4V (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 6 Aug 2023 22:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbjHGC4T (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 6 Aug 2023 22:56:19 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C7FEBA
        for <linux-efi@vger.kernel.org>; Sun,  6 Aug 2023 19:55:45 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1b9c5e07c1bso36300995ad.2
        for <linux-efi@vger.kernel.org>; Sun, 06 Aug 2023 19:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691376944; x=1691981744;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G1Ss6Zu6KDUKnIWTfTdD1avxJMXCefuvC5IKQQ+Drm4=;
        b=qBNOpSAvsRX7NZexEKzLiyF2XJmqUIVDt9Srb9fenSHGtYV7OuPree4w0XbF/PubUu
         7PnxZPkwtGO0Wib+Fu5zsk+RBI3OCF8zojA6eq5emL38+i2qEgFLQUKcYuldzPuUVkIj
         5QNXpPEevBJPJhJQbhKeMNyDTu5jgU4OkJ2YGx57Nu2wHVCujhdsiaUo8dpsVewPZDAL
         YHUSR3/yIsXNkFkFCb+77mYvDJ0VFRuPwvEaRtp0QVKq7bOx8v1dLZgo6WJZrbuvAU8x
         gKQCMaS0ACI9qIT2EjxaF1NYZYwPnfr138Pq5vk/Ireui6ffh6Kvm1YWrcTu/t5bX8WB
         vlBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691376944; x=1691981744;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G1Ss6Zu6KDUKnIWTfTdD1avxJMXCefuvC5IKQQ+Drm4=;
        b=AW7NopiOzAfwtQouSX7sFq/jdBMPfgGXmiXvTuyGQ5CXLrEugSJBajFfoLpQWh1C8Q
         IkoFK2WjaghNaK78Q0wKT1+fsnHpXm7/R5002zhwv/8fZAyyWKGAFGeshflpSa1qWN8B
         OfX23moZcrvhN+DkXfeGm+K9VgtLsr0r0sBeapeOPWZMjU7w7hopY/aBK9VRDLKWUAUb
         Hpkn/bnDIE7A3MJVlu7cK8vhm8TSkYzOWIFn5W4PFtSKrBD6GRa4jrt7yG7KPlpqKz2Y
         RK5MZZbV7zvzepkEf5KBdBe3ZyCw2mfx6DoQbiivVlb1w3PkLsc8LYZ07Pv+lFxhUffp
         kDgg==
X-Gm-Message-State: AOJu0YwOntO8aQvdC3hhHlm19kWuYnCBDEsahzKQtLz4J6zY6a9MgiO5
        aDljVQutOIqC7BAnZ3GP0WAWWA==
X-Google-Smtp-Source: AGHT+IE/F1ebhPj2fduTgDKuL2qd6FwC63LXP0GCqhEO2ibh2R4jTFchicGO9Ql/DCmboPnt04habQ==
X-Received: by 2002:a17:902:f7c9:b0:1bb:b91b:2b40 with SMTP id h9-20020a170902f7c900b001bbb91b2b40mr8462349plw.60.1691376943816;
        Sun, 06 Aug 2023 19:55:43 -0700 (PDT)
Received: from localhost ([164.70.16.189])
        by smtp.gmail.com with ESMTPSA id a7-20020a170902ecc700b001aaecc0b6ffsm5502354plh.160.2023.08.06.19.55.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Aug 2023 19:55:41 -0700 (PDT)
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
Subject: [PATCH v8 4/5] efivarfs: automatically update super block flag
Date:   Mon,  7 Aug 2023 11:53:41 +0900
Message-Id: <20230807025343.1939-5-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230807025343.1939-1-masahisa.kojima@linaro.org>
References: <20230807025343.1939-1-masahisa.kojima@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
index 603bba2d6437..17cd628b5c42 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1365,6 +1365,14 @@ bool efi_config_table_is_usable(const efi_guid_t *guid, unsigned long table)
 
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

