Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C06EE540D57
	for <lists+linux-efi@lfdr.de>; Tue,  7 Jun 2022 20:48:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347530AbiFGSsW (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 7 Jun 2022 14:48:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353964AbiFGSqV (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 7 Jun 2022 14:46:21 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 107CA18DAD8
        for <linux-efi@vger.kernel.org>; Tue,  7 Jun 2022 10:59:50 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id c14so16536515pgu.13
        for <linux-efi@vger.kernel.org>; Tue, 07 Jun 2022 10:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=OCrBfMB5XmI6P2G9zPVN7pDIEnXX+Jd7w4w3415cXtY=;
        b=DBk0FdnqVFmEQUX6ITZaPt6i5/jefBHSWtqHvrPcg1r9ZY6TEV00+O4iZ8Sv0YTyvJ
         sue9FTwzYra4grg3FUrg9aqngcZ8MVIS1K7tu1/+VFqi1LgFK2W9L/iuW7IlctdfKojH
         pcXGmV1+Yps8TQyckprpxFrkv+PaC24xHOrQ/o17zIv0axmKFmii8luW7aHzxNQJJ0lv
         kLc6fM00sYS/nqqUIuQfO7kuO655oisIygDUQIvEIDOE4jtyi5wW1jP0U+kOkrsNNq/3
         jELhYUhvqzfibN33JWVJxTQj8qSeUw9KDGd2I8c3D4ozNlM4tkx7IqHlKXzrR8xhn3Sk
         8vCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=OCrBfMB5XmI6P2G9zPVN7pDIEnXX+Jd7w4w3415cXtY=;
        b=jlHZbJShke+2Smzotn3TM3/VueIxzWPShf0TnUb7mvn1VY5PZd96/mdXrNByq5mSvg
         CrEdl7Fx8vXCM+zWH3opYZH7CL3tKzQJYHw3btx1pRoAPEfhAMMeUfACSGMZvgAR/eqm
         2h/o45ViurJUq4qCOp1rV2Bjl8mMLdJFMgam6QGowDcr6NR7GQqL3kkSQSB8uWdCqh/3
         Ff+8zq/DHszsPlIWNu2g3cpcvkkKRjnnlRfWEN1e8UE7x6317mCMv6I7SaOiqdZWHYBU
         PGN4Tb1kp/L/fdSz+4gO+tAUJ0No8/UDuR2XfpMyIenzD2iViHz0AX1MTD+9KuioywHj
         eWGg==
X-Gm-Message-State: AOAM530zhOMzSR0hiTS9Atjy08lQm9umgGwsIyvLkw9pkEKncXuC0sYR
        Wp8JLRcXe/rworhaKDQwT3CRunMI1tmGjA==
X-Google-Smtp-Source: ABdhPJzcG52XvvojKmbTYARUGZqraunKP1qEcm3SfbLZ0lGVdQIHbGCyI9myg/jNEmYMri2b9/KI2g==
X-Received: by 2002:a63:1b26:0:b0:3fd:8db8:9602 with SMTP id b38-20020a631b26000000b003fd8db89602mr13415877pgb.239.1654624790015;
        Tue, 07 Jun 2022 10:59:50 -0700 (PDT)
Received: from ubuntu ([175.124.254.119])
        by smtp.gmail.com with ESMTPSA id q16-20020a170902dad000b0015e8d4eb1c6sm13051960plx.16.2022.06.07.10.59.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 10:59:49 -0700 (PDT)
Date:   Tue, 7 Jun 2022 10:59:46 -0700
From:   Hyunwoo Kim <imv4bel@gmail.com>
To:     ardb@kernel.org, linux-efi@vger.kernel.org
Subject: [PATCH] firmware/efi: Add write mutex to prevent uaf - revision
Message-ID: <20220607175946.GA396134@ubuntu>
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

If the user calls close() in the middle of copy operation in
copy_from_user() of efi_capsule_write(),
the user buffer may be copied to the released page.
This is because ->flush is called unconditionally regardless
of f_count, unlike ->release.
This driver is not a security vulnerability, as only
root privileges can write to it.
However, you need to add a mutex to efi_capsule_write()
and efi_capsule_flush() as root can accidentally break
the page while in use.

Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
---
 drivers/firmware/efi/capsule-loader.c | 12 ++++++++++++
 include/linux/efi.h                   |  1 +
 2 files changed, 13 insertions(+)

diff --git a/drivers/firmware/efi/capsule-loader.c b/drivers/firmware/efi/capsule-loader.c
index 4dde8edd53b6..e50ede51ef38 100644
--- a/drivers/firmware/efi/capsule-loader.c
+++ b/drivers/firmware/efi/capsule-loader.c
@@ -177,6 +177,8 @@ static ssize_t efi_capsule_write(struct file *file, const char __user *buff,
 	if (count == 0)
 		return 0;
 
+	mutex_lock(&cap_info->write_lock);
+
 	/* Return error while NO_FURTHER_WRITE_ACTION is flagged */
 	if (cap_info->index < 0)
 		return -EIO;
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
index 7d9b0bb47eb3..e274c4e8d7c6 100644
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

