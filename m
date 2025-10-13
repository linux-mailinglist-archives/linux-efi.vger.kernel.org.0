Return-Path: <linux-efi+bounces-5031-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F2E9BD1D29
	for <lists+linux-efi@lfdr.de>; Mon, 13 Oct 2025 09:35:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4880E3A522A
	for <lists+linux-efi@lfdr.de>; Mon, 13 Oct 2025 07:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFF552E8DED;
	Mon, 13 Oct 2025 07:35:02 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1A052E266C;
	Mon, 13 Oct 2025 07:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760340902; cv=none; b=uHtgwqscWw/44tG5Uwmfc5kZM4wiajqgijxVP16ry7RNwwqF67ILddjBsDqmbyVoMvtgum8fdRsaFpW/hjXwIWmBvoXMpoavxEwi510hGJqAY6m+eID7DE2fWZJat/4KwJJAFki+a32ug4E66YvAMUj5PmWRtA6fUbgVHu9drqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760340902; c=relaxed/simple;
	bh=NCApywhaw9UwxiTx9sXxe8xLg9MuI+O2DIpkkCQS1tU=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=nSccp6PTKa8v2mLhigaah06XoPgnT0OiCcNB9UnmRPyYRjQrVA1P9L4IpuITSqvZ+FX2RearLNBFfkW4EScQvh/wpBjqpyQe0zBNcx4wt6ZFz5eJgsXzv8KIsyJShfLaITZCWURkFlJ99+3pXAEy3GS75J798PXI2UN++gBfF58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8DxO9Kgq+xo0H0VAA--.46000S3;
	Mon, 13 Oct 2025 15:34:56 +0800 (CST)
Received: from [10.130.10.66] (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJAxE+Sdq+xoJ1PdAA--.31982S3;
	Mon, 13 Oct 2025 15:34:55 +0800 (CST)
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
 <0c9b8e6a-96a6-91d4-946f-2109f48a529b@loongson.cn>
 <CAAhV-H41m96fvEWG5NqAE=tykPjyzt=50CseJDeCqdG-c_WMrQ@mail.gmail.com>
 <CAMj1kXEs5=VRi_rJwgHUrQWos-27PBbr3c4fYnmkV8Ahi8HZgw@mail.gmail.com>
 <CAAhV-H7HN128du-b1Rk_9qbYBq7gMSwo0s31909N4pTou6wzew@mail.gmail.com>
 <CAMj1kXGvSnCMRVCW7eAxgLRWMEV3QRj3Dqg3PmZchZJNpnLK9w@mail.gmail.com>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <3695be6e-bc75-1ee4-1222-95aafa44abdb@loongson.cn>
Date: Mon, 13 Oct 2025 15:34:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAMj1kXGvSnCMRVCW7eAxgLRWMEV3QRj3Dqg3PmZchZJNpnLK9w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAxE+Sdq+xoJ1PdAA--.31982S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxGrWfuw43urW8Ar4kCw45urX_yoW5XF4Upa
	y7GrWUKrs5JFZ7J34xJr15u3yUAwsIya45KF9I9ryrZw1UuF90qryjvrWjvFWDXrW8uFy2
	yF4ftrZIyFWqywcCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUvYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v2
	6F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
	02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAF
	wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4
	CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
	W8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j1WlkU
	UUUU=

On 2025/10/11 下午11:58, Ard Biesheuvel wrote:
> On Sat, 11 Oct 2025 at 08:01, Huacai Chen <chenhuacai@kernel.org> wrote:...>> Hmmm, I want to know whether this problem is an objtool issue or an
>> efistub issue in essence. If it is an objtool issue, we should fix
>> objtool and don't touch efistub. If it is an efistub issue, then we
>> should modify efistub (but not specific to LoongArch, when RISC-V and
>> ARM64 add objtool they will meet the same issue).
>>
> 
> It is an objtool issue in essence.
> 
> The generated code looks like this
> 
> 9000000001743080: ff b7 fe 57   bl      -332 <__efistub_kernel_entry_address>
> 9000000001743084: 26 03 c0 28   ld.d    $a2, $s2, 0
> 9000000001743088: 87 00 15 00   move    $a3, $a0
> 900000000174308c: 04 04 80 03   ori     $a0, $zero, 1
> 9000000001743090: c5 02 15 00   move    $a1, $fp
> 9000000001743094: e1 00 00 4c   jirl    $ra, $a3, 0
> 
> 9000000001743098 <__efistub_exit_boot_func>:
> 9000000001743098: 63 c0 ff 02   addi.d  $sp, $sp, -16
> 
> There is nothing wrong with this code, given that the indirect call is
> to a __noreturn function, and so the fact that it falls through into
> __efistub_exit_boot_func() is not a problem.
> 
> Even though the compiler does nothing wrong here, it would be nice if
> it would emit some kind of UD or BRK instruction after such a call, if
> only to make the backtrace more reliable. But the code is fine, and
> objtool simply does not have the information it needs to determine
> that the indirect call is of a variety that never returns.
> 
> So I don't mind fixing it in the code, but only for LoongArch, given
> that the problem does not exist on arm64 or RISC-V.

I assume this is the final conclusion, if there is no objection,
I will send patch according to Ard's suggestion and update the
commit message in the next week, the code looks like this:

-----8<-----
diff --git a/drivers/firmware/efi/libstub/loongarch.c 
b/drivers/firmware/efi/libstub/loongarch.c
index 3782d0a187d1..e5991aa9f805 100644
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
+       /* We should never get here, only to fix the objtool warning */
+       return EFI_LOAD_ERROR;
  }
-----8<-----

Thanks,
Tiezhu


