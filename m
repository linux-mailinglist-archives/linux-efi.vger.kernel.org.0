Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F03B875B7C1
	for <lists+linux-efi@lfdr.de>; Thu, 20 Jul 2023 21:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbjGTTRC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-efi@lfdr.de>); Thu, 20 Jul 2023 15:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbjGTTRC (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 20 Jul 2023 15:17:02 -0400
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 596971724;
        Thu, 20 Jul 2023 12:16:58 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-57722942374so12517787b3.1;
        Thu, 20 Jul 2023 12:16:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689880617; x=1690485417;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y+bHV3WlEcZ75hM1I+DnSWXsr4f2F1LThXJkmj5KdE4=;
        b=kmGG7BPMfb5whwIGaZybAMyVRAQ3yhnvxqLoeHIaZKMzRbnO001RP5P0hWEHhI66hR
         kqRuDLtSYWMXayTFSidhTogC09v+Orw5+C4yTC3Ld/p/eyLkA6Vgqll1DmntGo2kmimN
         YhxwWhFiMj8iVT6YeBIkHTcrVioREwWnGt/h3937ejZ3qtwYrOFX3eO9/hMPFJp/PTm3
         BHSBafSKZQ0PRlDX+IYri4vYrLWY2LxvAsvq7Mo2mw24ZZyrech42A5t9Zwo2wn8T7Mc
         DereuH9i3p+zwqqAAvD+a4w8KonwRShVouZ5b/US+2X8c7M/kxnKmOVZCgqAEbDz50sZ
         b6CA==
X-Gm-Message-State: ABy/qLZlp73IgHshR3roknQwpSrfZGpcZEISUqWXJ2HXLVcztlHpdAak
        mgUpgL3Z2EytHA3Pn40oN7KpPhQaAqbxzd1v
X-Google-Smtp-Source: APBJJlGX2O0p91uEFy8Zeyzq+lRhpwzOQotn4tjf/GzeqjA+uIKptl+oJD1gdUArSm8PoAEQ/KRPjg==
X-Received: by 2002:a81:7dd7:0:b0:576:896a:dbc5 with SMTP id y206-20020a817dd7000000b00576896adbc5mr6845084ywc.48.1689880617299;
        Thu, 20 Jul 2023 12:16:57 -0700 (PDT)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com. [209.85.128.178])
        by smtp.gmail.com with ESMTPSA id n71-20020a0dcb4a000000b0057716dd93b7sm397094ywd.13.2023.07.20.12.16.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jul 2023 12:16:55 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-5774098f16eso12523877b3.0;
        Thu, 20 Jul 2023 12:16:55 -0700 (PDT)
X-Received: by 2002:a25:ada7:0:b0:cf0:3633:6c77 with SMTP id
 z39-20020a25ada7000000b00cf036336c77mr5672353ybi.63.1689880615375; Thu, 20
 Jul 2023 12:16:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230711154449.1378385-1-eesposit@redhat.com> <ZK/9MlTh435FP5Ji@gambale.home>
 <ZLABozIRVGmwuIBf@gambale.home> <ba2354dc63fd741d2d351b18d4312d0771c0935d.camel@HansenPartnership.com>
 <ZLVyvAXwtemx1I6p@redhat.com> <0aa647f719103e8620d7209cbde40f04a7334749.camel@HansenPartnership.com>
 <FBDC67DD-856F-429B-8E91-B0CA8B0F24B9@oracle.com>
