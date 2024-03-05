Return-Path: <linux-efi+bounces-726-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57AA0872769
	for <lists+linux-efi@lfdr.de>; Tue,  5 Mar 2024 20:19:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39D281C23FC4
	for <lists+linux-efi@lfdr.de>; Tue,  5 Mar 2024 19:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52CAD23758;
	Tue,  5 Mar 2024 19:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q7mXfyKT"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7D922F0C
	for <linux-efi@vger.kernel.org>; Tue,  5 Mar 2024 19:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709666356; cv=none; b=LYKh/XENcf7+EcTeXGrw901Qh7sE20mxlrBk1S/ugJeocDwoscFXiA/yLff5bNX7ej+TTeIT8GrQlnR8VWNFtTQjxd86lhQiyAJDmaCS2ebnk/11ewDzy8d0PvF4f3Lc7JzqtOYF/ssGKC64mpTAPPTAcWJ4uuVoINmX4LjNJ/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709666356; c=relaxed/simple;
	bh=0MPyOdWhjrRfb7U4lRC/BNGzX8U3BYxkzyZ+jCz27HQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lkSYW7+s4wSJ1kBFSVPfl7n+ghoT4dOgduor+4IrkJpxYbKmEHK1VrAU3y8qanpwJcSNGLrViyZNKqIjYEVQwiMJOI5PyFNk/P53UPQuA5OoFSsfmG6XdEl0nA7C9mdnID8KUulBNb/RbJkt58WH/Rplsv2H0p7Ic6Smmw+iLtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q7mXfyKT; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709666355; x=1741202355;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0MPyOdWhjrRfb7U4lRC/BNGzX8U3BYxkzyZ+jCz27HQ=;
  b=Q7mXfyKTp3HvfGSz6XlCqb28ub1Ckx/beXSkvzKRvd3+oRrD9TVbOtMt
   4nJTlc25MGoBqRMJcjvA1w8a/Qnk7Bq/ZfJ1ovSLE7SJBGP5kzKLrnY8t
   WcCfuFtdVjqK/Z0TKEP0HXgyWYDk4sQD7WqZKOk+obpWNff5W3bd2EnbL
   3JZrSKTuiKU/OR4wlGcWSHJ/dxGsPlFdnjv0o5GOvWcYHbSSCrXVm3nRC
   SiId+dyGPVZB+1qr9QzYY3GfgbNNWouK007cm+TxM5izyftJYmxFXvBI+
   FnKuNDJVCAY8MxgRC2pVZzKdXw5sxagSRyYVtOWrHentqK4en1DcA92KJ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="26703045"
X-IronPort-AV: E=Sophos;i="6.06,206,1705392000"; 
   d="scan'208";a="26703045"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 11:19:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,206,1705392000"; 
   d="scan'208";a="14156786"
Received: from msavchak-mobl.amr.corp.intel.com (HELO [10.209.19.134]) ([10.209.19.134])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 11:19:14 -0800
Message-ID: <e48f01c3-c417-4826-bbbf-bc9b85df7dca@linux.intel.com>
Date: Tue, 5 Mar 2024 11:19:13 -0800
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] efi/libstub: Fold efi_tcg2_tagged_event into
 efi_measured_event
Content-Language: en-US
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-efi@vger.kernel.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20240304104409.2326422-6-ardb+git@google.com>
 <20240304104409.2326422-7-ardb+git@google.com>
 <8a0cdc16-c300-44ed-af8c-559bbe7aa95b@linux.intel.com>
 <CAMj1kXHvzS6w8gmaSHiu13__uP95AUJxMXBVnOGFB6Tt1+ocfA@mail.gmail.com>
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <CAMj1kXHvzS6w8gmaSHiu13__uP95AUJxMXBVnOGFB6Tt1+ocfA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 3/5/24 12:21 AM, Ard Biesheuvel wrote:
> On Tue, 5 Mar 2024 at 05:30, Kuppuswamy Sathyanarayanan
> <sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>>
>> On 3/4/24 2:44 AM, Ard Biesheuvel wrote:
>>> From: Ard Biesheuvel <ardb@kernel.org>
>>>
>>> In spite of the efi_ prefix, struct efi_tcg2_tagged_event is specific to
>>> the EFI stub, and so we can tweak it to our liking if needed, e.g., to
>>> accommodate the TDX variant of the TCG2 measurement protocol.
>>>
>>> In preparation for that, get rid of it entirely, and combine it with the
>>> efi_measured_event struct used by the measurement code.
>>>
>>> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>>> ---

With nits fixed,

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

