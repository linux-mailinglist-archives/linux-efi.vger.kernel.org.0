Return-Path: <linux-efi+bounces-6140-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iIqUJiCgj2kuSAEAu9opvQ
	(envelope-from <linux-efi+bounces-6140-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Fri, 13 Feb 2026 23:05:20 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B051139B68
	for <lists+linux-efi@lfdr.de>; Fri, 13 Feb 2026 23:05:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B5A10303A5FE
	for <lists+linux-efi@lfdr.de>; Fri, 13 Feb 2026 22:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBAD2303A30;
	Fri, 13 Feb 2026 22:05:10 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408293033E8
	for <linux-efi@vger.kernel.org>; Fri, 13 Feb 2026 22:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771020310; cv=none; b=UUmMdB/NlKQ/uZmSaSXnBXWEv/xw5qFwPnuuadRSSJh8wfPqE5DVQ9TM04HA4orw5y/iAfuBxxPWqf2LtGHRc3jH3drzD1u3ZtIl5VlbeekRhmiorOtRPsZDRjzF6ZBlLYV9XAjuGeeid1nydfgG6WYk+eqO9W3ose9PPuHY5k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771020310; c=relaxed/simple;
	bh=zc/aQYdOQ2ObL6nZaabi7fRw9wvMyrEqxOJki5ycx0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q2xrswtoBwqsS7n2y/6j9yagblyl5JS3GhAyNuIFEVLQtnSndJWX3BxBF9bXV+B2dN9lqTZKlHKh5721XoyfRVmFhiXEQlGUMg6EwZPgz0N5wWbk6sVSnkquH3p+592hN33Sg+YAglgfw9J6JYSCEGLq1url0CVWmxX4F7ywgS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1vr1HO-0005gD-9k; Fri, 13 Feb 2026 23:04:50 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1vr1HL-000e8h-0S;
	Fri, 13 Feb 2026 23:04:48 +0100
Received: from mfe by pty.whiteo.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <mfe@pengutronix.de>)
	id 1vr1HM-000000008cL-1XIN;
	Fri, 13 Feb 2026 23:04:48 +0100
Date: Fri, 13 Feb 2026 23:04:48 +0100
From: Marco Felsch <m.felsch@pengutronix.de>
To: Sumit Garg <sumit.garg@kernel.org>
Cc: Jens Wiklander <jens.wiklander@linaro.org>, 
	Matthew Wilcox <willy@infradead.org>, vbabka@suse.cz, akpm@linux-foundation.org, kernel@pengutronix.de, 
	op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, mcoquelin.stm32@gmail.com, 
	alexandre.torgue@foss.st.com, ilias.apalodimas@linaro.org, jan.kiszka@siemens.com, 
	masahisa.kojima@linaro.org, spu@pengutronix.de
Subject: Re: [PATCH v2] tee: shm: fix slab page refcounting
Message-ID: <252s4lfnujhrl3bkqm3xwatdkcdd3tfge3e6fla6f2llq4szjm@xltjvpqjgffn>
References: <20250325200740.3645331-1-m.felsch@pengutronix.de>
 <Z-Pc6C1YUqLyej3Z@casper.infradead.org>
 <20250326110718.qzbwpmaf6xlcb4xf@pengutronix.de>
 <CAHUa44FUK_73oKSaqGdiPqB3geZbTNDFsC1Mh=KN3YPWr9=7gQ@mail.gmail.com>
 <Z-TXMIXzaro0w60M@sumit-X1>
 <CAHUa44HEsMkzQHZZufdwutQyZRtig6e0qWomhwgDZAhy2qDyhg@mail.gmail.com>
 <20260212125830.jfwos3flga2l5uwk@pengutronix.de>
 <aY8N90jMp25bBZhi@sumit-xelite>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aY8N90jMp25bBZhi@sumit-xelite>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-efi@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6140-lists,linux-efi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[pengutronix.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[linaro.org,infradead.org,suse.cz,linux-foundation.org,pengutronix.de,lists.trustedfirmware.org,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org,gmail.com,foss.st.com,siemens.com];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[m.felsch@pengutronix.de,linux-efi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-efi];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3B051139B68
X-Rspamd-Action: no action

Hi Sumit,

On 26-02-13, Sumit Garg wrote:
> Hi Marco,
> 
> On Thu, Feb 12, 2026 at 01:58:30PM +0100, Marco Felsch wrote:
> > Hi Sumit,
> > 
> > TBH: I was hoping that you will take care of this since you're marked as
> > maintainer for the tee-trusted-key and we noticed the warning with 6.14
> > and still no fix available :/
> 
> Mathew did suggested a fix long back on which everybody agreed but

You agreed. I said that the current TEE API also allows non-slabed based
backed memory and therefore I don't wanted to send this patch approach
and instead asked you to do so since you're the maintainer and fine with
the change.

> didn't got enough attention from you to test and report if that fixed

Why should it get attention from us? Maybe we do have different views of
being a maintainer.

> your issue. Since you insisted further, I have created a formal fix

Why is it our issue? It's everyones issue which uses the tee trusted-key
driver.

> patch based on that here [1]. Care to test that?

A colleague of mine is going to test it and will reply on the patch.

> [1] https://lore.kernel.org/all/20260213113317.1728769-1-sumit.garg@kernel.org/

...

> > I checked the code once again and figured that we could drop/replace
> > tee_shm_register_kernel_buf() with tee_shm_alloc_kernel_buf(). I don't
> > see why a kernel driver needs to tee_shm_register_kernel_buf() in the
> > first place, maybe this is legacy. The only users of
> > tee_shm_register_kernel_buf() are trusted_tee.c and tee_stmm_efi.c.
> 
> No it's not legacy but allows for efficient memory reuse within the
> kernel as to not create bounce buffers to share data with TEE.

To be hones, there are only two driver using the API. The tee_stmm_efi
driver can do the alloc during the probe(). The trusted_tee has to use a
bounce buffer, yes but how often do you assume that (un)sealing and rng
ops have to be done during runtime? This shouldn't be a overhead at all.

Therefore my suggestion would be still to drop the internal kernel API
and only use it for userspace pages, where it could really matter.

Regards,
  Marco
-- 
#gernperDu 
#CallMeByMyFirstName

Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | https://www.pengutronix.de/ |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-9    |

