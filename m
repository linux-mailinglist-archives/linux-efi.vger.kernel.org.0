Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1F3E583A4A
	for <lists+linux-efi@lfdr.de>; Thu, 28 Jul 2022 10:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235150AbiG1IXj (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 28 Jul 2022 04:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235155AbiG1IXg (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 28 Jul 2022 04:23:36 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A80C06248D;
        Thu, 28 Jul 2022 01:23:35 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C9A83106F;
        Thu, 28 Jul 2022 01:23:35 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DDF8F3F73B;
        Thu, 28 Jul 2022 01:23:32 -0700 (PDT)
Date:   Thu, 28 Jul 2022 09:23:30 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Maximilian Luz <luzmaximilian@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
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
Message-ID: <20220728082330.w4ppmzvjaeywsglu@bogus>
References: <20220723224949.1089973-1-luzmaximilian@gmail.com>
 <20220723224949.1089973-5-luzmaximilian@gmail.com>
 <20220726143005.wt4be7yo7sbd3xut@bogus>
 <829c8fee-cae5-597d-933d-784b4b57bd73@gmail.com>
 <20220726154138.74avqs6iqlzqpzjk@bogus>
 <d1bc99bb-82ce-aa6e-7fad-e9309fa1c19b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1bc99bb-82ce-aa6e-7fad-e9309fa1c19b@gmail.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Jul 26, 2022 at 07:01:28PM +0200, Maximilian Luz wrote:
> On 7/26/22 17:41, Sudeep Holla wrote:
> > On Tue, Jul 26, 2022 at 05:15:41PM +0200, Maximilian Luz wrote:
> > >
> > > So ultimately I think it's better to add a DT entry for it.
> >
> > I disagree for the reason that once you discover more apps running on the
> > secure side, you want to add more entries and update DT on the platform
> > every time you discover some new firmware entity and you wish to interact
> > with it from the non-secure side.
>
> Just as you'll have to add a driver to the kernel and update whatever is
> probing the TrEE interface and add those strings to that interface. If
> you then start doing SoC-specific lists, I think you'd be pretty much
> re-implementing a DT in the kernel driver...
>

Yes at the cost of DT being dumping ground for all the SoC specific firmware
crap. Firmware can be and must be discoverable, no point in dumping it in
DT as it forces DT upgrade every time something changes in the firmware i.e.
it can go out of sync quite quickly.

> I don't quite understand why this is a problem. I think per device,
> there's a reasonably limited set of apps that we would want to interact
> with from the kernel. And for one single device, that set doesn't change
> over time. So what's the difference to, say, an I2C device?
>

As I said we don't want DT to be dumping ground for all the not well designed
firmware interface. The whole point of firmware being another piece of
software that can be change unlike hardware makes it fragile to present any
more that what you need in the DT. I see this as one of the example.

Anyways I don't have the final say, I leave it to the DT maintainers.

> > As along as get this application ID can handle any random name, I prefer
> > to use that as the discover mechanism and not have this DT.
>
> Apart from the above, some apps must also be loaded from the system. And
> those you can't detect: If an app isn't running, it doesn't have an ID
> (uefisecapp and the tpm app are loaded by the firmware at boot). Those
> are mostly vendor-specific things as far as I can tell, or HDCP stuff.
> So you'd need to specify those as firmware somehow, and since (as far as
> I can tell) those are signed specifically by/for that vendor and
> potentially device (similar to the GPU zap shader or remoteproc
> firmware), you'll need to use per-device paths.
>

Sounds to me like more can be pushed to user space as it gets loaded at
runtime.

> That means you either hard-code them in the driver and have a compatible
> per model, do DMI matching, or something similar (again, essentially
> baking DTs into the kernel driver...), or just store them in the DT
> (like we already do for GPU/remoteprocs). While you could hard-code some
> known loaded-by-firmware apps and use the DT for others, I think we
> should keep everything in the same place.
>

Worst case I am fine with that as this needs to be one of and future
platforms must get their act right in designing their f/w interface.

--
Regards,
Sudeep
