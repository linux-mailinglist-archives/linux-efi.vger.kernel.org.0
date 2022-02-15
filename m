Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1623A4B78EA
	for <lists+linux-efi@lfdr.de>; Tue, 15 Feb 2022 21:53:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242131AbiBORD6 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 15 Feb 2022 12:03:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242132AbiBORD5 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 15 Feb 2022 12:03:57 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C90EF11941C;
        Tue, 15 Feb 2022 09:03:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7BBF6B81B82;
        Tue, 15 Feb 2022 17:03:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DBCAC340F3;
        Tue, 15 Feb 2022 17:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644944624;
        bh=T8kc+LHaHToL5taLqE2WnvQ4eDDGqqRKHydxVIzSff8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=P7Q1EpfCHrGdZlA1lH7d/TKZqguDWT7sINidykAbJEEiYopl6sWPkQlvcJ5hle7jh
         aQQI08Ud00OYs2L1BXHrtP/yxkgi9GMY/QUN5nogodKFwBeXLZMmoD2yMZJPFnJmwE
         2qWZZzIyUuaw5I8Hbx3IKySfxF++bQFMFYpF48c0fdSKrVcwsJrGfv9xdiaWoaUR2i
         QKfOtoYY3gP8pBSt0JTZ3IBhO/RvAgDunix5kzsr1NBuACt9IkdTngYU+2nMA9o8Nw
         EMK8S5XT4hjJwQCpi7dRjn6eJoTjPqHLo7qRPHzYbeU3dwtQwNZvuOEj2Z4wqRgGjs
         hMvf0FDlR2ftA==
Received: by mail-wr1-f42.google.com with SMTP id o24so30575174wro.3;
        Tue, 15 Feb 2022 09:03:44 -0800 (PST)
X-Gm-Message-State: AOAM531PxEINdNBUpgt+tyOeHq+iysx6t3FUseg96+/JYPCVpOT6M7xG
        8CugJUgPb0NRZjAV88POXoxtkMJHXKm8moSJFPc=
X-Google-Smtp-Source: ABdhPJzYoJ3RIILNZxJnnai/1N5aDrtVl0fpG9dEfhshR4BKpRrwl19hBLXuWlv4eXaEE6WY1PX8zxmfh1FzE6N2bPg=
X-Received: by 2002:a5d:598d:: with SMTP id n13mr4058713wri.447.1644944622559;
 Tue, 15 Feb 2022 09:03:42 -0800 (PST)
MIME-Version: 1.0
References: <YfP0osb45uJldtM9@localhost.localdomain> <YfQTZTUNaeGi+8tG@FVFF77S0Q05N>
 <YfRorCpk0seVGI+5@localhost.localdomain> <Yfk8hQB1eon7oeYU@FVFF77S0Q05N>
 <79bcce92-abb2-4c3e-7193-d18e144da8a0@nokia.com> <489b76f9-fbaf-dae0-c90d-c52ee0de92a4@roeck-us.net>
 <YgvAO1UbZcbcj5na@localhost.localdomain> <be9cc279-1d62-3d57-9347-6cfaffc00cb4@roeck-us.net>
In-Reply-To: <be9cc279-1d62-3d57-9347-6cfaffc00cb4@roeck-us.net>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 15 Feb 2022 18:03:30 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGQhKuwdATd=SrhBFXZkKMHiFWsrq7m+AY-hFLM3Ltcyg@mail.gmail.com>
Message-ID: <CAMj1kXGQhKuwdATd=SrhBFXZkKMHiFWsrq7m+AY-hFLM3Ltcyg@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: move efi_reboot to restart handler
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Krzysztof Adamski <krzysztof.adamski@nokia.com>,
        Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Matija Glavinic-Pecotic <matija.glavinic-pecotic.ext@nokia.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 15 Feb 2022 at 17:57, Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 2/15/22 07:01, Krzysztof Adamski wrote:
> > Dnia Tue, Feb 15, 2022 at 06:30:26AM -0800, Guenter Roeck napisa=C5=82(=
a):
> >> On 2/15/22 00:44, Alexander Sverdlin wrote:
> >>> Hello Mark, Ard,
> >>>
> >>> On 01/02/2022 14:58, Mark Rutland wrote:
> >>>>> You could argue that restart handlers were not created for that but=
 they
