Return-Path: <linux-efi+bounces-732-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1A26872987
	for <lists+linux-efi@lfdr.de>; Tue,  5 Mar 2024 22:39:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 577D91F263B6
	for <lists+linux-efi@lfdr.de>; Tue,  5 Mar 2024 21:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8560A12AAE2;
	Tue,  5 Mar 2024 21:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fCQhThiM"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2DF9128817
	for <linux-efi@vger.kernel.org>; Tue,  5 Mar 2024 21:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709674754; cv=none; b=LH4VzWVVa0Lgg2vzGoSfmesZFLkahj+qUpE/PtPUIeAKj8HiC+98PkO6JSYMvPGlCVF5Imaa43qMyCqhsa8uDUX2dxK3KP17R8iIwM1LIA+FeaLVgGy8rmNdJcIXr4EYZ7l8xRvGzqLB0CAlqfNyQRw/iQ5aAVPHOY825ly7UIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709674754; c=relaxed/simple;
	bh=w6xvuqRo8he8F3d7ine0yJdo6geivq+HrU7aylu1zsU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YqJGTumD6KD2KQbJQQX3PknUxYSy6IONbjHUKqA9V/7CtHy1065VYkK+4ja6MAMZC/yOvKz8MEHTBk8IVieKBEPVLUJfbR1H4irBTSMDaPAWxJhTAy9/zIj3NwgfDk5ePxqiy9B+Z+r39Ufd+AwpXh1/+vbdXrZyf3g6RDkeLes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fCQhThiM; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709674753; x=1741210753;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=w6xvuqRo8he8F3d7ine0yJdo6geivq+HrU7aylu1zsU=;
  b=fCQhThiMJQyc/eRI1CrMH81GB24CTYUiaqoB1PVexAfl1DCBPnynBzgv
   SE7LIcVrRjeAFW15t2U5Rj0qR5C9PY8xC0/nB1cjxaymojKpSAUCaY1jh
   /PM92hqgE4551LHsunXkksuJLhqMAOqhnOYXSerITdE/sPmfN9Y6GkLWO
   TJ+o16jMljnMrSV4zPD5yWkf3ot+DUX+2Vl/gGtGH4LYG6HrYdeC8EUG5
   OgOPXGnpaTnsw96vBqtdOgOxKW4kDtn06iOiCV/kwlpHuS4+VM1ORVDek
   s7njL5GXYcn+d5YQSL573VVZKIFicBWESRppzvdzG74oJ4CSRor2repX1
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="21713788"
X-IronPort-AV: E=Sophos;i="6.06,206,1705392000"; 
   d="scan'208";a="21713788"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 13:39:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,206,1705392000"; 
   d="scan'208";a="9382272"
Received: from msavchak-mobl.amr.corp.intel.com (HELO [10.209.19.134]) ([10.209.19.134])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 13:39:12 -0800
Message-ID: <ca82210c-ba17-4b91-aa97-9806459f1e11@linux.intel.com>
Date: Tue, 5 Mar 2024 13:39:11 -0800
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] efi/libstub: Measure into CC protocol if TCG2
 protocol is absent
Content-Language: en-US
To: Ard Biesheuvel <ardb+git@google.com>, linux-efi@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20240304104409.2326422-6-ardb+git@google.com>
 <20240304104409.2326422-9-ardb+git@google.com>
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20240304104409.2326422-9-ardb+git@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 3/4/24 2:44 AM, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
>
> To accommodate confidential compute VMs that expose the simplified CC
> measurement protocol instead of the full-blown TCG2 one, fall back to
> the former if the latter does not exist.
>
> The CC protocol was designed to be used in this manner, which is why the
> types and prototypes have been kept the same where possible. So reuse
> the existing code, and only deviate from the TCG2 code path where
> needed.
>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---

