Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0483D9562
	for <lists+linux-efi@lfdr.de>; Wed, 16 Oct 2019 17:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392892AbfJPPUX (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 16 Oct 2019 11:20:23 -0400
Received: from mga07.intel.com ([134.134.136.100]:7188 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387700AbfJPPUV (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 16 Oct 2019 11:20:21 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Oct 2019 08:20:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,304,1566889200"; 
   d="scan'208";a="370829200"
Received: from hagarwal-mobl1.gar.corp.intel.com (HELO localhost) ([10.252.5.165])
  by orsmga005.jf.intel.com with ESMTP; 16 Oct 2019 08:20:15 -0700
Date:   Wed, 16 Oct 2019 18:20:14 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Kairui Song <kasong@redhat.com>, linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Matthew Garrett <matthewgarrett@google.com>,
        Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>,
        x86@kernel.org, linux-efi@vger.kernel.org,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH v3] x86, efi: never relocate kernel below lowest
 acceptable address
Message-ID: <20191016152014.GC4261@linux.intel.com>
References: <20191012034421.25027-1-kasong@redhat.com>
 <20191014101419.GA4715@zn.tnic>
 <20191014202111.GP15552@linux.intel.com>
 <20191014211825.GJ4715@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191014211825.GJ4715@zn.tnic>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Oct 14, 2019 at 11:18:25PM +0200, Borislav Petkov wrote:
> On Mon, Oct 14, 2019 at 11:21:11PM +0300, Jarkko Sakkinen wrote:
> > Was there a section in the patch submission documentation to point out
> > when people send patches with all the possible twists for an acronym?
> 
> I don't think so.
> 
> > This is giving me constantly gray hairs with TPM patches.
> 
> Well, I'm slowly getting tired of repeating the same crap over and over
> again about how important it is to document one's changes and to write
> good commit messages. The most repeated answers I'm simply putting into
> canned reply templates because, well, saying it once or twice is not
> enough anymore. :-\
> 
> And yeah, I see your pain. Same here, actually.
> 
> In the acronym case, I'd probably add a regex to my patch massaging
> script and convert those typos automatically and be done with it.

Wonder if checkpatch.pl could be extended to know acronyms e.g. have a
db of known acronyms.

/Jarkko
