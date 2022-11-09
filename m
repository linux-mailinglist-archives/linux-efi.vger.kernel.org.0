Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AED5622F7D
	for <lists+linux-efi@lfdr.de>; Wed,  9 Nov 2022 16:57:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbiKIP5c (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 9 Nov 2022 10:57:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbiKIP5b (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 9 Nov 2022 10:57:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71F6C18E19
        for <linux-efi@vger.kernel.org>; Wed,  9 Nov 2022 07:57:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 232BBB81F2D
        for <linux-efi@vger.kernel.org>; Wed,  9 Nov 2022 15:57:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C668FC433B5
        for <linux-efi@vger.kernel.org>; Wed,  9 Nov 2022 15:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668009447;
        bh=+cbG+P4pWRIn9/14FBjUWr1ax6R29/2w6xMiXZGYvIU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=R+q3u3/xk9YZrSJTvFU3SmkYl/JUTiTdClqcRX+FrICZHNy89WLWtZHzCTw+LYLhA
         JsVm2fp4TUadCYhSHZHQ1NtnqA0fwv6YafFMh6RRuMYlWZ/bJUcXmeDGEcrH7PSi4u
         AZnITnxuZyR4ONlefmbzD4drebRvSEuXkE+ymgwYwb+p/xlrk4jFkFbLGYUcmhs3n9
         9v3kTElhfVzJOZy5RADqExqnlJCSGL4T8keYF8NwBL+5x7Qtj0XcgTPxBt/7KXTilF
         fPXENBXnYc/PjFF7e0Ps6TQHTFrPBkfVWGbjamM8Qx48BrWlzgVPBffD24diI0u+tn
         2D0ymaIKFC8ZA==
Received: by mail-lj1-f181.google.com with SMTP id l8so26362929ljh.13
        for <linux-efi@vger.kernel.org>; Wed, 09 Nov 2022 07:57:27 -0800 (PST)
X-Gm-Message-State: ACrzQf167vJCs8oLBnqdCJPzILzrA59QfwaUbeJgHM41YKOtDM9cFz83
        z0Pdhk7oflq71iF14e3GNFgFp+kNSYEA86uuVIc=
X-Google-Smtp-Source: AMsMyM7VcxUbqXHFk7AefvJkn9kp5fdCBZspp+TUev7R5hL8v79n1c5NCssZ1Koq1LQACJJhOysCAjZpQTelolS+43M=
X-Received: by 2002:a2e:87cd:0:b0:277:3662:3be4 with SMTP id
 v13-20020a2e87cd000000b0027736623be4mr19941466ljj.415.1668009445767; Wed, 09
 Nov 2022 07:57:25 -0800 (PST)
MIME-Version: 1.0
References: <20221108151509.2250968-1-ardb@kernel.org> <Y2u8YRlOoWrirMK+@monolith.localdoman>
In-Reply-To: <Y2u8YRlOoWrirMK+@monolith.localdoman>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 9 Nov 2022 16:57:14 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGeOEvybuvTL-Q8gMdB08UooZ0pNep2Wn1Y6v14Um1osw@mail.gmail.com>
Message-ID: <CAMj1kXGeOEvybuvTL-Q8gMdB08UooZ0pNep2Wn1Y6v14Um1osw@mail.gmail.com>
Subject: Re: [PATCH] arm64: efi: Disable only the misbehaving runtime service
 on sync exceptions
To:     Alexandru Elisei <alexandru.elisei@arm.com>
Cc:     linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        catalin.marinas@arm.com, will@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 9 Nov 2022 at 15:42, Alexandru Elisei <alexandru.elisei@arm.com> wrote:
>
> Hi,
>
> On Tue, Nov 08, 2022 at 04:15:09PM +0100, Ard Biesheuvel wrote:
> > Alexandru reports that his Ampere Altra machine, whose buggy firmware
> > triggers a synchronous exception in its implementation of SetTime() when
> > called without SetVirtualAddressMap() having been called first, doesn't
> > quite recover from this, and starts spewing error messages into the log
> > that are unrelated to the buggy runtime service.
> >
> > The driver in question is the EFI RTC driver, which should be fixed in
> > any case, as flooding the log like that (or doing any logging to the
> > kernel log at all on something whuch is not a severe issue) is not ok.
> >
> > However, in this particular case, it would be beneficial for both
> > ordinary use as well as diagnostics regarding broken firmware if we only
> > prevent the broken runtime service from being called again, and permit
> > others (such as GetTime() which triggers the logging or the variable
> > services) from being used as normal.
> >
> > So wire up the existing efi.runtime_supported_mask, and clear the
> > service's bit in the mask if the generic runtime service wrapper
> > observes a return value of EFI_ABORTED, which only happens if a service
> > call is aborted due to an exception. (EFI_ABORTED is not documented as a
> > valid error code for any of the EFI runtime services).
>
> With a kernel built from v6.1-rc4, when doing efibootmgr after the EFI panic
> happens (so with runtime services disabled), this is what I get:
>
> # efibootmgr
> Skipping unreadable variable "Boot0001": Interrupted system call
> Skipping unreadable variable "Boot0002": Interrupted system call
> show_order(): Interrupted system call
>
> And dmesg shows:
>
> [   55.941312] efi: EFI Runtime Services are disabled!
>
> With this patch on top of v6.1-rc4:
>
> # efibootmgr
> Skipping unreadable variable "Boot0001": Invalid argument
> Skipping unreadable variable "Boot0002": Invalid argument
> show_order(): Invalid argument
>
> Same thing happens if I cat the Boot001 efivars file. Nothing is printed
> on dmesg.
>

OK, this strongly suggests that the EFI runtime services end up in a
funny state after the crash of SetTime(), and subsequent calls to any
of them no longer work as expected.

> Changed efi_call_rts() to print the return value, status is
> 0x8000_0000_0000_000f (or 15 in decimal if casted into an int). Tried to
> debug further, but I'm not familiar with all the structs and what they
> represent (for example, efi_call_virt(get_variable, args) calls
> efi_call_virt_pointer(efi.runtime, get_variable, args), does it end up as
> __efi_rt_asm_wrapper((efi.runtime)->get_variable, "get_variable", args?)

Indeed.

The value of the function pointer is used to make the indirect call,
and the string is only used if an error occurs, so we can print it to
the log. The remaining arguments are simply the arguments to the
firmware call.

> As
> an aside, it would be really helpful to document the arguments for
> __efi_rt_asm_wrapper. Pointers here how to debug further would be very
> welcome.
>

If the log is completely silent, there is not a lot to debug, really.

The error value you are observing is EFI_ACCESS_DENIED, and looking at
the open source version of the Mt.Jade firmware, this might be the
value returned from the secure world helper.

One other thing I would like to try is disabling set_time specifically
using a command line parameter.

Btw could you share the output of dmidecode as well?
