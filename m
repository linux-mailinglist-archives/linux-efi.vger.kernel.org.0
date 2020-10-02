Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34A6228197E
	for <lists+linux-efi@lfdr.de>; Fri,  2 Oct 2020 19:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388436AbgJBRir (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 2 Oct 2020 13:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388441AbgJBRip (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 2 Oct 2020 13:38:45 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 269BAC0610D0
        for <linux-efi@vger.kernel.org>; Fri,  2 Oct 2020 10:38:43 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id gm14so1300747pjb.2
        for <linux-efi@vger.kernel.org>; Fri, 02 Oct 2020 10:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qJcmVj+L5ner65w+xYxx1+RLP+ut9GxY3p4hCl1LqMA=;
        b=gIp5YUPO7PD3ieTusA8eENYMVQ+bK/n83HWEw+rMd0/t8bJ+GMNU1nfo8pmHLBGbey
         H5JyYlqUskPhuVlpO9NQs3bVG1i7dBKQITRy7QTRKpOIYsYmg1kUj4GmG2GV8J6vT6HB
         0O1wQzHOr+TuqSP1UO1FvcIwzyDVBM0jrcqkw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qJcmVj+L5ner65w+xYxx1+RLP+ut9GxY3p4hCl1LqMA=;
        b=ZWj5KRr1YXT0aT+89EsdqZCsFRZmXZT7JZRbQex2LtTdvU0GRrr4yj0tf0MeDoMQ3A
         TpbreQ07jQRp+Ht3M9J0HjkgzgvpvGKjOE/Mekh0/1yfZAHCNu5xDOD+gai1Vo4yQXJ9
         oTnbRd3PUEtkRiRGc8q/ML3IWuPPf66v3jNWKDMaiRjQEOI2Tcn83AJZ8qZiVhLQlTEE
         q1ZkX+9ZVXm9fqMq2yzV0dVl0Jsx47YDVyEue50QK9kNj/gx7Sje+lxOkdstA8dOxEIt
         bjHAxMx96hoF3rCsIXjPqtrWfEdH9rkNxLcij5FF8HVPRAnHDnLKNuqFL9xsggMbDbFm
         Afiw==
X-Gm-Message-State: AOAM531jezJKPWMf8lehZGoDeKf94MHwfTU3lt5MYc0/s6hKTmIj8mEW
        wcbZjthJOMCPV60A4V8iyCjHAQ==
X-Google-Smtp-Source: ABdhPJzBWNvPO4VGKoipwgCa0vomjqtbhEwBldg9Xy+e2FhhYXBi1vlX/kGVu0Jis+yqO1+GeMgDig==
X-Received: by 2002:a17:90a:69e3:: with SMTP id s90mr3814287pjj.130.1601660322701;
        Fri, 02 Oct 2020 10:38:42 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q8sm2480298pfu.173.2020.10.02.10.38.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2020 10:38:36 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Scott Branden <scott.branden@broadcom.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Takashi Iwai <tiwai@suse.de>, Jessica Yu <jeyu@kernel.org>,
        SeongJae Park <sjpark@amazon.de>,
        KP Singh <kpsingh@chromium.org>, linux-efi@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 09/16] firmware_loader: Use security_post_load_data()
Date:   Fri,  2 Oct 2020 10:38:21 -0700
Message-Id: <20201002173828.2099543-10-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201002173828.2099543-1-keescook@chromium.org>
References: <20201002173828.2099543-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Now that security_post_load_data() is wired up, use it instead
of the NULL file argument style of security_post_read_file(),
and update the security_kernel_load_data() call to indicate that a
security_kernel_post_load_data() call is expected.

Wire up the IMA check to match earlier logic. Perhaps a generalized
change to ima_post_load_data() might look something like this:

    return process_buffer_measurement(buf, size,
                                      kernel_load_data_id_str(load_id),
                                      read_idmap[load_id] ?: FILE_CHECK,
                                      0, NULL);

Signed-off-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
---
 drivers/base/firmware_loader/fallback.c       |  8 ++++----
 .../base/firmware_loader/fallback_platform.c  |  8 +++++++-
 security/integrity/ima/ima_main.c             | 20 +++++++++----------
 3 files changed, 21 insertions(+), 15 deletions(-)

diff --git a/drivers/base/firmware_loader/fallback.c b/drivers/base/firmware_loader/fallback.c
index bff4717cc6b5..251d92fc8bae 100644
--- a/drivers/base/firmware_loader/fallback.c
+++ b/drivers/base/firmware_loader/fallback.c
@@ -272,9 +272,9 @@ static ssize_t firmware_loading_store(struct device *dev,
 				dev_err(dev, "%s: map pages failed\n",
 					__func__);
 			else
-				rc = security_kernel_post_read_file(NULL,
-						fw_priv->data, fw_priv->size,
-						READING_FIRMWARE);
+				rc = security_kernel_post_load_data(fw_priv->data,
+						fw_priv->size,
+						LOADING_FIRMWARE, "blob");
 
 			/*
 			 * Same logic as fw_load_abort, only the DONE bit
@@ -613,7 +613,7 @@ static bool fw_run_sysfs_fallback(u32 opt_flags)
 		return false;
 
 	/* Also permit LSMs and IMA to fail firmware sysfs fallback */
-	ret = security_kernel_load_data(LOADING_FIRMWARE, false);
+	ret = security_kernel_load_data(LOADING_FIRMWARE, true);
 	if (ret < 0)
 		return false;
 
diff --git a/drivers/base/firmware_loader/fallback_platform.c b/drivers/base/firmware_loader/fallback_platform.c
index a12c79d47efc..8bdf88043079 100644
--- a/drivers/base/firmware_loader/fallback_platform.c
+++ b/drivers/base/firmware_loader/fallback_platform.c
@@ -17,7 +17,7 @@ int firmware_fallback_platform(struct fw_priv *fw_priv, u32 opt_flags)
 	if (!(opt_flags & FW_OPT_FALLBACK_PLATFORM))
 		return -ENOENT;
 
-	rc = security_kernel_load_data(LOADING_FIRMWARE, false);
+	rc = security_kernel_load_data(LOADING_FIRMWARE, true);
 	if (rc)
 		return rc;
 
@@ -27,6 +27,12 @@ int firmware_fallback_platform(struct fw_priv *fw_priv, u32 opt_flags)
 
 	if (fw_priv->data && size > fw_priv->allocated_size)
 		return -ENOMEM;
+
+	rc = security_kernel_post_load_data((u8 *)data, size, LOADING_FIRMWARE,
+						"platform");
+	if (rc)
+		return rc;
+
 	if (!fw_priv->data)
 		fw_priv->data = vmalloc(size);
 	if (!fw_priv->data)
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 9dd9c5f4d736..6f2b8352573a 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -648,15 +648,6 @@ int ima_post_read_file(struct file *file, void *buf, loff_t size,
 	enum ima_hooks func;
 	u32 secid;
 
-	if (!file && read_id == READING_FIRMWARE) {
-		if ((ima_appraise & IMA_APPRAISE_FIRMWARE) &&
-		    (ima_appraise & IMA_APPRAISE_ENFORCE)) {
-			pr_err("Prevent firmware loading_store.\n");
-			return -EACCES;	/* INTEGRITY_UNKNOWN */
-		}
-		return 0;
-	}
-
 	/* permit signed certs */
 	if (!file && read_id == READING_X509_CERTIFICATE)
 		return 0;
@@ -706,7 +697,7 @@ int ima_load_data(enum kernel_load_data_id id, bool contents)
 		}
 		break;
 	case LOADING_FIRMWARE:
-		if (ima_enforce && (ima_appraise & IMA_APPRAISE_FIRMWARE)) {
+		if (ima_enforce && (ima_appraise & IMA_APPRAISE_FIRMWARE) && !contents) {
 			pr_err("Prevent firmware sysfs fallback loading.\n");
 			return -EACCES;	/* INTEGRITY_UNKNOWN */
 		}
@@ -742,6 +733,15 @@ int ima_post_load_data(char *buf, loff_t size,
 		       enum kernel_load_data_id load_id,
 		       char *description)
 {
+	if (load_id == LOADING_FIRMWARE) {
+		if ((ima_appraise & IMA_APPRAISE_FIRMWARE) &&
+		    (ima_appraise & IMA_APPRAISE_ENFORCE)) {
+			pr_err("Prevent firmware loading_store.\n");
+			return -EACCES; /* INTEGRITY_UNKNOWN */
+		}
+		return 0;
+	}
+
 	return 0;
 }
 
-- 
2.25.1

