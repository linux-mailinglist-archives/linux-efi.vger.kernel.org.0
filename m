Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D9C52DE1D
	for <lists+linux-efi@lfdr.de>; Wed, 29 May 2019 15:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbfE2N2h (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 29 May 2019 09:28:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34570 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726104AbfE2N2g (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 29 May 2019 09:28:36 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C9C7963162;
        Wed, 29 May 2019 13:28:31 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-112-70.ams2.redhat.com [10.36.112.70])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 820F717B90;
        Wed, 29 May 2019 13:28:30 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-efi@vger.kernel.org
Subject: [PATCH] efi/bgrt: Drop BGRT status field reserved bits check
Date:   Wed, 29 May 2019 15:28:28 +0200
Message-Id: <20190529132828.13105-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Wed, 29 May 2019 13:28:36 +0000 (UTC)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Starting with ACPI 6.2 bits 1 and 2 of the BGRT status field are no longer
reserved. These bits are now used to indicate if the image needs to be
rotated before being displayed.

The first device using these bits has now shown up (the GPD MicroPC) and
the reserved bits check causes us to reject the valid BGRT table on this
device.

Rather then changing the reserved bits check, allowing only the 2 new bits,
instead just completely remove it so that we do not end up with a similar
problem when more bits are added in the future.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/firmware/efi/efi-bgrt.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/firmware/efi/efi-bgrt.c b/drivers/firmware/efi/efi-bgrt.c
index a2384184a7de..b07c17643210 100644
--- a/drivers/firmware/efi/efi-bgrt.c
+++ b/drivers/firmware/efi/efi-bgrt.c
@@ -47,11 +47,6 @@ void __init efi_bgrt_init(struct acpi_table_header *table)
 		       bgrt->version);
 		goto out;
 	}
-	if (bgrt->status & 0xfe) {
-		pr_notice("Ignoring BGRT: reserved status bits are non-zero %u\n",
-		       bgrt->status);
-		goto out;
-	}
 	if (bgrt->image_type != 0) {
 		pr_notice("Ignoring BGRT: invalid image type %u (expected 0)\n",
 		       bgrt->image_type);
-- 
2.21.0

