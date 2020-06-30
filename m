Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 282BF20FC42
	for <lists+linux-efi@lfdr.de>; Tue, 30 Jun 2020 20:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727976AbgF3Sxj (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 30 Jun 2020 14:53:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25791 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725805AbgF3Sxj (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 30 Jun 2020 14:53:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593543217;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EXXh1nLHeYCU/y8Dd7k4qJnwxFGXO5xfFdK00B3SJD4=;
        b=SvDALAHuncSI/uiwy9C73aRIQ8mGT2lE3pmncQDWdPouP+TCFmrqkAedh0irg/2TnRx0mt
        UI5nU84dejEb932qQGGotMGKpQIqBnY68l8M/8NEiqFyr+ds1fmi7GRo5IA514Z9wMAuTr
        zFrv1Qv1S94xEoJ5zYNdQTwnC9dp6kQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-502-R7XLidzmPralqNKpPmIcow-1; Tue, 30 Jun 2020 14:53:33 -0400
X-MC-Unique: R7XLidzmPralqNKpPmIcow-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C91F5800D5C;
        Tue, 30 Jun 2020 18:53:31 +0000 (UTC)
Received: from redhat.com (ovpn-113-167.phx2.redhat.com [10.3.113.167])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6B6695C1C5;
        Tue, 30 Jun 2020 18:53:30 +0000 (UTC)
Date:   Tue, 30 Jun 2020 14:53:28 -0400
From:   Peter Jones <pjones@redhat.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Tyler Hicks <tyhicks@linux.microsoft.com>,
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
Message-ID: <20200630185327.pasrylg7og7rlno3@redhat.com>
References: <20200615232504.1848159-1-tyhicks@linux.microsoft.com>
 <CAMj1kXHJbsxA2-jqpbLnUeeNfM0oC8Sh70+axOKoBCFMJ8+jKQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXHJbsxA2-jqpbLnUeeNfM0oC8Sh70+axOKoBCFMJ8+jKQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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

Seems like in that case our measurement is unreliable and can't really
be trusted.  That said, having things that were using the measurements
before this suddenly stop being able to access sealed secrets is not a
great experience for the user who unwittingly bought the junk hardware.
Same with the zero-supported-hashes case.  It would be nice to at log it
and have a way for them to opt-in to allowing the old measurement to go
through, so they can recover their data, though I don't know what that
method would be if the measured command line is one of their
dependencies.

-- 
        Peter

