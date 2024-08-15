Return-Path: <linux-efi+bounces-1542-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26849953A9E
	for <lists+linux-efi@lfdr.de>; Thu, 15 Aug 2024 21:10:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AFFA284830
	for <lists+linux-efi@lfdr.de>; Thu, 15 Aug 2024 19:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90D6E76026;
	Thu, 15 Aug 2024 19:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tXHVRT29";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cAIOFZaz"
X-Original-To: linux-efi@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA95E4084C;
	Thu, 15 Aug 2024 19:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723749018; cv=none; b=aY9WjHVHuX52PeaHme+2odiYNxyO1ma5OMVKC4Nkc1rxZxZtg1PUopXnSa30xUv+gyFvarASFium6tx1D3bGyaUBLRAFXpzFJkr70bzsPj/oI4bgNFoIASSsY9oocbMp/YKQ4+mMALZISZCWLnYeSAviRvgE4T2yxzGrXF1b5Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723749018; c=relaxed/simple;
	bh=qX4J3Xd64CEwbRGOxae+jQ1qggxaa6N08g0sY0Yr4kk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=E85Y8fHH6u4Vz/lqCrmxRnoT9rrNYRJqlKHPVj5yCw+mMh3HHWhLbAlYhGKi9Rw7eP40bMcwk+OEAd1jqZ78CbcQIpLOdl8/tvIuiv+tZu/WRr8wnDRYGHPSu9KF8zCsEQc+JliKvJJCbA3RUkKd1Wotdpu0Mubo+Ua/kjZdpc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tXHVRT29; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cAIOFZaz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723749014;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fZTVvaO2p2W+P+UPnKNV9BKWDUfkQHL/Xf0aN8/w5q0=;
	b=tXHVRT29inPW/Cw8vHHs1o14Q4Yg3be6qe6cDE1L2kjUo1Ou+VJWbihHot0QdYTT2XmfNq
	Q7QHsyjgqoB5Q42qu0yDhBmmkonyK9Cl6Ff4CsaEjhOwJ86AXJXwKqyY5kAg9g14zXrdxO
	ax7P6WZqn9oe9FXaY5ioB5ukKN9HGo/U2D2wj5FHKutnuWinDt8ZRCGFBmxRLt3hc8qnfc
	sJvVZE7ClLcjgLf59JVQy2y7fu6zGzKEnF1gvED+dsVLlyDPjYBCOWSqXX1AJYZeW0plRT
	84C/Hq8k3joLra6RWJ+SAEv1oMijRvkMW5KQVtHRF8nD6KNa++f8NFzn4DeM4w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723749014;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fZTVvaO2p2W+P+UPnKNV9BKWDUfkQHL/Xf0aN8/w5q0=;
	b=cAIOFZazMeEHCSiUEc0/bZDaCxz0Zt0Bdo6zTqNdOOXhSC3N+b2lASD42ZXOG8ROfzkNKS
	ENdJDWGyB1XUvtDQ==
To: "Daniel P. Smith" <dpsmith@apertussolutions.com>, "Eric W. Biederman"
 <ebiederm@xmission.com>, Eric Biggers <ebiggers@kernel.org>
Cc: Ross Philipson <ross.philipson@oracle.com>,
 linux-kernel@vger.kernel.org, x86@kernel.org,
 linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
 linux-efi@vger.kernel.org, iommu@lists.linux-foundation.org,
 mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
 dave.hansen@linux.intel.com, ardb@kernel.org, mjg59@srcf.ucam.org,
 James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de,
 jarkko@kernel.org, jgg@ziepe.ca, luto@amacapital.net,
 nivedita@alum.mit.edu, herbert@gondor.apana.org.au, davem@davemloft.net,
 corbet@lwn.net, dwmw2@infradead.org, baolu.lu@linux.intel.com,
 kanth.ghatraju@oracle.com, andrew.cooper3@citrix.com,
 trenchboot-devel@googlegroups.com
Subject: Re: [PATCH v9 06/19] x86: Add early SHA-1 support for Secure Launch
 early measurements
In-Reply-To: <5b1ce8d3-516d-4dfd-a976-38e5cee1ef4e@apertussolutions.com>
References: <20240531010331.134441-1-ross.philipson@oracle.com>
 <20240531010331.134441-7-ross.philipson@oracle.com>
 <20240531021656.GA1502@sol.localdomain>
 <874jaegk8i.fsf@email.froward.int.ebiederm.org>
 <5b1ce8d3-516d-4dfd-a976-38e5cee1ef4e@apertussolutions.com>
Date: Thu, 15 Aug 2024 21:10:14 +0200
Message-ID: <87ttflli09.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Aug 15 2024 at 13:38, Daniel P. Smith wrote:
> On 5/31/24 09:54, Eric W. Biederman wrote:
>> Eric Biggers <ebiggers@kernel.org> writes:
>>> That paragraph is also phrased as a hypothetical, "Even if we'd prefer to use
>>> SHA-256-only".  That implies that you do not, in fact, prefer SHA-256 only.  Is
>>> that the case?  Sure, maybe there are situations where you *have* to use SHA-1,
>>> but why would you not at least *prefer* SHA-256?
>> 
>> Yes.  Please prefer to use SHA-256.
>> 
>> Have you considered implementing I think it is SHA1-DC (as git has) that
>> is compatible with SHA1 but blocks the known class of attacks where
>> sha1 is actively broken at this point?
>
> We are using the kernel's implementation, addressing what the kernel 
> provides is beyond our efforts. Perhaps someone who is interested in 
> improving the kernel's SHA1 could submit a patch implementing/replacing 
> it with SHA1-DC, as I am sure the maintainers would welcome the help.

Well, someone who is interested to get his "secure" code merged should
have a vested interested to have a non-broken SHA1 implementation if
there is a sensible requirement to use SHA1 in that new "secure" code,
no?

Just for the record. The related maintainers can rightfully decide to
reject known broken "secure" code on a purely technical argument.

Thanks,

        tglx


