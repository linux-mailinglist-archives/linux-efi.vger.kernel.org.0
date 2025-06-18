Return-Path: <linux-efi+bounces-3831-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4123ADE5A5
	for <lists+linux-efi@lfdr.de>; Wed, 18 Jun 2025 10:35:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FF3E17CBEE
	for <lists+linux-efi@lfdr.de>; Wed, 18 Jun 2025 08:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC59A27FB2D;
	Wed, 18 Jun 2025 08:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TZo+Qjfz"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C735619E819;
	Wed, 18 Jun 2025 08:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750235617; cv=none; b=R3M7C/CvdfD9x9+JHLysaZ0iPZXB75ucdDD9vTPi4/wj8KVzaHkCmB9L5BxJ8L5Srwv7DH4/GeCIrFfCSzkn+/67eERhekLtYVkHDdqwU9REDEoWfhq2PH8GWHdkcG994xx0Vd6mLOvIqWwxi88t5tp3fMUuxCO6X7SB/S3NIyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750235617; c=relaxed/simple;
	bh=fIu3H0X1ir+ab5DgfWZw8Zxf2egqeIQlXSOMOU+My5c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i4VIhubzAJEKUAe+BobFLMmBSY0E5svDZQc0+jTUXKt1joy07bh6JgkMFo8q7lLLbnSMTRUI/nRb1z6oCi4k0919pJGi3CPvHnt2uAzPBi6mQrxGGwPZvgk3J7DlygJi3hp4kaP18QY4RxNEWVEq+XYQyemEW7S6btFScuXMVvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TZo+Qjfz; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750235616; x=1781771616;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=fIu3H0X1ir+ab5DgfWZw8Zxf2egqeIQlXSOMOU+My5c=;
  b=TZo+Qjfzi4wCLHB/11wruSp9VA8QxlGISaG66w533v1WSxc0plEdsYs+
   hkjO9HgyUl/JUZyJm3wc2EovJu+JzqMcKAhEriaMtjq67akzMNj1KIHmD
   JkdU1/Zk3puJlDlHVqjsZgY9Ayzk1ORsS+CYrkwVbuWk0h4oqiEZ/6f0c
   BPbxaD9Mt41TjdHdZrN5BBXjIMYvS757sd07ljxPsHwNSZx13Wury3aLx
   LMpgMVpttEdIn61q9L4rTT8bwABNHd/zfZjr9givGPHYZX+S9VHV98hrO
   EL0tpav7TZTcKGQoiCIVBa9ecXgQUiSwlNg7rGuD7WIXrCrQAsQyEj5Lc
   A==;
X-CSE-ConnectionGUID: m3aupNNSTI222TTctr1y+Q==
X-CSE-MsgGUID: kOfACOHfRR6RwtxVlSIOCA==
X-IronPort-AV: E=McAfee;i="6800,10657,11467"; a="63048642"
X-IronPort-AV: E=Sophos;i="6.16,245,1744095600"; 
   d="scan'208";a="63048642"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 01:32:27 -0700
X-CSE-ConnectionGUID: XdbUQy3CRfOUfn7iOGHy+w==
X-CSE-MsgGUID: HBtqD8F8So280xiJlFKgkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,245,1744095600"; 
   d="scan'208";a="149986926"
Received: from mmowka-mobl.ger.corp.intel.com (HELO [10.245.101.212]) ([10.245.101.212])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 01:32:20 -0700
Message-ID: <231e4cef-2e44-4e25-9169-f298e72e8e07@linux.intel.com>
Date: Wed, 18 Jun 2025 10:32:04 +0200
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
Content-Language: pl
From: "Mowka, Mateusz" <mateusz.mowka@linux.intel.com>
In-Reply-To: <20250421162712.77452-3-ross.philipson@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 21-Apr-25 6:26 PM, Ross Philipson wrote:
> Initial bits to bring in Secure Launch functionality. Add Kconfig
> options for compiling in/out the Secure Launch code.
>
> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>

Acked-by: Mateusz Mowka <mateusz.mowka@linux.intel.com>

> ---
>   arch/x86/Kconfig | 11 +++++++++++
>   1 file changed, 11 insertions(+)
>
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 4b9f378e05f6..badde1e9742e 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -2001,6 +2001,17 @@ config EFI_RUNTIME_MAP
>   
>   	  See also Documentation/ABI/testing/sysfs-firmware-efi-runtime-map.
>   
> +config SECURE_LAUNCH
> +	bool "Secure Launch support"
> +	depends on X86_64 && X86_X2APIC && TCG_TIS && TCG_CRB && CRYPTO_LIB_SHA1 && CRYPTO_LIB_SHA256
> +	help
> +	   The Secure Launch feature allows a kernel to be loaded
> +	   directly through an Intel TXT measured launch. Intel TXT
> +	   establishes a Dynamic Root of Trust for Measurement (DRTM)
> +	   where the CPU measures the kernel image. This feature then
> +	   continues the measurement chain over kernel configuration
> +	   information and init images.
> +
>   source "kernel/Kconfig.hz"
>   
>   config ARCH_SUPPORTS_KEXEC

