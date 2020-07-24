Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E09D622D0B3
	for <lists+linux-efi@lfdr.de>; Fri, 24 Jul 2020 23:37:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726870AbgGXVhB (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 24 Jul 2020 17:37:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727103AbgGXVg5 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 24 Jul 2020 17:36:57 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CA74C08C5F6
        for <linux-efi@vger.kernel.org>; Fri, 24 Jul 2020 14:36:56 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id il6so453547pjb.0
        for <linux-efi@vger.kernel.org>; Fri, 24 Jul 2020 14:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Qku51F3DrWa6qngs3brRCvs/T/eVZDmg+FQ8m7DJ84Y=;
        b=ErJl9x76PRS3MiK8WeCfMVbTqv2T1HWSOaBV6g16182sJx2KTiDvaZ66SBx1g+ohPj
         IRVh3Mqg9H7OczMYYITojtZNthP78brV4cxTHi/IYEYpcwzAJMjxxGbCMFk1r7YXuMpN
         ilJTX5tTBecVZbZ/0f7uMr2IwzT4Xw/bqZfaM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Qku51F3DrWa6qngs3brRCvs/T/eVZDmg+FQ8m7DJ84Y=;
        b=prVKXAWPWtwA28iutoWQ8qFAjDxI5NSCxYjROErX8vvADWxdErOozqrL3gfKuX+sLs
         3HI4fvjRL5y/B16SThaF4tU7GnUYIxi7n+RheImmyI38riIgvHY3PSmZ6LjOKoIOAr6D
         /8m9hFfdGFQUcYfXbWVN363DIhfLMeXkFgWJYeo71rTQP3pCH9H4ta4iMRxpZos5/ofG
         EUqilXTrf24Wn2kSfNaQsuidJgnIi+xVyaHSZH3KRiQBbOEvWWbt5yC2PumG8M5d6mFn
         KQHrQqlg03gm9I7aBHPO6n6E8UGnn/B5LQzhjmxmz8huF5h8nVGpaMfX68Pd6FK5WN9Y
         WmGQ==
X-Gm-Message-State: AOAM530mDBDYr1xiIAWzCjwUrYwm7an710SxV0cCM2XqgeZOvP42f/b4
        8mg5PyYrLZdkH0/K4Za+Uw++kQ==
X-Google-Smtp-Source: ABdhPJy40e6BQkhVjc5Woc4W4b4IkDw6bQdypPRWbdAX/8+gLgin1GvY06B2zXnxEa4QIBLZ4JbDBg==
X-Received: by 2002:a17:902:8a85:: with SMTP id p5mr9869112plo.89.1595626615673;
        Fri, 24 Jul 2020 14:36:55 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f2sm7244500pfb.184.2020.07.24.14.36.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 14:36:53 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Scott Branden <scott.branden@broadcom.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Jessica Yu <jeyu@kernel.org>, SeongJae Park <sjpark@amazon.de>,
        KP Singh <kpsingh@chromium.org>, linux-efi@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 15/19] IMA: Add support for file reads without contents
Date:   Fri, 24 Jul 2020 14:36:36 -0700
Message-Id: <20200724213640.389191-16-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200724213640.389191-1-keescook@chromium.org>
References: <20200724213640.389191-1-keescook@chromium.org>
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
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 security/integrity/ima/ima_main.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index dc4f90660aa6..459e50526a12 100644
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
+	/* Read entire file for all partial reads during appraisal. */
+	func = read_idmap[read_id] ?: FILE_CHECK;
+	security_task_getsecid(current, &secid);
+	return process_measurement(file, current_cred(), secid, NULL,
+				   0, MAY_READ, func);
 }
 
 const int read_idmap[READING_MAX_ID] = {
-- 
2.25.1

