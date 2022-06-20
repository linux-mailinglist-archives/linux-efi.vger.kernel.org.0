Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 650FE551561
	for <lists+linux-efi@lfdr.de>; Mon, 20 Jun 2022 12:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239494AbiFTKIo (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 20 Jun 2022 06:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241030AbiFTKId (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 20 Jun 2022 06:08:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D77DCE58;
        Mon, 20 Jun 2022 03:08:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8BFEDB80FF2;
        Mon, 20 Jun 2022 10:08:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF7C8C3411B;
        Mon, 20 Jun 2022 10:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655719710;
        bh=LQ09WzpvAuZ+VN0WE2YryKJGLR0i8dpc70CuF8hcQcw=;
        h=From:To:Cc:Subject:Date:From;
        b=B1CVthejPAXMC9OSqvibzGcKnr6cqxrNxJzrG7Z7DkhFFfqeMykaQVhFc3hiT1hqI
         OrdeMXh7mG+mE3r/q3KkAeuLEvx4t0CzohHF90RM9VHb/JVqco1xN5BAqVDqIfXltv
         BCkRbHNBry4KG+ZCaOYI6gBQ7XIr2rQadqUHlkJc0ZbJX/2agIfDX8XvjzV6wFeN6h
         cNxxWiIuIKoaafiX1VO9DcrwNLpS/jUH0EpMAra+BSW6jhNuxlrMAskR8q1NrVqxk6
         tHtqGa5M4BIPlzJOUj++Olv1IHnrtZasrFZdOiOrofd/52eFjG4JsOuI6LmJ30MJFS
         PMm+coTzQuANg==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-media@vger.kernel.org
Cc:     linux-staging@lists.linux.dev, linux-efi@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] media: atomisp_gmin_platform: stop abusing efivar API
Date:   Mon, 20 Jun 2022 12:08:19 +0200
Message-Id: <20220620100819.1682995-1-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2741; h=from:subject; bh=LQ09WzpvAuZ+VN0WE2YryKJGLR0i8dpc70CuF8hcQcw=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBisEcSp2/w5oaMdXAIsvdWh3VGjOQhk6qBNlrgNckg Nz7eiQKJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYrBHEgAKCRDDTyI5ktmPJA60DA CQJYkqAl0wVNOTagWW54Vkbm/yXJrTWi+Wm59zz56IOUXRMNvm3l9irt5LFUv2KlPKZDbu9wimftoI 5+J6hF8vEVhCfdYvy7JR2oKcK6K4YYRtQrl+pdHgij/5izowODmgopw/FAd9Pw/3lHNzlQAtbNi2MM 9RXVzNO0QtGitXiKKiazBx8EQGcCQB/2OMNG35oBoTA5xOCCmCbJRVpCdSGLSC9WzG1+H0mdNmXh0Z 6hScIWxfanp79xVuwJZKXdt9sfnqIwJW7+hJnoUg8OeCiu9k5g1C6RoqYFIJ0f2gIen3ehgbjt6okn jSXLuEY0ZLE2Ytp6pJUhBOrd5GYcqLNsEHgWTNbm+PEOdJHxsscp+3IKoEyDgYCyx1amijLYZaqNdo ClpvxlkihxiG7FqisbgmekwNuz3GHxJRULu4YlwnLgfFe25J3n4uFlxEihGSbS8mS0YLUhCgUzUfBb 9BZtKATMMIfgr/A7noll6DfQnpjRrJN8iM47hprZlzcYM=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

As the code comment already suggests, using the efivar API in this way
is not how it is intended, and so let's switch to the right one, which
is simply to call efi.get_variable() directly after checking whether or
not the GetVariable() runtime service is supported.

Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---

If I can please get an ack, I'd like to take this via the EFI tree for
the next cycle.

 drivers/staging/media/atomisp/pci/atomisp_gmin_platform.c | 27 +++++---------------
 1 file changed, 6 insertions(+), 21 deletions(-)

diff --git a/drivers/staging/media/atomisp/pci/atomisp_gmin_platform.c b/drivers/staging/media/atomisp/pci/atomisp_gmin_platform.c
index 7e47db82de07..bf527b366ab3 100644
--- a/drivers/staging/media/atomisp/pci/atomisp_gmin_platform.c
+++ b/drivers/staging/media/atomisp/pci/atomisp_gmin_platform.c
@@ -1284,7 +1284,7 @@ static int gmin_get_config_var(struct device *maindev,
 	const struct dmi_system_id *id;
 	struct device *dev = maindev;
 	char var8[CFG_VAR_NAME_MAX];
-	struct efivar_entry *ev;
+	efi_status_t status;
 	int i, ret;
 
 	/* For sensors, try first to use the _DSM table */
@@ -1326,24 +1326,11 @@ static int gmin_get_config_var(struct device *maindev,
 	for (i = 0; i < sizeof(var8) && var8[i]; i++)
 		var16[i] = var8[i];
 
-	/* Not sure this API usage is kosher; efivar_entry_get()'s
-	 * implementation simply uses VariableName and VendorGuid from
-	 * the struct and ignores the rest, but it seems like there
-	 * ought to be an "official" efivar_entry registered
-	 * somewhere?
-	 */
-	ev = kzalloc(sizeof(*ev), GFP_KERNEL);
-	if (!ev)
-		return -ENOMEM;
-	memcpy(&ev->var.VariableName, var16, sizeof(var16));
-	ev->var.VendorGuid = GMIN_CFG_VAR_EFI_GUID;
-	ev->var.DataSize = *out_len;
-
-	ret = efivar_entry_get(ev, &ev->var.Attributes,
-			       &ev->var.DataSize, ev->var.Data);
-	if (ret == 0) {
-		memcpy(out, ev->var.Data, ev->var.DataSize);
-		*out_len = ev->var.DataSize;
+	status = EFI_UNSUPPORTED;
+	if (efi_rt_services_supported(EFI_RT_SUPPORTED_GET_VARIABLE))
+		status = efi.get_variable(var16, &GMIN_CFG_VAR_EFI_GUID, NULL,
+					  (unsigned long *)out_len, out);
+	if (status == EFI_SUCCESS) {
 		dev_info(maindev, "found EFI entry for '%s'\n", var8);
 	} else if (is_gmin) {
 		dev_info(maindev, "Failed to find EFI gmin variable %s\n", var8);
@@ -1351,8 +1338,6 @@ static int gmin_get_config_var(struct device *maindev,
 		dev_info(maindev, "Failed to find EFI variable %s\n", var8);
 	}
 
-	kfree(ev);
-
 	return ret;
 }
 
-- 
2.35.1

