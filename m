Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC8B120FC79
	for <lists+linux-efi@lfdr.de>; Tue, 30 Jun 2020 21:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbgF3TKY (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 30 Jun 2020 15:10:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:57008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726347AbgF3TKY (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 30 Jun 2020 15:10:24 -0400
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 82CF4206A1;
        Tue, 30 Jun 2020 19:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593544223;
        bh=bvlrBIfobkJqYUwxFksgp5a8Mp33hFTvnGQJoruLeuY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ydWGPy5P0M/MOtzOb7cUumHcgEcBKEz3HcrctoB7EZjLFRYWjETnvQegJG24Fg8zO
         xdATpa8ivXsc6/01zIHIA/AoOIV2O+3HuDASjsb0d3HqK5nNymjAeV/55d0zIGRmBR
         vKzo0Veies9WvUU+irZ5vR96h9P95/xMpmqmR+oQ=
Received: by mail-ot1-f52.google.com with SMTP id t18so6510720otq.5;
        Tue, 30 Jun 2020 12:10:23 -0700 (PDT)
X-Gm-Message-State: AOAM530xR4yAenqF71g56/6apwLmanOn1fvEmNcQQsOvPM+50Cx0My/k
        KlxUIXiA5sxaAwv3kDgkbwzt52xQwEuYzFbkTI8=
X-Google-Smtp-Source: ABdhPJxyBSIMgPHRikk+QNpo1LzL2zQLLth65d1YiWHuRfZ5Bbyrei2mNQsDdeewN/53+vnvUBS3wNYrt0lG66uBKBo=
X-Received: by 2002:a9d:4a8f:: with SMTP id i15mr20375352otf.77.1593544222958;
 Tue, 30 Jun 2020 12:10:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200615232504.1848159-1-tyhicks@linux.microsoft.com>
 <CAMj1kXHJbsxA2-jqpbLnUeeNfM0oC8Sh70+axOKoBCFMJ8+jKQ@mail.gmail.com> <20200630185327.pasrylg7og7rlno3@redhat.com>
In-Reply-To: <20200630185327.pasrylg7og7rlno3@redhat.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 30 Jun 2020 21:10:11 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFtC+2VQxg8nqZL3+88nC5CT+smhibB8KgvMMTOhgtU3A@mail.gmail.com>
Message-ID: <CAMj1kXFtC+2VQxg8nqZL3+88nC5CT+smhibB8KgvMMTOhgtU3A@mail.gmail.com>
Subject: Re: [PATCH] tpm: Require that all digests are present in
 TCG_PCR_EVENT2 structures
To:     Peter Jones <pjones@redhat.com>
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 30 Jun 2020 at 20:53, Peter Jones <pjones@redhat.com> wrote:
>
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
> Same with the zero-supported-hashes case.  It would be nice to at log it
> and have a way for them to opt-in to allowing the old measurement to go
> through, so they can recover their data, though I don't know what that
> method would be if the measured command line is one of their
> dependencies.
>

Maybe use a EFI variable?
