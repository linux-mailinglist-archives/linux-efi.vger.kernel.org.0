Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 475931811CF
	for <lists+linux-efi@lfdr.de>; Wed, 11 Mar 2020 08:22:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728146AbgCKHVs (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 11 Mar 2020 03:21:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:40440 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726934AbgCKHVr (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 11 Mar 2020 03:21:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id E687FAF5B;
        Wed, 11 Mar 2020 07:21:46 +0000 (UTC)
From:   Takashi Iwai <tiwai@suse.de>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [PATCH] efi/cper: Use scnprintf() for avoiding potential buffer overflow
Date:   Wed, 11 Mar 2020 08:21:45 +0100
Message-Id: <20200311072145.5001-1-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Since snprintf() returns the would-be-output size instead of the
actual output size, the succeeding calls may go beyond the given
buffer limit.  Fix it by replacing with scnprintf().

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/firmware/efi/cper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
index b1af0de2e100..9d2512913d25 100644
--- a/drivers/firmware/efi/cper.c
+++ b/drivers/firmware/efi/cper.c
@@ -101,7 +101,7 @@ void cper_print_bits(const char *pfx, unsigned int bits,
 		if (!len)
 			len = snprintf(buf, sizeof(buf), "%s%s", pfx, str);
 		else
-			len += snprintf(buf+len, sizeof(buf)-len, ", %s", str);
+			len += scnprintf(buf+len, sizeof(buf)-len, ", %s", str);
 	}
 	if (len)
 		printk("%s\n", buf);
-- 
2.16.4

