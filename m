Return-Path: <linux-efi+bounces-1134-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56F228FBB74
	for <lists+linux-efi@lfdr.de>; Tue,  4 Jun 2024 20:21:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D246AB24F2E
	for <lists+linux-efi@lfdr.de>; Tue,  4 Jun 2024 18:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C6D714A4E5;
	Tue,  4 Jun 2024 18:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jImRPbGP"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C27149009;
	Tue,  4 Jun 2024 18:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717525293; cv=none; b=EWmIeEYmA2yDjgnxs4M6GXLWtzre5Myqr+b9e1n9AcZLSjXKb32sLleNW96XAv+WvsvNGe/EDit0SXjSE40FU9HHXMyJMyOCxZKPUdkVX4YAU1DTk/6UDKTp+QBSkJaDU3XIk5ECOOe2UgL5OVxo+Y/dg77vLVOi7P4QS++3MZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717525293; c=relaxed/simple;
	bh=rJen4p/W7Qw4c91Xr9BpGnLPEjJLClcQzjp1Wn6mzUk=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=RETQq0Qup2Blpu4NlCyoV3jM2IX2hLo0ivp27TBngc/eB/++riUJB6RsmSBEkAioKlFvD0An0DUQll92jSrc7PQ+3kmM4AycZqUstBGbrMdvYRKMTwhk/NDLXNutH3XG1K6rhRXBFjscQqBZwDmCvhNXS031lA6RtIDOXkirnWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jImRPbGP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05055C2BBFC;
	Tue,  4 Jun 2024 18:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717525292;
	bh=rJen4p/W7Qw4c91Xr9BpGnLPEjJLClcQzjp1Wn6mzUk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jImRPbGPC31H3Lp5sDakUcWNcoHmB1MSC8DZsrgV4n4jN8IRnrKQN9FNSGA+F666V
	 ixNdbhn5DqJdm5jlYRGVpYwtyWwFT1R5NGqAgJ4c4dWV9ce4Aw3wlT0CGDrdqU91gY
	 2+SIqS5xZGyKN1Oi4WurYpYLnlLKubqE9we2LEL7GMTYRezo7XmT078tfQ1n24Sto5
	 bn+3T9AII3RuOHzXf1l8M9F+1wKLINvwAyzmHlxz6PQeBJ2zTDxvouJRXIaBYXs5ya
	 NKO7D8Uhz/+o8s4tIoiA6n2EMXU3TmqFLMGeQ5gpgr8bsfN/dAlEWc9gIsakqS6dW/
	 Qb3MFnYgR6ONw==
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 04 Jun 2024 21:21:25 +0300
Message-Id: <D1RFWFIJEYWL.2FC7V79321264@kernel.org>
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Ross Philipson" <ross.philipson@oracle.com>,
 <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
 <linux-integrity@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-crypto@vger.kernel.org>, <kexec@lists.infradead.org>,
 <linux-efi@vger.kernel.org>, <iommu@lists.linux-foundation.org>
Cc: <dpsmith@apertussolutions.com>, <tglx@linutronix.de>,
 <mingo@redhat.com>, <bp@alien8.de>, <hpa@zytor.com>,
 <dave.hansen@linux.intel.com>, <ardb@kernel.org>, <mjg59@srcf.ucam.org>,
 <James.Bottomley@hansenpartnership.com>, <peterhuewe@gmx.de>,
 <jgg@ziepe.ca>, <luto@amacapital.net>, <nivedita@alum.mit.edu>,
 <herbert@gondor.apana.org.au>, <davem@davemloft.net>, <corbet@lwn.net>,
 <ebiederm@xmission.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
 <kanth.ghatraju@oracle.com>, <andrew.cooper3@citrix.com>,
 <trenchboot-devel@googlegroups.com>
Subject: Re: [PATCH v9 04/19] x86: Secure Launch Resource Table header file
X-Mailer: aerc 0.17.0
References: <20240531010331.134441-1-ross.philipson@oracle.com>
 <20240531010331.134441-5-ross.philipson@oracle.com>
In-Reply-To: <20240531010331.134441-5-ross.philipson@oracle.com>

On Fri May 31, 2024 at 4:03 AM EEST, Ross Philipson wrote:
> Introduce the Secure Launch Resource Table which forms the formal
> interface between the pre and post launch code.
>
> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>

If a uarch specific, I'd appreciate Intel SDM reference here so that I
can look it up and compare. Like in section granularity.

BR, Jarkko

