Return-Path: <linux-efi+bounces-4296-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C602FB0291E
	for <lists+linux-efi@lfdr.de>; Sat, 12 Jul 2025 05:25:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D31D51C47CA5
	for <lists+linux-efi@lfdr.de>; Sat, 12 Jul 2025 03:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E5551C07C3;
	Sat, 12 Jul 2025 03:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="VVrc81ls"
X-Original-To: linux-efi@vger.kernel.org
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.6])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B097E25634;
	Sat, 12 Jul 2025 03:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752290746; cv=none; b=FccSWirWusWw/BgjuY9zgj83OQfvMmTvvlfQNSxCAwyD0WzDGhbSvYZCAn43AaNIWC4Sa0rKLOJ1D3PQcnC4n+FMm9bSthgY0jQ3UKF6l4d8r06PA6EC0YN6fE22VwrA9+0VjBPjXjFIlSuJg6BuOFrxOkRokzQH77RszmvM3Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752290746; c=relaxed/simple;
	bh=MJWg3034T78GUrqUJrFN3kXBcUD+xvJ7hZxnjCP+zx0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AGj+kpxvpHA4o/WYC2bl+A8XIY0ImVucswXsaleVf8H2q5XLqcPOe3Z6Ecc0QkWvR28nQFta+fMWhLr8rSA7Zxx2LTZz1DAbWspOvucc4qdqVAGyLQTjPBxtNdQoBin6dJcd0lAaIBAAxm5VHw2FpdH/Y2u1n6MDFDDBIXtZitg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=VVrc81ls; arc=none smtp.client-ip=117.135.210.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=aV47un9oUhptwr2YiRT6wkuIv6+2RaKk1/m5Xmf09SM=;
	b=VVrc81lsDCLGmT9Np7g3DFFHl1QvKNbTFcUZeFypSy9BtIMYMCTBBmAHLSBmtK
	7NwTwoBDgxwr6sYRpstuhIFOpJJT9sJrpW1p3c6hOJJRkMEnEl7vUsBKbBKIu67w
	75kToBHfpP4SWjoPq/Q2IWwL2+k6BoTEiuKu72TLZbnfI=
Received: from [172.19.20.199] (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wD3J0tp1XFo0GmhAA--.13942S2;
	Sat, 12 Jul 2025 11:24:26 +0800 (CST)
Message-ID: <f43764cd-597b-487f-878b-a071df12f414@126.com>
Date: Sat, 12 Jul 2025 11:24:25 +0800
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5] efi/tpm: Fix the issue where the CC platforms event
 log header can't be correctly identified
To: James Bottomley <James.Bottomley@HansenPartnership.com>, ardb@kernel.org
Cc: jarkko@kernel.org, sathyanarayanan.kuppuswamy@linux.intel.com,
 ilias.apalodimas@linaro.org, jgg@ziepe.ca, linux-efi@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, liuzixing@hygon.cn
References: <1752288950-21813-1-git-send-email-yangge1116@126.com>
 <31d1da85f3ec863d16f4bcb173dab687efd6ceed.camel@HansenPartnership.com>
From: Ge Yang <yangge1116@126.com>
In-Reply-To: <31d1da85f3ec863d16f4bcb173dab687efd6ceed.camel@HansenPartnership.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3J0tp1XFo0GmhAA--.13942S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7urWUJw4DZr17ArW8KrWrAFb_yoW8Gw4rp3
	ZrAF1Svas5KF1Sv3sFqw1j9a12yrWvyayDArykJ340yFn8Wr92qFWYka45Ga9xWa1UKa95
	Xa40qr1xta4j9FJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jbmiiUUUUU=
X-CM-SenderInfo: 51dqwwjhrrila6rslhhfrp/1tbiOh2IG2hxxUDrEwABsR



在 2025/7/12 11:03, James Bottomley 写道:
> On Sat, 2025-07-12 at 10:55 +0800, yangge1116@126.com wrote:
>> From: Ge Yang <yangge1116@126.com>
>>
>> Since commit d228814b1913 ("efi/libstub: Add get_event_log() support
>> for CC platforms") reuses TPM2 support code for the CC platforms,
>> when launching a TDX virtual machine with coco measurement enabled,
>> the following error log is generated:
>>
>> [Firmware Bug]: Failed to parse event in TPM Final Events Log
>>
>> Call Trace:
>> efi_config_parse_tables()
>>    efi_tpm_eventlog_init()
>>      tpm2_calc_event_log_size()
>>        __calc_tpm2_event_size()
>>
>> The pcr_idx value in the Intel TDX log header is 1, causing the
>> function __calc_tpm2_event_size() to fail to recognize the log
>> header, ultimately leading to the "Failed to parse event in TPM Final
>> Events Log" error.
>>
>> According to UEFI Specification 2.10, Section 38.4.1: For TDX, TPM
>> PCR 0 maps to MRTD, so the log header uses TPM PCR 1 instead.
> 
> This isn't a justification ... Intel just screwed up.  Whatever the
> UEFI spec says about PCR mapping, the log spec the TCG produces
> requires the header event to have a pcrIndex of 0 and, since it isn't
> recorded in a PCR, it doesn't matter what the mapping is.
> 
> Just say Intel misread the spec and wrongly sets pcrIndex to 1 in the
> header and since they did this, we fear others might, so we're relaxing
> the header check.
> 

OK, thanks.


> Regards,
> 
> James


