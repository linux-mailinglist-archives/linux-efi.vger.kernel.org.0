Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1BD055B12F
	for <lists+linux-efi@lfdr.de>; Sun, 26 Jun 2022 12:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234234AbiFZKcy (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 26 Jun 2022 06:32:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232828AbiFZKcx (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 26 Jun 2022 06:32:53 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2023F1275B
        for <linux-efi@vger.kernel.org>; Sun, 26 Jun 2022 03:32:53 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id x8so1863278pgj.13
        for <linux-efi@vger.kernel.org>; Sun, 26 Jun 2022 03:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=hkHZM8wb80oIrqVifGkSOXwF074+9iUQtUPwitWPy70=;
        b=I7MW+SwZuOjkYhWocpwZRvUUsabAt6//H5v0aRz9oUy4i1MCrWtVnxxmBzUBrMtlMN
         9hEUiLDKruRtF5vxY8VmIZ0eXAyVubZC7WtRXg4gaLkJ8WRTlxcCSrcitPa/0P1GaB9D
         +T9j3c5CDZvL6eiY4jEoLHFuSkYEqshbfr9kcsL4+1PTNuMSYoMqiyY3mW6R+SJRUFkb
         MxGo2Tp30ryoksQqLy+rZpeyr8wYEo+s/049ADuBkf9qm1m9KH6pul+y+/k8nqJokoGQ
         8BxNnk/Zi3zKzw0Opn9yTUykmWIkod7/RHgQ/4EhhrcccN2wRNClgvzpEzBAAvA/IpzC
         7img==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=hkHZM8wb80oIrqVifGkSOXwF074+9iUQtUPwitWPy70=;
        b=Iote8mbXCnJOffojQh5O7i0hes9BcZkmk4hZwvSi9X+SHuy1AMjDCEOa4X3KxuzYPq
         cUEL4Bdh6tVRDB/rwZG1Cmq1SuNn1v6/z30y6zFpI4aO35+rMTIIPLmMN8wKtZWqmZuw
         TPMSrz+65Bb9cqMIRhLQBC5171gi+o362xKrnDGoUfNgq8M16pX18Ttsp4h2JxQX7nPM
         R/EL9r3c+gNmWN1kzfodR5UWE6om855Dyrrz6XAGwdr8YGImTPU36olnenzRZxRQCGS9
         sCHyp2ZfxSLBpqlc2ptrHFuFE805GU4eAb1beHH9D0Y3CXrqQ23xqcSf3c3Wtkk1ps8+
         fs/w==
X-Gm-Message-State: AJIora+RU9eoNox6RYvLhrRmvY3QJjjxvI4hd9eQzNyBMRm+b9CHd4bh
        PoRbPJUA71kqkypP7PA6MB/ag45/FKh4sA==
X-Google-Smtp-Source: AGRyM1vt6wl5ymi3ioVfXjmh523Iksmz5hY8sd+uC7rPOtVsNax97kSH0EFeWX9o8PsZaIiBt9JYTQ==
X-Received: by 2002:a63:8641:0:b0:40d:d04d:1b22 with SMTP id x62-20020a638641000000b0040dd04d1b22mr3915516pgd.418.1656239572482;
        Sun, 26 Jun 2022 03:32:52 -0700 (PDT)
Received: from ubuntu ([175.124.254.119])
        by smtp.gmail.com with ESMTPSA id a8-20020aa78e88000000b0052534ade61dsm4975828pfr.185.2022.06.26.03.32.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jun 2022 03:32:52 -0700 (PDT)
Date:   Sun, 26 Jun 2022 03:32:48 -0700
From:   Hyunwoo Kim <imv4bel@gmail.com>
To:     ardb@kernel.org
Cc:     linux-efi@vger.kernel.org
Subject: [PATCH] efi/capsule-loader: Fix use-after-free in efi_capsule_write
Message-ID: <20220626103248.GA57385@ubuntu>
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

If the user calls close() during a copy operation in copy_from_user() of efi_capsule_write(), 
a race condition may occur in which the user's buffer is copied to the freed page.

This is because .flush of file_operations is called unconditionally 
regardless of ->f_count, unlike .release.

This driver is writable only with root privileges, so it is not a security vulnerability.
However, it is recommended to add mutexes to efi_capsule_write() and efi_capsule_flush() 
as root can accidentally break the page while in use.

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

Dear all,

I submitted this patch 2 weeks ago, this is my 3rd submission of this patch.

Can I get feedback on this patch?

Regards,
Hyunwoo Kim.
