Return-Path: <linux-efi+bounces-5653-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55164C7CDCA
	for <lists+linux-efi@lfdr.de>; Sat, 22 Nov 2025 12:07:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07D603AB7B4
	for <lists+linux-efi@lfdr.de>; Sat, 22 Nov 2025 11:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E1F12FCC16;
	Sat, 22 Nov 2025 11:04:55 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF2DD2EE611;
	Sat, 22 Nov 2025 11:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763809494; cv=none; b=LPUniMNI3ICaejF14VBbM/RuW3pKySZyXikKv4KQ0k8kXR5YS+q4r0xcYn1GmUdz5HoBCQ7+fW6ijj/ZaDTFzMwK68W79JsYeebR1sh6qQZ0OXvVTCeBDjKq6YV1ox4SVQLl9IPEjPU9TjNOmw7MfafxtQv98RMFspAj3NeuqkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763809494; c=relaxed/simple;
	bh=pQk50qd94A6EcAWXFd6fCruandW3WiwUM21AnUJJBDI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=STiN7MZElUthnmN+ymXw1Se6Dcrb+AgNXDUy4TPLIPVTlUMvQwy79a62V1VkiAXCZVprklXFIaYMIj6KN2mKOXkX5bnLI8YsqVJs/2CcKJulJVOEnuj04gii0Wowo+rkUUL3MAs1DFL8r4xW9PafqwA+qURFudFVJ+kfvxi2HtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [36.44.121.68])
	by gateway (Coremail) with SMTP id _____8BxWNHEmCFpBu0mAA--.18562S3;
	Sat, 22 Nov 2025 19:04:36 +0800 (CST)
Received: from [192.168.0.111] (unknown [36.44.121.68])
	by front1 (Coremail) with SMTP id qMiowJDx_8O6mCFpg+Y7AQ--.35665S3;
	Sat, 22 Nov 2025 19:04:32 +0800 (CST)
Message-ID: <39617a3e-c476-abac-8425-bbcece769cdb@loongson.cn>
Date: Sat, 22 Nov 2025 19:04:33 +0800
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v2] efistub: Only link libstub to final vmlinux
Content-Language: en-US
To: Huacai Chen <chenhuacai@kernel.org>, Will Deacon <will@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>,
 Ard Biesheuvel <ardb@kernel.org>, loongarch@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org,
 linux-efi@vger.kernel.org, linux-kbuild@vger.kernel.org,
 linux-kernel@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>
References: <CAAhV-H6m5vszCyiF3qi94cpHBPVuqM2xH93D=gfsQqOSYvC-sA@mail.gmail.com>
 <33612d85-e70b-26da-8460-ea6b9064ce08@loongson.cn>
 <CAAhV-H5ZSTFDxvm-W1CrgEoQ5d_jw5yVsfetQ_J_qL5pqLtzgg@mail.gmail.com>
 <CAMj1kXGk0udgM67wrWqahqK8H0uE8emQj51SmJey+7fE-FTjdA@mail.gmail.com>
 <CAAhV-H4c=vdNWO0v_mYL2xZ9FYjDyRDvt6f_kV4d8Bh=CRJniQ@mail.gmail.com>
 <CAMj1kXEaxxcWTTANWeEMNjYDymdL5Fxy2B=XBF4RGtteEkfinw@mail.gmail.com>
 <421c08e1-255b-447b-b5e3-ee6544fbefd2@loongson.cn>
 <CAAhV-H5KsFShDJ_Cxu+1_ces8oojn8+S-7PLmE7aUj8gX5_GEw@mail.gmail.com>
 <32s3lvzfu6jkyho7qenrqbsm5wkgjnzn2imdp6tfwycmyxpzgu@kg5367uxmxii>
 <CAAhV-H47fzaKcMhgLWWOTxB+srBsg85-eK0LW1vQXQnvq32-+w@mail.gmail.com>
 <aRsH7RTpAah4g5Xr@willie-the-truck>
 <CAAhV-H4AasfFet_Gi_mVyte3RPMH3qBS73dBfF-=Gd7HJ6ZPEw@mail.gmail.com>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
