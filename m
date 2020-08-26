Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 248472524CD
	for <lists+linux-efi@lfdr.de>; Wed, 26 Aug 2020 02:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726611AbgHZAqN (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 25 Aug 2020 20:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726570AbgHZAqM (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 25 Aug 2020 20:46:12 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDDB1C061574;
        Tue, 25 Aug 2020 17:46:12 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id w186so173858pgb.8;
        Tue, 25 Aug 2020 17:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=tYkmP2T+taGzQPsdNtmk2OPLPT6ITCwubwhEvkJJlCk=;
        b=GGCI67e+oEId6snat38qMmRD/cojMw+wU62EvwvFdd0q3is7kDXAaVI72o2D2BgLcg
         WrFBmzhN+Xs57YQPxevp7oGA6ZvYp5MsCxsnsOzC/DS9LaaYCj9Gag50gOggeQeF1BvU
         LvjCgOzTTFsdPIy6a3fSWpjzW5K1mqQauP/+P+93ZeIwRUt9wnr0nIEvnSp5NvldFFXI
         gSyL5jlwp4Pi1YoCFt1xc/1A9VRfNVUXL6E97gifx9rFCjHRvv6jwA34q/2gLCj7XRF0
         5+AlZPMWPOka9YqAjK4ersPfW+rlKqLTycYryUzFAbwCGB04MUuG471+7RqdNe/rOLKJ
         rTOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tYkmP2T+taGzQPsdNtmk2OPLPT6ITCwubwhEvkJJlCk=;
        b=JTLRHycZ6fR4524ilioNhdHTMMLhqYGQjAnsVUMWe9I25aH9XNX1lc2YKc1hobMK9P
         W+tOWk7NQrRywcqWWYigYZdsSxTFHGgBUxbcrp+568VCGrShZ6FA9H9/zYA0r/TYV71Y
         /9RTNU6cNlDH2KYTt8gx3Ztw4UroCGQ8vZbUjzIi+4346cVIyQRTvMlsbMQqWQT4cPU1
         kSlb7QT27bnpjg5ENPQ4+tcfGLUsjODfmbd4rcPEmz+k5ZTZKxpcUParTnh20Pf8yCiI
         5kx41q11RgOJQRobaMh0buqnL7xVR4RHVV7Nfeskx7GAW3aIk6l/eMq/8jw5vsRM0Vyd
         DIyQ==
X-Gm-Message-State: AOAM530xHJtXbD53LM0JBHBo4ubyvYqdPT0sMZl0u68VYkM1sSAK4tNv
        xn4f/evbXdW3CVr3X1jRDzFeEajF/mQ=
X-Google-Smtp-Source: ABdhPJwrkfHpS2LCPLcl2zwqpbRRX0x+ND+JnKe6KIxu6P4VzxGh1LKiTQleevwGOAEAH/WWCZtYTg==
X-Received: by 2002:a63:511a:: with SMTP id f26mr8721575pgb.15.1598402772496;
        Tue, 25 Aug 2020 17:46:12 -0700 (PDT)
Received: from linux-691t.suse.de ([124.11.22.254])
        by smtp.gmail.com with ESMTPSA id x4sm454044pff.112.2020.08.25.17.46.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Aug 2020 17:46:11 -0700 (PDT)
From:   "Lee, Chun-Yi" <joeyli.kernel@gmail.com>
X-Google-Original-From: "Lee, Chun-Yi" <jlee@suse.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Lee, Chun-Yi" <jlee@suse.com>,
        Matthias Brugger <mbrugger@suse.com>,
        Fabian Vogt <fvogt@suse.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH v2] efi/efivars: Create efivars mount point via efivars abstraction
Date:   Wed, 26 Aug 2020 08:46:07 +0800
Message-Id: <20200826004607.7483-1-jlee@suse.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

This patch creates efivars mount point when active efivars abstraction
be set. It is useful for userland to determine the availability of efivars
filesystem.

Cc: Matthias Brugger <mbrugger@suse.com>
Cc: Fabian Vogt <fvogt@suse.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: "Lee, Chun-Yi" <jlee@suse.com>
---

v2:
Using efivars_kobject() helper instead of checking GetVariable or
GetNextVariable EFI runtime services. Because the efivarfs code could be
instantiated using a different efivars abstraction.

 drivers/firmware/efi/efi.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 3aa07c3b5136..db483fc68501 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -405,11 +405,13 @@ static int __init efisubsys_init(void)
 	if (error)
 		goto err_remove_group;
 
-	/* and the standard mountpoint for efivarfs */
-	error = sysfs_create_mount_point(efi_kobj, "efivars");
-	if (error) {
-		pr_err("efivars: Subsystem registration failed.\n");
-		goto err_remove_group;
+	if (efivars_kobject()) {
+		/* and the standard mountpoint for efivarfs */
+		error = sysfs_create_mount_point(efi_kobj, "efivars");
+		if (error) {
+			pr_err("efivars: Subsystem registration failed.\n");
+			goto err_remove_group;
+		}
 	}
 
 	if (efi_enabled(EFI_DBG) && efi_enabled(EFI_PRESERVE_BS_REGIONS))
-- 
2.16.4

