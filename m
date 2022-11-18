Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20D1162F639
	for <lists+linux-efi@lfdr.de>; Fri, 18 Nov 2022 14:34:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242178AbiKRNeE (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 18 Nov 2022 08:34:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235303AbiKRNdQ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 18 Nov 2022 08:33:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F7908FF85;
        Fri, 18 Nov 2022 05:32:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 20EFBB823B8;
        Fri, 18 Nov 2022 13:32:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5103AC433D7;
        Fri, 18 Nov 2022 13:32:52 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="gB7VV9jP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1668778371;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+rn43NMm2YFbXIKxqcJTRkqXmYYbQTLqTZ42eLiNxak=;
        b=gB7VV9jPyENstcotO2itt/6NqlfkYEDwmJwFHc7M08FmUDqLboNz/7G/VB8y7bpB4e7bP9
        c8cY9AlAQa3BS8s+AcU0ShpdXM7HOiAM8YJQ2O8XC7fqWKQRQsHRDvDzR4ackIfz042Avd
        AVR9/M/0DXsfxNRxA0ybqp20Tj32FhM=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id e06189ab (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 18 Nov 2022 13:32:51 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-efi@vger.kernel.org, linux-crypto@vger.kernel.org,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH v2 1/5] efi: vars: prohibit reading random seed variables
Date:   Fri, 18 Nov 2022 14:32:35 +0100
Message-Id: <20221118133239.2515648-2-Jason@zx2c4.com>
In-Reply-To: <20221118133239.2515648-1-Jason@zx2c4.com>
References: <20221118133239.2515648-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

In anticipation of putting random seeds in EFI variables, it's important
that the random GUID namespace of variables remains hidden from
userspace. We accomplish this by not populating efivarfs with entries
from that GUID, as well as denying the creation of new ones in that
GUID.

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 fs/efivarfs/inode.c | 4 ++++
 fs/efivarfs/super.c | 3 +++
 2 files changed, 7 insertions(+)

diff --git a/fs/efivarfs/inode.c b/fs/efivarfs/inode.c
index 939e5e242b98..617f3ad2485e 100644
--- a/fs/efivarfs/inode.c
+++ b/fs/efivarfs/inode.c
@@ -91,6 +91,10 @@ static int efivarfs_create(struct user_namespace *mnt_userns, struct inode *dir,
 	err = guid_parse(dentry->d_name.name + namelen + 1, &var->var.VendorGuid);
 	if (err)
 		goto out;
+	if (guid_equal(&var->var.VendorGuid, &LINUX_EFI_RANDOM_SEED_TABLE_GUID)) {
+		err = -EPERM;
+		goto out;
+	}
 
 	if (efivar_variable_is_removable(var->var.VendorGuid,
 					 dentry->d_name.name, namelen))
diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
index 6780fc81cc11..07e82e246666 100644
--- a/fs/efivarfs/super.c
+++ b/fs/efivarfs/super.c
@@ -116,6 +116,9 @@ static int efivarfs_callback(efi_char16_t *name16, efi_guid_t vendor,
 	int err = -ENOMEM;
 	bool is_removable = false;
 
+	if (guid_equal(&vendor, &LINUX_EFI_RANDOM_SEED_TABLE_GUID))
+		return 0;
+
 	entry = kzalloc(sizeof(*entry), GFP_KERNEL);
 	if (!entry)
 		return err;
-- 
2.38.1

