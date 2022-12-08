Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C7D86478A5
	for <lists+linux-efi@lfdr.de>; Thu,  8 Dec 2022 23:12:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbiLHWMM (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 8 Dec 2022 17:12:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbiLHWMC (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 8 Dec 2022 17:12:02 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA4B63A2;
        Thu,  8 Dec 2022 14:11:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670537519; x=1702073519;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=fT9SC06qYKXjgX1+neHHzXyWOTyqrcFvQQcpAYrJp80=;
  b=Yy0XwLfCQb+8JabfVdvKKykzMimJkBKgaOM7fSGck+IN3nSQfPupa6YE
   v9/5JFzVZcgHrW2krsSQDtdMs10ezIa0/f6ZC1dJJNqbiCYB9Hdp+l+X6
   oogk+Aqs2TxE/InZzQDePDU8Q53SVzfJg2NB744kFnM7AEFDddNPDPfWs
   9H4FJPloRH3gJ1vbUNLsiaVXhH8mCDKq4hHTGqcmyIsMhskuk8yJ5u415
   4z/7NsSIkOJy55OMF7oNL0dgUQuGZFtXRFJv4ZwTHk8rs13kZc/UzB3SM
   gihe0UH46PKT6HuGsHFVBsEVIEiCgW+o5ifzQb1Jug+6fHE69u50k+FFC
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10555"; a="300735866"
X-IronPort-AV: E=Sophos;i="5.96,228,1665471600"; 
   d="scan'208";a="300735866"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2022 14:11:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10555"; a="649335504"
X-IronPort-AV: E=Sophos;i="5.96,228,1665471600"; 
   d="scan'208";a="649335504"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 08 Dec 2022 14:11:55 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id D63CC179; Fri,  9 Dec 2022 00:12:23 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH v1 1/2] efi/earlycon: Replace open coded strnchrnul()
Date:   Fri,  9 Dec 2022 00:12:16 +0200
Message-Id: <20221208221217.56354-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

strnchrnul() can be called in the early stages. Replace
open coded variant in the EFI early console driver.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/firmware/efi/earlycon.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/firmware/efi/earlycon.c b/drivers/firmware/efi/earlycon.c
index 4d6c5327471a..be7c83b6cd10 100644
--- a/drivers/firmware/efi/earlycon.c
+++ b/drivers/firmware/efi/earlycon.c
@@ -10,6 +10,7 @@
 #include <linux/kernel.h>
 #include <linux/serial_core.h>
 #include <linux/screen_info.h>
+#include <linux/string.h>
 
 #include <asm/early_ioremap.h>
 
@@ -143,16 +144,10 @@ efi_earlycon_write(struct console *con, const char *str, unsigned int num)
 	len = si->lfb_linelength;
 
 	while (num) {
-		unsigned int linemax;
-		unsigned int h, count = 0;
+		unsigned int linemax = (si->lfb_width - efi_x) / font->width;
+		unsigned int h, count;
 
-		for (s = str; *s && *s != '\n'; s++) {
-			if (count == num)
-				break;
-			count++;
-		}
-
-		linemax = (si->lfb_width - efi_x) / font->width;
+		count = strnchrnul(str, num, '\n') - str;
 		if (count > linemax)
 			count = linemax;
 
-- 
2.35.1

