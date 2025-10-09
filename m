Return-Path: <linux-efi+bounces-5009-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0751EBC7B30
	for <lists+linux-efi@lfdr.de>; Thu, 09 Oct 2025 09:28:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB15719E3292
	for <lists+linux-efi@lfdr.de>; Thu,  9 Oct 2025 07:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13E272D0C63;
	Thu,  9 Oct 2025 07:28:00 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 159D72BE7AF;
	Thu,  9 Oct 2025 07:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759994880; cv=none; b=e9kw3zw8AaxOTW9B6tXoLSbXIf38eTKXNUkOZzsYMRel3XYAl7NAtR6ixGF+oXjzuPl120BdLWD7UF6Dlsi7uKnbNbOIdgRZWzCK3dH6eo6gI9BMbx+qEQDC8NNJ1I1lRRYkZ14ptN+mK0bV/3v+ky+x5uFzm9U0Oh6lc+JGA14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759994880; c=relaxed/simple;
	bh=XfqDBfd6iAezjZ4Zyx6Aa3kJN4a1sI8LfvLWt/i2PWw=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=psr+lKC+ufIEETyV9UGwdXkFy7MboC7QOqG4DOBAZRv058GGrvvO6GsqHL7VKRqNqkMoVXemcLs0LncbRfdW4DfJ5Khhl2Ef4XP19/CVdoyiG1YrwPDanF0ycwOvg4EwYbmpvPCoBKuDxxZmjpr42DQO1Ug16MTUioQC0l78gaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8Cx77_1Y+doGzAUAA--.41427S3;
	Thu, 09 Oct 2025 15:27:49 +0800 (CST)
