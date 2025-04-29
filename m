Return-Path: <linux-efi+bounces-3484-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BAB11AA0877
	for <lists+linux-efi@lfdr.de>; Tue, 29 Apr 2025 12:24:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9EFB7A8D9D
	for <lists+linux-efi@lfdr.de>; Tue, 29 Apr 2025 10:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3534F2BF3FA;
	Tue, 29 Apr 2025 10:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DotFVh0G"
X-Original-To: linux-efi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953CC2C1082
	for <linux-efi@vger.kernel.org>; Tue, 29 Apr 2025 10:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745922271; cv=none; b=EiUWSDmQAvLC6szVmAgv61wMdUv6g1i4apkNftkZiU5ftTUeC6yXr60rG840MaGBZ7NNG0kbYqcBVOr3SnHHHpjP4nTKd9zQj/vwz+YdHiEq4uEI+2Oi1r8Yb4/zHg9Si8U1Rvz0QmhFWCtf2q6ddsF2aeqIfbX4OhixwaqeZ+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745922271; c=relaxed/simple;
	bh=mIokkismE9b0ITX8QD/umdH27xhxFXMQAp0rkvZ/QUE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=g4EAYJoswk0H732+KcPYwM0cOJs11bsbFaSsKvGYI7x49Ew2YKRiAoXXjxbrHEVyW3KpM9wrCfuYYnfa5iquYXy/363UaaurZx3Cr/4WCNHWXdAfvHXZ8yF1V6bzZSshzSBj1BEEfo9kY9VqXly+epRBj5gQAtEhlY28cnSbdjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DotFVh0G; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745922268;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MJDenMq4UnA+J9tvrAddv1d5fx82EYV9asQIQ+z0GZg=;
	b=DotFVh0Gtb3O5xoiU+GtjQHmiqkA9OwDc+Y0nFZEinFlkifbcCVyFoZS9jl3TWCg0HxHab
	kRSUU/7tE1zqTNGTLgB6M4Gz1xMKV9nu4v8joLbQ1AAiLx+DYVei3zEtZMyY4/i/dwlFMv
	/nXJeM58fG/FK1v30atsti+wtO+BMRw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-452-KVxUAKjINGiGB9UjcrrYHw-1; Tue, 29 Apr 2025 06:24:27 -0400
X-MC-Unique: KVxUAKjINGiGB9UjcrrYHw-1
X-Mimecast-MFC-AGG-ID: KVxUAKjINGiGB9UjcrrYHw_1745922266
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43cf327e9a2so39247875e9.3
        for <linux-efi@vger.kernel.org>; Tue, 29 Apr 2025 03:24:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745922266; x=1746527066;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MJDenMq4UnA+J9tvrAddv1d5fx82EYV9asQIQ+z0GZg=;
        b=Bpg/KGNo362P4pT8vv4Kwm7/OZdpwQ3pGdCuxDQOX2OaV7qlH7a8YlYOtUvGoczX39
         z8dkemUg7vp9FrNw+uLwRBtz+OzVUU064PfJqpKeyEk5pos5TeS2RWdm/lUdmx1Klg7N
         wgjyIDtPSpjRdgBV1sNeEjefELXLLWShZS/UNcU+6vPPD7B3XsuNASYSSF1IV8JhC6li
         SZ4k3CgZh1nrUzGodmJRTHPkeJLQL49KIZ9ibKuPo6P5es2v7k7WbuQvewhXRhIKZ9nl
         BHFBz/VitbuRcokukyqroB150fLVaoMR62BqSr6EfHVsee6y6Hz44w2aUzsp61Z6EjhO
         96HA==
X-Forwarded-Encrypted: i=1; AJvYcCW6rhYpSDLpR2/CxjIoLoogeRqdDJP+xt8Fwb/OpyXeQQpiJG4w6xVhLnA22GNTiPh5js5R1arU52c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYF4b4LOpELIBU+RhZA94hhQxxxwO9urOiHaXHIm9hBflMo/R9
	mYVT4EUlEJms7/29KdVDrL9mLTQP/u+21qcpocKiA/Rb/oJMQIsHXijmsIAwLJgsO/K+u6Bmuk3
	VMp/itNiix8wVd6bptWca8iA95q1/UjBjkC9Og3rQS/zA8ECmhcC0lkyRNg==
X-Gm-Gg: ASbGnctrvImV++lrUMO8y8MNZmRSUmF/9d9aUypvujwgelosesCTjHk16KHp9M+ly+o
	cpSeVvnvFBQByezNaMbPReqnd0PdBuwx18agBvwkwLevdgYQs/9SP31k9nDImgTL/JyOlR7ZDYX
	EXOsZBgy/N326zsx4CcruAi4gfz18mpQB1Cc6HkDNhXhXxeicyBco/95SU4I6QavGMRlz7CNuWy
	GTJXba/FIS5IXMM/Z0gHV3pi1LM13OXdEz3PVblvlhSXPxUH0t6oaBDBTS3oj9wdk0orHPzbO3x
	N8Mn11k=
X-Received: by 2002:a05:600c:35d5:b0:43c:fa24:873e with SMTP id 5b1f17b1804b1-441ad3b964cmr18549725e9.13.1745922265750;
        Tue, 29 Apr 2025 03:24:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFCuK0SnkDnf6F2mCzzqm8B+HP2+9+Mxx8hNK6OkeTe6Yi/IGcxXyhQ2mE6S12P8pv8w1eJVQ==
