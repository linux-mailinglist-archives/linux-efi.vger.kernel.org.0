Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF73417240A
	for <lists+linux-efi@lfdr.de>; Thu, 27 Feb 2020 17:53:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730470AbgB0Qxg (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 27 Feb 2020 11:53:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:37390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727211AbgB0Qxg (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 27 Feb 2020 11:53:36 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F9BE2469F;
        Thu, 27 Feb 2020 16:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582822415;
        bh=FCpEczpISHL8j03AAQqFyL4qGLGWBbexvzcAmi6nUKw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=wW7QVVDuMTfXdNeCfIsChW07MzXyoK8XLlBGOtXMiWqPA7GvXvbVyJF2pfGTDUiXV
         qrP5uc7DkE4+yIAgI5O6cDDbwWeovrEAqIG5Zn8fBYP/dOK1eQb/y4U1mM4+li6Iey
         WBsVateRyNYB1kT4FU/kWhYy40szzoMrTUqQjMfU=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1j7MPl-008VgO-9G; Thu, 27 Feb 2020 16:53:33 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 27 Feb 2020 16:53:33 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Nicolas Pitre <nico@fluxnic.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v4 0/5] ARM: decompressor: use by-VA cache maintenance for
 v7 cores
In-Reply-To: <CAKv+Gu_smwr3RDW=B8BQ8AG1+aOibFHwvoTSR=F2TxDguV2ELQ@mail.gmail.com>
References: <20200226165738.11201-1-ardb@kernel.org>
 <CACRpkdZ9WR7wEjgscAF=Pwy0=YwbNPjtH6BQWa5wfXW74Md4xQ@mail.gmail.com>
 <91023d8f118440439cf55847a6bc43c2@kernel.org>
 <CAKv+Gu_smwr3RDW=B8BQ8AG1+aOibFHwvoTSR=F2TxDguV2ELQ@mail.gmail.com>
Message-ID: <bb66152dddd84d34d2cf8c7a98c486a1@kernel.org>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/1.3.10
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: ardb@kernel.org, linus.walleij@linaro.org, linux-arm-kernel@lists.infradead.org, linux-efi@vger.kernel.org, linux@armlinux.org.uk, nico@fluxnic.net, catalin.marinas@arm.com, tony@atomide.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 2020-02-27 16:47, Ard Biesheuvel wrote:
> On Thu, 27 Feb 2020 at 17:01, Marc Zyngier <maz@kernel.org> wrote:
>> 
>> On 2020-02-27 10:11, Linus Walleij wrote:
>> > On Wed, Feb 26, 2020 at 5:57 PM Ard Biesheuvel <ardb@kernel.org> wrote:
>> >
>> >> So instead, switch to the by-VA cache maintenance that the
>> >> architecture
>> >> requires for v7 and later (and ARM1176, as a side effect).
>> >>
>> >> Changes since v3:
>> >> - ensure that the region that is cleaned after self-relocation of the
>> >> zImage
>> >>   covers the appended DTB, if present
>> >>
>> >> Apologies to Linus, but due to this change, I decided not to take your
>> >> Tested-by into account, and I would appreciate it if you could retest
>> >> this version of the series? Thanks.
>> >
>> > No problem, I have tested it on the following:
>> >
>> > - ARMv7 Cortex A9 x 2 Qualcomm APQ8060 DragonBoard
>> > - ARM PB11MPCore (4 x 1176)
>> 
>> <pedant>
>> 
>> The ARM11MPCore isn't a bunch of 1176s glued together. It is actually 
>> a
>> very
>> different CPU, designed by a different team.
>> 
>> </pedant>
>> 
> 
> It still takes the same code path in the cache routines, afaict:
> - the architecture field in the main id register == 0xf, so it uses
> __armv7_mmu_cache_flush
> - ID_MMFR1[19:16] == 0x2, so it does not take the 'hierarchical' code
> path which is modified by these patches

Absolutely. From a SW perspective, this is treated in a similar way as
ARM1176. The underlying HW is very different though...

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
