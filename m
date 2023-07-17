Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 376517568B8
	for <lists+linux-efi@lfdr.de>; Mon, 17 Jul 2023 18:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbjGQQJ6 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 17 Jul 2023 12:09:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbjGQQJ5 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 17 Jul 2023 12:09:57 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8486A1AC;
        Mon, 17 Jul 2023 09:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1689610195;
        bh=Bv+pwpJ+oI9bej7GzVoTr/6OprE/oRwJNiev2GZLjnI=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=tmsko/nGLSiPzr6oksVrKNsNFAt4ckj/jU+kt3+3wXx9+i8cUE7Vk1U1Qo1/QQWhl
         FPQEVdBqRb+vNIyW18n28xH9mrp4ojgbeSJmh9olz9xMCZWcLi7CxSv+5MCNW1+Q5s
         +gRbadHnpqZoi+mLdp8U55cARFsLzNZLeXTgxuHk=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 01FBB12816B5;
        Mon, 17 Jul 2023 12:09:55 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id UuxOTA0-6V0a; Mon, 17 Jul 2023 12:09:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1689610194;
        bh=Bv+pwpJ+oI9bej7GzVoTr/6OprE/oRwJNiev2GZLjnI=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=JNt6QNxEoRGBW/6Az8Geptwotr4p1NXnQ3RXdfIsJMS2EMmxLugQDVtSaZ0tb5Aty
         9CQNMxavTOwNbdK7v8eSDP7Wrw85yLb+stzr/u0duqLwlsyLx09WWMfuYAUYJf5pAp
         O3d3omMY4MJGWmAGAEXbIP8OheYugeM0U7Tsv/0c=
Received: from [IPv6:2601:5c4:4302:c21::a774] (unknown [IPv6:2601:5c4:4302:c21::a774])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id B09D612810B3;
        Mon, 17 Jul 2023 12:08:29 -0400 (EDT)
Message-ID: <ba2354dc63fd741d2d351b18d4312d0771c0935d.camel@HansenPartnership.com>
Subject: Re: [RFC PATCH v2] x86/boot: add .sbat section to the bzImage
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Ard Biesheuvel <ardb@kernel.org>,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>
Cc:     x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        bluca@debian.org, lennart@poettering.net,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "Daniel P ." =?ISO-8859-1?Q?Berrang=E9?= <berrange@redhat.com>,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org
Date:   Mon, 17 Jul 2023 12:08:26 -0400
In-Reply-To: <ZLABozIRVGmwuIBf@gambale.home>
References: <20230711154449.1378385-1-eesposit@redhat.com>
         <ZK/9MlTh435FP5Ji@gambale.home> <ZLABozIRVGmwuIBf@gambale.home>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 2023-07-13 at 15:52 +0200, Ard Biesheuvel wrote:
> (add linux-efi@ cc)

Thanks for that, since this is really EFI related rather than x86.

> On Thu, Jul 13, 2023 at 03:33:38PM +0200, Ard Biesheuvel wrote:
> > Hello Emanuele,
> > 
> > Please cc the linux-efi@ mailing list and myself on EFI related
> > patches.
> > 
> > First of all, I think the tone of the discussion is way out of hand
> > on both sides of the debate. Please keep it civil and courteous.
> > 
> > On Tue, Jul 11, 2023 at 11:44:49AM -0400, Emanuele Giuseppe
> > Esposito wrote:
> > > *Important*: this is just an RFC, as I am not expert in this area
> > > and I don't know what's the best way to achieve this.
> > > 
> > > v2:
> > > * add standard "sbat,1,SBAT Version,..." header string
> > > 
> > > The aim of this patch is to add a .sbat section to the linux
> > > binary
> > > (https://github.com/rhboot/shim/blob/main/SBAT.md).
> > > We mainly need SBAT in UKIs (Unified Kernel Images), as we might
> > > want to revoke authorizations to specific signed PEs that were
> > > initially considered as trusted. The reason might be for example
> > > a security issue related to a specific linux release.
> > > 
> > > A .sbat is simply a section containing a string with the
> > > component name and a version number. This version number is
> > > compared with the value in OVMF_VARS, and if it's less than the
> > > variable, the binary is not trusted, even if it is correctly
> > > signed.
> > > 
> > 
> > Most people will not known what OVMF_VARS is or a PE.
> > 
> > Also, 'version number' is a bit vague, better to stick with
> > existing terminology that makes this more self explanatory: the
> > component that authenticates the kernel image keeps a revocation
> > counter, and refuses to load authentic images whose revocation
> > index is lower than the revocation counter. This approach removes
> > the need for revoking individual image hashes or having to rotate
> > the signing keys when a vulnerability is discovered.
> > 
> > The argument that we need this in the upstream kernel seems to be
> > predicated on the assumption that there is one universal signing
> > authority and revocation domain, but this is not necessarily true.
> > Even if the distros appear to have decided that it is a reasonable
> > choice to deploy the MicroSoft signed shim and the associated
> > components on other systems than Windows-crippled x86 PCs, this is
> > not universally true, and UEFI secure boot can be (and is) deployed
> > in sane ways as well.

Well, yes, but just because sanity exists, doesn't mean we can ignore
the current insanity in the Laptop/desktop x86 space.

The problem, as I see it, is if the distros give the kernel an .sbat
section, that means any vanilla kernel that's built by a user and
signed by their key now won't work (even if their key is in MoK)
because it won't have an sbat section ... and the sbat mechanism is
component specific, not key specific, so the signer has no choice but
to adopt it.

There are two ways out of this: give the kernel an sbat section that's
always current, which is what the proposed patch does (but rather falls
down on the who keeps it current and how part) or actually add sbat
addition to the signing tools, so people who sign their own kernels can
simply go on doing that and no-one else need worry.

I rather incline to the latter, but as a maintainer of a secure boot
signing tool I would say that.  I could easily add tools that tell
someone what the current SBAT level is on the machine they're using, or
in any given boot component, which will make it very easy to add the
correct one.  If it becomes the responsibility of the signer, they're
the ones who decide whether what they've signed revokes everything else
(which they'd never realistically do if they want to keep booting
distro kernels in addition to their own).

James

