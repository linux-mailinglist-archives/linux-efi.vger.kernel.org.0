Return-Path: <linux-efi+bounces-3481-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B58D0AA07D1
	for <lists+linux-efi@lfdr.de>; Tue, 29 Apr 2025 11:55:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94DAB3B204B
	for <lists+linux-efi@lfdr.de>; Tue, 29 Apr 2025 09:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E974D2BE10B;
	Tue, 29 Apr 2025 09:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O4QBT5yC"
X-Original-To: linux-efi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D8C2BE0E1
	for <linux-efi@vger.kernel.org>; Tue, 29 Apr 2025 09:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745920540; cv=none; b=fl8+0hRRlOjgieQTkflwMmYI2BZVq3Zpnt0w8B/JP8m75MMrgietb2MySEhWctMbYryB9u4IB+fP0OBIPAj1CWus5hD50JTZIAQLXVsxetfdyezCoTTaRro40kvWDEcjT4Z5dz6uSyujf7C/m6GeqPUjmJIq2qhQP38hzrkFP8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745920540; c=relaxed/simple;
	bh=keJfQAoUIwU/GXMp5g4AzFuoVvBz2pxzJTdJyj/jCAI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HqJWgtrP8sn0p/XJM0D5muuvtFCNGoNYsFr0E+rzAlhAzwuJOYOZGX2O2mJDjCbW1ARP0v0H0qPZUHPTdNGLg/JWCi+j8KKFri1CxqJQigFEs4SiWW1fV0qDGFjlRbIp2LecWdsRJ0FloWpCWbkVX51Nj6aeqUc55la1H0CpR0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O4QBT5yC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745920538;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xntjKgnfwZOTv8Lz3QOtpBAGgzG+hyrtl5zomojulJw=;
	b=O4QBT5yCoE5A9ZbsWB2L2nM9SESAMBDbg1OWBNbOQ+aMazjLYggjzYCGzR/rQ7R7FLzM4X
	IRryQMwZeaqa05iiNpq64B7ezQOGKwgdgzSUWlbwqtAaY/7KwTL+7j+8cEOsP8e4Ialugx
	MC0iOwuFeX3NA6997+L7yjvOVNNZge0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-330-aCH6l5aNNQuUz_W3OOHmtQ-1; Tue, 29 Apr 2025 05:55:33 -0400
X-MC-Unique: aCH6l5aNNQuUz_W3OOHmtQ-1
X-Mimecast-MFC-AGG-ID: aCH6l5aNNQuUz_W3OOHmtQ_1745920532
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43eea5a5d80so28697425e9.1
        for <linux-efi@vger.kernel.org>; Tue, 29 Apr 2025 02:55:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745920532; x=1746525332;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xntjKgnfwZOTv8Lz3QOtpBAGgzG+hyrtl5zomojulJw=;
        b=YvwSuR64K4tASzTWpDD+AC5xiLuJjWPYaZZIkQUn/Fb+X1lQlyp7JsE24+a7/9DGxd
         CMPdyYKvCIa8FQoVq4+z/nZQENl7Yxv3wXw5wKpAhopo9hOFv74OGyT6AZAXDL6XsiNP
         n1IKXxg3w3bn6T5fJG/6gqN8t90cbJDmPxGdfLwkLsZKDZYo45AmnsourDJ5niwAj7i/
         LujEmSHOp5qOLbN0UFlf2u7Y/zaMwFnb35u9cZxNbkYZvnp5S8JlqyDr7gXwjBq753QB
         8pKIQqmHKCtHUl3np/+MqpQSb1hlurLtF2upRGpb9NoKpKuiRjregUeUTubDwIyjhgBS
         OPxg==
X-Forwarded-Encrypted: i=1; AJvYcCWXOmnpweOKRxpvfpvEP7NYLiuTCMWB84JMVKBN2QtAhPsq+5LhMzfXrA3ZjwS092syX6EmvlSdKgA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJQ6GhNtDlIv6jNUR5rUfyl2dmsV2rTeJ79HVpvuR0fFiRXDcD
	jQHkpPiXTttqrsSTD1gg5RJU8Wx69ttcZXcUyGm5b04mt0jLxzc6aau5h39TLxpYNq+wiP8VzmT
	Bkn7YKTFhyF1ben/8t4z0f5CQr9iEgCLl4CazuJT0mltnX1Bgqmm3dS/klA==
