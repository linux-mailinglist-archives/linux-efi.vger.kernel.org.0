Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4FF466DBCF
	for <lists+linux-efi@lfdr.de>; Tue, 17 Jan 2023 12:05:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236727AbjAQLFk (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 17 Jan 2023 06:05:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236745AbjAQLFG (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 17 Jan 2023 06:05:06 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7710303FC;
        Tue, 17 Jan 2023 03:04:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8902CB812A9;
        Tue, 17 Jan 2023 11:04:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3867FC433D2;
        Tue, 17 Jan 2023 11:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673953494;
        bh=wsFijr8RtHy8c37DYkxizZWfQUewq34t88PdijWuA5s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KmtgV2LmsMWnnqHjflSG/o8jwuoDDBx/E/Z+4+AIt/iOPulPP4wbYuj4DUQZin11i
         av602fXzR2GJzqlB1cPWvlEp+RZcQqKTqvJ6IObi3Oa8BJTtJdS9dFvnQptLUOnM1/
         SLohg+J2Q+B6EeKJM2RDu7XjZq7beBswSI135atV4MNozQ0RjccCe83EXXoGWDWBcX
         zlKqoL2bqzZO/e7diATzA0Lk8QwqvQQhECGn2ipyfhIB7w5e4DIidB10eOjqGp/MfU
         HGBzL8QroN0OfmypKyXepNFgFrW63DFCsDhJaKinAIVvyGz3Ju7pqW7DphjGbFTVvi
         VUmZw3ce7nPnA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pHjmF-0001n1-9Z; Tue, 17 Jan 2023 12:05:15 +0100
Date:   Tue, 17 Jan 2023 12:05:15 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Maximilian Luz <luzmaximilian@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>,
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
Message-ID: <Y8aA60iJ0Sv2IrLm@hovoldconsulting.com>
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

> +static int qcom_uefisecapp_probe(struct platform_device *pdev)
> +{
> +	struct qcuefi_client *qcuefi;
> +	int status;

[...]

> +	/* Set up kobject for efivars interface. */
> +	qcuefi->kobj = kobject_create_and_add("qcom_tee_uefisecapp", firmware_kobj);
> +	if (!qcuefi->kobj) {
> +		status = -ENOMEM;
> +		goto err_kobj;

When preparing some related EFI patches, I noticed that the error labels
here are named after where you jump from rather than after what they do
(as is suggested by the coding standard).

Would you mind changing that (throughout) for your v2?

> +	}
> +
> +	/* Register global reference. */
> +	platform_set_drvdata(pdev, qcuefi);
> +	status = qcuefi_set_reference(qcuefi);
> +	if (status)
> +		goto err_ref;
> +
> +	/* Register efivar ops. */
> +	status = efivars_register(&qcuefi->efivars, &qcom_efivar_ops, qcuefi->kobj);
> +	if (status)
> +		goto err_register;
> +
> +	return 0;
> +
> +err_register:
> +	qcuefi_set_reference(NULL);
> +err_ref:
> +	kobject_put(qcuefi->kobj);
> +err_kobj:
> +	qctee_dma_free(qcuefi->dev, &qcuefi->dma);
> +	return status;
> +}

Johan
