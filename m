Return-Path: <linux-efi+bounces-5401-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF9EC44B74
	for <lists+linux-efi@lfdr.de>; Mon, 10 Nov 2025 02:19:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B1E13A62C3
	for <lists+linux-efi@lfdr.de>; Mon, 10 Nov 2025 01:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52DCF200C2;
	Mon, 10 Nov 2025 01:19:01 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF536EAC7;
	Mon, 10 Nov 2025 01:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762737541; cv=none; b=upIVGTTUi6+K5a4e/0IfVCW4ZfI/O2M7NAtRKJIaxamH/hwu2AxUDz38Zu0ABzqJEGq9bHl/HJV/2d+SUlC5Nwpt9s0eEyoS/nq1qkVoWty5RToLVUQwGG77b6pe2oLhfgV5tRjRpu7zU3KanKvn5rSUpnpzL0o3gDLB3i49w7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762737541; c=relaxed/simple;
	bh=6TfcSbOhHdyMDVVM7y/Rj5ZPd2q5rSk9xlpPkTokdJY=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=nKweMJmggTgmelF5QXzwjdLuK1kUBKGqVozOKvdVLLF7LHFmkoUu3poQ8Lg10EW5V9NIFHciIfiGPTbUy3y+kkuwCOGv28qVJ5GTxnOFLm1viB3370ZA7+YBV6eDDSaHU/LaL446TDYNce5psD319VD5KPKF2Wd9XtRXfCqeFaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8Dx9tB+PRFpozkhAA--.1636S3;
	Mon, 10 Nov 2025 09:18:54 +0800 (CST)
Received: from [10.130.10.66] (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJCxocJ7PRFpRHMtAQ--.64632S3;
	Mon, 10 Nov 2025 09:18:52 +0800 (CST)
Subject: Re: [PATCH v2] efistub: Only link libstub to final vmlinux
To: Ard Biesheuvel <ardb@kernel.org>, Huacai Chen <chenhuacai@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, loongarch@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org,
 linux-efi@vger.kernel.org, linux-kbuild@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <CAAhV-H7HN128du-b1Rk_9qbYBq7gMSwo0s31909N4pTou6wzew@mail.gmail.com>
 <rhnei6wovxmoqs36wdysomfsul3faxtmgde73wrrqdt3qo3b2j@akd7vzne76rq>
 <CAMj1kXF+hDJy0vRWNgwoijHxvA-scvhGODMj9A3dv19v3jf2yw@mail.gmail.com>
 <lgyzruqczm7uti2lfbhfhr5hyzpnm7wtvgffa2o7nigx76g6i3@wlffltvmhhez>
 <CAMj1kXFDquPxCYSBWgjikS=209pSJ_kth67M0RDeuetV9CPYAw@mail.gmail.com>
 <wlx6pt5crtfdwtop4w5vjznjfarrwitq44wdbufncjdvtsx647@tgobruak66yb>
 <CAMj1kXFfEBkcc-aiwGrRR-pKg4LBbS7weK0pEpZJsKOk5pbkuA@mail.gmail.com>
 <jxfb5a2c2qber623l2gwewirwod54bbgfnvt7t7f3jah2ea33g@2uyhy3auzmpx>
 <d9f3352a-1c1f-464a-a8fd-741cd96b5f8e@loongson.cn>
 <CAAhV-H6m5vszCyiF3qi94cpHBPVuqM2xH93D=gfsQqOSYvC-sA@mail.gmail.com>
 <33612d85-e70b-26da-8460-ea6b9064ce08@loongson.cn>
 <CAAhV-H5ZSTFDxvm-W1CrgEoQ5d_jw5yVsfetQ_J_qL5pqLtzgg@mail.gmail.com>
 <CAMj1kXGk0udgM67wrWqahqK8H0uE8emQj51SmJey+7fE-FTjdA@mail.gmail.com>
 <CAAhV-H4c=vdNWO0v_mYL2xZ9FYjDyRDvt6f_kV4d8Bh=CRJniQ@mail.gmail.com>
 <CAMj1kXEaxxcWTTANWeEMNjYDymdL5Fxy2B=XBF4RGtteEkfinw@mail.gmail.com>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <421c08e1-255b-447b-b5e3-ee6544fbefd2@loongson.cn>
Date: Mon, 10 Nov 2025 09:18:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAMj1kXEaxxcWTTANWeEMNjYDymdL5Fxy2B=XBF4RGtteEkfinw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCxocJ7PRFpRHMtAQ--.64632S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7KrW8Kry5Cw1xWr13CFWrtFc_yoW5JryxpF
	WxJF1jkF4DAr4xZ3Z7tw4j9Fy7tryDJr18Ww1rtry5Awn09w1rJr48JF1jkFyUJr1xGFyj
	yr47tFZ7XF4Dt3gCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv
	67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
	AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
	F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GF
	ylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
	xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
	1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8zw
	Z7UUUUU==

On 2025/10/28 下午9:47, Ard Biesheuvel wrote:
> On Sun, 26 Oct 2025 at 12:20, Huacai Chen <chenhuacai@kernel.org> wrote:
>>
>> On Thu, Oct 23, 2025 at 4:07 PM Ard Biesheuvel <ardb@kernel.org> wrote:
>>>
>>> On Thu, 23 Oct 2025 at 10:01, Huacai Chen <chenhuacai@kernel.org> wrote:
>>>>
>>>> On Thu, Oct 23, 2025 at 2:55 PM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>>>>>
>>>>> Hi Josh and Ard,
>>>>>
>>>>> On 2025/10/20 下午2:55, Huacai Chen wrote:
>>>>>> On Mon, Oct 20, 2025 at 9:24 AM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>>>>>>>
>>>>>>> Hi Josh, Ard and Huacai,
>>>>>>>
>>>>>>> On 2025/10/18 上午1:05, Josh Poimboeuf wrote:
>>>>>>>
>>>>>>> ...
>>>>>>>
>>>>>>>> But IIUC, the libstub code runs *very* early, and wouldn't show up in a
>>>>>>>> stack trace anyway, because there are no traces of it on the stack once
>>>>>>>> it branches to head.S code (which doesn't save the link register).
>>>>>>>
>>>>>>> Thanks for your discussions.
>>>>>>>
>>>>>>> Are you OK with this current patch?
>>>>>> For me the current patch is just OK.
>>>>>
>>>>> We have discussed this a few times but there is almost no consensus
>>>>> of what should happen next and nothing changes.
>>>>>
>>>>> Could you please give me a clear reply? Then I can make progress for
>>>>> the following series:
>>>>>
>>>>> https://lore.kernel.org/loongarch/20250917112716.24415-1-yangtiezhu@loongson.cn/
>>>> For me, this patch is OK, ignore __efistub_ prefix in objtool is also
>>>> OK [1]. But I cannot accept the way that modifying the efistub part
>>>> only for LoongArch.
>>>>
>>>> Clear enough?
>>>>
>>>
>>> LoongArch is the only architecture which has the problem, so I don't
>>> see a reason to modify other architectures.
>>  From your reply I think the efistub code is completely right, but
>> objtool cannot handle the "noreturn" function pointer. And this patch
>> is a workaround rather than a proper fix (so you don't want to touch
>> other architectures), right?
>>
> 
> That is my reasoning, yes. But Josh is right that it shouldn't make a
> difference in practice, I am just reluctant to make changes to the
> code running on the target to accommodate a flawed build time tool.

If I understand correctly, I should modify this patch to remove the
changes of arm and riscv for now, do the changes only when there is
a real problem or requirement some day, right? If no more comments,
I will send v3 later.

Thanks,
Tiezhu


