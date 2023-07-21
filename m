Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B812E75C22E
	for <lists+linux-efi@lfdr.de>; Fri, 21 Jul 2023 10:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbjGUI4A convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-efi@lfdr.de>); Fri, 21 Jul 2023 04:56:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjGUIz6 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 21 Jul 2023 04:55:58 -0400
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7462B2D71;
        Fri, 21 Jul 2023 01:55:56 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-5704fce0f23so18214747b3.3;
        Fri, 21 Jul 2023 01:55:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689929755; x=1690534555;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dse7od/G5Z7cPPLFT9TMDMB90ZkP6Ozs7OE/Onew+wA=;
        b=CJyfmT9bGhEyS0uBF+lzyQAC0jVrwOpQ5bXjsbPoXpp3kEgxZCYNctkuNzylFwEqq1
         CelKq4DVLIsjNcEAg4nFHRvm6YHNABdLSgTI8e8ptZVmxT0nsKy5VEUCffPfYMby5OvB
         EkfwTB1lGdrs/gHe/NyO8U7ySSlECEdpXeXBSKi/jYZCWVzX7aeqMG/PvhMrOOxndeec
         ihwB1V63lNXTKhJ+PsqhL4JE8RfR+6Z/fzuI77FfPQSBhg3IYh0ZztEz00wgRzdUICDo
         FruYYxYQ0Qf/PFc4O9lUhS3Do9iVXRya8xpkq0/qg2BSYeMYElrdv8cIVvDUvD/r7zqT
         UJ2Q==
X-Gm-Message-State: ABy/qLavmIxrUo37m/L/Nd44WvCs8j5gBdiu/yDcTu8g0487kG6edjGw
        gdzzMGB+mEiiREugs2KkYPEfP9Bqme8zjVns
X-Google-Smtp-Source: APBJJlEeKO7rTRIjmImc4kTgcciiOwZwVTVJP5CGHi8+TryjXsS2u5iIvx1bqQ0yaGzlEULmZKlSdg==
X-Received: by 2002:a0d:ce02:0:b0:583:1f86:8f9a with SMTP id q2-20020a0dce02000000b005831f868f9amr1404582ywd.37.1689929755394;
        Fri, 21 Jul 2023 01:55:55 -0700 (PDT)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com. [209.85.128.172])
        by smtp.gmail.com with ESMTPSA id z17-20020a81c211000000b00573898fb12bsm749648ywc.82.2023.07.21.01.55.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jul 2023 01:55:54 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-5774098f16eso18366987b3.0;
        Fri, 21 Jul 2023 01:55:53 -0700 (PDT)
X-Received: by 2002:a81:49d4:0:b0:57a:8906:4192 with SMTP id
 w203-20020a8149d4000000b0057a89064192mr1409466ywa.36.1689929753318; Fri, 21
 Jul 2023 01:55:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230711154449.1378385-1-eesposit@redhat.com> <ZK/9MlTh435FP5Ji@gambale.home>
 <ZLABozIRVGmwuIBf@gambale.home> <ba2354dc63fd741d2d351b18d4312d0771c0935d.camel@HansenPartnership.com>
 <ZLVyvAXwtemx1I6p@redhat.com> <0aa647f719103e8620d7209cbde40f04a7334749.camel@HansenPartnership.com>
 <FBDC67DD-856F-429B-8E91-B0CA8B0F24B9@oracle.com> <CAMw=ZnQ5pjwJZdX9kyib=vFd_c5_5_eUhV_mT5OcRPt693m=Yg@mail.gmail.com>
 <635B383C-38A5-479E-80A6-358D5F90988B@oracle.com>
