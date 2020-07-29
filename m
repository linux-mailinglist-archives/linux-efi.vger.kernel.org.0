Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9F4232404
	for <lists+linux-efi@lfdr.de>; Wed, 29 Jul 2020 19:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727864AbgG2R7d (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 29 Jul 2020 13:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727921AbgG2R7G (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 29 Jul 2020 13:59:06 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C39E9C061794
        for <linux-efi@vger.kernel.org>; Wed, 29 Jul 2020 10:59:06 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id m8so6470159pfh.3
        for <linux-efi@vger.kernel.org>; Wed, 29 Jul 2020 10:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d+cxh7Adx01Lz+PZ0BqdBZD0tuhqHe+fIcb3T8VVshI=;
        b=ZZB5JK//OYdCgnZb/fU8QzTjp427UrGSGiw79T8stn6rtJuQa9EpnWg2nqhPKWluxW
         W6G5fG+ztYpEQLf1lCq0MlQ9zNk4q/Y5m3gxLuSfvTXmmiKW5Rv4D1MaN0sW3Ja7Djt+
         EOHWd0VX606jZjeyOdUtx/H0g56YaQIalcg6A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d+cxh7Adx01Lz+PZ0BqdBZD0tuhqHe+fIcb3T8VVshI=;
        b=MQ5EA5XzDoXGgeOUVBtOfkfTivQbcoaOwrG84aY+HVSDLi+3ntiyPB4obii1gzLvp3
         dq86wHtPlmHcpEg9mXi2Jg3ce6t9xtzloMW5wCO0EbgsvC1JwbpomAihFjmdloPSC2/V
         KRj+iFXuOFxFH3BUp1CKde2UnI1wzPHn92WLTJp6tJ/lOXOmDEbbjw2+iiNEcjsd+nVl
         2yVXQoJXkPI3bXZZJfeH3yZiftUbGMxdF+tYCSk9oeE3Oe3VTFOEFwnxVxSD+2deOg6C
         Rs7IaOK2a/ncjnuw9KpJo+bT3cH9e5Hfk9HnKJQ/fcEs0AiQmq60wcx9ZfwNjDiFEcPF
         7HwA==
X-Gm-Message-State: AOAM5304kzd2+F/+B9S4HGz4aLT8174CGG4U1MR3sOxuWpmtmD6Jh1wi
        RmzHPD/W1ebykJ+J2gcax6OHgg==
X-Google-Smtp-Source: ABdhPJzwV8yZ+vHoQE7rb6HkYEvIykxXV/ucl+4R0uhyvLJBDEppIOQPIpaDe7F8tvEjOO8IV+mKow==
X-Received: by 2002:a63:ce41:: with SMTP id r1mr31178572pgi.203.1596045546377;
        Wed, 29 Jul 2020 10:59:06 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y10sm3081590pff.187.2020.07.29.10.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2020 10:59:04 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Scott Branden <scott.branden@broadcom.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Takashi Iwai <tiwai@suse.de>, Jessica Yu <jeyu@kernel.org>,
        SeongJae Park <sjpark@amazon.de>,
        KP Singh <kpsingh@chromium.org>, linux-efi@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 13/17] IMA: Add support for file reads without contents
Date:   Wed, 29 Jul 2020 10:58:41 -0700
Message-Id: <20200729175845.1745471-14-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200729175845.1745471-1-keescook@chromium.org>
References: <20200729175845.1745471-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Scott Branden <scott.branden@broadcom.com>

When the kernel_read_file LSM hook is called with contents=false, IMA
can appraise the file directly, without requiring a filled buffer. When
such a buffer is available, though, IMA can continue to use it instead
of forcing a double read here.

Signed-off-by: Scott Branden <scott.branden@broadcom.com>
Link: https://lore.kernel.org/lkml/20200706232309.12010-10-scott.branden@broadcom.com/
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 security/integrity/ima/ima_main.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index dc4f90660aa6..de57fce5bced 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -613,11 +613,8 @@ void ima_post_path_mknod(struct dentry *dentry)
 int ima_read_file(struct file *file, enum kernel_read_file_id read_id,
 		  bool contents)
 {
-	/* Reject all partial reads during appraisal. */
-	if (!contents) {
-		if (ima_appraise & IMA_APPRAISE_ENFORCE)
-			return -EACCES;
-	}
+	enum ima_hooks func;
+	u32 secid;
 
 	/*
 	 * Do devices using pre-allocated memory run the risk of the
@@ -626,7 +623,20 @@ int ima_read_file(struct file *file, enum kernel_read_file_id read_id,
 	 * buffers? It may be desirable to include the buffer address
 	 * in this API and walk all the dma_map_single() mappings to check.
 	 */
-	return 0;
+
+	/*
+	 * There will be a call made to ima_post_read_file() with
+	 * a filled buffer, so we don't need to perform an extra
+	 * read early here.
+	 */
+	if (contents)
+		return 0;
+
+	/* Read entire file for all partial reads. */
+	func = read_idmap[read_id] ?: FILE_CHECK;
+	security_task_getsecid(current, &secid);
+	return process_measurement(file, current_cred(), secid, NULL,
+				   0, MAY_READ, func);
 }
 
 const int read_idmap[READING_MAX_ID] = {
-- 
2.25.1

