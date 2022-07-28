Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEAB1583D51
	for <lists+linux-efi@lfdr.de>; Thu, 28 Jul 2022 13:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237016AbiG1LYs (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 28 Jul 2022 07:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236944AbiG1LY2 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 28 Jul 2022 07:24:28 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 296536D56C;
        Thu, 28 Jul 2022 04:21:54 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1D598106F;
        Thu, 28 Jul 2022 04:21:55 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8366F3F73B;
        Thu, 28 Jul 2022 04:21:52 -0700 (PDT)
Date:   Thu, 28 Jul 2022 12:21:50 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Maximilian Luz <luzmaximilian@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Steev Klimaszewski <steev@kali.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, linux-efi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] dt-bindings: firmware: Add Qualcomm UEFI Secure
 Application client
Message-ID: <20220728112150.hs5el6wufljeoqyy@bogus>
References: <20220723224949.1089973-1-luzmaximilian@gmail.com>
 <20220723224949.1089973-5-luzmaximilian@gmail.com>
 <20220726143005.wt4be7yo7sbd3xut@bogus>
 <829c8fee-cae5-597d-933d-784b4b57bd73@gmail.com>
 <20220726154138.74avqs6iqlzqpzjk@bogus>
 <d1bc99bb-82ce-aa6e-7fad-e9309fa1c19b@gmail.com>
 <20220728082330.w4ppmzvjaeywsglu@bogus>
 <4e777590-616a-558a-031e-3ef1f1e492b4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e777590-616a-558a-031e-3ef1f1e492b4@gmail.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Jul 28, 2022 at 12:05:15PM +0200, Maximilian Luz wrote:
> On 7/28/22 10:23, Sudeep Holla wrote:

[...]

> > Worst case I am fine with that as this needs to be one of and future
> > platforms must get their act right in designing their f/w interface.
>
> Again, I fully agree with you that this situation shouldn't exist. But
> reality is sadly different.
>

As I mentioned I don't have final authority to say yes or no to DT bindings.
I have expressed my opinion and I thing allowing this to be generic via DT
bindings gives no incentive to get the firmware story right. Hence I am happy
to see this as one-off driver change and then we more changes are added to
the driver or similar drivers get added in the future, we have a change to
demand what action has been taken to fix the firmware story.

Just adding DT support(which I disagree) will make future platform to just
use it and not get improvements in areas of discovery or query from the
firmware.

--
Regards,
Sudeep
