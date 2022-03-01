Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAA234C821F
	for <lists+linux-efi@lfdr.de>; Tue,  1 Mar 2022 05:19:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232244AbiCAETi (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 28 Feb 2022 23:19:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232246AbiCAETg (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 28 Feb 2022 23:19:36 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17311FD3A;
        Mon, 28 Feb 2022 20:18:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=SNG8dsJKnqg4yoB1IAs+5+zuDlU3R1ic4tYvheuBHLI=; b=BIJf36tfAUXQXZqcOnbeAxttFX
        jFYQv0XXdHsIqDASqvzeCHFWihKYilk3cBB7YnenzeaqjtnWquPL2Fw2mclByXwyKXocnLBPj/MCX
        RaBePffOxZitWR550+mebrZDyIePhbYVH0r8PHLVLJcQx24hXPGUVuFzs6eBqsxmapMTWV5dPeUOv
        eNLkIn+YKoTteSp0QOkIc8uZW4AlOG4kySu/x+4CVBm28T0TzNfjGU8zpoKzPkyZzXMzw/b14XGcK
        mTSNmUW4cjUWIdFr5LGTpKGAdsPHshNUie5Tz1iOkAOHpuzMM5XNAoc7gkQiVOqLXFUI9cQd1xprT
        kRtI7Whg==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nOtyQ-00Er1X-42; Tue, 01 Mar 2022 04:18:54 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     patches@lists.linux.dev, Randy Dunlap <rdunlap@infradead.org>,
        Igor Zhbanov <i.zhbanov@omprussia.ru>,
        Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org,
        Lukas Wunner <lukas@wunner.de>,
        Octavian Purdila <octavian.purdila@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Matt Fleming <matt@codeblueprint.co.uk>
Subject: [PATCH] efi: fix return value of __setup handlers
Date:   Mon, 28 Feb 2022 20:18:51 -0800
Message-Id: <20220301041851.12459-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

When "dump_apple_properties" is used on the kernel boot command line,
it causes an Unknown parameter message and the string is added to init's
argument strings:

  Unknown kernel command line parameters "dump_apple_properties
    BOOT_IMAGE=/boot/bzImage-517rc6 efivar_ssdt=newcpu_ssdt", will be
    passed to user space.

 Run /sbin/init as init process
   with arguments:
     /sbin/init
     dump_apple_properties
   with environment:
     HOME=/
     TERM=linux
     BOOT_IMAGE=/boot/bzImage-517rc6
     efivar_ssdt=newcpu_ssdt

Similarly when "efivar_ssdt=somestring" is used, it is added to the
Unknown parameter message and to init's environment strings, polluting
them (see examples above).

Change the return value of the __setup functions to 1 to indicate
that the __setup options have been handled.

Fixes: 58c5475aba67 ("x86/efi: Retrieve and assign Apple device properties")
Fixes: 475fb4e8b2f4 ("efi / ACPI: load SSTDs from EFI variables")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: Igor Zhbanov <i.zhbanov@omprussia.ru>
Link: lore.kernel.org/r/64644a2f-4a20-bab3-1e15-3b2cdd0defe3@omprussia.ru
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org
Cc: Lukas Wunner <lukas@wunner.de>
Cc: Octavian Purdila <octavian.purdila@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Matt Fleming <matt@codeblueprint.co.uk>
---
 drivers/firmware/efi/apple-properties.c |    2 +-
 drivers/firmware/efi/efi.c              |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- linux-next-20220228.orig/drivers/firmware/efi/apple-properties.c
+++ linux-next-20220228/drivers/firmware/efi/apple-properties.c
@@ -24,7 +24,7 @@ static bool dump_properties __initdata;
 static int __init dump_properties_enable(char *arg)
 {
 	dump_properties = true;
-	return 0;
+	return 1;
 }
 
 __setup("dump_apple_properties", dump_properties_enable);
--- linux-next-20220228.orig/drivers/firmware/efi/efi.c
+++ linux-next-20220228/drivers/firmware/efi/efi.c
@@ -212,7 +212,7 @@ static int __init efivar_ssdt_setup(char
 		memcpy(efivar_ssdt, str, strlen(str));
 	else
 		pr_warn("efivar_ssdt: name too long: %s\n", str);
-	return 0;
+	return 1;
 }
 __setup("efivar_ssdt=", efivar_ssdt_setup);
 