X-Gm-Gg: ASbGncvF66ju7v2lZM0D5q08/UKyxsCcGe5te4NkKZbEFiz92FPTn5EsEoxMcm8tAdO
	4hf7qB+ILxp1QIX/jbNJzLj/zu2aypWhACDMHHhWeMaRf4Y8GGY7Fq/kg4Gowe+8fh1AULyhuZ+
	xnzxj/aDx40JkH7LHa7K4MLr5WhDhM7tICE2jibjPYUzWMHrkvPsLdh3BJMErIBkN6cfdhS2Kql
	6QtJIXAVNdBD6ew7kWwYzeG58EqiHdN9Ga8tiNWJg85gpKy6iZCSRGchzCCv/4hKgoAfN1s173F
	Yd+4syA=
X-Received: by 2002:a05:6000:310f:b0:3a0:8ac0:e496 with SMTP id ffacd0b85a97d-3a08ac0e542mr1848873f8f.7.1745920532213;
        Tue, 29 Apr 2025 02:55:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGfIWeyLjpuG6s2coM0Lu8kDibF6g1giWUUP9D7vYfEQD+QdfZivGSCk1W0/tffaKL2WnLAcw==
X-Received: by 2002:a05:6000:310f:b0:3a0:8ac0:e496 with SMTP id ffacd0b85a97d-3a08ac0e542mr1848828f8f.7.1745920531827;
        Tue, 29 Apr 2025 02:55:31 -0700 (PDT)
Received: from fedora (g3.ign.cz. [91.219.240.17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a073e5c7d1sm13359287f8f.83.2025.04.29.02.55.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 02:55:31 -0700 (PDT)
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
In-Reply-To: <CAMj1kXFMmhROmaDZ0gsw+ozG5iSkMvSXb15qexToUSAFyBn5hQ@mail.gmail.com>
References: <20250424080950.289864-1-vkuznets@redhat.com>
 <20250424080950.289864-3-vkuznets@redhat.com>
 <CAMj1kXFMmhROmaDZ0gsw+ozG5iSkMvSXb15qexToUSAFyBn5hQ@mail.gmail.com>
Date: Tue, 29 Apr 2025 11:55:29 +0200
Message-ID: <87ikmn9tri.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ard Biesheuvel <ardb@kernel.org> writes:

> On Thu, 24 Apr 2025 at 10:10, Vitaly Kuznetsov <vkuznets@redhat.com> wrote:

...

>> diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
>> index fdbce022db55..b9b80eccdc02 100644
>> --- a/arch/x86/boot/compressed/Makefile
>> +++ b/arch/x86/boot/compressed/Makefile
>> @@ -107,6 +107,8 @@ vmlinux-objs-$(CONFIG_UNACCEPTED_MEMORY) += $(obj)/mem.o
>>  vmlinux-objs-$(CONFIG_EFI) += $(obj)/efi.o
>>  vmlinux-libs-$(CONFIG_EFI_STUB) += $(objtree)/drivers/firmware/efi/libstub/lib.a
>>
>> +vmlinux-objs-$(CONFIG_EFI_SBAT) += $(objtree)/drivers/firmware/efi/libstub/sbat.o
>> +
>
> Please drop this, and put the .incbin directly into header.S
>

I'm sorry I'm probably missing something important but my understanding
is that that header.S is compiled into setup.elf:

 ld -m elf_x86_64 -z noexecstack --no-warn-rwx-segments  -m elf_i386 -z
 noexecstack -T arch/x86/boot/setup.ld  ... arch/x86/boot/header.o ...  -o arch/x86/boot/setup.elf

and then the result gets concatenated with vmlinux.bin to get bzImage:

 objcopy  -O binary arch/x86/boot/setup.elf arch/x86/boot/setup.bin
 cp arch/x86/boot/setup.bin arch/x86/boot/bzImage; truncate -s %4K arch/x86/boot/bzImage; cat arch/x86/boot/vmlinux.bin >>arch/x86/boot/bzImage

so if we want to have SBAT at the very end of bzImage without dirty
tricks it must be at the very end of vmlinux.bin, not setup.bin. I can,
of course, use some existing compilation unit but to be honest I can't
find anything suitable.

-- 
Vitaly


