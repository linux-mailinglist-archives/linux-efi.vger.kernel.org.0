Return-Path: <linux-efi+bounces-1161-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 029028FBF2F
	for <lists+linux-efi@lfdr.de>; Wed,  5 Jun 2024 00:43:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3526E1C25098
	for <lists+linux-efi@lfdr.de>; Tue,  4 Jun 2024 22:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CD8C14C5A3;
	Tue,  4 Jun 2024 22:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I9vMEgfy"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9F2A5F;
	Tue,  4 Jun 2024 22:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717541022; cv=none; b=ip+dRiOoH40K6nAm9ywhFy9eHNr4ok6BsK05RMjIE8BYRKJPHO9Hdw2o3nJd/R+CuxtSQ7FORgtUQUu38454cCo2WLVzviGWnsvc7oZFuDT5j0x5ytJu5t23WJlNd2PkPszBdwwDj2yJUyEXEaxehFpVrall6ZBizJOWCUlTVI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717541022; c=relaxed/simple;
	bh=Gvkfp5YbJwML1P1XHALdTu+UlMk812IdrdYozmeU+R8=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=Me8iIaR5Af8y2+fdHahZxow0A49tk+3MTUZWXpnPDgakwJZ6kvzlWZcNrui0ScuOHL/Z5hs68PtiORHekPyFZnxJQAhnHthngCwEnqUVCmY4l/xEC98VEaBKGineWkNXgyWNdkYS48Hx0ce7qy7r1GzoPFR/bNea2a+ImaKyRT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I9vMEgfy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA590C2BBFC;
	Tue,  4 Jun 2024 22:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717541021;
	bh=Gvkfp5YbJwML1P1XHALdTu+UlMk812IdrdYozmeU+R8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I9vMEgfymZiMHowJPK0j6PGnB4K8NiMVfmeC5CboYCxP4VQiCLtom6Bh3LGBUMGv2
	 RJYIUtTdCGtmGvwIEoZ5W3VGKDeMauC1Plp4BeHnilMFU0u4qtt8xJdpTJdYTu8Wem
	 3Q7k1fhtOTW3HcMO6VNZylFS3AhvFtv+ke3kt9hy4wyKOacVXfU7w4i3DY/0w5uHS/
	 lheegCWh9BSlWj52kUQD2plb2avqcjLDF6G958ch3TQwzwc2062ybktk6reSnYIVRP
	 RMZIuot6TzcVOOZ5t0RExBJo9ZZzZF6/XwCYxa4vLSLe1kjTIQIrEN+1djb3HXXFFM
	 J3AtNbhAAyKAQ==
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 05 Jun 2024 01:43:34 +0300
Message-Id: <D1RLH5CJJ2NA.33QHHJNR5IZ41@kernel.org>
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: <ross.philipson@oracle.com>, <linux-kernel@vger.kernel.org>,
 <x86@kernel.org>, <linux-integrity@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
 <kexec@lists.infradead.org>, <linux-efi@vger.kernel.org>,
 <iommu@lists.linux-foundation.org>
Cc: <dpsmith@apertussolutions.com>, <tglx@linutronix.de>,
 <mingo@redhat.com>, <bp@alien8.de>, <hpa@zytor.com>,
 <dave.hansen@linux.intel.com>, <ardb@kernel.org>, <mjg59@srcf.ucam.org>,
 <James.Bottomley@hansenpartnership.com>, <peterhuewe@gmx.de>,
 <jgg@ziepe.ca>, <luto@amacapital.net>, <nivedita@alum.mit.edu>,
 <herbert@gondor.apana.org.au>, <davem@davemloft.net>, <corbet@lwn.net>,
 <ebiederm@xmission.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
 <kanth.ghatraju@oracle.com>, <andrew.cooper3@citrix.com>,
 <trenchboot-devel@googlegroups.com>
Subject: Re: [PATCH v9 08/19] x86: Secure Launch kernel early boot stub
X-Mailer: aerc 0.17.0
References: <20240531010331.134441-1-ross.philipson@oracle.com>
 <20240531010331.134441-9-ross.philipson@oracle.com>
 <D1RHWYUN14C0.34HJBW7BI3CIV@kernel.org>
 <e5287d8c-58ec-4f24-b27f-f8de688931d6@oracle.com>
In-Reply-To: <e5287d8c-58ec-4f24-b27f-f8de688931d6@oracle.com>

> > s/tpm20/tpm2/
>
> Reasonable. We can change it.

For the sake of consistency. Anywhere else where we have code using TPM,
either "tpm_" or "tpm2_" is used.

BR, Jarkko

