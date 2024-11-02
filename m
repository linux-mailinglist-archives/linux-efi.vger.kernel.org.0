Return-Path: <linux-efi+bounces-2107-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 086F99B9C04
	for <lists+linux-efi@lfdr.de>; Sat,  2 Nov 2024 02:39:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A59FB1F21EDD
	for <lists+linux-efi@lfdr.de>; Sat,  2 Nov 2024 01:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E7F450276;
	Sat,  2 Nov 2024 01:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EvhPienQ"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD824D8CB;
	Sat,  2 Nov 2024 01:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730511567; cv=none; b=U/9ZMjRpGAgmbyENKwXHhCaSPAzWMf3yZQa4szyiyA/pkQbBVKjLwLfIoh0jEHKffxy0Tz/TrpgG30h6J+UHwfa7sMK3Mc9cV9YXOOpXVeL5bDFwbUyzA6bvvxVtUlFGk82mGRoCyl/lPAWk33savnAX9zUbl25ptbe3B/cJuYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730511567; c=relaxed/simple;
	bh=IaQl3xXmqIlGoa3l2q44Qr4bCwT9TUCnkQYdd7ZyWj8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=U9ZD2Bwxu+CbgFVnp7ySS1+tK3c9yx+b7XOmOIcEzMGplzKzQUEH2nvCVqRCV5lOZBBA/LWQMilih8/Gcigo5yHPmlPVTUUcW+1qFet3OWotBFqKNIm2+mlvqIf/ldbl3K3OiclL3+jlIgxRv+SiukITl0p5g6JtvP4EcUlz73U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EvhPienQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3256AC4CECD;
	Sat,  2 Nov 2024 01:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730511566;
	bh=IaQl3xXmqIlGoa3l2q44Qr4bCwT9TUCnkQYdd7ZyWj8=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=EvhPienQsr02gNyzBolx1UhCJ1qhimKmTyH8tA5JP3/dkX+EovpwLa10jl07kvICq
	 KpjNiRsz5REVf64QX57lOuT87MNvpT5g5w6ffxRJyyjmVDpY6cx7XeCGLV7CysMFvC
	 6i5LijMVHR3jTYdYodnQ6JGKQwo3kWdWKkJJ6M1GSfUKXaiqlikzWWiMUMbGnJgLWY
	 ltTyzV5iKNMLr50jdOGeUr5p47Mt+AiPwQHmRp+7k++aOyeMHbe3snlraOgayvuE0V
	 CtDIMGLaLyzX6DxAVngENUmyJsjNyLd8ANfd0St0wbfWjF03CtcrVd+smY/rs6q2YI
	 /bFbtGlgGYLEg==
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 02 Nov 2024 03:39:22 +0200
Message-Id: <D5BB5GX4KEUO.VJ2G9G9QKYRR@kernel.org>
Cc: <James.Bottomley@hansenpartnership.com>, <andrew.cooper3@citrix.com>,
 <ardb@kernel.org>, <baolu.lu@linux.intel.com>, <bp@alien8.de>,
 <dave.hansen@linux.intel.com>, <davem@davemloft.net>,
 <dpsmith@apertussolutions.com>, <dwmw2@infradead.org>,
 <ebiederm@xmission.com>, <herbert@gondor.apana.org.au>, <hpa@zytor.com>,
 <iommu@lists.linux-foundation.org>, <kanth.ghatraju@oracle.com>,
 <kexec@lists.infradead.org>, <linux-crypto@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-efi@vger.kernel.org>,
 <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <luto@amacapital.net>, <mingo@redhat.com>, <mjg59@srcf.ucam.org>,
 <nivedita@alum.mit.edu>, <tglx@linutronix.de>,
 <trenchboot-devel@googlegroups.com>, <x86@kernel.org>
Subject: Re: [RFC PATCH] tpm, tpm_tis: Introduce TPM_IOC_SET_LOCALITY
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, <ross.philipson@oracle.com>,
 "Jonathan Corbet" <corbet@lwn.net>, "Peter Huewe" <peterhuewe@gmx.de>,
 "Jason Gunthorpe" <jgg@ziepe.ca>
X-Mailer: aerc 0.18.2
References: <20240913200517.3085794-18-ross.philipson@oracle.com>
 <20241102013716.1036396-1-jarkko@kernel.org>
In-Reply-To: <20241102013716.1036396-1-jarkko@kernel.org>

On Sat Nov 2, 2024 at 3:37 AM EET, Jarkko Sakkinen wrote:
> DRTM needs to be able to set the locality used by kernel. Provide
> TPM_IOC_SET_LOCALITY operation for this purpose. It is enabled only if
> the kernel command-line has 'tpm.set_locality_enabled=3D1'. The operation
> is one-shot allowed only for tpm_tis for the moment.
>
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

I hope you could take it from there if this works for you in the big
pic, and address possible comments, thanks.

BR, Jarkko

