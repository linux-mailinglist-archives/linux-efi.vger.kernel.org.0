Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 809D41BEA4F
	for <lists+linux-efi@lfdr.de>; Wed, 29 Apr 2020 23:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbgD2VxK (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 29 Apr 2020 17:53:10 -0400
Received: from smtprelay0210.hostedemail.com ([216.40.44.210]:60898 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726911AbgD2VxK (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 29 Apr 2020 17:53:10 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 88EC8837F253;
        Wed, 29 Apr 2020 21:53:09 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1777:1792:2194:2199:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3870:3871:3872:4321:5007:6691:7903:7974:9108:10004:10400:10848:11026:11232:11658:11914:12296:12297:12679:12740:12760:12895:13069:13311:13357:13439:14181:14659:14721:21080:21212:21433:21627:21660:30029:30054:30060:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: jump77_1b7053dcfbe42
X-Filterd-Recvd-Size: 2010
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Wed, 29 Apr 2020 21:53:08 +0000 (UTC)
Message-ID: <31b23951ee2b8e2391f3208b60a7132df18be74e.camel@perches.com>
Subject: Re: [PATCH 03/10] efi/x86: Use pr_efi_err for error messages
From:   Joe Perches <joe@perches.com>
To:     Arvind Sankar <nivedita@alum.mit.edu>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi <linux-efi@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Wed, 29 Apr 2020 14:53:07 -0700
In-Reply-To: <20200429214332.GC1621173@rani.riverdale.lan>
References: <20200429174120.1497212-1-nivedita@alum.mit.edu>
         <20200429174120.1497212-5-nivedita@alum.mit.edu>
         <f74fe4ad56c0471f863ce550869391c8811f9893.camel@perches.com>
         <CAMj1kXGn70BmapKe=6sA17gMCcWRLCebQJFnyObwRbAefOcEng@mail.gmail.com>
         <20200429214332.GC1621173@rani.riverdale.lan>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 2020-04-29 at 17:43 -0400, Arvind Sankar wrote:
> On Wed, Apr 29, 2020 at 08:49:21PM +0200, Ard Biesheuvel wrote:
> > On Wed, 29 Apr 2020 at 20:47, Joe Perches <joe@perches.com> wrote:
> > > On Wed, 2020-04-29 at 13:41 -0400, Arvind Sankar wrote:
> > > > Use pr_efi_err instead of bare efi_printk for error messages.
> > > 
> > > Perhaps it'd be better to rename pr_efi_err to eri_err
> > > so it's clearer it's a typical efi_ logging function.
> > > 
> > > $ git grep -w --name-only pr_efi_err | \
> > >   xargs sed -i 's/\bpr_efi_err\b/efi_err/g'
> > > 
> > 
> > Yeah, pr_efi_err() is probably not the best name
> 
> Should I rename pr_efi/pr_efi_err to, say, efi_pr_info/efi_pr_error?

Perhaps not use pr_ in the name at all.

I suggest:

pr_efi		-> efi_info (or efi_debug or efi_dbg)
		   (it is guarded by an efi_quiet flag, default: on)
pr_efi_err	-> efi_err


