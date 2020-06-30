Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC39720FBC3
	for <lists+linux-efi@lfdr.de>; Tue, 30 Jun 2020 20:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390812AbgF3SdZ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 30 Jun 2020 14:33:25 -0400
Received: from linux.microsoft.com ([13.77.154.182]:51038 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729676AbgF3SdZ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 30 Jun 2020 14:33:25 -0400
Received: from sequoia (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id 6AC6720B717A;
        Tue, 30 Jun 2020 11:33:23 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6AC6720B717A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1593542004;
        bh=P8hrpLXW1bm+I0RtahNav7d3UiFywHUi9+V3kW2yqYE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XCR6/KNiEgjEaGmIFHHaIalSw46WRASLd42p0kaCSzM2PloibciuQ6Ca7BpcNHaEF
         fiBOSjY9l3V2bp4c4mkWCoe/3MO1u/4l6cUOT2mGAH9qXByYLlrOrSa8yTvMe6Guto
         RPw934ZtLlanwfAFvAT0OXWavNN3sLhY4Guwmfe0=
Date:   Tue, 30 Jun 2020 13:33:21 -0500
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
Message-ID: <20200630183321.GE4694@sequoia>
References: <20200615232504.1848159-1-tyhicks@linux.microsoft.com>
 <CAMj1kXHJbsxA2-jqpbLnUeeNfM0oC8Sh70+axOKoBCFMJ8+jKQ@mail.gmail.com>
 <20200617230958.GC62794@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200617230958.GC62794@linux.intel.com>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 2020-06-18 02:09:58, Jarkko Sakkinen wrote:
> On Tue, Jun 16, 2020 at 11:08:38AM +0200, Ard Biesheuvel wrote:
> > (cc Matthew and Peter)
> > 
> > On Tue, 16 Jun 2020 at 01:28, Tyler Hicks <tyhicks@linux.microsoft.com> wrote:
> > >
> > > Require that the TCG_PCR_EVENT2.digests.count value strictly matches the
> > > value of TCG_EfiSpecIdEvent.numberOfAlgorithms in the event field of the
> > > TCG_PCClientPCREvent event log header. Also require that
> > > TCG_EfiSpecIdEvent.numberOfAlgorithms is non-zero.
> > >
> > > The TCG PC Client Platform Firmware Profile Specification section 9.1
> > > (Family "2.0", Level 00 Revision 1.04) states:
> > >
> > >  For each Hash algorithm enumerated in the TCG_PCClientPCREvent entry,
> > >  there SHALL be a corresponding digest in all TCG_PCR_EVENT2 structures.
> > >  Note: This includes EV_NO_ACTION events which do not extend the PCR.
> > >
> > > Section 9.4.5.1 provides this description of
> > > TCG_EfiSpecIdEvent.numberOfAlgorithms:
> > >
> > >  The number of Hash algorithms in the digestSizes field. This field MUST
> > >  be set to a value of 0x01 or greater.
> > >
> > > Enforce these restrictions, as required by the above specification, in
> > > order to better identify and ignore invalid sequences of bytes at the
> > > end of an otherwise valid TPM2 event log. Firmware doesn't always have
> > > the means necessary to inform the kernel of the actual event log size so
> > > the kernel's event log parsing code should be stringent when parsing the
> > > event log for resiliency against firmware bugs. This is true, for
> > > example, when firmware passes the event log to the kernel via a reserved
> > > memory region described in device tree.
> > >
> > 
> > When does this happen? Do we have code in mainline that does this?
> > 
> > > Prior to this patch, a single bit set in the offset corresponding to
> > > either the TCG_PCR_EVENT2.eventType or TCG_PCR_EVENT2.eventSize fields,
> > > after the last valid event log entry, could confuse the parser into
> > > thinking that an additional entry is present in the event log. This
> > > patch raises the bar on how difficult it is for stale memory to confuse
> > > the kernel's event log parser but there's still a reliance on firmware
> > > to properly initialize the remainder of the memory region reserved for
> > > the event log as the parser cannot be expected to detect a stale but
> > > otherwise properly formatted firmware event log entry.
> > >
> > > Fixes: fd5c78694f3f ("tpm: fix handling of the TPM 2.0 event logs")
> > > Signed-off-by: Tyler Hicks <tyhicks@linux.microsoft.com>
> > > ---
> > 
> > I am all for stringent checks, but this could potentially break
> > measured boot on systems that are working fine today, right?
> 
> There would not be any sane reason to implement a TPM chip like that.

Jarkko, is this an ack from you?

Is there anything I can do to help along this fix?

I've spoke with two others that have poured through these specs to
implement firmware event log parsers and they thought the change made
sense.

Tyler

> 
> /Jarkko
