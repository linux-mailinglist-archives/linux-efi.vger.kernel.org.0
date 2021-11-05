Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0430446052
	for <lists+linux-efi@lfdr.de>; Fri,  5 Nov 2021 08:54:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232284AbhKEH4k (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 5 Nov 2021 03:56:40 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:37676 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231896AbhKEH4j (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 5 Nov 2021 03:56:39 -0400
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from light.dominikbrodowski.net (brodo.linta [10.2.0.102])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id CD9DE201340;
        Fri,  5 Nov 2021 07:53:57 +0000 (UTC)
Received: by light.dominikbrodowski.net (Postfix, from userid 1000)
        id C6899204BC; Fri,  5 Nov 2021 07:04:39 +0100 (CET)
Date:   Fri, 5 Nov 2021 07:04:39 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        "Ivan T. Ivanov" <iivanov@suse.de>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] random: fix crash on multiple early calls to
 add_bootloader_randomness()
Message-ID: <YYTJd8zt7x8rNbjW@light.dominikbrodowski.net>
References: <20211012082708.121931-1-iivanov@suse.de>
 <YWVKAk4h5bsUA3b6@light.dominikbrodowski.net>
 <YX44DCaIg/qGOrtE@light.dominikbrodowski.net>
 <CAMj1kXEeCwhADMEwfE8SaG=1+J8Lzrck72DixSdxOP3cAK_Uzg@mail.gmail.com>
 <YYI2unrpOm/ap/y6@light.dominikbrodowski.net>
 <CAMj1kXFCW4RQgXXNV7Z02Ljj36egidry0DyMm7+siSL6cocTOA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXFCW4RQgXXNV7Z02Ljj36egidry0DyMm7+siSL6cocTOA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Am Wed, Nov 03, 2021 at 08:27:39AM +0100 schrieb Ard Biesheuvel:
> > > > -       if (unlikely(crng_init == 0)) {
> > > > +       /* We cannot do much with the input pool until it is set up in
> > > > +        * rand_initalize(); therefore just mix into the crng state.
> > > > +        * As this does not affect the input pool, we cannot credit
> > > > +        * entropy for this.
> > > > +        */
> > > > +       if (unlikely(crng_init == 0) || unlikely(crng_global_init_time == 0)) {
> > >
> > > Can we just drop the unlikely()s here?
> >
> > As that would be a different change to the one necessary to resolve the bug,
> > I'd like to defer that decision to the maintainer of random.c.
> >
> 
> In that case, can we at least using a single unlikely() for the whole condition?

Fixed for v3.

Thanks,
	Dominik
