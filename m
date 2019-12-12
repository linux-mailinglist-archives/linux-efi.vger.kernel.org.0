Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5F8F11C95D
	for <lists+linux-efi@lfdr.de>; Thu, 12 Dec 2019 10:39:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728503AbfLLJia (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 12 Dec 2019 04:38:30 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38034 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728501AbfLLJia (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 12 Dec 2019 04:38:30 -0500
Received: by mail-wm1-f65.google.com with SMTP id p17so1697200wmi.3;
        Thu, 12 Dec 2019 01:38:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vG57Kuf3pSbWVOwsmxHL99j6Lgk8c1t98uCSolv4vBY=;
        b=aG/ggsb+9rAPBe/tSEdowA1xQqx18aYDlDROOtTEjg4OtF6f3rOa9Ym3VCiCdwz2ef
         TyIZyGJ7RLr0R7t97Syy5kbIIzTUf7j3xeTSzm0nebAT4qRjgpAWLTLbra8KGdADmu1M
         rjSpJyZB0wCFdBBPB2ATCxOmqT1vsasaU4I/JNBfVIFPguob5UMTWKJR8DDnFI2tx9DG
         91hORI0/fOe/7y5mfJUogSvK7ZoE0aLvCmq7IpH8oXweRhZOxqJQG7ZVwewip3pZ5RrK
         aAA1VUd0tNtQEmDN1Kv7qVWHiROYjVDtV4b+5kJXCVjvqurU96k1g4Rc0udgsPVz+141
         KsxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vG57Kuf3pSbWVOwsmxHL99j6Lgk8c1t98uCSolv4vBY=;
        b=acIeUG8vKjqzODOv9IA8C0ik+IkQBqykVPx/0yKjA23cVwzHNuAyCybNNVvEjHzxJH
         ldiqsAAelmc+VlnVf/CV8Pr4w6NGRxGSmVPoN1SE2wysm4FkCckvHbUP5z39st+8M8q+
         JxavjUU4nS6BermkE6sFL5yak/ewNjGrICY5wGYbIBYUe40L1af60CjbzwoXFf9DIp3A
         LkQyB48MYoOWTyCtWhRol6kNbzHtF+CXavs0lMI99hh3VF+39GGSGw85ZNwGoCHUCtDR
         0D0aAACKmSq/rkughQByX4I2rDF3AWbhPvJOhn8prqDVmHbCTLYD4pmLafxuLVMQCcFB
         Zg3Q==
X-Gm-Message-State: APjAAAXH8rQUIvxvI66KSWbmhM2dVDSgrZC3GopeQiP6ahBKDzD7Y0zK
        yiJZgJ0PxAClAiHfjL+sptw=
X-Google-Smtp-Source: APXvYqwLDb+l30V/1iZNd89lIDmqGBqTOCiHxXD83bqzQ52GzAg5J93583tp3e2DcaYl+py1p9xdxA==
X-Received: by 2002:a1c:1941:: with SMTP id 62mr1705929wmz.111.1576143508263;
        Thu, 12 Dec 2019 01:38:28 -0800 (PST)
Received: from linux-691t.suse.de ([124.11.22.254])
        by smtp.gmail.com with ESMTPSA id z8sm5471508wrq.22.2019.12.12.01.38.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Dec 2019 01:38:27 -0800 (PST)
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
Subject: [PATCH 1/2] efi: add a function for transferring status to string
Date:   Thu, 12 Dec 2019 17:38:11 +0800
Message-Id: <20191212093812.10518-2-jlee@suse.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191212093812.10518-1-jlee@suse.com>
References: <20191212093812.10518-1-jlee@suse.com>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

This function can be used to transfer EFI status code to string
to improve the readability of debug log.

Signed-off-by: "Lee, Chun-Yi" <jlee@suse.com>
---
 include/linux/efi.h | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/include/linux/efi.h b/include/linux/efi.h
index d87acf62958e..08daf4cdd807 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -42,6 +42,32 @@
 #define EFI_ABORTED		(21 | (1UL << (BITS_PER_LONG-1)))
 #define EFI_SECURITY_VIOLATION	(26 | (1UL << (BITS_PER_LONG-1)))
 
+#define EFI_STATUS_STR(_status) \
+	case EFI_##_status: \
+		return "EFI_" __stringify(_status);
+
+static inline char *
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
+	}
+
+	return "";
+}
+
 typedef unsigned long efi_status_t;
 typedef u8 efi_bool_t;
 typedef u16 efi_char16_t;		/* UNICODE character */
-- 
2.16.4

