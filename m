Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D78958279B
	for <lists+linux-efi@lfdr.de>; Wed, 27 Jul 2022 15:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232766AbiG0NYs (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 27 Jul 2022 09:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232909AbiG0NYr (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 27 Jul 2022 09:24:47 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AAD9631DE0;
        Wed, 27 Jul 2022 06:24:45 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DF8F315BF;
        Wed, 27 Jul 2022 06:24:45 -0700 (PDT)
Received: from bogus (unknown [10.57.11.51])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 969513F73B;
        Wed, 27 Jul 2022 06:24:41 -0700 (PDT)
Date:   Wed, 27 Jul 2022 14:24:37 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Maximilian Luz <luzmaximilian@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Steev Klimaszewski <steev@kali.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, linux-efi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] dt-bindings: firmware: Add Qualcomm UEFI Secure
 Application client
Message-ID: <20220727132437.pjob3z2nyxsuxgam@bogus>
References: <20220723224949.1089973-1-luzmaximilian@gmail.com>
 <20220723224949.1089973-5-luzmaximilian@gmail.com>
 <20220726143005.wt4be7yo7sbd3xut@bogus>
 <829c8fee-cae5-597d-933d-784b4b57bd73@gmail.com>
 <20220726154138.74avqs6iqlzqpzjk@bogus>
 <d1bc99bb-82ce-aa6e-7fad-e9309fa1c19b@gmail.com>
 <7284953b-52bb-37ac-fbe1-1fa845c44ff9@linaro.org>
 <3d752603-365d-3a33-e13e-ca241cee9a11@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d752603-365d-3a33-e13e-ca241cee9a11@gmail.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Jul 27, 2022 at 03:03:49PM +0200, Maximilian Luz wrote:
>
> Is there really a good way around it?

Yes rely on the firmware preferably auto discover, if that is not an option,
how about query. It seem to be working in your case.

> As far as I can see the alternative (especially for the apps that
> need to be loaded manually) is hard-coding everything in the driver.
> Which IMHO just spreads device specific information everywhere.
>

It may not be too bad compared to putting loads of firmware details
in the DT. What happens if you get a firmware upgrade with changed
number of firmware entities or even if the names are changed.

Are these name user ABI in a way that they won't be changed ? Generally
these entities tend to use UUID and the name you have might get changed.

I would ideally prefer even the name to be supplied from the userspace.
In this particular case, make this a driver and have the name as the
parameter. If the secure side services are used by some non-secure
applications, then you will need to have a user-interface which means
you can get the named from the userspace. No need to change the driver
in either case. Please let me know if I am missing anything to consider
here.

> Also: Let's use the TPM app as example. If that would be a SPI or I2C
> device, you'd model it in the DT. Just because it's a hardware device
> that's accessible via SCM/firmware you now don't?
>

Not sure if I understand the comparison here. But if there is some device
that is access restricted but needs to be accessed and has mechanism to
access, then you would model it as device in DT.

But the one $subject is addressing looks pure software and doesn't make
sense to model in DT IMO.

> If I were absolutely certain that there is a reliable mechanism to
> detect these apps, I'd agree with having a driver to instantiate those
> devices. But I am not.
>

You did say you use some query API to check this. I haven't seen the driver,
so relying on what you said earlier.

--
Regards,
Sudeep
