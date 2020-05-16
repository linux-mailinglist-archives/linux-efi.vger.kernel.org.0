Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9D081D6125
	for <lists+linux-efi@lfdr.de>; Sat, 16 May 2020 14:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbgEPM7z (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 16 May 2020 08:59:55 -0400
Received: from mout02.posteo.de ([185.67.36.66]:51689 "EHLO mout02.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726219AbgEPM7y (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sat, 16 May 2020 08:59:54 -0400
Received: from submission (posteo.de [89.146.220.130]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 4B1422400FD
        for <linux-efi@vger.kernel.org>; Sat, 16 May 2020 14:59:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1589633992; bh=9piRR8kN2zSd0xNtdI/xYxaqCZDooh4Pp8qoD8MP5Os=;
        h=From:To:Cc:Subject:Date:From;
        b=sHsn31OSJvGn8l3giYEJDS/9lr+uE7kZjyaV7DD5WFNxSGfRaAPq5FXgTYX389Dji
         dpg0V5DDaU8OmpwyJry0gCLMUpCDMUCVZBuCBb3IPftR83OII412ZSjGrOXGCxFFxB
         uoTpzVakexgvK2DzBb/MOocWX+x8nfNe7k5dclS+fj2v4bCfqz+cc8o6Nfcg2xz5af
         p7NzgQy/7WkBLygWaXvsr+Edd9TEMG5GbegfazOj+rrZxbS16fla1ZnC1LEIuX881F
         faQK8zeDR6QPaO3G15FmCHmNTPwflNO2MRBG8AV51w72jWSyOs+EYgh4TLevtkIJFO
         ds8saYoKKMtbg==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 49PQNR60NQz9rxf;
        Sat, 16 May 2020 14:59:51 +0200 (CEST)
From:   Benjamin Thiel <b.thiel@posteo.de>
To:     linux-efi@vger.kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Benjamin Thiel <b.thiel@posteo.de>
Subject: [PATCH] efi: Pull up arch-specific prototype efi_systab_show_arch()
Date:   Sat, 16 May 2020 14:59:48 +0200
Message-Id: <20200516125948.3459-1-b.thiel@posteo.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

... in order to fix a -Wmissing-prototypes warning:

arch/x86/platform/efi/efi.c:957:7: warning: no previous prototype for
‘efi_systab_show_arch’ [-Wmissing-prototypes]
char *efi_systab_show_arch(char *str)

Signed-off-by: Benjamin Thiel <b.thiel@posteo.de>
---
 drivers/firmware/efi/efi.c | 7 ++-----
 include/linux/efi.h        | 4 ++++
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 911a2bd0f6b7..d3e7ce6f1027 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -130,11 +130,8 @@ static ssize_t systab_show(struct kobject *kobj,
 	if (efi.smbios != EFI_INVALID_TABLE_ADDR)
 		str += sprintf(str, "SMBIOS=0x%lx\n", efi.smbios);
 
-	if (IS_ENABLED(CONFIG_IA64) || IS_ENABLED(CONFIG_X86)) {
-		extern char *efi_systab_show_arch(char *str);
-
+	if (IS_ENABLED(CONFIG_IA64) || IS_ENABLED(CONFIG_X86))
 		str = efi_systab_show_arch(str);
-	}
 
 	return str - buf;
 }
@@ -1012,4 +1009,4 @@ static int __init register_update_efi_random_seed(void)
 	return register_reboot_notifier(&efi_random_seed_nb);
 }
 late_initcall(register_update_efi_random_seed);
-#endif
+#endifefi_systab_show_arch
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 251f1f783cdf..e47dae8c8d5f 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1245,4 +1245,8 @@ struct linux_efi_memreserve {
 
 void __init efi_arch_mem_reserve(phys_addr_t addr, u64 size);
 
+#if defined(CONFIG_IA64) || defined(CONFIG_X86)
+extern char *efi_systab_show_arch(char *str);
+#endif
+
 #endif /* _LINUX_EFI_H */
-- 
2.20.1

