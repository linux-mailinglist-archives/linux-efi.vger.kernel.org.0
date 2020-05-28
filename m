Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 416281E69E7
	for <lists+linux-efi@lfdr.de>; Thu, 28 May 2020 20:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406087AbgE1S7c (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 28 May 2020 14:59:32 -0400
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:43238 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406029AbgE1S7b (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 28 May 2020 14:59:31 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id 49Xxnt6gsFz9vmXH
        for <linux-efi@vger.kernel.org>; Thu, 28 May 2020 18:59:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id AOKsdN58yzjB for <linux-efi@vger.kernel.org>;
        Thu, 28 May 2020 13:59:30 -0500 (CDT)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id 49Xxnt1pRDz9vbL8
        for <linux-efi@vger.kernel.org>; Thu, 28 May 2020 13:59:30 -0500 (CDT)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p6.oit.umn.edu 49Xxnt1pRDz9vbL8
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p6.oit.umn.edu 49Xxnt1pRDz9vbL8
Received: by mail-il1-f200.google.com with SMTP id v87so85307ill.23
        for <linux-efi@vger.kernel.org>; Thu, 28 May 2020 11:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=tF8KjEwM7qOsnpMJACsTFh8FYnS65ml6lSyUkpw2tX8=;
        b=cTkpeQijh/9oBDoILx1cIMvg79Suuum297Aw8r+SIb7zzsBq4CU9niqxs/bsBCkria
         osUlSj8/XHhOqMXqKpA0HugUmg0DvLj/oG4HhFzCxXdlmGwKqJj54GvOC2IM5ciOsixj
         miL2NF2bm8whvJjBDQLDt+aFOScETpadZRPI5dVzIcRcIoIg25EYn/U2bhwiaAk0kMst
         p4Q4GSEd2bfA00SErtdToxJPxUM/F0YalB+7gFt5iAEDxN+EbLeBuNzojQv7xXPgeWvj
         WMpAne+gMpeKs6vsQUnrcjD2nVt7nzTun6iWAwUxuVWCFReaodwovEGwRHc3xvTAuY/7
         yQvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tF8KjEwM7qOsnpMJACsTFh8FYnS65ml6lSyUkpw2tX8=;
        b=MycOQV1nomm5csA13UNPLvsgu3QI00yngt1DOVpXFNVrWeWYIcwh09JBlnwEjWvl9P
         s7MUuT3xc/7cKDGq5WHutZbEYkYSCc6d3V7IF1Usucu3XZUUwCzUYrxWjPwDJaHC0KAQ
         wC4URHIr7nrPymvGhAa0w3S7eWK6VnP+vsxWl3ks7vh+FNfwS6omYU+jz6ej88fr+mAy
         sikRg3MTann0t8epykFLvAtFP2AqoNHx8OiHVh0bNFPAKWkeG/hk8Mgt19Hl3UDRQiqs
         jB+RgqlJF3M8TXlcHi4Axew4oCzesdYpm3nQSSb8ypzAUmNur4zz/bUapKCsbWRGCtZF
         +3Hg==
X-Gm-Message-State: AOAM5337JGatc5oeiH+P8dy7h5a3pgUwLkwL2HNxInAph8zcWvLlMhLL
        CWYv8SNOODgxvw19io+TaIX/0QdOnWSixFwJZE2FOJC71R/5prXzDd4HibCxk0KlsI2473/hGYs
        mAMfHr5L+TSCZ55OfE4aFJmQg
X-Received: by 2002:a05:6e02:13e3:: with SMTP id w3mr3760084ilj.62.1590692369625;
        Thu, 28 May 2020 11:59:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz1uoxU/j/spP4+apoVYeAYuLtLYSU/vnoV6LEnwUItWktUyDEabkqGqAgjdbuQ8iNSIEcCvg==
X-Received: by 2002:a05:6e02:13e3:: with SMTP id w3mr3760062ilj.62.1590692369270;
        Thu, 28 May 2020 11:59:29 -0700 (PDT)
Received: from qiushi.dtc.umn.edu (cs-kh5248-02-umh.cs.umn.edu. [128.101.106.4])
        by smtp.gmail.com with ESMTPSA id t22sm2806202iom.49.2020.05.28.11.59.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 11:59:28 -0700 (PDT)
From:   wu000273@umn.edu
To:     kjlu@umn.edu
Cc:     wu000273@umn.edu, Ard Biesheuvel <ardb@kernel.org>,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] efi: Fix reference count leak in efivar_create_sysfs_entry.
Date:   Thu, 28 May 2020 13:59:19 -0500
Message-Id: <20200528185920.7314-1-wu000273@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Qiushi Wu <wu000273@umn.edu>

kobject_init_and_add() should be handled when it return an error,
because kobject_init_and_add() takes reference even when it fails.
If this function returns an error, kobject_put() must be called to
properly clean up the memory associated with the object. Previous
commit "b8eb718348b8" fixed a similar problem.

Signed-off-by: Qiushi Wu <wu000273@umn.edu>
---
 drivers/firmware/efi/efivars.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/efivars.c b/drivers/firmware/efi/efivars.c
index 78ad1ba8c987..26528a46d99e 100644
--- a/drivers/firmware/efi/efivars.c
+++ b/drivers/firmware/efi/efivars.c
@@ -522,8 +522,10 @@ efivar_create_sysfs_entry(struct efivar_entry *new_var)
 	ret = kobject_init_and_add(&new_var->kobj, &efivar_ktype,
 				   NULL, "%s", short_name);
 	kfree(short_name);
-	if (ret)
+	if (ret) {
+		kobject_put(&new_var->kobj);
 		return ret;
+	}
 
 	kobject_uevent(&new_var->kobj, KOBJ_ADD);
 	if (efivar_entry_add(new_var, &efivar_sysfs_list)) {
-- 
2.17.1