In-Reply-To: <635B383C-38A5-479E-80A6-358D5F90988B@oracle.com>
From:   Luca Boccassi <bluca@debian.org>
Date:   Fri, 21 Jul 2023 09:55:41 +0100
X-Gmail-Original-Message-ID: <CAMw=ZnQtEwNFyZ-Gt6ODb9gp22KY1GimaSfW46N7o-S1Hkfp4A@mail.gmail.com>
Message-ID: <CAMw=ZnQtEwNFyZ-Gt6ODb9gp22KY1GimaSfW46N7o-S1Hkfp4A@mail.gmail.com>
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
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 21 Jul 2023 at 02:49, Eric Snowberg <eric.snowberg@oracle.com> wrote:
>
>
>
> > On Jul 20, 2023, at 1:16 PM, Luca Boccassi <bluca@debian.org> wrote:
> >
> > On Thu, 20 Jul 2023 at 18:11, Eric Snowberg <eric.snowberg@oracle.com> wrote:
> >>
> >> (add keyrings@ cc)
> >>
> >>> On Jul 17, 2023, at 11:15 AM, James Bottomley <James.Bottomley@hansenpartnership.com> wrote:
> >>>
> >>> On Mon, 2023-07-17 at 17:56 +0100, Daniel P. Berrangé wrote:
> >>>> On Mon, Jul 17, 2023 at 12:08:26PM -0400, James Bottomley wrote:
> >>>>> On Thu, 2023-07-13 at 15:52 +0200, Ard Biesheuvel wrote:
> >>>>>> (add linux-efi@ cc)
> >>>>>
> >>>>> Thanks for that, since this is really EFI related rather than x86.
> >>>>
> >>>> snip
> >>>>
> >>>>> The problem, as I see it, is if the distros give the kernel an
> >>>>> .sbat section, that means any vanilla kernel that's built by a user
> >>>>> and signed by their key now won't work (even if their key is in
> >>>>> MoK) because it won't have an sbat section ... and the sbat
> >>>>> mechanism is component specific, not key specific, so the signer
> >>>>> has no choice but to adopt it.
> >>>>
> >>>> AFAICT, that problem only exists for binaries directly invoked
> >>>> from shim. So that would be a problem for the boot loader (grub),
> >>>> or a kernel image being booted directly without a bootloader
> >>>> present.
> >>>
> >>> Well, currently, yes; that's the in_protocol check in
> >>> shim.c:verify_sbat_section().  However, I was assuming based on this
> >>> thread, that that was being tightened up (either because people are
> >>> moving away from grub or because the shim verifier protocol would
> >>> enforce it) as you imply below.
> >>>
> >>>> For kernel binaries invoked indirectly by the boot loader, the
> >>>> use of SBAT is currently optional. ie missing SBAT record would
> >>>> be treated as success.
> >>>>
> >>>> This was a pragmatic way to introduce SBAT support as it only
> >>>> impacted grub at that time.
> >>>>
> >>>> Once a distro starts adding SBAT to their kenrels too though, we
> >>>> can forsee that they would like to enforce SBAT for the whole
> >>>> boot chain, to prevent rollback to previously signed binaries
> >>>> that lacked SBAT info.
> >>>>
> >>>> This policy could be enforced per key though. eg require SBAT
> >>>> for anything verified against the vendor key that's compiled into
> >>>> shim, but not require SBAT for binaries verified with the MoK
> >>>> entries.
> >>>
> >>> That might work, but it's not currently in the shim code base.  It also
> >>> wouldn't work for SUSE I suspect: they actually put all of their distro
> >>> keys into MokList (so the machine owner has to approve any SUSE key
> >>> update), so how can shim tell the difference between my key and their
> >>> key?
> >>>
> >>>> The user specific MoK entries don't have such a compelling use
> >>>> case for SBAT, since if they need to revoke old binaries, the
> >>>> end users always have the easy fallback option of just rotating
> >>>> their signing keys and switching out the enrolled key in MoK.
> >>>>
> >>>> The choice of whether to mandate SBAT for binaries signed with
> >>>> a MoK entry, could be set by the end user themselves at the time
> >>>> their enroll their signing cert in the MoK DB.
> >>>
> >>> Well, I agree with this, since it was my original point.  However, a
> >>> key observation still seems to be that none of this exception proposal
> >>> is actually coded anywhere, so if shim does tighten up sbat
> >>> verification, everyone currently gets caught by it (and if it doesn't
> >>> then the kernel doesn't need an sbat section).
> >>>
> >>> I really think if this exception proposal is what everyone is planning,
> >>> then you can simply leave the upstream kernel alone, since it won't
> >>> require sbat information unless incorporated into a distro.
> >>>
> >>> So the direction forward seems to be to get this exception proposal
> >>> coded up and agreed and then we can decide based on that whether the
> >>> upstream kernel needs to care.
> >>
> >> I agree with James in the previous thread;  adding the SBAT section to
> >> the kernel should be handled by the signing tools. It really doesn't need to
> >> be included in the mainline kernel code. I also agree with the sentiment that
> >> mainline and the stable branches should not have SBAT versions attached
> >> to them. These are things distros should be responsible for including in their
> >> kernel if they want to have SBAT support.
> >
> > Why would 'signing tools' handle that? It's just a text-based PE
> > section, it doesn't require access to private key materials to be
> > handled, nor it has any relationship with signing.
>
> There is a relationship, the sbat information within the signed file
> can be used for revocation in lieu of revoking the hash or signing
> certificate at a later time.

No, it is completely disjoint. In fact, the kernel doesn't even have
to be signed at all, but it still _must_ have a .sbat section when it
is used in a UKI. The UKI build tool (which is not a signing tool)
will merge the .sbat sections from the various PEs that it assemble,
currently kernel and stub, to create the final 'outer' .sbat in the
UKI PE. It's not expected for the kernel PE binary that gets merged in
the UKI to be signed. It is expected that it has a valid .sbat
section.

> > And again, the point is that it's not something you might or
> > might not want to have - if you are getting your Shim signed by the
> > 3rd party CA, you need it, full stop, end of story. Without it, you
> > don't boot. So it needs to be easy to find and consume for all the
> > distributions/groups/projects that participate in the Shim + 3rd party
> > CA workflow, that's the main goal. Mistakes are going to be expensive.
>
> I thought this discussion was around adding a sbat section to a signed
> kernel. When signing a kernel, there must be some type of assurance
> done immediately prior to code signing.  Currently following the assurance
> step the appropriate public and private keys are supplied to either pesign
> or sbsign.  If the signing tools were modified  to optionally accept sbat
> information through a new command line arg, the new section could be
> added immediately before signing.

No, as mentioned above, the kernel doesn't even have to be signed. It
needs to carry .sbat data though, if it will be part of a signed UKI
that is loaded via the 3rd party CA flow.

> Unlike shim, every kernel will be different and have different vulnerabilities
> that individuals or distros may want to protect against.

That's not any different than grub.
