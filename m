Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 019D85B05BB
	for <lists+linux-efi@lfdr.de>; Wed,  7 Sep 2022 15:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbiIGNwg (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 7 Sep 2022 09:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiIGNwf (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 7 Sep 2022 09:52:35 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4DC579630
        for <linux-efi@vger.kernel.org>; Wed,  7 Sep 2022 06:52:34 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id z187so14679486pfb.12
        for <linux-efi@vger.kernel.org>; Wed, 07 Sep 2022 06:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date;
        bh=Os46oyuXrrUnaSHzX2Jq5aIhZgyL8+b3lVhx1qrbkDc=;
        b=dkB94lF8C5dYlJ5scLm6XqDxQpSdghGmoDw5F1hPc6a8Ry24hdRHklg6DlZNrqVGe/
         z81+QDHPXHchZ1FgRJv7oWIzm9mcLhvpQ3Cew3MbmHEghQWaq+9SuipEdZwvNcEZWQHH
         /LSWgLyOyEnH6NdwqhBDjVv/pqtp+GbtOoAIuMafNfK1ai/w++mXxCo5G0ayRJe4mIdU
         WzvvV8/ONQ/FolOwzc5SuLjLHzxmUCT5IEp+siyJ/Ld9w/qumi5+m9LtMwXhn3uDd2ZA
         5MiBioESBD4S0V/3AMUjIMQLvtxTpUsAccEuw/mHYiQhDNr7Hx8t4hXRRyMkbFBpVolZ
         XBXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Os46oyuXrrUnaSHzX2Jq5aIhZgyL8+b3lVhx1qrbkDc=;
        b=c6sbl04HTW6ZfA1zIhP/gCosnRKL1nZTAtl49i0V6JxxzeVnC+ZnWC/uDjxcVPVAwh
         b3c3WIsZnLRQBEOfbdwSAdpvrCJeuXaj0MiOTe7eGqBRMel0DJwD+xn+LGvhAQRqeHGo
         50qpt4pHq6OjHDzel6JpJXCZQVuxCn3HCDvzqGqjduAhWqaAqYpKbjQck+R9jHiRXxIW
         2xeD/7az5nkkILtTvmn1kR/ojQyH2WSM9HSQESaCcsfYqbt5DmESIw84J2u3Gp1wwdjl
         qSDA4FZ/tVp6bZR0hygOjYBShpKGtE8mT8jd6DW3FNbGQQrHE+kOBrtb/IhTUS9BuXmz
         zxKw==
X-Gm-Message-State: ACgBeo0N+LkeEs4i4jmky6otJP7b13s3OlJK3L6pdMOpZ/+YVGZ3ow47
        TwQpUHfiMwIijrBdW0b8K44=
X-Google-Smtp-Source: AA6agR4ds+XmuM2Kb5JbF8smadZZAh7m8bZtKJiZs3j1y427pKB9fQNgih3nljL7A0brLglGIyyjiA==
X-Received: by 2002:a63:798c:0:b0:42a:4612:c07b with SMTP id u134-20020a63798c000000b0042a4612c07bmr3545736pgc.519.1662558754079;
        Wed, 07 Sep 2022 06:52:34 -0700 (PDT)
Received: from ubuntu ([175.124.254.119])
        by smtp.gmail.com with ESMTPSA id p2-20020a17090a680200b001efa9e83927sm12064171pjj.51.2022.09.07.06.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 06:52:33 -0700 (PDT)
Date:   Wed, 7 Sep 2022 06:52:30 -0700
From:   Hyunwoo Kim <imv4bel@gmail.com>
To:     ardb@kernel.org
Cc:     linux-efi@vger.kernel.org, imv4bel@gmail.com
Subject: [PATCH v3] efi: capsule-loader: Fix use-after-free in
 efi_capsule_write
Message-ID: <20220907135230.GA126279@ubuntu>
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

ah... I had a problem with my mutt client. Sent back with v3 patch. Sorry.

Regards,
Hyunwoo Kim.
