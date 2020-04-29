Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD201BE79F
	for <lists+linux-efi@lfdr.de>; Wed, 29 Apr 2020 21:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbgD2TrI (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 29 Apr 2020 15:47:08 -0400
Received: from smtprelay0067.hostedemail.com ([216.40.44.67]:50626 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726973AbgD2TrH (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 29 Apr 2020 15:47:07 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id EC3375820;
        Wed, 29 Apr 2020 19:47:04 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1539:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3867:3870:3871:3872:4321:5007:7903:10004:10400:10848:11232:11658:11914:12296:12297:12740:12760:12895:13069:13311:13357:13439:14181:14659:14721:21080:21212:21324:21451:21627:21660:30012:30054:30060:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: brain68_5acb823abe628
X-Filterd-Recvd-Size: 1922
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Wed, 29 Apr 2020 19:47:03 +0000 (UTC)
Message-ID: <f53e716ac4da310d0d9ed7d211ac17ba8ec64699.camel@perches.com>
Subject: Re: [PATCH 03/10] efi/x86: Use pr_efi_err for error messages
From:   Joe Perches <joe@perches.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        linux-efi <linux-efi@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Wed, 29 Apr 2020 12:47:02 -0700
In-Reply-To: <CAMj1kXHN1j4+h-mTf_EpsaX3-ifAtKJOPmSSq9LvHoFUUg+0bw@mail.gmail.com>
References: <20200429174120.1497212-1-nivedita@alum.mit.edu>
         <20200429174120.1497212-5-nivedita@alum.mit.edu>
         <f74fe4ad56c0471f863ce550869391c8811f9893.camel@perches.com>
         <CAMj1kXGn70BmapKe=6sA17gMCcWRLCebQJFnyObwRbAefOcEng@mail.gmail.com>
         <3fa8fba37f9339adc993cdb7afc77ed0e063967d.camel@perches.com>
         <CAMj1kXHN1j4+h-mTf_EpsaX3-ifAtKJOPmSSq9LvHoFUUg+0bw@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 2020-04-29 at 20:59 +0200, Ard Biesheuvel wrote:
> On Wed, 29 Apr 2020 at 20:57, Joe Perches <joe@perches.com> wrote:
> > On Wed, 2020-04-29 at 20:49 +0200, Ard Biesheuvel wrote:
> > > On Wed, 29 Apr 2020 at 20:47, Joe Perches <joe@perches.com> wrote:
> > > > Looking at code for efi_printk -> efi_char16_printk,
> > > > it's somewhat difficult to see where the "output_string"
> > > > function pointer is set.  Any clue?
> > > It is set by the firmware.
> > 
> > Sure, where in the code though?
> > 
> 
> In which code? The firmware code?

I presume it's set from a struct received from hardware/firmware
somewhere in drivers/firmware/efi, but it doesn't seem clear where.

