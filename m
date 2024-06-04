Return-Path: <linux-efi+bounces-1139-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0A9C8FBCCE
	for <lists+linux-efi@lfdr.de>; Tue,  4 Jun 2024 21:58:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CBBE284757
	for <lists+linux-efi@lfdr.de>; Tue,  4 Jun 2024 19:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00DD6142631;
	Tue,  4 Jun 2024 19:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n8SKDzmd"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C053C13FD9D;
	Tue,  4 Jun 2024 19:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717531107; cv=none; b=Qf22LMW9mV0KnYV6je8i249y61lao3ge/Y5Hi92oAg+7qshmRkZG9NROE5zaQDixmKLp1optenKncCaSWxhM44DPHGVO0OekrjKwmitmeyG/ZnTSF/LfP1d0inlvqJ+jHTz2shQBCwMcmr+PF8ybj+C0fBqURv9hWJ8/JSCTOAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717531107; c=relaxed/simple;
	bh=EdXREgrUFbhjr5J9t9xfAPvnQcvPhKQ1IC5dTo+Axkg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=f15D3mx1f6WWggGLQsDvcDLiIv40KThesFt6EUW7BfGl2yhJdGfmwuojarbeT3LX0iFY9ZCQxJcOURLxm00esCQQMxDmbFxriWgSZzRmPCmZ3+QsyldTKvuDyvn5NYN0BW8OyALa2tKD3xe7hwgvuuz38qig2GXPUab0Z/goO/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n8SKDzmd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC0E6C2BBFC;
	Tue,  4 Jun 2024 19:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717531107;
	bh=EdXREgrUFbhjr5J9t9xfAPvnQcvPhKQ1IC5dTo+Axkg=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=n8SKDzmdRAxmg/cdodk0J19d2WNc3XJ8TNLT2QE1Wnss24vGwthUtE4wxphTxOnBI
	 7EiS2dyoKsrcu5VjuCibb4F7u0poTQqvPefUSPhWQRefKgIsY1p/p6/1gWHyJzW6cB
	 L5jka2UwpQMtdF8SmaJeWiNCz8Pq/5Uxj4OpFCpMsHZBTtLSib52BLbff5DWT9+YE0
	 ulAtWhzBRdPzRzapJRSs5rCZ9ADYWpT6dQB8YcMq95qUY6EBIyMeEwoKwLasS+NX7N
	 T7wAy+5TFRHb/A444x+5RHSozYN8O6dptYC4gXpbR/qx6lIx8KQ1mNZqHivZPDqXmx
	 vcSGHh+M/fpYg==
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 04 Jun 2024 22:58:19 +0300
Message-Id: <D1RHYMFSVGSW.39IL7KFK8A47N@kernel.org>
Cc: <dpsmith@apertussolutions.com>, <tglx@linutronix.de>,
 <mingo@redhat.com>, <bp@alien8.de>, <hpa@zytor.com>,
 <dave.hansen@linux.intel.com>, <ardb@kernel.org>, <mjg59@srcf.ucam.org>,
 <James.Bottomley@hansenpartnership.com>, <peterhuewe@gmx.de>,
 <jgg@ziepe.ca>, <luto@amacapital.net>, <nivedita@alum.mit.edu>,
 <herbert@gondor.apana.org.au>, <davem@davemloft.net>, <corbet@lwn.net>,
 <ebiederm@xmission.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
 <kanth.ghatraju@oracle.com>, <andrew.cooper3@citrix.com>,
 <trenchboot-devel@googlegroups.com>
Subject: Re: [PATCH v9 09/19] x86: Secure Launch kernel late boot stub
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Ross Philipson" <ross.philipson@oracle.com>,
 <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
 <linux-integrity@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-crypto@vger.kernel.org>, <kexec@lists.infradead.org>,
 <linux-efi@vger.kernel.org>, <iommu@lists.linux-foundation.org>
X-Mailer: aerc 0.17.0
References: <20240531010331.134441-1-ross.philipson@oracle.com>
 <20240531010331.134441-10-ross.philipson@oracle.com>
In-Reply-To: <20240531010331.134441-10-ross.philipson@oracle.com>

On Fri May 31, 2024 at 4:03 AM EEST, Ross Philipson wrote:
> The routine slaunch_setup is called out of the x86 specific setup_arch()
> routine during early kernel boot. After determining what platform is
> present, various operations specific to that platform occur. This
> includes finalizing setting for the platform late launch and verifying
> that memory protections are in place.

"memory protections" is not too helpful tbh.

Better to describe very briefly the VT-d usage.

BR, Jarkko

