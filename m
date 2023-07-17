Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCBE97569BA
	for <lists+linux-efi@lfdr.de>; Mon, 17 Jul 2023 18:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbjGQQ51 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 17 Jul 2023 12:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbjGQQ5Z (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 17 Jul 2023 12:57:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30705F7
        for <linux-efi@vger.kernel.org>; Mon, 17 Jul 2023 09:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689612997;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:in-reply-to:in-reply-to:  references:references;
        bh=AMmCJfIuZBK8TOlrXcnRNW71QMAvrCE4A3yY2m0hwhE=;
        b=DKIE3dv6Kt7AjQT0RAs5vJYl0UtbhkhMxknKjeQC4zE3Lwkdtb5iWm2YUPp4M33zYs3hh7
        mG/jf1qbWZL5KK+m5IzNhwevhblqfg11k56Stm7zu5VOqlrSrZfQnGP/RE7S+0ZW1y1MVZ
        LVLR/Kx633cctJ5Ii+VoWYFqmtMewCs=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-468-WBCtU6FiNPKTnL0Eemngyw-1; Mon, 17 Jul 2023 12:56:34 -0400
X-MC-Unique: WBCtU6FiNPKTnL0Eemngyw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4B9EA3C19340;
        Mon, 17 Jul 2023 16:56:33 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.62])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E9D104CD0F1;
        Mon, 17 Jul 2023 16:56:30 +0000 (UTC)
Date:   Mon, 17 Jul 2023 17:56:28 +0100
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
Message-ID: <ZLVyvAXwtemx1I6p@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20230711154449.1378385-1-eesposit@redhat.com>
 <ZK/9MlTh435FP5Ji@gambale.home>
 <ZLABozIRVGmwuIBf@gambale.home>
 <ba2354dc63fd741d2d351b18d4312d0771c0935d.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ba2354dc63fd741d2d351b18d4312d0771c0935d.camel@HansenPartnership.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Jul 17, 2023 at 12:08:26PM -0400, James Bottomley wrote:
> On Thu, 2023-07-13 at 15:52 +0200, Ard Biesheuvel wrote:
> > (add linux-efi@ cc)
>
> Thanks for that, since this is really EFI related rather than x86.

snip

> The problem, as I see it, is if the distros give the kernel an .sbat
> section, that means any vanilla kernel that's built by a user and
> signed by their key now won't work (even if their key is in MoK)
> because it won't have an sbat section ... and the sbat mechanism is
> component specific, not key specific, so the signer has no choice but
> to adopt it.

AFAICT, that problem only exists for binaries directly invoked
from shim. So that would be a problem for the boot loader (grub),
or a kernel image being booted directly without a bootloader
present.

For kernel binaries invoked indirectly by the boot loader, the
use of SBAT is currently optional. ie missing SBAT record would
be treated as success.

This was a pragmatic way to introduce SBAT support as it only
impacted grub at that time.

Once a distro starts adding SBAT to their kenrels too though, we
can forsee that they would like to enforce SBAT for the whole
boot chain, to prevent rollback to previously signed binaries
that lacked SBAT info.

This policy could be enforced per key though. eg require SBAT
for anything verified against the vendor key that's compiled into
shim, but not require SBAT for binaries verified with the MoK
entries.

The user specific MoK entries don't have such a compelling use
case for SBAT, since if they need to revoke old binaries, the
end users always have the easy fallback option of just rotating
their signing keys and switching out the enrolled key in MoK.

The choice of whether to mandate SBAT for binaries signed with
a MoK entry, could be set by the end user themselves at the time
their enroll their signing cert in the MoK DB.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

