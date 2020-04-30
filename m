Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E13321C0698
	for <lists+linux-efi@lfdr.de>; Thu, 30 Apr 2020 21:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbgD3TiG (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 30 Apr 2020 15:38:06 -0400
Received: from smtprelay0066.hostedemail.com ([216.40.44.66]:60034 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726338AbgD3TiG (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 30 Apr 2020 15:38:06 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 1C09F181D330D;
        Thu, 30 Apr 2020 19:38:05 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:968:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1777:1792:2110:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3868:3871:3874:4250:4321:4362:5007:10004:10400:10848:11026:11232:11658:11914:12297:12740:12760:12895:13069:13161:13229:13311:13357:13439:14096:14097:14181:14659:14721:21080:21212:21433:21451:21627:21660:30030:30054:30060:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: camp39_467245017161d
X-Filterd-Recvd-Size: 1907
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Thu, 30 Apr 2020 19:38:03 +0000 (UTC)
Message-ID: <d357dcfec5b5c175ea3430053735399ef6fa87a6.camel@perches.com>
Subject: Re: [PATCH 1/2] efi/libstub: efi_info/efi_err message neatening
From:   Joe Perches <joe@perches.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>, X86 ML <x86@kernel.org>
Date:   Thu, 30 Apr 2020 12:38:02 -0700
In-Reply-To: <CAMj1kXGMnTfYiU_vMDYG0uy7Na7wy=5DRHERTzZQeb4UBusn0g@mail.gmail.com>
References: <20200430182843.2510180-1-nivedita@alum.mit.edu>
         <091e3fc3bdbc5f480af7d3b3ac096d174a4480d0.1588273612.git.joe@perches.com>
         <CAMj1kXGMnTfYiU_vMDYG0uy7Na7wy=5DRHERTzZQeb4UBusn0g@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 2020-04-30 at 21:29 +0200, Ard Biesheuvel wrote:
> On Thu, 30 Apr 2020 at 21:12, Joe Perches <joe@perches.com> wrote:
> > Use a standard style for these output logging messages.
> > 
> > Miscellanea:
> > 
> > o Use more common macro #defines with fmt, ##__VA_ARGS__
> > 0 Remove trailing messages periods and odd ' uses
> > o Remove embedded function names and use %s, __func__
> > 
> > Signed-off-by: Joe Perches <joe@perches.com>
> > ---
> > 
> > Perhaps these trivialities on top of this series?
> > 
> 
> The EFI printing routines don't actually support format strings.

Thanks.  Then nevermind on that bit.

> Removing trailing periods is not really necessary IMO, but i'll take a
> patch that fixes those weird quotes.

<shrug>  Your choice.

There are 60+ uses of efi_err, 12 with a trailing period.

cheers, Joe

