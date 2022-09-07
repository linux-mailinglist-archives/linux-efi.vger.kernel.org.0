Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97FB25B08A6
	for <lists+linux-efi@lfdr.de>; Wed,  7 Sep 2022 17:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbiIGPfU (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 7 Sep 2022 11:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiIGPfT (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 7 Sep 2022 11:35:19 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DF1167158
        for <linux-efi@vger.kernel.org>; Wed,  7 Sep 2022 08:35:18 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id z187so14989572pfb.12
        for <linux-efi@vger.kernel.org>; Wed, 07 Sep 2022 08:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date;
        bh=tcezKddoaOYGKfWECrHEAwsAR8wUyzBKlSKo0IIJr7I=;
        b=U1rDRYKxu3ttJKziP9grpw2iQLoXjAtIzl3ctVXAJFcZUIsA6KJdqNRUAgSkafCZyy
         lkMRZOhRXjwLcY2QnJrYRbOoUDRb19EkqNqXzjxe4dDwgL7jgHIZE6ESK9TNUTsyfK3q
         3Djv7IHaZaE7Yw6kKohiCDF5rUqa/7MxHJqBIHqLlwwgLi1sJoXtLOmSit0Ez3NOiAe0
         xc3Yp+Ovg9u0Q4nMeoW3oaBk1r4pxvj7DUscMQdz3BGCz+CVsEgnGmHsm0RcyPNQA8Go
         2MCPPONe3vJveUxmrUxMad7cz5jJ7dHe81bl8xy9n0raiOP2SC46/MsSUgsfpjz2jUxr
         UwdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=tcezKddoaOYGKfWECrHEAwsAR8wUyzBKlSKo0IIJr7I=;
        b=lc9ifs/8uB2hnUugL5Ap2iJ2jxjgVS1M27fyICLwaYuo7QwUAKjFX68zteho3E1V1D
         pPCS0hX14lyKK9KvNugWQG1PGZrGJgGxyWiS0BXyiCT3HYz16iPxnj2WAVFhu26U2t80
         AVx9sFJQUTy6x2P/wqHxQrj4MSK++dgR5ddJSUUTbO/krGb0vwUrtmS2ka9pi3SgwFMN
         5CTLE7QDUVrS+/9YKD+3YZUPsUsuhAE6s00mJYE2zjJITTSM/YP3ng5nab2JVzLHUngQ
         6kdUxFiz+XDqKehQr4xJbLcAgB/JDj6+YIzJ7C4InqpS9sIuabLOjFWYyfWoqmbEdTeL
         Aemg==
X-Gm-Message-State: ACgBeo1K70epmtoTiWgtbr80/D0b5EsL/o0il83IIFRa8c5vQ/LQyFNG
        Yclqe9DAq8X9hDMZU9xCHYzAorc4GOI=
X-Google-Smtp-Source: AA6agR7SapapjFSPJrXFh+l1RMhgyxnsEIZm+eezMSGHq3R0RrOyfACb2wvwH2CpQ32R75oOYt31fQ==
X-Received: by 2002:a63:fe12:0:b0:42a:e57:7464 with SMTP id p18-20020a63fe12000000b0042a0e577464mr3977953pgh.552.1662564918085;
        Wed, 07 Sep 2022 08:35:18 -0700 (PDT)
Received: from ubuntu ([175.124.254.119])
        by smtp.gmail.com with ESMTPSA id p13-20020aa79e8d000000b0052e7f103138sm12867433pfq.38.2022.09.07.08.35.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 08:35:17 -0700 (PDT)
Date:   Wed, 7 Sep 2022 08:35:13 -0700
From:   Hyunwoo Kim <imv4bel@gmail.com>
To:     ardb@kernel.org
Cc:     linux-efi@vger.kernel.org, imv4bel@gmail.com
Subject: [PATCH v4] efi: capsule-loader: Fix use-after-free in
 efi_capsule_write
Message-ID: <20220907153513.GA147130@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

A race condition may occur if the user calls close() on another
thread during a write() operation on the device node of the efi capsule.

This is a race condition that occurs between the efi_capsule_write()
and efi_capsule_flush() functions of efi_capsule_fops,
which ultimately results in UAF.

So, the page freeing process is modified to be done in
efi_capsule_release() instead of efi_capsule_flush().

Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
---
 drivers/firmware/efi/capsule-loader.c | 29 ++++++---------------------
 1 file changed, 6 insertions(+), 23 deletions(-)

diff --git a/drivers/firmware/efi/capsule-loader.c b/drivers/firmware/efi/capsule-loader.c
index 4dde8edd53b6..788e860304ae 100644
--- a/drivers/firmware/efi/capsule-loader.c
+++ b/drivers/firmware/efi/capsule-loader.c
@@ -243,18 +243,17 @@ static ssize_t efi_capsule_write(struct file *file, const char __user *buff,
 }
 
 /**
- * efi_capsule_flush - called by file close or file flush
+ * efi_capsule_release - called by file close
+ * @inode: not used
  * @file: file pointer
- * @id: not used
  *
- *	If a capsule is being partially uploaded then calling this function
- *	will be treated as upload termination and will free those completed
- *	buffer pages and -ECANCELED will be returned.
+ *	We will not free successfully submitted pages since efi update
+ *	requires data to be maintained across system reboot.
  **/
-static int efi_capsule_flush(struct file *file, fl_owner_t id)
+static int efi_capsule_release(struct inode *inode, struct file *file)
 {
-	int ret = 0;
 	struct capsule_info *cap_info = file->private_data;
+	int ret = 0;
 
 	if (cap_info->index > 0) {
 		pr_err("capsule upload not complete\n");
@@ -262,21 +261,6 @@ static int efi_capsule_flush(struct file *file, fl_owner_t id)
 		ret = -ECANCELED;
 	}
 
-	return ret;
-}
-
-/**
- * efi_capsule_release - called by file close
- * @inode: not used
- * @file: file pointer
- *
- *	We will not free successfully submitted pages since efi update
- *	requires data to be maintained across system reboot.
- **/
-static int efi_capsule_release(struct inode *inode, struct file *file)
-{
-	struct capsule_info *cap_info = file->private_data;
-
 	kfree(cap_info->pages);
 	kfree(cap_info->phys);
 	kfree(file->private_data);
@@ -324,7 +308,6 @@ static const struct file_operations efi_capsule_fops = {
 	.owner = THIS_MODULE,
 	.open = efi_capsule_open,
 	.write = efi_capsule_write,
-	.flush = efi_capsule_flush,
 	.release = efi_capsule_release,
 	.llseek = no_llseek,
 };
-- 
2.25.1

