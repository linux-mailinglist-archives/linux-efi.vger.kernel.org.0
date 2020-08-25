Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 324A3251CE8
	for <lists+linux-efi@lfdr.de>; Tue, 25 Aug 2020 18:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbgHYQH2 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 25 Aug 2020 12:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725998AbgHYQH1 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 25 Aug 2020 12:07:27 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8546CC061574;
        Tue, 25 Aug 2020 09:07:26 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id nv17so1491432pjb.3;
        Tue, 25 Aug 2020 09:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=xb8JRPhTQOB4CzrTUKbst+Vn0iZLum3gGtW/o6gt4qs=;
        b=K7y1eXb78X/E7j32HXRZHkHEUNPCetGsgmDvlb2i1RwcQVdYFwCjuM5DBQI1CN/urA
         9DmvxKtJAq7PgmWJ4ANvD88sQzmGD2Su9D3sUckX7NYbYBQs6TDwsv6tUKYp0D3awZa4
         K/Pv42cUWk/alMtTJd0jNkoSEuurI58lpZNfDmFnOGvqkiE2G3apm1yV7FRBHFbgF75T
         sL0goXQiI7J6OGt8ftXQpLDZmGQsbwZQI0YKvYsg8igCU1XXSqRr2xn7tLtTLsohnlQA
         7tQ1/n/8whI6Z/5xQ5nphOMPLyRaDgU37mfwNUKPbPPbcVzgrdHu8ppc6ZDSFtW6iTmM
         5Jsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xb8JRPhTQOB4CzrTUKbst+Vn0iZLum3gGtW/o6gt4qs=;
        b=qqmTAwhoyA60EjJ9fEn/S++43B8WWRVmX701Or4pVRgSgU518b0iQ0dE/WKd/R5k4O
         JEbqW6MCMKHCtd67L4f6iC8Sw/mzxwg5PpzFhYCyv8/Ub5S16yV4Hq+n3st01I7Zmjmr
         +BzW32O7Dz9WghohqzLPWiJmvtse34Fa9kL5zxZvnNtWmtr0e8bOzxdVTnCwwdNQxZEc
         BY6/ZSDKq2CAqCpDgNupmOwGIRkruMjsoXmcGyGWaVZpMhlehLnmtKqjBmsWLx83WMHd
         N8DNxVa3K+rlGnbqtqozIr0S8lT28Dvexdjmz+GlzqyzTHbfpkQ8lp0ejiynTDaPDlbO
         SV7A==
X-Gm-Message-State: AOAM532o+uYbW24ymgZ5QQ3iSId5HeLVZmt/Ag9obZ/SvI01cs10dwYZ
        vEmMSNEOVjrQ1roTSiD4nMKdC1WWt8s=
X-Google-Smtp-Source: ABdhPJy+M5osUP+KInk6omFaMIirmtBOHzdY0MVCSu5pa33jwU4rU0r8DHsWhkK8vwB0ZuGFH5Lz/w==
X-Received: by 2002:a17:90a:cf8a:: with SMTP id i10mr2178608pju.140.1598371646153;
        Tue, 25 Aug 2020 09:07:26 -0700 (PDT)
Received: from linux-691t.suse.de ([124.11.22.254])
        by smtp.gmail.com with ESMTPSA id a7sm15422480pfd.194.2020.08.25.09.07.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Aug 2020 09:07:25 -0700 (PDT)
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
Date:   Wed, 26 Aug 2020 00:07:19 +0800
Message-Id: <20200825160719.7188-1-jlee@suse.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

This patch creates efivars mount point when active efivars abstraction
be set. It is useful for userland to determine the availability of efivars
filesystem.

v2:
Using efivars_kobject() helper instead of checking GetVariable or
GetNextVariable EFI runtime services. Because the efivarfs code could be
instantiated using a different efivars abstraction.

Cc: Matthias Brugger <mbrugger@suse.com>
Cc: Fabian Vogt <fvogt@suse.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: "Lee, Chun-Yi" <jlee@suse.com>
---
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

