Return-Path: <linux-efi+bounces-724-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14A55872695
	for <lists+linux-efi@lfdr.de>; Tue,  5 Mar 2024 19:33:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F4C128B523
	for <lists+linux-efi@lfdr.de>; Tue,  5 Mar 2024 18:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEECA1426F;
	Tue,  5 Mar 2024 18:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EhYOV7MM"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8AA61B970
	for <linux-efi@vger.kernel.org>; Tue,  5 Mar 2024 18:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709663588; cv=none; b=bpu5GS7rB/hTEaxWpJM46bsgsapBdrETqKPOEU+xlaEzf3I2C4pp8o0eg5qzoMWBS0WA82V9DQ+xciWA6eanzgeXphYd956uLS3jlld7Kixxz/p1tVuz025VC9nYcPn1UIMRyyLIEXXiFLwx1mtwEs/XnY0erKMsl+xDtfW6KkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709663588; c=relaxed/simple;
	bh=v4kgbFwNGEtR1wFQ6X/mJy4Vux4DcOKNyMCmQhpkmFg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LBDqj7ZYbXyqMpJcnfyQg3LBngNbLOQH9WivM6tzNUzCn9lVN2x06qbtzy7xtJMuLjqG4bP8F5a7w8rLywQwqOkpBqHHO9EJ8BYeQgjluLBCEwY6fhoUlDcuFwMuzUjLAgEjGlvGY2zZnJdsK+fysGKsHzNhiXxRlce3u8mrXmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EhYOV7MM; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709663587; x=1741199587;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=v4kgbFwNGEtR1wFQ6X/mJy4Vux4DcOKNyMCmQhpkmFg=;
  b=EhYOV7MMge+8XitEGYu1dn0FbM0syyy+4tR2v1QSFVJ4nANk4a5fUPVg
   5OihdenWpe2a/jK6IXzjbxLQ37guylfcHxfsPi+Zl7l/6+37nKTZfS8pJ
   HKISRnfXjtzl49kAFjHvZPww1wGYz9O62h0owu5utVxVYYiEDU019rLQH
   SxFhifP6olEwwdAg1r7VJbySwFkocBri88e3mKUGLTEgp+RyNk0Azyw7i
   tzOvWei6AZyOsC1POq8Ely/48NSeYc7VJHISYerOzUqON/vW22iNSWbf2
   XM7nhZyiQiwDSWcC8+YKeAQPcq/AThtQljYSGpER/k3rk8863ntL1n8Ip
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="14953562"
X-IronPort-AV: E=Sophos;i="6.06,206,1705392000"; 
   d="scan'208";a="14953562"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 10:33:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,206,1705392000"; 
   d="scan'208";a="13956890"
Received: from msavchak-mobl.amr.corp.intel.com (HELO [10.209.19.134]) ([10.209.19.134])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 10:33:05 -0800
Message-ID: <2f2416e0-265b-4f03-abf5-fb29c1a0e61b@linux.intel.com>
Date: Tue, 5 Mar 2024 10:33:05 -0800
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
To: Dionna Amalie Glaze <dionnaglaze@google.com>,
 Ard Biesheuvel <ardb@kernel.org>
