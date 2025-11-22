Return-Path: <linux-efi+bounces-5654-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E10C7CE40
	for <lists+linux-efi@lfdr.de>; Sat, 22 Nov 2025 12:27:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 865B23A59B7
	for <lists+linux-efi@lfdr.de>; Sat, 22 Nov 2025 11:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A7B3274B42;
	Sat, 22 Nov 2025 11:27:11 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 430A313AD1C;
	Sat, 22 Nov 2025 11:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763810831; cv=none; b=TOQy0ycUz94s3hw88RtuJxEtIENOleMXgMO2WwoocG588eLX8vAwBbmu2WQWQFYJKeSjKD7c+GKMbxS5ZDggHMphtZ1nSsIE8DDi5msZ8x8RCJhA918eusmobDhN+8L11uD0vaidUltspvEf1zUpUnSa4nKjzTrhLcvVr+yzhyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763810831; c=relaxed/simple;
	bh=PdKae5AjMVZitRaBXKL1kJYtGQ3efsdJlfub/gHe9PE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A0jM1MDSs9xsmdG2qfdTZazeH1aYICEPg0mr2bNcdEkQQSNQE+hAo/G/OT1f2Vj8URhoBk5nwpa5A8vOnSSuz9mVKet6RcewqERwClSwN3JQ8aDelw4s+Tm553l0ZoK/UieBZv3FhSmv4+W4xsp/OidCso7bxO2+vVXvAfX5kF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [36.44.121.68])
	by gateway (Coremail) with SMTP id _____8CxbNIFniFpNO4mAA--.18897S3;
	Sat, 22 Nov 2025 19:27:01 +0800 (CST)
Received: from [192.168.0.111] (unknown [36.44.121.68])
	by front1 (Coremail) with SMTP id qMiowJAxvsH8nSFpm+g7AQ--.53718S3;
	Sat, 22 Nov 2025 19:26:57 +0800 (CST)
Message-ID: <7f179e5f-610c-6468-cb3f-17d25d096a8f@loongson.cn>
Date: Sat, 22 Nov 2025 19:26:52 +0800
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v1] kbuild: Add KBUILD_VMLINUX_LIBS_PRELINK
Content-Language: en-US
To: Nathan Chancellor <nathan@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
 Huacai Chen <chenhuacai@kernel.org>, linux-kbuild@vger.kernel.org,
 linux-efi@vger.kernel.org, loongarch@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20251119042708.27658-1-yangtiezhu@loongson.cn>
 <20251122013551.GA3928114@ax162>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
In-Reply-To: <20251122013551.GA3928114@ax162>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:qMiowJAxvsH8nSFpm+g7AQ--.53718S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7AFWxury5KFWUGFW7Gr17Jwc_yoW8GFW5pa
	1vyr4jvFsrJw4vqan7C345Xa1YqF95XrWxWFyDKa98Z3yDXr10vrZFgF43ZF9FvFyDAF4S
	gFs7XF9xCry7K3gCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU92b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AK
	xVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
	AYIcxG8wCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMI
	IF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVF
	xhVjvjDU0xZFpf9x07jreOLUUUUU=

On 11/22/25 09:35, Nathan Chancellor wrote:
> On Wed, Nov 19, 2025 at 12:27:08PM +0800, Tiezhu Yang wrote:
> ...
>> index 433849ff7529..e72d3254b93f 100755
>> --- a/scripts/link-vmlinux.sh
>> +++ b/scripts/link-vmlinux.sh
>> @@ -61,12 +61,11 @@ vmlinux_link()
>>   	shift
>>   
>>   	if is_enabled CONFIG_LTO_CLANG || is_enabled CONFIG_X86_KERNEL_IBT; then
>> -		# Use vmlinux.o instead of performing the slow LTO link again.
> 
> Why is this comment getting removed?

When using KBUILD_VMLINUX_LIBS_PRELINK or KBUILD_VMLINUX_LIBS_FINAL,
drivers/firmware/efi/libstub/lib.a needs to be linked to the final
vmlinux with vmlinux.o, so I thought the above comment is not proper,
it I misunderstood it, I will keep the comment as is.

>>   		objs=vmlinux.o
>> -		libs=
>> +		libs="${KBUILD_VMLINUX_LIBS_PRELINK}"
>>   	else
>>   		objs=vmlinux.a
>> -		libs="${KBUILD_VMLINUX_LIBS}"
>> +		libs="${KBUILD_VMLINUX_LIBS} ${KBUILD_VMLINUX_LIBS_PRELINK}"
>>   	fi
>>   
>>   	if is_enabled CONFIG_GENERIC_BUILTIN_DTB; then

FYI, the previous patch is still under discussion yesterday [1],
I do not know whether this patch is necessary and what is the next
step [2].

[1] 
https://lore.kernel.org/loongarch/CAAhV-H4AasfFet_Gi_mVyte3RPMH3qBS73dBfF-=Gd7HJ6ZPEw@mail.gmail.com/
[2] 
https://lore.kernel.org/loongarch/39617a3e-c476-abac-8425-bbcece769cdb@loongson.cn/

Thanks,
Tiezhu


