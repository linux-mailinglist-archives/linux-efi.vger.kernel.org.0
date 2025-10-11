Return-Path: <linux-efi+bounces-5027-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21F9BBCF1DF
	for <lists+linux-efi@lfdr.de>; Sat, 11 Oct 2025 10:13:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 225E3189CCEA
	for <lists+linux-efi@lfdr.de>; Sat, 11 Oct 2025 08:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3DAD2367D6;
	Sat, 11 Oct 2025 08:13:40 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE89822A4D5;
	Sat, 11 Oct 2025 08:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760170420; cv=none; b=YOffI/aAU+HYSy44U8ylx5TquhwBLYBm0wJSTmzGleDKwnujTcjIdOCF5Czb/CxPiSEujRZoNd+zoruYawlU2zFqbLhrCwwLXXjEvOErDfGnj2vA7/48bcSc1XI6/AxjfZ9YO9ODy4L/xdO0WcnXF8nt6BuW68Ag2g9SGSvZG44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760170420; c=relaxed/simple;
	bh=zHGZt9ZMhou9U26WElAlqRV68v+jrKPecXcSGOYw2dI=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=TJkQNXX+j9Kv6DgIFsMsFJKo31QlSxhR1ro4RzqXXA96S7VZ6D2GVkCCSfQmXPvhSUhQtqopEqarpBoc/p10IYPxrlv5Nqmwjn0UveiRfCeEBJh3Dkj52FJO32MF1HL1hmlkfep0e9LWBfFNi5M7rzTJiWvn3nrdhiBn8BSFBAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8DxudGuEeponvwUAA--.45568S3;
	Sat, 11 Oct 2025 16:13:34 +0800 (CST)
Received: from [10.130.10.66] (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJCx2sCsEepo8vfZAA--.1249S3;
	Sat, 11 Oct 2025 16:13:33 +0800 (CST)
Subject: Re: [PATCH v2] efistub: Only link libstub to final vmlinux
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Ard Biesheuvel <ardb@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
 loongarch@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-riscv@lists.infradead.org, linux-efi@vger.kernel.org,
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
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
 <0c9b8e6a-96a6-91d4-946f-2109f48a529b@loongson.cn>
 <CAAhV-H41m96fvEWG5NqAE=tykPjyzt=50CseJDeCqdG-c_WMrQ@mail.gmail.com>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <9508dbf5-6432-f459-f273-8b327d51a055@loongson.cn>
Date: Sat, 11 Oct 2025 16:13:31 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAAhV-H41m96fvEWG5NqAE=tykPjyzt=50CseJDeCqdG-c_WMrQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCx2sCsEepo8vfZAA--.1249S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxuw4DGFWrJFWDKFy3XF4xGrX_yoWxCrW3pa
	15GFWYyr4fJw48Jas2y3y5uFyYqwnIgr9FgasFv34rZ3WqvF13XryUWryj9F4DAryvg3Wa
	yay3tr9aka1DJwcCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Ib4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v2
	6F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
	02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAF
	wI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4
	CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAF
	wI0_Jw0_GFylx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zV
	AF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4l
	IxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCw
	CI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnI
	WIevJa73UjIFyTuYvjxUcVc_UUUUU

On 2025/10/11 下午3:42, Huacai Chen wrote:
> On Sat, Oct 11, 2025 at 3:29 PM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>>
>> On 2025/10/11 上午11:40, Ard Biesheuvel wrote:
>>> On Fri, 10 Oct 2025 at 19:54, Huacai Chen <chenhuacai@kernel.org> wrote:
>>>>
>>>> On Sat, Oct 11, 2025 at 9:13 AM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>>>>>
>>>>> On 2025/10/11 上午12:25, Ard Biesheuvel wrote:
>>>>> ...
>>>>>> Why do we need both (1) and (2)?
>>>>>
>>>>> Not both, either (1) or (2).
>>>>> Which one do you prefer? Or any other suggestions?
>>>>>
>>>>> Taking all of the considerations in balance, we should decide
>>>>> what is the proper way.
>>>> As a summary, there are three methods:
>>>> (1) Only link libstub with vmlinux.o during the final vmlinux link.
>>>> (2) Remove the attribute __noreturn for real_kernel_entry() and add while (1).
>>>> (3) Ignore "__efistub_" prefix in objtool.
>>>>
>>>> Josh prefers method (1), I prefer method (3) but also accept method
>>>> (1) if it is not only specific to loongarch.
>>>>
>>>
>>> This is a false positive warning in objtool, which complains about a
>>> function that falls through, even though that can never happen in
>>> reality.
>>>
>>> To me, it is not acceptable to modify how vmlinux.o is constructed
>>> also for other architectures, in order to hide some of its constituent
>>> parts from objtool, which do not use objtool to begin with.
>>>
>>>
>>> If you are not willing to fix objtool, I suggest fixing the loongarch
>>> code like this:
>>
>> Thank you.
>>
>>> --- a/drivers/firmware/efi/libstub/loongarch.c
>>> +++ b/drivers/firmware/efi/libstub/loongarch.c
>>> @@ -10,7 +10,7 @@
>>>    #include "efistub.h"
>>>    #include "loongarch-stub.h"
>>>
>>> -typedef void __noreturn (*kernel_entry_t)(bool efi, unsigned long cmdline,
>>> +typedef void (*kernel_entry_t)(bool efi, unsigned long cmdline,
>>>                                             unsigned long systab);
>>>
>>>    efi_status_t check_platform_features(void)
>>> @@ -81,4 +81,6 @@
>>>
>>>           real_kernel_entry(true, (unsigned long)cmdline_ptr,
>>>                             (unsigned long)efi_system_table);
>>> +
>>> +       return EFI_LOAD_ERROR;
>>>    }
>>
>> I tested the above changes, the falls through objtool warning can
>> be fixed because efi_boot_kernel() ends with a return instruction,
>> I think this is reasonable.
>>
>> efi_boot_kernel() has a return value, there are "return status" in
>> other parts of efi_boot_kernel(), it should also return at the end
>> of efi_boot_kernel() in theory, although we should never get here.
>>
>> If there are more comments, please let me know.
> I still don't want LoongArch to be a special case, which means
> efi_boot_kernel() in fdt.c, jump_kernel_func in riscv.c and
> enter_kernel in arm64.c should also be modified.

Here is the diff:

----- 8< -----
diff --git a/drivers/firmware/efi/libstub/arm64.c 
b/drivers/firmware/efi/libstub/arm64.c
index e57cd3de0a00..f3a1bb86bf8d 100644
--- a/drivers/firmware/efi/libstub/arm64.c
+++ b/drivers/firmware/efi/libstub/arm64.c
@@ -128,11 +128,11 @@ unsigned long __weak primary_entry_offset(void)
         return 0;
  }

