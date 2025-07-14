Return-Path: <linux-efi+bounces-4303-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DA3FB0348C
	for <lists+linux-efi@lfdr.de>; Mon, 14 Jul 2025 04:38:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 004837A2FA7
	for <lists+linux-efi@lfdr.de>; Mon, 14 Jul 2025 02:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A1D51B041A;
	Mon, 14 Jul 2025 02:38:18 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11B14156C40;
	Mon, 14 Jul 2025 02:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752460698; cv=none; b=QFSPyPt5SILFpAHzdCkF94IJob2YbNeEZ3Wgt3WUK/gTzfOaVh6gQQeH0Kuife8/9+79hAYrHxcZ7xarQWO+e9bLVOmVlK2x+ecLQjDiK3j6f98vWtLC5Op0TQ7u9nnHCqwpqh/xPPtfu1yH3AIZYMrj/xsvyhq9Np2+BV0hO5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752460698; c=relaxed/simple;
	bh=tBDQ6T9SB15vLOX23t6RWLMsn+1lBLsQh50/3NqT1rM=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=pojXMwpNcgxFRkfR70XD1bub19HPZFAXTSz68tV5dFt8McE7jVIqSYvE4J+PvT0V8Rndbe0riFAJkS0chMbN/4GwuEJGfLk8DkvQ6ASdzJ2hK67eRSVVvyoF3tzw/1dTof+hdoiRJBmcjTfJxtWKcgwDenDqB1qVho7OzSsJM8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.62])
	by gateway (Coremail) with SMTP id _____8CxqmqKbXRo2usoAQ--.44718S3;
	Mon, 14 Jul 2025 10:38:02 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
	by front1 (Coremail) with SMTP id qMiowJAxE+SDbXRoXzwWAA--.55950S3;
	Mon, 14 Jul 2025 10:37:57 +0800 (CST)
Subject: Re: [PATCH] rtc: efi: Add runtime check for the wakeup service
 capability
To: Ard Biesheuvel <ardb@kernel.org>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Feng Tang <feng.tang@linux.alibaba.com>, linux-rtc@vger.kernel.org,
 linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250710084151.55003-1-feng.tang@linux.alibaba.com>
 <CAMj1kXHDFq3FZj4134CTcQZnke4t1=u6iRNNsQBvuhb3F6KurQ@mail.gmail.com>
 <CAMj1kXGiixvwsSmOz65F=OXQuHovO4DMAsJaPZ2sL3PBbMHh8A@mail.gmail.com>
 <20250711085608f4146d99@mail.local>
 <CAMj1kXEL90VvygoSk8EtQJO0cjybwpt10uHM+ufJg84LvR+Ouw@mail.gmail.com>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <af1c5ec4-9e4d-a2d9-e70b-1f182e6b5790@loongson.cn>
Date: Mon, 14 Jul 2025 10:36:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAMj1kXEL90VvygoSk8EtQJO0cjybwpt10uHM+ufJg84LvR+Ouw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAxE+SDbXRoXzwWAA--.55950S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxurWrJFyxJryxAry8ArWDAwc_yoW5XrWfpF
	WUCFWqqr15KFy8Ars2qw1Y9r1aqry3tFy8Xw1DAa4UWrn0vr1jkr40kr4Y9a9FgryrC3WY
	9Fy2qF9I93WDAagCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	XVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
	8JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
	Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E
	14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jepB-UUUUU=



On 2025/7/14 上午10:08, Ard Biesheuvel wrote:
> On Fri, 11 Jul 2025 at 18:56, Alexandre Belloni
> <alexandre.belloni@bootlin.com> wrote:
>>
>> On 11/07/2025 11:26:18+1000, Ard Biesheuvel wrote:
>>> On Fri, 11 Jul 2025 at 11:06, Ard Biesheuvel <ardb@kernel.org> wrote:
>>>>
>>>> On Thu, 10 Jul 2025 at 18:41, Feng Tang <feng.tang@linux.alibaba.com> wrote:
>>>>>
>>>>> The kernel selftest of rtc reported a error on an ARM server which
>>>>> use rtc-efi device:
>>>>>
>>>>>          RUN           rtc.alarm_alm_set ...
>>>>>          rtctest.c:262:alarm_alm_set:Alarm time now set to 17:31:36.
>>>>>          rtctest.c:267:alarm_alm_set:Expected -1 (-1) != rc (-1)
>>>>>          alarm_alm_set: Test terminated by assertion
>>>>>                   FAIL  rtc.alarm_alm_set
>>>>>          not ok 5 rtc.alarm_alm_set
>>>>>
>>>>> The root cause is, the underlying EFI firmware doesn't support wakeup
>>>>> service (get/set alarm), while it doesn't have the EFI RT_PROP table
>>>>> either. As Ard Biesheuvel clarified [1], this breaks the UEFI spec,
>>>>> which requires EFI firmware to provide a 'RT_PROP' table if it doesn't
>>>>> support all runtime services (Section 4.6.2, UEFI spec 2.10).
>>>>>
>>>>> This issue was also reproduced on ARM server from another vendor, which
>>>>> doesn't have RT_PROP table either. This means, in real world, there are
>>>>> quite some platforms having this issue, that it doesn't support wakeup
>>>>> service while not providing a correct RT_PROP table, which makes it
>>>>> wrongly claimed to support it.
>>>>>
>>>>> Add a runtime check for the wakeup service to detect and correct this
>>>>> kind of cases.
>>>>>
>>>>> [1]. https://lore.kernel.org/lkml/CAMj1kXEkzXsjm0dPhzxB+KdtzqADd4NmafKmw2rKw7mAPBrgdA@mail.gmail.com/
>>>>>
>>>>> Signed-off-by: Feng Tang <feng.tang@linux.alibaba.com>
>>>>> ---
>>>>>   drivers/rtc/rtc-efi.c | 4 +++-
>>>>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>>>>
>>>>
>>>> Thanks, I've queued this up now.
>>>>
>>>
>>> Actually, we might just remove the EFI get/set wakeup time
>>> functionality altogether, as it seems rather pointless to me to begin
>>> with.
>>>
>>> I'll send out an RFC shortly.
>>
>> I guess this is going to also solve the issue reported by loongson
>> https://lore.kernel.org/linux-rtc/20250613061747.4117470-1-wangming01@loongson.cn/
>>
>> However, please let me take care of patches in my subsystem...
>>
> 
> Apologies - I've dropped it now.
> 
> But please don't queue this, I'll send out my RFC shortly.
> 
This is similar problem on Loongarch VM when running ltp testcase rtc02, 
I do not know whether the root cause is the same, the runtime service is 
hard to debug.

Hope for RFC version :)

Regards
Bibo Mao


