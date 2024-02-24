Return-Path: <linux-efi+bounces-662-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B435862357
	for <lists+linux-efi@lfdr.de>; Sat, 24 Feb 2024 08:37:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E6141C21E84
	for <lists+linux-efi@lfdr.de>; Sat, 24 Feb 2024 07:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95B7C12B84;
	Sat, 24 Feb 2024 07:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LgJKXipM"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0261B666;
	Sat, 24 Feb 2024 07:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708760262; cv=none; b=fJf+sFz0Wuph09sqj6XYf3e0P268jGMlU/lHXD8JtbUoAEz8QxBpgftCewUfUpVAyS9IQGGNWpHNAcL8WhvkcD7FbDSrJJvRc3dAKZYne0nBedFB2x1v/kGu4yxKQZrDQQgI9tOs8H4k1eNO6R+TQAox4LiTKCnUvj186SZJfoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708760262; c=relaxed/simple;
	bh=AtaqrweNfn12KD1Xc3+14+5Cj9+rbaXL+nnoyVPSEOg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jftmQzYP1Vgbp4IcWzWrUMpvjzSowwbvSq/CtF2qr8brZPAtDggnu8DSx0fTIcRDm3ocayWrHuDL36fGidMSAOeqCuxw2jRIziZJmThPfOBa04XwcjIEM4zM7XB78Ttr0Mcy/irTUS4U7hzr+FOX9xe36I2oqw7hW7qiqO3JUCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LgJKXipM; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708760261; x=1740296261;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=AtaqrweNfn12KD1Xc3+14+5Cj9+rbaXL+nnoyVPSEOg=;
  b=LgJKXipM6jhA5VLeaamOQk27xiEVvaG8adaoJJ43K4e/jkuO79gMFaUQ
   ZbPE24L32hqW/PkJcyU7UCXUpqSShctjgsUAuErQXnJb+LWOUv741vgoZ
   dflkG2JIA6f8MignwDYnXYN1GVrkPCDtKiHFNMTBL8uObFqqqnB0GXAJK
   pV8eQLZmNzfpM3JEBs70QQzhdKwzAaXzbSourOuICimEEFm1fvrmuB0Eo
   T0xRy3MzBOXVooAaPCMzG/x2h3ARpAyeRDTv4v2dPw6e9YzrB6pjusAYG
   hd9hOPpqMz/2BIoOEc2Uw35PhdW8XyuUn/GhRDC276eRnMrWQdVe8ybrq
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10993"; a="14505766"
X-IronPort-AV: E=Sophos;i="6.06,181,1705392000"; 
   d="scan'208";a="14505766"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 23:37:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,181,1705392000"; 
   d="scan'208";a="10844042"
Received: from bafghani-mobl.amr.corp.intel.com (HELO [10.255.231.229]) ([10.255.231.229])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 23:37:40 -0800
Message-ID: <7bd53417-af59-43a8-965e-f63dfc827f3c@linux.intel.com>
Date: Fri, 23 Feb 2024 23:37:39 -0800
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] efi/libstub: Add Confidential Computing (CC)
 measurement support
Content-Language: en-US
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
 linux-efi@vger.kernel.org
References: <20240215030002.281456-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20240215030002.281456-2-sathyanarayanan.kuppuswamy@linux.intel.com>
 <CAC_iWj+p6gmcb4-_-f8Kr4Ds6EmSsq2D4GK1XymyybX7i1TMFw@mail.gmail.com>
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <CAC_iWj+p6gmcb4-_-f8Kr4Ds6EmSsq2D4GK1XymyybX7i1TMFw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Ilias,

Thanks for the review.

