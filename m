Return-Path: <linux-efi+bounces-5658-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA488C7DB42
	for <lists+linux-efi@lfdr.de>; Sun, 23 Nov 2025 04:37:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 835C53A1EB5
	for <lists+linux-efi@lfdr.de>; Sun, 23 Nov 2025 03:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2885D1F5842;
	Sun, 23 Nov 2025 03:37:25 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 707FF15665C;
	Sun, 23 Nov 2025 03:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763869045; cv=none; b=Lv32xbHWXW3dYKHkdlRvUGgFLD8hupjfolu3N9rZ2pMZLcyikt5IS9Z+OOEiBrxq/iSGsCByJEj1zv1Cb3ha8zqp7k9/wIYsXwDdznveB9NEICR2UZQIcKBeYZt/csFJh13z7wJ1pmZ/tNoWtu2dxi+0Q/Ho7I0zK9hYk4wedwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763869045; c=relaxed/simple;
	bh=+0XzVZZeYb0GSe2/mcsHpIGdSUcj5BSGzMI4IGhs5dY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oi1NbkPjQs6i/WRNcw3ZDHGau5RuKbxQ2kWSLi/02swx5LNSbGb2YPvN8Bcq+50TfxAe+VH4RgPvBOanxtqO/Kbi+vHdO0WsscGWMuNdU3wfNjg0Ba+c74FhYTi7gW8lloU08o3u3rJbp065Zdd9mpiqJSqbMEtTO/25k96I00A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [117.22.84.22])
	by gateway (Coremail) with SMTP id _____8CxJ9FpgSJppRUnAA--.18149S3;
	Sun, 23 Nov 2025 11:37:13 +0800 (CST)
Received: from [192.168.0.111] (unknown [117.22.84.22])
	by front1 (Coremail) with SMTP id qMiowJDxrcFkgSJp3Hs8AQ--.7566S3;
	Sun, 23 Nov 2025 11:37:10 +0800 (CST)
Message-ID: <fc4fa66f-15a0-ebe3-0a27-f3f38b03bbdb@loongson.cn>
Date: Sun, 23 Nov 2025 11:37:14 +0800
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
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Will Deacon <will@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
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
 <39617a3e-c476-abac-8425-bbcece769cdb@loongson.cn>
 <CAAhV-H4fHBuRpDEDQrExApgnREJaT8JWUJ2700bEPFxDqToi2w@mail.gmail.com>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
In-Reply-To: <CAAhV-H4fHBuRpDEDQrExApgnREJaT8JWUJ2700bEPFxDqToi2w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDxrcFkgSJp3Hs8AQ--.7566S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW3Jw4DKw47AFWftFWkCw47Jrc_yoW7GFy5pF
	WUAayqkF4DArW3Cw1ktw18WFyayr1xXry8Wrn8KrykAryqvrnxJr4Skr1j9F9Yqr1rW3W2
	vF40qFyavFWUA3gCm3ZEXasCq-sJn29KB7ZKAUJUUUUf529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUPFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWU
	twAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMx
	k0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l
	4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxV
	WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI
	7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
	4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI
	42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU2-VyUUUUU

