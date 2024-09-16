Return-Path: <linux-efi+bounces-1784-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E061979FB5
	for <lists+linux-efi@lfdr.de>; Mon, 16 Sep 2024 12:47:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBF0F287192
	for <lists+linux-efi@lfdr.de>; Mon, 16 Sep 2024 10:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7559314EC4B;
	Mon, 16 Sep 2024 10:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OwbqEI51"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C607B34CC4;
	Mon, 16 Sep 2024 10:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726483654; cv=none; b=Sgz4ihet8mT8xzzEzAmRbLhnqOeem1CchSYs3Di70kAl5fYRovEe9LdQeqzs1jNl0iCzjP70ojnMYog537wLiHUKcaIv5cpaUxXmSd4ko/n0mhGTlSrEdYnDN72McPWAotGl3mt9ubOA62jeF3Zrk+vSZ5PYm+iMwfGqapm37H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726483654; c=relaxed/simple;
	bh=LwPMTDOEgB8HyD450hSuRIBCkam14G4uFTnIfXIGh7s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TLHTjXgQZ+kmEuNZL34UKR5w44OtjkfW2OtDHYC0zSgNS4y3sjcExhjdYVjULtiDvNzn4ZC/Lq92dTf3nbdvPSYl/Ron0b68BIlFJ6hWxijgm9v1An4ggbB3/3kV9foVJIxFRTX/U/qldcWPTZL9D+PgTITsLEAq9A9Oi3g+Lck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OwbqEI51; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-375e5c12042so2319359f8f.3;
        Mon, 16 Sep 2024 03:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726483651; x=1727088451; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FUfSPTxRR+PneERlzFcQtWtgSIwzFTWRZQHaHy/Sf94=;
        b=OwbqEI510dGSlRWDDj5clhnAOBwijvE+AnCbjYxFqyGFQh2ywgyZJ7MtBsnEpPYR70
         IzswH/MPLmP82z4eVdjN9qxFwUSdj3ueRSEur3l9D8OjopM0u//u+cGW9h7iWQOlsKVW
         S2RDLnhIQVFXe9yKIW7TbVii2yxUBBNTUVxzWB9+H6JGF9fcZINI+cwwss6moO0gv0A0
         v55fFCbkVd/enPbgLzpeboyqfgX0cK9+1dWuhXf47dxnfrjEnpJ5J/4DbyDSOoHX526A
         7Vq3sbGh3C+0D1uRMYV5xq0MnZMT8EkZxQwW4+Laq6G8stBD0G49/toi/OWDOYUhB8Bm
         OnxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726483651; x=1727088451;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FUfSPTxRR+PneERlzFcQtWtgSIwzFTWRZQHaHy/Sf94=;
        b=NibTpsylZeFwM78x4Dd7GByEOKmtp/oFAcWdhYNjQbK3kKQGB47ptyKo1vy0dmzEwv
         TRWwN5XbiB4lRxAFcSmJcbpib1Uj2MHZOY9TPLwldkueI5H+gm/H8zvDnwvcAWkEzN6P
         ZpCChgA4ULxkGvDyAgXT3XaMtV9bTxpbheDjcRzkrmYX6/W0iDJXDHuE3pfGXXy8fZTw
         olAC/GmO7rN7u7RJRFKGpkCkKA48WmhYGXLwu7ACoGC9rB1kQXsaiw/BEls11ysbk8Z/
         3V7S22jINK9CUFL6tYGZOA9RdgEhZ+DUO0iOLUulQ1jOEk287gyJsPcTT/6xS9nP7Oec
         cSGg==
X-Forwarded-Encrypted: i=1; AJvYcCUOgLVE3NrBVgTrhp8QY8QzfvmNGemDt9IIxo+zMASESeCOsQM10gBSOVn9XknZQVwl4Fpq96JXQW3zx30=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy20AhkifntGmWJxJ90CI7KMeRmN7LN/Nm9UAAD6rxsLXQLUVUG
	Q+ga0T92bqsUWlJNGbXB5YwlNnIvhIrHp1wR/iAe9NhW+WPjjYN7
X-Google-Smtp-Source: AGHT+IH9HrOfNBxvdg4E0kJYcBtVVCCv1F4onM6EWVNYOWevwv05LUffHKOcwAF/sp4lve9y0JIT4Q==
X-Received: by 2002:adf:fbc3:0:b0:374:cb5c:2966 with SMTP id ffacd0b85a97d-378c2d5a6f5mr8415481f8f.40.1726483650173;
        Mon, 16 Sep 2024 03:47:30 -0700 (PDT)
Received: from ?IPV6:2a02:6b6f:e750:7600:c5:51ce:2b5:970b? ([2a02:6b6f:e750:7600:c5:51ce:2b5:970b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e73e8388sm6881772f8f.32.2024.09.16.03.47.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Sep 2024 03:47:29 -0700 (PDT)
Message-ID: <c23b8ec6-117f-4843-af37-507961520482@gmail.com>
Date: Mon, 16 Sep 2024 11:47:29 +0100
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] tpm: do not ignore memblock_reserve return value
To: Ard Biesheuvel <ardb@kernel.org>, Gregory Price <gourry@gourry.net>,
 Dave Young <dyoung@redhat.com>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
 leitao@debian.org, sathyanarayanan.kuppuswamy@linux.intel.com,
 ilias.apalodimas@linaro.org
References: <20240913231954.20081-1-gourry@gourry.net>
 <20240913231954.20081-3-gourry@gourry.net>
 <CAMj1kXH+QE+C78n84jRUn6ACUPbO9pU_EeeTcTa-nWitCKpt-Q@mail.gmail.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <CAMj1kXH+QE+C78n84jRUn6ACUPbO9pU_EeeTcTa-nWitCKpt-Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 16/09/2024 09:29, Ard Biesheuvel wrote:
> (cc Dave)
> 
> On Sat, 14 Sept 2024 at 15:26, Gregory Price <gourry@gourry.net> wrote:
>>
>> tpm code currently ignores a relevant failure case silently.
>> Add an error to make this failure non-silent.
>>
>> Signed-off-by: Gregory Price <gourry@gourry.net>
>> ---
>>  drivers/firmware/efi/tpm.c | 7 ++++++-
>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/firmware/efi/tpm.c b/drivers/firmware/efi/tpm.c
>> index 9c3613e6af15..b0cc2cc11d7e 100644
>> --- a/drivers/firmware/efi/tpm.c
>> +++ b/drivers/firmware/efi/tpm.c
>> @@ -61,7 +61,12 @@ int __init efi_tpm_eventlog_init(void)
>>         }
>>
>>         tbl_size = sizeof(*log_tbl) + log_tbl->size;
>> -       memblock_reserve(efi.tpm_log, tbl_size);
>> +       if (memblock_reserve(efi.tpm_log, tbl_size)) {
>> +               pr_err("TPM Event Log memblock reserve fails (0x%lx, 0x%x)\n",
>> +                      efi.tpm_log, tbl_size);
>> +               ret = -ENOMEM;
>> +               goto out;
>> +       }
>>
> 
> Given the discussion in the other thread, I wonder if this should be
> efi_mem_reserve() instead - might as well fix that too.
> 
> Dave?

I dont believe efi_mem_reserve is needed after your patch in
https://lore.kernel.org/all/20240912155159.1951792-2-ardb+git@google.com/

which will cover both kexec_load and kexec_file_load cases.

Thanks,
Usama

