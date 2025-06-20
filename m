Return-Path: <linux-efi+bounces-3840-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C0C7AE15BF
	for <lists+linux-efi@lfdr.de>; Fri, 20 Jun 2025 10:20:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 921547A934E
	for <lists+linux-efi@lfdr.de>; Fri, 20 Jun 2025 08:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8B2D202F6D;
	Fri, 20 Jun 2025 08:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T8GyoOUe"
X-Original-To: linux-efi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03810235058
	for <linux-efi@vger.kernel.org>; Fri, 20 Jun 2025 08:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750407596; cv=none; b=QZHh4WPCNput5dGetQ5JNxMC9U/N42Py2BKXzy+b9oLVFdA2l7uLhsjoTVxQj4G4R8lR2RviCotSkFt2WifYDi9RCEV6ccqKGgtnAxAywe0OTwDZKcwo7VnS0p0c2V6zP9nB0QHj7M808dEDhFu2FXuG9lvVFsCqttpfHwq1MAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750407596; c=relaxed/simple;
	bh=EZJgeG7o7S5LSoNijejXr1VzyhgQ9cnzYr7vFQVsCQM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=INTMErb5mYt8LI+0ryPaYCEplAtAIZeIB/oYZOnwM0QIFB0VC9H4nXNzbdv6/mASIsg7W5eZC60Meo9U3aecLiuZ5/l+cu40B1LqfvLQ158wCmfdYH4AfCN1BG81QjhF0IkqkxRXJ1eFR4fKaGqT3M95KrGcfrqI7M+FyPimFl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T8GyoOUe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750407593;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I42ahxY637ah5hv17ijVkw5D/XryJ8P8/wdbbtL7i+U=;
	b=T8GyoOUeGnLBSycwz2L6W5+X4FSNks2h/BG1zdgZHEjB6iRbY8w2Qv9EN/tIwGQ3Y0ReG+
	OvRxZ59SFYd/iVmGu+PtXP0MuurM60N3airuuhGbpR8sCTJDbEs3yimVdF99Zps25JcCw/
	YfXXOMiqFvCDYCLaeBuX7OwtnKZIkDo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-egN-QUIOOrSp75InDRMCMA-1; Fri, 20 Jun 2025 04:19:52 -0400
X-MC-Unique: egN-QUIOOrSp75InDRMCMA-1
X-Mimecast-MFC-AGG-ID: egN-QUIOOrSp75InDRMCMA_1750407591
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a4f3796779so788093f8f.1
        for <linux-efi@vger.kernel.org>; Fri, 20 Jun 2025 01:19:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750407591; x=1751012391;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I42ahxY637ah5hv17ijVkw5D/XryJ8P8/wdbbtL7i+U=;
        b=UC5g0oKBfpyl9jPO0r4IbkepK+KFek2ocaLn05RuThou8y7bi55GCz05kA79TrOK7Y
         UUcaYkBMK68zq3XNM0A7v9I804fYP823vvByc/TQX3riOExkVyvfdwCTKn9Abk+v0NVQ
         vAsDTkSkh/z0CSokeJv/bkiQSJJ05EIEwYQyKDeGinVrmb3P2Jh0xdGsXCi5R4xDiGoh
         VvL+Ai4Y7iiK7sQRAZVfuJoeEJCNoNtqY/u4VgGeEtMrgZkgCYsiQ+OqusIzUzr25oRx
         cd/BFLWhIKcZE5rXOaAvRwpJ8Dl6xa6FEMCoMh8U2J9ykv/wxlLZsG5kTZDYdJGmTKDr
         OwEQ==
X-Gm-Message-State: AOJu0YzTuDxx5fEdMMihmYRepvl+jE+awfqd03ckJRcDQ40y7t9xU1J/
	2RxUrHqNvCIWwjVGyeNiFWg5MbzSYoL0fUAMplZCcijaFgLGENWjOUDJm44esLJZGPcd3NZeo4D
	YbtdEKZq9AjgBywgSHjH8pNWqsPpc58KkR+oyZl4r6tCUc2ioaKyZbuCsclr1ng==
X-Gm-Gg: ASbGnctjyVwwJyAPhwTo+47/HEIBMmK77+SNYKjqL6uVpC7HNLTnAl8CqXKWMBI1wxH
	h7nqa0s6zNHrApPus/EQhP1n9j+wpKRI2vo5Te30+wi6VkARb9LPSs1W4dynH/vNoqJqnaKyL37
	kboZBPYtwO9OA4POsVi5tobWPf2sWTfghjvxQQq7hLHhDn7TKzC//Yr/G4qjGYiLTiTqDZstw7H
	EZJmhOgWwTS84fmViWPeV5qrmnHkWtGkG8A2yEU5z2eeEKwB6ugOVv7Z5+SO6dpmTLr9wPMO42S
	0eLaCO4o+1teiFlitPE=
