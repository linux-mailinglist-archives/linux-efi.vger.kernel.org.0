Return-Path: <linux-efi+bounces-2808-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C60A3DB72
	for <lists+linux-efi@lfdr.de>; Thu, 20 Feb 2025 14:38:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EF1519C2221
	for <lists+linux-efi@lfdr.de>; Thu, 20 Feb 2025 13:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D00191F4E49;
	Thu, 20 Feb 2025 13:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RIBcqeio"
X-Original-To: linux-efi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37268288A2
	for <linux-efi@vger.kernel.org>; Thu, 20 Feb 2025 13:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740058688; cv=none; b=hjFTbrFL5PIIJ7kGyNR5HaFBEcqrgUJCTyJzmzunC+ochi8VZCP6dYwWJ6Ok3HGE/9ZQT+CPvxj9auZOfycWVCq6P7TuO0+4hIg3B4lbb4ZTzrZYaNEr1cGW2DK1quL5mn67PGupertkXvOtaGLs0pdeFFqcYeetTUvIUkVrNSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740058688; c=relaxed/simple;
	bh=WNKbmhVzaLRevjnTrEfwgemOd0VZkuLBY85NCuL/Uvc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kVtUr/aYLqR2wlgQvqket7+u7mhR+ljKSy2AOI0lRDp8odJ1AgwB6XtfX+7XkBCUNysUWvGPHa1gvE9Rb14KYEJka+CBOR/r4jpgumo43NeG+BR9T4JpeSfAtlu/9rM0Q5g76HmLeXrzmsK8toWjq88CwPNXDCe7j9aHXj//mSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RIBcqeio; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740058686;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3Z6Y+QONZzHviDlS3Fl6zxksjOSMCbAcq5j75r4OI3s=;
	b=RIBcqeioSP4DPrNXRMg9nyv6jGRGgso+6NljerK1gYllacndNQCfJ0wlAXjvxCoqyMMCVc
	X6D8HTpqo5VQ0hKK+7s4jgkLCiUPDIzlZfS+WCrRy0E9HRracJYgBkQqTiQV8TJblZlpCr
	Iw65zJAmzxTUURbqYSqzBgZSEVITwsU=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-do2A_cMbNS2X8VNrzmsogA-1; Thu, 20 Feb 2025 08:38:04 -0500
X-MC-Unique: do2A_cMbNS2X8VNrzmsogA-1
X-Mimecast-MFC-AGG-ID: do2A_cMbNS2X8VNrzmsogA_1740058684
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5e0412dd901so1478483a12.2
        for <linux-efi@vger.kernel.org>; Thu, 20 Feb 2025 05:38:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740058683; x=1740663483;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3Z6Y+QONZzHviDlS3Fl6zxksjOSMCbAcq5j75r4OI3s=;
        b=A71dc2vqs0YcbFQeVQL+oRFd2juwoci+EePSSZnA4i36u48lfQaGYpvRTcZ63lw9ZC
         b/Gas6kiTlO1b7ipVA7Tt2TeVBwUF/+e5zdDsAaCmsWevVI7/LRKQSI0UBRMU0SfjZo6
         iVi9HNKAPwRC/NHiW9G74rZs8FOfdeYkvgdFwPteux5kKjm0pjhmSgWCd1su6N3cFRoM
         7qzt4EQ6PFVQURPWewgkood4catM4VIbFf4qykHkE5iO38HZRR07c0+UWI+/MkOh0vZ0
         XxXY1QKKgqK4m/7H+dXlvk4epOl3soQ3Ek/YePyk8wk1l5ASqVyrztrH0RuKUYTHFJaM
         wloQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFoNXCwyBBqPRiyD042KuINjMcn8iriauykrQpAyVnvYZgvZ6ESYQyRVBwDFFMcRfvN8l4mentKD4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqPs8acniFJh6p80GzLvUtWHqrJ/yGQySfEQOb8I2gyNJm0S+9
	lU7q46uIkj/w3BVY22fJ4/2bWIrF2e3eO+A5iQWjz4h+FShy+0rxLtpyDWe4S1LGr4xcv40rKot
	OXCM8CnmjS1YZUQ8GfZ0OFgNPbHwno9+hyto+6i8EbXlM8pajG3YDX1xGAQ==
