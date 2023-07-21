Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FF3E75C5D1
	for <lists+linux-efi@lfdr.de>; Fri, 21 Jul 2023 13:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbjGULYf (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 21 Jul 2023 07:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbjGULYe (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 21 Jul 2023 07:24:34 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8BF71996;
        Fri, 21 Jul 2023 04:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1689938671;
        bh=Su+fAd/hk2qW820IuX6Kbh5m9vCkDqFgFh+fW7xlJnI=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=sLru+sKOeepl9SHV0S+eEuHY5xha7KEjhBnbIa0GU5qgNLgb9emZQzI+CZjleUlO+
         bXj2meMc0fJMKvcU+aICK+4j0V4sXGt2hKTSphy1YS3dpAZZC+qWImhwjVxFBmi2Bv
         Mi9DhqTtN/DG2CsHkexR6YeiKE2fwz7xHm3tRiGc=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id F0EF512868AE;
        Fri, 21 Jul 2023 07:24:31 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id 14wxoYoKcqs8; Fri, 21 Jul 2023 07:24:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1689938671;
        bh=Su+fAd/hk2qW820IuX6Kbh5m9vCkDqFgFh+fW7xlJnI=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=sLru+sKOeepl9SHV0S+eEuHY5xha7KEjhBnbIa0GU5qgNLgb9emZQzI+CZjleUlO+
         bXj2meMc0fJMKvcU+aICK+4j0V4sXGt2hKTSphy1YS3dpAZZC+qWImhwjVxFBmi2Bv
         Mi9DhqTtN/DG2CsHkexR6YeiKE2fwz7xHm3tRiGc=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::c14])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 1A4511286497;
        Fri, 21 Jul 2023 07:24:30 -0400 (EDT)
Message-ID: <c2f451e0f8d72cf3183aff9cbaf23f135fc7b495.camel@HansenPartnership.com>
Subject: Re: [RFC PATCH v2] x86/boot: add .sbat section to the bzImage
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Luca Boccassi <bluca@debian.org>,
        Eric Snowberg <eric.snowberg@oracle.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        "Daniel P." =?ISO-8859-1?Q?Berrang=E9?= <berrange@redhat.com>,
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
Date:   Fri, 21 Jul 2023 07:24:28 -0400
In-Reply-To: <CAMw=ZnQtEwNFyZ-Gt6ODb9gp22KY1GimaSfW46N7o-S1Hkfp4A@mail.gmail.com>
References: <20230711154449.1378385-1-eesposit@redhat.com>
         <ZK/9MlTh435FP5Ji@gambale.home> <ZLABozIRVGmwuIBf@gambale.home>
         <ba2354dc63fd741d2d351b18d4312d0771c0935d.camel@HansenPartnership.com>
         <ZLVyvAXwtemx1I6p@redhat.com>
         <0aa647f719103e8620d7209cbde40f04a7334749.camel@HansenPartnership.com>
         <FBDC67DD-856F-429B-8E91-B0CA8B0F24B9@oracle.com>
         <CAMw=ZnQ5pjwJZdX9kyib=vFd_c5_5_eUhV_mT5OcRPt693m=Yg@mail.gmail.com>
         <635B383C-38A5-479E-80A6-358D5F90988B@oracle.com>
         <CAMw=ZnQtEwNFyZ-Gt6ODb9gp22KY1GimaSfW46N7o-S1Hkfp4A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 2023-07-21 at 09:55 +0100, Luca Boccassi wrote:
> On Fri, 21 Jul 2023 at 02:49, Eric Snowberg
> <eric.snowberg@oracle.com> wrote:
> > > On Jul 20, 2023, at 1:16 PM, Luca Boccassi <bluca@debian.org>
> > > wrote:
> > > On Thu, 20 Jul 2023 at 18:11, Eric Snowberg
> > > <eric.snowberg@oracle.com> wrote:
[...]
> > > > I agree with James in the previous thread;  adding the SBAT
> > > > section to the kernel should be handled by the signing tools.
> > > > It really doesn't need to be included in the mainline kernel
> > > > code. I also agree with the sentiment that mainline and the
> > > > stable branches should not have SBAT versions attached
> > > > to them. These are things distros should be responsible for
> > > > including in their kernel if they want to have SBAT support.
> > > 
> > > Why would 'signing tools' handle that? It's just a text-based PE
> > > section, it doesn't require access to private key materials to be
> > > handled, nor it has any relationship with signing.
> > 
> > There is a relationship, the sbat information within the signed
> > file can be used for revocation in lieu of revoking the hash or
> > signing certificate at a later time.
> 
> No, it is completely disjoint. In fact, the kernel doesn't even have
> to be signed at all, but it still _must_ have a .sbat section when it
> is used in a UKI.

Just a minute, this is wrong.  I was talking to Peter after all of this
blew up about how we handle signed kernels with no sbat (since we need
that still to work for developers who sign their own kernels).  I
thought he was planning to require an sbat section for all EFI
binaries, but he says that's not true.  The current way shim does the
sbat check is that if the section doesn't exist the binary is processed
as having an empty sbat section (i.e. no sbat level checking will be
done because there's no named sbat level for anything and it will just
work) and they're planning to keep it that way so that a signed but no
sbat kernel will always "just work" without any special key handling in
shim.  So if we're planning to keep this no-sbat case in discrete
kernels, even when the shim verifier checks sbat, the UKI kernel will
need to work for this case as well.

James

