Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF5042DD252
	for <lists+linux-efi@lfdr.de>; Thu, 17 Dec 2020 14:43:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbgLQNm1 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 17 Dec 2020 08:42:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:54554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726488AbgLQNmT (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 17 Dec 2020 08:42:19 -0500
X-Gm-Message-State: AOAM5317Opw6ppz1MsY8IjY9jnogRClsjkz+F9RlPX+ieC0LCh915wFS
        RFENMzax91bqNRPFFWXw9Ezy3B0/8pH4hfoTFaw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608212499;
        bh=ER/3vyz6QmXexaKciGDwLoO8Jb6wAKkLOrgQjI6JTB8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SVgyzh07MHoiigHjzZXzYMau6P90bBcyj/kgK+ZICIcrxhvwXwerA1Q0ovOmAiPOb
         Yg0QFXVgO7j8/Sc1DL6kIuW0ik4svhsY+U/5YsHMUS+6jtAQ8ySnCElOGQ3RDT8neD
         SLDgftbzC+Kzr+N3UQCJkS9WOS1zsVLEgSbmML7f2+aTcv9Mptvk7fNHndNwVF81fs
         IDXT8X8y5L5Mk1t8xEVTRL/5OMfWTndw6rSjn7KzMOH3LTIZPSSZYaG97mH6JcNEWS
         q4cKqYM859jHf2vH7OvIHD7nW3Zpj9KOMVMUAtCxvGVcnSC6u12feZf1IVgqmTeiCY
         bZFTDp1jjCETg==
X-Google-Smtp-Source: ABdhPJxvfnmPF+VJoic606sWqwPtqfOLEA0PxNQEbf8WwouJ1WCMXn6kRcPWqfsVeVnGhlIpEJWcv3sCH72qoIsY7oI=
X-Received: by 2002:a05:6830:1c24:: with SMTP id f4mr28679651ote.108.1608212498287;
 Thu, 17 Dec 2020 05:41:38 -0800 (PST)
MIME-Version: 1.0
References: <242ea718-89f8-e74f-e48a-e6b0fa436ed1@computerix.info>
 <CAMj1kXHSSZftuv-M9Gg-V+XFTJtFtii8Jfqin03kstSuF9DRJA@mail.gmail.com> <21bee914-35d0-c33d-b68c-20574f8e6fb6@computerix.info>
In-Reply-To: <21bee914-35d0-c33d-b68c-20574f8e6fb6@computerix.info>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 17 Dec 2020 14:41:27 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFDN6Y_xpywzksBhYh-S9BuFuDRgfAOdWrUN6LTuKc+WQ@mail.gmail.com>
Message-ID: <CAMj1kXFDN6Y_xpywzksBhYh-S9BuFuDRgfAOdWrUN6LTuKc+WQ@mail.gmail.com>
Subject: Re: Efistub patch breaks 5.10 for me
To:     Klaus Kusche <klaus.kusche@computerix.info>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        "Limonciello, Mario" <mario.limonciello@dell.com>,
        Jacobo Pantoja <jacobopantoja@gmail.com>,
        Peter Jones <pjones@redhat.com>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 17 Dec 2020 at 14:39, Klaus Kusche <klaus.kusche@computerix.info> wrote:
>
>
> Hello,
>
> On 17/12/2020 13:41, Ard Biesheuvel wrote:
> >> tried to boot 5.10.1 (my first attempt to boot a 5.10.x).
> >>
> >> Displays
> >>
> >> EFI stub: WARNING: [Firmware Bug]: LoadOptions is an EFI_LOAD_OPTION descriptor
> >> EFI stub: WARNING: [Firmware Bug]: Using OptionalData as a workaround
> >>
> >> for one or two seconds on the notebook display.
> >>
> >> Then, the notebook display becomes completely black
> >> and the notebook does not boot and does not react to anything
> >> (hard poweroff needed).
> >
> > Hello Klaus,
> >
> > Please try reverting
> >
> > 4a568ce29d3f48df95919f82a80e4b9be7ea0dc1
> >
> > "efi/x86: Add a quirk to support command line arguments on Dell EFI firmware"
>
> Thanks for the quick response.
>
> Efistub is *not* the culprit:
>
> With the patch reverted, the two efistub error messages are gone.
> And with the two errormessages not occupying the display and my attention,
> I noticed that the kernel actually came up for fractions of a second
> before the display went dark.
>
> AMD radeon seems to be the culprit:
> After unconfiguring it, the system comes up fine in text mode,
> both with and without the efistub patch.
>
> And with the efistub patch applied,
> dmesg actually shows an empty command line instead of the \x01,
> as it should.
>

Thanks for reporting back, and good luck debugging the radeon driver :-)
