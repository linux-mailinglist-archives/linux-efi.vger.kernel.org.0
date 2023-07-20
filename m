Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06E2775B536
	for <lists+linux-efi@lfdr.de>; Thu, 20 Jul 2023 19:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbjGTRHu (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 20 Jul 2023 13:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjGTRHt (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 20 Jul 2023 13:07:49 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 848A7193;
        Thu, 20 Jul 2023 10:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1689872857;
        bh=glW40uY0uFwX/9MnPDdB2OI8tCiPfxvzTv6gvs9+Orw=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=EQOWoZCSu3UjMQztHHrpJIOz6h+TL40/8jSm2Qr16lk9s4/ZN6Na7mNG/CbFE5g69
         8tWicaM2WKEJSA9yHQOwf3xQ5IxTP3DDZTcta9XB6CRbsdaX/NH24B3vSt2uGnShP5
         FI3Hmxt9L1Kx7yhKhRqYIER1pD+68CuuWMXomPBY=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id E4B69128648C;
        Thu, 20 Jul 2023 13:07:37 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id ECnMdAaPFcSl; Thu, 20 Jul 2023 13:07:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1689872857;
        bh=glW40uY0uFwX/9MnPDdB2OI8tCiPfxvzTv6gvs9+Orw=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=EQOWoZCSu3UjMQztHHrpJIOz6h+TL40/8jSm2Qr16lk9s4/ZN6Na7mNG/CbFE5g69
         8tWicaM2WKEJSA9yHQOwf3xQ5IxTP3DDZTcta9XB6CRbsdaX/NH24B3vSt2uGnShP5
         FI3Hmxt9L1Kx7yhKhRqYIER1pD+68CuuWMXomPBY=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::c14])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 0410A1286255;
        Thu, 20 Jul 2023 13:07:35 -0400 (EDT)
Message-ID: <d67ac07c71097a4c97c8792c7c1fac9f4d5850dd.camel@HansenPartnership.com>
Subject: Re: [RFC PATCH v2] x86/boot: add .sbat section to the bzImage
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Eric Snowberg <eric.snowberg@oracle.com>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     "Daniel P." =?ISO-8859-1?Q?Berrang=E9?= <berrange@redhat.com>,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "bluca@debian.org" <bluca@debian.org>,
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
Date:   Thu, 20 Jul 2023 13:07:34 -0400
In-Reply-To: <FBDC67DD-856F-429B-8E91-B0CA8B0F24B9@oracle.com>
References: <20230711154449.1378385-1-eesposit@redhat.com>
         <ZK/9MlTh435FP5Ji@gambale.home> <ZLABozIRVGmwuIBf@gambale.home>
         <ba2354dc63fd741d2d351b18d4312d0771c0935d.camel@HansenPartnership.com>
         <ZLVyvAXwtemx1I6p@redhat.com>
         <0aa647f719103e8620d7209cbde40f04a7334749.camel@HansenPartnership.com>
         <FBDC67DD-856F-429B-8E91-B0CA8B0F24B9@oracle.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 2023-07-20 at 16:46 +0000, Eric Snowberg wrote:
> If a distro adds a SBAT section to either their UKI, or if kernel
> SBAT enforcement is turned on from GRUB2 by default, there is one
> piece missing that would need  to be handled by the mainline kernel
> which is SBAT enforcement for kexec. This  would mean the revocations
> SBAT protect against would need to be referenced  before doing the
> signature validation in kexec. If this is not added, any distro that 
> allows kexec really doesn’t have a SBAT protected kernel.

Um, actually, this is actually one of the misunderstandings of the
whole thread: sbat is a revocation mechanism for protecting EFI boot
security.  It's design is to prevent malicious actors exploiting buggy
code to get into the EFI boot system before ExitBootServices is called
and nothing more.  The kernel's intrusion into EFI boot security is
tiny: it's basically the EFI stub up to ExitBootServices, so even if
the kernel were to have an sbat number it would obviously be under the
control of the maintainers of only that code (i.e. Ard) and it would
only rev if we actually found a usable exploit in the efi stub.

As far as kexec is concerned, ExitBootServices is long gone and nothing
a future kexec'd kernel can do can alter that, so there's no EFI
security benefit to making kexec sbat aware, and thus it seems there's
no need to do anything about it for kexec.  Now if we're interested in
sbat as a more general revocation mechanism, that might change, but I
think sbat is too tightly designed for the problems of EFI variables to
be more generally useful.

James

