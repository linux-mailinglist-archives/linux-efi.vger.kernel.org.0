Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C965D11208
	for <lists+linux-efi@lfdr.de>; Thu,  2 May 2019 06:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725613AbfEBEEw (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 2 May 2019 00:04:52 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42450 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbfEBEEw (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 2 May 2019 00:04:52 -0400
Received: by mail-pl1-f193.google.com with SMTP id x15so397958pln.9;
        Wed, 01 May 2019 21:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=rM4F3y1QRq9xFsJANLJ2PQUCgusKq4bJmMsIhz12PE0=;
        b=Ts+TRyYTEECnYuiapH/JiLE3aOdUcKZNWtildqgDgHamRd1VdgzSGCAWO44xInhGdj
         +mSemGh+TE4HS0enaJJsBrtkBbEcqWjz1lpnryVQHRWMubhUVwQSTmS9EEIDPhXvjgjU
         6g+o0scjwM2Wa4GBwJx9KfNyLLX34ZxZRDRKa2cvK6CWUZXFH0y6AEjV9qy3spZmahNA
         b+SQITUSMYLUc8ch/bNzxbVNjMDumR6A+WyTsRmnX8GEt5nMTj+WfPGejfq+coffthgc
         ++DUO+WcK0FirgVSRFVswobYbN0c12GGZ64G5JL7y1dbW1ZfpZpkx9vTuLSTED8o15Aa
         1gWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=rM4F3y1QRq9xFsJANLJ2PQUCgusKq4bJmMsIhz12PE0=;
        b=PIQfgCDkuK6JeaM8WapizqgQYIoEHVzR4evwt9U4hEUUPDxqCNDlSguhadEdALMLh1
         a2AQEtCa6FgXBLYjkUbo6JtMUoSf+NKSeYyODoeWeZq1F2UL1ChnjgyhTSKrCABE3PiB
         ahrglisHc/uQp0lJ321PI0qoKfi+ttaSiBSvznCX2PlZJaK3AZrUHbfpRuRpT3my1lg2
         IwW1rVUW3gofKfZ9J12BsogSYPK0P6Fk4OioyRRd30B49wpqj4hB+Rhci4mcLqPtangr
         6kuXjFbt2wZB0RQYAQ5QASeALElXZpDSBl1wlLR3efH6M5yxoLzjowDufz4iO9QMZjy0
         iNzg==
X-Gm-Message-State: APjAAAUhdwqVlMuycEHwAssfkVJPYJEbEz22/zHr4S752TayfVZcK/3G
        QUiBNFaZLmeFJi9PmEhatfc=
X-Google-Smtp-Source: APXvYqwIlSDxRSKdkfXgyWtEN1++MlQ6biUp+2bnooCkGaXvtPFj1C9E0K1kp+y/Rsm678WOZw1y7g==
X-Received: by 2002:a17:902:b28:: with SMTP id 37mr1260911plq.322.1556769891072;
        Wed, 01 May 2019 21:04:51 -0700 (PDT)
Received: from linux-l9pv.suse ([202.47.205.198])
        by smtp.gmail.com with ESMTPSA id k4sm1107687pgh.27.2019.05.01.21.04.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 01 May 2019 21:04:50 -0700 (PDT)
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
        linux-kernel@vger.kernel.org, "Lee, Chun-Yi" <jlee@suse.com>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>
Subject: [PATCH 1/2 v2] efi: add a function to convert the status value to string
Date:   Thu,  2 May 2019 12:04:39 +0800
Message-Id: <20190502040441.30372-1-jlee@suse.com>
X-Mailer: git-send-email 2.12.3
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

This function can be used to convert EFI status value to string
for printing out debug message. Using this function can improve
the readability of log.

v2.
- Changed the wording in subject and description.
- Moved the marco immediately after the status value definitions.
- Turned into a proper function instead of inline.

Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Anton Vorontsov <anton@enomsg.org>
Cc: Colin Cross <ccross@android.com>
Cc: Tony Luck <tony.luck@intel.com>
Signed-off-by: "Lee, Chun-Yi" <jlee@suse.com>
---
 include/linux/efi.h | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/include/linux/efi.h b/include/linux/efi.h
index 54357a258b35..6f3f89a32eef 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -42,6 +42,34 @@
 #define EFI_ABORTED		(21 | (1UL << (BITS_PER_LONG-1)))
 #define EFI_SECURITY_VIOLATION	(26 | (1UL << (BITS_PER_LONG-1)))
 
+#define EFI_STATUS_STR(_status) \
+case EFI_##_status: \
+	return "EFI_" __stringify(_status);
+
+static __attribute__((unused)) char *
+efi_status_to_str(unsigned long status)
+{
+	switch (status) {
+	EFI_STATUS_STR(SUCCESS)
+	EFI_STATUS_STR(LOAD_ERROR)
+	EFI_STATUS_STR(INVALID_PARAMETER)
+	EFI_STATUS_STR(UNSUPPORTED)
+	EFI_STATUS_STR(BAD_BUFFER_SIZE)
+	EFI_STATUS_STR(BUFFER_TOO_SMALL)
+	EFI_STATUS_STR(NOT_READY)
+	EFI_STATUS_STR(DEVICE_ERROR)
+	EFI_STATUS_STR(WRITE_PROTECTED)
+	EFI_STATUS_STR(OUT_OF_RESOURCES)
+	EFI_STATUS_STR(NOT_FOUND)
+	EFI_STATUS_STR(ABORTED)
+	EFI_STATUS_STR(SECURITY_VIOLATION)
+	default:
+		pr_warn("Unknown efi status: 0x%lx", status);
+	}
+
+	return "Unknown efi status";
+}
+
 typedef unsigned long efi_status_t;
 typedef u8 efi_bool_t;
 typedef u16 efi_char16_t;		/* UNICODE character */
-- 
2.16.4

