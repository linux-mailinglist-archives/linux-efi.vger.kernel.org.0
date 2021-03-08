Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08964331195
	for <lists+linux-efi@lfdr.de>; Mon,  8 Mar 2021 16:04:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbhCHPDv (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 8 Mar 2021 10:03:51 -0500
Received: from foss.arm.com ([217.140.110.172]:39252 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229468AbhCHPDd (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 8 Mar 2021 10:03:33 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0A77431B;
        Mon,  8 Mar 2021 07:03:33 -0800 (PST)
Received: from C02TD0UTHF1T.local (unknown [10.57.51.12])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 918373F73C;
        Mon,  8 Mar 2021 07:03:30 -0800 (PST)
Date:   Mon, 8 Mar 2021 15:03:20 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Will Deacon <will@kernel.org>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        James Morse <james.morse@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>, kvmarm@lists.cs.columbia.edu,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/mm: Fix __enable_mmu() for new TGRAN range values
Message-ID: <20210308150232.GA14159@C02TD0UTHF1T.local>
References: <1614954969-14338-1-git-send-email-anshuman.khandual@arm.com>
 <20210305145111.GA78884@C02TD0UTHF1T.local>
 <1f339512-34ac-9779-e534-bee6698b99aa@arm.com>
 <20210308133053.GA26128@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210308133053.GA26128@willie-the-truck>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Mar 08, 2021 at 01:30:53PM +0000, Will Deacon wrote:
> On Sun, Mar 07, 2021 at 05:24:21PM +0530, Anshuman Khandual wrote:
> > On 3/5/21 8:21 PM, Mark Rutland wrote:
> > > On Fri, Mar 05, 2021 at 08:06:09PM +0530, Anshuman Khandual wrote:

> > >> +#define ID_AA64MMFR0_TGRAN_2_SUPPORTED_DEFAULT	0x0
> > >> +#define ID_AA64MMFR0_TGRAN_2_SUPPORTED_NONE	0x1
> > >> +#define ID_AA64MMFR0_TGRAN_2_SUPPORTED_MIN	0x2
> > >> +#define ID_AA64MMFR0_TGRAN_2_SUPPORTED_MAX	0x7
> > >
> > > The TGRAN2 fields doesn't quite follow the usual ID scheme rules, so how
> > > do we deteremine the max value? Does the ARM ARM say anything in
> > > particular about them, like we do for some of the PMU ID fields?
> > 
> > Did not find anything in ARM ARM, regarding what scheme TGRAN2 fields
> > actually follow. I had arrived at more restrictive 0x7 value, like the
> > usual signed fields as the TGRAN4 fields definitely do not follow the
> > unsigned ID scheme. Would restricting max value to 0x3 (i.e LPA2) be a
> > better option instead ?
> 
> I don't think it helps much, as TGRAN64_2 doesn't even define 0x3.
> 
> So I think this patch is probably the best we can do, but the Arm ARM could
> really do with describing the scheme here.

I agree, and I've filed a ticket internally to try to get this cleaned
up.

I suspect that the answer is that these are basically unsigned, with
0x2-0xf indicating presence, but I can't guarantee that.

Thanks,
Mark.
