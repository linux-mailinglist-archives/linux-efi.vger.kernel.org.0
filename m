Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3984C673F3F
	for <lists+linux-efi@lfdr.de>; Thu, 19 Jan 2023 17:47:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbjASQrf (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 19 Jan 2023 11:47:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbjASQrd (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 19 Jan 2023 11:47:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 808A17EEF;
        Thu, 19 Jan 2023 08:47:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 374CF61CDC;
        Thu, 19 Jan 2023 16:47:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90493C433D2;
        Thu, 19 Jan 2023 16:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674146849;
        bh=b4vm+X+r5sFdIifmj+z1qTfcQFjkoxmS/pKfIqvnGUA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oN1jwzKCScxiWTJTCYfWrPPIbVpzuLZ+yDSprx6xsB8JPr+4+LAjmo08mIkrTN0uE
         ketUfwrZt37E/0pn4+XDPRNG9GEDUxUpMSvf+Z80NdeNsAz2Y5Er27ofFSZ3UMtIY1
         dAtn7NzD+qTTh/q1RSHto2b99QwPYpRCjRBJa0Y2J7rrRwk6dMqeN/RcG0EyBxFN0h
         ylvpHgL0YZNDRuqvxUJ/bbViii7hbpoMhylvxo9OPfN5Yu04Iixxngq/0m4mUkjXfM
         Me4d7YGnz/kKr/Do0V/8uGyagWmUmuJym0XSUKg3xRp5dyDsIuzR7MEJD2I56e3YUC
         s23WBNwQ9zJ0Q==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pIY4z-0007PZ-Ev; Thu, 19 Jan 2023 17:47:57 +0100
Date:   Thu, 19 Jan 2023 17:47:57 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Maximilian Luz <luzmaximilian@gmail.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>, Andy Gross <agross@kernel.org>,
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
Message-ID: <Y8l0PdZlXLym//xS@hovoldconsulting.com>
References: <20220723224949.1089973-1-luzmaximilian@gmail.com>
 <20220723224949.1089973-4-luzmaximilian@gmail.com>
 <Y8ZbN5LNn2fk0/xi@hovoldconsulting.com>
 <2b0fdc2d-6457-059b-bbdf-27e7de59abeb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b0fdc2d-6457-059b-bbdf-27e7de59abeb@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Jan 18, 2023 at 09:45:18PM +0100, Maximilian Luz wrote:
> On 1/17/23 09:24, Johan Hovold wrote:
> > On Sun, Jul 24, 2022 at 12:49:48AM +0200, Maximilian Luz wrote:

> >> +module_platform_driver(qcom_uefisecapp_driver);
> > 
> > I noticed that for efivarfs to work, you're currently relying on having
> > the firmware still claim that the variable services are supported in the
> > RT_PROP table so that efi core registers the default ops at subsys init
> > time (which are later overridden by this driver).
> > 
> > Otherwise efivarfs may fail to initialise when built in:
> > 
> > 	static __init int efivarfs_init(void)
> > 	{
> > 		if (!efivars_kobject())
> > 			return -ENODEV;
> > 
> > 		return register_filesystem(&efivarfs_type);
> > 	}
> > 
> > 	module_init(efivarfs_init);
> > 
> > With recent X13s firmware the corresponding bit in the RT_PROP table has
> > been cleared so that efivarfs would fail to initialise. Similar problem
> > when booting with 'efi=noruntime'.
> > 
> > One way to handle this is to register also the qcom_uefisecapp_driver at
> > subsys init time and prevent it from being built as a module (e.g. as is
> > done for the SCM driver). I'm using the below patch for this currently.
> 
> So I've had another look and I'm not sure this will work reliably:
> 
> First, you are correct in case the RT_PROP table is cleared. In that
> case, using subsys_initcall() will move the efivar registration before
> the efivarfs_init() call.
> 
> However, in case EFI indicates support for variables, we will then have
> generic_ops_register() and the uefisecapp's driver call running both in
> subsys_initcall(). So if I'm not mistaken, this could cause the generic
> ops to be registered after the uefisecapp ones, which we want to avoid.

Good catch, I was using 'efi=noruntime' on the CRD so I did not notice
that race.

> One solution is bumping uefisecapp to fs_initcall(). Or do you have any
> other suggestions?

I think it would be best to avoid that if we can, but that should work.

The problem here is that the firmware claims to support the EFI variable
services even when it clearly does not and the corresponding callbacks
just return EFI_UNSUPPORTED. As far as I understand, this is still spec
compliant though so we just need to handle that.

One way to address this could be to have efi core not register the
default efivars ops in this case. That would require checking that the
services are indeed available by making one of those calls during
initialisation.

This would however expose the fact that the Google SMI implementation
implicitly relies on overriding the default ops, but I think that's a
good thing as what we have now is racy in multiple ways.

Instead I think we should move the efivarfs availability check from
module init to mount time. That should allow the Google driver, and your
SCM implementation, to continue to be built as modules.

Any consumers (e.g. the Qualcomm RTC driver) would instead need to
check if efivars is available or else defer probe.

Alternatively, it seems all efivars implementation would need to be
always-built in which is not ideal for generic kernels.

I just posted a series here as food for thought:

	https://lore.kernel.org/r/20230119164255.28091-1-johan+linaro@kernel.org

Johan
