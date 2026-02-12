Return-Path: <linux-efi+bounces-6111-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mD5wCZzOjWn87AAAu9opvQ
	(envelope-from <linux-efi+bounces-6111-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Thu, 12 Feb 2026 13:59:08 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4292B12DB07
	for <lists+linux-efi@lfdr.de>; Thu, 12 Feb 2026 13:59:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 23885300DD60
	for <lists+linux-efi@lfdr.de>; Thu, 12 Feb 2026 12:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4FE635BDB9;
	Thu, 12 Feb 2026 12:58:57 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45DF312831
	for <linux-efi@vger.kernel.org>; Thu, 12 Feb 2026 12:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770901137; cv=none; b=k6OJYEFJtbEnULnWowujezONTidfUuHbGIBOZ6rbAoN1tez73A7hmFFR2fcEF/Yi9Yr3/h4fVEMtZFMA5Fg/Zt03FBMQ/9Abv94WPRFEUzHvpJstPSF8Dl3dUl9ygzOdQEa3tdijb1oaUcicqIw/nBzso764w96mbI5SGA9FEg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770901137; c=relaxed/simple;
	bh=v6Jj5I50F0vSTTue7XCemvNJLicCeB6gpgHzAExqFNc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sq7U5hxMag2wAc1zMIwXaVawmKQBe8T/E/ZB3S6/bVpE3exjxIkyd1de4u2IWGqU0Neeim7/BEi1iX8MlFHmgB9WeS1IHHkM006+UEFfa7+DDM0t75F3/O0da2VQdmjgbAKwYJ/2g3EYqTE9uJegbgqjZBkIgPe5gBBuQonAR6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1vqWHB-0008LE-0f; Thu, 12 Feb 2026 13:58:33 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1vqWH7-000PUE-2A;
	Thu, 12 Feb 2026 13:58:31 +0100
Received: from mfe by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1vqWH8-00DseC-2p;
	Thu, 12 Feb 2026 13:58:30 +0100
Date: Thu, 12 Feb 2026 13:58:30 +0100
From: Marco Felsch <m.felsch@pengutronix.de>
To: Jens Wiklander <jens.wiklander@linaro.org>
Cc: Sumit Garg <sumit.garg@kernel.org>,
	Matthew Wilcox <willy@infradead.org>, vbabka@suse.cz,
	akpm@linux-foundation.org, kernel@pengutronix.de,
	op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
	linux-efi@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, ilias.apalodimas@linaro.org,
	jan.kiszka@siemens.com, masahisa.kojima@linaro.org
Subject: Re: [PATCH v2] tee: shm: fix slab page refcounting
Message-ID: <20260212125830.jfwos3flga2l5uwk@pengutronix.de>
References: <20250325200740.3645331-1-m.felsch@pengutronix.de>
 <Z-Pc6C1YUqLyej3Z@casper.infradead.org>
 <20250326110718.qzbwpmaf6xlcb4xf@pengutronix.de>
 <CAHUa44FUK_73oKSaqGdiPqB3geZbTNDFsC1Mh=KN3YPWr9=7gQ@mail.gmail.com>
 <Z-TXMIXzaro0w60M@sumit-X1>
 <CAHUa44HEsMkzQHZZufdwutQyZRtig6e0qWomhwgDZAhy2qDyhg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHUa44HEsMkzQHZZufdwutQyZRtig6e0qWomhwgDZAhy2qDyhg@mail.gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-efi@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-6111-lists,linux-efi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[pengutronix.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,infradead.org,suse.cz,linux-foundation.org,pengutronix.de,lists.trustedfirmware.org,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org,gmail.com,foss.st.com,linaro.org,siemens.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[m.felsch@pengutronix.de,linux-efi@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-efi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4292B12DB07
X-Rspamd-Action: no action

Hi Sumit,

TBH: I was hoping that you will take care of this since you're marked as
maintainer for the tee-trusted-key and we noticed the warning with 6.14
and still no fix available :/

However please see below for further discussion.

On 25-04-28, Jens Wiklander wrote:
> On Thu, Mar 27, 2025 at 5:42 AM Sumit Garg <sumit.garg@kernel.org> wrote:
> >
> > On Wed, Mar 26, 2025 at 02:47:46PM +0100, Jens Wiklander wrote:
> > > On Wed, Mar 26, 2025 at 12:07 PM Marco Felsch <m.felsch@pengutronix.de> wrote:
> > > >
> > > > On 25-03-26, Matthew Wilcox wrote:
> > > > > On Tue, Mar 25, 2025 at 09:07:39PM +0100, Marco Felsch wrote:
> > > > > > Skip manipulating the refcount in case of slab pages according commit
> > > > > > b9c0e49abfca ("mm: decline to manipulate the refcount on a slab page").
> > > > >
> > > > > This almost certainly isn't right.  I know nothing about TEE, but that
> > > > > you are doing this indicates a problem.  The hack that we put into
> > > > > networking should not be blindly replicated.
> > > > >
> > > > > Why are you taking a reference on the pages to begin with?  Is it copy
> > > > > and pasted from somewhere else, or was there actual thought put into it?
> > > >
> > > > Not sure, this belongs to the TEE maintainers.
> > >
> > > I don't know. We were getting the user pages first, so I assume we
> > > just did the same thing when we added support for kernel pages.
> > >
> > > >
> > > > > If it's "prevent the caller from freeing the allocation", well, it never
> > > > > accomplished that with slab allocations.  So for callers that do kmalloc
> > > > > (eg setup_mm_hdr()  in drivers/firmware/efi/stmm/tee_stmm_efi.c), you
> > > > > have to rely on them not freeing the allocation while the TEE driver
> > > > > has it.
> >
> > It's not just about the TEE driver but rather if the TEE implementation
> > (a trusted OS) to whom the page is registered with. We don't want the
> > trusted OS to work on registered kernel pages if they gets free somehow
> > in the TEE client driver. Having a reference in the TEE subsystem
> > assured us that won't happen. But if you say slab allocations are still
> > prone the kernel pages getting freed even after refcount then can you
> > suggest how should we handle this better?
> >
> > As otherwise it can cause very hard to debug problems if trusted OS can
> > manipulate kernel pages that are no longer available.
> 
> We must be able to rely on the kernel callers to have the needed
> references before calling tee_shm_register_kernel_buf() and to keep
> those until after calling tee_shm_free().

I checked the code once again and figured that we could drop/replace
tee_shm_register_kernel_buf() with tee_shm_alloc_kernel_buf(). I don't
see why a kernel driver needs to tee_shm_register_kernel_buf() in the
first place, maybe this is legacy. The only users of
tee_shm_register_kernel_buf() are trusted_tee.c and tee_stmm_efi.c.

+Cc the efi-stmm folks since they will be affected by this change as
well.

Regards,
  Marco


> > > > > And if that's your API contract, then there's no point in taking
> > > > > refcounts on other kinds of pages either; it's just unnecessary atomic
> > > > > instructions.  So the right patch might be something like this:
> > > > >
> > > > > +++ b/drivers/tee/tee_shm.c
> > > > > @@ -15,29 +15,11 @@
> > > > >  #include <linux/highmem.h>
> > > > >  #include "tee_private.h"
> > > >
> > > > I had the same diff but didn't went this way since we can't be sure that
> > > > iov's are always slab backed. As far as I understood IOVs. In
> > > > 'worst-case' scenario an iov can be backed by different page types too.
> > >
> > > We're only using kvec's. Briefly, before commit 7bdee4157591 ("tee:
> > > Use iov_iter to better support shared buffer registration") we checked
> > > with is_vmalloc_addr() || is_kmap_addr(). I like Matthew's suggestion,
> > > it's nice to fix problems by deleting code. :-)
> > >
> > > Sumit, you know the callers better. What do you think?
> >
> > If we don't have a sane way to refcont registered kernel pages in TEE
> > subsystem then yeah we have to solely rely on the client drivers to
> > behave properly. Nevertheless, it's still within the kernel boundaries
> > which we can rely upon.
> 
> Yes.
> 
> Cheers,
> Jens

-- 
#gernperDu 
#CallMeByMyFirstName

Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | https://www.pengutronix.de/ |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-9    |

