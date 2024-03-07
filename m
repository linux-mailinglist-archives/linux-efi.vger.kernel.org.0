Return-Path: <linux-efi+bounces-762-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3784875343
	for <lists+linux-efi@lfdr.de>; Thu,  7 Mar 2024 16:36:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A1F21F24398
	for <lists+linux-efi@lfdr.de>; Thu,  7 Mar 2024 15:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 474CD12BE8E;
	Thu,  7 Mar 2024 15:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KfWyFbAA"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D7A1E49E
	for <linux-efi@vger.kernel.org>; Thu,  7 Mar 2024 15:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709825812; cv=none; b=kCKfP1e+i1ank/UxPpltFGMJt1jQlB6qmLeB+XcEaiAcSRk9LmOAG+PbgCDCIx5R0gMTwwl/roTOq0bMGj5rXyn1+VJGTQLiWgQa/mtD+dTrQIG4aZNR5wMnO8smBbckdprtHC9Ldzxtc1swEFfUboETe0JZjIIAldmqUqS5SOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709825812; c=relaxed/simple;
	bh=IXjrD7uSaj/tp7yjKULcNcZrSuLtQi8UXiYCH//8Sjo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IEsaehNpsASnjA4Hrpk7rR0rzgIyWW/rbgujM1yYbHZvsnNeb7kvoNRlF93Wr/alBP6ZDC3/U1plrRZcpA0rPeB0kcFoFAqOFJ+BHBRACtToTZTXkIhFn+PtVQspaN4LJkOYsb0jCv97CiP5ApvwV+aiKhEgmf46JTaX8XIv1hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KfWyFbAA; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709825810; x=1741361810;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=IXjrD7uSaj/tp7yjKULcNcZrSuLtQi8UXiYCH//8Sjo=;
  b=KfWyFbAAOZeFXVeAqF5j3d3qmAHt6cM8ezq1o4jb0n+iXeb0I/EkaIrP
   kSRhUcBZebDs1PWPmTzOA6fGbhgnikNOMtEdV09EchpTINgxESl9kMQlD
   qNqt9OzazcfHW5Lwui5SexXyd6zQ77JYhkGccEHnbM/74Dtf5TNKYddbw
   fOzE6QcxNWdkxckOMIGMX6rO4O5TWUnY80LJ0o6TsTPAr5Bkbj/eAbB1M
   CrJm0UZ4E6srOQTk7ILNHXYti+Nc5E9cC3xeYs/dPqxk9V0bXHpStWLCX
   j+ip781QNl42iukfWF24MhqczxyJpM6c/wPEwnSfvuOguiA5aVURTC5gK
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="15144666"
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="15144666"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 07:36:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="10120909"
Received: from pqtruong-mobl.amr.corp.intel.com (HELO [10.212.139.124]) ([10.212.139.124])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 07:36:50 -0800
Message-ID: <ee598ddd-5f23-45a7-9233-f7de1bd9364e@linux.intel.com>
Date: Thu, 7 Mar 2024 07:36:49 -0800
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Bug Report] Bug in "efi/libstub: Add get_event_log() support for
 CC platforms"
Content-Language: en-US
To: Ard Biesheuvel <ardb@kernel.org>,
 Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Ard Biesheuvel <ardb+git@google.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, linux-efi@vger.kernel.org
