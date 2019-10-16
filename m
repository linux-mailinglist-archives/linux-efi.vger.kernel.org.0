Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7CB3DA217
	for <lists+linux-efi@lfdr.de>; Thu, 17 Oct 2019 01:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388246AbfJPXZ2 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 16 Oct 2019 19:25:28 -0400
Received: from smtprelay0045.hostedemail.com ([216.40.44.45]:56242 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725970AbfJPXZ2 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 16 Oct 2019 19:25:28 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id B26C85832;
        Wed, 16 Oct 2019 23:25:26 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::::::::,RULES_HIT:41:355:379:599:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1539:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3167:3352:3622:3865:3866:3867:3868:3870:3871:4321:5007:6742:7875:7903:10004:10400:11232:11658:11914:12297:12663:12740:12760:12895:13069:13311:13357:13439:14659:21080:21433:21627:21740:30003:30054:30090:30091,0,RBL:47.151.152.152:@perches.com:.lbl8.mailshell.net-62.14.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:24,LUA_SUMMARY:none
X-HE-Tag: flock47_2f3f58b870741
X-Filterd-Recvd-Size: 2044
Received: from XPS-9350.home (unknown [47.151.152.152])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Wed, 16 Oct 2019 23:25:24 +0000 (UTC)
Message-ID: <3f2feed96a3569e2a27051864ae5e8a84ce634b4.camel@perches.com>
Subject: Re: [PATCH v3] x86, efi: never relocate kernel below lowest
 acceptable address
From:   Joe Perches <joe@perches.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Kairui Song <kasong@redhat.com>, linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Matthew Garrett <matthewgarrett@google.com>,
        Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>,
        x86@kernel.org, linux-efi@vger.kernel.org,
        linux-integrity@vger.kernel.org
Date:   Wed, 16 Oct 2019 16:25:23 -0700
In-Reply-To: <20191016154842.GJ1138@zn.tnic>
References: <20191012034421.25027-1-kasong@redhat.com>
         <20191014101419.GA4715@zn.tnic> <20191014202111.GP15552@linux.intel.com>
         <20191014211825.GJ4715@zn.tnic> <20191016152014.GC4261@linux.intel.com>
         <fb0e7c13da405970d5cbd59c10005daaf970b8da.camel@perches.com>
         <20191016154842.GJ1138@zn.tnic>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 2019-10-16 at 17:48 +0200, Borislav Petkov wrote:
> On Wed, Oct 16, 2019 at 08:23:56AM -0700, Joe Perches wrote:
> > ?  examples please.
> 
> From this very thread:
> 
> \sEfi\s, \sefi\s, \seFI\s etc should be "EFI"
> 
> I'm thinking perhaps start conservatively and catch the most often
> misspelled ones in commit messages or comments. "CPU", "SMT", "MCE",
> "MCA", "PCI" etc come to mind.
> 
> > checkpatch has a db for misspellings, I supposed another for
> > acronyms could be added,
> 
> Doesn't have to be another one - established acronyms are part of the
> dictionary too.

Couldn't work.  The dictionary is case insensitive.