X-Gm-Gg: ASbGncu8vMKFLn3Mkv409M41AB8kGfKVCEI/Vt6dsgb3ySQFb3Y4DvIcYQo/AnPkqeU
	7rrkEUj+y4j2G9xG6UhpioF9OtqoPRwB7SgMEO9Uz9Rupxp1IfBzesJMZnZgT3kGJNA8JK1x7FC
	reqE3q7XQY8lbMgiqnTgzxMrw03spt76/D2/pt5ZOFRGZa5QfLaxSBrJ1dyMwxVFHhsmCsMkoQh
	BuUjsvRdG0KASkGmQhR8aCfOYYtF8bAYdV4o0XMp6zKXotob0Z0rT28BP153COndRo6ujM4vbIH
	WXm3UKZWaYz3MzImOqAV4U70eQKmFlSkjGwEHIvb2NCxXW1viiKMyfW1Cvl3pwiW+sS28SpoGO5
	lnchDj/Cm9fDlVZDXxE65k+OCEfPqVUp74sTieLzPp4b3A5tgQm2eKWI=
X-Received: by 2002:a05:6402:13c8:b0:5e0:82a0:50e6 with SMTP id 4fb4d7f45d1cf-5e0a4bae5bfmr2165524a12.20.1740058683570;
        Thu, 20 Feb 2025 05:38:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFKE4U1hhxsYM4lR+FS5y2jvGSFIPFR+2C4tFcThGLFAJbNRyPYrf/RJxsYafAikDdN33UGPw==
X-Received: by 2002:a05:6402:13c8:b0:5e0:82a0:50e6 with SMTP id 4fb4d7f45d1cf-5e0a4bae5bfmr2165505a12.20.1740058683176;
        Thu, 20 Feb 2025 05:38:03 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dece1d3624sm12316054a12.40.2025.02.20.05.38.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 05:38:01 -0800 (PST)
Message-ID: <2d4924d6-1ae3-4993-a6b0-aae6f00bab88@redhat.com>
Date: Thu, 20 Feb 2025 14:38:01 +0100
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] x86/efi/mixed: Decouple from legacy decompressor
To: Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>
Cc: Ingo Molnar <mingo@kernel.org>, linux-efi@vger.kernel.org,
 linux-kernel@vger.kernel.org, x86@kernel.org
References: <20250210174941.3251435-9-ardb+git@google.com>
 <CAMj1kXHOqMM5uGxLTYuEf9KrxY5WzYvwo847JzoB-Qa2SN67Sg@mail.gmail.com>
 <20250220124831.GFZ7cknypjWiZoZzK5@fat_crate.local>
 <CAMj1kXEkkShwDfbwJ5abc9Q+LaqbvTNh1O5rVXy3EW85DdYTuQ@mail.gmail.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAMj1kXEkkShwDfbwJ5abc9Q+LaqbvTNh1O5rVXy3EW85DdYTuQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Ard,

On 20-Feb-25 1:54 PM, Ard Biesheuvel wrote:
> On Thu, 20 Feb 2025 at 13:48, Borislav Petkov <bp@alien8.de> wrote:
>>
>> On Thu, Feb 20, 2025 at 12:29:30PM +0100, Ard Biesheuvel wrote:
>>> Unless anyone minds, I'd like to queue this up in the EFI tree.
>>>
>>> Boris, Ingo?
>>
>> FWIW, it looks like a nice cleanup to me and it boots in my 64-bit OVMF guest
>> but that doesn't mean a whole lot.
>>
> 
> Thanks. For the record, I tested this both on 32-bit OVMF and on a
> mixed mode tablet (with 32-bit AMI firmware) that I keep for testing
> purposes. Notably, 32-bit OVMF boots with paging (and PAE) enabled
> whereas the AMI firmware doesn't.

Ah good to know that you're still using the mixed-mode tablet
for testing.

I've just added this series to my personal kernel testing-tree which
I regularly boot on various models of these kinda tablets. I'll let
you know if I hit any problems.

> Not sure how many users of mixed mode remain

I think the 32 bit mixed-mode Intel Bay Trail tablets are still
somewhat popular I still get occasional inquiries about when we will
finally have the cameras working on them :)

Regards,

Hans



