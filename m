Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4922218CD9
	for <lists+linux-efi@lfdr.de>; Wed,  8 Jul 2020 18:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730278AbgGHQVA (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 8 Jul 2020 12:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730133AbgGHQVA (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 8 Jul 2020 12:21:00 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 672FCC061A0B;
        Wed,  8 Jul 2020 09:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=IFxG3I++S1fiEvjW5wx8/JfNFqGKg4LDaTs+WrEu4Ro=; b=mquyLh+TNq/82IQ6Jgx5yTBq2U
        bE2LLEuCKNdN+kfM2lzxwvcQHnhup7SR98CwZfTexIjKhg2nlW2kzrajjqm4DW0Fv9Kpx51V1rqzM
        9FjbU2nqd8VWYxcc7JBl1P/7p3MRiuwvpKe4xbj68c+9zvGBa9OKadTdSzZR9v77wU+FZmKxoG5pL
        9LkA2Sn6V7aPdzeuLSaGRVEdJr+SjDumZITREAxphT+zabMtEP9PcAh6Aa51ZiXE/W+teODrsBIXb
        P+H2JUzM/iEBjsGr120SF/hVbdDNYfLNY8FtCF0vISMdVxLYv4Do6UhqL3qlMBHT2zc2I1nOJzDOQ
        Kn1FZVmw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jtCoY-0001ag-W5; Wed, 08 Jul 2020 16:20:55 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6249E30047A;
        Wed,  8 Jul 2020 18:20:53 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 47897235D47FC; Wed,  8 Jul 2020 18:20:53 +0200 (CEST)
Date:   Wed, 8 Jul 2020 18:20:53 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ingo Molnar <mingo@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        linux-efi <linux-efi@vger.kernel.org>
Subject: Re: [GIT PULL] EFI fixes
Message-ID: <20200708162053.GU4800@hirez.programming.kicks-ass.net>
References: <20200628182601.GA84577@gmail.com>
 <CAHk-=wgD+q+oDdtukYC74_cDX5i0Ynf0GLhuNe2Faaokejj6fQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgD+q+oDdtukYC74_cDX5i0Ynf0GLhuNe2Faaokejj6fQ@mail.gmail.com>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sun, Jun 28, 2020 at 11:57:18AM -0700, Linus Torvalds wrote:
> On Sun, Jun 28, 2020 at 11:26 AM Ingo Molnar <mingo@kernel.org> wrote:
> >
> > - Fix build regression on v4.8 and older
> 
> Interesting.
> 
> It's perhaps yet another reason to just skip gcc-4.8 too, since
> apparently 4.9 works.
> 
> gcc-4.9 really has a lot of advantages. It's where (I think) gcc
> basically supports all C11 things, including _Generic() but also
> __auto_type.

+1

Anybody for nay, or should we just do this?
