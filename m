Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEE6B756BB0
	for <lists+linux-efi@lfdr.de>; Mon, 17 Jul 2023 20:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbjGQSST (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 17 Jul 2023 14:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231795AbjGQSSC (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 17 Jul 2023 14:18:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3D6A12A
        for <linux-efi@vger.kernel.org>; Mon, 17 Jul 2023 11:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689617769;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1qvL7DDIpxS/xLROYngkGGEjlSuc/hKGHFYsv5Rvjr0=;
        b=SsT4RSktc8zLPZUvh3AFSnfzo8mgkNRq5UZEyOvyDr1fq4gh8/FvXBoEOi9dR7FYPyjfQ4
        1ZyeJCQJrdd/wkGGSXHbKLCOxUXSdtMV/H1AUw00vqL03oDvLfj3FbjpgNCPMDJmRJ7k97
        PUqDFzsveR+pwyb9V13P/N5HgRkVrtE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-149-g9lesL-gMcqJiC3BWMQ59g-1; Mon, 17 Jul 2023 14:16:07 -0400
X-MC-Unique: g9lesL-gMcqJiC3BWMQ59g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C5B32891F20;
        Mon, 17 Jul 2023 18:16:06 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.62])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6E3D21121314;
        Mon, 17 Jul 2023 18:16:04 +0000 (UTC)
Date:   Mon, 17 Jul 2023 19:16:02 +0100
From:   Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
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
Subject: Re: [RFC PATCH v2] x86/boot: add .sbat section to the bzImage
Message-ID: <ZLWFYqh2z9sH6Bfs@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20230711154449.1378385-1-eesposit@redhat.com>
 <ZK/9MlTh435FP5Ji@gambale.home>
 <ZLABozIRVGmwuIBf@gambale.home>
 <ba2354dc63fd741d2d351b18d4312d0771c0935d.camel@HansenPartnership.com>
 <ZLVyvAXwtemx1I6p@redhat.com>
 <0aa647f719103e8620d7209cbde40f04a7334749.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0aa647f719103e8620d7209cbde40f04a7334749.camel@HansenPartnership.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Jul 17, 2023 at 01:15:19PM -0400, James Bottomley wrote:
> On Mon, 2023-07-17 at 17:56 +0100, Daniel P. Berrangé wrote:
> > On Mon, Jul 17, 2023 at 12:08:26PM -0400, James Bottomley wrote:
> > > On Thu, 2023-07-13 at 15:52 +0200, Ard Biesheuvel wrote:
> > > > (add linux-efi@ cc)
> > > 
> > > Thanks for that, since this is really EFI related rather than x86.
> > 
> > snip
> > 
> > > The problem, as I see it, is if the distros give the kernel an
> > > .sbat section, that means any vanilla kernel that's built by a user
> > > and signed by their key now won't work (even if their key is in
> > > MoK) because it won't have an sbat section ... and the sbat
> > > mechanism is component specific, not key specific, so the signer
> > > has no choice but to adopt it.
> > 
> > AFAICT, that problem only exists for binaries directly invoked
> > from shim. So that would be a problem for the boot loader (grub),
> > or a kernel image being booted directly without a bootloader
> > present.
> 
> Well, currently, yes; that's the in_protocol check in
> shim.c:verify_sbat_section().  However, I was assuming based on this
> thread, that that was being tightened up (either because people are
> moving away from grub or because the shim verifier protocol would
> enforce it) as you imply below.
> 
> > For kernel binaries invoked indirectly by the boot loader, the
> > use of SBAT is currently optional. ie missing SBAT record would
> > be treated as success.
> > 
> > This was a pragmatic way to introduce SBAT support as it only
> > impacted grub at that time.
> > 
> > Once a distro starts adding SBAT to their kenrels too though, we
> > can forsee that they would like to enforce SBAT for the whole
> > boot chain, to prevent rollback to previously signed binaries
> > that lacked SBAT info.
> > 
> > This policy could be enforced per key though. eg require SBAT
> > for anything verified against the vendor key that's compiled into
> > shim, but not require SBAT for binaries verified with the MoK
> > entries.
> 
> That might work, but it's not currently in the shim code base.  It also
> wouldn't work for SUSE I suspect: they actually put all of their distro
> keys into MokList (so the machine owner has to approve any SUSE key
> update), so how can shim tell the difference between my key and their
> key?

Interesting, I didn't know that about SUSE's usage pattern. That
would pretty much require that the SBAT enforcement is configured
per MokList entry, to retain sufficient flexibility for users.

> > The user specific MoK entries don't have such a compelling use
> > case for SBAT, since if they need to revoke old binaries, the
> > end users always have the easy fallback option of just rotating
> > their signing keys and switching out the enrolled key in MoK.
> > 
> > The choice of whether to mandate SBAT for binaries signed with
> > a MoK entry, could be set by the end user themselves at the time
> > their enroll their signing cert in the MoK DB.
> 
> Well, I agree with this, since it was my original point.  However, a
> key observation still seems to be that none of this exception proposal
> is actually coded anywhere, so if shim does tighten up sbat
> verification, everyone currently gets caught by it (and if it doesn't
> then the kernel doesn't need an sbat section).
> 
> I really think if this exception proposal is what everyone is planning,
> then you can simply leave the upstream kernel alone, since it won't
> require sbat information unless incorporated into a distro.

I don't know what shim maintainers are planning, this was just an
idea I came up with when thinking through how to enforce SBAT without
making it a pain for users.

> So the direction forward seems to be to get this exception proposal
> coded up and agreed and then we can decide based on that whether the
> upstream kernel needs to care.

Agreed, I think it needs some feedback from the shim maintainers about
a vision for future SBAT enforcement. I'll raise this idea and see
what they say. If we eliminate the need for upstream linux to care
about SBTA that probably makes life easier for everyone.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

