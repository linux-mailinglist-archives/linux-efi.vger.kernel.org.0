Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F07720FCB0
	for <lists+linux-efi@lfdr.de>; Tue, 30 Jun 2020 21:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727846AbgF3TX0 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 30 Jun 2020 15:23:26 -0400
Received: from linux.microsoft.com ([13.77.154.182]:38908 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbgF3TX0 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 30 Jun 2020 15:23:26 -0400
Received: from sequoia (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id 36EC020B717A;
        Tue, 30 Jun 2020 12:23:24 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 36EC020B717A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1593545005;
        bh=/73jWX48iDgfnF6CKgFhER3y8ByMtAjJCLEbLzm/Tko=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s34WJzeT3xk/6f6Z8xCg7w6XoAIkynJE92+HKDEMZdPJZJi8PJ06GLuxZ8Tewp1Rc
         VKZeGQ2OpWEFFDhwSynqTVjWpV8Hbk6+gvrwi61j1lGZj3WGu8le6HHGJFJBBANOAV
         uNhU/U2+T0B7WFKmQSqWbgZDDRJpiEVlnCBedYLg=
Date:   Tue, 30 Jun 2020 14:23:22 -0500
From:   Tyler Hicks <tyhicks@linux.microsoft.com>
To:     Peter Jones <pjones@redhat.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Matthew Garrett <mjg59@google.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
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
Message-ID: <20200630192322.GF4694@sequoia>
References: <20200615232504.1848159-1-tyhicks@linux.microsoft.com>
 <CAMj1kXHJbsxA2-jqpbLnUeeNfM0oC8Sh70+axOKoBCFMJ8+jKQ@mail.gmail.com>
 <20200630185327.pasrylg7og7rlno3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200630185327.pasrylg7og7rlno3@redhat.com>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 2020-06-30 14:53:28, Peter Jones wrote:
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
> Seems like in that case our measurement is unreliable and can't really
> be trusted.  That said, having things that were using the measurements
> before this suddenly stop being able to access sealed secrets is not a
> great experience for the user who unwittingly bought the junk hardware.

I haven't seen where anyone has suggested that such junk hardware
exists. Do you know of or expect any firmware that has mismatched
TCG_PCR_EVENT2.digests.count and TCG_EfiSpecIdEvent.numberOfAlgorithms
values?

I would think that the userspace code that's parsing
/sys/kernel/security/tpm0/binary_bios_measurements would also have
issues with such an event log.

> Same with the zero-supported-hashes case.

Small but important correction: it is a zero-hashes case, not a
zero-supported-hashes case

There's no handshake involved or anything like that. This would only
cause problems if the firmware provided no hashes, which means the
firmware event log is unusable, anyways.

Tyler

> It would be nice to at log it and have a way for them to opt-in to
> allowing the old measurement to go through, so they can recover their
> data, though I don't know what that method would be if the measured
> command line is one of their dependencies.
> 
> -- 
>         Peter
