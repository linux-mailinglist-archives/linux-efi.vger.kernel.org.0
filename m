Return-Path: <linux-efi+bounces-1940-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A3999B4AB
	for <lists+linux-efi@lfdr.de>; Sat, 12 Oct 2024 13:58:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57DC1B243BF
	for <lists+linux-efi@lfdr.de>; Sat, 12 Oct 2024 11:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60EA114F9CC;
	Sat, 12 Oct 2024 11:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marek.ca header.i=@marek.ca header.b="G0uPOVnP"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41091552FD
	for <linux-efi@vger.kernel.org>; Sat, 12 Oct 2024 11:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728734330; cv=none; b=chwqq3hEchBbkY0/oKMisVLZKWJH3BUdGwuXl+XlzbN/Y462BEkCbfr1Sv0A5dMqRDBg73QiIEk05o6KTTXa5R6g8Jq9s7E1oFHM29Pvvq8TrfTqTMi20Hc6O/AkwrklFi/Tyv75stl7GsdZX/cdVzJ/L67l51ZotgaCAZtxhKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728734330; c=relaxed/simple;
	bh=eUse1WaKbLNTi+lH1lFNxvAR/3Z5+DaPJh8J6RQchok=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=JdIAlXwBLPF5E51BNGhKkAbK5e9OnNEv4wcRjyq+dSV4Y+i/UjZ75/LagcfJxJoEj9Cooqc77MOWz+YMdvXAsELrw1I83tDmIJOF73CqO6z1maXjzWKOfnCoV9usr5rZEZcMm3Ir137m6ncezzz6176S+rUWzfCN1yps0bU2XJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marek.ca; spf=pass smtp.mailfrom=marek.ca; dkim=pass (2048-bit key) header.d=marek.ca header.i=@marek.ca header.b=G0uPOVnP; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marek.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marek.ca
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-45efe3c46b5so32384521cf.2
        for <linux-efi@vger.kernel.org>; Sat, 12 Oct 2024 04:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek.ca; s=google; t=1728734326; x=1729339126; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Diub50GAsamJSYxMpuxJNl2q4XzBU/QQSzsDe5urvxI=;
        b=G0uPOVnPlaEHdTMT4knYoOwCjZ8N4ezGYLG/RMmu1Tx4k8Kd5Lc6UMXyDaJ6eydT1t
         CJTo3zyNcdeolc3SJGROQWLGOczciIJKWfbNPArt1mUu2l2VKtHR54MLjWeDRQ71solV
         wzm2FJR46TaHphr3WKKvq+X6D6EH1TGs/gj2/BWFdnasU4wBqhPqpmN1iYK8Ww0flAqn
         9k/Cil9ibkZGGI0ew4v7CAr4PV4dbEo2E5GxFJcA0LnqfMPf3V+gFKn1vUL8GC55lXfi
         H0BkNq8HAhatnRPnpA2EjqObpFkmfGCicCaxwBDLn1/r1QKyV3GVz0Ur3rSJrz226D9L
         GpAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728734326; x=1729339126;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Diub50GAsamJSYxMpuxJNl2q4XzBU/QQSzsDe5urvxI=;
        b=o48PALfxDZN9vogjNMAVZyC2q1ZjUMX8+Ax9Pl32dOkXphR9nuDdDaVwNx85kH7QfI
         hCWyCLoThurO7uk1qsl4ggf+UQwMXJMkVH1xCuo6/Czqmg9jaIyjdljnhfnYQ3IixYUK
         9TN/IcLDadUZeSnLlWZbC1Kgtpi4hLl65nRRX4DS9XoDXk3HKuN/cCd6jP4mUZc17hSR
         PSk7VcoQRp3M74PdZDT2U7ghu0JGP/ezPNmsXZN8QXHnj5kGO37K08Kka1MzRyNaJ7Bw
         sCnrJBJYQpnRVymuMKPrMrXi9rzQj2OTGRl9eFL2HCGN73HO2L5az0WZW5I5RuRZ51LK
         78Rg==
X-Gm-Message-State: AOJu0YzFXbPiixsqTB8OdEhchdxlXLE03MpcMIEGg76m6qXBGonX+P2P
	QWErl+ihZpBK4o4TBcpN8KehUctqzqXfN/9Mv1jd3foBQgodHawNGDs/CVPYVaw=
