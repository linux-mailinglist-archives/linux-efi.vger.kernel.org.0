Return-Path: <linux-efi+bounces-468-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B352849056
	for <lists+linux-efi@lfdr.de>; Sun,  4 Feb 2024 21:28:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC41AB21B9B
	for <lists+linux-efi@lfdr.de>; Sun,  4 Feb 2024 20:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FA282561F;
	Sun,  4 Feb 2024 20:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GBn5Ddon"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BBF625622;
	Sun,  4 Feb 2024 20:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707078483; cv=none; b=qiSMRKMNC2+LQcTHPkTaTBTb4kw1clN6F5X0lgDl2aA9N2RxgWduqIPlmujbjkwAVlwrJuXuS8gH9Wn57bK5CgpOiPWVNMj+i+EX0YcEyOQviRItd8ckgcF3WI09qccFgshaLxe96p4BrJ3T71TQlapggK6S2saS5jGDh5Y8MzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707078483; c=relaxed/simple;
	bh=pYUDma7IeNGn5sB0DMsKBMM7M0vpq2RmkTAySdwqiIE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nNz1PizMfxv5bcZncFp/07OYpGPpKD9KAvoe62h4bSdNZ+TNgls/neyIKuVTg7P7oInHiItQyr/IU5ns00pBlL071WJE3BH0vZmnzwUppQyhtk7ctVuQzwRSjmZIvuUp9x9Pzzjra6Ryv4QNbQGuVPu/nwLzu9pLGqC5BX5xX60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GBn5Ddon; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707078481; x=1738614481;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=pYUDma7IeNGn5sB0DMsKBMM7M0vpq2RmkTAySdwqiIE=;
  b=GBn5Ddon6IYh7nSYE0umg5jhZSJS7avPinYl+hA/n7NQS1WaUMN4NQTA
   LatmrEfVZPim9LRhTBtfx9yFNFgy1ZIiHkk4KTDwrfRDr2GW5S3JBPXmf
   I0hNRCbeqp30yjmwgIl0p/sQF3Ep25YncIYQh+ESqoR8s9KPu0pPrp/87
   YBoR7FyPSHRJx70pqk2E71rNQeAFNevjbupZqDyfR89hOF/xTxH+njLbq
   RvS3+yKIAMrWOTJAsjVRg7K+0RBKpJwvc02XHXoqZ/Bd7eSSxsAKJKbjE
   5SeDod4vDaHlRueb4U+TkhVLDmBlyygFxRIZMU1FqgE1lqqCPO9or1+O+
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10973"; a="25864383"
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="25864383"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2024 12:28:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10973"; a="909116928"
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="909116928"
Received: from cluevan6-mobl.amr.corp.intel.com (HELO [10.209.72.230]) ([10.209.72.230])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2024 12:28:00 -0800
Message-ID: <6a696340-b57c-4fa5-bb2e-b3a0257453bc@linux.intel.com>
Date: Sun, 4 Feb 2024 12:27:59 -0800
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] efi/libstub: Add Confidential Computing (CC)
 measurement support
Content-Language: en-US
To: James Bottomley <James.Bottomley@HansenPartnership.com>,
 Ard Biesheuvel <ardb@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
 "Yao, Jiewen" <jiewen.yao@intel.com>, "Lu, Ken" <ken.lu@intel.com>
References: <20240203075736.3982371-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <82a84e769875c70279348179c1b2b63a16770c8e.camel@HansenPartnership.com>
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <82a84e769875c70279348179c1b2b63a16770c8e.camel@HansenPartnership.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

+Jiewen & Ken (RTMR firmware owner)

On 2/3/24 10:46 PM, James Bottomley wrote:
> On Sat, 2024-02-03 at 07:57 +0000, Kuppuswamy Sathyanarayanan wrote:
>> If the virtual firmware implements TPM support, TCG2 protocol will be
>> used for kernel measurements and event logging support. But in CC
>> environment, not all platforms support or enable the TPM feature.
>> UEFI specification [1] exposes protocol and interfaces used for
>> kernel measurements in CC platforms without TPM support.
>>
>> Currently, the efi-stub only supports the kernel related measurements
>> for the platform that supports TCG2 protocol. So, extend it add
>> CC measurement protocol (EFI_CC_MEASUREMENT_PROTOCOL) and event
>> logging support. Event logging format in the CC environment is the
>> same as TCG2.
> Why do we have to do this anymore?  Given that you're already pushing
> patches that map RTMRs to TPM PCRs:
>
> https://lore.kernel.org/lkml/20240128212532.2754325-4-sameo@rivosinc.com/

IMHO, I am not sure whether we need this mapping support . I have already
mentioned the same comment in [1]. If we support extension and logging
via configFS ABI, why again support PCR mapping?

https://lore.kernel.org/lkml/2bd7c80b-9cd8-4450-a410-c3739d224167@linux.intel.com/ [1]

>
> Can't you just add a stub TCG2 driver to EFI that exposes only the
> ability to log and measure using this mapping?  That way all our
> existing code will "just work" without the need to understand anything
> about confidential computing or add new code to do the measurement?

I am not familiar with the EFI implementation, but I think a new protocol
is added to handle future CC extensions (which could deviate from
TCG2) and to support platforms that does not support or enable TPM
feature. So modifying the TCG2 driver in EFI may not work for the
above-mentioned cases. I think the EFI driver part of this support
is already merged.

Jiewen/Ken may have more comments about this proposal.

>
> James
>
-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


