Return-Path: <linux-efi+bounces-727-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D8E9872787
	for <lists+linux-efi@lfdr.de>; Tue,  5 Mar 2024 20:27:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C6AF1F26483
	for <lists+linux-efi@lfdr.de>; Tue,  5 Mar 2024 19:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A89C24B29;
	Tue,  5 Mar 2024 19:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FRBy/kfR"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593A81AADC
	for <linux-efi@vger.kernel.org>; Tue,  5 Mar 2024 19:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709666842; cv=none; b=o7rjqiH7fgnd/Hh0AyrYUEI51YDKf4SEt7hNOgCkFWXXPU0W23GKTWixdXQNXih9ISdYZEtSH8W0ngNSnANuyGOzTuW4qecx6iFKD9XJZcTi5Q2KWwBGmoItym/YR3QmXPXeolyx/42E8eTXVbtL65gflDLljecswPx88cBJcOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709666842; c=relaxed/simple;
	bh=Zni/cf8KvsWjDQn8YGl+bWHkvz1TC/f4VV7qX1dXOio=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DTe6UdQWCbzwkGFPSr6vUvkM0eJ723fcwB3+UbBLySpgDkArz/Mum72TSZ4uG6vjoqbqT/l6aGFHgyVvbW1i3q3W077sIMx30iAeQfGsktmC7vlRpZnXBEpJdJ+b4PleyYZfVtQidRHQCWtUmk4oCGZFsRl/JxzBhQ4bTjRDPc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FRBy/kfR; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709666841; x=1741202841;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Zni/cf8KvsWjDQn8YGl+bWHkvz1TC/f4VV7qX1dXOio=;
  b=FRBy/kfRgCacleKDB6wfeqqGIMwHp/B5CY1gbJ0PPFPT2MZgLoY1E89F
   yRuQu03qpJFMD+VpqHxqR3fmgZJM3tllDMpUJEvNM2EWuz/5OXG3xgh5/
   Pr4/kLc4CQhKQulFCrpVOjBmpiYJVhNKdVRgug/ft0bPbohlJ/eLxMm7D
   +ds/RP1VXgKRvnOulUsBOeeu7MBZKkbepavJ4r5MqVzUeyy2gdMa5cCkG
   wKMA7unbOSp5gu9B1OEmmJDxrz77r0dAtfjfk3yBzCDPQ9KmOUAoFrZvS
   rIt+Ho20JJNU35b6f57RGUXIU5mBd1zdoyV72OrkjfcTNMimMG8MsIFZk
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="4104792"
X-IronPort-AV: E=Sophos;i="6.06,206,1705392000"; 
   d="scan'208";a="4104792"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 11:27:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,206,1705392000"; 
   d="scan'208";a="13970818"
Received: from msavchak-mobl.amr.corp.intel.com (HELO [10.209.19.134]) ([10.209.19.134])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 11:27:20 -0800
Message-ID: <1425355b-d3b8-4066-acd9-aba5067d4afa@linux.intel.com>
Date: Tue, 5 Mar 2024 11:27:19 -0800
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] efi/libstub: Add Confidential Computing (CC)
 measurement typedefs
Content-Language: en-US
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Ard Biesheuvel <ardb+git@google.com>
Cc: linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
References: <20240304104409.2326422-6-ardb+git@google.com>
 <20240304104409.2326422-8-ardb+git@google.com>
 <CAC_iWjKeKBd3O-i8Lodv4m5e8n=0Bss0N_mjc+jCj2QNgmaQzA@mail.gmail.com>
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <CAC_iWjKeKBd3O-i8Lodv4m5e8n=0Bss0N_mjc+jCj2QNgmaQzA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 3/5/24 10:00 AM, Ilias Apalodimas wrote:
> Hi Ard,
>
> On Mon, 4 Mar 2024 at 12:44, Ard Biesheuvel <ardb+git@google.com> wrote:
>> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>>
>> If the virtual firmware implements TPM support, TCG2 protocol will be
>> used for kernel measurements and event logging support. But in CC
>> environment, not all platforms support or enable the TPM feature. UEFI
>> specification [1] exposes protocol and interfaces used for kernel
>> measurements in CC platforms without TPM support.
>>
>> More details about the EFI CC measurements and logging can be found
>> in [1].
>>
>> Link: https://uefi.org/specs/UEFI/2.10/38_Confidential_Computing.html#efi-cc-measurement-protocol [1]
>> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>> [ardb: Drop code changes, keep typedefs and #define's only]
>> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>> ---
>>  drivers/firmware/efi/libstub/efistub.h | 79 ++++++++++++++++++++
>>  include/linux/efi.h                    |  1 +
>>  2 files changed, 80 insertions(+)
>>
> [...]
>
>> +
>> +struct efi_cc_event {
>> +       u32 event_size;
>> +       struct {
>> +               u32 header_size;
>> +               u16 header_version;
>> +               u32 mr_index;
>> +               u32 event_type;
>> +       } __packed event_header;
>> +       u8 event_data[0];
> We should define this as a flexible array member instead of a zero-length array?
> The spec is funny and defines this as event_data[1]. I think we aren't
> using the sizeof(struct efi_cc_event) anywhere, so if this struct is
> not used as a member of another struct or an array we can omit it
> entirely.

Flexible array is also fine or we can just add a comment like "u8[] event follows here"
like in struct efi_tcg2_event .

>
> [...]
>
> Cheers
> /Ilias

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