In-Reply-To: <CAAhV-H4AasfFet_Gi_mVyte3RPMH3qBS73dBfF-=Gd7HJ6ZPEw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDx_8O6mCFpg+Y7AQ--.35665S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxAF45tryxCw18uFyfCr1kCrX_yoWrJw48pF
	WjyFWqkr4DJr4fXwnrK3WUXFWYyr1fJrW8WF90vry8CrWqvrn7Xw4Fkr4j9FyDXr13Wr12
	vrW0qFyavFWUA3gCm3ZEXasCq-sJn29KB7ZKAUJUUUUf529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUPFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWU
	twAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMx
	k0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l
	4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxV
	WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI
	7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
	4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI
	42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU2-VyUUUUU

Cc: Nathan Chancellor <nathan@kernel.org>

Hi all,

On 11/21/25 22:36, Huacai Chen wrote:
> On Mon, Nov 17, 2025 at 7:33 PM Will Deacon <will@kernel.org> wrote:
>>
>> On Sat, Nov 15, 2025 at 11:16:42AM +0800, Huacai Chen wrote:
>>> On Wed, Nov 12, 2025 at 2:00 AM Josh Poimboeuf <jpoimboe@kernel.org> wrote:
>>>>
>>>> On Mon, Nov 10, 2025 at 03:00:00PM +0800, Huacai Chen wrote:
>>>>> On Mon, Nov 10, 2025 at 9:19 AM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>>>>>> If I understand correctly, I should modify this patch to remove the
>>>>>> changes of arm and riscv for now, do the changes only when there is
>>>>>> a real problem or requirement some day, right? If no more comments,
>>>>>> I will send v3 later.
>>>>>
>>>>> Now everyone involved agrees that the efistub code is correct, so the
>>>>> proper solution is to fix the compiler.
>>>>
>>>> Hm?  I don't see how it's a compiler bug.  It's really just an objtool
>>>> limitation.
>>>>
>>>>> Changing efistub code and changing objtool (ignore __efistub prefix)
>>>>> are both workarounds, but I think changing objtool is a little more
>>>>> reasonable. Maybe Josh has different ideas?
>>>>
>>>> I thought the conversation had converged on what Tiezhu mentioned above,
>>>> which is to skip objtool on libstub for loongarch, but leave the other
>>>> arches alone.  That way objtool behavior is consistent between loongarch
>>>> and x86, and objtool doesn't need to ignore any prefixes.
>>>>
>>>> So basically, the v2 patch minus the arm64/riscv changes.
>>>
>>> Hi, ARM64 and RISC-V maintainers,
>>>
>>> Would you mind that this patch modifies the three architectures
>>> together (they are exactly the same style now)?
>>>
>>> Madhavan is the author of ARM64's objtool, I think your opinion is
>>> also very important.
>>
>> arm64 doesn't (yet) use objtool.
>>
>> I defer to Ard on anything relating to the arm64 efistub. Reading the
>> start of this thread, it doesn't look like he's convinced and I'm not
>> surprised if it's purely an issue with objtool.
> OK, I know, but I have a concern.
> 
> Ard said that he is reluctant to make changes to accommodate a flawed
> build time tool and there may be regression risk.
> 
> So, I'm also reluctant and don't want LoongArch to meet regression
> risk. If one day LoongArch has a regression, we probably need another
> workaround to "fix" this workaround. But if these three architectures
> change in the same way, we may have a chance to solve some fundamental
> problems...

IIUC, Josh do not like to ignore these EFISTUB functions in
validate_branch() of objtool, Huacai do not like to only link
libstub to vmlinux only for LoongArch.

It seems that there is only one way to fix or workaround this
problem, remove the attribute __noreturn for real_kernel_entry()
and then make efi_boot_kernel() ends with a return instruction [1]
or an unconditional jump instruction [2] that only touches
drivers/firmware/efi/libstub/loongarch.c.

Since this is a issue only for LoongArch by now, what do you
think of this minimal change only for LoongArch libstub code?
Using "return EFI_LOAD_ERROR" [1] or "while (1)" [2]?

Maybe this is the simple and direct way for this special issue
only on LoongArch so far. If not, any other suggestions?

On the other hand, is it possible to add KBUILD_VMLINUX_LIBS_FINAL
and then use it only for LoongArch first [3]? Any potential risks?

What is the next step?

[1] 
https://lore.kernel.org/loongarch/CAMj1kXH-rK0bRyHXdJ-crAyMyvJHApH0WR7_8Qd8vrSPBLK+yg@mail.gmail.com/
[2] 
https://lore.kernel.org/loongarch/20250826064631.9617-2-yangtiezhu@loongson.cn/
[3] https://lore.kernel.org/loongarch/20251122000101.GA1996391@ax162/

Thanks,
Tiezhu


