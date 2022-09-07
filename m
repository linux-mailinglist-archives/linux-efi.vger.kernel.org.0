Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E02335B01F1
	for <lists+linux-efi@lfdr.de>; Wed,  7 Sep 2022 12:31:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbiIGKbJ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 7 Sep 2022 06:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbiIGKbH (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 7 Sep 2022 06:31:07 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5068C7C773
        for <linux-efi@vger.kernel.org>; Wed,  7 Sep 2022 03:31:06 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id o126so5175808pfb.6
        for <linux-efi@vger.kernel.org>; Wed, 07 Sep 2022 03:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date;
        bh=iM744CT1yRB3NzIJlUIuTOvumIkRLCKHvFn23BNSRoc=;
        b=anS0kkXqmNkfrxMl5W5BziP+ik+I59voaT2c4aWz99j7BNJa/7xPk9qCTBIrnLR4S4
         AP5eBf/zJD/KbiwTfIGq6LyiMRa79sTOVx29UXNU3UYb1ZqFJbVvFxKVCCD31CQpRq4k
         p4vG5QSII0mMkhT4lcBKdWqN5ZZbUFW0T2n//EII+e134xq+RVHi3+7WKo/bDpoye9PR
         6qs37GwBBtOUG6+lp1aatQ3X0u895jRpdRWLoWMrLhY/RFipQex07nRWhbOxGg7fFLmG
         Qx5QOi0xdPNEsr5V4plO7zAgS3ELX1uDX7R7ar/jg5/6axOvzpNzJwHUVqD9PkWlX4Wc
         lvnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=iM744CT1yRB3NzIJlUIuTOvumIkRLCKHvFn23BNSRoc=;
        b=PLKvZ3Ot06lYuNrwf8MaLCKbRqdJGpxSujHsU1bdaqYwvrZu0OouN+1IvFs4dw/J0N
         NtIilbwz0dNzOUxEx60x0LR/aTdQXCnY1FPwjE1V++yQbD340ycu7QQUL8eF/yqVkP7h
         pa4GbKPIanM79biq2NemZeGo11GE+c3X7KB6LMR3Td9qYeW6eFkCF0a+otVhYWMLYDi2
         FfoJ/zMyLZKghlfJrP77GdcGDzB4nA4zH0x2Y2F6rDLWW9U6bTrdZliOJJoB2ObusxH5
         RxmJeKemtK8L19Yz2bafhQXmD4ckOzKhephizQouDe1oO7ZpPtkyka6prALuYM5lZw1/
         X/OA==
X-Gm-Message-State: ACgBeo12+k/15FOZNrWX0S7ks8wWOImRPt6fYQC5fPf+k9fzqiDYf+QB
        ntj1Ssdq+mSg8YP0Kdq+obA=
X-Google-Smtp-Source: AA6agR4MPq5f5LCtLhB/wYODWO/itvP/AFEsSps78l/iXlrHBNc1SXuZ6ToJgq3iS41+QAmX93pDJQ==
X-Received: by 2002:a05:6a00:21cc:b0:53d:debc:2ea1 with SMTP id t12-20020a056a0021cc00b0053ddebc2ea1mr3401957pfj.56.1662546665852;
        Wed, 07 Sep 2022 03:31:05 -0700 (PDT)
Received: from ubuntu ([175.124.254.119])
        by smtp.gmail.com with ESMTPSA id 16-20020a17090a0e9000b002007b60e288sm5243917pjx.23.2022.09.07.03.31.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 03:31:05 -0700 (PDT)
Date:   Wed, 7 Sep 2022 03:31:02 -0700
From:   Hyunwoo Kim <imv4bel@gmail.com>
To:     ardb@kernel.org
Cc:     linux-efi@vger.kernel.org, imv4bel@gmail.com
Subject: [PATCH v2] efi: capsule-loader: Fix use-after-free in
 efi_capsule_write
Message-ID: <20220907103102.GA116958@ubuntu>
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

This is a race condition that occurs between the efi_capsule_write() and 
efi_capsule_flush() functions of efi_capsule_fops, 
which ultimately results in UAF.

So I added mutex_lock/unlock to these two functions 
to avoid race condition.

Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
---
 drivers/firmware/efi/capsule-loader.c | 12 ++++++++++++
 include/linux/efi.h                   |  1 +
 2 files changed, 13 insertions(+)

diff --git a/drivers/firmware/efi/capsule-loader.c b/drivers/firmware/efi/capsule-loader.c
index 4dde8edd53b6..ca50cb982371 100644
--- a/drivers/firmware/efi/capsule-loader.c
+++ b/drivers/firmware/efi/capsule-loader.c
@@ -174,6 +174,8 @@ static ssize_t efi_capsule_write(struct file *file, const char __user *buff,
 	void *kbuff = NULL;
 	size_t write_byte;
 
+	mutex_lock(&cap_info->write_lock);
+
 	if (count == 0)
 		return 0;
 
@@ -233,12 +235,16 @@ static ssize_t efi_capsule_write(struct file *file, const char __user *buff,
 			goto failed;
 	}
 
+	mutex_unlock(&cap_info->write_lock);
+
 	return write_byte;
 
 fail_unmap:
 	kunmap(page);
 failed:
 	efi_free_all_buff_pages(cap_info);
+	mutex_unlock(&cap_info->write_lock);
+
 	return ret;
 }
 
@@ -256,12 +262,16 @@ static int efi_capsule_flush(struct file *file, fl_owner_t id)
 	int ret = 0;
 	struct capsule_info *cap_info = file->private_data;
 
+	mutex_lock(&cap_info->write_lock);
+
 	if (cap_info->index > 0) {
 		pr_err("capsule upload not complete\n");
 		efi_free_all_buff_pages(cap_info);
 		ret = -ECANCELED;
 	}
 
+	mutex_unlock(&cap_info->write_lock);
+
 	return ret;
 }
 
@@ -315,6 +325,8 @@ static int efi_capsule_open(struct inode *inode, struct file *file)
 		return -ENOMEM;
 	}
 
+	mutex_init(&cap_info->write_lock);
+
 	file->private_data = cap_info;
 
 	return 0;
diff --git a/include/linux/efi.h b/include/linux/efi.h
index d2b84c2fec39..f8b92a54d3c9 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -204,6 +204,7 @@ struct efi_image_auth {
 struct capsule_info {
 	efi_capsule_header_t	header;
 	efi_capsule_header_t	*capsule;
+	struct mutex		write_mutex;
 	int			reset_type;
 	long			index;
 	size_t			count;
-- 
2.25.1

