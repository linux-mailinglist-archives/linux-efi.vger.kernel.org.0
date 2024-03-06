Return-Path: <linux-efi+bounces-751-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C079873A8E
	for <lists+linux-efi@lfdr.de>; Wed,  6 Mar 2024 16:21:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFD201C21354
	for <lists+linux-efi@lfdr.de>; Wed,  6 Mar 2024 15:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78617134CEF;
	Wed,  6 Mar 2024 15:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="P8Jjnct+"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7666F5DF1D
	for <linux-efi@vger.kernel.org>; Wed,  6 Mar 2024 15:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709738491; cv=none; b=oTffDVs8cbJPpsN/EZKnqC6HF+UcnBtH1sSOXdeY3EefIeY+UepLTUkUc4DeOOmhd0JsA5WTJRn4i31+DJyCBA72bXP5ev72qyZD1HohHQLmTtxNvorkVgGwa65QAu7ovFko2hge7pDFlC84k5UhpZ1+YW0b5cg4bew8xcZrP0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709738491; c=relaxed/simple;
	bh=JDc5r3BRrOZ1w1zNcP41fD1K/PAk1OWRsEOHFAyAIe4=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=nvrOf/E9ttD1RnuwVmqKU/0OXZuRe09nGU/5gaQJIxev5BbA/M/PaLpGSyqofwxSmtXzD729IfVVGhyr4+4ScMJCJ2je3/3YJSjoSQCbkESD2belersPDAvw5qm4kWn3OBgyboGrACt8wu4JZKImqwg9UUfdAOBC58V1Y0cx+UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=P8Jjnct+; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1dc49afb495so9063725ad.2
        for <linux-efi@vger.kernel.org>; Wed, 06 Mar 2024 07:21:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1709738489; x=1710343289; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n8Qqx9ooCSBKu7MZRWmQy03iinWuJivXIhQKkqlVv5I=;
        b=P8Jjnct+6XKuJIQn74As4ATNMt9yIGu293nUfPHrg0NptSrTVZJWc3KmZWSuRQGQ0u
         pzd9FoYuvMxZVFfzuedo+BkbgsHXMJHqsxDnMJiN75uXatnE2YvnAtmqMRSTSLvVt+wU
         8MerIGGu8HfB5QCZpEsvKEgqEfzAADQgXxWkYYyqPZ+MvJfY2W9ZDmICNPVubkGOnyI4
         z4cv3Jq+yZj2P6U4LbcecjrjD4qCmCJfWRr06sDXm1+xzcaPO9Vbty9egylrx3hJbCRM
         lZTYJf7bvkuj48fRMd4dV+SIgwCRLQpgcZheL26af/atGyJpIZeqbZ0Gypn0K2YLn50E
         asBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709738489; x=1710343289;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n8Qqx9ooCSBKu7MZRWmQy03iinWuJivXIhQKkqlVv5I=;
        b=IPfFXBKhYIiXot7SRw9NNgRvooj95isaCAyth3vfmxf+IGu176TAWlvCUo1SpDEQRB
         Ywy1/ro2tVup5jWTB26QZk05s5nlNYDXUZwWdkvAxqm+AfKYrnmh9jrEOaOkbWCiaeWL
         oD2hiOSEOrDsyi05edtZCEbQxw1pWhJmZa0F1iIi7RW6tI4HmIFxYKXIp4VIiN05Ymbr
         EX73LbWa8L+bLLQY3xl2vFlbz9SS0lN/evIZvD8QaU9G1falT8NeTWlhf3fzTeN9A3J+
         qOTgoqUT7cikkG4yp5WQYwYt9PWpb571CInYzj6+nMPONjKYrp/SoOMriURdt2v2ogGJ
         +1Kg==
X-Forwarded-Encrypted: i=1; AJvYcCWnO0GH95aXvdGz+FojYRMExy5b8aU5cBt6tglezNtSjftPCS7x431k/JZnG7ilXlN3XzxsvJcxDql/Va8Gpn9T4nqHyEja43zH
X-Gm-Message-State: AOJu0YwfAr0xszokYj+v1XP0599e2PwsOSJ+3sQcrKM1xyBtpNBjOgKs
	CGpFzd8eGvzWqY8I4Oc+05q94+JDpSA3vbhEGuVAQn54R4vrXqEqXqcTimvPjz8=
X-Google-Smtp-Source: AGHT+IHS64f5maqdTjPkHR3rlh1H8dRVq7aDFlNHNq/juokRqXnYFlJ9FFwUBMnE7dQOFGHwlqSFxw==
X-Received: by 2002:a17:903:230a:b0:1dc:fb9d:402d with SMTP id d10-20020a170903230a00b001dcfb9d402dmr6231276plh.58.1709738488550;
        Wed, 06 Mar 2024 07:21:28 -0800 (PST)
Received: from localhost ([192.184.165.199])
        by smtp.gmail.com with ESMTPSA id ld4-20020a170902fac400b001db5b39635dsm12783423plb.277.2024.03.06.07.21.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 07:21:27 -0800 (PST)
