Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EEFEE42FC4
	for <lists+linux-efi@lfdr.de>; Wed, 12 Jun 2019 21:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbfFLTPX (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 12 Jun 2019 15:15:23 -0400
Received: from mga05.intel.com ([192.55.52.43]:41275 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727497AbfFLTPX (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 12 Jun 2019 15:15:23 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Jun 2019 12:15:22 -0700
X-ExtLoop1: 1
Received: from suygunge-mobl.ger.corp.intel.com (HELO localhost) ([10.252.48.116])
  by fmsmga004.fm.intel.com with ESMTP; 12 Jun 2019 12:15:21 -0700
Date:   Wed, 12 Jun 2019 22:15:20 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Matthew Garrett <mjg59@google.com>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-efi <linux-efi@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH V2 1/2] Abstract out support for locating an EFI config
 table
Message-ID: <20190612191520.GB3378@linux.intel.com>
References: <20190607205147.102904-1-matthewgarrett@google.com>
 <20190610165819.GA10114@linux.intel.com>
 <CACdnJusZQeKTGDs5c-TG9Yrv1ShN8Twgf6R=TmAdDNjLMnaRNg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACdnJusZQeKTGDs5c-TG9Yrv1ShN8Twgf6R=TmAdDNjLMnaRNg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Jun 10, 2019 at 10:46:35AM -0700, Matthew Garrett wrote:
> On Mon, Jun 10, 2019 at 9:58 AM Jarkko Sakkinen
> <jarkko.sakkinen@linux.intel.com> wrote:
> >
> > On Fri, Jun 07, 2019 at 01:51:46PM -0700, Matthew Garrett wrote:
> > > We want to grab a pointer to the TPM final events table, so abstract out
> > > the existing code for finding an FDT table and make it generic.
> > >
> > > Signed-off-by: Matthew Garrett <mjg59@google.com>
> >
> > Just to clarify are these extensions to what you did before and not
> > something that needs be squashed your commits pipelined for v5.3?
> 
> Correct - they handle a corner case. Ideally they'd hit 5.3 as well,
> but if you'd prefer I'm ok waiting.

Probably makes sense to have them in the PR.

/Jarkko
