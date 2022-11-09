Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4057362302E
	for <lists+linux-efi@lfdr.de>; Wed,  9 Nov 2022 17:30:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbiKIQa5 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 9 Nov 2022 11:30:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbiKIQa5 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 9 Nov 2022 11:30:57 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 78C7D18E01
        for <linux-efi@vger.kernel.org>; Wed,  9 Nov 2022 08:30:53 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BC7B11FB;
        Wed,  9 Nov 2022 08:30:54 -0800 (PST)
Received: from monolith.localdoman (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E227C3F73D;
        Wed,  9 Nov 2022 08:30:33 -0800 (PST)
Date:   Wed, 9 Nov 2022 16:30:14 +0000
From:   Alexandru Elisei <alexandru.elisei@arm.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        catalin.marinas@arm.com, will@kernel.org
Subject: Re: [PATCH] arm64: efi: Disable only the misbehaving runtime service
 on sync exceptions
Message-ID: <Y2vVltMDbhzuVYm2@monolith.localdoman>
References: <20221108151509.2250968-1-ardb@kernel.org>
 <Y2u8YRlOoWrirMK+@monolith.localdoman>
 <CAMj1kXGeOEvybuvTL-Q8gMdB08UooZ0pNep2Wn1Y6v14Um1osw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXGeOEvybuvTL-Q8gMdB08UooZ0pNep2Wn1Y6v14Um1osw@mail.gmail.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi,

On Wed, Nov 09, 2022 at 04:57:14PM +0100, Ard Biesheuvel wrote:
> On Wed, 9 Nov 2022 at 15:42, Alexandru Elisei <alexandru.elisei@arm.com> wrote:
> >
> > Hi,
> >
> > On Tue, Nov 08, 2022 at 04:15:09PM +0100, Ard Biesheuvel wrote:
> > > Alexandru reports that his Ampere Altra machine, whose buggy firmware
> > > triggers a synchronous exception in its implementation of SetTime() when
> > > called without SetVirtualAddressMap() having been called first, doesn't
> > > quite recover from this, and starts spewing error messages into the log
> > > that are unrelated to the buggy runtime service.
> > >
> > > The driver in question is the EFI RTC driver, which should be fixed in
> > > any case, as flooding the log like that (or doing any logging to the
> > > kernel log at all on something whuch is not a severe issue) is not ok.
> > >
> > > However, in this particular case, it would be beneficial for both
> > > ordinary use as well as diagnostics regarding broken firmware if we only
> > > prevent the broken runtime service from being called again, and permit
> > > others (such as GetTime() which triggers the logging or the variable
> > > services) from being used as normal.
> > >
> > > So wire up the existing efi.runtime_supported_mask, and clear the
> > > service's bit in the mask if the generic runtime service wrapper
> > > observes a return value of EFI_ABORTED, which only happens if a service
> > > call is aborted due to an exception. (EFI_ABORTED is not documented as a
> > > valid error code for any of the EFI runtime services).
> >
> > With a kernel built from v6.1-rc4, when doing efibootmgr after the EFI panic
> > happens (so with runtime services disabled), this is what I get:
> >
> > # efibootmgr
> > Skipping unreadable variable "Boot0001": Interrupted system call
> > Skipping unreadable variable "Boot0002": Interrupted system call
> > show_order(): Interrupted system call
> >
> > And dmesg shows:
> >
> > [   55.941312] efi: EFI Runtime Services are disabled!
> >
> > With this patch on top of v6.1-rc4:
> >
> > # efibootmgr
> > Skipping unreadable variable "Boot0001": Invalid argument
> > Skipping unreadable variable "Boot0002": Invalid argument
> > show_order(): Invalid argument
> >
> > Same thing happens if I cat the Boot001 efivars file. Nothing is printed
> > on dmesg.
> >
> 
> OK, this strongly suggests that the EFI runtime services end up in a
> funny state after the crash of SetTime(), and subsequent calls to any
> of them no longer work as expected.
> 
> > Changed efi_call_rts() to print the return value, status is
> > 0x8000_0000_0000_000f (or 15 in decimal if casted into an int). Tried to
> > debug further, but I'm not familiar with all the structs and what they
> > represent (for example, efi_call_virt(get_variable, args) calls
> > efi_call_virt_pointer(efi.runtime, get_variable, args), does it end up as
> > __efi_rt_asm_wrapper((efi.runtime)->get_variable, "get_variable", args?)
> 
> Indeed.
> 
> The value of the function pointer is used to make the indirect call,
> and the string is only used if an error occurs, so we can print it to
> the log. The remaining arguments are simply the arguments to the
> firmware call.

Got it, thanks for the explanation.

> 
> > As
> > an aside, it would be really helpful to document the arguments for
> > __efi_rt_asm_wrapper. Pointers here how to debug further would be very
> > welcome.
> >
> 
> If the log is completely silent, there is not a lot to debug, really.
> 
> The error value you are observing is EFI_ACCESS_DENIED, and looking at
> the open source version of the Mt.Jade firmware, this might be the
> value returned from the secure world helper.
> 
> One other thing I would like to try is disabling set_time specifically
> using a command line parameter.

Hm... had a look at kernel_parameters.txt and the rtc-efi driver and
couldn't figure out how to do that. I could just return 0 early from
efi_set_time(), I suppose. Is that what you had in mind?

> 
> Btw could you share the output of dmidecode as well?

Sure, you can find it at [1] (expires in 6 months, pastebin is unlisted).
If it makes a difference, dmidecode was run with the stock Ubuntu kernel
(v5.15).

[1] https://pastebin.com/eaL2LRCf

Thanks,
Alex
