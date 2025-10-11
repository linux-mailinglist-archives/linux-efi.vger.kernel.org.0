Return-Path: <linux-efi+bounces-5025-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21F31BCF113
	for <lists+linux-efi@lfdr.de>; Sat, 11 Oct 2025 09:30:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D408D427CC2
	for <lists+linux-efi@lfdr.de>; Sat, 11 Oct 2025 07:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D40FD22655B;
	Sat, 11 Oct 2025 07:29:56 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00BEB190664;
	Sat, 11 Oct 2025 07:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760167796; cv=none; b=fj/LiHV0c+0T+Ahw5Xhq4mk86jt+2Rf7lcTxzn97SX4Fu+Pmdeygj7ytrJIUYgBtbpngjCx5FZKT+JOhs3OnP3SGi0bCR3FpwEkxHvd33+Y0Lpr45VAd5350sgsGfk1kSTonMFU06+lq3g4HXZ5MF45z3DEs4mE4DQsRN/Pk8U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760167796; c=relaxed/simple;
	bh=/rd2ExXxfY8mQaCM10OES977zZ7AnGo3Lstk2daeBCo=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=EehetppSy5P1GHtrqMKJIjuj6TU8kUyJgWHBEqWf/99iQhgR7wbHKvXvewSoX3A09GKtyYubrxgABWQMuNQ9CwjkEWBIBdQs0AgU8W6HtIBp5w4PpE60oYthKDWKoYsI2H3VhKSkoSwyZ0w1LNC72r3PloZV0XWSgqmize7YpxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8Bx1tBsB+poSvoUAA--.44669S3;
	Sat, 11 Oct 2025 15:29:48 +0800 (CST)
Received: from [10.130.10.66] (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJAxusBrB+poDevZAA--.1109S3;
	Sat, 11 Oct 2025 15:29:48 +0800 (CST)
Subject: Re: [PATCH v2] efistub: Only link libstub to final vmlinux
To: Ard Biesheuvel <ardb@kernel.org>, Huacai Chen <chenhuacai@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, loongarch@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org,
 linux-efi@vger.kernel.org, linux-kbuild@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250928085506.4471-1-yangtiezhu@loongson.cn>
 <CAMj1kXG8Wi+THa2SeLxiDT=+t_TKx0AL4H-azZO4DNJvyyv96g@mail.gmail.com>
 <CAAhV-H7xOf8DEwOrNh+GQGHktOT4Ljp+7SqutGvvDZp6GLXJrA@mail.gmail.com>
 <CAMj1kXG=EFkRAMkvKMSjPixoGqU-tZXVoRkJJ6Wcnzs3x52X6Q@mail.gmail.com>
 <CAMj1kXHWe2uGY3S1NJ6mckqD4n116rPmaOzw3_Qbvxyjh7ECMw@mail.gmail.com>
 <fec0c03d-9d8c-89a3-886a-1adc22e59b66@loongson.cn>
 <CAMj1kXFLyBbRL+pAAQ6be6dxqFPiyw_Ug8qNQWaicZQ235HE=A@mail.gmail.com>
 <8091e8fa-3483-af39-2f7a-e4eb62b0944f@loongson.cn>
 <CAAhV-H4+UGLSkbjHbq9MerWfxnq0a13x+uzNfTsCoe1UxjbWsg@mail.gmail.com>
 <CAMj1kXH-rK0bRyHXdJ-crAyMyvJHApH0WR7_8Qd8vrSPBLK+yg@mail.gmail.com>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <0c9b8e6a-96a6-91d4-946f-2109f48a529b@loongson.cn>
Date: Sat, 11 Oct 2025 15:29:47 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAMj1kXH-rK0bRyHXdJ-crAyMyvJHApH0WR7_8Qd8vrSPBLK+yg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAxusBrB+poDevZAA--.1109S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7WF43GF17tw43Jr4ftFy7urX_yoW8KrW8pF
	WjkFWYkF4rZr4UXw1vyayjvrWaqrs3trWUKasxXryfZan8Xr4aqr4Y9w1q9F4kJrZ7W3W2
	va1xtr9Iyayqy3gCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AK
	xVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
	Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE
	14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1c
	AE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
	rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8Zw
	CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x02
	67AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
	0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8vA
	pUUUUUU==

On 2025/10/11 上午11:40, Ard Biesheuvel wrote:
> On Fri, 10 Oct 2025 at 19:54, Huacai Chen <chenhuacai@kernel.org> wrote:
>>
>> On Sat, Oct 11, 2025 at 9:13 AM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>>>
>>> On 2025/10/11 上午12:25, Ard Biesheuvel wrote:
>>> ...
>>>> Why do we need both (1) and (2)?
>>>
>>> Not both, either (1) or (2).
>>> Which one do you prefer? Or any other suggestions?
>>>
>>> Taking all of the considerations in balance, we should decide
>>> what is the proper way.
>> As a summary, there are three methods:
>> (1) Only link libstub with vmlinux.o during the final vmlinux link.
>> (2) Remove the attribute __noreturn for real_kernel_entry() and add while (1).
>> (3) Ignore "__efistub_" prefix in objtool.
>>
>> Josh prefers method (1), I prefer method (3) but also accept method
>> (1) if it is not only specific to loongarch.
>>
> 
> This is a false positive warning in objtool, which complains about a
> function that falls through, even though that can never happen in
> reality.
> 
> To me, it is not acceptable to modify how vmlinux.o is constructed
> also for other architectures, in order to hide some of its constituent
> parts from objtool, which do not use objtool to begin with.
> 
> 
> If you are not willing to fix objtool, I suggest fixing the loongarch
> code like this:

Thank you.

> --- a/drivers/firmware/efi/libstub/loongarch.c
> +++ b/drivers/firmware/efi/libstub/loongarch.c
> @@ -10,7 +10,7 @@
>   #include "efistub.h"
>   #include "loongarch-stub.h"
> 
> -typedef void __noreturn (*kernel_entry_t)(bool efi, unsigned long cmdline,
> +typedef void (*kernel_entry_t)(bool efi, unsigned long cmdline,
>                                            unsigned long systab);
> 
>   efi_status_t check_platform_features(void)
> @@ -81,4 +81,6 @@
> 
>          real_kernel_entry(true, (unsigned long)cmdline_ptr,
>                            (unsigned long)efi_system_table);
> +
> +       return EFI_LOAD_ERROR;
>   }

I tested the above changes, the falls through objtool warning can
be fixed because efi_boot_kernel() ends with a return instruction,
I think this is reasonable.

efi_boot_kernel() has a return value, there are "return status" in
other parts of efi_boot_kernel(), it should also return at the end
of efi_boot_kernel() in theory, although we should never get here.

If there are more comments, please let me know.

Thanks,
Tiezhu


