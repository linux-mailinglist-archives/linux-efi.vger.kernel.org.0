Return-Path: <linux-efi+bounces-4185-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBE9CAFC454
	for <lists+linux-efi@lfdr.de>; Tue,  8 Jul 2025 09:40:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70A881885ACC
	for <lists+linux-efi@lfdr.de>; Tue,  8 Jul 2025 07:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8250C298CC7;
	Tue,  8 Jul 2025 07:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="mCSiVsxt"
X-Original-To: linux-efi@vger.kernel.org
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA5BC2989BC;
	Tue,  8 Jul 2025 07:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751960412; cv=none; b=LqTjio8+XdY7WRsw/s9puMvu1KoPPTsvvub1o30fHjWyh+wbGLjqS1BoeQIyxn/zdw6X7D4c/vF1mvJJMcUxMGPyW2WV50v2oGuoWLKZDSwZb39b8EbQECQhtnHDufeivoZO/IUGmuFkzpTEcRrhZhXf0vbBkBJp6Az6t1yjNRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751960412; c=relaxed/simple;
	bh=3fo4EfdCIwepWMiWH+dpbuUTXqXmWdubD93vkAP8EFg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ugWC/1ZwNQl/9WcGAIIbIc22X1/Vy+XQdQISaJlpb5AAzXWCtoGPBbpnmEFtdoe15H+CeYVjwoE1J+xdTKDTm3Jsdy0SJtIvVRof9XZvYd+q5dKvwVZi8oY4dHgln0kcCsMwRsGHTUM7gVDAZioMtGv5RyiAnmaD3UPAf/a37fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=mCSiVsxt; arc=none smtp.client-ip=220.197.31.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=4pcONlMtctRaQHK7fS6/2dAIUpqJuNsF4h6jvz/beT4=;
	b=mCSiVsxtRndwqmss2ycRnowHt0DpJ3lfNRCsVJL8pvMVoAlR3DhmuNTE3rHHZ1
	1KNS74CFDbo7z9sE34wlBk716LiX1LNaSy0kNFKQSkUQvl4qvEvD2CwyBYAiiD8u
	L/bshUamWlWK4o/rFl0EQORUr4EPHIODu3HVEeItubvRA=
Received: from [172.19.20.199] (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wD39zc6y2xonS0mAA--.884S2;
	Tue, 08 Jul 2025 15:39:39 +0800 (CST)
Message-ID: <8497d07f-b0e2-4a0f-91b9-9e6ecd1f8b1e@126.com>
Date: Tue, 8 Jul 2025 15:39:38 +0800
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3] efi/tpm: Fix the issue where the CC platforms event
 log header can't be correctly identified
To: Ard Biesheuvel <ardb@kernel.org>
Cc: jarkko@kernel.org, sathyanarayanan.kuppuswamy@linux.intel.com,
 ilias.apalodimas@linaro.org, jgg@ziepe.ca, linux-efi@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, liuzixing@hygon.cn
References: <1751858087-10366-1-git-send-email-yangge1116@126.com>
 <CAMj1kXEbTH3T_hYQnvPy_cAnBJi6z7VoZxh3KseW91D1o=R_4g@mail.gmail.com>
From: Ge Yang <yangge1116@126.com>
In-Reply-To: <CAMj1kXEbTH3T_hYQnvPy_cAnBJi6z7VoZxh3KseW91D1o=R_4g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD39zc6y2xonS0mAA--.884S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxKw48XF4xKr4UCryUGFW8Crg_yoW3tFyDpF
	48JF9Ykr45JFW2gw1fZw1UA3ZxZw4ktrZrGFyDK3WjyrnxuryxWF4UGry5CF93trsrG3WY
	q34Utr17ua4jvaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jbHUDUUUUU=
X-CM-SenderInfo: 51dqwwjhrrila6rslhhfrp/1tbiigCEG2hswwvYQwAAsC