On 2/18/24 10:38 PM, Ilias Apalodimas wrote:
> Hi Kuppuswamy,
>
> On Thu, 15 Feb 2024 at 05:02, Kuppuswamy Sathyanarayanan
> <sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>> If the virtual firmware implements TPM support, TCG2 protocol will be
>> used for kernel measurements and event logging support. But in CC
>> environment, not all platforms support or enable the TPM feature. UEFI
>> specification [1] exposes protocol and interfaces used for kernel
>> measurements in CC platforms without TPM support.
>>
>> Currently, the efi-stub only supports the kernel related measurements
>> for the platform that supports TCG2 protocol. So, extend it add
>> CC measurement protocol (EFI_CC_MEASUREMENT_PROTOCOL) and event logging
>> support. Event logging format in the CC environment is the same as
>> TCG2.
>>
>> More details about the EFI CC measurements and logging can be found
>> in [1].
>>
>> Link: https://uefi.org/specs/UEFI/2.10/38_Confidential_Computing.html#efi-cc-measurement-protocol [1]
>> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>> ---
>>
>> Changes since v1:
>> * Fixed missing tagged event data.
>>
>>  .../firmware/efi/libstub/efi-stub-helper.c    | 127 ++++++++++++++----
>>  drivers/firmware/efi/libstub/efistub.h        |  74 ++++++++++
>>  include/linux/efi.h                           |   1 +
>>  3 files changed, 174 insertions(+), 28 deletions(-)
>>
>> diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
>> index bfa30625f5d0..cc31f8143190 100644
>> --- a/drivers/firmware/efi/libstub/efi-stub-helper.c
>> +++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
>> @@ -219,50 +219,121 @@ static const struct {
>>         },
>>  };
>>
>> +static efi_status_t tcg2_efi_measure(efi_tcg2_protocol_t *tcg2,
>> +                                    unsigned long load_addr,
>> +                                    unsigned long load_size,
>> +                                    enum efistub_event event)
>> +{
>> +       struct efi_measured_event {
>> +               efi_tcg2_event_t        event_data;
>> +               efi_tcg2_tagged_event_t tagged_event;
>> +               u8                      tagged_event_data[];
>> +       } *evt;
>> +       int size = sizeof(*evt) + events[event].event_data_len;
> This is defined as size_t on the cc variant. I guess both are ok, just pick one

Ok

>> +       efi_status_t status;
>> +
>> +       status = efi_bs_call(allocate_pool, EFI_LOADER_DATA, size,
>> +                            (void **)&evt);
>> +       if (status != EFI_SUCCESS)
> pr_err() here as done in the cc variant?

I will remove the error message in the CC variant as well. I don't want to
introduce additional logs for existing case (tcg2) as well. May be I can
can use efi_debug just for the map_pcr_to_mr_index call.
>> +               return status;
>> +
>> +       evt->event_data = (struct efi_tcg2_event){
>> +               .event_size                     = size,
>> +               .event_header.header_size       = sizeof(evt->event_data.event_header),
>> +               .event_header.header_version    = EFI_TCG2_EVENT_HEADER_VERSION,
>> +               .event_header.pcr_index         = events[event].pcr_index,
>> +               .event_header.event_type        = EV_EVENT_TAG,
>> +       };
>> +
>> +       evt->tagged_event = (struct efi_tcg2_tagged_event){
>> +               .tagged_event_id                = events[event].event_id,
>> +               .tagged_event_data_size         = events[event].event_data_len,
>> +       };
>> +
>> +       memcpy(evt->tagged_event_data, events[event].event_data,
>> +              events[event].event_data_len);
>> +
>> +       status = efi_call_proto(tcg2, hash_log_extend_event, 0,
>> +                               load_addr, load_size, &evt->event_data);
> The struct filling/memcpying looks similar across the 2 functions.  I
> wonder if it makes sense to have a common function for that, with an
> argument for the event data type.

If we want to use helper function, the updated code looks like below.

Are you fine with this version? (compile-tested only)

+struct efi_tcg2_measured_event {
+       efi_tcg2_event_t        event_data;
+       efi_tcg2_tagged_event_t tagged_event;
+       u8                      tagged_event_data[];
+};
+
+struct efi_cc_measured_event {
+       efi_cc_event_t  event_data;
+       efi_tcg2_tagged_event_t tagged_event;
+       u8                      tagged_event_data[];
+};
+
+static void efi_tcg2_event_init(struct efi_tcg2_measured_event *evt,
+                               size_t size,
+                               enum efistub_event event)
+{
+       evt->event_data = (struct efi_tcg2_event){
+               .event_size                     = size,
+               .event_header.header_size       = sizeof(evt->event_data.event_header),
+               .event_header.header_version    = EFI_TCG2_EVENT_HEADER_VERSION,
+               .event_header.pcr_index         = events[event].pcr_index,
+               .event_header.event_type        = EV_EVENT_TAG,
+       };
+
+       evt->tagged_event = (struct efi_tcg2_tagged_event){
+               .tagged_event_id                = events[event].event_id,
+               .tagged_event_data_size         = events[event].event_data_len,
+       };
+
+       memcpy(evt->tagged_event_data, events[event].event_data,
+              events[event].event_data_len);
+}
+
+static efi_status_t tcg2_efi_measure(efi_tcg2_protocol_t *tcg2,
+                                    unsigned long load_addr,
+                                    unsigned long load_size,
+                                    enum efistub_event event)
+{
+       struct efi_tcg2_measured_event *evt;
+       efi_status_t status;
+       size_t size;
+
+       size = sizeof(*evt) + events[event].event_data_len;
+
+       status = efi_bs_call(allocate_pool, EFI_LOADER_DATA, size,
+                            (void **)&evt);
+       if (status != EFI_SUCCESS)
+               return status;
+
+       efi_tcg2_event_init(evt, size, event);
+
+       status = efi_call_proto(tcg2, hash_log_extend_event, 0,
+                               load_addr, load_size, &evt->event_data);
+       efi_bs_call(free_pool, evt);
+
+       return status;
+}

+
+static efi_status_t cc_efi_measure(efi_cc_protocol_t *cc,
+                                  unsigned long load_addr,
+                                  unsigned long load_size,
+                                  enum efistub_event event)
+{
+       struct efi_cc_measured_event *evt;
+       efi_cc_mr_index_t mr;
+       efi_status_t status;
+       size_t size;
+
+       status = efi_call_proto(cc, map_pcr_to_mr_index, events[event].pcr_index, &mr);
+       if (status != EFI_SUCCESS) {
+               efi_debug("CC_MEASURE: PCR to MR mapping failed\n");
+               return status;
+       }
+
+       size = sizeof(*evt) + events[event].event_data_len;
+
+       status = efi_bs_call(allocate_pool, EFI_LOADER_DATA, size, (void **)&evt);
+       if (status != EFI_SUCCESS)
+               return status;
+
+       efi_tcg2_event_init((struct efi_tcg2_measured_event *)evt, size, event);
+
+       evt->event_data = (struct efi_cc_event){
+               .event_header.header_size       = sizeof(evt->event_data.event_header),
+               .event_header.header_version    = EFI_CC_EVENT_HEADER_VERSION,
+               .event_header.mr_index          = mr,
+       };
+
+       status = efi_call_proto(cc, hash_log_extend_event, 0,
+                               load_addr, load_size, &evt->event_data);
+
+       efi_bs_call(free_pool, evt);
+
+       return status;
+}


>
>> +       efi_bs_call(free_pool, evt);
>> +
>> +       return status;
>> +}
>> +
>> +static efi_status_t cc_efi_measure(efi_cc_protocol_t *cc,
>> +                                  unsigned long load_addr,
>> +                                  unsigned long load_size,
>> +                                  enum efistub_event event)
>> +{
>> +       struct efi_measured_event {
>> +               efi_cc_event_t  event_data;
>> +               efi_tcg2_tagged_event_t tagged_event;
>> +               u8                      tagged_event_data[];
>> +       } *evt;
>> +       size_t size = sizeof(*evt) + events[event].event_data_len;
>> +       efi_cc_mr_index_t mr;
>> +       efi_status_t status;
>> +
>> +       status = efi_call_proto(cc, map_pcr_to_mr_index, events[event].pcr_index, &mr);
>> +       if (status != EFI_SUCCESS) {
>> +               efi_err("CC_MEASURE: PCR to MR mapping failed\n");
>> +               return status;
>> +       }
>> +
>> +       status = efi_bs_call(allocate_pool, EFI_LOADER_DATA, size, (void **)&evt);
>> +       if (status != EFI_SUCCESS) {
>> +               efi_err("CC_MEASURE: Allocating event struct failed\n");
>> +               return status;
>> +       }
>> +
>> +       evt->event_data = (struct efi_cc_event){
>> +               .event_size                     = size,
>> +               .event_header.header_size       = sizeof(evt->event_data.event_header),
>> +               .event_header.header_version    = EFI_CC_EVENT_HEADER_VERSION,
>> +               .event_header.mr_index          = mr,
>> +               .event_header.event_type        = EV_EVENT_TAG,
>> +       };
>> +
>> +       evt->tagged_event = (struct efi_tcg2_tagged_event){
>> +               .tagged_event_id                = events[event].event_id,
>> +               .tagged_event_data_size         = events[event].event_data_len,
>> +       };
>> +
>> +       memcpy(evt->tagged_event_data, events[event].event_data,
>> +              events[event].event_data_len);
>> +
>> +       status = efi_call_proto(cc, hash_log_extend_event, 0,
>> +                               load_addr, load_size, &evt->event_data);
>> +
>> +       efi_bs_call(free_pool, evt);
>> +
>> +       return status;
>> +}
>>  static efi_status_t efi_measure_tagged_event(unsigned long load_addr,
>>                                              unsigned long load_size,
>>                                              enum efistub_event event)
>>  {
>>         efi_guid_t tcg2_guid = EFI_TCG2_PROTOCOL_GUID;
>> +       efi_guid_t cc_guid = EFI_CC_MEASUREMENT_PROTOCOL_GUID;
>> +       efi_cc_protocol_t *cc = NULL;
>>         efi_tcg2_protocol_t *tcg2 = NULL;
>>         efi_status_t status;
>>
>>         efi_bs_call(locate_protocol, &tcg2_guid, NULL, (void **)&tcg2);
>>         if (tcg2) {
>> -               struct efi_measured_event {
>> -                       efi_tcg2_event_t        event_data;
>> -                       efi_tcg2_tagged_event_t tagged_event;
>> -                       u8                      tagged_event_data[];
>> -               } *evt;
>> -               int size = sizeof(*evt) + events[event].event_data_len;
>> -
>> -               status = efi_bs_call(allocate_pool, EFI_LOADER_DATA, size,
>> -                                    (void **)&evt);
>> +               status = tcg2_efi_measure(tcg2, load_addr, load_size, event);
>>                 if (status != EFI_SUCCESS)
>>                         goto fail;
>>
>> -               evt->event_data = (struct efi_tcg2_event){
>> -                       .event_size                     = size,
>> -                       .event_header.header_size       = sizeof(evt->event_data.event_header),
>> -                       .event_header.header_version    = EFI_TCG2_EVENT_HEADER_VERSION,
>> -                       .event_header.pcr_index         = events[event].pcr_index,
>> -                       .event_header.event_type        = EV_EVENT_TAG,
>> -               };
>> -
>> -               evt->tagged_event = (struct efi_tcg2_tagged_event){
>> -                       .tagged_event_id                = events[event].event_id,
>> -                       .tagged_event_data_size         = events[event].event_data_len,
>> -               };
>> -
>> -               memcpy(evt->tagged_event_data, events[event].event_data,
>> -                      events[event].event_data_len);
>> -
>> -               status = efi_call_proto(tcg2, hash_log_extend_event, 0,
>> -                                       load_addr, load_size, &evt->event_data);
>> -               efi_bs_call(free_pool, evt);
>> +               return EFI_SUCCESS;
>> +       }
>>
>> +       efi_bs_call(locate_protocol, &cc_guid, NULL, (void **)&cc);
>> +       if (cc) {
>> +               status = cc_efi_measure(cc, load_addr, load_size, event);
>>                 if (status != EFI_SUCCESS)
>>                         goto fail;
>> +
>>                 return EFI_SUCCESS;
>>         }
>>
> [...]
>
> Thanks
> /Ilias

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


