Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 648EC66D81C
	for <lists+linux-efi@lfdr.de>; Tue, 17 Jan 2023 09:24:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236096AbjAQIYo (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 17 Jan 2023 03:24:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236133AbjAQIY0 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 17 Jan 2023 03:24:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 310E62ED58;
        Tue, 17 Jan 2023 00:24:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AD6EA611F2;
        Tue, 17 Jan 2023 08:24:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07E0EC433F1;
        Tue, 17 Jan 2023 08:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673943843;
        bh=jOMA2ItWhbyt6drah2KbBQDJgxvQk73yFlOfbO12fu4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ls0BQqaL23lBXhvrtbco3O6ro6b1+RhXmNl4/Mdz6e+k2JDSy7ZdQTYJNeENmVc0T
         U1Yt33cs8/uUvDdt3cwrpXhFusU2Xyj6IElSjBwVVzTZm2kCeuuusisknHIzU9FF0+
         iB2FFgpKaPaeWYge/fxtQFEz0j0+je1R4BSF5ZSdY5jU8EyjgZuP5I/AuHahvStnXf
         apmrRFs0gHXYSux7PaGbuUvGyK9WhpR/FE8fzdWwFeQwbDcV0aUpIRYla23oe586S4
         OMJm8CHF2MzvlFz/mdvrFmA/gY4yte5G0jLiNwrUDSi/4f9CCtJkHkc21fq5SidYnG
         yLOCuy6LZYn9g==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pHhGZ-0007NH-6G; Tue, 17 Jan 2023 09:24:23 +0100
Date:   Tue, 17 Jan 2023 09:24:23 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Maximilian Luz <luzmaximilian@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Steev Klimaszewski <steev@kali.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, linux-efi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] firmware: Add support for Qualcomm UEFI Secure
 Application
Message-ID: <Y8ZbN5LNn2fk0/xi@hovoldconsulting.com>
References: <20220723224949.1089973-1-luzmaximilian@gmail.com>
 <20220723224949.1089973-4-luzmaximilian@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220723224949.1089973-4-luzmaximilian@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sun, Jul 24, 2022 at 12:49:48AM +0200, Maximilian Luz wrote:
> On platforms using the Qualcomm UEFI Secure Application (uefisecapp),
> EFI variables cannot be accessed via the standard interface in EFI
> runtime mode. The respective functions return EFI_UNSUPPORTED. On these
> platforms, we instead need to talk to uefisecapp. This commit provides
> support for this and registers the respective efivars operations to
> access EFI variables from the kernel.
> 
> Communication with uefisecapp follows the standard Qualcomm Trusted
> Environment (TEE or TrEE) / Secure OS conventions via the respective SCM
> call interface. This is also the reason why variable access works
> normally while boot services are active. During this time, said SCM
> interface is managed by the boot services. When calling
> ExitBootServices(), the ownership is transferred to the kernel.
> Therefore, UEFI must not use that interface itself (as multiple parties
> accessing this interface at the same time may lead to complications) and
> cannot access variables for us.
> 
> Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
> ---

> +static struct platform_driver qcom_uefisecapp_driver = {
> +	.probe = qcom_uefisecapp_probe,
> +	.remove = qcom_uefisecapp_remove,
> +	.driver = {
> +		.name = "qcom_tee_uefisecapp",
> +		.of_match_table = qcom_uefisecapp_dt_match,
> +		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
> +	},
> +};
> +module_platform_driver(qcom_uefisecapp_driver);

I noticed that for efivarfs to work, you're currently relying on having
the firmware still claim that the variable services are supported in the
RT_PROP table so that efi core registers the default ops at subsys init
time (which are later overridden by this driver).

Otherwise efivarfs may fail to initialise when built in:

	static __init int efivarfs_init(void)
	{
		if (!efivars_kobject())
			return -ENODEV;

		return register_filesystem(&efivarfs_type);
	}

	module_init(efivarfs_init);

With recent X13s firmware the corresponding bit in the RT_PROP table has
been cleared so that efivarfs would fail to initialise. Similar problem
when booting with 'efi=noruntime'.

One way to handle this is to register also the qcom_uefisecapp_driver at
subsys init time and prevent it from being built as a module (e.g. as is
done for the SCM driver). I'm using the below patch for this currently.

I guess the Google GSMI implementation suffers from a similar problem.

Johan


From 8fecce12d215bd8cab1b8c8f9f0d1e1fe20fe6e7 Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan+linaro@kernel.org>
Date: Sun, 15 Jan 2023 15:32:34 +0100
Subject: [PATCH] firmware: qcom_tee_uefisecapp: register at subsys init

Register efivars at subsys init time so that it is available when
efivarfs probes. For the same reason, also prevent building the driver
as a module.

This is specifically needed on platforms such as the Lenovo Thinkpad
X13s where the firmware has cleared the variable services in the RT_PROP
table so that efi core does not register any efivar callbacks at subsys
init time (which are later overridden).

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/firmware/Kconfig               | 2 +-
 drivers/firmware/qcom_tee_uefisecapp.c | 7 ++++++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
index 4e9e2c227899..48e712e363da 100644
--- a/drivers/firmware/Kconfig
+++ b/drivers/firmware/Kconfig
@@ -231,7 +231,7 @@ config QCOM_TEE
 	select QCOM_SCM
 
 config QCOM_TEE_UEFISECAPP
-	tristate "Qualcomm TrEE UEFI Secure App client driver"
+	bool "Qualcomm TrEE UEFI Secure App client driver"
 	select QCOM_TEE
 	depends on EFI
 	help
diff --git a/drivers/firmware/qcom_tee_uefisecapp.c b/drivers/firmware/qcom_tee_uefisecapp.c
index 65573e4b815a..e83bce4da70a 100644
--- a/drivers/firmware/qcom_tee_uefisecapp.c
+++ b/drivers/firmware/qcom_tee_uefisecapp.c
@@ -754,7 +754,12 @@ static struct platform_driver qcom_uefisecapp_driver = {
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 };
-module_platform_driver(qcom_uefisecapp_driver);
+
+static int __init qcom_uefisecapp_init(void)
+{
+	return platform_driver_register(&qcom_uefisecapp_driver);
+}
+subsys_initcall(qcom_uefisecapp_init);
 
 MODULE_AUTHOR("Maximilian Luz <luzmaximilian@gmail.com>");
 MODULE_DESCRIPTION("Client driver for Qualcomm TrEE/TZ UEFI Secure App");
-- 
2.38.2