References: <0229a87e-fb19-4dad-99fc-4afd7ed4099a@collabora.com>
 <CAMj1kXE166VdJLWSWo7_3MDw4V3zSuYRx44Z7yqyj5mQVOdDCA@mail.gmail.com>
 <CAMj1kXGFLwsgPo9Xy_-9gaOUUO=wDd_K12ccYUhP1nWf3KLb0w@mail.gmail.com>
 <CAMj1kXG3ySsqU0v5dnC2V+xiKGxdFnY_WSOFzrqb0sr9gDT7Zw@mail.gmail.com>
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <CAMj1kXG3ySsqU0v5dnC2V+xiKGxdFnY_WSOFzrqb0sr9gDT7Zw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 3/7/24 3:30 AM, Ard Biesheuvel wrote:
> On Thu, 7 Mar 2024 at 12:13, Ard Biesheuvel <ardb@kernel.org> wrote:
>> On Thu, 7 Mar 2024 at 12:08, Ard Biesheuvel <ardb@kernel.org> wrote:
>>> Hi Muhammad,
>>>
>>> Thanks for the report.
>>>
>>> On Thu, 7 Mar 2024 at 12:02, Muhammad Usama Anjum
>>> <usama.anjum@collabora.com> wrote:
>>>> Hi,
>>>>
>>>> The recent patch:
>>>> 276805fb9c305: efi/libstub: Add get_event_log() support for CC platforms
>>>> has introduced
>>>> #define EFI_CC_EVENT_LOG_FORMAT_TCG_2   0x00000002
>>>>
>>>> But EFI_TCG2_EVENT_LOG_FORMAT_TCG_2 has the same numerical value:
>>>> #define EFI_TCG2_EVENT_LOG_FORMAT_TCG_2   0x2
>>>>
>>>> Thus there is dead code in efi_retrieve_tcg2_eventlog() i.e, multiple if
>>>> conditions with (version == 2) I'm unable to decide on what is wrong and
>>>> what is right here. Please have a look.
>>>>
>>> Why is this a problem? The compiler will recognize this and simplify
>>> the conditional. The code as written is semantically correct, the fact
>>> that the symbolic constants resolve to the same numerical value is
>>> just an implementation detail.
>> Ah hold on. I see what you mean now:
>>
>> if (version == EFI_TCG2_EVENT_LOG_FORMAT_TCG_2)
>> final_events_table = get_efi_config_table(LINUX_EFI_TPM_FINAL_LOG_GUID);
>> + else if (version == EFI_CC_EVENT_LOG_FORMAT_TCG_2)
>> + final_events_table = get_efi_config_table(LINUX_EFI_CC_FINAL_LOG_GUID);
>>
>> Yes, that is broken.
> Could we fix it like this perhaps?
>
> --- a/drivers/firmware/efi/libstub/tpm.c
> +++ b/drivers/firmware/efi/libstub/tpm.c
> @@ -75,8 +75,7 @@
>          *
>          * CC Event log also uses TCG2 format, handle it same as TPM2.
>          */
>        if (version > EFI_TCG2_EVENT_LOG_FORMAT_TCG_1_2) {
>             /*
>              * The TCG2 log format has variable length entries,
>              * and the information to decode the hash algorithms
> @@ -109,10 +108,11 @@
>      * Figure out whether any events have already been logged to the
>      * final events structure, and if so how much space they take up
>      */
>    if (version > EFI_TCG2_EVENT_LOG_FORMAT_TCG_1_2)
>        final_events_table =
>            get_efi_config_table(LINUX_EFI_TPM_FINAL_LOG_GUID) ?:
>            get_efi_config_table(LINUX_EFI_CC_FINAL_LOG_GUID);

Looks good to me. If there is a concern that a TPM config table may exists
even in CC case, we can get the table pointer under protocol check and pass
it as argument to this function.

diff --git a/drivers/firmware/efi/libstub/tpm.c b/drivers/firmware/efi/libstub/tpm.c
index c35f99f259c1..2ef1e4cd6bb2 100644
--- a/drivers/firmware/efi/libstub/tpm.c
+++ b/drivers/firmware/efi/libstub/tpm.c
@@ -49,12 +49,12 @@ void efi_enable_reset_attack_mitigation(void)
 
 static void efi_retrieve_tcg2_eventlog(int version, efi_physical_addr_t log_location,
                                       efi_physical_addr_t log_last_entry,
-                                      efi_bool_t truncated)
+                                     efi_bool_t truncated,
+                                     struct efi_tcg2_final_events_table *final_events_table)
 {
        efi_guid_t linux_eventlog_guid = LINUX_EFI_TPM_EVENT_LOG_GUID;
        efi_status_t status;
        struct linux_efi_tpm_eventlog *log_tbl = NULL;
-       struct efi_tcg2_final_events_table *final_events_table = NULL;
        unsigned long first_entry_addr, last_entry_addr;
        size_t log_size, last_entry_size;
        int final_events_size = 0;
@@ -109,10 +109,6 @@ static void efi_retrieve_tcg2_eventlog(int version, efi_physical_addr_t log_loca
         * Figure out whether any events have already been logged to the
         * final events structure, and if so how much space they take up
         */
-       if (version == EFI_TCG2_EVENT_LOG_FORMAT_TCG_2)
-               final_events_table = get_efi_config_table(LINUX_EFI_TPM_FINAL_LOG_GUID);
-       else if (version == EFI_CC_EVENT_LOG_FORMAT_TCG_2)
-               final_events_table = get_efi_config_table(LINUX_EFI_CC_FINAL_LOG_GUID);
        if (final_events_table && final_events_table->nr_events) {
                struct tcg_pcr_event2_head *header;
                int offset;
@@ -152,6 +148,7 @@ static void efi_retrieve_tcg2_eventlog(int version, efi_physical_addr_t log_loca
 
 void efi_retrieve_eventlog(void)
 {
+      struct efi_tcg2_final_events_table *final_events_table = NULL;
        efi_physical_addr_t log_location = 0, log_last_entry = 0;
        efi_guid_t tpm2_guid = EFI_TCG2_PROTOCOL_GUID;
        int version = EFI_TCG2_EVENT_LOG_FORMAT_TCG_2;
@@ -170,6 +167,8 @@ void efi_retrieve_eventlog(void)
                                                &log_location, &log_last_entry,
                                                &truncated);
                }
+               if (version == EFI_TCG2_EVENT_LOG_FORMAT_TCG_2)
+                       final_events_table = get_efi_config_table(LINUX_EFI_TPM_FINAL_LOG_GUID);
        } else {
                efi_guid_t cc_guid = EFI_CC_MEASUREMENT_PROTOCOL_GUID;
                efi_cc_protocol_t *cc = NULL;
@@ -179,6 +178,7 @@ void efi_retrieve_eventlog(void)
                        return;
 
                version = EFI_CC_EVENT_LOG_FORMAT_TCG_2;
+              final_events_table = get_efi_config_table(LINUX_EFI_CC_FINAL_LOG_GUID);
                status = efi_call_proto(cc, get_event_log, version, &log_location,
                                        &log_last_entry, &truncated);
        }
@@ -187,5 +187,5 @@ void efi_retrieve_eventlog(void)
                return;
 
        efi_retrieve_tcg2_eventlog(version, log_location, log_last_entry,
-                                  truncated);
+                                 truncated, final_events_table);
 }





-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


