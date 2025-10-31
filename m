Return-Path: <linux-efi+bounces-5303-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AE48C25E61
	for <lists+linux-efi@lfdr.de>; Fri, 31 Oct 2025 16:51:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DC77C34FB14
	for <lists+linux-efi@lfdr.de>; Fri, 31 Oct 2025 15:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A0D62E7651;
	Fri, 31 Oct 2025 15:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="anszXl1y"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00E82E6CAC;
	Fri, 31 Oct 2025 15:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761925867; cv=none; b=ExCfis+yKtLqziBA8mGF7GTp9NYQdUr998xOssv+127tlXJh90lBkWKRUOWA6EY2JmvrjdafDxFq+sLoq9dbeTNgWy6XS4SZcDs6HZ/KX7x9KCKjUKJ2U6T8AykCVJpNKRlfxLCYUm1GF9HXuvDl/itZEjBfzrVRxEcxpmsiXbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761925867; c=relaxed/simple;
	bh=3JNm5w5PxMIzq/o+9F1WdKTFb+0BAFGDlT1t1PLX/6Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OYFcW7Y3xwbGfMHL/0//bmwjDb0Br8MFf1RmNfy2lsZFL+ePa13i6UObBLXsfyWdBlzvFMzMf6FzTBVtScR+POkGkIbuWARc6l1t8ES6iSWhvfRRuM+TPpfmqNKCVaHulDZhLiIVI+QBvnlMR73fRpmjS3wrEfFAtoH4U3lk11c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=anszXl1y; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761925866; x=1793461866;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3JNm5w5PxMIzq/o+9F1WdKTFb+0BAFGDlT1t1PLX/6Y=;
  b=anszXl1ybMYqkpD3onMHd+xhMYRvZU6w3iyQeF3t4V3S69acsW5aSZ+2
   VCAFKyQV64slwq7w1uD7I2c10e4HCO9wrIQndGxNJMMkw15byQgwQcpl+
   Qn0+NTmRVJKySnfIKhYvIYenWwt96OBDbc0Vx6XZ2BjzsyGjPaf5Hmyo8
   Duaig1NOtdL0Wn/fTpW1Sj3yOb1rmeMiGzCYIG0LRnOaMGIr7Lz6F4Zmh
   +Aqm9RyMos8ik8OgyfwkkYIHVgRxYUqkB2CY5rE+MQvmWhzX+OocbOQ3C
   vDtGoccKv57SfifBa3FXLCdfJxge0WvXlhlCM/7D2mLSAG2vCdiLW90Oc
   A==;
X-CSE-ConnectionGUID: MmqKMIidTEy9EvcwLlNNiA==
X-CSE-MsgGUID: xvIXK14AQAa/XuLN7IGO/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11599"; a="89552627"
X-IronPort-AV: E=Sophos;i="6.19,269,1754982000"; 
   d="scan'208";a="89552627"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 08:51:05 -0700
X-CSE-ConnectionGUID: IOlYVB+0QK2CUd52NrAo0g==
X-CSE-MsgGUID: u5r3OQyyQ/yI8TfsjCmdzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,269,1754982000"; 
   d="scan'208";a="217103419"
Received: from cmdeoliv-mobl4.amr.corp.intel.com (HELO [10.125.110.52]) ([10.125.110.52])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 08:51:04 -0700
Message-ID: <a482fd68-ce54-472d-8df1-33d6ac9f6bb5@intel.com>
Date: Fri, 31 Oct 2025 08:51:03 -0700
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] x86/boot: Fix page table access in 5-level to
 4-level paging transition
To: Usama Arif <usamaarif642@gmail.com>, dwmw@amazon.co.uk,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, ardb@kernel.org, hpa@zytor.com
Cc: x86@kernel.org, apopple@nvidia.com, thuth@redhat.com,
 nik.borisov@suse.com, kas@kernel.org, linux-kernel@vger.kernel.org,
 linux-efi@vger.kernel.org, kernel-team@meta.com,
 Michael van der Westhuizen <rmikey@meta.com>, Tobias Fleig <tfleig@meta.com>
References: <20251028105637.769470-1-usamaarif642@gmail.com>
 <20251028105637.769470-2-usamaarif642@gmail.com>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <20251028105637.769470-2-usamaarif642@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/28/25 03:55, Usama Arif wrote:
> - native_read_cr3_pa(): Uses CR3_ADDR_MASK properly clearing SME encryption
>   bit and extracting only the physical address portion.

I guess we can apply these as-is. They do fix a bug.

But I find these descriptions a bit unsatisfying. CR3_ADDR_MASK happens
to work here on 64-bit. Interestingly enough, it wouldn't have been as
good of a fix on PAE paging because it ignores those upper bits instead
of reserving them.

But CR3_ADDR_MASK doesn't "extract... only the physical address
portion". It also extracts reserved bits.

It also doesn't mention the LAM bits. It's not just SME.

This would be better:

 - native_read_cr3_pa(): Uses CR3_ADDR_MASK to additionally mask
   metadata out of CR3 (like SME or LAM bits). All remaining bits are
   real address bits or reserved and must be 0.

> - mask pgd value with PTE_PFN_MASK instead of PAGE_MASK, accounting for
>   flags above physical address (_PAGE_BIT_NOPTISHADOW in particular).

This also isn't _quite_ right. The "flags above physical" address are
dynamic. They move because the max physical address (MAXPHYADDR) is
enumerated and changes from CPU to CPU.

It's OK in this case because moving MAXPHYADDR down just changes bits
from address bits to reserved (must be 0).

In a perfect world, we would construct a kexec CR3 with the dynamic
MAXPHYADDR (plus masking out the lower 12 bits). That would be obviously
correct for *all* 32-bit and 64-bit cases and wouldn't even rely on
knowing where the boundary is between ignored and reserved. The approach
in these patches is a fine improvement We don't need to be perfect.

Ideally this second bullet would be:

 - mask pgd value with PTE_PFN_MASK instead of PAGE_MASK, accounting for
   flags above bit 51 (_PAGE_BIT_NOPTISHADOW in particular). Bits below
   51, but above the max physical address are reserved and must be 0.

But it's fine-ish as-is.

Acked-by: Dave Hansen <dave.hansen@linux.intel.com>

