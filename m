Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A060A5B09BA
	for <lists+linux-efi@lfdr.de>; Wed,  7 Sep 2022 18:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbiIGQIU (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 7 Sep 2022 12:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbiIGQIA (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 7 Sep 2022 12:08:00 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43E4DB2CEB
        for <linux-efi@vger.kernel.org>; Wed,  7 Sep 2022 09:07:20 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id q63so14023027pga.9
        for <linux-efi@vger.kernel.org>; Wed, 07 Sep 2022 09:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date;
        bh=8rSKkOgWaS8u7bE/tTuGwqArO0055ZIGLm107F6sIzw=;
        b=mV2WAJ3jD42MJUg5Onh+9b0Pymwtw7zJOBgBE/ct6ZNU2k0zMdTumeLo45bIPTgDCo
         oEGpzoaCM3Q+gYraRZPKMgQSwPfebYIZ4V30L9mDacUMfZRm2NImskJydDtJ1teo9rQp
         HQXzs/q/gOBJEU3KiXKDNiF+YQs+a0GhDn0R5FVnkC/ER9nTN20F5fGfz0lbrv5HNyq2
         wrGt73mf2zP5cCkL5/XTQdewSVBlZqh12NJ5KHzs8nwR1UDv01L7Z4/QwMZ117AGRF1M
         2JDZAZ+MGZhW0Hq22/lLPIsv5obNOAhpCfZvN0JCu/PaDWneglBpaqV9o61mq4Gk/rW1
         wr5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=8rSKkOgWaS8u7bE/tTuGwqArO0055ZIGLm107F6sIzw=;
        b=JHntsaOPItZve95703qhXuqqL9ukkLkqUHRgDquuZhVEtTbttnYLAjW1OwE2xaeea5
         TbWJ+y3o4LtgNv4iof1byEoGo63gYiJRyNaYSNzuNzydIpXLheEImaqHLZAUPvDoznUi
         P3oAQDBZuDg4KzXTmBAzGUDKWxOriFIGg+4vlN+ISBxV39xdZLCctqb+vLeikzYAs45A
         HyusJSOvU1aUPCMWd6BH+q83bPh9KsE4ndfaoP72OGOASilmDVh4LVH+JmuYkfDaqZaU
         VIHUO5eepQASA5UH1UXPrDpgr7xtJVZNd95gyPAqqb1psHqEp5G6wiBLA7rPXCoWJeDP
         a0Ww==
X-Gm-Message-State: ACgBeo1qvk7auWR+JX6KuuwWOaPiN8QI50aCFScVDvdZHd4Bnop/eMti
        LjsyciNBcAxJc5XdV826qu1+KHEBqY8=
X-Google-Smtp-Source: AA6agR65SE7LBTi0egtZDnYMh4nk2w3m5Y+p8XHjYE9dnCItj1NCKbWQGPKIFUMc9ZQ1LoCJuxFNgw==
X-Received: by 2002:a05:6a00:22c6:b0:52f:4d67:b370 with SMTP id f6-20020a056a0022c600b0052f4d67b370mr4625841pfj.58.1662566839283;
        Wed, 07 Sep 2022 09:07:19 -0700 (PDT)
Received: from ubuntu ([175.124.254.119])
        by smtp.gmail.com with ESMTPSA id 22-20020a630a16000000b00434e57bfc6csm1777805pgk.56.2022.09.07.09.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 09:07:18 -0700 (PDT)
Date:   Wed, 7 Sep 2022 09:07:14 -0700
From:   Hyunwoo Kim <imv4bel@gmail.com>
To:     ardb@kernel.org
Cc:     linux-efi@vger.kernel.org, imv4bel@gmail.com
Subject: [PATCH v5] efi: capsule-loader: Fix use-after-free in
 efi_capsule_write
Message-ID: <20220907160714.GA150039@ubuntu>
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
 drivers/firmware/efi/capsule-loader.c | 31 ++++++---------------------
 1 file changed, 7 insertions(+), 24 deletions(-)

diff --git a/drivers/firmware/efi/capsule-loader.c b/drivers/firmware/efi/capsule-loader.c
index 4dde8edd53b6..cec826adcb51 100644
--- a/drivers/firmware/efi/capsule-loader.c
+++ b/drivers/firmware/efi/capsule-loader.c
@@ -242,29 +242,6 @@ static ssize_t efi_capsule_write(struct file *file, const char __user *buff,
 	return ret;
 }
 
-/**
- * efi_capsule_flush - called by file close or file flush
- * @file: file pointer
- * @id: not used
- *
- *	If a capsule is being partially uploaded then calling this function
- *	will be treated as upload termination and will free those completed
- *	buffer pages and -ECANCELED will be returned.
- **/
-static int efi_capsule_flush(struct file *file, fl_owner_t id)
-{
-	int ret = 0;
-	struct capsule_info *cap_info = file->private_data;
-
-	if (cap_info->index > 0) {
-		pr_err("capsule upload not complete\n");
-		efi_free_all_buff_pages(cap_info);
-		ret = -ECANCELED;
-	}
-
-	return ret;
-}
-
 /**
  * efi_capsule_release - called by file close
  * @inode: not used
@@ -277,6 +254,13 @@ static int efi_capsule_release(struct inode *inode, struct file *file)
 {
 	struct capsule_info *cap_info = file->private_data;
 
+	if (cap_info->index > 0 &&
+		(cap_info->header.headersize == 0 ||
+		cap_info->count < cap_info->total_size)) {
+		pr_err("capsule upload not complete\n");
+		efi_free_all_buff_pages(cap_info);
+	}
+
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

