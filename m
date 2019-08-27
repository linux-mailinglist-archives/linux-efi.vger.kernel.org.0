Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38E4A9F5D6
	for <lists+linux-efi@lfdr.de>; Wed, 28 Aug 2019 00:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725992AbfH0WMG (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 27 Aug 2019 18:12:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39630 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725989AbfH0WMG (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 27 Aug 2019 18:12:06 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0CAD685360;
        Tue, 27 Aug 2019 22:12:06 +0000 (UTC)
Received: from redhat.com (dhcp-10-20-1-91.bss.redhat.com [10.20.1.91])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 86DF760CD0;
        Tue, 27 Aug 2019 22:12:00 +0000 (UTC)
Date:   Tue, 27 Aug 2019 18:11:58 -0400
From:   Peter Jones <pjones@redhat.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Matthew Garrett <mjg59@google.com>, ard.biesheuvel@linaro.org,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Bartosz Szczepanek <bsz@semihalf.com>,
        Lyude Paul <lyude@redhat.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] efi+tpm: Don't access event->count when it isn't
 mapped.
Message-ID: <20190827221157.mngkglcgj4azux7b@redhat.com>
References: <20190826153028.32639-1-pjones@redhat.com>
 <20190826162823.4mxkwhd7mbtro3zy@linux.intel.com>
 <CACdnJuuB_ExhOOtA8Uh7WO42TSNfRHuGaK4Xo=5SbdfWDKr7wA@mail.gmail.com>
 <20190827110344.4uvjppmkkaeex3mk@linux.intel.com>
 <20190827134155.otm6ekeb53siy6lb@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190827134155.otm6ekeb53siy6lb@linux.intel.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Tue, 27 Aug 2019 22:12:06 +0000 (UTC)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Aug 27, 2019 at 04:41:55PM +0300, Jarkko Sakkinen wrote:
> On Tue, Aug 27, 2019 at 02:03:44PM +0300, Jarkko Sakkinen wrote:
> > > Jarkko, these two should probably go to 5.3 if possible - I
> > > independently had a report of a system hitting this issue last week
> > > (Intel apparently put a surprising amount of data in the event logs on
> > > the NUCs).
> > 
> > OK, I can try to push them. I'll do PR today.
> 
> Ard, how do you wish these to be managed?
> 
> I'm asking this because:
> 
> 1. Neither patch was CC'd to linux-integrity.
> 2. Neither patch has your tags ATM.

I think Ard's not back until September.  I can just to re-send them with
the accumulated tags and Cc linux-integrity, if you think that would
help?

-- 
  Peter
