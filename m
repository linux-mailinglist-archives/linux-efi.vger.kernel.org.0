Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5604D219AC7
	for <lists+linux-efi@lfdr.de>; Thu,  9 Jul 2020 10:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726193AbgGII2R (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 9 Jul 2020 04:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726247AbgGII2Q (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 9 Jul 2020 04:28:16 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69B9DC061A0B;
        Thu,  9 Jul 2020 01:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NWFj2V6cxUSTsKbsAmHW98rzpJRUzD2nP4IA25RU07o=; b=evyv0BMPkzrls+U4oHEFIIm/5d
        TD/Km3xUwPwbZCUcVwwwz7vPggeDhTJ11FxTvBiZY6MZtGm1gzTL5rbMrNv3WrUlDZU++Qsu8R7O4
        st0FsHJPKzf8Fuhn36dAu+tImp32tB7gBLjLgq/fvmFooY3NdpTYuGPzMxaSCHXT3IXt8MQPANU2z
        lQkgokwtyTZavgftzkXGwn5ltdQSNcFwa8AraQgm8VBWwnqbjTDobhhu5hJUVK3XBtnvw4gyQAwoN
        N4F0/yer/WDrIPOnEPXtoiVeMBpxrTwD0t+pAe49GnfDOj0TKYd/4a44ZCWqpd4SC+kz8x7Wdj8gP
        c97q7xkg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jtRuc-0001XH-Mw; Thu, 09 Jul 2020 08:28:10 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 569C330047A;
        Thu,  9 Jul 2020 10:28:08 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4CDBD29E916A7; Thu,  9 Jul 2020 10:28:08 +0200 (CEST)
Date:   Thu, 9 Jul 2020 10:28:08 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ingo Molnar <mingo@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        linux-efi <linux-efi@vger.kernel.org>
Subject: Re: [GIT PULL] EFI fixes
Message-ID: <20200709082808.GH597537@hirez.programming.kicks-ass.net>
References: <20200628182601.GA84577@gmail.com>
 <CAHk-=wgD+q+oDdtukYC74_cDX5i0Ynf0GLhuNe2Faaokejj6fQ@mail.gmail.com>
 <20200708162053.GU4800@hirez.programming.kicks-ass.net>
 <CAHk-=wggLLv8dY7ViOm7rdHxVNKJUkZMuR90vXO307WkBT8qrw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wggLLv8dY7ViOm7rdHxVNKJUkZMuR90vXO307WkBT8qrw@mail.gmail.com>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Jul 08, 2020 at 11:00:19AM -0700, Linus Torvalds wrote:
> On Wed, Jul 8, 2020 at 9:21 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > It's perhaps yet another reason to just skip gcc-4.8 too, since
> > > apparently 4.9 works.
> > >
> > > gcc-4.9 really has a lot of advantages. It's where (I think) gcc
> > > basically supports all C11 things, including _Generic() but also
> > > __auto_type.
> >
> > +1
> >
> > Anybody for nay, or should we just do this?
> 
> I'll just do it. Let's see if anybody screams with a good reason. I
> hate the whole "support old compilers", it ends up not only making for
> complex code, it tends to cause these unnecessary kinds of "guys, we
> tested this really well, but that crazy compiler had a very particular
> odd issue, and it wasn't in any test box.

Excellent, thanks!
