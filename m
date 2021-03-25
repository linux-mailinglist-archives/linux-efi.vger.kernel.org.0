Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 616E3348D86
	for <lists+linux-efi@lfdr.de>; Thu, 25 Mar 2021 10:57:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbhCYJ5C (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 25 Mar 2021 05:57:02 -0400
Received: from foss.arm.com ([217.140.110.172]:45640 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229995AbhCYJ4j (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 25 Mar 2021 05:56:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 826B631B;
        Thu, 25 Mar 2021 02:56:38 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 640983F718;
        Thu, 25 Mar 2021 02:56:35 -0700 (PDT)
Date:   Thu, 25 Mar 2021 09:56:26 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     "will@kernel.org" <will@kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "ardb@kernel.org" <ardb@kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        KY Srinivasan <kys@microsoft.com>
Subject: Re: [PATCH v9 1/7] smccc: Add HVC call variant with result registers
 other than 0 thru 3
Message-ID: <20210325095626.GA36570@C02TD0UTHF1T.local>
References: <1615233439-23346-1-git-send-email-mikelley@microsoft.com>
 <1615233439-23346-2-git-send-email-mikelley@microsoft.com>
 <20210324165519.GA24528@C02TD0UTHF1T.local>
 <MWHPR21MB159351AFC4226A6AA8E33530D7629@MWHPR21MB1593.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MWHPR21MB159351AFC4226A6AA8E33530D7629@MWHPR21MB1593.namprd21.prod.outlook.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Mar 25, 2021 at 04:55:51AM +0000, Michael Kelley wrote:
> From: Mark Rutland <mark.rutland@arm.com> Sent: Wednesday, March 24, 2021 9:55 AM
> > For the benefit of others here, SMCCCv1.2 allows:
> > 
> > * SMC64/HVC64 to use all of x1-x17 for both parameters and return values
> > * SMC32/HVC32 to use all of r1-r7 for both parameters and return values
> > 
> > The rationale for this was to make it possible to pass a large number of
> > arguments in one call without the hypervisor/firmware needing to access
> > the memory of the caller.
> > 
> > My preference would be to add arm_smccc_1_2_{hvc,smc}() assembly
> > functions which read all the permitted argument registers from a struct,
> > and write all the permitted result registers to a struct, leaving it to
> > callers to set those up and decompose them.
> > 
> > That way we only have to write one implementation that all callers can
> > use, which'll be far easier to maintain. I suspect that in general the
> > cost of temporarily bouncing the values through memory will be dominated
> > by whatever the hypervisor/firmware is going to do, and if it's not we
> > can optimize that away in future.
> 
> Thanks for the feedback, and I'm working on implementing this approach.
> But I've hit a snag in that gcc limits the "asm" statement to 30 arguments,
> which gives us 15 registers as parameters and 15 registers as return
> values, instead of the 18 each allowed by SMCCC v1.2.  I will continue
> with the 15 register limit for now, unless someone knows a way to exceed
> that.  The alternative would be to go to pure assembly language.

I realise in retrospect this is not clear, but when I said "assembly
functions" I had meant raw assembly functions rather than inline
assembly.

We already have __arm_smccc_smc and __arm_smccc_hvc assembly functions
in arch/{arm,arm64}/kernel/smccc-call.S, and I'd expected we'd add the
full fat SMCCCv1.2 variants there.

Thanks,
Mark.
