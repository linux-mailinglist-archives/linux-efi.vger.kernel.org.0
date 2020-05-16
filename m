Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 167AF1D614D
	for <lists+linux-efi@lfdr.de>; Sat, 16 May 2020 15:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbgEPN0x (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 16 May 2020 09:26:53 -0400
Received: from mout01.posteo.de ([185.67.36.65]:40726 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726302AbgEPN0x (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sat, 16 May 2020 09:26:53 -0400
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 2E2FC160063
        for <linux-efi@vger.kernel.org>; Sat, 16 May 2020 15:26:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1589635611; bh=7FoIUPqDi5c7vN5iYSzxU0lEaqMlu5poIBIzZs9kdns=;
        h=From:To:Cc:Subject:Date:From;
        b=Ie7Y5iL7lih9M7oKNUt1mWFU9uGspwt7i7n3cigqUBecNbAgzE+w4bBsUQTER+YsQ
         1rRyhPW0+IcoZ2G8p/x+buEllzEdacyCUU2EKejs13DcM16I1FNGDzcCBWz00iWezF
         g/XXoQhrDkeAl7Cq1xjZ4bs4uD04msMeS+jMhMQVMzjwxJXe9Of8kfzXZzFqj4v5WN
         94Ox3gKNJSJ+H8emLlHLn/cPqX0Kf2SKcM9GanJ41+agfxrAed8WyppREF0cxGE+88
         mtVk3ilzXAyE133Nj7gLpoWI0YFOjjXqa5kp1tU11kv6yRgV1Srh53INPlRmHypfCm
         08Ew9X8DFx6EQ==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 49PQzZ4crMz9rxc;
        Sat, 16 May 2020 15:26:50 +0200 (CEST)
From:   Benjamin Thiel <b.thiel@posteo.de>
To:     linux-efi@vger.kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Benjamin Thiel <b.thiel@posteo.de>
Subject: [PATCH v2] efi: Pull up arch-specific prototype efi_systab_show_arch()
Date:   Sat, 16 May 2020 15:26:47 +0200
Message-Id: <20200516132647.14568-1-b.thiel@posteo.de>
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
 drivers/firmware/efi/efi.c | 5 +----
 include/linux/efi.h        | 2 ++
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 911a2bd0f6b7..4e3055238f31 100644
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
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 251f1f783cdf..9430d01c0c3d 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1245,4 +1245,6 @@ struct linux_efi_memreserve {
 
 void __init efi_arch_mem_reserve(phys_addr_t addr, u64 size);
 
+char *efi_systab_show_arch(char *str);
+
 #endif /* _LINUX_EFI_H */
-- 
2.20.1