-void __noreturn efi_enter_kernel(unsigned long entrypoint,
-                                unsigned long fdt_addr,
-                                unsigned long fdt_size)
+void efi_enter_kernel(unsigned long entrypoint,
+                     unsigned long fdt_addr,
+                     unsigned long fdt_size)
  {
-       void (* __noreturn enter_kernel)(u64, u64, u64, u64);
+       void (*enter_kernel)(u64, u64, u64, u64);

         enter_kernel = (void *)entrypoint + primary_entry_offset();
         enter_kernel(fdt_addr, 0, 0, 0);
diff --git a/drivers/firmware/efi/libstub/efistub.h 
b/drivers/firmware/efi/libstub/efistub.h
index f5ba032863a9..b4c716df4d47 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -1129,9 +1129,9 @@ efi_status_t efi_stub_common(efi_handle_t handle,

  efi_status_t efi_handle_cmdline(efi_loaded_image_t *image, char 
**cmdline_ptr);

-asmlinkage void __noreturn efi_enter_kernel(unsigned long entrypoint,
-                                           unsigned long fdt_addr,
-                                           unsigned long fdt_size);
+asmlinkage void efi_enter_kernel(unsigned long entrypoint,
+                                unsigned long fdt_addr,
+                                unsigned long fdt_size);

  void efi_handle_post_ebs_state(void);

diff --git a/drivers/firmware/efi/libstub/fdt.c 
b/drivers/firmware/efi/libstub/fdt.c
index 6a337f1f8787..7ece39ed70f6 100644
--- a/drivers/firmware/efi/libstub/fdt.c
+++ b/drivers/firmware/efi/libstub/fdt.c
@@ -358,7 +358,9 @@ efi_status_t efi_boot_kernel(void *handle, 
efi_loaded_image_t *image,
                 efi_handle_post_ebs_state();

         efi_enter_kernel(kernel_addr, fdt_addr, fdt_totalsize((void 
*)fdt_addr));
+
         /* not reached */
+       return EFI_LOAD_ERROR;
  }

  void *get_fdt(unsigned long *fdt_size)
diff --git a/drivers/firmware/efi/libstub/loongarch.c 
b/drivers/firmware/efi/libstub/loongarch.c
index 3782d0a187d1..88c500aeed86 100644
--- a/drivers/firmware/efi/libstub/loongarch.c
+++ b/drivers/firmware/efi/libstub/loongarch.c
@@ -10,8 +10,8 @@
  #include "efistub.h"
  #include "loongarch-stub.h"

-typedef void __noreturn (*kernel_entry_t)(bool efi, unsigned long cmdline,
-                                         unsigned long systab);
+typedef void (*kernel_entry_t)(bool efi, unsigned long cmdline,
+                              unsigned long systab);

  efi_status_t check_platform_features(void)
  {
@@ -81,4 +81,7 @@ efi_status_t efi_boot_kernel(void *handle, 
efi_loaded_image_t *image,

         real_kernel_entry(true, (unsigned long)cmdline_ptr,
                           (unsigned long)efi_system_table);
+
+       /* not reached */
+       return EFI_LOAD_ERROR;
  }
diff --git a/drivers/firmware/efi/libstub/riscv.c 
b/drivers/firmware/efi/libstub/riscv.c
index f66f33ceb99e..6589e8f5cf1a 100644
--- a/drivers/firmware/efi/libstub/riscv.c
+++ b/drivers/firmware/efi/libstub/riscv.c
@@ -11,7 +11,7 @@

  #include "efistub.h"

-typedef void __noreturn (*jump_kernel_func)(unsigned long, unsigned long);
+typedef void (*jump_kernel_func)(unsigned long, unsigned long);

  static unsigned long hartid;

@@ -81,7 +81,7 @@ unsigned long __weak stext_offset(void)
         return 0;
  }

-void __noreturn efi_enter_kernel(unsigned long entrypoint, unsigned 
long fdt,
+void efi_enter_kernel(unsigned long entrypoint, unsigned long fdt,
                                  unsigned long fdt_size)
  {
         unsigned long kernel_entry = entrypoint + stext_offset();

Do the above changes in a single patch?
Or in two patches?
One is to modify drivers/firmware/efi/libstub/loongarch.c,
the other one is to modify the arm64 and riscv.

Let us wait for more review comments.

Thanks,
Tiezhu


