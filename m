Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A15D6BDEA5
	for <lists+linux-efi@lfdr.de>; Wed, 25 Sep 2019 15:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405965AbfIYNMq (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 25 Sep 2019 09:12:46 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:48856 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405921AbfIYNMq (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 25 Sep 2019 09:12:46 -0400
Received: from [167.98.27.226] (helo=rainbowdash.codethink.co.uk)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1iD764-00071e-EH; Wed, 25 Sep 2019 14:12:44 +0100
Received: from ben by rainbowdash.codethink.co.uk with local (Exim 4.92.2)
        (envelope-from <ben@rainbowdash.codethink.co.uk>)
        id 1iD764-0007H0-04; Wed, 25 Sep 2019 14:12:44 +0100
From:   Ben Dooks <ben.dooks@codethink.co.uk>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linux-kernel@lists.codethink.co.uk,
        Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH] efi: make unexported efi_rci2_sysfs_init static
Date:   Wed, 25 Sep 2019 14:12:41 +0100
Message-Id: <20190925131241.27913-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The efi_rci2_sysfs_init() is not used outside of rci2-table.c so
make it static to silence the following sparse warning:

drivers/firmware/efi/rci2-table.c:79:12: warning: symbol 'efi_rci2_sysfs_init' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 drivers/firmware/efi/rci2-table.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/rci2-table.c b/drivers/firmware/efi/rci2-table.c
index 3e290f96620a..76b0c354a027 100644
--- a/drivers/firmware/efi/rci2-table.c
+++ b/drivers/firmware/efi/rci2-table.c
@@ -76,7 +76,7 @@ static u16 checksum(void)
 	return chksum;
 }
 
-int __init efi_rci2_sysfs_init(void)
+static int __init efi_rci2_sysfs_init(void)
 {
 	struct kobject *tables_kobj;
 	int ret = -ENOMEM;
-- 
2.23.0