X-Google-Smtp-Source: AGHT+IG48YvSRedxV9qgCtTINLv1hMQ+u3WbGEyfbf2QUOxBeV0LQCrBJBQXamJYXZzcuASZZIqS8Q==
X-Received: by 2002:a05:622a:11d6:b0:458:3a34:b7b5 with SMTP id d75a77b69052e-4604bbccd65mr84992431cf.26.1728734326462;
        Sat, 12 Oct 2024 04:58:46 -0700 (PDT)
Received: from [192.168.0.189] (modemcable125.110-19-135.mc.videotron.ca. [135.19.110.125])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46042895a9csm24040501cf.91.2024.10.12.04.58.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Oct 2024 04:58:46 -0700 (PDT)
Subject: Re: [PATCH 1/3] efi/libstub: fix efi_parse_options() ignoring the
 default command line
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org,
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Ingo Molnar <mingo@kernel.org>, open list <linux-kernel@vger.kernel.org>
References: <20241011224812.25763-1-jonathan@marek.ca>
 <CAMj1kXFstg+2j9nYCO=_=L3LAd4PYc5vO3OX4EtHfFA90BXv5Q@mail.gmail.com>
From: Jonathan Marek <jonathan@marek.ca>
Message-ID: <5364ea9f-9042-3fba-5cb1-c42ae94b0d4b@marek.ca>
Date: Sat, 12 Oct 2024 07:55:21 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAMj1kXFstg+2j9nYCO=_=L3LAd4PYc5vO3OX4EtHfFA90BXv5Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 10/12/24 3:46 AM, Ard Biesheuvel wrote:
> Hi Jonathan,
> 
> Please use a cover letter when sending more than a single patch.
> 
> On Sat, 12 Oct 2024 at 00:51, Jonathan Marek <jonathan@marek.ca> wrote:
>>
>> efi_convert_cmdline() always returns a size of at least 1 because it counts
>> the NUL terminator, so the "cmdline_size == 0" condition is not possible.
>>
>> Change it to compare against 1 to get the intended behavior: to use
>> CONFIG_CMDLINE when load_options_size is 0.
>>
>> Fixes: 60f38de7a8d4 ("efi/libstub: Unify command line param parsing")
>> Signed-off-by: Jonathan Marek <jonathan@marek.ca>
>> ---
>>   drivers/firmware/efi/libstub/efi-stub.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/firmware/efi/libstub/efi-stub.c b/drivers/firmware/efi/libstub/efi-stub.c
>> index 958a680e0660d..709ae2d41a632 100644
>> --- a/drivers/firmware/efi/libstub/efi-stub.c
>> +++ b/drivers/firmware/efi/libstub/efi-stub.c
>> @@ -129,7 +129,7 @@ efi_status_t efi_handle_cmdline(efi_loaded_image_t *image, char **cmdline_ptr)
>>
>>          if (IS_ENABLED(CONFIG_CMDLINE_EXTEND) ||
>>              IS_ENABLED(CONFIG_CMDLINE_FORCE) ||
>> -           cmdline_size == 0) {
>> +           cmdline_size == 1) {
> 
> I'd prefer it if we could keep the weirdness local to
> efi_convert_cmdline(). Would the below fix things too?
> 
> --- a/drivers/firmware/efi/libstub/efi-stub-helper.c
> +++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
> @@ -395,9 +395,7 @@
>                  }
>          }
> 
> -       options_bytes++;        /* NUL termination */
> -
> -       status = efi_bs_call(allocate_pool, EFI_LOADER_DATA, options_bytes,
> +       status = efi_bs_call(allocate_pool, EFI_LOADER_DATA, options_bytes + 1,
>                               (void **)&cmdline_addr);
>          if (status != EFI_SUCCESS)
>                  return NULL;
> 
> Note that the only other caller of efi_convert_cmdline() in x86-stub.c
> ignores this value entirely.
> 

Just changing this would just make things more broken, the following 
snprintf would remove the last character of the command line because it 
uses options_bytes.

Since this patch has a Fixes: tag, I wanted to make the fix as simple as 
possible. If you think comparing the size to 1 is "weird", the fix could 
instead check if cmdline[0] is non-NUL (or just strlen(cmdline)==0 if 
you don't like that either).

And then my followup cleanup patch can just remove the cmd_line_len 
argument from efi_convert_cmdline().

