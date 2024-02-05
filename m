Return-Path: <linux-efi+bounces-484-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE2C884A7D8
	for <lists+linux-efi@lfdr.de>; Mon,  5 Feb 2024 22:43:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 894CA293B22
	for <lists+linux-efi@lfdr.de>; Mon,  5 Feb 2024 21:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F104130E37;
	Mon,  5 Feb 2024 20:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J8hT8ZOU"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30D0130E34;
	Mon,  5 Feb 2024 20:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707164024; cv=none; b=fPFwNoNS2f7/yctmA0JdhqQCraV5s9PlDLarjaW+22+vv7OOfFwuUH2CZuqYPalWgvX41X/N+i/01TxEH+/PzXtkuwke17+hs/L1Rp/YwWkPIqiFMQQoFp21TFzJiQPYt8CoCpWd7fbe0ibGdNyWR+xgptqOZ53WviqqcbtyAtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707164024; c=relaxed/simple;
	bh=2yih0opNne/Q0VVz8BpBMmldQxIFKnPYj/oBNJL89CI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TC2IToofSjkQcdX5+SMdHpNHsI9CZk9gcNammkFfHDNZzbengNsyf3jb34c7PAcIJH9opK24rxc36/8W20z3QxLMyjt9e0P120UgUYjBpm+DlOd+K3bgVMO4zratEAcP1tOwyKnJkFqRagmDircvMZoUCkkPnUvZBOPp7p4E3ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J8hT8ZOU; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707164022; x=1738700022;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2yih0opNne/Q0VVz8BpBMmldQxIFKnPYj/oBNJL89CI=;
  b=J8hT8ZOUU0hkeB+oEzJFa1u6pFycEbnvGZKv4pURmtf+BcoDedtW65kC
   yBDxp+Uxi1KKk/vvFH/fqkzmCrQgOccD9w+Q5iOxwp9XcuXyz6NfSGm9y
   RSXvAEASoxS3+dI7I/NoLhvAH8SNqxAwJ87smuzd2XWhZoxapty6EL3wM
   +4PdEJsJ4WZhB0jS1MFx6/vIHgraFF4oJyy+WzddJhFFLRJQ0xneC3u1G
   6f5IYS4B7QPmUspnPWbvIj6K9k2oxMYV50cwytihU4Hqnyhoc3dYm8IS4
   LbQc9auBxWI9uyOjqLad9O9RabEMU19TvkKF71RaqJiYkilbIfS2uDoqT
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="751228"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="751228"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 12:13:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="909394756"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="909394756"
Received: from vmsundar-mobl.amr.corp.intel.com (HELO [10.251.2.9]) ([10.251.2.9])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 12:13:41 -0800
Message-ID: <7241153a-626d-4ea5-ab9e-d6842b662064@linux.intel.com>
Date: Mon, 5 Feb 2024 12:13:40 -0800
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
To: Ard Biesheuvel <ardb@kernel.org>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>,
 linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
 "Yao, Jiewen" <jiewen.yao@intel.com>, "Lu, Ken" <ken.lu@intel.com>
References: <20240203075736.3982371-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <82a84e769875c70279348179c1b2b63a16770c8e.camel@HansenPartnership.com>
 <6a696340-b57c-4fa5-bb2e-b3a0257453bc@linux.intel.com>
 <CAMj1kXF_02CO9C61N4uL6Z03Gtf5VmiqoCbk8beL4vd4PDHc0w@mail.gmail.com>
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <CAMj1kXF_02CO9C61N4uL6Z03Gtf5VmiqoCbk8beL4vd4PDHc0w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 2/4/24 2:03 PM, Ard Biesheuvel wrote:
> On Sun, 4 Feb 2024 at 21:28, Kuppuswamy Sathyanarayanan
> <sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>> +Jiewen & Ken (RTMR firmware owner)
>>
>> On 2/3/24 10:46 PM, James Bottomley wrote:
>>> On Sat, 2024-02-03 at 07:57 +0000, Kuppuswamy Sathyanarayanan wrote:
>>>> If the virtual firmware implements TPM support, TCG2 protocol will be
>>>> used for kernel measurements and event logging support. But in CC
>>>> environment, not all platforms support or enable the TPM feature.
>>>> UEFI specification [1] exposes protocol and interfaces used for
>>>> kernel measurements in CC platforms without TPM support.
>>>>
>>>> Currently, the efi-stub only supports the kernel related measurements
>>>> for the platform that supports TCG2 protocol. So, extend it add
>>>> CC measurement protocol (EFI_CC_MEASUREMENT_PROTOCOL) and event
>>>> logging support. Event logging format in the CC environment is the
>>>> same as TCG2.
>>> Why do we have to do this anymore?  Given that you're already pushing
>>> patches that map RTMRs to TPM PCRs:
>>>
>>> https://lore.kernel.org/lkml/20240128212532.2754325-4-sameo@rivosinc.com/
>> IMHO, I am not sure whether we need this mapping support . I have already
>> mentioned the same comment in [1]. If we support extension and logging
>> via configFS ABI, why again support PCR mapping?
>>
>> https://lore.kernel.org/lkml/2bd7c80b-9cd8-4450-a410-c3739d224167@linux.intel.com/ [1]
>>
>>> Can't you just add a stub TCG2 driver to EFI that exposes only the
>>> ability to log and measure using this mapping?  That way all our
>>> existing code will "just work" without the need to understand anything
>>> about confidential computing or add new code to do the measurement?
>> I am not familiar with the EFI implementation, but I think a new protocol
>> is added to handle future CC extensions (which could deviate from
>> TCG2) and to support platforms that does not support or enable TPM
>> feature. So modifying the TCG2 driver in EFI may not work for the
>> above-mentioned cases. I think the EFI driver part of this support
>> is already merged.
>>
>> Jiewen/Ken may have more comments about this proposal.
>>
> I don't think it is sufficient to wire up the CC protocol here. There
> is more code in drivers/firmware/efi/libstub/tpm.c that deals with the
> event log.
>
> Given that the EFI CC protocol was specifically designed to act as a
> substitute for the TCG2 protocol, I would expect all occurrences of
> TCG2 protocol invocations to be handled accordingly.
>
> So I think the approach here should be to provide a local wrapper
> around get_event_log() and hash_log_extend_event() that is backed by
> either the TCG2 protocol of the EFI cc protocol, and all current
> callers invoke this wrapper rather than the TCG2 protocol directly.
Ah, I missed that part. Thanks for pointing out. I will fix this in
next version.

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


