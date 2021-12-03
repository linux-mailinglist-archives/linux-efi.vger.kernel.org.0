Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A0D3467C26
	for <lists+linux-efi@lfdr.de>; Fri,  3 Dec 2021 18:02:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240107AbhLCRFT (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 3 Dec 2021 12:05:19 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:35804 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240062AbhLCRFP (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 3 Dec 2021 12:05:15 -0500
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from light.dominikbrodowski.net (brodo.linta [10.2.0.102])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id 149C6201378;
        Fri,  3 Dec 2021 17:01:47 +0000 (UTC)
Received: by light.dominikbrodowski.net (Postfix, from userid 1000)
        id 940C620257; Fri,  3 Dec 2021 18:01:43 +0100 (CET)
Date:   Fri, 3 Dec 2021 18:01:43 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Theodore Ts'o <tytso@mit.edu>, "Ivan T. Ivanov" <iivanov@suse.de>,
        Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, hsinyi@chromium.org
Subject: Re: [PATCH v4] random: fix crash on multiple early calls to
 add_bootloader_randomness()
Message-ID: <YapNd0byhBcnABei@light.dominikbrodowski.net>
References: <20211012082708.121931-1-iivanov@suse.de>
 <YWVKAk4h5bsUA3b6@light.dominikbrodowski.net>
 <YaivhAV8LouB0zGV@light.dominikbrodowski.net>
 <CAHmME9qxBeBzfKCjzfAFX9ZWAGKv1TKCQw3x22d_DmJtaAewLw@mail.gmail.com>
 <YanOIvAV1iPBEXR3@light.dominikbrodowski.net>
 <CAHmME9qGHo4n6QGxnE+O46pagOR0bA+9E8bi8ZLPAzMuMZpPwg@mail.gmail.com>
 <b2a5b4a7-4aee-558c-5558-549fd2998165@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2a5b4a7-4aee-558c-5558-549fd2998165@zx2c4.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Jason,

Am Fri, Dec 03, 2021 at 05:47:41PM +0100 schrieb Jason A. Donenfeld:
> On 12/3/21 16:39, Jason A. Donenfeld wrote:
> > Hi Dominik,
> > 
> > Thanks for your analysis. Some more questions:
> > 
> > On Fri, Dec 3, 2021 at 8:59 AM Dominik Brodowski
> > <linux@dominikbrodowski.net> wrote:
> > > On subsequent calls to add_bootloader_randomness() and then to
> > > add_hwgenerator_randomness(), crng_fast_load() will be skipped. Instead,
> > > wait_event_interruptible() (which makes no sense for the init process)
> > > and then credit_entropy_bits() will be called. If the entropy count for
> > > that second seed is large enough, that proceeds to crng_reseed().
> > > However, crng_reseed() may depend on workqueues being available, which
> > > is not the case early during boot.
> > 
> > It sounds like *the* issue you've identified is that crng_reseed()
> > calls into workqueue functions too early in init, right? The bug is
> > about paths into crng_reseed() that might cause that?
> > 
> > If so, then specifically, are you referring to crng_reseed()'s call to
> > numa_crng_init()? In other words, the cause of the bug would be
> > 6c1e851c4edc ("random: fix possible sleeping allocation from irq
> > context")? If that's the case, then I wonder if the problem you're
> > seeing goes away if you revert both 6c1e851c4edc ("random: fix
> > possible sleeping allocation from irq context") and its primary
> > predecessor, 8ef35c866f88 ("random: set up the NUMA crng instances
> > after the CRNG is fully initialized"). These fix an actual bug, so I'm
> > not suggesting we actually revert these in the tree, but for the
> > purpose of testing, I'm wondering if this is actually the root cause
> > of the bug you're seeing.
> 
> If the above holds, I wonder if something more basic like the below would do
> the trick -- deferring the bringup of the secondary pools until later on in
> rand_initialize.

Firstly, wasn't this done before 8ef35c866f88 -- and initializing the NUMA
crng even if not enough entropy had been obtained yet?

Secondly, this approach seems works for small amounts of entropy submitted
to add_bootloader_randomness (e.g. for four calls with 8 bytes), but not for
larger quantities (e.g. for four calls with 64 bytes). Don't ask me why,
though.

Thirdly, this still does not fix the issue that only the second call to
add_bootloader_randomness() credits entropy.

Thanks,
	Dominik
