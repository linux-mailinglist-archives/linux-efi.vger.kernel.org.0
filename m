Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58506330F30
	for <lists+linux-efi@lfdr.de>; Mon,  8 Mar 2021 14:31:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbhCHNbV (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 8 Mar 2021 08:31:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:57640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229575AbhCHNa7 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 8 Mar 2021 08:30:59 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id EA44964DA3;
        Mon,  8 Mar 2021 13:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615210258;
        bh=pEXNet6N/egXd7wBXv+XZqh8Z0VGXmL8Y0GWpDXYgSU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cKyWPlExbizCNVfKpN0ou+bCV20Y4lb3vpBkQS2Vmo3MZrrlJQh/iUsAO0JLf7oom
         Aflt8QGqmFYVUY8Zoiag1rK2aK5nf7xwG+EThpUDEqEjn6MScpRvXvHbMLGDeywvrw
         WWiK5i+VSUsi8FHgLgoDTguaw2tETYur8CDLJvxvop3CT1bE01EW2xjxsh8OQ4qdXj
         GwOH4MfOsamqJ4lC32GoG/POx0M8kDUF82rFM3HPT6hBlwnQ+glrbXy0A7BO3OfZGU
         4cUoYzdmvTf2bToG82yD3eHRe2YFbLqF1oklALbm0QeZuNe7ARB0QrZ1vjAHnhVRDX
         9nL4V2qDnHBug==
Date:   Mon, 8 Mar 2021 13:30:53 +0000
From:   Will Deacon <will@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        James Morse <james.morse@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>, kvmarm@lists.cs.columbia.edu,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/mm: Fix __enable_mmu() for new TGRAN range values
Message-ID: <20210308133053.GA26128@willie-the-truck>
References: <1614954969-14338-1-git-send-email-anshuman.khandual@arm.com>
 <20210305145111.GA78884@C02TD0UTHF1T.local>
 <1f339512-34ac-9779-e534-bee6698b99aa@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f339512-34ac-9779-e534-bee6698b99aa@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sun, Mar 07, 2021 at 05:24:21PM +0530, Anshuman Khandual wrote:
> 
> 
> On 3/5/21 8:21 PM, Mark Rutland wrote:
> > On Fri, Mar 05, 2021 at 08:06:09PM +0530, Anshuman Khandual wrote:
> >> From: James Morse <james.morse@arm.com>
> >>
> >> As per ARM ARM DDI 0487G.a, when FEAT_LPA2 is implemented, ID_AA64MMFR0_EL1
> >> might contain a range of values to describe supported translation granules
> >> (4K and 16K pages sizes in particular) instead of just enabled or disabled
> >> values. This changes __enable_mmu() function to handle complete acceptable
> >> range of values (depending on whether the field is signed or unsigned) now
> >> represented with ID_AA64MMFR0_TGRAN_SUPPORTED_[MIN..MAX] pair. While here,
> >> also fix similar situations in EFI stub and KVM as well.
> >>
> >> Cc: Catalin Marinas <catalin.marinas@arm.com>
> >> Cc: Will Deacon <will@kernel.org>
> >> Cc: Marc Zyngier <maz@kernel.org>
> >> Cc: James Morse <james.morse@arm.com>
> >> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> >> Cc: Ard Biesheuvel <ardb@kernel.org>
> >> Cc: Mark Rutland <mark.rutland@arm.com>
> >> Cc: linux-arm-kernel@lists.infradead.org
> >> Cc: kvmarm@lists.cs.columbia.edu
> >> Cc: linux-efi@vger.kernel.org
> >> Cc: linux-kernel@vger.kernel.org
> >> Signed-off-by: James Morse <james.morse@arm.com>
> >> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> >> ---
> >>  arch/arm64/include/asm/sysreg.h           | 20 ++++++++++++++------
> >>  arch/arm64/kernel/head.S                  |  6 ++++--
> >>  arch/arm64/kvm/reset.c                    | 23 ++++++++++++-----------
> >>  drivers/firmware/efi/libstub/arm64-stub.c |  2 +-
> >>  4 files changed, 31 insertions(+), 20 deletions(-)
> >>
> >> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
> >> index dfd4edb..d4a5fca9 100644
> >> --- a/arch/arm64/include/asm/sysreg.h
> >> +++ b/arch/arm64/include/asm/sysreg.h
> >> @@ -796,6 +796,11 @@
> >>  #define ID_AA64MMFR0_PARANGE_48		0x5
> >>  #define ID_AA64MMFR0_PARANGE_52		0x6
> >>  
> >> +#define ID_AA64MMFR0_TGRAN_2_SUPPORTED_DEFAULT	0x0
> >> +#define ID_AA64MMFR0_TGRAN_2_SUPPORTED_NONE	0x1
> >> +#define ID_AA64MMFR0_TGRAN_2_SUPPORTED_MIN	0x2
> >> +#define ID_AA64MMFR0_TGRAN_2_SUPPORTED_MAX	0x7
> >
> > The TGRAN2 fields doesn't quite follow the usual ID scheme rules, so how
> > do we deteremine the max value? Does the ARM ARM say anything in
> > particular about them, like we do for some of the PMU ID fields?
> 
> Did not find anything in ARM ARM, regarding what scheme TGRAN2 fields
> actually follow. I had arrived at more restrictive 0x7 value, like the
> usual signed fields as the TGRAN4 fields definitely do not follow the
> unsigned ID scheme. Would restricting max value to 0x3 (i.e LPA2) be a
> better option instead ?

I don't think it helps much, as TGRAN64_2 doesn't even define 0x3.

So I think this patch is probably the best we can do, but the Arm ARM could
really do with describing the scheme here.

Will