Cc: Qinkun Bao <qinkun@google.com>, linux-efi@vger.kernel.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20240304104409.2326422-6-ardb+git@google.com>
 <20240304104409.2326422-9-ardb+git@google.com>
 <CAAH4kHYD03xepd=u9m66XWY=UHkOdooGj7jKPnu9DvA=LPAfXg@mail.gmail.com>
 <CAMj1kXEyWkDaENDOk5zrkZv+5=FwbXgQekoVHP2OqscrM5x=og@mail.gmail.com>
 <CAAH4kHb7ZgfrQQjVr-JiutQthwkbrVGR2DkUDE=E0ZoWGO34eA@mail.gmail.com>
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <CAAH4kHb7ZgfrQQjVr-JiutQthwkbrVGR2DkUDE=E0ZoWGO34eA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 3/5/24 10:00 AM, Dionna Amalie Glaze wrote:
> On Tue, Mar 5, 2024 at 9:47 AM Ard Biesheuvel <ardb@kernel.org> wrote:
>> On Tue, 5 Mar 2024 at 18:34, Dionna Amalie Glaze <dionnaglaze@google.com> wrote:
>>> On Mon, Mar 4, 2024 at 2:44 AM Ard Biesheuvel <ardb+git@google.com> wrote:
>>>> From: Ard Biesheuvel <ardb@kernel.org>
>>>>
>>>> To accommodate confidential compute VMs that expose the simplified CC
>>>> measurement protocol instead of the full-blown TCG2 one, fall back to
>>>> the former if the latter does not exist.
>>>>
>>>> The CC protocol was designed to be used in this manner, which is why the
>>>> types and prototypes have been kept the same where possible. So reuse
>>>> the existing code, and only deviate from the TCG2 code path where
>>>> needed.
>>>>
>>>> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>>>> ---
>>>>  drivers/firmware/efi/libstub/efi-stub-helper.c | 67 +++++++++++++++-----
>>>>  drivers/firmware/efi/libstub/efistub.h         |  3 +
>>>>  2 files changed, 53 insertions(+), 17 deletions(-)
>>>>
>>>> diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
>>>> index 0dbc9d3f4abd..21f4567324f6 100644
>>>> --- a/drivers/firmware/efi/libstub/efi-stub-helper.c
>>>> +++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
>>>> @@ -223,44 +223,77 @@ static efi_status_t efi_measure_tagged_event(unsigned long load_addr,
>>>>                                              unsigned long load_size,
>>>>                                              enum efistub_event_type event)
>>>>  {
>>>> +       union {
>>>> +               efi_status_t
>>>> +               (__efiapi *hash_log_extend_event)(void *, u64, efi_physical_addr_t,
>>>> +                                                 u64, const union efistub_event *);
>>>> +               struct { u32 hash_log_extend_event; } mixed_mode;
>>>> +       } method;
>>>>         struct efistub_measured_event *evt;
>>>>         int size = struct_size(evt, tagged_event_data,
>>>>                                events[event].event_data_len);
>>>>         efi_guid_t tcg2_guid = EFI_TCG2_PROTOCOL_GUID;
>>>>         efi_tcg2_protocol_t *tcg2 = NULL;
>>>> +       union efistub_event ev;
>>>>         efi_status_t status;
>>>> +       void *protocol;
>>>>
>>>>         efi_bs_call(locate_protocol, &tcg2_guid, NULL, (void **)&tcg2);
>>>>         if (tcg2) {
>>>> -               status = efi_bs_call(allocate_pool, EFI_LOADER_DATA, size,
>>>> -                                    (void **)&evt);
>>>> -               if (status != EFI_SUCCESS)
>>>> -                       goto fail;
>>>> -
>>>> -               evt->event_data.tcg2_data = (struct efi_tcg2_event){
>>>> +               ev.tcg2_data = (struct efi_tcg2_event){
>>>>                         .event_size                     = size,
>>>> -                       .event_header.header_size       = sizeof(evt->event_data.tcg2_data.event_header),
>>>> +                       .event_header.header_size       = sizeof(ev.tcg2_data.event_header),
>>>>                         .event_header.header_version    = EFI_TCG2_EVENT_HEADER_VERSION,
>>>>                         .event_header.pcr_index         = events[event].pcr_index,
>>>>                         .event_header.event_type        = EV_EVENT_TAG,
>>>>                 };
>>>> +               protocol = tcg2;
>>>> +               method.hash_log_extend_event =
>>>> +                       (void *)efi_table_attr(tcg2, hash_log_extend_event);
>>>> +       } else {
>>> +Qinkun Bao
>>> Given that the exclusive or between CC_MEASUREMENT_PROTOCOL and the
>>> TCG protocol breaks backwards compatibility, it'd be preferable to
>>> measure into all the measurement protocols that are present.
>> How so? Older kernels will use TCG2 if it exists, and so will new
>> kernels. The only difference is that on new kernels, the CC protocol
>> will be used in case TCG2 is not implemented.
>>
>> So the only affected scenario here is a system that today implements
>> TCG but not CC, and intends to implement CC later and receive
>> measurements into both protocols. Does that really qualify as backward
>> compatibility? I'd rather not accommodate future systems that
>> implement something that the UEFI spec says they should not.
>>
>>> The UEFI
>>> v2.10 standard says that firmware "should not" provide both, but it is
>>> not MUST NOT. Given this and our desire to provide service continuity,
>>> I ask that you remove the "else" guard.
>>>
>> Ignoring the newer protocol if the established one exists is an
>> excellent way of making sure this does not happen.
>>
> The problem is that the protocols are not equivalent, and we disagree
> with the standard's claim of "should not" to the point that we're
> taking it to the USWG. The "should not" advisement is predicated on
> not trusting boot layers to use both protocols when they're both
> present, such that you could accidentally miss measuring a
> security-critical event. That's a strawman though, since you already
> need to develop trust in those boot layers. We have software supply
> chain endorsements for tracking that kind of property for use in
> attestation verification.
>
> The CC protocol is useful for hardware-rooted boot measurement, but it
> does nothing about the rest of TPM 2.0. There are plenty of users that
> want to use a vTPM that's hosted by the VMM but also get an extra
> integrity assurance that measurements into TDX RTMRs and attested by
> an Intel-rooted key pass an extra level of scrutiny.
>

If you check the EDK2 part of this support, it also uses if else model.
It does not measure both. If there a complete vTPM support, why
can't user trust measurements from it? I think the CC vendors will
ensure their vTPM implementation is protected from attack from the
host (like implementing it part of firmware or launching it as  service in
a separate VM).

>>>> +               efi_guid_t cc_guid = EFI_CC_MEASUREMENT_PROTOCOL_GUID;
>>>> +               efi_cc_protocol_t *cc = NULL;
>>>>
>>>> -               evt->tagged_event_id            = events[event].event_id;
>>>> -               evt->tagged_event_data_size     = events[event].event_data_len;
>>>> -
>>>> -               memcpy(evt->tagged_event_data, events[event].event_data,
>>>> -                      events[event].event_data_len);
>>>> +               efi_bs_call(locate_protocol, &cc_guid, NULL, (void **)&cc);
>>>> +               if (!cc)
>>>> +                       return EFI_UNSUPPORTED;
>>>>
>>>> -               status = efi_call_proto(tcg2, hash_log_extend_event, 0,
>>>> -                                       load_addr, load_size, &evt->event_data.tcg2_data);
>>>> -               efi_bs_call(free_pool, evt);
>>>> +               ev.cc_data = (struct efi_cc_event){
>>>> +                       .event_size                     = size,
>>>> +                       .event_header.header_size       = sizeof(ev.cc_data.event_header),
>>>> +                       .event_header.header_version    = EFI_CC_EVENT_HEADER_VERSION,
>>>> +                       .event_header.event_type        = EV_EVENT_TAG,
>>>> +               };
>>>>
>>>> +               status = efi_call_proto(cc, map_pcr_to_mr_index,
>>>> +                                       events[event].pcr_index,
>>>> +                                       &ev.cc_data.event_header.mr_index);
>>>>                 if (status != EFI_SUCCESS)
>>>>                         goto fail;
>>>> -               return EFI_SUCCESS;
>>>> +
>>>> +               protocol = cc;
>>>> +               method.hash_log_extend_event =
>>>> +                       (void *)efi_table_attr(cc, hash_log_extend_event);
>>>>         }
>>>>
>>>> -       return EFI_UNSUPPORTED;
>>>> +       status = efi_bs_call(allocate_pool, EFI_LOADER_DATA, size, (void **)&evt);
>>>> +       if (status != EFI_SUCCESS)
>>>> +               goto fail;
>>>> +
>>>> +       evt->event_data                 = ev;
>>>> +       evt->tagged_event_id            = events[event].event_id;
>>>> +       evt->tagged_event_data_size     = events[event].event_data_len;
>>>> +
>>>> +       memcpy(evt->tagged_event_data, events[event].event_data,
>>>> +              events[event].event_data_len);
>>>> +
>>>> +       status = efi_fn_call(&method, hash_log_extend_event, protocol, 0,
>>>> +                            load_addr, load_size, &evt->event_data);
>>>> +       efi_bs_call(free_pool, evt);
>>>> +
>>>> +       if (status == EFI_SUCCESS)
>>>> +               return EFI_SUCCESS;
>>>> +
>>>>  fail:
>>>>         efi_warn("Failed to measure data for event %d: 0x%lx\n", event, status);
>>>>         return status;
>>>> diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
>>>> index d621bfb719c4..4bf9a76796b7 100644
>>>> --- a/drivers/firmware/efi/libstub/efistub.h
>>>> +++ b/drivers/firmware/efi/libstub/efistub.h
>>>> @@ -954,8 +954,11 @@ union efi_cc_protocol {
>>>>         } mixed_mode;
>>>>  };
>>>>
>>>> +static_assert(sizeof(efi_tcg2_event_t) == sizeof(efi_cc_event_t));
>>>> +
>>>>  union efistub_event {
>>>>         efi_tcg2_event_t        tcg2_data;
>>>> +       efi_cc_event_t          cc_data;
>>>>  };
>>>>
>>>>  struct efistub_measured_event {
>>>> --
>>>> 2.44.0.278.ge034bb2e1d-goog
>>>>
>>>>
>>>
>>> --
>>> -Dionna Glaze, PhD (she/her)
>
>
-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


