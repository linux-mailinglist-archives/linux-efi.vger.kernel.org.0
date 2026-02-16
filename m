Return-Path: <linux-efi+bounces-6144-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id u7lOFgi5kmmEwwEAu9opvQ
	(envelope-from <linux-efi+bounces-6144-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Mon, 16 Feb 2026 07:28:24 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A41721411D8
	for <lists+linux-efi@lfdr.de>; Mon, 16 Feb 2026 07:28:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AE2EF300BDA3
	for <lists+linux-efi@lfdr.de>; Mon, 16 Feb 2026 06:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B4A326ED54;
	Mon, 16 Feb 2026 06:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vvw7taDt"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481D82744F;
	Mon, 16 Feb 2026 06:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771223300; cv=none; b=eQwALwU9i6B4ydlN0cOkdK4+DGxEYXYK+9ijfe0LHX5q4MWwDLi7T6HRq28T4bvJdDyqhxUlXgNkjrkqVGqdjmS15XyexgPkbMJYv1Ec0xTxnahkCGtt+F3ookghRYPbZY6FPuRXYgpqtxT1cjOUKA8J/cIuLVq6yqqIHHfViOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771223300; c=relaxed/simple;
	bh=IB6S87GqJDUeZVCDWsj9FO7zAiiLNHQjIae0NCwbIyg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OWohndtm/hBboFIE7zcVyT6LlADg+ibdgMvsNVj77QDCxSpYghDiC2YksjYd6mE9rVWGn5lBUtvRw/EoghUli8VMSJ+ZpxhBEtIhBit44vjtZjFB8qGggCWe9TxxExbULDTYusCRXqN5QqTrOTbwXSKnzOO0aAUxYXe0K5hjcQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vvw7taDt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91B66C116C6;
	Mon, 16 Feb 2026 06:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771223299;
	bh=IB6S87GqJDUeZVCDWsj9FO7zAiiLNHQjIae0NCwbIyg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Vvw7taDtzIRHRPpyGWyElmvnZLUhQHz605cFYNwB67Xs3cPclrRcoUfPhUV/p1+75
	 2AWNLD7UZLuLiQIUSuQxvIIBN07fbTMo+bamb3iFjWzFTTxVEqJvv0BS72OK+GbcQa
	 MaGe1qIKa8LJ5Xlg3GXUwsHQHvvHz3gLFQ88OoTuAKfooJgVFServunzAKdNHlYzWM
	 gjNSCngjfv6y6QYeB0jRGpsxVo5okoCk1MOqnLIEfZGaJBN6wS60aXFqkMnkI2TKqT
	 /mhX+mzim3N96bnOeNAhpE8lKu7P8W+vWg6Nox4X7UttTiba7Dx09uyiWlZ7yjkhB5
	 Euz23RmJRex/g==
Date: Mon, 16 Feb 2026 11:58:10 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: Jens Wiklander <jens.wiklander@linaro.org>,
	Matthew Wilcox <willy@infradead.org>, vbabka@suse.cz,
	akpm@linux-foundation.org, kernel@pengutronix.de,
	op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
	linux-efi@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, ilias.apalodimas@linaro.org,
	jan.kiszka@siemens.com, masahisa.kojima@linaro.org,
	spu@pengutronix.de
Subject: Re: [PATCH v2] tee: shm: fix slab page refcounting
Message-ID: <aZK4-grGSdOFXHTK@sumit-xelite>
References: <20250325200740.3645331-1-m.felsch@pengutronix.de>
 <Z-Pc6C1YUqLyej3Z@casper.infradead.org>
 <20250326110718.qzbwpmaf6xlcb4xf@pengutronix.de>
 <CAHUa44FUK_73oKSaqGdiPqB3geZbTNDFsC1Mh=KN3YPWr9=7gQ@mail.gmail.com>
 <Z-TXMIXzaro0w60M@sumit-X1>
 <CAHUa44HEsMkzQHZZufdwutQyZRtig6e0qWomhwgDZAhy2qDyhg@mail.gmail.com>
 <20260212125830.jfwos3flga2l5uwk@pengutronix.de>
 <aY8N90jMp25bBZhi@sumit-xelite>
 <252s4lfnujhrl3bkqm3xwatdkcdd3tfge3e6fla6f2llq4szjm@xltjvpqjgffn>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <252s4lfnujhrl3bkqm3xwatdkcdd3tfge3e6fla6f2llq4szjm@xltjvpqjgffn>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6144-lists,linux-efi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[17];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-efi];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sumit.garg@kernel.org,linux-efi@vger.kernel.org];
	FREEMAIL_CC(0.00)[linaro.org,infradead.org,suse.cz,linux-foundation.org,pengutronix.de,lists.trustedfirmware.org,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org,gmail.com,foss.st.com,siemens.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pengutronix.de:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A41721411D8
X-Rspamd-Action: no action

On Fri, Feb 13, 2026 at 11:04:48PM +0100, Marco Felsch wrote:
> Hi Sumit,
> 
> On 26-02-13, Sumit Garg wrote:
> > Hi Marco,
> > 
> > On Thu, Feb 12, 2026 at 01:58:30PM +0100, Marco Felsch wrote:
> > > Hi Sumit,
> > > 
> > > TBH: I was hoping that you will take care of this since you're marked as
> > > maintainer for the tee-trusted-key and we noticed the warning with 6.14
> > > and still no fix available :/
> > 
> > Mathew did suggested a fix long back on which everybody agreed but
> 
> You agreed. I said that the current TEE API also allows non-slabed based
> backed memory and therefore I don't wanted to send this patch approach
> and instead asked you to do so since you're the maintainer and fine with
> the change.
> 
> > didn't got enough attention from you to test and report if that fixed
> 
> Why should it get attention from us? Maybe we do have different views of
> being a maintainer.

It's really the basic expectation I have put here which every reporter
of a bug needs to say if a suggested fix works for them or not.

> 
> > your issue. Since you insisted further, I have created a formal fix
> 
> Why is it our issue? It's everyones issue which uses the tee trusted-key
> driver.
> 
> > patch based on that here [1]. Care to test that?
> 
> A colleague of mine is going to test it and will reply on the patch.
> 
> > [1] https://lore.kernel.org/all/20260213113317.1728769-1-sumit.garg@kernel.org/
> 
> ...
> 
> > > I checked the code once again and figured that we could drop/replace
> > > tee_shm_register_kernel_buf() with tee_shm_alloc_kernel_buf(). I don't
> > > see why a kernel driver needs to tee_shm_register_kernel_buf() in the
> > > first place, maybe this is legacy. The only users of
> > > tee_shm_register_kernel_buf() are trusted_tee.c and tee_stmm_efi.c.
> > 
> > No it's not legacy but allows for efficient memory reuse within the
> > kernel as to not create bounce buffers to share data with TEE.
> 
> To be hones, there are only two driver using the API. The tee_stmm_efi
> driver can do the alloc during the probe(). The trusted_tee has to use a
> bounce buffer, yes but how often do you assume that (un)sealing and rng
> ops have to be done during runtime? This shouldn't be a overhead at all.
> 
> Therefore my suggestion would be still to drop the internal kernel API
> and only use it for userspace pages, where it could really matter.

I don't disagree with what you are saying here but we really need to
promote efficient memory reuse for TEE clients. There will surely be
more use-cases coming in future which can benefit from the flexibility
to register buffer. One another kernel client being remoteproc subsystem
which is already under review for this API.

-Sumit

> 
> Regards,
>   Marco
> -- 
> #gernperDu 
> #CallMeByMyFirstName
> 
> Pengutronix e.K.                           |                             |
> Steuerwalder Str. 21                       | https://www.pengutronix.de/ |
> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-9    |

