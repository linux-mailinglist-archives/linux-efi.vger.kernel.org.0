Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B3B12952B2
	for <lists+linux-efi@lfdr.de>; Wed, 21 Oct 2020 21:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502366AbgJUTHi (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 21 Oct 2020 15:07:38 -0400
Received: from smtprelay0071.hostedemail.com ([216.40.44.71]:37686 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2502340AbgJUTHi (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 21 Oct 2020 15:07:38 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 28C0A180A885F;
        Wed, 21 Oct 2020 19:07:37 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:967:968:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1538:1593:1594:1711:1714:1730:1747:1777:1792:2198:2199:2393:2525:2553:2560:2563:2682:2685:2828:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3351:3622:3865:3867:3868:3870:3871:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:5007:6742:8985:9025:10004:10400:10848:11232:11658:11914:12043:12219:12297:12740:12760:12895:13069:13255:13311:13357:13439:14181:14659:14721:21080:21451:21611:21627:21788:30029:30054:30060:30074:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:28,LUA_SUMMARY:none
X-HE-Tag: roof84_28176e32724a
X-Filterd-Recvd-Size: 2172
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf20.hostedemail.com (Postfix) with ESMTPA;
        Wed, 21 Oct 2020 19:07:33 +0000 (UTC)
Message-ID: <1cecfbfc853b2e71a96ab58661037c28a2f9280e.camel@perches.com>
Subject: Re: [PATCH -next] treewide: Remove stringification from __alias
 macro definition
From:   Joe Perches <joe@perches.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
Date:   Wed, 21 Oct 2020 12:07:32 -0700
In-Reply-To: <CAMj1kXHe0hEDiGNMM_fg3_RYjM6B6mbKJ+1R7tsnA66ZzsiBgw@mail.gmail.com>
References: <e9b1ba517f06b81bd24e54c84f5e44d81c27c566.camel@perches.com>
         <CAMj1kXHe0hEDiGNMM_fg3_RYjM6B6mbKJ+1R7tsnA66ZzsiBgw@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 2020-10-21 at 21:02 +0200, Ard Biesheuvel wrote:
> On Wed, 21 Oct 2020 at 20:58, Joe Perches <joe@perches.com> wrote:
> > Like the __section macro, the __alias macro uses
> > macro # stringification to create quotes around
> > the section name used in the __attribute__.
> > 
> > Remove the stringification and add quotes or a
> > stringification to the uses instead.
> > 
> 
> Why?

Using quotes in __section caused/causes differences
between clang and gcc.

https://lkml.org/lkml/2020/9/29/2187

Using common styles for details like this is good.