> >>>>> suit this purpose ideally and it wouldn't make much sense (in my
> >>>>> opinion) to add yet another notifier chain that would run before re=
set
> >>>>> notifiers, for code that is not supposed to reset the whole system =
and
> >>>>> this is exacly what I would have to do if efi_reboot() is forced to=
 be
> >>>>> called before all handlers.
> >>>>
> >>>> As above, I think that's just using the wrong interface, and the reb=
oot
> >>>> notifier mechanism *already* exists, so I'm really confused here.
> >>>>
> >>>> Have I misunderstood what you're trying to achieve?
> >>>>
> >>>> Is there some problem with the reboot notifier mechanism that I am u=
naware of?
> >>>> e.g. do we bypass them in some case where you think they're needed?
> >>>>
> >>>> Are you simply unaware of reboot notifiers?
> >>>
> >>> Could you please check the simple case of pwrseq_emmc.c?
> >>>
> >>> While that's currently the only example of this kind upstream I can i=
magine
> >>> further use-cases, especially in storage area like above.
> >>>
> >>> Would you suggest it's illegal usage of register_restart_handler()?
> >>> Do we need to fix pwrseq_emmc.c by introducing new atomic notifier ch=
ain
> >>> which will be called before restart handlers, so that it works on
> >>> emergency_restart()?
> >>>
> >>
> >> Abuse isn't just about using an API for something it isn't originally =
intended
> >> for, abuse is also to intentionally _not_ use an API, as it is current=
ly done
> >> by the EFI restart code for arm64. Also, keep in mind that the same ar=
gument
> >> (our restart handler _must_ be executed under all circumstances and do=
es therefore
> >> not use the restart API) is likely going to be used again in the futur=
e. All
> >> it takes is for some other standard (or chip vendor, for that matter) =
to declare
> >> their restart handler mandatory if present.
> >
> > Wait, but it is up to us to decide if we want to follow such standard o=
r
> > not. If we want to have code that is more flexible, nobody can refuse u=
s
> > to do so, right? None of the standards says that we can't support
> > restart handlers in case of EFI on ARM64, it was decided by kernel
> > developers, not some vendors. We can change that.
> >
>
> Of course it was decided by kernel developers. Point is that they use
> the EFI standard as argument for bypassing the API. What I am saying is
> that others can (and likely will, since the flood doors have been opened)
> do the same in the future, using the same line of arguments.
>

I don't think anyone was doing what you describe here. My primary
point was that platforms should not implement and expose EFI reset if
that implementation fails to deal with the platform's peripherals
adequately.

> >> Given that, I'd suggest to cut your losses and try to find another
> >> solution for your problem. That may be to introduce yet another API,
> >> one that is called before the EFI restart handling but that is always
> >> called, unlike reboot notifiers, or simply stick with out-of-tree code=
.
> >
> > Sure I could create yet another API like you suggest but in practice it
> > would be a copy of existing API as i would have to work exactly the
> > same - would be called at the same time in the same situations. The onl=
y
> > thing that would be different would be separate chain.
>
> Correct.
>
> > But if we want to prevent registering some custom code to be run before=
 > efi_reboot(), that new API would have to be rejected as well, for the
> > same reason. So what is the point?
> >
>
> Ah, yes, you are right. The emmc example does reset the emmc, after all,
> which one could use as argument that it "violates" the EFI mandate.
> Sorry, I guess you'll be stuck with out-of-tree code (and, realistically,
> so is everyone using emmc in an arm64 based system with an EFI restart
> handler which does not implement emmc reset). Actually, turns out that
> the emmc restart handling code is not reliable anyway, since for example
> x86 doesn't use/support the restart handler call chain, and neither
> do several other architectures.
>

Rich firmware like EFI and ACPI implies that the firmware knows how to
manage the hardware.

> Interestingly, in this context, x86 isn't as inflexible as arm64 and does
> support other means to reset the system even in the presence of EFI
> (and actually seems to prefer ACPI reset over EFI reset unless I
> misunderstand the code).
>

No, correct. This is primarily for historical reasons and for parity
with Windows/x86 which does the same (which means that on many cheap
Wintel laptops, ACPI reset is the only thing that works)

> Other options for you might be to disable EFI restart handling in your
> system (assuming that is possible), or to implement the necessary code
> as part of the EFI restart handler, ie outside Linux, again if that is
> possible.
>

Either implement EFI reset properly, or not at all. Adding code to the
OS that forces it to reason about whether or not EFI reset can be
called safely simply means that the EFI implementation is broken and
should probably be avoided entirely.
