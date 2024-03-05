Return-Path: <linux-efi+bounces-728-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6436487279B
	for <lists+linux-efi@lfdr.de>; Tue,  5 Mar 2024 20:36:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87EA61C24F07
	for <lists+linux-efi@lfdr.de>; Tue,  5 Mar 2024 19:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6C242CCD3;
	Tue,  5 Mar 2024 19:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hJwhx4G0"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7EB1C01
	for <linux-efi@vger.kernel.org>; Tue,  5 Mar 2024 19:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709667390; cv=none; b=iKvNnhYXuJGiW+Uf1171ngA5825nfy4JFKNXmENWddwHZwE4I8L8qSIa9AMGqxCf71EqRdvs/eQ57kjMpgoxQ2LYhHXAk8j22V8Ve9bv6r7DyVPLjvnVRCZGTRQtTpQHXCzrJizxQp1vtEvNgYTi+qZDDr9vse1kfKw68+3N3Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709667390; c=relaxed/simple;
	bh=m7hiqaAbH2q3omgCoimWNiHconkxmo1Dv5dvmcVp1Js=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U0DNN3smcYjhG6vpRDK/uwQSM7C1THbsfZGFJ7YeDIoEb6/jT42T8NQSjMk8irAj7saAB+fIqgdYOly/gUxmYuytO1VaY8MXVydFZey2NJ2HEz2L6I1SfkxJepod6XP+gIeq3bUQK/zTFybLIQYx6ihraZyZPD4gaFvF8IqyJYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hJwhx4G0; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709667389; x=1741203389;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=m7hiqaAbH2q3omgCoimWNiHconkxmo1Dv5dvmcVp1Js=;
  b=hJwhx4G0pBNvDEdwaaLX0YXH1ltYyxWn5k0+ICMIBG2G93KLG/NXTRKX
   /QvePQVf70Bji4bUe2N7bc76ReHemxhxYvIfNA8Mq4S5tB5q3yNlqBtUT
   HEhQBsxRU4TKjxrLCtvt779Aa6bEVfbNxjs+1TBxLns+No/32r4/ECnC1
   fwKkHybtbL/fkl06OF5tt3IBmapvK9dp4pOyJW9m80EU1bxGnPEoV11Tq
   rRuBIdmUaVhnU1eFP8RnzYuBr3+3JKu8yoYJYxBO4dD3vSHYAyP7hCH+2
   m9lRiCD0y/IoK85tt51v3hKEV4iIsEy7DE0BbJwdrhZrevi3dgMD9H9+J
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="4101984"
X-IronPort-AV: E=Sophos;i="6.06,206,1705392000"; 
   d="scan'208";a="4101984"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 11:36:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,206,1705392000"; 
   d="scan'208";a="40367416"
