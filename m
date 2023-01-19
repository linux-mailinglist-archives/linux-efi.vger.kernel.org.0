Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4672D674AD8
	for <lists+linux-efi@lfdr.de>; Fri, 20 Jan 2023 05:37:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbjATEhc (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 19 Jan 2023 23:37:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjATEhJ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 19 Jan 2023 23:37:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17D24C3829;
        Thu, 19 Jan 2023 20:34:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 697FFB82629;
        Thu, 19 Jan 2023 16:45:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0129FC433D2;
        Thu, 19 Jan 2023 16:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674146748;
        bh=Ik8KGBx4efM6Qvmj0I2GTqwFRPzmKf5LmQQLhwoAEQg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c4ZmBDSeAohseCGX28vHo4/i9s+S5U76T11M0gprfwIW+/x608C2+8ZozXffHJuz/
         o5OmXKd5qFW+7FwSWAdteoeUd++W6qWB9LTf9s0AP6mp4Eu//+neoK4HaiEymf94Qz
         SX57/vt+rn+QH0OE/3sGKVRBVX8bG4za7YwcDDrP4vAj9JIGVrbpIurXqb3NZypOeC
         Az9QTIfTIhz2en5hXFtfhgAmnuC9BpcJbNzcl+qettrPojl78TE1/jYZOXPOzDvEgF
         rFnGGNaiT1VbCO7+k/J0Lw8wiemoJBc9isH8yIyeI/d0aqOUczW1Cn3XcukUiJSFk8
         SD7OxzxPKTkig==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1pIY3M-0007Mr-2B; Thu, 19 Jan 2023 17:46:16 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Matthew Garrett <mjg59@srcf.ucam.org>, Jeremy Kerr <jk@ozlabs.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 1/4] efi: efivars: add efivars printk prefix
Date:   Thu, 19 Jan 2023 17:42:52 +0100
Message-Id: <20230119164255.28091-2-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.38.2
In-Reply-To: <20230119164255.28091-1-johan+linaro@kernel.org>
References: <20230119164255.28091-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Add an 'efivars: ' printk prefix to make the log entries stand out more,
for example:

	efivars: Registered efivars operations

While at it, change the sole remaining direct printk() call to pr_err().

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/firmware/efi/vars.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/vars.c b/drivers/firmware/efi/vars.c
index aa5ba38f81ff..f34e7741e0c3 100644
--- a/drivers/firmware/efi/vars.c
+++ b/drivers/firmware/efi/vars.c
@@ -6,6 +6,8 @@
  * Copyright (C) 2004 Intel Corporation <matthew.e.tolentino@intel.com>
  */
 
+#define pr_fmt(fmt) "efivars: " fmt
+
 #include <linux/types.h>
 #include <linux/sizes.h>
 #include <linux/errno.h>
@@ -90,7 +92,7 @@ int efivars_unregister(struct efivars *efivars)
 		return -EINTR;
 
 	if (!__efivars) {
-		printk(KERN_ERR "efivars not registered\n");
+		pr_err("efivars not registered\n");
 		rv = -EINVAL;
 		goto out;
 	}
-- 
2.38.2