On 11/23/25 10:29, Huacai Chen wrote:
> On Sat, Nov 22, 2025 at 7:04 PM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>>
>> Cc: Nathan Chancellor <nathan@kernel.org>
>>
>> Hi all,
>>
>> On 11/21/25 22:36, Huacai Chen wrote:
>>> On Mon, Nov 17, 2025 at 7:33 PM Will Deacon <will@kernel.org> wrote:
>>>>
>>>> On Sat, Nov 15, 2025 at 11:16:42AM +0800, Huacai Chen wrote:
>>>>> On Wed, Nov 12, 2025 at 2:00 AM Josh Poimboeuf <jpoimboe@kernel.org> wrote:
>>>>>>
>>>>>> On Mon, Nov 10, 2025 at 03:00:00PM +0800, Huacai Chen wrote:
>>>>>>> On Mon, Nov 10, 2025 at 9:19 AM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>>>>>>>> If I understand correctly, I should modify this patch to remove the
>>>>>>>> changes of arm and riscv for now, do the changes only when there is
>>>>>>>> a real problem or requirement some day, right? If no more comments,
>>>>>>>> I will send v3 later.
>>>>>>>
>>>>>>> Now everyone involved agrees that the efistub code is correct, so the
>>>>>>> proper solution is to fix the compiler.
>>>>>>
>>>>>> Hm?  I don't see how it's a compiler bug.  It's really just an objtool
>>>>>> limitation.
>>>>>>
>>>>>>> Changing efistub code and changing objtool (ignore __efistub prefix)
>>>>>>> are both workarounds, but I think changing objtool is a little more
>>>>>>> reasonable. Maybe Josh has different ideas?
>>>>>>
>>>>>> I thought the conversation had converged on what Tiezhu mentioned above,
>>>>>> which is to skip objtool on libstub for loongarch, but leave the other
>>>>>> arches alone.  That way objtool behavior is consistent between loongarch
>>>>>> and x86, and objtool doesn't need to ignore any prefixes.
>>>>>>
>>>>>> So basically, the v2 patch minus the arm64/riscv changes.
>>>>>
>>>>> Hi, ARM64 and RISC-V maintainers,
>>>>>
>>>>> Would you mind that this patch modifies the three architectures
>>>>> together (they are exactly the same style now)?
>>>>>
>>>>> Madhavan is the author of ARM64's objtool, I think your opinion is
>>>>> also very important.
>>>>
>>>> arm64 doesn't (yet) use objtool.
>>>>
>>>> I defer to Ard on anything relating to the arm64 efistub. Reading the
>>>> start of this thread, it doesn't look like he's convinced and I'm not
>>>> surprised if it's purely an issue with objtool.
>>> OK, I know, but I have a concern.
>>>
>>> Ard said that he is reluctant to make changes to accommodate a flawed
>>> build time tool and there may be regression risk.
>>>
>>> So, I'm also reluctant and don't want LoongArch to meet regression
>>> risk. If one day LoongArch has a regression, we probably need another
>>> workaround to "fix" this workaround. But if these three architectures
>>> change in the same way, we may have a chance to solve some fundamental
>>> problems...
>>
>> IIUC, Josh do not like to ignore these EFISTUB functions in
>> validate_branch() of objtool, Huacai do not like to only link
>> libstub to vmlinux only for LoongArch.
>>
>> It seems that there is only one way to fix or workaround this
>> problem, remove the attribute __noreturn for real_kernel_entry()
>> and then make efi_boot_kernel() ends with a return instruction [1]
>> or an unconditional jump instruction [2] that only touches
>> drivers/firmware/efi/libstub/loongarch.c.
>>
>> Since this is a issue only for LoongArch by now, what do you
>> think of this minimal change only for LoongArch libstub code?
>> Using "return EFI_LOAD_ERROR" [1] or "while (1)" [2]?
>>
>> Maybe this is the simple and direct way for this special issue
>> only on LoongArch so far. If not, any other suggestions?
>>
>> On the other hand, is it possible to add KBUILD_VMLINUX_LIBS_FINAL
>> and then use it only for LoongArch first [3]? Any potential risks?
>>
>> What is the next step?
> Is it possible to improve objtool that can handle indirect __noreturn functions?
> Is it possible to improve objtool that can handle
> OBJECT_FILES_NON_STANDARD event LTO is enabled?
> Is it possible to improve objtool that only ignore __efistub prefix
> for LoongArch?

I think a new arch_is_efistub() can be added in objtool
to handle this issue only for LoongArch, something like:

bool arch_is_retpoline(struct symbol *sym);
bool arch_is_rethunk(struct symbol *sym);
bool arch_is_embedded_insn(struct symbol *sym);

This is valid for LoongArch and will not affect x86,
arm64 and riscv can implement it some day.

The code looks like:

tools/objtool/include/objtool/arch.h:
bool arch_is_efistub(struct symbol *sym);

tools/objtool/check.c:
__weak bool arch_is_efistub(struct symbol *sym)
{
	return false;
}

tools/objtool/arch/loongarch/decode.c:
bool arch_is_efistub(struct symbol *sym)
{
	return !strncmp(func->name, "__efistub_", 10));
}

tools/objtool/check.c:
static int validate_branch()
{
...
			if (arch_is_efistub(func))
				return 0;

			if (file->ignore_unreachables)
				return 0;

			WARN("%s() falls through to next function %s()",
			     func->name, insn_func(insn)->name);
			func->warned = 1;

			return 1;
...
}

Let us wait for Josh's opinion.

Thanks,
Tiezhu


