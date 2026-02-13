Return-Path: <linux-efi+bounces-6123-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wDlNCQcOj2kgHgEAu9opvQ
	(envelope-from <linux-efi+bounces-6123-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Fri, 13 Feb 2026 12:41:59 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BE91D135CEE
	for <lists+linux-efi@lfdr.de>; Fri, 13 Feb 2026 12:41:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E939D3008D64
	for <lists+linux-efi@lfdr.de>; Fri, 13 Feb 2026 11:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BA87354ADB;
	Fri, 13 Feb 2026 11:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KQTI1b3u"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186D4241665;
	Fri, 13 Feb 2026 11:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770982915; cv=none; b=BMMFxxv9v46R2l0iXGBl2e/vTiWhhSdZafr3rxDDvCyOKmX/38d5QBS/IchUe7MQ6+UyTY35VcpGLbGxTPe4pnz+khIOWohXsZ3c6br5HuND1d6BUmts7iAJXYv4Z4aR0rl2xQNjn0g8pSMH3nQkZb8Ve7hJiIihk8uhAg3zki8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770982915; c=relaxed/simple;
	bh=//FUPQtiHgkA6+8ggCTux5TUR6pLkT0fZp0gFDq5xRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B0Tk0xgImEEtoFfwjRGeNYERpM8ZDuW4RPKQgn6GYH0GQG7at0O+tXiQLZhPj14d/PoouSlcEeIMePjWk3i+UDVMASDtqm7I1j021vLSt/dzzXyuGr+0O5va1xRQSHw8V3Ac1ouw55I9F2mraAuNPd/mNzjigL8sWAAtvQfMST4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KQTI1b3u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE6D6C116C6;
	Fri, 13 Feb 2026 11:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770982914;
	bh=//FUPQtiHgkA6+8ggCTux5TUR6pLkT0fZp0gFDq5xRk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KQTI1b3u0Q4pyuXy0AQhK+daoEjRVYcgNTOfFMrdfdZ/HhxV617xG2c28/P8pq1D9
	 iD6Nks4akO4w62sa5jNdbS1F3SbFTTRPizMUdXq1cLYFHPAp4bKBlvjlTaRgILYdoP
	 yr2bOqqRtlh5pbgCIlnuOlrak4uvTjq6VUbgw+bWGAJs7gDbZSS9Oz80rWkzus5pmr
	 LQ9t52v1iig1a0ANoVlL58TPaRATwVW6B4fAuR0VCVM7Pqsk8YrSNBf9BzttKJ4j+v
	 UDPatfhhstyabt8VHBDQo07Uu8TWw2eXjm5ROfA4Slm+pmClEI6C7f5EzgQt3ZOw6D
	 zYN4e8eHOIZ7w==
Date: Fri, 13 Feb 2026 17:11:43 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: Jens Wiklander <jens.wiklander@linaro.org>,
	Matthew Wilcox <willy@infradead.org>, vbabka@suse.cz,
	akpm@linux-foundation.org, kernel@pengutronix.de,
	op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
	linux-efi@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, ilias.apalodimas@linaro.org,
	jan.kiszka@siemens.com, masahisa.kojima@linaro.org
Subject: Re: [PATCH v2] tee: shm: fix slab page refcounting
Message-ID: <aY8N90jMp25bBZhi@sumit-xelite>
References: <20250325200740.3645331-1-m.felsch@pengutronix.de>
 <Z-Pc6C1YUqLyej3Z@casper.infradead.org>
 <20250326110718.qzbwpmaf6xlcb4xf@pengutronix.de>
 <CAHUa44FUK_73oKSaqGdiPqB3geZbTNDFsC1Mh=KN3YPWr9=7gQ@mail.gmail.com>
 <Z-TXMIXzaro0w60M@sumit-X1>
 <CAHUa44HEsMkzQHZZufdwutQyZRtig6e0qWomhwgDZAhy2qDyhg@mail.gmail.com>
 <20260212125830.jfwos3flga2l5uwk@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260212125830.jfwos3flga2l5uwk@pengutronix.de>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6123-lists,linux-efi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linaro.org,infradead.org,suse.cz,linux-foundation.org,pengutronix.de,lists.trustedfirmware.org,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org,gmail.com,foss.st.com,siemens.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sumit.garg@kernel.org,linux-efi@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-efi];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: BE91D135CEE
X-Rspamd-Action: no action

Hi Marco,

On Thu, Feb 12, 2026 at 01:58:30PM +0100, Marco Felsch wrote:
> Hi Sumit,
> 
> TBH: I was hoping that you will take care of this since you're marked as
> maintainer for the tee-trusted-key and we noticed the warning with 6.14
> and still no fix available :/

Mathew did suggested a fix long back on which everybody agreed but
didn't got enough attention from you to test and report if that fixed
your issue. Since you insisted further, I have created a formal fix
patch based on that here [1]. Care to test that?

