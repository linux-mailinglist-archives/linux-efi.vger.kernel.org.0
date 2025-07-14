Return-Path: <linux-efi+bounces-4336-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5877B03FFB
	for <lists+linux-efi@lfdr.de>; Mon, 14 Jul 2025 15:32:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22627189716A
	for <lists+linux-efi@lfdr.de>; Mon, 14 Jul 2025 13:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9675924EAAB;
	Mon, 14 Jul 2025 13:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eJ6meA0k"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C381142065;
	Mon, 14 Jul 2025 13:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752499703; cv=none; b=R4UcE9kMKJvnLQ4KXGFCnnys74GXgAJQZ3YRBnmD2abgC5+80aUN/tURDu1y2fmL+ADbitz+HmL74aDcbFkHg8UmeDO3ZnentqXwY9TjmbMURgcveXdjR3kv+s77uirS8vBuOZu6b7q+lkbqNSbh9TYy2zAD8brNjTT3BldF3h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752499703; c=relaxed/simple;
	bh=hTGIreXw8EF1eVT7un+ZiXPn8NihCxvEx0CPsOQIAf0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PMd6k38llDAYBjYyRKcw1vOxyY3dLzRcRewv+vCHn9WQIrtMGfqIbu1rGVH1TX9dEW0ln3P8dyjWjJGp8aGTuDJ35j8dfXiW+lvDjzg6/XslJaX+ucuM6H4xhWFzkOIM0Fro1gQkTtip0r51SCIkKAaB/mwDHhFQIu7vLADt97E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eJ6meA0k; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752499700; x=1784035700;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=hTGIreXw8EF1eVT7un+ZiXPn8NihCxvEx0CPsOQIAf0=;
  b=eJ6meA0kjhL4d/6Fo8e/2SxfdZovRqX3jxucX4oSZiA/BMfs3IlNngXR
   DMIC8Hbd8Y9XtsukQopSTrPT30qBoTTbl/JPcPSwjx1c7vZhy9JpH+Rg6
   8SVtXWOqj7DHy+YLe8Vf2URUlQWffvvO0bvO7Od4pi/R5kDvjsH70wpiF
   dmfMCGmSVcgqTJKlhA0gtdMWA9G6rLTX/YJqBHxEmXfFV/0AjK8cL8Zik
   Vo7qoEjfUyvaBUOOZtSZFoTxjkSVXlT6CzAEN+qu4qAU5qF/ABaBYI4/J
   J2a1pLVpwUVkLtGlVLHCsE953c4e9o+XBEI1E2zADvMuXNrtN1fk9eV1t
   A==;
X-CSE-ConnectionGUID: QjK5aEWTSs+uG5Np6KFQ2g==
X-CSE-MsgGUID: AinhMhl9TYOnUU2qxDSmtQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="58458067"
X-IronPort-AV: E=Sophos;i="6.16,311,1744095600"; 
   d="scan'208";a="58458067"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2025 06:28:17 -0700
X-CSE-ConnectionGUID: oIep/sphQa6tcp3Etdu9AQ==
X-CSE-MsgGUID: OU+RdU2qQk6H5dvDPMeRUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,311,1744095600"; 
   d="scan'208";a="156350428"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2025 06:28:15 -0700
Received: from [10.124.223.75] (unknown [10.124.223.75])
	by linux.intel.com (Postfix) with ESMTP id 5ADC120B571C;
	Mon, 14 Jul 2025 06:28:14 -0700 (PDT)
Message-ID: <89b6b1ba-4f55-4e54-a49d-7dcaddfd503f@linux.intel.com>
Date: Mon, 14 Jul 2025 06:28:14 -0700
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V6] efi/tpm: Fix the issue where the CC platforms event
 log header can't be correctly identified
To: yangge1116@126.com, ardb@kernel.org
Cc: jarkko@kernel.org, James.Bottomley@HansenPartnership.com,
 ilias.apalodimas@linaro.org, jgg@ziepe.ca, linux-efi@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, liuzixing@hygon.cn
References: <1752290685-22164-1-git-send-email-yangge1116@126.com>
Content-Language: en-US
From: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <1752290685-22164-1-git-send-email-yangge1116@126.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 7/11/25 8:24 PM, yangge1116@126.com wrote:
> From: Ge Yang <yangge1116@126.com>
>
> Since commit d228814b1913 ("efi/libstub: Add get_event_log() support
> for CC platforms") reuses TPM2 support code for the CC platforms, when
> launching a TDX virtual machine with coco measurement enabled, the
> following error log is generated:
>
> [Firmware Bug]: Failed to parse event in TPM Final Events Log
>
> Call Trace:
> efi_config_parse_tables()
>    efi_tpm_eventlog_init()
>      tpm2_calc_event_log_size()
>        __calc_tpm2_event_size()
>
> The pcr_idx value in the Intel TDX log header is 1, causing the function
> __calc_tpm2_event_size() to fail to recognize the log header, ultimately
> leading to the "Failed to parse event in TPM Final Events Log" error.
>
> Intel misread the spec and wrongly sets pcrIndex to 1 in the header and
> since they did this, we fear others might, so we're relaxing the header
> check. There's no danger of this causing problems because we check for
> the TCG_SPECID_SIG signature as the next thing.
>
> Fixes: d228814b1913 ("efi/libstub: Add get_event_log() support for CC platforms")
> Signed-off-by: Ge Yang <yangge1116@126.com>
> Cc: stable@vger.kernel.org
> ---
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>
> V6:
> - improve commit message suggested by James
>
> V5:
> - remove the pcr_index check without adding any replacement checks suggested by James and Sathyanarayanan
>
> V4:
> - remove cc_platform_has(CC_ATTR_GUEST_STATE_ENCRYPT) suggested by Ard
>
> V3:
> - fix build error
>
> V2:
> - limit the fix for CC only suggested by Jarkko and Sathyanarayanan
>
>   include/linux/tpm_eventlog.h | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/include/linux/tpm_eventlog.h b/include/linux/tpm_eventlog.h
> index 891368e..05c0ae5 100644
> --- a/include/linux/tpm_eventlog.h
> +++ b/include/linux/tpm_eventlog.h
> @@ -202,8 +202,7 @@ static __always_inline u32 __calc_tpm2_event_size(struct tcg_pcr_event2_head *ev
>   	event_type = event->event_type;
>   
>   	/* Verify that it's the log header */
> -	if (event_header->pcr_idx != 0 ||
> -	    event_header->event_type != NO_ACTION ||
> +	if (event_header->event_type != NO_ACTION ||
>   	    memcmp(event_header->digest, zero_digest, sizeof(zero_digest))) {
>   		size = 0;
>   		goto out;

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


