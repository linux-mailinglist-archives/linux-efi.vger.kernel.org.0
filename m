Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49FA3673F39
	for <lists+linux-efi@lfdr.de>; Thu, 19 Jan 2023 17:46:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbjASQqN (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 19 Jan 2023 11:46:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230403AbjASQqE (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 19 Jan 2023 11:46:04 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 756998BAA2;
        Thu, 19 Jan 2023 08:45:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C7B7ACE24F8;
        Thu, 19 Jan 2023 16:45:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E105C43392;
        Thu, 19 Jan 2023 16:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674146748;
        bh=QeWwkHCkmPI6InIWABry3ht60PE2twa3Wx83EnocKUc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FcC3eOC0tK1JDm2vU5t6lG8N6tu2TTkZsEkQFINKv3WNnID1xUrnhqQa7j+fE2+eO
         LcdFhQp59mnpkqoWEGnz6PhnIH/Pg6NwhEDX7x3kj4AHY50PIe4zwX0LpS+WD+V/5J
         cwDq20s978Dr0himuRr1MO4WFz+zoObpD4Kinu4ZdJ1rDUhcwohVF99J00aZlaUHWT
         lAdsUpO2pS7hFAQTko8jDkFb2joMJ07UK8+jEeVo1m1033azICpEOXvSQaiwXi2shX
         DLK+9UsVAtYuOCeg4TWtEhoZF0yyCbbeDcOgI8Sya7pkc4vj0Daq03uym8g9IvcfYK
         UhqdEVTUPEutw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1pIY3M-0007Mv-7w; Thu, 19 Jan 2023 17:46:16 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Matthew Garrett <mjg59@srcf.ucam.org>, Jeremy Kerr <jk@ozlabs.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 3/4] efi: verify that variable services are supported
Date:   Thu, 19 Jan 2023 17:42:54 +0100
Message-Id: <20230119164255.28091-4-johan+linaro@kernel.org>
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

Current Qualcomm UEFI firmware does not implement the variable services
but not all revisions clear the corresponding bits in the RT_PROP table
services mask and instead the corresponding calls return
EFI_UNSUPPORTED.

This leads to efi core registering the generic efivar ops even when the
variable services are not supported or when they are accessed through
some other interface (e.g. Google SMI or the upcoming Qualcomm SCM
implementation).

Instead of playing games with init call levels to make sure that the
custom implementations are registered after the generic one, make sure
that get_next_variable() is actually supported before registering the
generic ops.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/firmware/efi/efi.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index a7f1a32537f1..03ccc4e8d1fc 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -187,8 +187,27 @@ static const struct attribute_group efi_subsys_attr_group = {
 static struct efivars generic_efivars;
 static struct efivar_operations generic_ops;
 
+static bool generic_ops_supported(void)
+{
+	unsigned long name_size;
+	efi_status_t status;
+	efi_char16_t name;
+	efi_guid_t guid;
+
+	name_size = sizeof(name);
+
+	status = efi.get_next_variable(&name_size, &name, &guid);
+	if (status == EFI_UNSUPPORTED)
+		return false;
+
+	return true;
+}
+
 static int generic_ops_register(void)
 {
+	if (!generic_ops_supported())
+		return 0;
+
 	generic_ops.get_variable = efi.get_variable;
 	generic_ops.get_next_variable = efi.get_next_variable;
 	generic_ops.query_variable_store = efi_query_variable_store;
@@ -202,6 +221,9 @@ static int generic_ops_register(void)
 
 static void generic_ops_unregister(void)
 {
+	if (!generic_ops.get_variable)
+		return;
+
 	efivars_unregister(&generic_efivars);
 }
 
-- 
2.38.2