>>>  drivers/firmware/efi/libstub/efi-stub-helper.c | 26 ++++++++------------
>>>  drivers/firmware/efi/libstub/efistub.h         | 18 ++++++++------
>>>  2 files changed, 21 insertions(+), 23 deletions(-)
>>>
>>> diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
>>> index bfa30625f5d0..0dbc9d3f4abd 100644
>>> --- a/drivers/firmware/efi/libstub/efi-stub-helper.c
>>> +++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
>>> @@ -193,7 +193,7 @@ void efi_apply_loadoptions_quirk(const void **load_options, u32 *load_options_si
>>>       *load_options_size = load_option_unpacked.optional_data_size;
>>>  }
>>>
>>> -enum efistub_event {
>>> +enum efistub_event_type {
>>>       EFISTUB_EVT_INITRD,
>>>       EFISTUB_EVT_LOAD_OPTIONS,
>>>       EFISTUB_EVT_COUNT,
>>> @@ -221,44 +221,38 @@ static const struct {
>>>
>>>  static efi_status_t efi_measure_tagged_event(unsigned long load_addr,
>>>                                            unsigned long load_size,
>>> -                                          enum efistub_event event)
>>> +                                          enum efistub_event_type event)
>>>  {
>>> +     struct efistub_measured_event *evt;
>>> +     int size = struct_size(evt, tagged_event_data,
>>> +                            events[event].event_data_len);
>> Include linux/overflow.h explicitly?
>>
> Yes, good point.
>
>>>       efi_guid_t tcg2_guid = EFI_TCG2_PROTOCOL_GUID;
>>>       efi_tcg2_protocol_t *tcg2 = NULL;
>>>       efi_status_t status;
>>>
>>>       efi_bs_call(locate_protocol, &tcg2_guid, NULL, (void **)&tcg2);
>>>       if (tcg2) {
>>> -             struct efi_measured_event {
>>> -                     efi_tcg2_event_t        event_data;
>>> -                     efi_tcg2_tagged_event_t tagged_event;
>>> -                     u8                      tagged_event_data[];
>>> -             } *evt;
>>> -             int size = sizeof(*evt) + events[event].event_data_len;
>>> -
>>>               status = efi_bs_call(allocate_pool, EFI_LOADER_DATA, size,
>>>                                    (void **)&evt);
>> It looks like in patch 3 you have converted evt as stack variable. Since that
>> change is not specific to CC fallback, can it be moved here?
>>
> Not sure what you mean here. evt is still there after parch #3

Sorry, it looks like I misread the patch # 3. Please ignore this comment.

>
>>>               if (status != EFI_SUCCESS)
>>>                       goto fail;
>>>
>>> -             evt->event_data = (struct efi_tcg2_event){
>>> +             evt->event_data.tcg2_data = (struct efi_tcg2_event){
>>>                       .event_size                     = size,
>>> -                     .event_header.header_size       = sizeof(evt->event_data.event_header),
>>> +                     .event_header.header_size       = sizeof(evt->event_data.tcg2_data.event_header),
>>>                       .event_header.header_version    = EFI_TCG2_EVENT_HEADER_VERSION,
>>>                       .event_header.pcr_index         = events[event].pcr_index,
>>>                       .event_header.event_type        = EV_EVENT_TAG,
>>>               };
>>>
>>> -             evt->tagged_event = (struct efi_tcg2_tagged_event){
>>> -                     .tagged_event_id                = events[event].event_id,
>>> -                     .tagged_event_data_size         = events[event].event_data_len,
>>> -             };
>>> +             evt->tagged_event_id            = events[event].event_id;
>>> +             evt->tagged_event_data_size     = events[event].event_data_len;
>>>
>>>               memcpy(evt->tagged_event_data, events[event].event_data,
>>>                      events[event].event_data_len);
>>>
>>>               status = efi_call_proto(tcg2, hash_log_extend_event, 0,
>>> -                                     load_addr, load_size, &evt->event_data);
>>> +                                     load_addr, load_size, &evt->event_data.tcg2_data);
>>>               efi_bs_call(free_pool, evt);
>>>
>>>               if (status != EFI_SUCCESS)
>>> diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
>>> index c04b82ea40f2..b2c50dce48b8 100644
>>> --- a/drivers/firmware/efi/libstub/efistub.h
>>> +++ b/drivers/firmware/efi/libstub/efistub.h
>>> @@ -843,14 +843,7 @@ struct efi_tcg2_event {
>>>       /* u8[] event follows here */
>>>  } __packed;
>>>
>>> -struct efi_tcg2_tagged_event {
>>> -     u32 tagged_event_id;
>>> -     u32 tagged_event_data_size;
>>> -     /* u8  tagged event data follows here */
>>> -} __packed;
>>> -
>>>  typedef struct efi_tcg2_event efi_tcg2_event_t;
>>> -typedef struct efi_tcg2_tagged_event efi_tcg2_tagged_event_t;
>>>  typedef union efi_tcg2_protocol efi_tcg2_protocol_t;
>>>
>>>  union efi_tcg2_protocol {
>>> @@ -882,6 +875,17 @@ union efi_tcg2_protocol {
>>>       } mixed_mode;
>>>  };
>>>
>>> +union efistub_event {
>>> +     efi_tcg2_event_t        tcg2_data;
>>> +};
>>> +
>>> +struct efistub_measured_event {
>>> +     union efistub_event     event_data;
>>> +     u32                     tagged_event_id;
>>> +     u32                     tagged_event_data_size;
>>> +     u8                      tagged_event_data[];
>>> +} __packed;
>>> +
>> Since efistub_measured_event is only used efi-stub-helper.c, why
>> not leave it there?
>>
> Indeed. I will move it back.

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


