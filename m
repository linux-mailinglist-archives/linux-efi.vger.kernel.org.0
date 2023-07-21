Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59C6B75CB3C
	for <lists+linux-efi@lfdr.de>; Fri, 21 Jul 2023 17:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231825AbjGUPP3 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 21 Jul 2023 11:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231514AbjGUPP0 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 21 Jul 2023 11:15:26 -0400
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A333A8E;
        Fri, 21 Jul 2023 08:15:02 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-579de633419so24002097b3.3;
        Fri, 21 Jul 2023 08:15:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689952497; x=1690557297;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4gls07TAhrPZDEI4R+VJXoEx/0hW6Rvn6uyBj2nqCeY=;
        b=NW5qYZcPNvZXlNlR758095l1tu8OHkcj6s8W2Z6gjWMSXXmULAnuut6ALZuOMfmzkf
         ftajB7kbfMXNDzMcXaGdGPETYKCNi7gC48J8+M1+LBmn+D4hqL/uQVFCKAKKozneSsBK
         Fcic569dJvzL9ac04VDw+1bNaQ/TQxAxCx1FqnuGuIrILPOba8MsFIT8JHjmYuTA7bIH
         2VY09VYH+KYOwgrXrkVG+YcLXbaFUMvQ6p/ZnynpWc3VrUUM9YMuQO3i1R0VAvijZhdr
         P1MN1x7gr+mHyZLG+S75w9lLrkMZ1o3UJE1AraVjuwMo68+co9z+BxH8mUz8ftu/TDBp
         X+uw==
X-Gm-Message-State: ABy/qLacF9cNjOBSW7ZvuEmBl8pBXaxps416D5EvVS/jdWydwmwTNNeM
        8OlJMT2r18xFwLU0InYjNl0+UxKPls79iQ==
X-Google-Smtp-Source: APBJJlFlhHzwBcSDQGhQ4UbAVH9YCayglWpwu3m4gYU8WeRht/E9l1vklBkgvckA+079WbsKMcr+GQ==
X-Received: by 2002:a0d:d844:0:b0:577:3b66:5fa with SMTP id a65-20020a0dd844000000b005773b6605famr376626ywe.42.1689952496898;
        Fri, 21 Jul 2023 08:14:56 -0700 (PDT)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com. [209.85.128.177])
        by smtp.gmail.com with ESMTPSA id h184-20020a0dc5c1000000b0057736c436f1sm918540ywd.141.2023.07.21.08.14.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jul 2023 08:14:56 -0700 (PDT)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-583a8596e2aso3316627b3.1;
        Fri, 21 Jul 2023 08:14:56 -0700 (PDT)
X-Received: by 2002:a0d:ddd4:0:b0:577:2cac:cd49 with SMTP id
 g203-20020a0dddd4000000b005772caccd49mr420491ywe.1.1689952496259; Fri, 21 Jul
 2023 08:14:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230711154449.1378385-1-eesposit@redhat.com> <ZK/9MlTh435FP5Ji@gambale.home>
 <ZLABozIRVGmwuIBf@gambale.home> <ba2354dc63fd741d2d351b18d4312d0771c0935d.camel@HansenPartnership.com>
 <ZLVyvAXwtemx1I6p@redhat.com> <0aa647f719103e8620d7209cbde40f04a7334749.camel@HansenPartnership.com>
 <FBDC67DD-856F-429B-8E91-B0CA8B0F24B9@oracle.com> <CAMw=ZnQ5pjwJZdX9kyib=vFd_c5_5_eUhV_mT5OcRPt693m=Yg@mail.gmail.com>
 <635B383C-38A5-479E-80A6-358D5F90988B@oracle.com> <CAMw=ZnQtEwNFyZ-Gt6ODb9gp22KY1GimaSfW46N7o-S1Hkfp4A@mail.gmail.com>
 <c2f451e0f8d72cf3183aff9cbaf23f135fc7b495.camel@HansenPartnership.com>
 <CAMw=ZnSHDYrLXoad=d_O_qAsurqv196z3Fc3VRAJXSsJNVXdPw@mail.gmail.com>
 <137ddc2957d43576afd37afb0bedab3ceea1f8d7.camel@HansenPartnership.com>
 <CAMw=ZnSPGp-jCAN+z_QdGJAgJv4=pgee_2oQ4oBqVqnye6813A@mail.gmail.com> <caec9522f981393e6fd0f8e36ff495781828406f.camel@HansenPartnership.com>
In-Reply-To: <caec9522f981393e6fd0f8e36ff495781828406f.camel@HansenPartnership.com>
From:   Luca Boccassi <bluca@debian.org>
Date:   Fri, 21 Jul 2023 16:14:43 +0100
X-Gmail-Original-Message-ID: <CAMw=ZnREBiwqP+wmUfBishtZ9eOiNsaicypvMqFMmEdV_g2gpg@mail.gmail.com>
Message-ID: <CAMw=ZnREBiwqP+wmUfBishtZ9eOiNsaicypvMqFMmEdV_g2gpg@mail.gmail.com>
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

On Fri, 21 Jul 2023 at 14:34, James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> On Fri, 2023-07-21 at 14:10 +0100, Luca Boccassi wrote:
> > On Fri, 21 Jul 2023 at 14:01, James Bottomley
> > <James.Bottomley@hansenpartnership.com> wrote:
> [...]
> > > Well, my job is to be concerned about how individuals who want to
> > > own their own keys, either in MoK or db, participate in this, so I
> > > am mostly thinking about local signing.  Whatever we decide, there
> > > must be a local workflow pathway.
> >
> > Sure but for local signing via MoK that's obviously fine, as one gets
> > to keep the pieces. AFAIK it's a different flow in Shim whether
> > something is authorized by MoK, DB or the built-in cert, so having
> > different policies built-in for those different cases should be
> > doable. Actually at the moment even if Shim loads the image, if it
> > gets authorized by DB .sbat isn't checked at all.
>
> So let's be sure we mean the same thing here.  There is really no third
> party CA.  Microsoft gives the distributions a signing key to allow
> them to sign their version of shim.  Some distributions, like Red Hat,
> also embed their signing certificates in shim, so shim can distinguish
> between a RH key and another key added to MokList.  However, some
> distributions, like SUSE, insist that all signing keys be approved by
> the machine owner (so no embedded shim certs for non-enterprise) and
> their shim can't distinguish between SUSE keys and machine owner
> additions.  Given the variances in key handling, I think trying to
> distinguish between official and developer keys is a huge addition of
> complexity we don't need, so there has to be a workflow that functions
> for both and that workflow would seem to be allowing non-existent or
> empty sbat sections.  Official key holders  would *always* add sbat
> sections, so there's really no problem that needs a solution to be
> mandated here.

The certificate is called the "Microsoft Corporation UEFI CA 2011" ,
issued by the "Microsoft Corporation Third Party Marketplace Root". So
for short, we call it UEFI 3rd party CA :-)
Anyway, I wasn't aware that SUSE doesn't embed their cert in Shim,
we'll have to take that in consideration for sure.
