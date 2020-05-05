Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FDD11C4FC7
	for <lists+linux-efi@lfdr.de>; Tue,  5 May 2020 10:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725766AbgEEIBm (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 5 May 2020 04:01:42 -0400
Received: from smtprelay0165.hostedemail.com ([216.40.44.165]:42462 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725833AbgEEIBm (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 5 May 2020 04:01:42 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 85AD5182D31F3;
        Tue,  5 May 2020 08:01:41 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1539:1593:1594:1711:1730:1747:1777:1792:2110:2393:2553:2559:2562:2828:2914:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3872:4321:5007:7903:8603:10004:10400:10848:11232:11658:11914:12296:12297:12740:12760:12895:13069:13311:13357:13439:14181:14659:14721:21080:21627:30012:30054:30060:30070:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: roll80_65f027eb9442c
X-Filterd-Recvd-Size: 1926
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf13.hostedemail.com (Postfix) with ESMTPA;
        Tue,  5 May 2020 08:01:40 +0000 (UTC)
Message-ID: <d0a6e679bc835d89a6b219f44dbbdcdcdea256bc.camel@perches.com>
Subject: Re: [trivial PATCH] efi/libstub: Reduce efi_printk object size
From:   Joe Perches <joe@perches.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>, X86 ML <x86@kernel.org>
Date:   Tue, 05 May 2020 01:01:39 -0700
In-Reply-To: <CAMj1kXGQ7dLNMnheWViBh7BnHd00kWw0AW2aF7i7S2wGti0qKg@mail.gmail.com>
References: <091e3fc3bdbc5f480af7d3b3ac096d174a4480d0.1588273612.git.joe@perches.com>
         <ec53e67b3ac928922807db3cb1585e911971dadc.1588273612.git.joe@perches.com>
         <CAMj1kXHwdy3BTqt-q_qnezyz666BcqKiFxeumfsD+Qjy5qRzZA@mail.gmail.com>
         <f1926d434cdeb091405ef8c01a90c0140d296bed.camel@perches.com>
         <CAMj1kXGQ7dLNMnheWViBh7BnHd00kWw0AW2aF7i7S2wGti0qKg@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 2020-05-05 at 09:50 +0200, Ard Biesheuvel wrote:
> On Mon, 4 May 2020 at 20:29, Joe Perches <joe@perches.com> wrote:
> > Use a few more common kernel styles.
> > 
> > Trivially reduce efi_printk object size by using a dereference to
> > a temporary instead of multiple dereferences of the same object.
> > 
> > Use efi_printk(const char *str) and static or static const for its
> > internal variables.
> > 
> > Use the more common form of while instead of a for loop.
> > 
> > Change efi_char16_printk argument to const.
> > 
> > Signed-off-by: Joe Perches <joe@perches.com>
> 
> Thanks Joe.

No worries, it's not worth applying if
it's not good code.  Just ignore it.

cheers, Joe