Received: from msavchak-mobl.amr.corp.intel.com (HELO [10.209.19.134]) ([10.209.19.134])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 11:36:28 -0800
Message-ID: <63c54a85-3fe3-4e52-885c-ae5816e6b289@linux.intel.com>
Date: Tue, 5 Mar 2024 11:36:27 -0800
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
To: Dionna Amalie Glaze <dionnaglaze@google.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, Qinkun Bao <qinkun@google.com>,
 linux-efi@vger.kernel.org, Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20240304104409.2326422-6-ardb+git@google.com>
 <20240304104409.2326422-9-ardb+git@google.com>
 <CAAH4kHYD03xepd=u9m66XWY=UHkOdooGj7jKPnu9DvA=LPAfXg@mail.gmail.com>
 <CAMj1kXEyWkDaENDOk5zrkZv+5=FwbXgQekoVHP2OqscrM5x=og@mail.gmail.com>
 <CAAH4kHb7ZgfrQQjVr-JiutQthwkbrVGR2DkUDE=E0ZoWGO34eA@mail.gmail.com>
 <2f2416e0-265b-4f03-abf5-fb29c1a0e61b@linux.intel.com>
 <CAAH4kHZhUE+1nBLpEz4tbx=etzZ+3xCXZoexB032OUT-XgZQwg@mail.gmail.com>
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <CAAH4kHZhUE+1nBLpEz4tbx=etzZ+3xCXZoexB032OUT-XgZQwg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 3/5/24 10:46 AM, Dionna Amalie Glaze wrote:
> On Tue, Mar 5, 2024 at 10:33 AM Kuppuswamy Sathyanarayanan
> <sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>>
>> On 3/5/24 10:00 AM, Dionna Amalie Glaze wrote:
>>> On Tue, Mar 5, 2024 at 9:47 AM Ard Biesheuvel <ardb@kernel.org> wrote:
>>>> On Tue, 5 Mar 2024 at 18:34, Dionna Amalie Glaze <dionnaglaze@google.com> wrote:
>>>>> On Mon, Mar 4, 2024 at 2:44 AM Ard Biesheuvel <ardb+git@google.com> wrote:
>>>>>> From: Ard Biesheuvel <ardb@kernel.org>
>>>>>>
>>>>>> To accommodate confidential compute VMs that expose the simplified CC
>>>>>> measurement protocol instead of the full-blown TCG2 one, fall back to
>>>>>> the former if the latter does not exist.
>>>>>>
>>>>>> The CC protocol was designed to be used in this manner, which is why the
>>>>>> types and prototypes have been kept the same where possible. So reuse
>>>>>> the existing code, and only deviate from the TCG2 code path where
>>>>>> needed.
>>>>>>
>>>>>> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>>>>>> ---
>>>>>>  drivers/firmware/efi/libstub/efi-stub-helper.c | 67 +++++++++++++++-----
>>>>>>  drivers/firmware/efi/libstub/efistub.h         |  3 +
>>>>>>  2 files changed, 53 insertions(+), 17 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
>>>>>> index 0dbc9d3f4abd..21f4567324f6 100644
>>>>>> --- a/drivers/firmware/efi/libstub/efi-stub-helper.c
>>>>>> +++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
>>>>>> @@ -223,44 +223,77 @@ static efi_status_t efi_measure_tagged_event(unsigned long load_addr,
>>>>>>                                              unsigned long load_size,
>>>>>>                                              enum efistub_event_type event)
>>>>>>  {
>>>>>> +       union {
>>>>>> +               efi_status_t
>>>>>> +               (__efiapi *hash_log_extend_event)(void *, u64, efi_physical_addr_t,
>>>>>> +                                                 u64, const union efistub_event *);
>>>>>> +               struct { u32 hash_log_extend_event; } mixed_mode;
>>>>>> +       } method;
>>>>>>         struct efistub_measured_event *evt;
>>>>>>         int size = struct_size(evt, tagged_event_data,
>>>>>>                                events[event].event_data_len);
>>>>>>         efi_guid_t tcg2_guid = EFI_TCG2_PROTOCOL_GUID;
>>>>>>         efi_tcg2_protocol_t *tcg2 = NULL;
>>>>>> +       union efistub_event ev;
>>>>>>         efi_status_t status;
>>>>>> +       void *protocol;
>>>>>>
>>>>>>         efi_bs_call(locate_protocol, &tcg2_guid, NULL, (void **)&tcg2);
>>>>>>         if (tcg2) {
>>>>>> -               status = efi_bs_call(allocate_pool, EFI_LOADER_DATA, size,
>>>>>> -                                    (void **)&evt);
>>>>>> -               if (status != EFI_SUCCESS)
>>>>>> -                       goto fail;
>>>>>> -
>>>>>> -               evt->event_data.tcg2_data = (struct efi_tcg2_event){
>>>>>> +               ev.tcg2_data = (struct efi_tcg2_event){
>>>>>>                         .event_size                     = size,
>>>>>> -                       .event_header.header_size       = sizeof(evt->event_data.tcg2_data.event_header),
>>>>>> +                       .event_header.header_size       = sizeof(ev.tcg2_data.event_header),
>>>>>>                         .event_header.header_version    = EFI_TCG2_EVENT_HEADER_VERSION,
>>>>>>                         .event_header.pcr_index         = events[event].pcr_index,
>>>>>>                         .event_header.event_type        = EV_EVENT_TAG,
>>>>>>                 };
>>>>>> +               protocol = tcg2;
>>>>>> +               method.hash_log_extend_event =
>>>>>> +                       (void *)efi_table_attr(tcg2, hash_log_extend_event);
>>>>>> +       } else {
>>>>> +Qinkun Bao
>>>>> Given that the exclusive or between CC_MEASUREMENT_PROTOCOL and the
>>>>> TCG protocol breaks backwards compatibility, it'd be preferable to
>>>>> measure into all the measurement protocols that are present.
>>>> How so? Older kernels will use TCG2 if it exists, and so will new
>>>> kernels. The only difference is that on new kernels, the CC protocol
>>>> will be used in case TCG2 is not implemented.
>>>>
>>>> So the only affected scenario here is a system that today implements
>>>> TCG but not CC, and intends to implement CC later and receive
>>>> measurements into both protocols. Does that really qualify as backward
>>>> compatibility? I'd rather not accommodate future systems that
>>>> implement something that the UEFI spec says they should not.
>>>>
>>>>> The UEFI
>>>>> v2.10 standard says that firmware "should not" provide both, but it is
>>>>> not MUST NOT. Given this and our desire to provide service continuity,
>>>>> I ask that you remove the "else" guard.
>>>>>
>>>> Ignoring the newer protocol if the established one exists is an
>>>> excellent way of making sure this does not happen.
>>>>
>>> The problem is that the protocols are not equivalent, and we disagree
>>> with the standard's claim of "should not" to the point that we're
>>> taking it to the USWG. The "should not" advisement is predicated on
>>> not trusting boot layers to use both protocols when they're both
>>> present, such that you could accidentally miss measuring a
>>> security-critical event. That's a strawman though, since you already
>>> need to develop trust in those boot layers. We have software supply
>>> chain endorsements for tracking that kind of property for use in
>>> attestation verification.
>>>
>>> The CC protocol is useful for hardware-rooted boot measurement, but it
>>> does nothing about the rest of TPM 2.0. There are plenty of users that
>>> want to use a vTPM that's hosted by the VMM but also get an extra
>>> integrity assurance that measurements into TDX RTMRs and attested by
>>> an Intel-rooted key pass an extra level of scrutiny.
>>>
>> If you check the EDK2 part of this support, it also uses if else model.
> Yes, we've been discussing this with Intel and they agreed to allow a
> default false build option to measure into both.

To make it clear, any plans to update the spec with this requirement?

>
>> It does not measure both. If there a complete vTPM support, why
>> can't user trust measurements from it? I think the CC vendors will
> There are folks who want to do a double-check with TEE quotes, but yes
> I agree in general this is not the best situation. It's a stepping
> stones model rather than scaling Everest in one bound.
> Ideally you'd have a measured and protected TPM implementation with
> adequate security for persistent data so that the
> CC_MEASUREMENT_PROTOCOL is fully redundant and therefore not needed.
>
> But anyway, the standard is what it is for now, so I wouldn't block
> this patch based on this request. When there's more alignment from the
> UEFI standards working group and an accepted patch into EDK2, then we
> can revisit this in the different boot layers.

Got it. Personally I think we can consider it, once it is adapted in
firmware and updated in spec (to make it consistent with firmware
support). Anyway, since doing it is harmless, I will  leave it to the
maintainers choice.

>
>> ensure their vTPM implementation is protected from attack from the
>> host (like implementing it part of firmware or launching it as  service in
>> a separate VM).
>>
>>>>>> +               efi_guid_t cc_guid = EFI_CC_MEASUREMENT_PROTOCOL_GUID;
>>>>>> +               efi_cc_protocol_t *cc = NULL;
>>>>>>
>>>>>> -               evt->tagged_event_id            = events[event].event_id;
>>>>>> -               evt->tagged_event_data_size     = events[event].event_data_len;
>>>>>> -
>>>>>> -               memcpy(evt->tagged_event_data, events[event].event_data,
>>>>>> -                      events[event].event_data_len);
>>>>>> +               efi_bs_call(locate_protocol, &cc_guid, NULL, (void **)&cc);
>>>>>> +               if (!cc)
>>>>>> +                       return EFI_UNSUPPORTED;
>>>>>>
>>>>>> -               status = efi_call_proto(tcg2, hash_log_extend_event, 0,
>>>>>> -                                       load_addr, load_size, &evt->event_data.tcg2_data);
>>>>>> -               efi_bs_call(free_pool, evt);
>>>>>> +               ev.cc_data = (struct efi_cc_event){
>>>>>> +                       .event_size                     = size,
>>>>>> +                       .event_header.header_size       = sizeof(ev.cc_data.event_header),
>>>>>> +                       .event_header.header_version    = EFI_CC_EVENT_HEADER_VERSION,
>>>>>> +                       .event_header.event_type        = EV_EVENT_TAG,
>>>>>> +               };
>>>>>>
>>>>>> +               status = efi_call_proto(cc, map_pcr_to_mr_index,
>>>>>> +                                       events[event].pcr_index,
>>>>>> +                                       &ev.cc_data.event_header.mr_index);
>>>>>>                 if (status != EFI_SUCCESS)
>>>>>>                         goto fail;
>>>>>> -               return EFI_SUCCESS;
>>>>>> +
>>>>>> +               protocol = cc;
>>>>>> +               method.hash_log_extend_event =
>>>>>> +                       (void *)efi_table_attr(cc, hash_log_extend_event);
>>>>>>         }
>>>>>>
>>>>>> -       return EFI_UNSUPPORTED;
>>>>>> +       status = efi_bs_call(allocate_pool, EFI_LOADER_DATA, size, (void **)&evt);
>>>>>> +       if (status != EFI_SUCCESS)
>>>>>> +               goto fail;
>>>>>> +
>>>>>> +       evt->event_data                 = ev;
>>>>>> +       evt->tagged_event_id            = events[event].event_id;
>>>>>> +       evt->tagged_event_data_size     = events[event].event_data_len;
>>>>>> +
>>>>>> +       memcpy(evt->tagged_event_data, events[event].event_data,
>>>>>> +              events[event].event_data_len);
>>>>>> +
>>>>>> +       status = efi_fn_call(&method, hash_log_extend_event, protocol, 0,
>>>>>> +                            load_addr, load_size, &evt->event_data);
>>>>>> +       efi_bs_call(free_pool, evt);
>>>>>> +
>>>>>> +       if (status == EFI_SUCCESS)
>>>>>> +               return EFI_SUCCESS;
>>>>>> +
>>>>>>  fail:
>>>>>>         efi_warn("Failed to measure data for event %d: 0x%lx\n", event, status);
>>>>>>         return status;
>>>>>> diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
>>>>>> index d621bfb719c4..4bf9a76796b7 100644
>>>>>> --- a/drivers/firmware/efi/libstub/efistub.h
>>>>>> +++ b/drivers/firmware/efi/libstub/efistub.h
>>>>>> @@ -954,8 +954,11 @@ union efi_cc_protocol {
>>>>>>         } mixed_mode;
>>>>>>  };
>>>>>>
>>>>>> +static_assert(sizeof(efi_tcg2_event_t) == sizeof(efi_cc_event_t));
>>>>>> +
>>>>>>  union efistub_event {
>>>>>>         efi_tcg2_event_t        tcg2_data;
>>>>>> +       efi_cc_event_t          cc_data;
>>>>>>  };
>>>>>>
>>>>>>  struct efistub_measured_event {
>>>>>> --
>>>>>> 2.44.0.278.ge034bb2e1d-goog
>>>>>>
>>>>>>
>>>>> --
>>>>> -Dionna Glaze, PhD (she/her)
>>>
>> --
>> Sathyanarayanan Kuppuswamy
>> Linux Kernel Developer
>>
>
-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


