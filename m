Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39C7275C7E4
	for <lists+linux-efi@lfdr.de>; Fri, 21 Jul 2023 15:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231262AbjGUNeF (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 21 Jul 2023 09:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbjGUNeE (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 21 Jul 2023 09:34:04 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 544A9121;
        Fri, 21 Jul 2023 06:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1689946442;
        bh=TiphdHXvMuUcO0i6GCIlwWLbWEkBbJfN4Wq1cM4dYMA=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=ZgX3Eqfm2MYvmUoX1/SrOMSPA4Jg5S+9AmCkRja0afIcgKm+X8kmPSqHtmlGIMopa
         2Xi1xVod18cKjY3ETYRKZapGEKqNaQkygV7Jco212CpgdF4qaEyX2gbB2RWDW2ln1b
         QKMuuP+A6M/4OEtvEnnKkYLAWcbj3A9mEiycNG0g=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id DC7CB1285F6A;
        Fri, 21 Jul 2023 09:34:02 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id FJi4xGw7Wxjc; Fri, 21 Jul 2023 09:34:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1689946442;
        bh=TiphdHXvMuUcO0i6GCIlwWLbWEkBbJfN4Wq1cM4dYMA=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=ZgX3Eqfm2MYvmUoX1/SrOMSPA4Jg5S+9AmCkRja0afIcgKm+X8kmPSqHtmlGIMopa
         2Xi1xVod18cKjY3ETYRKZapGEKqNaQkygV7Jco212CpgdF4qaEyX2gbB2RWDW2ln1b
         QKMuuP+A6M/4OEtvEnnKkYLAWcbj3A9mEiycNG0g=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::c14])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 0AA6B1285F0E;
        Fri, 21 Jul 2023 09:34:00 -0400 (EDT)
Message-ID: <caec9522f981393e6fd0f8e36ff495781828406f.camel@HansenPartnership.com>
Subject: Re: [RFC PATCH v2] x86/boot: add .sbat section to the bzImage
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Luca Boccassi <bluca@debian.org>
Cc:     Eric Snowberg <eric.snowberg@oracle.com>,
        Ard Biesheuvel <ardb@kernel.org>,
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
Date:   Fri, 21 Jul 2023 09:33:56 -0400
In-Reply-To: <CAMw=ZnSPGp-jCAN+z_QdGJAgJv4=pgee_2oQ4oBqVqnye6813A@mail.gmail.com>
References: <20230711154449.1378385-1-eesposit@redhat.com>
         <ZK/9MlTh435FP5Ji@gambale.home> <ZLABozIRVGmwuIBf@gambale.home>
         <ba2354dc63fd741d2d351b18d4312d0771c0935d.camel@HansenPartnership.com>
         <ZLVyvAXwtemx1I6p@redhat.com>
         <0aa647f719103e8620d7209cbde40f04a7334749.camel@HansenPartnership.com>
         <FBDC67DD-856F-429B-8E91-B0CA8B0F24B9@oracle.com>
         <CAMw=ZnQ5pjwJZdX9kyib=vFd_c5_5_eUhV_mT5OcRPt693m=Yg@mail.gmail.com>
         <635B383C-38A5-479E-80A6-358D5F90988B@oracle.com>
         <CAMw=ZnQtEwNFyZ-Gt6ODb9gp22KY1GimaSfW46N7o-S1Hkfp4A@mail.gmail.com>
         <c2f451e0f8d72cf3183aff9cbaf23f135fc7b495.camel@HansenPartnership.com>
         <CAMw=ZnSHDYrLXoad=d_O_qAsurqv196z3Fc3VRAJXSsJNVXdPw@mail.gmail.com>
         <137ddc2957d43576afd37afb0bedab3ceea1f8d7.camel@HansenPartnership.com>
         <CAMw=ZnSPGp-jCAN+z_QdGJAgJv4=pgee_2oQ4oBqVqnye6813A@mail.gmail.com>
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

On Fri, 2023-07-21 at 14:10 +0100, Luca Boccassi wrote:
> On Fri, 21 Jul 2023 at 14:01, James Bottomley
> <James.Bottomley@hansenpartnership.com> wrote:
[...]
> > Well, my job is to be concerned about how individuals who want to
> > own their own keys, either in MoK or db, participate in this, so I
> > am mostly thinking about local signing.  Whatever we decide, there
> > must be a local workflow pathway.
> 
> Sure but for local signing via MoK that's obviously fine, as one gets
> to keep the pieces. AFAIK it's a different flow in Shim whether
> something is authorized by MoK, DB or the built-in cert, so having
> different policies built-in for those different cases should be
> doable. Actually at the moment even if Shim loads the image, if it
> gets authorized by DB .sbat isn't checked at all.

So let's be sure we mean the same thing here.  There is really no third
party CA.  Microsoft gives the distributions a signing key to allow
them to sign their version of shim.  Some distributions, like Red Hat,
also embed their signing certificates in shim, so shim can distinguish
between a RH key and another key added to MokList.  However, some
distributions, like SUSE, insist that all signing keys be approved by
the machine owner (so no embedded shim certs for non-enterprise) and
their shim can't distinguish between SUSE keys and machine owner
additions.  Given the variances in key handling, I think trying to
distinguish between official and developer keys is a huge addition of
complexity we don't need, so there has to be a workflow that functions
for both and that workflow would seem to be allowing non-existent or
empty sbat sections.  Official key holders  would *always* add sbat
sections, so there's really no problem that needs a solution to be
mandated here.

James
 
