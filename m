Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 980472E175
	for <lists+linux-efi@lfdr.de>; Wed, 29 May 2019 17:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726162AbfE2Pqp (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 29 May 2019 11:46:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35568 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725914AbfE2Pqp (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 29 May 2019 11:46:45 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A5A4F30B46F1;
        Wed, 29 May 2019 15:46:40 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-112-29.ams2.redhat.com [10.36.112.29])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CBC86600C4;
        Wed, 29 May 2019 15:46:37 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        dri-devel@lists.freedesktop.org, Peter Jones <pjones@redhat.com>,
        linux-efi@vger.kernel.org, linux-fbdev@vger.kernel.org
Subject: [PATCH] efifb: BGRT: Add check for new BGRT status field rotation bits
Date:   Wed, 29 May 2019 17:46:35 +0200
Message-Id: <20190529154635.2659-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Wed, 29 May 2019 15:46:45 +0000 (UTC)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Starting with ACPI 6.2 bits 1 and 2 of the BGRT status field are no longer
reserved. These bits are now used to indicate if the image needs to be
rotated before being displayed.

The efifb code does not support rotating the image before copying it to
the screen.

This commit adds a check for these new bits and if they are set leaves the
fb contents as is instead of trying to use the un-rotated BGRT image.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/video/fbdev/efifb.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/video/fbdev/efifb.c b/drivers/video/fbdev/efifb.c
index 9f39f0c360e0..dfa8dd47d19d 100644
--- a/drivers/video/fbdev/efifb.c
+++ b/drivers/video/fbdev/efifb.c
@@ -169,6 +169,11 @@ static void efifb_show_boot_graphics(struct fb_info *info)
 		return;
 	}
 
+	if (bgrt_tab.status & 0x06) {
+		pr_info("efifb: BGRT rotation bits set, not showing boot graphics\n");
+		return;
+	}
+
 	/* Avoid flashing the logo if we're going to print std probe messages */
 	if (console_loglevel > CONSOLE_LOGLEVEL_QUIET)
 		return;
-- 
2.21.0

