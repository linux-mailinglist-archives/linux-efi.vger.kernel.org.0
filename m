Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E4191FD959
	for <lists+linux-efi@lfdr.de>; Thu, 18 Jun 2020 01:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbgFQXKH (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 17 Jun 2020 19:10:07 -0400
Received: from mga02.intel.com ([134.134.136.20]:18187 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726761AbgFQXKG (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 17 Jun 2020 19:10:06 -0400
IronPort-SDR: BOApvUG5IKHXyrRMBb+iw+O9cAOTcYnrDPkbBdXW+9lpNXNCTdKR7s6L50ZqA6SfLkVG3ER3fN
 QXNjm2WZaHzQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2020 16:10:05 -0700
IronPort-SDR: Xh1ebDmI2ePs5KOp7NfFQgx3PcIZQSKlrBspT7+i6hmvSQnE4h2j8LGD17Foz1au+O+snVSTRH
 /DhIkrek56Xw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,523,1583222400"; 
   d="scan'208";a="309638656"
Received: from kleeve-mobl.ger.corp.intel.com (HELO localhost) ([10.252.50.166])
  by fmsmga002.fm.intel.com with ESMTP; 17 Jun 2020 16:09:59 -0700
Date:   Thu, 18 Jun 2020 02:09:58 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Tyler Hicks <tyhicks@linux.microsoft.com>,
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
Message-ID: <20200617230958.GC62794@linux.intel.com>
References: <20200615232504.1848159-1-tyhicks@linux.microsoft.com>
 <CAMj1kXHJbsxA2-jqpbLnUeeNfM0oC8Sh70+axOKoBCFMJ8+jKQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXHJbsxA2-jqpbLnUeeNfM0oC8Sh70+axOKoBCFMJ8+jKQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Jun 16, 2020 at 11:08:38AM +0200, Ard Biesheuvel wrote:
> (cc Matthew and Peter)
> 
> On Tue, 16 Jun 2020 at 01:28, Tyler Hicks <tyhicks@linux.microsoft.com> wrote:
> >
> > Require that the TCG_PCR_EVENT2.digests.count value strictly matches the
> > value of TCG_EfiSpecIdEvent.numberOfAlgorithms in the event field of the
> > TCG_PCClientPCREvent event log header. Also require that
> > TCG_EfiSpecIdEvent.numberOfAlgorithms is non-zero.
> >
> > The TCG PC Client Platform Firmware Profile Specification section 9.1
> > (Family "2.0", Level 00 Revision 1.04) states:
> >
> >  For each Hash algorithm enumerated in the TCG_PCClientPCREvent entry,
> >  there SHALL be a corresponding digest in all TCG_PCR_EVENT2 structures.
> >  Note: This includes EV_NO_ACTION events which do not extend the PCR.
> >
> > Section 9.4.5.1 provides this description of
> > TCG_EfiSpecIdEvent.numberOfAlgorithms:
> >
> >  The number of Hash algorithms in the digestSizes field. This field MUST
> >  be set to a value of 0x01 or greater.
> >
> > Enforce these restrictions, as required by the above specification, in
> > order to better identify and ignore invalid sequences of bytes at the
> > end of an otherwise valid TPM2 event log. Firmware doesn't always have
> > the means necessary to inform the kernel of the actual event log size so
> > the kernel's event log parsing code should be stringent when parsing the
> > event log for resiliency against firmware bugs. This is true, for
> > example, when firmware passes the event log to the kernel via a reserved
> > memory region described in device tree.
> >
> 
> When does this happen? Do we have code in mainline that does this?
> 
> > Prior to this patch, a single bit set in the offset corresponding to
> > either the TCG_PCR_EVENT2.eventType or TCG_PCR_EVENT2.eventSize fields,
> > after the last valid event log entry, could confuse the parser into
> > thinking that an additional entry is present in the event log. This
> > patch raises the bar on how difficult it is for stale memory to confuse
> > the kernel's event log parser but there's still a reliance on firmware
> > to properly initialize the remainder of the memory region reserved for
> > the event log as the parser cannot be expected to detect a stale but
> > otherwise properly formatted firmware event log entry.
> >
> > Fixes: fd5c78694f3f ("tpm: fix handling of the TPM 2.0 event logs")
> > Signed-off-by: Tyler Hicks <tyhicks@linux.microsoft.com>
> > ---
> 
> I am all for stringent checks, but this could potentially break
> measured boot on systems that are working fine today, right?

There would not be any sane reason to implement a TPM chip like that.

/Jarkko
