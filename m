Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12D9C75CBAE
	for <lists+linux-efi@lfdr.de>; Fri, 21 Jul 2023 17:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231778AbjGUP1J (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 21 Jul 2023 11:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231723AbjGUP1I (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 21 Jul 2023 11:27:08 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3845A12F;
        Fri, 21 Jul 2023 08:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1689953227;
        bh=FngqbpUI4Rw9Bf1aCJcQKawbuMpbfY3PSkF8qrGHcrk=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=ZvbvMKkP0V4OCTmLGyuzoGeaYYl86jH2pvT2cIPwnRxKyrHItK1YV8BPIoh+jnEmF
         p7vfGpcjnW5ZLLCevQtulovzEhrSkWUY3EKW6dTizCgvC6GQIVdXnYQqq89Hja4mLG
         uyrjQCOywnUKtkJ2uWVX5b7cQW/OBBW+JQ5qTxiY=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 56F111285F09;
        Fri, 21 Jul 2023 11:27:07 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id nkCt7AA_vId3; Fri, 21 Jul 2023 11:27:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1689953227;
        bh=FngqbpUI4Rw9Bf1aCJcQKawbuMpbfY3PSkF8qrGHcrk=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=ZvbvMKkP0V4OCTmLGyuzoGeaYYl86jH2pvT2cIPwnRxKyrHItK1YV8BPIoh+jnEmF
         p7vfGpcjnW5ZLLCevQtulovzEhrSkWUY3EKW6dTizCgvC6GQIVdXnYQqq89Hja4mLG
         uyrjQCOywnUKtkJ2uWVX5b7cQW/OBBW+JQ5qTxiY=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::c14])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 7B9F51285CE5;
        Fri, 21 Jul 2023 11:27:05 -0400 (EDT)
Message-ID: <58a3914d2c147d926a09ca833550031828098b31.camel@HansenPartnership.com>
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
Date:   Fri, 21 Jul 2023 11:27:03 -0400
In-Reply-To: <CAMw=ZnREf8L1hrGgFUMrcBJNf-7ZTs0hMNFMB_nNAvyV=Pe2Nw@mail.gmail.com>
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
         <caec9522f981393e6fd0f8e36ff495781828406f.camel@HansenPartnership.com>
         <CAMw=ZnREBiwqP+wmUfBishtZ9eOiNsaicypvMqFMmEdV_g2gpg@mail.gmail.com>
         <CAMw=ZnREf8L1hrGgFUMrcBJNf-7ZTs0hMNFMB_nNAvyV=Pe2Nw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 2023-07-21 at 16:22 +0100, Luca Boccassi wrote:
> On Fri, 21 Jul 2023 at 16:14, Luca Boccassi <bluca@debian.org> wrote:
[...]
> > Anyway, I wasn't aware that SUSE doesn't embed their cert in Shim,
> > we'll have to take that in consideration for sure.
> 
> Actually, a dev from SUSE's security just confirmed they embed their
> CA in Shim like every other distribution. Nobody seems to be aware of
> any example where a distribution relies exclusively on MoK - and
> that's understandable, as that would mean failing to boot by default
> on a new machine. Do you have any example/cases where that's actually
> happening? Outside development/local signing/etc.

It happened last year for an openSUSE Leap update that changed the
kernel signing certificate.  I got asked to confirm acceptance of the
new key and it got put in my MokList, which now has three certificates:
two suse ones and my own.

James

