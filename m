Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 951BA11E042
	for <lists+linux-efi@lfdr.de>; Fri, 13 Dec 2019 10:07:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725906AbfLMJHK (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 13 Dec 2019 04:07:10 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50300 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725810AbfLMJHJ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 13 Dec 2019 04:07:09 -0500
Received: by mail-wm1-f67.google.com with SMTP id a5so5471104wmb.0;
        Fri, 13 Dec 2019 01:07:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5zlnMRG2Xz8RVeE2jai5rgez52Z3RsSPyyE68+eN4M4=;
        b=FpL1UGCwvEiOCsz+c7RFhxWtSzMBv+O/EQ81ael7dZAihC0LRXthtOryETlweTiAkS
         DH2aJw/ZvXNL4qhZmMxzfTBgObvJekBi3YDiIepwzU6L/YSdP78qIRASJV93Q569Pzox
         sRmgew4RFWJZX/6xX2VLd/Xz4a9uLYs6K68wxhwD1AkY7GvMiK1iUl6uf6JfyhLhum2k
         cGtqOsyybEjvYG0A/ykwpXYir9j2dETQAhS4wQs88Uxdo9GYd51JEUL6VGm0nnYQIjSC
         D1udu7FcFSBC+2nZmg5t8zCFd92ZDVY2kkX2C9Kry5o0yUdiOhXkka0e/goc2V5ZwZJk
         t/Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5zlnMRG2Xz8RVeE2jai5rgez52Z3RsSPyyE68+eN4M4=;
        b=eYioruwFzhF5rLWnsYZWZCibf2pDGba/xnWFzfsLsKsyGYlQHpvfD6LU9MdRFqSNYI
         3MhIvu65nsqjW74uEJbpqdKFNgmAl5HhxwaG+d7nmCzvOz2Gw3p3AhYmbleRwXCVCrg7
         hGfS/Hqr/RC80t1WSIQ4xtNLy+/yrIWUP/txVmkWdP63yQxYvpw2KMb+qv2bWLkvQc5s
         9NQNRGa6DHtV5FKH2Q3nYYjB8vI49cQ+VU4LdWQNNk+DUux3TOWZoFShOUgMOCNuTg+l
         x6w/SyqVZRE2HQQBYmWGgAGk9bHWoMEbjJk8OTS4w08DaNNnCis+Qm4uzCgqI+xBfsZN
         o6dQ==
X-Gm-Message-State: APjAAAV1j918OLz/o9lZuH9cZgVJTIl873tKbrhJWL/QqziZKfyWm+Jk
        MdBuUs/5P0E128343vmr+fM=
X-Google-Smtp-Source: APXvYqxD5N6/KhAaiuHz+hL1cauToq0sw4RNDQAmbtbfZaCITXDv6iRnX3D7y+b0Q1sn6Z0id+p4jw==
X-Received: by 2002:a1c:1dd7:: with SMTP id d206mr11688067wmd.5.1576228027062;
        Fri, 13 Dec 2019 01:07:07 -0800 (PST)
Received: from linux-691t.suse.de ([124.11.22.254])
        by smtp.gmail.com with ESMTPSA id y6sm9079094wrl.17.2019.12.13.01.06.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Dec 2019 01:07:06 -0800 (PST)
From:   "Lee, Chun-Yi" <joeyli.kernel@gmail.com>
X-Google-Original-From: "Lee, Chun-Yi" <jlee@suse.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        David Howells <dhowells@redhat.com>,
        Josh Boyer <jwboyer@fedoraproject.org>,
        Nayna Jain <nayna@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-efi@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, "Lee, Chun-Yi" <jlee@suse.com>
Subject: [PATCH 1/2 v2] efi: add a function to convert the status code to a string
Date:   Fri, 13 Dec 2019 17:06:45 +0800
Message-Id: <20191213090646.12329-2-jlee@suse.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191213090646.12329-1-jlee@suse.com>
References: <20191213090646.12329-1-jlee@suse.com>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

This function can be used to convert EFI status code to a string
to improve the readability of log.

v2:
Moved the convert function to efi.c

Signed-off-by: "Lee, Chun-Yi" <jlee@suse.com>
---
 drivers/firmware/efi/efi.c | 32 ++++++++++++++++++++++++++++++++
 include/linux/efi.h        |  1 +
 2 files changed, 33 insertions(+)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index e98bbf8e56d9..8bdc1c17eb5d 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -954,6 +954,38 @@ int efi_status_to_err(efi_status_t status)
 	return err;
 }
 
+#define EFI_STATUS_STR(_status) \
+	EFI_##_status : return "EFI_" __stringify(_status)
+
+const char *efi_status_to_str(efi_status_t status)
+{
+	switch (status) {
+	case EFI_STATUS_STR(SUCCESS);
+	case EFI_STATUS_STR(LOAD_ERROR);
+	case EFI_STATUS_STR(INVALID_PARAMETER);
+	case EFI_STATUS_STR(UNSUPPORTED);
+	case EFI_STATUS_STR(BAD_BUFFER_SIZE);
+	case EFI_STATUS_STR(BUFFER_TOO_SMALL);
+	case EFI_STATUS_STR(NOT_READY);
+	case EFI_STATUS_STR(DEVICE_ERROR);
+	case EFI_STATUS_STR(WRITE_PROTECTED);
+	case EFI_STATUS_STR(OUT_OF_RESOURCES);
+	case EFI_STATUS_STR(NOT_FOUND);
+	case EFI_STATUS_STR(ABORTED);
+	case EFI_STATUS_STR(SECURITY_VIOLATION);
+	}
+	/*
+	 * There are two possibilities for this message to be exposed:
+	 * - Caller feeds a unknown status code from firmware.
+	 * - A new status code be defined in efi.h but we forgot to update
+	 *   this function.
+	 */
+	pr_warn("Unknown efi status: 0x%lx\n", status);
+
+	return "Unknown efi status";
+}
+EXPORT_SYMBOL(efi_status_to_str);
+
 static DEFINE_SPINLOCK(efi_mem_reserve_persistent_lock);
 static struct linux_efi_memreserve *efi_memreserve_root __ro_after_init;
 
diff --git a/include/linux/efi.h b/include/linux/efi.h
index d87acf62958e..2c6848d2b112 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1228,6 +1228,7 @@ efi_capsule_pending(int *reset_type)
 #endif
 
 extern int efi_status_to_err(efi_status_t status);
+extern const char *efi_status_to_str(efi_status_t status);
 
 /*
  * Variable Attributes
-- 
2.16.4