[1] https://lore.kernel.org/all/20260213113317.1728769-1-sumit.garg@kernel.org/

> 
> However please see below for further discussion.
> 
> On 25-04-28, Jens Wiklander wrote:
> > On Thu, Mar 27, 2025 at 5:42 AM Sumit Garg <sumit.garg@kernel.org> wrote:
> > >
> > > On Wed, Mar 26, 2025 at 02:47:46PM +0100, Jens Wiklander wrote:
> > > > On Wed, Mar 26, 2025 at 12:07 PM Marco Felsch <m.felsch@pengutronix.de> wrote:
> > > > >
> > > > > On 25-03-26, Matthew Wilcox wrote:
> > > > > > On Tue, Mar 25, 2025 at 09:07:39PM +0100, Marco Felsch wrote:
> > > > > > > Skip manipulating the refcount in case of slab pages according commit
> > > > > > > b9c0e49abfca ("mm: decline to manipulate the refcount on a slab page").
> > > > > >
> > > > > > This almost certainly isn't right.  I know nothing about TEE, but that
> > > > > > you are doing this indicates a problem.  The hack that we put into
> > > > > > networking should not be blindly replicated.
> > > > > >
> > > > > > Why are you taking a reference on the pages to begin with?  Is it copy
> > > > > > and pasted from somewhere else, or was there actual thought put into it?
> > > > >
> > > > > Not sure, this belongs to the TEE maintainers.
> > > >
> > > > I don't know. We were getting the user pages first, so I assume we
> > > > just did the same thing when we added support for kernel pages.
> > > >
> > > > >
> > > > > > If it's "prevent the caller from freeing the allocation", well, it never
> > > > > > accomplished that with slab allocations.  So for callers that do kmalloc
> > > > > > (eg setup_mm_hdr()  in drivers/firmware/efi/stmm/tee_stmm_efi.c), you
> > > > > > have to rely on them not freeing the allocation while the TEE driver
> > > > > > has it.
> > >
> > > It's not just about the TEE driver but rather if the TEE implementation
> > > (a trusted OS) to whom the page is registered with. We don't want the
> > > trusted OS to work on registered kernel pages if they gets free somehow
> > > in the TEE client driver. Having a reference in the TEE subsystem
> > > assured us that won't happen. But if you say slab allocations are still
> > > prone the kernel pages getting freed even after refcount then can you
> > > suggest how should we handle this better?
> > >
> > > As otherwise it can cause very hard to debug problems if trusted OS can
> > > manipulate kernel pages that are no longer available.
> > 
> > We must be able to rely on the kernel callers to have the needed
> > references before calling tee_shm_register_kernel_buf() and to keep
> > those until after calling tee_shm_free().
> 
> I checked the code once again and figured that we could drop/replace
> tee_shm_register_kernel_buf() with tee_shm_alloc_kernel_buf(). I don't
> see why a kernel driver needs to tee_shm_register_kernel_buf() in the
> first place, maybe this is legacy. The only users of
> tee_shm_register_kernel_buf() are trusted_tee.c and tee_stmm_efi.c.

No it's not legacy but allows for efficient memory reuse within the
kernel as to not create bounce buffers to share data with TEE.

-Sumit

> 
> +Cc the efi-stmm folks since they will be affected by this change as
> well.
> 
> Regards,
>   Marco
> 
> 
> > > > > > And if that's your API contract, then there's no point in taking
> > > > > > refcounts on other kinds of pages either; it's just unnecessary atomic
> > > > > > instructions.  So the right patch might be something like this:
> > > > > >
> > > > > > +++ b/drivers/tee/tee_shm.c
> > > > > > @@ -15,29 +15,11 @@
> > > > > >  #include <linux/highmem.h>
> > > > > >  #include "tee_private.h"
> > > > >
> > > > > I had the same diff but didn't went this way since we can't be sure that
> > > > > iov's are always slab backed. As far as I understood IOVs. In
> > > > > 'worst-case' scenario an iov can be backed by different page types too.
> > > >
> > > > We're only using kvec's. Briefly, before commit 7bdee4157591 ("tee:
> > > > Use iov_iter to better support shared buffer registration") we checked
> > > > with is_vmalloc_addr() || is_kmap_addr(). I like Matthew's suggestion,
> > > > it's nice to fix problems by deleting code. :-)
> > > >
> > > > Sumit, you know the callers better. What do you think?
> > >
> > > If we don't have a sane way to refcont registered kernel pages in TEE
> > > subsystem then yeah we have to solely rely on the client drivers to
> > > behave properly. Nevertheless, it's still within the kernel boundaries
> > > which we can rely upon.
> > 
> > Yes.
> > 
> > Cheers,
> > Jens
> 
> -- 
> #gernperDu 
> #CallMeByMyFirstName
> 
> Pengutronix e.K.                           |                             |
> Steuerwalder Str. 21                       | https://www.pengutronix.de/ |
> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-9    |

