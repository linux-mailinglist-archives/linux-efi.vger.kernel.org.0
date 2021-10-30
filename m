Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9274440B0F
	for <lists+linux-efi@lfdr.de>; Sat, 30 Oct 2021 20:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232038AbhJ3SbM (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 30 Oct 2021 14:31:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:57234 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231766AbhJ3SbG (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 30 Oct 2021 14:31:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635618516;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n3Mgk88GftykavhRfevxmb2OnrvVoUttarFCvaInBLI=;
        b=VW2/MMkI/KM5QnWLq6ofpNdlxFOORhFj+TXEQgX+q7qVTGvPTb9+mALzDUr+lw5gMjo4dO
        QG3eZag3//U/Xzj2whYfZZymLe4+dZbQ12J4S/Q+0SFzrgpBbPECWb3C8AfzRuPcc2Km43
        qd4NbFOWPmR8p28kaIl5lAyNqnk/l8Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-111-rdJLY_KoMXKy1ItcgdzG4w-1; Sat, 30 Oct 2021 14:28:32 -0400
X-MC-Unique: rdJLY_KoMXKy1ItcgdzG4w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F1D248018AC;
        Sat, 30 Oct 2021 18:28:29 +0000 (UTC)
Received: from x1.localdomain (unknown [10.39.192.75])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3419C5F4E1;
        Sat, 30 Oct 2021 18:28:27 +0000 (UTC)
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
Subject: [PATCH 04/13] power: supply: bq25890: Fix initial setting of the F_CONV_RATE field
Date:   Sat, 30 Oct 2021 20:28:04 +0200
Message-Id: <20211030182813.116672-5-hdegoede@redhat.com>
In-Reply-To: <20211030182813.116672-1-hdegoede@redhat.com>
References: <20211030182813.116672-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The code doing the initial setting of the F_CONV_RATE field based
on the bq->state.online flag. In order for this to work properly,
this must be done after the initial bq25890_get_chip_state() call.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/supply/bq25890_charger.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
index 491d36a3811a..99497fdc73da 100644
--- a/drivers/power/supply/bq25890_charger.c
+++ b/drivers/power/supply/bq25890_charger.c
@@ -682,16 +682,16 @@ static int bq25890_hw_init(struct bq25890_device *bq)
 		}
 	}
 
-	/* Configure ADC for continuous conversions when charging */
-	ret = bq25890_field_write(bq, F_CONV_RATE, !!bq->state.online);
+	ret = bq25890_get_chip_state(bq, &bq->state);
 	if (ret < 0) {
-		dev_dbg(bq->dev, "Config ADC failed %d\n", ret);
+		dev_dbg(bq->dev, "Get state failed %d\n", ret);
 		return ret;
 	}
 
-	ret = bq25890_get_chip_state(bq, &bq->state);
+	/* Configure ADC for continuous conversions when charging */
+	ret = bq25890_field_write(bq, F_CONV_RATE, !!bq->state.online);
 	if (ret < 0) {
-		dev_dbg(bq->dev, "Get state failed %d\n", ret);
+		dev_dbg(bq->dev, "Config ADC failed %d\n", ret);
 		return ret;
 	}
 
-- 
2.31.1

