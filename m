Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 803966E8A1F
	for <lists+linux-efi@lfdr.de>; Thu, 20 Apr 2023 08:08:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233806AbjDTGIn (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 20 Apr 2023 02:08:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjDTGIm (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 20 Apr 2023 02:08:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1405440C2
        for <linux-efi@vger.kernel.org>; Wed, 19 Apr 2023 23:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681970875;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wSFuSvux7VnCbOpwwSFApJu6KXSS6fzL4QItxFfANDg=;
        b=KQi2dS95YYbcmpqogjewDwYdeoCz0kh8DK++YDzLn47yJcrr09JOHcb4ZYLOo8ReUjvl7o
        K6fhUQNeOsWMD41ep84S8uC7b1pO5oahH0FUIWwuNXcJuKHof/YQ/UDLkf5vhZ9GiYhUuT
        YQ3ucX/bEA6nOe9J4Jq9wd7jF49zqfU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-609-Q6NMGBi1NumcfzANwCxDWQ-1; Thu, 20 Apr 2023 02:07:52 -0400
X-MC-Unique: Q6NMGBi1NumcfzANwCxDWQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 56C01185A78F;
        Thu, 20 Apr 2023 06:07:51 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.59])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B727F492B05;
        Thu, 20 Apr 2023 06:07:50 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 84C6D18009A9; Thu, 20 Apr 2023 08:07:49 +0200 (CEST)
Date:   Thu, 20 Apr 2023 08:07:49 +0200
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Evgeniy Baskov <baskov@ispras.ru>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Peter Jones <pjones@redhat.com>,
        Dave Young <dyoung@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Kees Cook <keescook@chromium.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC PATCH 0/3] efi: Implement generic zboot support
Message-ID: <3zm36sbx4enlqaumxxz2gp3f6etwzhlfotqrqxsus2r6xulwvm@saqniauxenmi>
References: <20230416120729.2470762-1-ardb@kernel.org>
 <jwvybt4sro56aiqvddn6jxdjpdelasdhl747c25kzv4vbjr7ph@fbtheokrtxce>
 <CAMj1kXE4xF9RJbaR0H6uuFxxroUJxQFo8WThb=SUa7H0OpDxUg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXE4xF9RJbaR0H6uuFxxroUJxQFo8WThb=SUa7H0OpDxUg@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

  Hi,

> > Realistically, the second option is unlikely to ever be used on x86,
> >
> > What would be needed to do so?  Teach kexec-tools and grub2 parse and
> > load zboot kernels I guess?
> 
> I already implemented this for mach-virt here, so we can load Fedora
> kernels without firmware:
> 
> https://gitlab.com/qemu-project/qemu/-/commit/ff11422804cd03494cc98691eecd3909ea09ab6f
> 
> On arm64, this is probably more straight-forward, as the bare metal
> image is already intended to be booted directly like that. However,
> the x86 uncompressed image requires surprisingly little from all the
> boot_params/setup_header cruft to actually boot, so perhaps there it
> is easy too.

For existing boot loaders like grub I'd expect it being easy
to code up, all the setup header code exists already, grub also
has support for uncompressing stuff, so it should really be only
zboot header parsing and some plumbing to get things going (i.e.
have grub boot efi zboot kernels in bios mode).

Disclaimer: didn't actually check grub source code.

I suspect the bigger problem wrt. grub is that getting patches merged
upstream is extremely slow and every distro carries a huge stack of
patches ...

take care,
  Gerd

