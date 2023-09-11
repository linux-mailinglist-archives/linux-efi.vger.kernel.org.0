Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADF0679A5A8
	for <lists+linux-efi@lfdr.de>; Mon, 11 Sep 2023 10:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232667AbjIKIKt (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 11 Sep 2023 04:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbjIKIKs (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 11 Sep 2023 04:10:48 -0400
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D8AFB
        for <linux-efi@vger.kernel.org>; Mon, 11 Sep 2023 01:10:30 -0700 (PDT)
Received: by mail-wr1-x44a.google.com with SMTP id ffacd0b85a97d-31400956ce8so2682183f8f.3
        for <linux-efi@vger.kernel.org>; Mon, 11 Sep 2023 01:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1694419829; x=1695024629; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=V9h3TvxPp3BhqWITBWJvxN/XihdHn8lTfNkH9Bkr8a4=;
        b=wBE4t8B5K3xyY20CmyzaRJFup5Vzh2PVN0RhTo33U9yKzgYMFsRlGN1863ioWzaQPo
         R4WW59KwqR6bncQABQAyb9YldcO4CABskDg92BxCdxya3mB8Uab9rR9vyHa7moBKPg1x
         z/5Kf1wGyjaEGNjj+583SlsIWo5IcxpR9lIdyT4t32nmctcmaK7D+0bOkGyjwgCaGYdc
         8Fyskok11ahzQCc605WYgfYPLLakSX54Z/eibrO7PLobGHoPlDfzaR5+lzBWUj7Igxxg
         njfDvsVQwtig2i/VmS0bep3PTRpeDPfgn7m3Q+Af1DfmhrXkcwhSbNkwi/zK7/9Bkq7X
         f/Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694419829; x=1695024629;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V9h3TvxPp3BhqWITBWJvxN/XihdHn8lTfNkH9Bkr8a4=;
        b=uquOTgqCVY7ODO89abOBcVr2ZPArzjESMhFpM2GY08QXtg465nsrqPl7RdYN5bJdOu
         /TSH+T00h8ReHRjHAixuL8ieGnrK43+wSF8MQsYqR0pb+jk7erCbXDS5fjuE/tMsGJWV
         CClWDcpeBHajhELLeeSP4J3uc/EZNqUuINDTj78cnNuEJX/1xCdxtIdDwHn4jxnnyVba
         g2C+dZ33JZz+NVwH6YfEOnI8iXGe+YFr29QCplkf8yKbNBOgaCQWj5WklLvhJOSAIJmZ
         s+JznN8i0Dt4P6GRSka2VXq1GoNpLgdRgdprzgY1PFKBCbfQ4yXHT825eiHuQb6qSDOm
         2OIg==
X-Gm-Message-State: AOJu0Yz5gDJJl0t+ehLXUIoUC2Jy1gX1FbonPOeNzLooghPBwhows0wk
        biuTE6gkwlx4BpyzDZeOv3LkUdwJLCeWEPpepC/bw5XewZK4vjwEoYgCUlO+Fz8KGA9+tKxzHqB
        45k1qC8EPuy80K8/Az2nfIT1HhhYsBzYFcilyv4BHRCclfDxyNscTsqtaruGM
X-Google-Smtp-Source: AGHT+IHmRffXERXdCfxjhB6kAYDHUYvGeOC1TSb89axyNohqgL+wpV1jHIU4tmZswBM0iKH2jIKIQDMz
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:adf:f64c:0:b0:31a:ed75:75d5 with SMTP id
 x12-20020adff64c000000b0031aed7575d5mr100996wrp.6.1694419828860; Mon, 11 Sep
 2023 01:10:28 -0700 (PDT)
Date:   Mon, 11 Sep 2023 08:10:25 +0000
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2422; i=ardb@kernel.org;
 h=from:subject; bh=Zz38QtKegMKvJqutaAuY242u84asHJSeCT+dYe1TEcg=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIeXf6UJ3+90MCldnd0aGXWi57b8nLjxvW8i9a+6c23QDv
 yS+yw3uKGVhEONgkBVTZBGY/ffdztMTpWqdZ8nCzGFlAhnCwMUpABPZ85zhr7TICWmHV5L+R3lv
 vvU6f+noBpdLTz4/eWhuWaOW5vHNXIeRYSV/9NVKnvmXjtYas0S8SNBQnuagt9rB/5/rv++pVlr +7AA=
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230911081024.3489875-2-ardb@google.com>
Subject: [PATCH] efi/x86: Disable buggy QueryVariableInfo() on HP ProBook x360
From:   Ard Biesheuvel <ardb@google.com>
To:     linux-efi@vger.kernel.org
Cc:     N3verG0nnaGiveYouUp+LinuxKernel@disroot.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Ard Biesheuvel <ardb@kernel.org>

Some HP ProBook x360 machines appear to have a buggy UEFI implementation
that crashes in the firmware when QueryVariableInfo() is invoked. So add
a DMI based quirk that marks this runtime service as unavailable on
those machines.

Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=217898
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
DodoLedev,

Please check whether this patch gives you a working efibootmgr when
applied onto 6.4 or earlier. There is another patch [0] under discussion
that will combine with this one to fix the 6.5 regression as well.

[0] https://lore.kernel.org/all/20230910045445.41632-1-heinrich.schuchardt@canonical.com/

 arch/x86/platform/efi/quirks.c | 31 ++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
index f0cc00032751..7103bec7bc86 100644
--- a/arch/x86/platform/efi/quirks.c
+++ b/arch/x86/platform/efi/quirks.c
@@ -162,8 +162,9 @@ efi_status_t efi_query_variable_store(u32 attributes, unsigned long size,
 	efi_status_t status;
 	u64 storage_size, remaining_size, max_size;
 
-	if (!(attributes & EFI_VARIABLE_NON_VOLATILE))
-		return 0;
+	if (!(attributes & EFI_VARIABLE_NON_VOLATILE) ||
+	    !efi_rt_services_supported(EFI_RT_SUPPORTED_QUERY_VARIABLE_INFO))
+		return EFI_SUCCESS;
 
 	if (nonblocking)
 		return query_variable_store_nonblocking(attributes, size);
@@ -779,3 +780,29 @@ void efi_crash_gracefully_on_page_fault(unsigned long phys_addr)
 		schedule();
 	}
 }
+
+static int __init
+disable_buggy_query_variable_info(const struct dmi_system_id *id)
+{
+	pr_info("Detected %s machine, disabling EFI QueryVariableInfo()\n",
+		id->ident);
+	efi.runtime_supported_mask &= ~EFI_RT_SUPPORTED_QUERY_VARIABLE_INFO;
+	return 1;
+}
+
+static int __init efi_dmi_check(void)
+{
+	static const struct dmi_system_id dmi_ids[] __initconst = {
+		{
+			.callback = disable_buggy_query_variable_info,
+			.ident = "HP ProBook x360",
+			.matches = {
+				DMI_MATCH(DMI_SYS_VENDOR, "HP"),
+				DMI_MATCH(DMI_PRODUCT_NAME, "HP ProBook x360 11 G1 EE"),
+			},
+		},
+		{ }	/* terminating entry */
+	};
+	return dmi_check_system(dmi_ids);
+}
+subsys_initcall(efi_dmi_check);
-- 
2.42.0.283.g2d96d420d3-goog

