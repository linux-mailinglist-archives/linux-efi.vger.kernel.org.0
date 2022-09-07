Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A7E05B059A
	for <lists+linux-efi@lfdr.de>; Wed,  7 Sep 2022 15:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbiIGNq4 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 7 Sep 2022 09:46:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbiIGNqe (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 7 Sep 2022 09:46:34 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF03EA3D3D
        for <linux-efi@vger.kernel.org>; Wed,  7 Sep 2022 06:46:07 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id t65so2691013pgt.2
        for <linux-efi@vger.kernel.org>; Wed, 07 Sep 2022 06:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date;
        bh=fvvLgOpiiVxhgiqg0jJEN5rqJRa+7V40kP2JA0R4QjE=;
        b=pf6WNJNDwap/Pz4C6V9eOqc9fN/2snu95ysWQKf3K9ONTgstVtrkGtQk9LnnBI7Fn0
         OlOCola71+/URIghquVvu5zEIl5xf6RM05RnPOjWCzq3uNgIDyT9BOOo+m3CWfjCYWrp
         rseRx3TOVVLkTiRb9obIsX6DSWwt6VHHHRulAvZBVdFUv/X6JLs4CaJGvMVWPKBrVMTZ
         6+1jG1iMoK65JrLSaQNJZJ6j8yrt1OjBFC9bdAhlRzzFbV/8Zmmhbi5BF8U0FoyR6JwZ
         D0FGt75vAx8+6VByCxFd2oV2JO3mYFrX8lCng2yhRQ/MS1459rfj8zIZtybe43OrLI9u
         c9Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=fvvLgOpiiVxhgiqg0jJEN5rqJRa+7V40kP2JA0R4QjE=;
        b=lvOEUgl6spNMspDe0M2mZnKr3ldeM5uqZ8rJMC6fr0ADQjlfiQXgYPDd1sU2/BQwPB
         oWZr3SCsETv4i4utnXGXnkp+pOOWkJMFlz1JMhcakouQClu5vnPpY+cNwpn+xXHynaOZ
         C1OjaUI9Q5MEJEGrrxN+1Ds06KrpEO7oxaUWq0UoWmjOTuHOYd0bgxD0MHBuwxyCnoGD
         X+HhyOsx/MJj4tFe2P8o3wMXEZ2lsdrI/2j7rJDhMUZpaYLht4DDAHSM//GZaBAUl+No
         qD3PGwmJwp/ayZelw2C4Miays6E7MbSDXk2/AB4tL5FUogB7I8hJfdHtEs2hVlbJ1kaj
         89sg==
X-Gm-Message-State: ACgBeo1160jJSG49eANH7J/0unWzl+sqh8eS5TagFqsg9hMFEHl/p6+S
        P0WVN9r0H5ayT5x+C76obYuka2KFCfw=
X-Google-Smtp-Source: AA6agR5XwPRHYMz0P5mZxBEJxZaR6BfIdSIfr+0WctMuMLBHZ2M6ZqiHfExbN8Rimv2ChRvQqJpblA==
X-Received: by 2002:a63:4b43:0:b0:42a:b42a:d216 with SMTP id k3-20020a634b43000000b0042ab42ad216mr3477116pgl.530.1662558366452;
        Wed, 07 Sep 2022 06:46:06 -0700 (PDT)
Received: from ubuntu ([175.124.254.119])
        by smtp.gmail.com with ESMTPSA id p5-20020aa79e85000000b0053826eaa1c7sm12541066pfq.22.2022.09.07.06.46.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 06:46:05 -0700 (PDT)
Date:   Wed, 7 Sep 2022 06:46:02 -0700
From:   Hyunwoo Kim <imv4bel@gmail.com>
To:     ardb@kernel.org
Cc:     linux-efi@vger.kernel.org, imv4bel@gmail.com
Subject: [PATCH v3] efi: capsule-loader: Fix use-after-free in
 efi_capsule_write
Message-ID: <20220907134602.GA125834@ubuntu>
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
+	struct mutex		write_lock;
 	int			reset_type;
 	long			index;
 	size_t			count;
-- 
2.25.1


Fixed a typo in the v2 patch "struct mutex write_mutex".

Regards,
Hyunwoo Kim.
