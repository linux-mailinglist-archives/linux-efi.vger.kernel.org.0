Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC851274C
	for <lists+linux-efi@lfdr.de>; Fri,  3 May 2019 07:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbfECFva (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 3 May 2019 01:51:30 -0400
Received: from mga05.intel.com ([192.55.52.43]:61367 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725775AbfECFva (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 3 May 2019 01:51:30 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 May 2019 22:51:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,424,1549958400"; 
   d="scan'208";a="167149467"
Received: from jsakkine-mobl1.tm.intel.com (HELO localhost) ([10.237.50.189])
  by fmsmga002.fm.intel.com with ESMTP; 02 May 2019 22:51:26 -0700
Date:   Fri, 3 May 2019 08:51:26 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Matthew Garrett <mjg59@google.com>, Ingo Molnar <mingo@kernel.org>,
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
Message-ID: <20190503055126.GD3728@linux.intel.com>
References: <20190227202658.197113-1-matthewgarrett@google.com>
 <20190227202658.197113-3-matthewgarrett@google.com>
 <CAJzaN5pUJoOCz5-ZDSnTb6dbVPuy0QwmFD0CeofAGK+bRQx0og@mail.gmail.com>
 <CACdnJutpBPAX6TOGgs3Ng2v_cC5hAf-3pHThESvjQ9vbvQeVkA@mail.gmail.com>
 <CAKv+Gu9PF4u=-7QL4e36Q3S5kC4+5Z=yLYHLT9jE+eNY7YUV7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKv+Gu9PF4u=-7QL4e36Q3S5kC4+5Z=yLYHLT9jE+eNY7YUV7A@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, May 02, 2019 at 09:14:49AM +0200, Ard Biesheuvel wrote:
> (+ Ingo)
> 
> On Tue, 30 Apr 2019 at 21:52, Matthew Garrett <mjg59@google.com> wrote:
> >
> > On Tue, Apr 30, 2019 at 6:07 AM Bartosz Szczepanek <bsz@semihalf.com> wrote:
> > >
> > > I may be a little late with this comment, but I've just tested these
> > > patches on aarch64 platform (from the top of jjs/master) and got
> > > kernel panic ("Unable to handle kernel read", full log at the end of
> > > mail). I think there's problem with below call to
> > > tpm2_calc_event_log_size(), where physical address of efi.tpm_log is
> > > passed as (void *) and never remapped:
> >
> > Yes, it looks like this is just broken. Can you try with the attached patch?
> 
> I'm a bit uncomfortable with EFI code that is obviously broken and
> untested being queued for the next merge window in another tree.
> 
> What is currently queued there? Can we revert this change for the time
> being, and resubmit it via the EFI tree for v5.3?

Nothing ATM. The broken code is in my master branch ATM. Nothing
in my next branch nor have I included anything to my PRs. Should
be nothing to worry about in that sense :-)

/Jarkko