In-Reply-To: <FBDC67DD-856F-429B-8E91-B0CA8B0F24B9@oracle.com>
From:   Luca Boccassi <bluca@debian.org>
Date:   Thu, 20 Jul 2023 20:16:43 +0100
X-Gmail-Original-Message-ID: <CAMw=ZnQ5pjwJZdX9kyib=vFd_c5_5_eUhV_mT5OcRPt693m=Yg@mail.gmail.com>
Message-ID: <CAMw=ZnQ5pjwJZdX9kyib=vFd_c5_5_eUhV_mT5OcRPt693m=Yg@mail.gmail.com>
Subject: Re: [RFC PATCH v2] x86/boot: add .sbat section to the bzImage
To:     Eric Snowberg <eric.snowberg@oracle.com>
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "lennart@poettering.net" <lennart@poettering.net>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        open list <linux-kernel@vger.kernel.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        Jarkko Sakkinen <jarkko@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 20 Jul 2023 at 18:11, Eric Snowberg <eric.snowberg@oracle.com> wrote:
>
> (add keyrings@ cc)
>
> > On Jul 17, 2023, at 11:15 AM, James Bottomley <James.Bottomley@hansenpartnership.com> wrote:
> >
> > On Mon, 2023-07-17 at 17:56 +0100, Daniel P. Berrangé wrote:
> >> On Mon, Jul 17, 2023 at 12:08:26PM -0400, James Bottomley wrote:
> >>> On Thu, 2023-07-13 at 15:52 +0200, Ard Biesheuvel wrote:
> >>>> (add linux-efi@ cc)
> >>>
> >>> Thanks for that, since this is really EFI related rather than x86.
> >>
> >> snip
> >>
> >>> The problem, as I see it, is if the distros give the kernel an
> >>> .sbat section, that means any vanilla kernel that's built by a user
> >>> and signed by their key now won't work (even if their key is in
> >>> MoK) because it won't have an sbat section ... and the sbat
> >>> mechanism is component specific, not key specific, so the signer
> >>> has no choice but to adopt it.
> >>
> >> AFAICT, that problem only exists for binaries directly invoked
> >> from shim. So that would be a problem for the boot loader (grub),
> >> or a kernel image being booted directly without a bootloader
> >> present.
> >
> > Well, currently, yes; that's the in_protocol check in
> > shim.c:verify_sbat_section().  However, I was assuming based on this
> > thread, that that was being tightened up (either because people are
> > moving away from grub or because the shim verifier protocol would
> > enforce it) as you imply below.
> >
> >> For kernel binaries invoked indirectly by the boot loader, the
> >> use of SBAT is currently optional. ie missing SBAT record would
> >> be treated as success.
> >>
> >> This was a pragmatic way to introduce SBAT support as it only
> >> impacted grub at that time.
> >>
> >> Once a distro starts adding SBAT to their kenrels too though, we
> >> can forsee that they would like to enforce SBAT for the whole
> >> boot chain, to prevent rollback to previously signed binaries
> >> that lacked SBAT info.
> >>
> >> This policy could be enforced per key though. eg require SBAT
> >> for anything verified against the vendor key that's compiled into
> >> shim, but not require SBAT for binaries verified with the MoK
> >> entries.
> >
> > That might work, but it's not currently in the shim code base.  It also
> > wouldn't work for SUSE I suspect: they actually put all of their distro
> > keys into MokList (so the machine owner has to approve any SUSE key
> > update), so how can shim tell the difference between my key and their
> > key?
> >
> >> The user specific MoK entries don't have such a compelling use
> >> case for SBAT, since if they need to revoke old binaries, the
> >> end users always have the easy fallback option of just rotating
> >> their signing keys and switching out the enrolled key in MoK.
> >>
> >> The choice of whether to mandate SBAT for binaries signed with
> >> a MoK entry, could be set by the end user themselves at the time
> >> their enroll their signing cert in the MoK DB.
> >
> > Well, I agree with this, since it was my original point.  However, a
> > key observation still seems to be that none of this exception proposal
> > is actually coded anywhere, so if shim does tighten up sbat
> > verification, everyone currently gets caught by it (and if it doesn't
> > then the kernel doesn't need an sbat section).
> >
> > I really think if this exception proposal is what everyone is planning,
> > then you can simply leave the upstream kernel alone, since it won't
> > require sbat information unless incorporated into a distro.
> >
> > So the direction forward seems to be to get this exception proposal
> > coded up and agreed and then we can decide based on that whether the
> > upstream kernel needs to care.
>
> I agree with James in the previous thread;  adding the SBAT section to
> the kernel should be handled by the signing tools. It really doesn't need to
> be included in the mainline kernel code. I also agree with the sentiment that
> mainline and the stable branches should not have SBAT versions attached
> to them. These are things distros should be responsible for including in their
> kernel if they want to have SBAT support.

Why would 'signing tools' handle that? It's just a text-based PE
section, it doesn't require access to private key materials to be
handled, nor it has any relationship with signing. Why should all the
(numerous) signing tools be extended to do also add arbitrary PE
sections? And again, the point is that it's not something you might or
might not want to have - if you are getting your Shim signed by the
3rd party CA, you need it, full stop, end of story. Without it, you
don't boot. So it needs to be easy to find and consume for all the
distributions/groups/projects that participate in the Shim + 3rd party
CA workflow, that's the main goal. Mistakes are going to be expensive.

> If a distro adds a SBAT section to either their UKI, or if kernel SBAT enforcement
> is turned on from GRUB2 by default, there is one piece missing that would need
> to be handled by the mainline kernel which is SBAT enforcement for kexec. This
> would mean the revocations SBAT protect against would need to be referenced
> before doing the signature validation in kexec. If this is not added, any distro that
> allows kexec really doesn’t have a SBAT protected kernel.

The kexec question is indeed interesting, but a bit further down the
road. As James said, initially protecting the stub is probably more
interesting and urgent, as the system before ExitBootServices is much
more "valuable" to protect. For the future, IIRC a few ideas were
floated, to avoid downgrades, but nothing concrete as far as I know.
