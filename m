Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8583C440B1B
	for <lists+linux-efi@lfdr.de>; Sat, 30 Oct 2021 20:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231936AbhJ3SbS (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 30 Oct 2021 14:31:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55310 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231462AbhJ3SbR (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 30 Oct 2021 14:31:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635618526;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y+Dng0wkC1+F0UUNHu8qdIK3Gm5IP43FdCxwyGpAGOg=;
        b=TEaBP21Mh32YsGK+ZLmYDd9kyxX+UHDS+TbWbbHMcOoTo4mT83koSJ/KQKRRVbEXVuIFGq
        mthVMACTf+d8kSfdSKbo0PbC6mkKgFzy7ZZWFEs3QFVYAfthR2yPiGdQ9u283de8IWD3w+
        4bDZ/WswxHL9oWACfeIW+0mw2RC/f+s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-279-inHHBM-PPKCA76gMm2xtcA-1; Sat, 30 Oct 2021 14:28:41 -0400
X-MC-Unique: inHHBM-PPKCA76gMm2xtcA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2C3E98018AC;
        Sat, 30 Oct 2021 18:28:39 +0000 (UTC)
Received: from x1.localdomain (unknown [10.39.192.75])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 644605F4E1;
        Sat, 30 Oct 2021 18:28:36 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andy@infradead.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Sebastian Reichel <sre@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Yauhen Kharuzhy <jekhor@gmail.com>,
        Tsuchiya Yuto <kitakar@gmail.com>,
        platform-driver-x86@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org
Subject: [PATCH 07/13] power: supply: bq25890: Enable charging on boards where we skip reset
Date:   Sat, 30 Oct 2021 20:28:07 +0200
Message-Id: <20211030182813.116672-8-hdegoede@redhat.com>
In-Reply-To: <20211030182813.116672-1-hdegoede@redhat.com>
References: <20211030182813.116672-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On boards where the "ti,skip-init" boolean property is set we don't reset
the charger; and on some boards where the fw takes care of initalizition
F_CHG_CFG is set to 0 before handing control over to the OS.

Explicitly set F_CHG_CFG to 1 on boards where we don't reset the charger,
so that charging is always enabled on these boards, like it is always
enabled on boards where we do reset the charger.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/supply/bq25890_charger.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
index 280821a6a6c6..aa4d04d20cdc 100644
--- a/drivers/power/supply/bq25890_charger.c
+++ b/drivers/power/supply/bq25890_charger.c
@@ -689,6 +689,17 @@ static int bq25890_hw_init(struct bq25890_device *bq)
 			dev_dbg(bq->dev, "Reset failed %d\n", ret);
 			return ret;
 		}
+	} else {
+		/*
+		 * Ensure charging is enabled, on some boards where the fw
+		 * takes care of initalizition F_CHG_CFG is set to 0 before
+		 * handing control over to the OS.
+		 */
+		ret = bq25890_field_write(bq, F_CHG_CFG, 1);
+		if (ret < 0) {
+			dev_dbg(bq->dev, "Enabling charging failed %d\n", ret);
+			return ret;
+		}
 	}
 
 	/* disable watchdog */
-- 
2.31.1