Date: Wed, 06 Mar 2024 07:21:27 -0800 (PST)
X-Google-Original-Date: Wed, 06 Mar 2024 07:21:17 PST (-0800)
Subject:     Re: [External] Re: [PATCH 3/3] efistub: fix missed the initialization of gp
In-Reply-To: <CAMj1kXH1oMbONoHFMPaatfaqrHNE2ryfrG7kw-7J-eFsuXkK-Q@mail.gmail.com>
CC: cuiyunhui@bytedance.com, Paul Walmsley <paul.walmsley@sifive.com>,
  aou@eecs.berkeley.edu, xuzhipeng.1973@bytedance.com, alexghiti@rivosinc.com, samitolvanen@google.com,
  bp@alien8.de, xiao.w.wang@intel.com, jan.kiszka@siemens.com, kirill.shutemov@linux.intel.com,
  nathan@kernel.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
  linux-efi@vger.kernel.org
From: Palmer Dabbelt <palmer@dabbelt.com>
To: Ard Biesheuvel <ardb@kernel.org>
Message-ID: <mhng-c53211c1-4708-459a-bdc5-6e013c2adaee@palmer-ri-x1c9>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Wed, 06 Mar 2024 05:09:07 PST (-0800), Ard Biesheuvel wrote:
> On Wed, 6 Mar 2024 at 14:02, Ard Biesheuvel <ardb@kernel.org> wrote:
>>
>> On Wed, 6 Mar 2024 at 13:34, yunhui cui <cuiyunhui@bytedance.com> wrote:
>> >
>> > Hi Ard,
>> >
>> > On Wed, Mar 6, 2024 at 5:36 PM Ard Biesheuvel <ardb@kernel.org> wrote:
>> > >
>> > > On Wed, 6 Mar 2024 at 09:56, Yunhui Cui <cuiyunhui@bytedance.com> wrote:
>> > > >
>> > > > Compared with gcc version 12, gcc version 13 uses the gp
>> > > > register for compilation optimization, but the efistub module
>> > > > does not initialize gp.
>> > > >
>> > > > Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
>> > > > Co-Developed-by: Zhipeng Xu <xuzhipeng.1973@bytedance.com>
>> > >
>> > > This needs a sign-off, and your signoff needs to come after.
>> > >
>> > > > ---
>> > > >  arch/riscv/kernel/efi-header.S | 11 ++++++++++-
>> > > >  1 file changed, 10 insertions(+), 1 deletion(-)
>> > > >
>> > > > diff --git a/arch/riscv/kernel/efi-header.S b/arch/riscv/kernel/efi-header.S
>> > > > index 515b2dfbca75..fa17c08c092a 100644
>> > > > --- a/arch/riscv/kernel/efi-header.S
>> > > > +++ b/arch/riscv/kernel/efi-header.S
>> > > > @@ -40,7 +40,7 @@ optional_header:
>> > > >         .long   __pecoff_data_virt_end - __pecoff_text_end      // SizeOfInitializedData
>> > > >  #endif
>> > > >         .long   0                                       // SizeOfUninitializedData
>> > > > -       .long   __efistub_efi_pe_entry - _start         // AddressOfEntryPoint
>> > > > +       .long   _efistub_entry - _start         // AddressOfEntryPoint
>> > > >         .long   efi_header_end - _start                 // BaseOfCode
>> > > >  #ifdef CONFIG_32BIT
>> > > >         .long  __pecoff_text_end - _start               // BaseOfData
>> > > > @@ -121,4 +121,13 @@ section_table:
>> > > >
>> > > >         .balign 0x1000
>> > > >  efi_header_end:
>> > > > +
>> > > > +       .global _efistub_entry
>> > > > +_efistub_entry:
>> > >
>> > > This should go into .text or .init.text, not the header.
>> > >
>> > > > +       /* Reload the global pointer */
>> > > > +       load_global_pointer
>> > > > +
>> > >
>> > > What is supposed to happen here if CONFIG_SHADOW_CALL_STACK=y? The EFI
>> > > stub Makefile removes the SCS CFLAGS, so the stub will be built
>> > > without shadow call stack support, which I guess means that it might
>> > > use GP as a global pointer as usual?
>> > >
>> > > > +       call __efistub_efi_pe_entry
>> > > > +       ret
>> > > > +
>> > >
>> > > You are returning to the firmware here, but after modifying the GP
>> > > register. Shouldn't you restore it to its old value?
>> > There is no need to restore the value of the gp register. Where gp is
>> > needed, the gp register must first be initialized. And here is the
>> > entry.
>> >
>>
>> But how should the firmware know that GP was corrupted after calling
>> the kernel's EFI entrypoint? The EFI stub can return to the firmware
>> if it encounters any errors while still running in the EFI boot
>> services.
>>
>
> Actually, I wonder if GP can be modified at all before
> ExitBootServices(). The EFI timer interrupt is still live at this
> point, and so the firmware is being called behind your back, and might
> rely on GP retaining its original value.

[A few of us are talking on IRC as I'm writing this...]

The UEFI spec says "UEFI firmware must neither trust the
values of tp and gp nor make an assumption of owning the write access to 
these register in any circumstances".  It's kind of vague what "UEFI 
firmware" means here, but I think it's reasonable to assume that the 
kernel (and thus the EFI stub) is not included there.

So under that interpretation, the kernel (including the EFI stub) would 
be allowed to overwrite GP with whatever it wants.

[We're still talking on IRC, though]

