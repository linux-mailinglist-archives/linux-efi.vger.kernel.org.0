Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67C6C690E47
	for <lists+linux-efi@lfdr.de>; Thu,  9 Feb 2023 17:23:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbjBIQXS (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 9 Feb 2023 11:23:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjBIQXS (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 9 Feb 2023 11:23:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 324BA22035
        for <linux-efi@vger.kernel.org>; Thu,  9 Feb 2023 08:23:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C1E9161B45
        for <linux-efi@vger.kernel.org>; Thu,  9 Feb 2023 16:23:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DC69C433A1
        for <linux-efi@vger.kernel.org>; Thu,  9 Feb 2023 16:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675959796;
        bh=HNn/8UgLUepal04HCv3vdi6oO4AwtQ/rmWusZCnnJP0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=K0Q7SMPYtde/BMyk01RYfDiLtK3V4poMSfnylxmgDfsSBH+50Qac7dlCoSy3+kaCL
         6huvDYVkhyfEGix7k6/MYahCbKMPB//g7cjuZ4b5Wp/eWRaGzK4T817UisVsiALmh3
         hpv4eVQHsOmIv/3amdyDP0MhqP1duQydIGUzQaTbfoB1+JmcsEwZIafMNxS0voeCIS
         ZVbH6DWH/AQb+gSyez4pwKYZ9gypPM1aaqrLwIqrD+4CJqiYJtwIawxlkE4FmOgSpM
         FntfGdlZ1GYnGxEfepGF9W6Ht6HIsXcu3G2VKC2RdHyZg+1SY6+9yy79Ja6l337oO7
         GOMKlcDGjr9eg==
Received: by mail-lf1-f44.google.com with SMTP id bp15so3810120lfb.13
        for <linux-efi@vger.kernel.org>; Thu, 09 Feb 2023 08:23:16 -0800 (PST)
X-Gm-Message-State: AO0yUKUjNLCtzEQM66b3CqxJAk6HRtzVaMkU5WGT7PLTzguFHyX4ZgjV
        bZsa98LeJgwCkOCpdMeCLrJk+4XEE/4Zzr8Al4E=
X-Google-Smtp-Source: AK7set9OmLxwTlEfor4671qJxoNP1kYDFUvHj9M893MINcLfRo1n0r78K52P9YSi4mlPbKZyqLrhlmH1PubkC4Ydw2s=
X-Received: by 2002:ac2:5633:0:b0:4da:ff30:3998 with SMTP id
 b19-20020ac25633000000b004daff303998mr1925746lff.198.1675959794116; Thu, 09
 Feb 2023 08:23:14 -0800 (PST)
MIME-Version: 1.0
References: <20230206124938.272988-1-ardb@kernel.org> <20230206124938.272988-4-ardb@kernel.org>
 <ca9dc359-899b-ec69-36e0-17225189da01@intel.com> <Y+QCvSmdrqaJjxoT@hirez.programming.kicks-ass.net>
 <Y+QMNzjz0l8cnW4Y@FVFF77S0Q05N.cambridge.arm.com> <63e51b92.170a0220.ca7b5.2b23@mx.google.com>
In-Reply-To: <63e51b92.170a0220.ca7b5.2b23@mx.google.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 9 Feb 2023 17:23:02 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHZwKPifJu1Y+hvjivJWU9YMJHyR84Y23nMsYrCxM0uYw@mail.gmail.com>
Message-ID: <CAMj1kXHZwKPifJu1Y+hvjivJWU9YMJHyR84Y23nMsYrCxM0uYw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] efi: x86: Wire up IBT annotation in memory
 attributes table
To:     Kees Cook <keescook@chromium.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@intel.com>, linux-efi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 9 Feb 2023 at 17:13, Kees Cook <keescook@chromium.org> wrote:
>
> On Wed, Feb 08, 2023 at 08:55:19PM +0000, Mark Rutland wrote:
> > On Wed, Feb 08, 2023 at 09:14:53PM +0100, Peter Zijlstra wrote:
> > > On Wed, Feb 08, 2023 at 07:17:15AM -0800, Dave Hansen wrote:
> > > > On 2/6/23 04:49, Ard Biesheuvel wrote:
> > > > > --- a/arch/x86/kernel/apm_32.c
> > > > > +++ b/arch/x86/kernel/apm_32.c
> > > > > @@ -609,7 +609,7 @@ static long __apm_bios_call(void *_call)
> > > > >
> > > > >         apm_irq_save(flags);
> > > > >         firmware_restrict_branch_speculation_start();
> > > > > -       ibt = ibt_save();
> > > > > +       ibt = ibt_save(true);
> > > >
> > > > My only nit with these is the bare use of 'true'/'false'.  It's
> > > > impossible to tell at the call-site what the 'true' means.  So, if you
> > > > happen to respin these and see a nice way to remedy this I'd appreciate it.
> > >
> > > I've often wished for a named argument extention to C, much like named
> > > initializers, such that one can write:
> > >
> > >     ibt_save(.disable = true);
> > >
> > > Because the thing you mention is very common with boolean arguments, the
> > > what gets lost in the argument name and true/false just isn't very
> > > telling.
> > >
> > > But yeah, even if by some miracle all compiler guys were like, YES! and
> > > implemented it tomorrow, we couldn't use it for a good few years anyway
> > > :-/
> >
> > Well... ;)
> >
> > | [mark@lakrids:~]% cat args.c
> > | #include <stdbool.h>
> > | #include <stdio.h>
> > |
> > | struct foo_args {
> > |     bool enable;
> > |     unsigned long other;
> > | };
> > |
> > | void __foo(struct foo_args args)
> > | {
> > |     printf("foo:\n"
> > |            "  enable: %s\n"
> > |            "  other: 0x%lx\n",
> > |            args.enable ? "YES" : "NO",
> > |            args.other);
> > | }
> > |
> > | #define foo(args...) \
> > |     __foo((struct foo_args) { args })
> > |
> > |
> > | int main(int argc, char *argv[])
> > | {
> > |     foo(true);
> > |     foo(.enable = true);
> > |     foo(false, .other=0xdead);
> > | }
> > | [mark@lakrids:~]% gcc args.c -o args
> > | [mark@lakrids:~]% ./args
> > | foo:
> > |   enable: YES
> > |   other: 0x0
> > | foo:
> > |   enable: YES
> > |   other: 0x0
> > | foo:
> > |   enable: NO
> > |   other: 0xdead
>
> I am horrified and delighted.

+1

> And the resulting codegen is identical:
> https://godbolt.org/z/eKTMPYc17
>
> Without this fancy solution, what I'd seen is just using an enum:
>
> enum do_the_thing {
>         THING_DISABLE = 0,
>         THING_ENABLE,
> };
>
> void foo(enum do_the_thing enable)
> {
>         if (enable) { ... }
> }
>
> foo(THING_ENABLE);
>

I have no strong preference one way or the other, but given that
apm_32.c is not the epicenter of new development, and the call from
EFI code is self-documenting already ('
ibt_save(efi_disable_ibt_for_runtime)', I'm inclined to just queue the
patch as-is, and leave it to whoever feels inclined to spend more free
time on this to come up with some nice polish to put on top.

Unless anyone minds?
