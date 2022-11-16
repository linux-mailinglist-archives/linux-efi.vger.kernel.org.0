Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95EF162C3CE
	for <lists+linux-efi@lfdr.de>; Wed, 16 Nov 2022 17:17:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233740AbiKPQRX (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 16 Nov 2022 11:17:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238085AbiKPQRR (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 16 Nov 2022 11:17:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8514BD135;
        Wed, 16 Nov 2022 08:17:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 42997B81DD9;
        Wed, 16 Nov 2022 16:17:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CD32C433D6;
        Wed, 16 Nov 2022 16:17:13 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="DO7/xtKp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1668615433;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SutN9URRaDRkoRI4sfbAAJPIQ0pLYtrJHZUE/tUAx5Q=;
        b=DO7/xtKpmJ+qbHUkvjOiJl95LOYlJrLNXrCH1BXJ5r/WuFITUd9HEjZ/RqdSLzoGooTmYc
        gfHssY9a8mQGQCUu90xJOpKx3QeILTHlt5an1KxtzQ2WBAcZ4bsfucAykgwEOaq44uGweW
        bOC9xpFA89pnO1UW3k8kh5xasxnPH/E=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 8e977426 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 16 Nov 2022 16:17:12 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-efi@vger.kernel.org, linux-crypto@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Lennart Poettering <lennart@poettering.net>
Subject: [PATCH RFC v1 5/6] efi: efivarfs: prohibit reading random seed variables
Date:   Wed, 16 Nov 2022 17:16:41 +0100
Message-Id: <20221116161642.1670235-6-Jason@zx2c4.com>
In-Reply-To: <20221116161642.1670235-1-Jason@zx2c4.com>
References: <20221116161642.1670235-1-Jason@zx2c4.com>
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

Variables in the random seed GUID must remain secret, so deny all reads
to them.

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 fs/efivarfs/file.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/efivarfs/file.c b/fs/efivarfs/file.c
index d57ee15874f9..08996ba3a373 100644
--- a/fs/efivarfs/file.c
+++ b/fs/efivarfs/file.c
@@ -76,6 +76,9 @@ static ssize_t efivarfs_file_read(struct file *file, char __user *userbuf,
 	while (!__ratelimit(&file->f_cred->user->ratelimit))
 		msleep(50);
 
+	if (guid_equal(&var->var.VendorGuid, &LINUX_EFI_RANDOM_SEED_TABLE_GUID))
+		return -EPERM;
+
 	err = efivar_entry_size(var, &datasize);
 
 	/*
-- 
2.38.1

