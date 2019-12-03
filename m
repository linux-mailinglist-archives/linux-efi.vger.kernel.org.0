Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E46A1105C0
	for <lists+linux-efi@lfdr.de>; Tue,  3 Dec 2019 21:14:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbfLCUOl (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 3 Dec 2019 15:14:41 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:45846 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbfLCUOl (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 3 Dec 2019 15:14:41 -0500
Received: by mail-qv1-f68.google.com with SMTP id c2so2093375qvp.12;
        Tue, 03 Dec 2019 12:14:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bm5k8zQpgAmJX5WQch8jWZs9UGjvpkTxdBtgDKGujPw=;
        b=Rr8Px1+PnYNeAUdxUPfn+MJ12/5cvatkF40H/w7qFPZyM9q/+/3r9EBWgso4D6A/zS
         gMWC4aC9LCFOHmy9QqlhooMIR2KF0S3+0+TQrctIkumfx/JKcSvLob7ffgzRzauz9Pmr
         gL7lc7YHOrxDX8LGyvTHufa9nkHPBsM/A1fOZbP5SsWh23sqzFlcBMQeKq2aUpIKLb43
         KyyBTrq7BafTEzmpiDZ8Y8rIeSDmEop3wqs9VWn0l2231ClS6pPhNBuK1VZb1DMEzdZA
         g8EgjoUgPSadz49jpZYU0mQh5gOli2yqqRCzgOPz6H6d086w9swpGaQDp/xXy3DFbN1H
         AJNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bm5k8zQpgAmJX5WQch8jWZs9UGjvpkTxdBtgDKGujPw=;
        b=AwjEqZI2xr0c2A4RlJIdhpDIFSa2ANGf+y+h7EjMdqgCR9HFOG1PIPRQpNr2+b3G2E
         6OJYvxDffefdKhJhc1gCBke7FW/cjZy5+E7C2ZI1AIKGUtV3j2FT/+bFi7Rd09tzeoZe
         H9gGatCBnTlZu5AXHpcXyVsh1kXNWOEQtbfUsc0KkwUIo9eNUbu5BSYRLK4mDIHvoaCb
         LNsKgDs/0VzzxFSMO8zz0zOnHrEUpoJuqz4t9uQS1rvH3GRywA5m9OAoIWZV8TXogBBU
         ZNw53VLDNhL+XEDCFuYs3/t/vq9oWbBbVd8qFeqzYOwBzPSM6AHzbJsYjS4PNuVHSRy/
         ZjHw==
X-Gm-Message-State: APjAAAWcNRjtOEFKOL7iG40mT3waKHl7h3nXJ1aMZxKJj9BUFWYkFFFo
        UdbGe5RmNAQEtxxEQUW4cQ==
X-Google-Smtp-Source: APXvYqxG6NRh8Mwfq13GzmsRH4miOdxwm088FfOdpCEqPNeMTwLiuS9YjJADGVY5pvc3GZI5br4xMA==
X-Received: by 2002:ad4:4e34:: with SMTP id dm20mr7183818qvb.163.1575404080368;
        Tue, 03 Dec 2019 12:14:40 -0800 (PST)
Received: from gabell.cable.rcn.com (209-6-122-159.s2973.c3-0.arl-cbr1.sbo-arl.ma.cable.rcncustomer.com. [209.6.122.159])
        by smtp.gmail.com with ESMTPSA id l34sm2437104qtd.71.2019.12.03.12.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2019 12:14:39 -0800 (PST)
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-efi@vger.kernel.org
Cc:     Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        d.hatayama@fujitsu.com, Eric Biederman <ebiederm@xmission.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Subject: [PATCH v2 1/2] efi: add /proc/efi directory
Date:   Tue,  3 Dec 2019 15:14:09 -0500
Message-Id: <20191203201410.28045-2-msys.mizuma@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191203201410.28045-1-msys.mizuma@gmail.com>
References: <20191203201410.28045-1-msys.mizuma@gmail.com>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>

Add /proc/efi directory to show some efi internal information.

Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
---
 drivers/firmware/efi/efi.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index d101f072c..d8157cb34 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -325,6 +325,22 @@ static __init int efivar_ssdt_load(void)
 static inline int efivar_ssdt_load(void) { return 0; }
 #endif
 
+#ifdef CONFIG_PROC_FS
+static struct proc_dir_entry *proc_efi;
+static int __init efi_proc_init(void)
+{
+	proc_efi = proc_mkdir("efi", NULL);
+	if (!proc_efi) {
+		pr_err("/proc/efi: Cannot create /proc/efi directory.\n");
+		return 1;
+	}
+
+	return 0;
+}
+#else
+static inline int efi_proc_init(void) { return 0; }
+#endif /* CONFIG_PROC_FS */
+
 /*
  * We register the efi subsystem with the firmware subsystem and the
  * efivars subsystem with the efi subsystem, if the system was booted with
@@ -381,6 +397,12 @@ static int __init efisubsys_init(void)
 		goto err_remove_group;
 	}
 
+	error = efi_proc_init();
+	if (error) {
+		sysfs_remove_mount_point(efi_kobj, "efivars");
+		goto err_remove_group;
+	}
+
 	return 0;
 
 err_remove_group:
-- 
2.18.1