Looks fine to me.

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>  drivers/firmware/efi/libstub/efi-stub-helper.c | 67 +++++++++++++++-----
>  drivers/firmware/efi/libstub/efistub.h         |  3 +
>  2 files changed, 53 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
> index 0dbc9d3f4abd..21f4567324f6 100644
> --- a/drivers/firmware/efi/libstub/efi-stub-helper.c
> +++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
> @@ -223,44 +223,77 @@ static efi_status_t efi_measure_tagged_event(unsigned long load_addr,
>  					     unsigned long load_size,
>  					     enum efistub_event_type event)
>  {
> +	union {
> +		efi_status_t
> +		(__efiapi *hash_log_extend_event)(void *, u64, efi_physical_addr_t,
> +						  u64, const union efistub_event *);
> +		struct { u32 hash_log_extend_event; } mixed_mode;
> +	} method;
>  	struct efistub_measured_event *evt;
>  	int size = struct_size(evt, tagged_event_data,
>  			       events[event].event_data_len);
>  	efi_guid_t tcg2_guid = EFI_TCG2_PROTOCOL_GUID;
>  	efi_tcg2_protocol_t *tcg2 = NULL;
> +	union efistub_event ev;
>  	efi_status_t status;
> +	void *protocol;
>  
>  	efi_bs_call(locate_protocol, &tcg2_guid, NULL, (void **)&tcg2);
>  	if (tcg2) {
> -		status = efi_bs_call(allocate_pool, EFI_LOADER_DATA, size,
> -				     (void **)&evt);
> -		if (status != EFI_SUCCESS)
> -			goto fail;
> -
> -		evt->event_data.tcg2_data = (struct efi_tcg2_event){
> +		ev.tcg2_data = (struct efi_tcg2_event){
>  			.event_size			= size,
> -			.event_header.header_size	= sizeof(evt->event_data.tcg2_data.event_header),
> +			.event_header.header_size	= sizeof(ev.tcg2_data.event_header),
>  			.event_header.header_version	= EFI_TCG2_EVENT_HEADER_VERSION,
>  			.event_header.pcr_index		= events[event].pcr_index,
>  			.event_header.event_type	= EV_EVENT_TAG,
>  		};
> +		protocol = tcg2;
> +		method.hash_log_extend_event =
> +			(void *)efi_table_attr(tcg2, hash_log_extend_event);
> +	} else {
> +		efi_guid_t cc_guid = EFI_CC_MEASUREMENT_PROTOCOL_GUID;
> +		efi_cc_protocol_t *cc = NULL;
>  
> -		evt->tagged_event_id		= events[event].event_id;
> -		evt->tagged_event_data_size	= events[event].event_data_len;
> -
> -		memcpy(evt->tagged_event_data, events[event].event_data,
> -		       events[event].event_data_len);
> +		efi_bs_call(locate_protocol, &cc_guid, NULL, (void **)&cc);
> +		if (!cc)
> +			return EFI_UNSUPPORTED;
>  
> -		status = efi_call_proto(tcg2, hash_log_extend_event, 0,
> -					load_addr, load_size, &evt->event_data.tcg2_data);
> -		efi_bs_call(free_pool, evt);
> +		ev.cc_data = (struct efi_cc_event){
> +			.event_size			= size,
> +			.event_header.header_size	= sizeof(ev.cc_data.event_header),
> +			.event_header.header_version	= EFI_CC_EVENT_HEADER_VERSION,
> +			.event_header.event_type	= EV_EVENT_TAG,
> +		};
>  
> +		status = efi_call_proto(cc, map_pcr_to_mr_index,
> +					events[event].pcr_index,
> +					&ev.cc_data.event_header.mr_index);
>  		if (status != EFI_SUCCESS)
>  			goto fail;
> -		return EFI_SUCCESS;
> +
> +		protocol = cc;
> +		method.hash_log_extend_event =
> +			(void *)efi_table_attr(cc, hash_log_extend_event);
>  	}
>  
> -	return EFI_UNSUPPORTED;
> +	status = efi_bs_call(allocate_pool, EFI_LOADER_DATA, size, (void **)&evt);
> +	if (status != EFI_SUCCESS)
> +		goto fail;
> +
> +	evt->event_data			= ev;
> +	evt->tagged_event_id		= events[event].event_id;
> +	evt->tagged_event_data_size	= events[event].event_data_len;
> +
> +	memcpy(evt->tagged_event_data, events[event].event_data,
> +	       events[event].event_data_len);
> +
> +	status = efi_fn_call(&method, hash_log_extend_event, protocol, 0,
> +			     load_addr, load_size, &evt->event_data);
> +	efi_bs_call(free_pool, evt);
> +
> +	if (status == EFI_SUCCESS)
> +		return EFI_SUCCESS;
> +
>  fail:
>  	efi_warn("Failed to measure data for event %d: 0x%lx\n", event, status);
>  	return status;
> diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
> index d621bfb719c4..4bf9a76796b7 100644
> --- a/drivers/firmware/efi/libstub/efistub.h
> +++ b/drivers/firmware/efi/libstub/efistub.h
> @@ -954,8 +954,11 @@ union efi_cc_protocol {
>  	} mixed_mode;
>  };
>  
> +static_assert(sizeof(efi_tcg2_event_t) == sizeof(efi_cc_event_t));
> +
>  union efistub_event {
>  	efi_tcg2_event_t	tcg2_data;
> +	efi_cc_event_t		cc_data;
>  };
>  
>  struct efistub_measured_event {

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