在 2025/7/8 9:19, Ard Biesheuvel 写道:
> On Mon, 7 Jul 2025 at 13:15, <yangge1116@126.com> wrote:
>>
>> From: Ge Yang <yangge1116@126.com>
>>
>> Since commit d228814b1913 ("efi/libstub: Add get_event_log() support
>> for CC platforms") reuses TPM2 support code for the CC platforms, when
>> launching a TDX virtual machine with coco measurement enabled, the
>> following error log is generated:
>>
>> [Firmware Bug]: Failed to parse event in TPM Final Events Log
>>
>> Call Trace:
>> efi_config_parse_tables()
>>    efi_tpm_eventlog_init()
>>      tpm2_calc_event_log_size()
>>        __calc_tpm2_event_size()
>>
>> The pcr_idx value in the Intel TDX log header is 1, causing the function
>> __calc_tpm2_event_size() to fail to recognize the log header, ultimately
>> leading to the "Failed to parse event in TPM Final Events Log" error.
>>
>> According to UEFI Specification 2.10, Section 38.4.1: For TDX, TPM PCR
>> 0 maps to MRTD, so the log header uses TPM PCR 1 instead. To successfully
>> parse the TDX event log header, the check for a pcr_idx value of 0
>> must be skipped.
>>
>> According to Table 6 in Section 10.2.1 of the TCG PC Client
>> Specification, the index field does not require the PCR index to be
>> fixed at zero. Therefore, skipping the check for a pcr_idx value of
>> 0 for CC platforms is safe.
>>
>> Link: https://uefi.org/specs/UEFI/2.10/38_Confidential_Computing.html#intel-trust-domain-extension
>> Link: https://trustedcomputinggroup.org/wp-content/uploads/TCG_PCClient_PFP_r1p05_v23_pub.pdf
>> Fixes: d228814b1913 ("efi/libstub: Add get_event_log() support for CC platforms")
>> Signed-off-by: Ge Yang <yangge1116@126.com>
>> Cc: stable@vger.kernel.org
>> ---
>>
>> V3:
>> - fix build error
>>
>> V2:
>> - limit the fix for CC only suggested by Jarkko and Sathyanarayanan
>>
>>   drivers/char/tpm/eventlog/tpm2.c   |  4 +++-
>>   drivers/firmware/efi/libstub/tpm.c | 13 +++++++++----
>>   drivers/firmware/efi/tpm.c         |  4 +++-
>>   include/linux/tpm_eventlog.h       | 14 +++++++++++---
>>   4 files changed, 26 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/char/tpm/eventlog/tpm2.c b/drivers/char/tpm/eventlog/tpm2.c
>> index 37a0580..30ef47c 100644
>> --- a/drivers/char/tpm/eventlog/tpm2.c
>> +++ b/drivers/char/tpm/eventlog/tpm2.c
>> @@ -18,6 +18,7 @@
>>   #include <linux/module.h>
>>   #include <linux/slab.h>
>>   #include <linux/tpm_eventlog.h>
>> +#include <linux/cc_platform.h>
>>
>>   #include "../tpm.h"
>>   #include "common.h"
>> @@ -36,7 +37,8 @@
>>   static size_t calc_tpm2_event_size(struct tcg_pcr_event2_head *event,
>>                                     struct tcg_pcr_event *event_header)
>>   {
>> -       return __calc_tpm2_event_size(event, event_header, false);
>> +       return __calc_tpm2_event_size(event, event_header, false,
>> +                       cc_platform_has(CC_ATTR_GUEST_STATE_ENCRYPT));
> 
> 
> This conflates TDX attestation with guest state encryption.
> 
> I think there could be meaningful ways for a confidential guest to use
> [emulated] TPM attestation rather than CC specific attestation, so I
> don't think it is a good idea to assume that the fact that we are
> running on a CoCo guest always implies that all the TCG data
> structures are of the CC variety.
> 

Okay, thank you. I'll adjust the patch again.

> 
>>   }
>>
>>   static void *tpm2_bios_measurements_start(struct seq_file *m, loff_t *pos)
>> diff --git a/drivers/firmware/efi/libstub/tpm.c b/drivers/firmware/efi/libstub/tpm.c
>> index a5c6c4f..9728060 100644
>> --- a/drivers/firmware/efi/libstub/tpm.c
>> +++ b/drivers/firmware/efi/libstub/tpm.c
>> @@ -50,7 +50,8 @@ void efi_enable_reset_attack_mitigation(void)
>>   static void efi_retrieve_tcg2_eventlog(int version, efi_physical_addr_t log_location,
>>                                         efi_physical_addr_t log_last_entry,
>>                                         efi_bool_t truncated,
>> -                                      struct efi_tcg2_final_events_table *final_events_table)
>> +                                      struct efi_tcg2_final_events_table *final_events_table,
>> +                                      bool is_cc_event)
>>   {
>>          efi_guid_t linux_eventlog_guid = LINUX_EFI_TPM_EVENT_LOG_GUID;
>>          efi_status_t status;
>> @@ -87,7 +88,8 @@ static void efi_retrieve_tcg2_eventlog(int version, efi_physical_addr_t log_loca
>>                          last_entry_size =
>>                                  __calc_tpm2_event_size((void *)last_entry_addr,
>>                                                      (void *)(long)log_location,
>> -                                                   false);
>> +                                                   false,
>> +                                                   is_cc_event);
>>                  } else {
>>                          last_entry_size = sizeof(struct tcpa_event) +
>>                             ((struct tcpa_event *) last_entry_addr)->event_size;
>> @@ -123,7 +125,8 @@ static void efi_retrieve_tcg2_eventlog(int version, efi_physical_addr_t log_loca
>>                          header = data + offset + final_events_size;
>>                          event_size = __calc_tpm2_event_size(header,
>>                                                     (void *)(long)log_location,
>> -                                                  false);
>> +                                                  false,
>> +                                                  is_cc_event);
>>                          /* If calc fails this is a malformed log */
>>                          if (!event_size)
>>                                  break;
>> @@ -157,6 +160,7 @@ void efi_retrieve_eventlog(void)
>>          efi_tcg2_protocol_t *tpm2 = NULL;
>>          efi_bool_t truncated;
>>          efi_status_t status;
>> +       bool is_cc_event = false;
>>
>>          status = efi_bs_call(locate_protocol, &tpm2_guid, NULL, (void **)&tpm2);
>>          if (status == EFI_SUCCESS) {
>> @@ -186,11 +190,12 @@ void efi_retrieve_eventlog(void)
>>
>>                  final_events_table =
>>                          get_efi_config_table(EFI_CC_FINAL_EVENTS_TABLE_GUID);
>> +               is_cc_event = true;
>>          }
>>
>>          if (status != EFI_SUCCESS || !log_location)
>>                  return;
>>
>>          efi_retrieve_tcg2_eventlog(version, log_location, log_last_entry,
>> -                                  truncated, final_events_table);
>> +                                  truncated, final_events_table, is_cc_event);
>>   }
>> diff --git a/drivers/firmware/efi/tpm.c b/drivers/firmware/efi/tpm.c
>> index cdd4310..ca8535d 100644
>> --- a/drivers/firmware/efi/tpm.c
>> +++ b/drivers/firmware/efi/tpm.c
>> @@ -12,6 +12,7 @@
>>   #include <linux/init.h>
>>   #include <linux/memblock.h>
>>   #include <linux/tpm_eventlog.h>
>> +#include <linux/cc_platform.h>
>>
>>   int efi_tpm_final_log_size;
>>   EXPORT_SYMBOL(efi_tpm_final_log_size);
>> @@ -23,7 +24,8 @@ static int __init tpm2_calc_event_log_size(void *data, int count, void *size_inf
>>
>>          while (count > 0) {
>>                  header = data + size;
>> -               event_size = __calc_tpm2_event_size(header, size_info, true);
>> +               event_size = __calc_tpm2_event_size(header, size_info, true,
>> +                                    cc_platform_has(CC_ATTR_GUEST_STATE_ENCRYPT));
>>                  if (event_size == 0)
>>                          return -1;
>>                  size += event_size;
>> diff --git a/include/linux/tpm_eventlog.h b/include/linux/tpm_eventlog.h
>> index 891368e..b3380c9 100644
>> --- a/include/linux/tpm_eventlog.h
>> +++ b/include/linux/tpm_eventlog.h
>> @@ -143,6 +143,7 @@ struct tcg_algorithm_info {
>>    * @event:        Pointer to the event whose size should be calculated
>>    * @event_header: Pointer to the initial event containing the digest lengths
>>    * @do_mapping:   Whether or not the event needs to be mapped
>> + * @is_cc_event:  Whether or not the event is from a CC platform
>>    *
>>    * The TPM2 event log format can contain multiple digests corresponding to
>>    * separate PCR banks, and also contains a variable length of the data that
>> @@ -159,7 +160,8 @@ struct tcg_algorithm_info {
>>
>>   static __always_inline u32 __calc_tpm2_event_size(struct tcg_pcr_event2_head *event,
>>                                           struct tcg_pcr_event *event_header,
>> -                                        bool do_mapping)
>> +                                        bool do_mapping,
>> +                                        bool is_cc_event)
>>   {
>>          struct tcg_efi_specid_event_head *efispecid;
>>          struct tcg_event_field *event_field;
>> @@ -201,8 +203,14 @@ static __always_inline u32 __calc_tpm2_event_size(struct tcg_pcr_event2_head *ev
>>          count = event->count;
>>          event_type = event->event_type;
>>
>> -       /* Verify that it's the log header */
>> -       if (event_header->pcr_idx != 0 ||
>> +       /*
>> +        * Verify that it's the log header. According to the TCG PC Client
>> +        * Specification, when identifying a log header, the check for a
>> +        * pcr_idx value of 0 is not required. For CC platforms, skipping
>> +        * this check during log header is necessary; otherwise, the CC
>> +        * platform's log header may fail to be recognized.
>> +        */
>> +       if ((!is_cc_event && event_header->pcr_idx != 0) ||
>>              event_header->event_type != NO_ACTION ||
>>              memcmp(event_header->digest, zero_digest, sizeof(zero_digest))) {
>>                  size = 0;
>> --
>> 2.7.4
>>


