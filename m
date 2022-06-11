Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97EA9547753
	for <lists+linux-efi@lfdr.de>; Sat, 11 Jun 2022 21:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231239AbiFKTkZ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 11 Jun 2022 15:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231250AbiFKTkY (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 11 Jun 2022 15:40:24 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B98B547062
        for <linux-efi@vger.kernel.org>; Sat, 11 Jun 2022 12:40:23 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id i1so1937220plg.7
        for <linux-efi@vger.kernel.org>; Sat, 11 Jun 2022 12:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=cSm2NJt9iaLHTCu/twYKHMGYlgx5OqEZL1E0jaqACLM=;
        b=LgpgBpd1DRnB3U/CgS6UnJuPjx4mhkZF+sOz/y8/z/59l1Mm7mjGpOcccR8ghQrAb3
         ZSClv+AFuqjTkn6Zco/NWJNi3wejJcNyGoBurm6beR0ElvoAxv4KLXT/jzX365XtnCqR
         OXzosIEV+HXMToAJqrVLSSY7c71MbLgGqq5a1hQffhj3vnslTV9jla/r+WIXPmbaHnGR
         nNw4bFum8Ux7GgrclUjpCDp3OKZZBRYE4A+JcSwCS7bkERHY1mzb36C8yBaZ4DojyH1N
         uLyV6bPR25lMOaGOSTJ5dAPddF0/rtDeMwRXKvvlz+yfjaqtte1tTJfDoZgQhZPE7JiK
         xYlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=cSm2NJt9iaLHTCu/twYKHMGYlgx5OqEZL1E0jaqACLM=;
        b=axJIWIZZYFkuIF7j0DdftFC2URSreBpJz+PJ63SEVcsU6Ua9ysseEfkMebuYX7Wj6V
         kzz0tJD/cM7We4e1nN7YOFyFkq1Mmh8gjDbPGywm7lPSPp1qIbGzPypsyYPvj++UMqRJ
         aGwxiw4xNccbL+JtWK7ieQXOpaALbvVBVZnws1jzeySc8D3idn1gmZ8E+cOy4vs/OGQT
         f/yUHvNYRGSKVJczV2vusosBR3eS5/hwM/M0ANYDJi/YFz9tyTKIWv6XQNTYbYpgqpJH
         6k1q3bx+qNOX1hDp90JucMI4hM7bmPc+/xOssxIrjxo8+ayCaIMJZmWDaMUlIrME9JzK
         biVg==
X-Gm-Message-State: AOAM530y0I3/nYjvHNMhAXsHnZGWipBQzFn6bXJ//tzQGv07zZ9mslyo
        NRCHqdnz/0KVBW5JoT1lZ9u+uUIdcgK3SA==
X-Google-Smtp-Source: ABdhPJxhV4KUf4Torzjeb/AlD1Nuq6luY5mBqVZQ49gUnnbaDGgGuDi0+KbsfxQc0+TsBhJtkdelzg==
X-Received: by 2002:a17:902:b282:b0:163:ffe6:2cf9 with SMTP id u2-20020a170902b28200b00163ffe62cf9mr51782965plr.76.1654976423241;
        Sat, 11 Jun 2022 12:40:23 -0700 (PDT)
Received: from ubuntu ([175.124.254.119])
        by smtp.gmail.com with ESMTPSA id h10-20020a62830a000000b0051b62689ec2sm1940612pfe.129.2022.06.11.12.40.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jun 2022 12:40:22 -0700 (PDT)
Date:   Sat, 11 Jun 2022 12:40:19 -0700
From:   Hyunwoo Kim <imv4bel@gmail.com>
To:     ardb@kernel.org, linux-efi@vger.kernel.org
Subject: [PATCH] efi/capsule-loader: Add write mutex to prevent uaf
Message-ID: <20220611194019.GA483211@ubuntu>
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
However, it seems to be a good idea to add mutexes to 
efi_capsule_write() and efi_capsule_flush() as root can 
accidentally break the page while in use.

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

