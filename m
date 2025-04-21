Return-Path: <linux-efi+bounces-3395-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B40CBA95569
	for <lists+linux-efi@lfdr.de>; Mon, 21 Apr 2025 19:41:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BE487A5AEB
	for <lists+linux-efi@lfdr.de>; Mon, 21 Apr 2025 17:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61AD41E573F;
	Mon, 21 Apr 2025 17:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ORG0Iapu"
X-Original-To: linux-efi@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA201D5ADC;
	Mon, 21 Apr 2025 17:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745257309; cv=none; b=AO85TzuWMouOI/xG9VW5//AbOKV+Tiwq1FfD4huN9OsOVbkAFkh7J8JF7BNz9XQIooeTrvA0/z4FMRMieL9pfClRyfec+d0xNQ4D8oH0/54dJyUE3h62p8VQtl1ywMj1s6h/61FwmAeq0p9qbPR7indQO+OLRdApp/4CJO5EtlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745257309; c=relaxed/simple;
	bh=MInvo/TJqnPXzU3X5PwPYokDZsTAhzEEcwDju2P+M8o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N1K86ibY+agTRPaNAEN5dH0LDuaraWMessvAs+9lSMH5wFKeZYN5LKlSHMWt4VhvKUxNHe3980MA02JXAHTsH/RDX6dnLg4/QhO/0zd9xDcMnuHdyZDrsuRP4hg3tGxC5T8POvoWxzMUHjWf7WpSLxn6xt+zSi2vh78t37bfXMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ORG0Iapu; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=Ff+h7YRAkELws4CRWM7YOB1YCS1xo5ywus2jMjXmZLo=; b=ORG0IapudPPt0kyVA64pyXTGLZ
	2ozgqSwMiwrIoNUfzdXuzOgGfP16RJ+MkH+lgjykjY8nOmzW5/NkJ2DMvgGjKDk0z6wNysFJIgBuW
	eQ+XYGrRi2LiWjjRcBFJl3+4TtqK8TqlR5M40OMEp71P/4+ZG8I6M8Wv9gNwdcts8y4lgfRgiy4J4
	R4jpTc/Z0wW2DChYSHRG5jQxNZZcs17DWw7J8iCANSTwDCOCGVvTT2hkZwh5+AZNMOiAVAIUEGf+N
	qORbtkQuyYEPCvSKOXk/2pk6sanGbLe+QCLnJLbDWUVNAgzwNXST9tHHRVyjKQUMMk49qS98WYQhD
	VTpPUq1A==;
Received: from [50.39.124.201] (helo=[192.168.254.17])
	by desiato.infradead.org with esmtpsa (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u6v9F-0000000B5HO-0I13;
	Mon, 21 Apr 2025 17:41:37 +0000
Message-ID: <e1e3dc8f-ca16-4cce-a670-bb8ef566213d@infradead.org>
Date: Mon, 21 Apr 2025 10:41:27 -0700
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 02/19] x86: Secure Launch Kconfig
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
References: <20250421162712.77452-1-ross.philipson@oracle.com>
 <20250421162712.77452-3-ross.philipson@oracle.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250421162712.77452-3-ross.philipson@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 4/21/25 9:26 AM, Ross Philipson wrote:
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 4b9f378e05f6..badde1e9742e 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -2001,6 +2001,17 @@ config EFI_RUNTIME_MAP
>  
>  	  See also Documentation/ABI/testing/sysfs-firmware-efi-runtime-map.
>  
> +config SECURE_LAUNCH
> +	bool "Secure Launch support"
> +	depends on X86_64 && X86_X2APIC && TCG_TIS && TCG_CRB && CRYPTO_LIB_SHA1 && CRYPTO_LIB_SHA256

It's normal to select needed library symbols instead of depending on them.
Nothing else in the kernel tree uses depends on for these 2 Kconfig symbols.
(CRYPTO_LIB_SHAxxx)

> +	help
> +	   The Secure Launch feature allows a kernel to be loaded
> +	   directly through an Intel TXT measured launch. Intel TXT
> +	   establishes a Dynamic Root of Trust for Measurement (DRTM)
> +	   where the CPU measures the kernel image. This feature then
> +	   continues the measurement chain over kernel configuration
> +	   information and init images.

-- 
~Randy


