Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 207F7673F36
	for <lists+linux-efi@lfdr.de>; Thu, 19 Jan 2023 17:45:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230371AbjASQpx (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 19 Jan 2023 11:45:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbjASQpv (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 19 Jan 2023 11:45:51 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E72458975;
        Thu, 19 Jan 2023 08:45:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9A64761CDC;
        Thu, 19 Jan 2023 16:45:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2EB5C433F1;
        Thu, 19 Jan 2023 16:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674146748;
        bh=XeXJuV70b8QQ89031T2UsnyGwGhNXA27WLTobdUHe78=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QvBnUIlJA0r4hT8+uu0mSag3a39SFxvH1ekgdar6RSpWa9Cqdh0t9UVAMzwVdJ66t
         Tnujp0eswYce5xvH99u9CXa+OocodvEkvGLDQ5+w9e8R7kx3mTkMHg+BBlJTZ8Onwj
         wEhodzItoVhF/usjpg7axTNYqWXBx8EtcycfZnSUH8I208NKyRBTRU24o4T+6gcw5M
         Ny8dQ5LS0NpHnCF9yvh3DzP9ay09XeF+4AtiiQFK1lIiNOYzOd1hj1K5i+0hKUEnS8
         f/wMFhIk0q7m5ualI0qSNQA93/egjP+FTwooyePpgHQIZNFpKtKct0UkvaksxSimyr
         1vWwdU2DyIofg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1pIY3M-0007Mx-AT; Thu, 19 Jan 2023 17:46:16 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Matthew Garrett <mjg59@srcf.ucam.org>, Jeremy Kerr <jk@ozlabs.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 4/4] efi: efivars: prevent double registration
Date:   Thu, 19 Jan 2023 17:42:55 +0100
Message-Id: <20230119164255.28091-5-johan+linaro@kernel.org>
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

Add the missing sanity check to efivars_register() so that it is no
longer possible to override an already registered set of efivar ops
(without first deregistering them).

This can help debug initialisation ordering issues where drivers have so
far unknowingly been relying on overriding the generic ops.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/firmware/efi/vars.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/efi/vars.c b/drivers/firmware/efi/vars.c
index f34e7741e0c3..bd75b87f5fc1 100644
--- a/drivers/firmware/efi/vars.c
+++ b/drivers/firmware/efi/vars.c
@@ -62,18 +62,27 @@ EXPORT_SYMBOL_GPL(efivar_is_available);
 int efivars_register(struct efivars *efivars,
 		     const struct efivar_operations *ops)
 {
+	int rv;
+
 	if (down_interruptible(&efivars_lock))
 		return -EINTR;
 
+	if (__efivars) {
+		pr_warn("efivars already registered\n");
+		rv = -EBUSY;
+		goto out;
+	}
+
 	efivars->ops = ops;
 
 	__efivars = efivars;
 
 	pr_info("Registered efivars operations\n");
-
+	rv = 0;
+out:
 	up(&efivars_lock);
 
-	return 0;
+	return rv;
 }
 EXPORT_SYMBOL_GPL(efivars_register);
 
-- 
2.38.2

