Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 752FA7CDC73
	for <lists+linux-efi@lfdr.de>; Wed, 18 Oct 2023 14:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbjJRM5j (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 18 Oct 2023 08:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjJRM5i (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 18 Oct 2023 08:57:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9803810E
        for <linux-efi@vger.kernel.org>; Wed, 18 Oct 2023 05:57:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 404B0C433C7
        for <linux-efi@vger.kernel.org>; Wed, 18 Oct 2023 12:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697633857;
        bh=c9MBpQITSX+16kTGqdlN7x+Ipnx1dwwTbv4UGwACLs0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FQZqTKclMK51NpvOL2MiMOx7+E41yAu2787qHKYudYotRNLxzKAZs2Ulk8v+oV9x8
         3drqfVcne73TP6+04JGPrS+7TbmIuhpEknLNJRXq4laQ+SUDuz76rq8zSwnKxHw61k
         NvSEZRytEoUsz8b8Vok0R3ARfCzIsDPatdtqDN2RgGs1fhBsnuKsFa2p3d4gpx0t5m
         oLGM0iOiO2WDYPeNfmBSWgnV+1VnXoJUTxeTBxpYFdkwsXifxBCFL/waJp7sxkWti6
         JkGQirp4ZIyGU2lVN57iDj3awlYgBucsxfWVWTmPVSOPJLXFwax82+OBsXySEE496r
         Kj9TR18sZX7Pg==
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2c501bd6ff1so80496531fa.3
        for <linux-efi@vger.kernel.org>; Wed, 18 Oct 2023 05:57:37 -0700 (PDT)
X-Gm-Message-State: AOJu0Yxj6NOaEWfUQzSQKx3LAR0O9rTQK3gQL99UPWwSVI1nrmYo2PlC
        MD7704iVjqhWS7z1iE146gwDPqfpqUFw7qt+fUM=
X-Google-Smtp-Source: AGHT+IE4rFJ7G56Ssvh7W/eWpDsh3xPve7bl/IEzD0o1CMX006suwurit4VKPPC+q5aF2xuY7HuDKlymKDisRljnXZY=
X-Received: by 2002:a2e:9056:0:b0:2c5:19f2:4fde with SMTP id
 n22-20020a2e9056000000b002c519f24fdemr3898463ljg.23.1697633855450; Wed, 18
 Oct 2023 05:57:35 -0700 (PDT)
MIME-Version: 1.0
References: <20231017132510.3845531-4-ardb@google.com> <ZS+rmaT2SAGdBxat@gmail.com>
 <CAGnOC3YBN06Y5HkxLXcoWFMaS7hDFP=4Ug_p2qee9CD++a0Bgw@mail.gmail.com> <ZS/QFF/afdftXiaU@gmail.com>
In-Reply-To: <ZS/QFF/afdftXiaU@gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 18 Oct 2023 14:57:24 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEPhwOMgiFHLfUyz4sR61rcxtLXzZKnkf+wL+EywvteuQ@mail.gmail.com>
Message-ID: <CAMj1kXEPhwOMgiFHLfUyz4sR61rcxtLXzZKnkf+wL+EywvteuQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] x86/boot: Fix boot_params init in EFI stub
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Ard Biesheuvel <ardb@google.com>, linux-efi@vger.kernel.org,
        x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 18 Oct 2023 at 14:31, Ingo Molnar <mingo@kernel.org> wrote:
>
>
> * Ard Biesheuvel <ardb@google.com> wrote:
>
> > On Wed, Oct 18, 2023 at 11:55=E2=80=AFAM Ingo Molnar <mingo@kernel.org>=
 wrote:
> > >
> > >
> > > * Ard Biesheuvel <ardb@google.com> wrote:
> > >
> > > > From: Ard Biesheuvel <ardb@kernel.org>
> > > >
> > > > v2:
> > > > add separate patch to rename the decompressor's version of the
> > > > boot_params global variable
> > > >
> > > > Ard Biesheuvel (2):
> > > >   x86/boot: Rename conflicting boot_params pointer to boot_params_p
> > > >   x86/boot: efistub: Assign global boot_params variable
> > > >
> > > >  arch/x86/boot/compressed/acpi.c         | 14 +++++------
> > > >  arch/x86/boot/compressed/cmdline.c      |  4 +--
> > > >  arch/x86/boot/compressed/ident_map_64.c |  7 +++---
> > > >  arch/x86/boot/compressed/kaslr.c        | 26 ++++++++++----------
> > > >  arch/x86/boot/compressed/mem.c          |  6 ++---
> > > >  arch/x86/boot/compressed/misc.c         | 24 +++++++++---------
> > > >  arch/x86/boot/compressed/misc.h         |  1 -
> > > >  arch/x86/boot/compressed/pgtable_64.c   |  9 +++----
> > > >  arch/x86/boot/compressed/sev.c          |  2 +-
> > > >  arch/x86/include/asm/boot.h             |  2 ++
> > > >  drivers/firmware/efi/libstub/x86-stub.c |  2 ++
> > > >  11 files changed, 50 insertions(+), 47 deletions(-)
> > >
> > > Thanks!
> > >
> > > I renamed 'boot_params_p' to 'boot_params_ptr' for clarity - fortunat=
ely
> > > haven't run out of 't' and 'r' letters yet in the kernel.
> > >
> >
> > OK thanks.
> >
> > I noticed you queued this up for v6.7.
> > So what should we do for v6.6 wrt the second patch?
>
> I presumed you'd queue it up in the EFI tree, and I'll merge it & resolve
> the conflict once it hits upstream?
>

Yup, works for me - I just wanted to double check.