Received: from [10.130.10.66] (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJCxocLrY+doN1fWAA--.11175S3;
	Thu, 09 Oct 2025 15:27:39 +0800 (CST)
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
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <fec0c03d-9d8c-89a3-886a-1adc22e59b66@loongson.cn>
Date: Thu, 9 Oct 2025 15:27:39 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAMj1kXHWe2uGY3S1NJ6mckqD4n116rPmaOzw3_Qbvxyjh7ECMw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCxocLrY+doN1fWAA--.11175S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxuFyDZr45uF48uFyxuF4DAwc_yoWxWw1kpa
	yjkFWjyr4kJr4kXas7t3yY9r1YqanIqrWaga4DuryrZa1qqr40vrWUZr4DuF9rXw4DC3WI
	qF1fJr9Ik3WUJ3gCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUPYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2
	x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17
	McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7
	I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCF
	x2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUXVWUAwC20s026c02F40E14v26r
	1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij
	64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr
	0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF
	0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j7189UUUUU=

On 2025/9/28 下午10:41, Ard Biesheuvel wrote:
> On Sun, 28 Sept 2025 at 16:39, Ard Biesheuvel <ardb@kernel.org> wrote:
>>
>> On Sun, 28 Sept 2025 at 15:52, Huacai Chen <chenhuacai@kernel.org> wrote:
>>>
>>> Hi, Ard,
>>>
>>> On Sun, Sep 28, 2025 at 9:42 PM Ard Biesheuvel <ardb@kernel.org> wrote:
>>>>
>>>> On Sun, 28 Sept 2025 at 10:55, Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>>>>>
>>>>> When compiling with LLVM and CONFIG_LTO_CLANG is set, there exists
>>>>> the following objtool warning on LoongArch:
>>>>>
>>>>>    vmlinux.o: warning: objtool: __efistub_efi_boot_kernel()
>>>>>    falls through to next function __efistub_exit_boot_func()
>>>>>
>>>>> This is because efi_boot_kernel() doesn't end with a return instruction
>>>>> or an unconditional jump, then objtool has determined that the function
>>>>> can fall through into the next function.
>>>>>
>>>>> At the beginning, try to do something to make efi_boot_kernel() ends with
>>>>> an unconditional jump instruction, but this modification seems not proper.
>>>>>
>>>>> Since the efistub functions are useless for stack unwinder, they can be
>>>>> ignored by objtool. After many discussions, no need to link libstub to
>>>>> the vmlinux.o, only link libstub to the final vmlinux.
>>>>>
>>>>
>>>> Please try keeping these changes confined to arch/loongarch. This
>>>> problem does not exist on other architectures, and changing the way
>>>> vmlinux is constructed might create other issues down the road.

This was discussed and tested in the v3 patch, it only touches the code
of LoongArch and works well like this:

diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
index dc5bd3f1b8d2..f34b416f5ca2 100644
--- a/arch/loongarch/Makefile
+++ b/arch/loongarch/Makefile
@@ -169,7 +169,6 @@ CHECKFLAGS += $(shell $(CC) $(KBUILD_CPPFLAGS) 
$(KBUILD_CFLAGS) -dM -E -x c /dev
  endif

  libs-y += arch/loongarch/lib/
-libs-$(CONFIG_EFI_STUB) += $(objtree)/drivers/firmware/efi/libstub/lib.a

  drivers-y              += arch/loongarch/crypto/

diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index 433849ff7529..ed94871c3606 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -69,6 +69,12 @@ vmlinux_link()
                 libs="${KBUILD_VMLINUX_LIBS}"
         fi

+       if [ "${SRCARCH}" = "loongarch" ]; then
+               if is_enabled CONFIG_EFI_STUB; then
+                       libs="${libs} drivers/firmware/efi/libstub/lib.a"
+               fi
+       fi
+
         if is_enabled CONFIG_GENERIC_BUILTIN_DTB; then
                 objs="${objs} .builtin-dtbs.o"
         fi

https://lore.kernel.org/loongarch/pq4h7jgndnt6p45lj4kgubxjd5gidfetugcuf5rcxzxxanzetd@6rrlpjnjsmuy/

>>> ARM, RISC-V and LoongArch do things exactly in the same way. Now
>>> LoongArch is the first of the three to enable objtool, so we meet the
>>> problem first.
>>>
>>> But yes, I also don't want to change the way of constructing vmlinux.
>>> So I prefer the earliest way to fix this problem.
>>> https://lore.kernel.org/loongarch/CAAhV-H7fRHGFVKV8HitRgmuoDPt5ODt--iSuV0EmeeUb9d5FNw@mail.gmail.com/T/#meef7411abd14f4c28c85e686614aa9211fccdca0
>>>
>>
>> Can we just drop the __noreturn annotation from kernel_entry_t, and
>> return EFI_SUCCESS from efi_boot_kernel()?

This was done in the early RFC patch, it works well like this:

diff --git a/drivers/firmware/efi/libstub/loongarch.c 
b/drivers/firmware/efi/libstub/loongarch.c
index 3782d0a187d1..e309fd78fca7 100644
--- a/drivers/firmware/efi/libstub/loongarch.c
+++ b/drivers/firmware/efi/libstub/loongarch.c
@@ -10,7 +10,7 @@
  #include "efistub.h"
  #include "loongarch-stub.h"

-typedef void __noreturn (*kernel_entry_t)(bool efi, unsigned long cmdline,
+typedef void (*kernel_entry_t)(bool efi, unsigned long cmdline,
  					  unsigned long systab);

  efi_status_t check_platform_features(void)
@@ -81,4 +81,7 @@ efi_status_t efi_boot_kernel(void *handle, 
efi_loaded_image_t *image,

  	real_kernel_entry(true, (unsigned long)cmdline_ptr,
  			  (unsigned long)efi_system_table);
+
+	/* We should never get here */
+	while (1);
  }

https://lore.kernel.org/loongarch/20250826064631.9617-2-yangtiezhu@loongson.cn/

> ... or add efi_boot_kernel() to ./tools/objtool/noreturns.h?

It can not fix the objtool warning.

Are you OK with the following changes?

(1) libstub doesn't link to vmlinux.o, only link libstub with vmlinux.o 
during the final vmlinux link, keep the changes confined to LoongArch, 
no need to be something more generic.

diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
index dc5bd3f1b8d2..f34b416f5ca2 100644
--- a/arch/loongarch/Makefile
+++ b/arch/loongarch/Makefile
@@ -169,7 +169,6 @@ CHECKFLAGS += $(shell $(CC) $(KBUILD_CPPFLAGS) 
$(KBUILD_CFLAGS) -dM -E -x c /dev
  endif

  libs-y += arch/loongarch/lib/
-libs-$(CONFIG_EFI_STUB) += $(objtree)/drivers/firmware/efi/libstub/lib.a

  drivers-y              += arch/loongarch/crypto/

diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index 433849ff7529..ed94871c3606 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -69,6 +69,12 @@ vmlinux_link()
                 libs="${KBUILD_VMLINUX_LIBS}"
         fi

+       if [ "${SRCARCH}" = "loongarch" ]; then
+               if is_enabled CONFIG_EFI_STUB; then
+                       libs="${libs} drivers/firmware/efi/libstub/lib.a"
+               fi
+       fi
+
         if is_enabled CONFIG_GENERIC_BUILTIN_DTB; then
                 objs="${objs} .builtin-dtbs.o"
         fi

(2) remove the attribute __noreturn for real_kernel_entry() and add
"while (1);" at the end of efi_boot_kernel().

diff --git a/drivers/firmware/efi/libstub/loongarch.c 
b/drivers/firmware/efi/libstub/loongarch.c
index 3782d0a187d1..e309fd78fca7 100644
--- a/drivers/firmware/efi/libstub/loongarch.c
+++ b/drivers/firmware/efi/libstub/loongarch.c
@@ -10,7 +10,7 @@
  #include "efistub.h"
  #include "loongarch-stub.h"

-typedef void __noreturn (*kernel_entry_t)(bool efi, unsigned long cmdline,
+typedef void (*kernel_entry_t)(bool efi, unsigned long cmdline,
  					  unsigned long systab);

  efi_status_t check_platform_features(void)
@@ -81,4 +81,7 @@ efi_status_t efi_boot_kernel(void *handle, 
efi_loaded_image_t *image,

  	real_kernel_entry(true, (unsigned long)cmdline_ptr,
  			  (unsigned long)efi_system_table);
+
+	/* We should never get here */
+	while (1);
  }

Taking all of the considerations in balance, what should to do?

Thanks,
Tiezhu


