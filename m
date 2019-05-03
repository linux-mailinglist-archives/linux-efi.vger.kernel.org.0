Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC52912786
	for <lists+linux-efi@lfdr.de>; Fri,  3 May 2019 08:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726193AbfECGMP (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 3 May 2019 02:12:15 -0400
Received: from mga11.intel.com ([192.55.52.93]:46409 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725775AbfECGMP (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 3 May 2019 02:12:15 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 May 2019 23:12:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,424,1549958400"; 
   d="scan'208";a="147784716"
Received: from jsakkine-mobl1.tm.intel.com (HELO localhost) ([10.237.50.189])
  by orsmga003.jf.intel.com with ESMTP; 02 May 2019 23:12:10 -0700
Date:   Fri, 3 May 2019 09:12:09 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Matthew Garrett <mjg59@google.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Bartosz Szczepanek <bsz@semihalf.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?iso-8859-1?Q?Thi=E9baud?= Weksteen <tweek@google.com>
Subject: Re: [PATCH V5 2/4] tpm: Reserve the TPM final events table
Message-ID: <20190503061209.GA5630@linux.intel.com>
References: <20190227202658.197113-1-matthewgarrett@google.com>
 <20190227202658.197113-3-matthewgarrett@google.com>
 <CAJzaN5pUJoOCz5-ZDSnTb6dbVPuy0QwmFD0CeofAGK+bRQx0og@mail.gmail.com>
 <CACdnJutpBPAX6TOGgs3Ng2v_cC5hAf-3pHThESvjQ9vbvQeVkA@mail.gmail.com>
 <CAKv+Gu9PF4u=-7QL4e36Q3S5kC4+5Z=yLYHLT9jE+eNY7YUV7A@mail.gmail.com>
 <CACdnJuvDuw0X9iwEqOu7EjM5ca1f+n7f=xqzrTPS9PyrmqKNHQ@mail.gmail.com>
 <20190503060218.GA28048@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190503060218.GA28048@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, May 03, 2019 at 08:02:18AM +0200, Ingo Molnar wrote:
> 
> * Matthew Garrett <mjg59@google.com> wrote:
> 
> > On Thu, May 2, 2019 at 12:15 AM Ard Biesheuvel
> > <ard.biesheuvel@linaro.org> wrote:
> > >
> > > (+ Ingo)
> > >
> > > On Tue, 30 Apr 2019 at 21:52, Matthew Garrett <mjg59@google.com> wrote:
> > > >
> > > > On Tue, Apr 30, 2019 at 6:07 AM Bartosz Szczepanek <bsz@semihalf.com> wrote:
> > > > >
> > > > > I may be a little late with this comment, but I've just tested these
> > > > > patches on aarch64 platform (from the top of jjs/master) and got
> > > > > kernel panic ("Unable to handle kernel read", full log at the end of
> > > > > mail). I think there's problem with below call to
> > > > > tpm2_calc_event_log_size(), where physical address of efi.tpm_log is
> > > > > passed as (void *) and never remapped:
> > > >
> > > > Yes, it looks like this is just broken. Can you try with the attached patch?
> > >
> > > I'm a bit uncomfortable with EFI code that is obviously broken and
> > > untested being queued for the next merge window in another tree.
> > 
> > The patchset was Cc:ed to linux-efi@. Is there anything else I should
> > have done to ensure you picked it up rather than Jarkko?
> 
> That's not the workflow rule the Linux kernel is using, if Cc:-ing a 
> patchset was the only condition for upstream inclusion then we'd have a 
> *LOT* of crap in the Linux kernel.
> 
> Just applying those EFI changes without even as much as an Acked-by from 
> the EFI maintainers is a *totally* unacceptable workflow.
> 
> Please revert/rebase and re-try this on the proper submission channels.
> 
> Meanwhile the broken code is NAK-ed by me:
> 
>    Nacked-by: Ingo Molnar <mingo@kernel.org>

There must be some kind of misconception here. None of the changes have
been submitted so far. They are only in my master branch. They briefly
went to linux-next through my next branch but as soon as issues were
reported I wiped them off from there (which happened like 2-3 weeks
ago). They haven't been part off any of my PR's.

There is nothing to revert.

/Jarkko
