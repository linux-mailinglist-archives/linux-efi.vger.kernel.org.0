Return-Path: <linux-efi+bounces-5878-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E6FCCC0B52
	for <lists+linux-efi@lfdr.de>; Tue, 16 Dec 2025 04:21:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CD7A8301A718
	for <lists+linux-efi@lfdr.de>; Tue, 16 Dec 2025 03:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 852DB29AB02;
	Tue, 16 Dec 2025 03:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IBymN0iX"
X-Original-To: linux-efi@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2FB2BE7BE;
	Tue, 16 Dec 2025 03:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765855222; cv=none; b=m9DznH8CN6nnd6bksohf2kfs4s87B0cQbYYv4HtsbhSa9JcQaFxm75spsWKC8EFwb3nyp8cnEIQuEG6uFZGeWUAalDFOCfMfkCKOYbBzQfRHxUvUNduBS+A5mZA21i3J6xAXmfAMG8bCVoyHleqZ773gkVe+W6WHRxVSMPc/YGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765855222; c=relaxed/simple;
	bh=agGzR8N1v/aQf5Aot+zTt/+zQuSckWjQgmzdFpNlTTk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pZyEYy8680UEsyUY/EXGNw77bLfzcgbdwTNoBYlyYcTs9Yj4LX6c25nbO46cTUa0T9FEZOI3QGeM1zCLOrMPDBnUBCySjZvkcTFFNrtlk1Yo/nKjfAgomv6ZY06EmemiAKQdzeEbww+1WlX2SuBtjOj61OjUIzknXWrghZmax3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=IBymN0iX; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=yHYvE/RwhbWxyv6LR2HFPMM/SlGaue2aVCL8Y+jEiaA=; b=IBymN0iX6goRzGGqs+498RbNgA
	kBvoFXwYc19krCnbKBbeSjBu/aG3Ya1I6najZaAULz+e+j/P5XtHbWQbkDWb+6g0q3RF7NFr17Fl/
	xmLnEzKSmSIeTYie1a5rcsoH0Xk9bc/DRmHktFJIJQdS0mS9/89LQgi1rxXS4VIAZrdCaMrVEf4pF
	J383PThV5rcxwzeOzP0QRL6M8MbjAYidli4Gjslj7imqivEFJ2ZG+VEewx4o7PU7q+3i8PnLWoFAj
	5h1PEOAJFSm1rW5vxOFSH2D3LVjV6QXtqfh+kiQxrl3tCYKkd+BW+l+aPQeLsr8xwgmaj7QD4mozw
	NFzI31RQ==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vVLbi-00000004cU4-4Bg6;
	Tue, 16 Dec 2025 03:20:15 +0000
Message-ID: <f2b1d24f-86fd-4b90-b6c0-126a4a2368ec@infradead.org>
Date: Mon, 15 Dec 2025 19:20:13 -0800
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 13/28] x86: Secure Launch Kconfig
To: Ross Philipson <ross.philipson@oracle.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org, linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
 linux-efi@vger.kernel.org, iommu@lists.linux.dev
Cc: dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com, ardb@kernel.org,
 mjg59@srcf.ucam.org, James.Bottomley@hansenpartnership.com,
 peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca, luto@amacapital.net,
 nivedita@alum.mit.edu, herbert@gondor.apana.org.au, davem@davemloft.net,
 corbet@lwn.net, ebiederm@xmission.com, dwmw2@infradead.org,
 baolu.lu@linux.intel.com, kanth.ghatraju@oracle.com,
 andrew.cooper3@citrix.com, trenchboot-devel@googlegroups.com
References: <20251215233316.1076248-1-ross.philipson@oracle.com>
 <20251215233316.1076248-14-ross.philipson@oracle.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20251215233316.1076248-14-ross.philipson@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/15/25 3:33 PM, Ross Philipson wrote:
> Add a Kconfig option for compiling in/out the Secure Launch feature.
> Secure Launch is controlled by a singel boolean on/off.
> 
> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
> ---
>  arch/x86/Kconfig | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index fa3b616af03a..9404d207c420 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -1975,6 +1975,20 @@ config EFI_RUNTIME_MAP
>  
>  	  See also Documentation/ABI/testing/sysfs-firmware-efi-runtime-map.
>  
> +config SECURE_LAUNCH
> +	bool "Secure Launch DRTM support"
> +	depends on X86_64 && X86_X2APIC && TCG_TIS && TCG_CRB
> +	select CRYPTO_LIB_SHA1
> +	select CRYPTO_LIB_SHA256
> +	help
> +	  The Secure Launch feature allows a kernel to be launched directly
> +	  through a vendor neutral DTRM (Dynamic Root of Trust for Measurement)

	                           DRTM

> +	  solution, with Intel TXT being one example.  The DRTM establishes an
> +	  environment where the CPU measures the kernel image, employing the TPM,
> +	  before starting it. Secure Launch then continues the measurement chain
> +	  over kernel configuration information and other launch artifacts (e.g.
> +	  any initramfs image).
> +
>  source "kernel/Kconfig.hz"
>  
>  config ARCH_SUPPORTS_KEXEC

-- 
~Randy


