Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 382E61E698B
	for <lists+linux-efi@lfdr.de>; Thu, 28 May 2020 20:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405991AbgE1SiV (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 28 May 2020 14:38:21 -0400
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:34156 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405988AbgE1SiN (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 28 May 2020 14:38:13 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id 49XxKJ0zWCz9vcjD
        for <linux-efi@vger.kernel.org>; Thu, 28 May 2020 18:38:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 2ktkw4YzTFAN for <linux-efi@vger.kernel.org>;
        Thu, 28 May 2020 13:38:12 -0500 (CDT)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id 49XxKH6MVSz9vcjM
        for <linux-efi@vger.kernel.org>; Thu, 28 May 2020 13:38:11 -0500 (CDT)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p5.oit.umn.edu 49XxKH6MVSz9vcjM
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p5.oit.umn.edu 49XxKH6MVSz9vcjM
Received: by mail-il1-f197.google.com with SMTP id x2so70222ill.13
        for <linux-efi@vger.kernel.org>; Thu, 28 May 2020 11:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=c1TTnDVto3wkCZeSMQka6W/DEVeWf5sl9QQWLQgXN9k=;
        b=drHw+/cEwBVwGldaRHVnRcYHMf95jXEAagHcGST8WG3PdUnHW1OZewz7BMmxvxp1yM
         Z0GjkBUrfOsTgT2qlIAVhGJnWCVDcu8fCcQpQoidDCITqaPGR/++9h81+sxomz5OmWSs
         ht8U30P2CTMSiK/nwR9qcjh9fbnZCweqrOgTo4bwLQ/aG8J3Fx/M6zLXUy1XvC6TWGST
         GvTAjWKuX51Yndju7P1KyJyY3SHZCdcOuucCvCdnC5ujqYXVpizHwkoxFpXGsyNlMSww
         GK0EOCUIkua4jFO3v4tUENgH3Wk0kJv2L1Jyofk5chHTgESNo/UYB7qxcryS1PcRJZ51
         wiiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=c1TTnDVto3wkCZeSMQka6W/DEVeWf5sl9QQWLQgXN9k=;
        b=Vh7H8wg900PU4dY7wVyUZn3XhdglvxJuCw4tP/99my0ptvk7+ImTL+bH49RXfqBjRM
         ifh6cduV+rFShdo2YLbRI98erNzncEX/6ddo7nIEwiddzjUVTsoypJUjau+C9uKkOl83
         RXioqlYzhJgdEwqn6zMvtoYF6s+DYioQi8KI0T30u8fBDX9d086VVCgP2vkktOotaUan
         OUlbo96LQNsmAFiXtfnigeR8QNQwxOK6NtsimJAQHHzbL7381dbhILY7m/IkiglWHC3L
         NUkt5MtVzxqWIpY94D30pCYgXb0qFXmFmX+cnOYDmhGxk/KUWgyv5Ix8pMJ22cG4UM2n
         Ve8A==
X-Gm-Message-State: AOAM533xAirCnTCJuLY3EFcOK2mtKiB122Ro1dbiLChyiTt/awOtDApL
        +WHh0dVddbTAOttO+u+H0XRAqUpvH/daO5rZrFD3PfuzN0Szmx5v84uUGCH6mxJT8Cqs7OiM/W5
        OhNfga1R0RbverYA4BdoYO3SI
X-Received: by 2002:a05:6e02:13e2:: with SMTP id w2mr4148970ilj.264.1590691090659;
        Thu, 28 May 2020 11:38:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzVPW9yLSepCvAllSlkGigtULfsb2Nh6cdvsTpPFGOt+J3pcMQEfAYp4Vvxp0BCM63yq1AvpA==
X-Received: by 2002:a05:6e02:13e2:: with SMTP id w2mr4148945ilj.264.1590691090336;
        Thu, 28 May 2020 11:38:10 -0700 (PDT)
Received: from qiushi.dtc.umn.edu (cs-kh5248-02-umh.cs.umn.edu. [128.101.106.4])
        by smtp.gmail.com with ESMTPSA id i13sm3701456ill.65.2020.05.28.11.38.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 11:38:09 -0700 (PDT)
From:   wu000273@umn.edu
To:     kjlu@umn.edu
Cc:     wu000273@umn.edu, Ard Biesheuvel <ardb@kernel.org>,
        Peter Jones <pjones@redhat.com>,
        Matt Fleming <matt.fleming@intel.com>,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] efi/esrt: Fix reference count leak in esre_create_sysfs_entry.
Date:   Thu, 28 May 2020 13:38:04 -0500
Message-Id: <20200528183804.4497-1-wu000273@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Qiushi Wu <wu000273@umn.edu>

kobject_init_and_add() takes reference even when it fails.
If this function returns an error, kobject_put() must be called to
properly clean up the memory associated with the object. Previous
commit "b8eb718348b8" fixed a similar problem.

Fixes: 0bb549052d33 ("efi: Add esrt support")
Signed-off-by: Qiushi Wu <wu000273@umn.edu>
---
 drivers/firmware/efi/esrt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/esrt.c b/drivers/firmware/efi/esrt.c
index e3d692696583..d5915272141f 100644
--- a/drivers/firmware/efi/esrt.c
+++ b/drivers/firmware/efi/esrt.c
@@ -181,7 +181,7 @@ static int esre_create_sysfs_entry(void *esre, int entry_num)
 		rc = kobject_init_and_add(&entry->kobj, &esre1_ktype, NULL,
 					  "entry%d", entry_num);
 		if (rc) {
-			kfree(entry);
+			kobject_put(&entry->kobj);
 			return rc;
 		}
 	}
-- 
2.17.1

