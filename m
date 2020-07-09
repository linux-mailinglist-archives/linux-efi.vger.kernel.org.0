Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCB6C21AB0D
	for <lists+linux-efi@lfdr.de>; Fri, 10 Jul 2020 00:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbgGIW6e (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 9 Jul 2020 18:58:34 -0400
Received: from linux.microsoft.com ([13.77.154.182]:55292 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726889AbgGIW6e (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 9 Jul 2020 18:58:34 -0400
Received: from sequoia (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id 7CF3B20B4908;
        Thu,  9 Jul 2020 15:58:32 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7CF3B20B4908
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1594335513;
        bh=hSzJx2wtRzs8tVYEA8JZveVIM1/46jY2Nc6LR+6a8eQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rSk5WGGOxrF25+SM75K/PBmOHPatBSoFi5EA1+37GzkrFox6aXG2W26Y4Rlpu8Szf
         5yXyDBc3XeLf2DF2jjnRfAGARelF7M2sQA7qCez+gwAoizU4ysAQcEWlaoGkjHGLzo
         jZk1MKmAQcVBakotL38XMKeFn0+YsOHsbgEn+3SQ=
Date:   Thu, 9 Jul 2020 17:58:23 -0500
From:   Tyler Hicks <tyhicks@linux.microsoft.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Matthew Garrett <mjg59@google.com>,
        Peter Jones <pjones@redhat.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Petr Vandrovec <petr@vmware.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        Thirupathaiah Annapureddy <thiruan@microsoft.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tpm: Require that all digests are present in
 TCG_PCR_EVENT2 structures
Message-ID: <20200709225823.GA4939@sequoia>
References: <20200615232504.1848159-1-tyhicks@linux.microsoft.com>
 <CAMj1kXHJbsxA2-jqpbLnUeeNfM0oC8Sh70+axOKoBCFMJ8+jKQ@mail.gmail.com>
 <20200617230958.GC62794@linux.intel.com>
 <20200630183321.GE4694@sequoia>
 <20200702235718.GI31291@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200702235718.GI31291@linux.intel.com>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 2020-07-03 02:57:18, Jarkko Sakkinen wrote:
> On Tue, Jun 30, 2020 at 01:33:21PM -0500, Tyler Hicks wrote:
> > Jarkko, is this an ack from you?
> > 
> > Is there anything I can do to help along this fix?
> > 
> > I've spoke with two others that have poured through these specs to
> > implement firmware event log parsers and they thought the change made
> > sense.
> > 
> > Tyler
> 
> I revisited the original patch and this stroke into my eye:
> 
> "This is true, for example, when firmware passes the event log to the
> kernel via a reserved memory region described in device tree."
> 
> During this discussion you gave an explanation what can trigger the bug
> but in the commit message nothing anchors to anything.
> 
> Please give a concrete example what can trigger the issue directly in
> the commit message instead. It's obviously needed.
> 
> In addition, you could also rewrite the existing inline comment to be
> something more reasonable to the context.

These are all fair points and I also see that there's a new conflict
with the TPM next branch. I'll rebase the patch on the current next
branch, expand on the commit message, and improve the comment in v2.

Tyler

> 
> /Jarkko
