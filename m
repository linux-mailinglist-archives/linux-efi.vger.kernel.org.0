Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B59C2323E7
	for <lists+linux-efi@lfdr.de>; Wed, 29 Jul 2020 19:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727968AbgG2R7J (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 29 Jul 2020 13:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727914AbgG2R7G (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 29 Jul 2020 13:59:06 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EC22C0619DC
        for <linux-efi@vger.kernel.org>; Wed, 29 Jul 2020 10:59:05 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id s15so3131347pgc.8
        for <linux-efi@vger.kernel.org>; Wed, 29 Jul 2020 10:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2dckHYDBSef92hBk0hdLw37DCCWMtjung/PzGLRIGlQ=;
        b=PeYr3jVB7W6UcW212/oJZmLRi4czVPcQjfijK3aeH7rdxGYPMC62JtlyIoOxj7gwy5
         c2dWpHJMjKgNg5+GOs7lE5ptFlJbitvkjzFCMkK2BuSsglPWQHHRYHbZXOmZVOOvVeL9
         AXbaJuHNrbC7ktjkX3HyAY7OqVwqAjEvn/WKk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2dckHYDBSef92hBk0hdLw37DCCWMtjung/PzGLRIGlQ=;
        b=GpwpgJPLluRKYN62D4p3LsEV0Y8dZmNrO20GF/UfRLFPPDfTrQoj1S6EqUBqFe/AsJ
         9s2OaFFlmEGBN1bOtdpe1eEA3IgSxTVEgyC2oDuTOjoIWlBQn3+MEpXxqHkTqKIYCzWN
         quIJa2H00bswSHSP4O1WnT0bpnGHfnzXkVUb9s/HC7tB5KlaK61ouCCtDFFXjpHup8Zd
         qfTnIFcTc7ZcQ/WMx1/jZZblgo6hlCNYTrTdbZ+0RYukUD56lgpconL7jHKiSDwhV5Vo
         omxql7mAQyEJ8O3InQ5lIgzPMnNU8MvrNl+PMpaXg4capUV4FXemXpIbOp8OraqSxT6Q
         riYA==
X-Gm-Message-State: AOAM530ScAwnyrKy6UxgAjL7e9vfc4ePAwaq6xyWbSxsXgkLwb74CbS/
        h9KmQHMBdBcLyhbTyjBdWXhS0w==
X-Google-Smtp-Source: ABdhPJx0d4Pms05JWWdUqTfjeGaSa2h+B6c1vOgjK6stye4AbmKSEHfAQSNgfmrRFdWMcscCi/9fDQ==
X-Received: by 2002:a65:64c5:: with SMTP id t5mr30425186pgv.28.1596045544724;
        Wed, 29 Jul 2020 10:59:04 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t73sm3172293pfc.78.2020.07.29.10.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2020 10:58:58 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>, Jessica Yu <jeyu@kernel.org>,
        Scott Branden <scott.branden@broadcom.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Takashi Iwai <tiwai@suse.de>, SeongJae Park <sjpark@amazon.de>,
        KP Singh <kpsingh@chromium.org>, linux-efi@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 11/17] module: Call security_kernel_post_load_data()
Date:   Wed, 29 Jul 2020 10:58:39 -0700
Message-Id: <20200729175845.1745471-12-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200729175845.1745471-1-keescook@chromium.org>
References: <20200729175845.1745471-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Now that there is an API for checking loaded contents for modules
loaded without a file, call into the LSM hooks.

Cc: Jessica Yu <jeyu@kernel.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 kernel/module.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/kernel/module.c b/kernel/module.c
index d773f32f8dfd..72e33e25d7b9 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -2970,7 +2970,7 @@ static int copy_module_from_user(const void __user *umod, unsigned long len,
 	if (info->len < sizeof(*(info->hdr)))
 		return -ENOEXEC;
 
-	err = security_kernel_load_data(LOADING_MODULE, false);
+	err = security_kernel_load_data(LOADING_MODULE, true);
 	if (err)
 		return err;
 
@@ -2980,11 +2980,17 @@ static int copy_module_from_user(const void __user *umod, unsigned long len,
 		return -ENOMEM;
 
 	if (copy_chunked_from_user(info->hdr, umod, info->len) != 0) {
-		vfree(info->hdr);
-		return -EFAULT;
+		err = -EFAULT;
+		goto out;
 	}
 
-	return 0;
+	err = security_kernel_post_load_data((char *)info->hdr, info->len,
+					     LOADING_MODULE);
+out:
+	if (err)
+		vfree(info->hdr);
+
+	return err;
 }
 
 static void free_copy(struct load_info *info)
-- 
2.25.1

