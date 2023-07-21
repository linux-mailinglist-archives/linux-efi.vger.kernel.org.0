Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA4F375C761
	for <lists+linux-efi@lfdr.de>; Fri, 21 Jul 2023 15:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbjGUNKz (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 21 Jul 2023 09:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjGUNKy (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 21 Jul 2023 09:10:54 -0400
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 403BB30C1;
        Fri, 21 Jul 2023 06:10:48 -0700 (PDT)
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-cae0ad435b6so1876546276.0;
        Fri, 21 Jul 2023 06:10:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689945047; x=1690549847;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2SMyrYuyGnw6se9V0iz4C3o5R60SIQ8j01sF09ulyNs=;
        b=KeclVoogQLTjYtMjWVbqZB3jMUo5gA1/C1iYwJuo8Uyt+J/07YH0tRin8WKUNeCYr/
         6Ph/rhlDJ51+jB+phHO3nQfMlDrD0KqRsFPiXXpOWOBJO7Mp8KwOeAHFno7mc8Ic5nnP
         dPsx8eWOr1x13hn/9U2GTaNEaP243sbCkaVq6eygHs41HlskgbdStKV+9hfJY23CGDQn
         ml50LCShko6sBcKkQguciwsCq6IXNcpWk42sOEkXz2Bevrsy+pj4h2ZqHAyGtfYXDcQw
         rG+b3fVxaBuqTa3TrQAk6tO/0kW5KYd4zIHfXWz5cpWwVAOe+hrGIbVd6vxHSRQhQfsG
         nhvQ==
X-Gm-Message-State: ABy/qLYF50beWv46A1eAbfPrA0s5lMAkfOJbOG/mCw9ILjp/dohTz0d6
        1F1YdgClFKJL7qchVfj2xrGhdqLKH+p8Aw==
X-Google-Smtp-Source: APBJJlFCOvlfhE0zixO6ibGOeGX4Xi6GbTjAozY7HzwMvk0RyUjgxu7Xs2/wWddSKmFNp+Q2fVs05Q==
X-Received: by 2002:a25:e20e:0:b0:cef:e2c4:d366 with SMTP id h14-20020a25e20e000000b00cefe2c4d366mr1541335ybe.48.1689945047266;
        Fri, 21 Jul 2023 06:10:47 -0700 (PDT)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com. [209.85.128.174])
        by smtp.gmail.com with ESMTPSA id h13-20020a25d00d000000b00c6135ffd2fcsm770861ybg.15.2023.07.21.06.10.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jul 2023 06:10:46 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-57045429f76so20953957b3.0;
        Fri, 21 Jul 2023 06:10:46 -0700 (PDT)
X-Received: by 2002:a25:6dc2:0:b0:cac:e20:90e3 with SMTP id
 i185-20020a256dc2000000b00cac0e2090e3mr1446640ybc.63.1689945045842; Fri, 21
 Jul 2023 06:10:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230711154449.1378385-1-eesposit@redhat.com> <ZK/9MlTh435FP5Ji@gambale.home>
 <ZLABozIRVGmwuIBf@gambale.home> <ba2354dc63fd741d2d351b18d4312d0771c0935d.camel@HansenPartnership.com>
 <ZLVyvAXwtemx1I6p@redhat.com> <0aa647f719103e8620d7209cbde40f04a7334749.camel@HansenPartnership.com>
 <FBDC67DD-856F-429B-8E91-B0CA8B0F24B9@oracle.com> <CAMw=ZnQ5pjwJZdX9kyib=vFd_c5_5_eUhV_mT5OcRPt693m=Yg@mail.gmail.com>
 <635B383C-38A5-479E-80A6-358D5F90988B@oracle.com> <CAMw=ZnQtEwNFyZ-Gt6ODb9gp22KY1GimaSfW46N7o-S1Hkfp4A@mail.gmail.com>
 <c2f451e0f8d72cf3183aff9cbaf23f135fc7b495.camel@HansenPartnership.com>
 <CAMw=ZnSHDYrLXoad=d_O_qAsurqv196z3Fc3VRAJXSsJNVXdPw@mail.gmail.com> <137ddc2957d43576afd37afb0bedab3ceea1f8d7.camel@HansenPartnership.com>
In-Reply-To: <137ddc2957d43576afd37afb0bedab3ceea1f8d7.camel@HansenPartnership.com>
From:   Luca Boccassi <bluca@debian.org>
Date:   Fri, 21 Jul 2023 14:10:33 +0100
X-Gmail-Original-Message-ID: <CAMw=ZnSPGp-jCAN+z_QdGJAgJv4=pgee_2oQ4oBqVqnye6813A@mail.gmail.com>
Message-ID: <CAMw=ZnSPGp-jCAN+z_QdGJAgJv4=pgee_2oQ4oBqVqnye6813A@mail.gmail.com>
Subject: Re: [RFC PATCH v2] x86/boot: add .sbat section to the bzImage
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     Eric Snowberg <eric.snowberg@oracle.com>,
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
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 21 Jul 2023 at 14:01, James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> On Fri, 2023-07-21 at 13:40 +0100, Luca Boccassi wrote:
> > On Fri, 21 Jul 2023 at 12:24, James Bottomley
> > <James.Bottomley@hansenpartnership.com> wrote:
> > >
> > > On Fri, 2023-07-21 at 09:55 +0100, Luca Boccassi wrote:
> > > > On Fri, 21 Jul 2023 at 02:49, Eric Snowberg
> > > > <eric.snowberg@oracle.com> wrote:
> > > > > > On Jul 20, 2023, at 1:16 PM, Luca Boccassi <bluca@debian.org>
> > > > > > wrote:
> > > > > > On Thu, 20 Jul 2023 at 18:11, Eric Snowberg
> > > > > > <eric.snowberg@oracle.com> wrote:
> > > [...]
> > > > > > > I agree with James in the previous thread;  adding the SBAT
> > > > > > > section to the kernel should be handled by the signing
> > > > > > > tools. It really doesn't need to be included in the
> > > > > > > mainline kernel code. I also agree with the sentiment that
> > > > > > > mainline and the
> > > > > > > stable branches should not have SBAT versions attached
> > > > > > > to them. These are things distros should be responsible for
> > > > > > > including in their kernel if they want to have SBAT
> > > > > > > support.
> > > > > >
> > > > > > Why would 'signing tools' handle that? It's just a text-based
> > > > > > PE section, it doesn't require access to private key
> > > > > > materials to be handled, nor it has any relationship with
> > > > > > signing.
> > > > >
> > > > > There is a relationship, the sbat information within the signed
> > > > > file can be used for revocation in lieu of revoking the hash or
> > > > > signing certificate at a later time.
> > > >
> > > > No, it is completely disjoint. In fact, the kernel doesn't even
> > > > have to be signed at all, but it still _must_ have a .sbat
> > > > section when it is used in a UKI.
> > >
> > > Just a minute, this is wrong.  I was talking to Peter after all of
> > > this blew up about how we handle signed kernels with no sbat (since
> > > we need that still to work for developers who sign their own
> > > kernels).  I thought he was planning to require an sbat section for
> > > all EFI binaries, but he says that's not true.  The current way
> > > shim does the sbat check is that if the section doesn't exist the
> > > binary is processed as having an empty sbat section (i.e. no sbat
> > > level checking will be done because there's no named sbat level for
> > > anything and it will just work) and they're planning to keep it
> > > that way so that a signed but no sbat kernel will always "just
> > > work" without any special key handling in shim.  So if we're
> > > planning to keep this no-sbat case in discrete kernels, even when
> > > the shim verifier checks sbat, the UKI kernel will need to work for
> > > this case as well.
> >
> > Are you sure that's not just about local signing?
>
> Well, my job is to be concerned about how individuals who want to own
> their own keys, either in MoK or db, participate in this, so I am
> mostly thinking about local signing.  Whatever we decide, there must be
> a local workflow pathway.

Sure but for local signing via MoK that's obviously fine, as one gets
to keep the pieces. AFAIK it's a different flow in Shim whether
something is authorized by MoK, DB or the built-in cert, so having
different policies built-in for those different cases should be
doable. Actually at the moment even if Shim loads the image, if it
gets authorized by DB .sbat isn't checked at all.

> >  IE, MoK vs embedded cert auth flow? As far as I know, the plan for
> > the 3rd party CA flow is to eventually (very eventually) require it.
> > I might have missed some development ofc.
>
> There is a thought to get sbat adopted by UEFI to solve the dbx
> problem, but if that were to happen, UEFI will likely be extremely
> concerned about backward compatibility (and as you have remarked, they
> and the OEMs adopt at a glacial pace), so, even if they eventually
> adopt it, I can't foresee them mandating refusing to execute signed EFI
> binaries with no sbat.  I'll pretty much stake cash on the compromise
> being that for the foreseeable future no sbat gets revoked by dbx and
> the plan will be a gradual shift towards sbat ... but all this is
> contingent on UEFI adoption in the first place, which isn't a given.
> There are also unsolved problems around sbat, like how the master sbat
> lists are kept and how they're delivered which must be solved before a
> UEFI proposal could be made.

I meant Shim + 3rd party CA flow here. UEFI SB 2.0 is so far ahead I'm
pretty sure a good chunk of the folks currently talking about it will
be retired by the time it actually exist ;-)
