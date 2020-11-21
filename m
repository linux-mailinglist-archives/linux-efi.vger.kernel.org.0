Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 879FF2BBBF2
	for <lists+linux-efi@lfdr.de>; Sat, 21 Nov 2020 03:06:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727267AbgKUCDK (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 20 Nov 2020 21:03:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727229AbgKUCDJ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 20 Nov 2020 21:03:09 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98DE3C061A49
        for <linux-efi@vger.kernel.org>; Fri, 20 Nov 2020 18:03:08 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 4so89868ybv.11
        for <linux-efi@vger.kernel.org>; Fri, 20 Nov 2020 18:03:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=b0YvDCLNXxObE7vEHCWq6i2O13x5pj7Sk5izCVC1W1s=;
        b=XxQGXE/c0CApYTMKGirkC/NzMW9PtuZKAP0Rij3rLCyz7ACe2iRldS3XiSAccUTDuw
         VexRPSGAp19xMnrTHsfrtF5BtMzF2MZP/DburWgf71GZwW5Ml9VtBSJJoaK8B8kB98JM
         LTiTyCSzkEAb3y96o6VkCwOeqiGY+E0TeBcGhxdVHz5xYkR8krpv6j9DfBcaZSO0HmQl
         FEbM1Bmew/lG+Q9/jFkWXlzWb5h4aJ92qoVUZ5HtmlWCWprdCkzLRZTSK1CfTFcfNnXl
         ooAeFNVOj3t7IovBKQRkijeoUTKtE2F8itFINpJOY5jVFiNDziby4r2/KpPmiYobuZR1
         QVgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=b0YvDCLNXxObE7vEHCWq6i2O13x5pj7Sk5izCVC1W1s=;
        b=a3HLiEoMOiPDXe0k7YKAQhi+YaX0jbtdAUusewSIX/f2ApHcOL58DdL3LNdGErn6Uz
         H5yiYmzWXYq2TtyAqnQCBhCitmXlQlDZV93nFKjXeGnC4ymHrSomO1+4VfvDQJpV74+s
         Ic5jcyMn4x66OQP5zIaYc93M9zk9xmUjf9+OGdo27x1hvvCiArrpiOh4AxAqYxOE5odb
         v9WLfBnoMZZE9tg5blo2zkcDP4mXZ49a/Kqau2emAuOte4yzI9VBnhl0H3P5RTNVDdyf
         lUrL40yt1qr+0fRSEOQRSowm6cH+ULBe8YM9nRcya6qfV5W5kPKknaKAFZjB0IL93KD7
         kC6A==
X-Gm-Message-State: AOAM533pC4iMFh1OHrCHa+UfNbRRNSjKOIo2hnCuraHm9E57dEr54nRH
        pi+Kb65WVLPQfuY6ldRhf12UwIrrp/o52io=
X-Google-Smtp-Source: ABdhPJw7hTX1ig2DBMzM7Cg89jHEaXXOfJNgJV7mzTh9QzeRlAT0xMYvrW67/KGE2pLPBd6hd9qCI67qknxhIss=
Sender: "saravanak via sendgmr" <saravanak@saravanak.san.corp.google.com>
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:7220:84ff:fe09:fedc])
 (user=saravanak job=sendgmr) by 2002:a5b:3cd:: with SMTP id
 t13mr31630414ybp.144.1605924187829; Fri, 20 Nov 2020 18:03:07 -0800 (PST)
Date:   Fri, 20 Nov 2020 18:02:24 -0800
In-Reply-To: <20201121020232.908850-1-saravanak@google.com>
Message-Id: <20201121020232.908850-10-saravanak@google.com>
Mime-Version: 1.0
References: <20201121020232.908850-1-saravanak@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH v2 09/17] driver core: Allow only unprobed consumers for
 SYNC_STATE_ONLY device links
From:   Saravana Kannan <saravanak@google.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Saravana Kannan <saravanak@google.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        kernel-team@android.com, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

SYNC_STATE_ONLY device links only affect the behavior of sync_state()
callbacks. Specifically, they prevent sync_state() only callbacks from
being called on a device if one or more of its consumers haven't probed.

So, creating a SYNC_STATE_ONLY device link from an already probed
consumer is useless. So, don't allow creating such device links.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/base/core.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index e2b246a44d1a..215ce9e72790 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -649,6 +649,17 @@ struct device_link *device_link_add(struct device *consumer,
 		goto out;
 	}
 
+	/*
+	 * SYNC_STATE_ONLY links are useless once a consumer device has probed.
+	 * So, only create it if the consumer hasn't probed yet.
+	 */
+	if (flags & DL_FLAG_SYNC_STATE_ONLY &&
+	    consumer->links.status != DL_DEV_NO_DRIVER &&
+	    consumer->links.status != DL_DEV_PROBING) {
+		link = NULL;
+		goto out;
+	}
+
 	/*
 	 * DL_FLAG_AUTOREMOVE_SUPPLIER indicates that the link will be needed
 	 * longer than for DL_FLAG_AUTOREMOVE_CONSUMER and setting them both
-- 
2.29.2.454.gaff20da3a2-goog

