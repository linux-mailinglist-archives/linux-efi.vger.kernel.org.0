Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAF1575C6FC
	for <lists+linux-efi@lfdr.de>; Fri, 21 Jul 2023 14:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbjGUMkb (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 21 Jul 2023 08:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbjGUMka (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 21 Jul 2023 08:40:30 -0400
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 250E52D58;
        Fri, 21 Jul 2023 05:40:29 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-c15a5ed884dso1742324276.2;
        Fri, 21 Jul 2023 05:40:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689943228; x=1690548028;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R1irb96IZdUaV+Zw6SqMt9u0coJjIQi+rgKDiQBXcb0=;
        b=HaPpygDWTM3n/dlCd+2dRXQKm9H9c+F3g8mrWGjCWF5uEe2KXlkyCYisb2IgZySVwD
         0pTYJptedQxoa65oGYZr2ipPcGLoAHDAAovLYRF0QPTHptY1xfk1vI63ok1WR+i4XVZC
         xgJf34Gwm4UOWZRIMDsZ3uvYp//ieTXgrHPjjuu15TiytTTdzNZO4cgUy44Cbx5z4hZY
         1miJC4Aqp9CSneKit/gsEReaRv+d6oSOaFK0rdKRydies4GR53UK9EzrBfVxiFDBXh/+
         kgVkLqexZ+EimnC7V5PGhkj9viO3JaUoJPi+7Ni/0j/u3fwbt8srkrV33M8HFZSwgWbW
         BPoA==
X-Gm-Message-State: ABy/qLY7+QKIbWDac9n/BOw4LrLIkPutoY3IC6PHnfNKa+PQIwI7t1Cq
        oAY6VaFyl4COn1iUbDfVA9XO79UfIgCyCg==
X-Google-Smtp-Source: APBJJlFAJkSG1QFMXLgXtX+nbZeA0qsyFiIt4YcYbP3fpt8cKO6GGh8mARMY43dzbvQRSmzB2U16ig==
X-Received: by 2002:a25:db91:0:b0:c4c:ec2c:3c95 with SMTP id g139-20020a25db91000000b00c4cec2c3c95mr1780013ybf.4.1689943228123;
        Fri, 21 Jul 2023 05:40:28 -0700 (PDT)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com. [209.85.128.179])
        by smtp.gmail.com with ESMTPSA id 127-20020a250d85000000b00cb6bb265676sm757380ybn.13.2023.07.21.05.40.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jul 2023 05:40:27 -0700 (PDT)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-57688a146ecso21105217b3.2;
        Fri, 21 Jul 2023 05:40:26 -0700 (PDT)
X-Received: by 2002:a0d:c8c7:0:b0:573:4d8b:471f with SMTP id
 k190-20020a0dc8c7000000b005734d8b471fmr1656720ywd.26.1689943226191; Fri, 21
 Jul 2023 05:40:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230711154449.1378385-1-eesposit@redhat.com> <ZK/9MlTh435FP5Ji@gambale.home>
 <ZLABozIRVGmwuIBf@gambale.home> <ba2354dc63fd741d2d351b18d4312d0771c0935d.camel@HansenPartnership.com>
 <ZLVyvAXwtemx1I6p@redhat.com> <0aa647f719103e8620d7209cbde40f04a7334749.camel@HansenPartnership.com>
 <FBDC67DD-856F-429B-8E91-B0CA8B0F24B9@oracle.com> <CAMw=ZnQ5pjwJZdX9kyib=vFd_c5_5_eUhV_mT5OcRPt693m=Yg@mail.gmail.com>
 <635B383C-38A5-479E-80A6-358D5F90988B@oracle.com> <CAMw=ZnQtEwNFyZ-Gt6ODb9gp22KY1GimaSfW46N7o-S1Hkfp4A@mail.gmail.com>
 <c2f451e0f8d72cf3183aff9cbaf23f135fc7b495.camel@HansenPartnership.com>
In-Reply-To: <c2f451e0f8d72cf3183aff9cbaf23f135fc7b495.camel@HansenPartnership.com>
From:   Luca Boccassi <bluca@debian.org>
Date:   Fri, 21 Jul 2023 13:40:14 +0100
X-Gmail-Original-Message-ID: <CAMw=ZnSHDYrLXoad=d_O_qAsurqv196z3Fc3VRAJXSsJNVXdPw@mail.gmail.com>
Message-ID: <CAMw=ZnSHDYrLXoad=d_O_qAsurqv196z3Fc3VRAJXSsJNVXdPw@mail.gmail.com>
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
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 21 Jul 2023 at 12:24, James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> On Fri, 2023-07-21 at 09:55 +0100, Luca Boccassi wrote:
> > On Fri, 21 Jul 2023 at 02:49, Eric Snowberg
> > <eric.snowberg@oracle.com> wrote:
> > > > On Jul 20, 2023, at 1:16 PM, Luca Boccassi <bluca@debian.org>
> > > > wrote:
> > > > On Thu, 20 Jul 2023 at 18:11, Eric Snowberg
> > > > <eric.snowberg@oracle.com> wrote:
> [...]
> > > > > I agree with James in the previous thread;  adding the SBAT
> > > > > section to the kernel should be handled by the signing tools.
> > > > > It really doesn't need to be included in the mainline kernel
> > > > > code. I also agree with the sentiment that mainline and the
> > > > > stable branches should not have SBAT versions attached
> > > > > to them. These are things distros should be responsible for
> > > > > including in their kernel if they want to have SBAT support.
> > > >
> > > > Why would 'signing tools' handle that? It's just a text-based PE
> > > > section, it doesn't require access to private key materials to be
> > > > handled, nor it has any relationship with signing.
> > >
> > > There is a relationship, the sbat information within the signed
> > > file can be used for revocation in lieu of revoking the hash or
> > > signing certificate at a later time.
> >
> > No, it is completely disjoint. In fact, the kernel doesn't even have
> > to be signed at all, but it still _must_ have a .sbat section when it
> > is used in a UKI.
>
> Just a minute, this is wrong.  I was talking to Peter after all of this
> blew up about how we handle signed kernels with no sbat (since we need
> that still to work for developers who sign their own kernels).  I
> thought he was planning to require an sbat section for all EFI
> binaries, but he says that's not true.  The current way shim does the
> sbat check is that if the section doesn't exist the binary is processed
> as having an empty sbat section (i.e. no sbat level checking will be
> done because there's no named sbat level for anything and it will just
> work) and they're planning to keep it that way so that a signed but no
> sbat kernel will always "just work" without any special key handling in
> shim.  So if we're planning to keep this no-sbat case in discrete
> kernels, even when the shim verifier checks sbat, the UKI kernel will
> need to work for this case as well.

Are you sure that's not just about local signing? IE, MoK vs embedded
cert auth flow? As far as I know, the plan for the 3rd party CA flow
is to eventually (very eventually) require it. I might have missed
some development ofc.
