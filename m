Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49B3429628C
	for <lists+linux-efi@lfdr.de>; Thu, 22 Oct 2020 18:20:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2896798AbgJVQUj (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 22 Oct 2020 12:20:39 -0400
Received: from smtprelay0126.hostedemail.com ([216.40.44.126]:59308 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2896796AbgJVQUj (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 22 Oct 2020 12:20:39 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 5284912EE;
        Thu, 22 Oct 2020 16:20:38 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 10,1,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:967:968:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2525:2553:2561:2564:2682:2685:2828:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3870:3871:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:5007:6248:6742:8985:9025:10004:10400:11232:11658:11914:12043:12219:12297:12438:12555:12663:12740:12760:12895:12986:13069:13255:13311:13357:13439:13845:14096:14097:14181:14659:14721:14777:21080:21324:21433:21451:21627:21788:21811:21889:30029:30054:30070:30074:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: juice98_4f032d527252
X-Filterd-Recvd-Size: 2328
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf17.hostedemail.com (Postfix) with ESMTPA;
        Thu, 22 Oct 2020 16:20:35 +0000 (UTC)
Message-ID: <133aa0c8c5e2cbc862df109200b982e89046dbc0.camel@perches.com>
Subject: Re: [PATCH -next] treewide: Remove stringification from __alias
 macro definition
From:   Joe Perches <joe@perches.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-crypto@vger.kernel.org,
        linux-mm <linux-mm@kvack.org>
Date:   Thu, 22 Oct 2020 09:20:34 -0700
In-Reply-To: <20201022073307.GP2628@hirez.programming.kicks-ass.net>
References: <e9b1ba517f06b81bd24e54c84f5e44d81c27c566.camel@perches.com>
         <20201022073307.GP2628@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 2020-10-22 at 09:33 +0200, Peter Zijlstra wrote:
> On Wed, Oct 21, 2020 at 11:58:25AM -0700, Joe Perches wrote:
> > Like the __section macro, the __alias macro uses
> > macro # stringification to create quotes around
> > the section name used in the __attribute__.
> > 
> > Remove the stringification and add quotes or a
> > stringification to the uses instead.
> 
> There's a complete lack of rationale for this change.

I'll eventually post V2.
I'm waiting to see if there are more comments.

As I wrote in reply to Ard:

https://lore.kernel.org/lkml/1cecfbfc853b2e71a96ab58661037c28a2f9280e.camel@perches.com/

Using quotes in __section caused/causes differences
between clang and gcc.

https://lkml.org/lkml/2020/9/29/2187

Using common styles for details like this is good.

