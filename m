Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F26020FD02
	for <lists+linux-efi@lfdr.de>; Tue, 30 Jun 2020 21:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728679AbgF3TtV (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 30 Jun 2020 15:49:21 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30939 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728593AbgF3TtG (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 30 Jun 2020 15:49:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593546544;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ta3QiFyXugeuA+urmixcQfRxGdpjyq1pxJZ1EMys5Xg=;
        b=I9NIsDVYQD2/z5f+jx2unqCvgpb32W658UHX7LUle6gFteoafKoKoi9720wuW1mXM3tma0
        IcO/V3xgtwI+9xb1EdRW+Vrj/FsPVEjfc6GTYEB71XLf7HmnN0I5y+CvFiy8v/n7gf5I6T
        Nr0PWpweA7Zvv1lPrJ+OAGiwhdPYJK0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-72-3ZEdmMQOM5yrPXoOwZ7Sxg-1; Tue, 30 Jun 2020 15:49:02 -0400
X-MC-Unique: 3ZEdmMQOM5yrPXoOwZ7Sxg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 95981BFC3;
        Tue, 30 Jun 2020 19:49:00 +0000 (UTC)
Received: from redhat.com (ovpn-113-167.phx2.redhat.com [10.3.113.167])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A8D7F7BEDE;
        Tue, 30 Jun 2020 19:48:58 +0000 (UTC)
Date:   Tue, 30 Jun 2020 15:48:56 -0400
From:   Peter Jones <pjones@redhat.com>
To:     Tyler Hicks <tyhicks@linux.microsoft.com>
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
Message-ID: <20200630194855.mfctxgveltvphgnc@redhat.com>
References: <20200615232504.1848159-1-tyhicks@linux.microsoft.com>
 <CAMj1kXHJbsxA2-jqpbLnUeeNfM0oC8Sh70+axOKoBCFMJ8+jKQ@mail.gmail.com>
 <20200630185327.pasrylg7og7rlno3@redhat.com>
 <20200630192322.GF4694@sequoia>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200630192322.GF4694@sequoia>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Jun 30, 2020 at 02:23:22PM -0500, Tyler Hicks wrote:
> > > I am all for stringent checks, but this could potentially break
> > > measured boot on systems that are working fine today, right?
> > 
> > Seems like in that case our measurement is unreliable and can't really
> > be trusted.  That said, having things that were using the measurements
> > before this suddenly stop being able to access sealed secrets is not a
> > great experience for the user who unwittingly bought the junk hardware.
> 
> I haven't seen where anyone has suggested that such junk hardware
> exists. Do you know of or expect any firmware that has mismatched
> TCG_PCR_EVENT2.digests.count and TCG_EfiSpecIdEvent.numberOfAlgorithms
> values?

If nobody has seen any hardware that actually produces the values you're
excluding, then I don't have a strong objection.
 
> I would think that the userspace code that's parsing
> /sys/kernel/security/tpm0/binary_bios_measurements would also have
> issues with such an event log.
> 
> > Same with the zero-supported-hashes case.
> 
> Small but important correction: it is a zero-hashes case, not a
> zero-supported-hashes case
> 
> There's no handshake involved or anything like that. This would only
> cause problems if the firmware provided no hashes, which means the
> firmware event log is unusable, anyways.

Indeed.

-- 
        Peter

