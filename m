Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42EA075CB92
	for <lists+linux-efi@lfdr.de>; Fri, 21 Jul 2023 17:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231524AbjGUPXS (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 21 Jul 2023 11:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232115AbjGUPXH (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 21 Jul 2023 11:23:07 -0400
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB47E3586;
        Fri, 21 Jul 2023 08:22:42 -0700 (PDT)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-57045429f76so22851467b3.0;
        Fri, 21 Jul 2023 08:22:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689952933; x=1690557733;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bRpZOSTRgUgs93CpnfRqLnXeS2bgmI9aOiNkeLEthD0=;
        b=XQ7CpVXcAYdVCdo2OFMrd45xJEfSBe/FwYXkV3wY3/gWd18XyXUPQlux+CiXrLwp/1
         iG00iJQ1m9dPHSBWILMLFxt75Q2gC9eBDrmrGugBHBw3zlj+Zc1OYqaYHUcd5hsRZ7ni
         QfCHkkB7y+MiUZ0yQuPLPo57sc/mYfpYPgKu8tm/PCz98z4v10agxkYV0oeSSTS8Tg0+
         lFCMNyOcakoi+bc0NXJEdiG/M15TrkpYz2EfGqrXXhE2WOcrHnzq6GN277KMguzXLXHP
         veUlu1K0D6wxfyxxCK4uIeo8TA7SVLP3LALUHkm7yv0cDXhAnEs9P8zvWTWf0Nt14lip
         JkgQ==
X-Gm-Message-State: ABy/qLbKkVRh+jrJCPWGA+pX9XQTq06fTJ/wqRR50Fn8Fs0MFpgo6HM+
        U5/bWX4JLATKenfkvABNBTRM0bwnyBG/BQ==
X-Google-Smtp-Source: APBJJlHsCwFm8o3IiOOLqKl7iC10k/IuqmOifIN/ywy/oIUtmb0iATjnTkKpDcXbOt21ws1bIqKHrA==
X-Received: by 2002:a0d:ff86:0:b0:577:2cac:cd4b with SMTP id p128-20020a0dff86000000b005772caccd4bmr482814ywf.7.1689952933290;
        Fri, 21 Jul 2023 08:22:13 -0700 (PDT)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com. [209.85.128.175])
        by smtp.gmail.com with ESMTPSA id m74-20020a0dca4d000000b0056d2a19ad91sm924478ywd.103.2023.07.21.08.22.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jul 2023 08:22:12 -0700 (PDT)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-5701eaf0d04so22523007b3.2;
        Fri, 21 Jul 2023 08:22:12 -0700 (PDT)
X-Received: by 2002:a81:4f44:0:b0:57a:5b6f:d41 with SMTP id
 d65-20020a814f44000000b0057a5b6f0d41mr358831ywb.42.1689952932202; Fri, 21 Jul
 2023 08:22:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230711154449.1378385-1-eesposit@redhat.com> <ZK/9MlTh435FP5Ji@gambale.home>
 <ZLABozIRVGmwuIBf@gambale.home> <ba2354dc63fd741d2d351b18d4312d0771c0935d.camel@HansenPartnership.com>
 <ZLVyvAXwtemx1I6p@redhat.com> <0aa647f719103e8620d7209cbde40f04a7334749.camel@HansenPartnership.com>
 <FBDC67DD-856F-429B-8E91-B0CA8B0F24B9@oracle.com> <CAMw=ZnQ5pjwJZdX9kyib=vFd_c5_5_eUhV_mT5OcRPt693m=Yg@mail.gmail.com>
 <635B383C-38A5-479E-80A6-358D5F90988B@oracle.com> <CAMw=ZnQtEwNFyZ-Gt6ODb9gp22KY1GimaSfW46N7o-S1Hkfp4A@mail.gmail.com>
 <c2f451e0f8d72cf3183aff9cbaf23f135fc7b495.camel@HansenPartnership.com>
 <CAMw=ZnSHDYrLXoad=d_O_qAsurqv196z3Fc3VRAJXSsJNVXdPw@mail.gmail.com>
 <137ddc2957d43576afd37afb0bedab3ceea1f8d7.camel@HansenPartnership.com>
 <CAMw=ZnSPGp-jCAN+z_QdGJAgJv4=pgee_2oQ4oBqVqnye6813A@mail.gmail.com>
 <caec9522f981393e6fd0f8e36ff495781828406f.camel@HansenPartnership.com> <CAMw=ZnREBiwqP+wmUfBishtZ9eOiNsaicypvMqFMmEdV_g2gpg@mail.gmail.com>
In-Reply-To: <CAMw=ZnREBiwqP+wmUfBishtZ9eOiNsaicypvMqFMmEdV_g2gpg@mail.gmail.com>
From:   Luca Boccassi <bluca@debian.org>
Date:   Fri, 21 Jul 2023 16:22:00 +0100
X-Gmail-Original-Message-ID: <CAMw=ZnREf8L1hrGgFUMrcBJNf-7ZTs0hMNFMB_nNAvyV=Pe2Nw@mail.gmail.com>
Message-ID: <CAMw=ZnREf8L1hrGgFUMrcBJNf-7ZTs0hMNFMB_nNAvyV=Pe2Nw@mail.gmail.com>
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

On Fri, 21 Jul 2023 at 16:14, Luca Boccassi <bluca@debian.org> wrote:
>
> On Fri, 21 Jul 2023 at 14:34, James Bottomley
> <James.Bottomley@hansenpartnership.com> wrote:
> >
> > On Fri, 2023-07-21 at 14:10 +0100, Luca Boccassi wrote:
> > > On Fri, 21 Jul 2023 at 14:01, James Bottomley
> > > <James.Bottomley@hansenpartnership.com> wrote:
> > [...]
> > > > Well, my job is to be concerned about how individuals who want to
> > > > own their own keys, either in MoK or db, participate in this, so I
> > > > am mostly thinking about local signing.  Whatever we decide, there
> > > > must be a local workflow pathway.
> > >
> > > Sure but for local signing via MoK that's obviously fine, as one gets
> > > to keep the pieces. AFAIK it's a different flow in Shim whether
> > > something is authorized by MoK, DB or the built-in cert, so having
> > > different policies built-in for those different cases should be
> > > doable. Actually at the moment even if Shim loads the image, if it
> > > gets authorized by DB .sbat isn't checked at all.
> >
> > So let's be sure we mean the same thing here.  There is really no third
> > party CA.  Microsoft gives the distributions a signing key to allow
> > them to sign their version of shim.  Some distributions, like Red Hat,
> > also embed their signing certificates in shim, so shim can distinguish
> > between a RH key and another key added to MokList.  However, some
> > distributions, like SUSE, insist that all signing keys be approved by
> > the machine owner (so no embedded shim certs for non-enterprise) and
> > their shim can't distinguish between SUSE keys and machine owner
> > additions.  Given the variances in key handling, I think trying to
> > distinguish between official and developer keys is a huge addition of
> > complexity we don't need, so there has to be a workflow that functions
> > for both and that workflow would seem to be allowing non-existent or
> > empty sbat sections.  Official key holders  would *always* add sbat
> > sections, so there's really no problem that needs a solution to be
> > mandated here.
>
> The certificate is called the "Microsoft Corporation UEFI CA 2011" ,
> issued by the "Microsoft Corporation Third Party Marketplace Root". So
> for short, we call it UEFI 3rd party CA :-)
> Anyway, I wasn't aware that SUSE doesn't embed their cert in Shim,
> we'll have to take that in consideration for sure.

Actually, a dev from SUSE's security just confirmed they embed their
CA in Shim like every other distribution. Nobody seems to be aware of
any example where a distribution relies exclusively on MoK - and
that's understandable, as that would mean failing to boot by default
on a new machine. Do you have any example/cases where that's actually
happening? Outside development/local signing/etc.