X-Received: by 2002:a05:6000:4284:b0:3a5:783f:5289 with SMTP id ffacd0b85a97d-3a6d1310426mr1399039f8f.49.1750407591008;
        Fri, 20 Jun 2025 01:19:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHjbyKfwYax+z1je2KpEdB0he3Tm2a0YUIzDj7QxBg0hghd6uGZaDXXPhvxDh2eI7i4eZRSMA==
X-Received: by 2002:a05:6000:4284:b0:3a5:783f:5289 with SMTP id ffacd0b85a97d-3a6d1310426mr1399019f8f.49.1750407590629;
        Fri, 20 Jun 2025 01:19:50 -0700 (PDT)
Received: from fedora ([2a00:11b1:10e1:28a7:c525:9906:d20b:f587])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6d117c663sm1408561f8f.64.2025.06.20.01.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 01:19:50 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org, Peter Jones <pjones@redhat.com>, Gerd
 Hoffmann <kraxel@redhat.com>, Heinrich Schuchardt
 <heinrich.schuchardt@gmx.de>
Subject: Re: [PATCH] efi: Fix .data section size calculations when .sbat is
 present
In-Reply-To: <CAMj1kXFq+oVwuHhkCxYG5mhpeS1fStRURSg5i6+wLo-rxi=Phg@mail.gmail.com>
References: <20250618122008.264294-1-vkuznets@redhat.com>
 <CAMj1kXEB7TSF2hUFqwxzdxca6YuCTbQ9fZv1KBf917=FVCvTgA@mail.gmail.com>
 <CAMj1kXFq+oVwuHhkCxYG5mhpeS1fStRURSg5i6+wLo-rxi=Phg@mail.gmail.com>
Date: Fri, 20 Jun 2025 10:19:48 +0200
Message-ID: <874iwaq0yj.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ard Biesheuvel <ardb@kernel.org> writes:

> On Thu, 19 Jun 2025 at 17:29, Ard Biesheuvel <ardb@kernel.org> wrote:
>>
>> On Wed, 18 Jun 2025 at 14:20, Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>> >
>> > Commit 0f9a1739dd0e ("efi: zboot specific mechanism for embedding SBAT
>> > section") neglected to adjust the sizes of the .data section when
>> > CONFIG_EFI_SBAT_FILE is set. As the result, the produced PE binary is
>> > incorrect and some tools complain about it. E.g. 'sbsign' reports:
>> >
>> >  # sbsign --key my.key --cert my.crt arch/arm64/boot/vmlinuz.efi
>> >  warning: file-aligned section .data extends beyond end of file
>> >  warning: checksum areas are greater than image size. Invalid section table?
>> >
>> > Note, '__data_size' was also used in the PE optional header. The field is
>> > supposed to reflect "The size of the initialized data section, or the sum
>> > of all such sections if there are multiple data sections.". While OVMF
>> > based firmware doesn't seem to care much about what's there, it sounds like
>> > including .sbat in the calculation is more correct.
>> >
>> > Fixes: 0f9a1739dd0e ("efi: zboot specific mechanism for embedding SBAT section")
>> > Reported-by: Heinrich Schuchardt <heinrich.schuchardt@gmx.de>
>> > Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>> > ---
>> >  drivers/firmware/efi/libstub/zboot-header.S | 2 +-
>> >  drivers/firmware/efi/libstub/zboot.lds      | 6 ++++--
>> >  2 files changed, 5 insertions(+), 3 deletions(-)
>> >
>>
>> Thanks for the fix.
>>
>> > diff --git a/drivers/firmware/efi/libstub/zboot-header.S b/drivers/firmware/efi/libstub/zboot-header.S
>> > index b6431edd0fc9..65df5f52e138 100644
>> > --- a/drivers/firmware/efi/libstub/zboot-header.S
>> > +++ b/drivers/firmware/efi/libstub/zboot-header.S
>> > @@ -41,7 +41,7 @@ __efistub_efi_zboot_header:
>> >         .short          .Lpe_opt_magic
>> >         .byte           0, 0
>> >         .long           _etext - .Lefi_header_end
>> > -       .long           __data_size
>> > +       .long           __all_data_size
>>
>> Frankly, I'm not sure if this is even worth the hassle.
>>
>> There is also a 'size of uninitialized data' field, but given that the
>> .data section has both initialized data and uninitialized data, and
>> the fact that no loaders appear to care about these fields, let's just
>> not bother.
>>
>
> ... or add .sbat to SizeOfCode instead. (the preceding field)
>

I was wondering how to make it consistent with yet-unmerged x86
patch. In v3:
https://lore.kernel.org/linux-efi/20250603091951.57775-1-vkuznets@redhat.com/
.sbat was accounted as SizeOfCode but the section is
"IMAGE_SCN_CNT_INITIALIZED_DATA", not "IMAGE_SCN_CNT_CODE" so I sent v4
yesterday:
https://lore.kernel.org/linux-efi/20250619151759.355893-1-vkuznets@redhat.com/
which made .sbat accounted in SizeOfInitializedData.

-- 
Vitaly


