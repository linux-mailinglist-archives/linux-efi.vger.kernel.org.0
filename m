Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F83B7569EE
	for <lists+linux-efi@lfdr.de>; Mon, 17 Jul 2023 19:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbjGQRPZ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 17 Jul 2023 13:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbjGQRPZ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 17 Jul 2023 13:15:25 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A23D18C;
        Mon, 17 Jul 2023 10:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1689614123;
        bh=t2CvEbHEtJOfQbnv6B7KOOw/16eZp8A7w4FgNzGKoBs=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=Sg0LVlf4wlWK7y06XnkN75VcH9O18A1YWdRSNWvLVkUPeOi7nMr8Lc1v0Fz5za8rO
         lthLDHyuDGTVb1uS0K4Rba5SURy0V4K0X2hC1BKsm6KcFmIgMFXuFxPMzFupqCoaGv
         TLhbw/kynnKJ9dAW7GE/Mkh7o8FVIp18R8hD7yBc=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 5B5D0128171B;
        Mon, 17 Jul 2023 13:15:23 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id tzxoBTS866Qv; Mon, 17 Jul 2023 13:15:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1689614123;
        bh=t2CvEbHEtJOfQbnv6B7KOOw/16eZp8A7w4FgNzGKoBs=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=Sg0LVlf4wlWK7y06XnkN75VcH9O18A1YWdRSNWvLVkUPeOi7nMr8Lc1v0Fz5za8rO
         lthLDHyuDGTVb1uS0K4Rba5SURy0V4K0X2hC1BKsm6KcFmIgMFXuFxPMzFupqCoaGv
         TLhbw/kynnKJ9dAW7GE/Mkh7o8FVIp18R8hD7yBc=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::c14])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 70E0B12816B5;
        Mon, 17 Jul 2023 13:15:21 -0400 (EDT)
Message-ID: <0aa647f719103e8620d7209cbde40f04a7334749.camel@HansenPartnership.com>
Subject: Re: [RFC PATCH v2] x86/boot: add .sbat section to the bzImage
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     "Daniel P." =?ISO-8859-1?Q?Berrang=E9?= <berrange@redhat.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>,
        x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        bluca@debian.org, lennart@poettering.net,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org
Date:   Mon, 17 Jul 2023 13:15:19 -0400
In-Reply-To: <ZLVyvAXwtemx1I6p@redhat.com>
References: <20230711154449.1378385-1-eesposit@redhat.com>
         <ZK/9MlTh435FP5Ji@gambale.home> <ZLABozIRVGmwuIBf@gambale.home>
         <ba2354dc63fd741d2d351b18d4312d0771c0935d.camel@HansenPartnership.com>
         <ZLVyvAXwtemx1I6p@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, 2023-07-17 at 17:56 +0100, Daniel P. Berrangé wrote:
> On Mon, Jul 17, 2023 at 12:08:26PM -0400, James Bottomley wrote:
> > On Thu, 2023-07-13 at 15:52 +0200, Ard Biesheuvel wrote:
> > > (add linux-efi@ cc)
> > 
> > Thanks for that, since this is really EFI related rather than x86.
> 
> snip
> 
> > The problem, as I see it, is if the distros give the kernel an
> > .sbat section, that means any vanilla kernel that's built by a user
> > and signed by their key now won't work (even if their key is in
> > MoK) because it won't have an sbat section ... and the sbat
> > mechanism is component specific, not key specific, so the signer
> > has no choice but to adopt it.
> 
> AFAICT, that problem only exists for binaries directly invoked
> from shim. So that would be a problem for the boot loader (grub),
> or a kernel image being booted directly without a bootloader
> present.

Well, currently, yes; that's the in_protocol check in
shim.c:verify_sbat_section().  However, I was assuming based on this
thread, that that was being tightened up (either because people are
moving away from grub or because the shim verifier protocol would
enforce it) as you imply below.

> For kernel binaries invoked indirectly by the boot loader, the
> use of SBAT is currently optional. ie missing SBAT record would
> be treated as success.
> 
> This was a pragmatic way to introduce SBAT support as it only
> impacted grub at that time.
> 
> Once a distro starts adding SBAT to their kenrels too though, we
> can forsee that they would like to enforce SBAT for the whole
> boot chain, to prevent rollback to previously signed binaries
> that lacked SBAT info.
> 
> This policy could be enforced per key though. eg require SBAT
> for anything verified against the vendor key that's compiled into
> shim, but not require SBAT for binaries verified with the MoK
> entries.

That might work, but it's not currently in the shim code base.  It also
wouldn't work for SUSE I suspect: they actually put all of their distro
keys into MokList (so the machine owner has to approve any SUSE key
update), so how can shim tell the difference between my key and their
key?

> The user specific MoK entries don't have such a compelling use
> case for SBAT, since if they need to revoke old binaries, the
> end users always have the easy fallback option of just rotating
> their signing keys and switching out the enrolled key in MoK.
> 
> The choice of whether to mandate SBAT for binaries signed with
> a MoK entry, could be set by the end user themselves at the time
> their enroll their signing cert in the MoK DB.

Well, I agree with this, since it was my original point.  However, a
key observation still seems to be that none of this exception proposal
is actually coded anywhere, so if shim does tighten up sbat
verification, everyone currently gets caught by it (and if it doesn't
then the kernel doesn't need an sbat section).

I really think if this exception proposal is what everyone is planning,
then you can simply leave the upstream kernel alone, since it won't
require sbat information unless incorporated into a distro.

So the direction forward seems to be to get this exception proposal
coded up and agreed and then we can decide based on that whether the
upstream kernel needs to care.

James