X-Received: by 2002:a05:600c:35d5:b0:43c:fa24:873e with SMTP id 5b1f17b1804b1-441ad3b964cmr18549445e9.13.1745922265315;
        Tue, 29 Apr 2025 03:24:25 -0700 (PDT)
Received: from fedora (g3.ign.cz. [91.219.240.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-440a5369cdasm154962675e9.31.2025.04.29.03.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 03:24:24 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: x86@kernel.org, linux-efi@vger.kernel.org, Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Dave Hansen
 <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Peter
 Jones <pjones@redhat.com>, Daniel Berrange <berrange@redhat.com>, Emanuele
 Giuseppe Esposito <eesposit@redhat.com>, Gerd Hoffmann
 <kraxel@redhat.com>, Greg KH <gregkh@linuxfoundation.org>, Luca Boccassi
 <bluca@debian.org>, Peter Zijlstra <peterz@infradead.org>, Matthew Garrett
 <mjg59@srcf.ucam.org>, James Bottomley
 <James.Bottomley@hansenpartnership.com>, Eric Snowberg
 <eric.snowberg@oracle.com>, Paolo Bonzini <pbonzini@redhat.com>, Paul
 Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] x86/efi: Implement support for embedding SBAT data
 for x86
In-Reply-To: <CAMj1kXHTtGP-UcJLut7OVUuULzg59npyoQhb+kuCZO5x-2NYWA@mail.gmail.com>
References: <20250424080950.289864-1-vkuznets@redhat.com>
 <20250424080950.289864-3-vkuznets@redhat.com>
 <CAMj1kXFMmhROmaDZ0gsw+ozG5iSkMvSXb15qexToUSAFyBn5hQ@mail.gmail.com>
 <87ikmn9tri.fsf@redhat.com>
 <CAMj1kXHTtGP-UcJLut7OVUuULzg59npyoQhb+kuCZO5x-2NYWA@mail.gmail.com>
Date: Tue, 29 Apr 2025 12:24:23 +0200
Message-ID: <87cycv9sfc.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ard Biesheuvel <ardb@kernel.org> writes:

> On Tue, 29 Apr 2025 at 11:55, Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>>
>> Ard Biesheuvel <ardb@kernel.org> writes:
>>
>> > On Thu, 24 Apr 2025 at 10:10, Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>>
>> ...
>>
>> >> diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
>> >> index fdbce022db55..b9b80eccdc02 100644
>> >> --- a/arch/x86/boot/compressed/Makefile
>> >> +++ b/arch/x86/boot/compressed/Makefile
>> >> @@ -107,6 +107,8 @@ vmlinux-objs-$(CONFIG_UNACCEPTED_MEMORY) += $(obj)/mem.o
>> >>  vmlinux-objs-$(CONFIG_EFI) += $(obj)/efi.o
>> >>  vmlinux-libs-$(CONFIG_EFI_STUB) += $(objtree)/drivers/firmware/efi/libstub/lib.a
>> >>
>> >> +vmlinux-objs-$(CONFIG_EFI_SBAT) += $(objtree)/drivers/firmware/efi/libstub/sbat.o
>> >> +
>> >
>> > Please drop this, and put the .incbin directly into header.S
>> >
>>
>> I'm sorry I'm probably missing something important but my understanding
>> is that that header.S is compiled into setup.elf:
>>
>>  ld -m elf_x86_64 -z noexecstack --no-warn-rwx-segments  -m elf_i386 -z
>>  noexecstack -T arch/x86/boot/setup.ld  ... arch/x86/boot/header.o ...  -o arch/x86/boot/setup.elf
>>
>> and then the result gets concatenated with vmlinux.bin to get bzImage:
>>
>>  objcopy  -O binary arch/x86/boot/setup.elf arch/x86/boot/setup.bin
>>  cp arch/x86/boot/setup.bin arch/x86/boot/bzImage; truncate -s %4K arch/x86/boot/bzImage; cat arch/x86/boot/vmlinux.bin >>arch/x86/boot/bzImage
>>
>> so if we want to have SBAT at the very end of bzImage without dirty
>> tricks it must be at the very end of vmlinux.bin, not setup.bin. I can,
>> of course, use some existing compilation unit but to be honest I can't
>> find anything suitable.
>>
>
> Yeah, you're right. I keep forgetting the insane way the bzImage is
> put together.
>
> So you'll need to incorporate $(CONFIG_EFI_SBAT_FILE) into
> arch/x86/boot/vmlinux. But that does not mean it needs to be
> constructed under drivers/firmware/efi/libstub, and it also doesn't
> mean you need filechk and a separate .o file, right?

Right, it just needs to be somewhere and this somewhere needs to depend
on the SBAT data to track its possible updates. E.g. looking at asm
files in arch/x86/boot/compressed/ (which go to vmlinux) I see:

arch/x86/boot/compressed/head_32.S
arch/x86/boot/compressed/head_64.S
arch/x86/boot/compressed/idt_handlers_64.S
arch/x86/boot/compressed/kernel_info.S
arch/x86/boot/compressed/la57toggle.S
arch/x86/boot/compressed/mem_encrypt.S
arch/x86/boot/compressed/piggy.S
arch/x86/boot/compressed/tdcall.S

and honestly I don't know which one to pick :-( An alternative would be
to create separate 3-line sbat.S files for x86 and zboot and then make
sbat.o dependent on CONFIG_EFI_SBAT_FILE but that would not satisfy all
the requirements as sbat.o stays)

-- 
Vitaly


