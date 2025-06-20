Return-Path: <linux-efi+bounces-3842-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CC82AE195F
	for <lists+linux-efi@lfdr.de>; Fri, 20 Jun 2025 12:58:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDA441BC5FD6
	for <lists+linux-efi@lfdr.de>; Fri, 20 Jun 2025 10:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09154285068;
	Fri, 20 Jun 2025 10:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WfNWY8Qv"
X-Original-To: linux-efi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3895255250
	for <linux-efi@vger.kernel.org>; Fri, 20 Jun 2025 10:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750417098; cv=none; b=iiY/+dlfXCNJfhK7eyNOgKEoeLpTgziru8532FTIz217g2hqMQ8a/2JMkddAgBaYAYFEzAwLAe8jNCzwz855Rq2rJcnrNLiADyYYMmCuJj82cRzm1M1PEipXanPHEAZIEHeU+4zpwnYPTQsxkKmil74TZxgpVWJpZT9FnjtsF3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750417098; c=relaxed/simple;
	bh=wIQYpr1q4W2/qvqBbIaMvAGVz8tNL166nanwWbPx4KU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Gcynz4r6D6rA8qOl+iYzludx5cOeJ9OlsXLNAYqvk6/WoRbP4l8opnczJ8bYhsmElNNjAhGgqPmvvgscuVpGMqTZ6KpQk/co0lPgBsWF3genaffWVXI0gF/1OYHEFpmbIMVTWEq02vpSfHaGXEgZ12ceZo51tcOJmrspganKa7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WfNWY8Qv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750417095;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SU7zY7e+Lzcxu5UnyWg6fhSRNEuNfPMs+LWG0i3XiI4=;
	b=WfNWY8Qv8al8gaMHHtLiUR+UEdft5hKFU7+DJ40CBSfETRSz1CWTK0/zaWlfay3T6MmbXw
	gwjklShbbIObNTQ2x1q7pN1T5r/MLzHexQIPb5fJnPwRc9yced3vqXYpWGkt96St2T5pqv
	ylnZRUeTidTZMhaONmfTi3foHGjI0gQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-IizhkpUbNi6q9VQdRoL6tA-1; Fri, 20 Jun 2025 06:58:13 -0400
X-MC-Unique: IizhkpUbNi6q9VQdRoL6tA-1
X-Mimecast-MFC-AGG-ID: IizhkpUbNi6q9VQdRoL6tA_1750417093
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-453018b4ddeso10539905e9.3
        for <linux-efi@vger.kernel.org>; Fri, 20 Jun 2025 03:58:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750417092; x=1751021892;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SU7zY7e+Lzcxu5UnyWg6fhSRNEuNfPMs+LWG0i3XiI4=;
        b=uXGBz0Mc9dkw0mN8+oz0l3cdk5JLQCxEnEGMqwa6QgdU4S/f2a3f6vL6PH9UBZONz3
         JnCkJXG1YXai9ajzAIx8JpXVxDCcZVELZWQj4f4K2zlhzZjj0GHO8GBCCLw18iEGsamM
         vL1ACxXf7/qclLrbPzdBz1k31FNgIopfRXZ8sSi7mcORLzJVKObsWaaYWNmutrF+r0YJ
         Vr/XWh761EUwVOqRUtG2NhxWcg3G6H+jpLHi1Wow/8tEXE0ruWWYI05NcCaAOGn2NXzE
         1uMUI3cqXMsOpLA5A5NFxBQLnYERR1FFUIl/WskJ3rhyWUT2vnNVZkMGb6Zo1kddCnh4
         vasA==
X-Gm-Message-State: AOJu0YwxkKVQFILTIBBUe3uTRy2LcCi/ln1wLjw5bqWugKpAOZXhAyz8
	mA3+DGo1PyunPZjPccwHpZYu/eWTkbX2cwusejJOAAWJ0Tuw60RY66m1xpMQg6FJzcA97Jq7rTj
	6BP0G3QItMpiM4undz7z3XXGYMu8cQrX+svSf+T7gDV7+9fYoF612Wo3++AagkQ==
X-Gm-Gg: ASbGncvRoKoRpcAeKM0TXUJRynvVnSWnJUUU2Ffl7/EbIvK1gCcDrANofhty2bvBWJw
	RYewHm9yyVuiAJhFl9zxURhYKtdV1tAx8x9Reo5flPe5D8Ye9RqWsvEXVc2H1ybAbthtjhRuNDx
	WCKNM1FBBbM2Cg/UhniIDM7hSgFBvc+z9Lu1+kPndNl2r6LTx54oBkIFVKGjOfbh6c9zlqH0+kA
	QQ3PYNRwBeBbRQ7l5Ufdythneh1+mq5H6JLxxU+WN6DTRIV+ozw59+Wkt6YeglBlUPoLX7ca9m8
	fEY0BG5xwB5Ath4Z2w==
X-Received: by 2002:a05:6000:1a86:b0:3a4:e4ee:4ca9 with SMTP id ffacd0b85a97d-3a6d12a25femr1996949f8f.23.1750417092468;
        Fri, 20 Jun 2025 03:58:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGb98anhr3efzxU3a2aETrIH2eH+S2H8paveHNbHpSqyp/U7o6FJL/GkNgDwvDp2yuyr2rH0w==
X-Received: by 2002:a05:6000:1a86:b0:3a4:e4ee:4ca9 with SMTP id ffacd0b85a97d-3a6d12a25femr1996902f8f.23.1750417092039;
        Fri, 20 Jun 2025 03:58:12 -0700 (PDT)
Received: from fedora (g3.ign.cz. [91.219.240.17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6d0f10138sm1737519f8f.3.2025.06.20.03.58.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 03:58:11 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org, Peter Jones <pjones@redhat.com>, Gerd
 Hoffmann <kraxel@redhat.com>, Heinrich Schuchardt
 <heinrich.schuchardt@gmx.de>
Subject: Re: [PATCH] efi: Fix .data section size calculations when .sbat is
 present
In-Reply-To: <CAMj1kXGh_Edw5-45HfufUvLneV6u66bv3ZfVVB5LAf3d8vE8=Q@mail.gmail.com>
References: <20250618122008.264294-1-vkuznets@redhat.com>
 <CAMj1kXEB7TSF2hUFqwxzdxca6YuCTbQ9fZv1KBf917=FVCvTgA@mail.gmail.com>
 <CAMj1kXFq+oVwuHhkCxYG5mhpeS1fStRURSg5i6+wLo-rxi=Phg@mail.gmail.com>
 <874iwaq0yj.fsf@redhat.com>
 <CAMj1kXGh_Edw5-45HfufUvLneV6u66bv3ZfVVB5LAf3d8vE8=Q@mail.gmail.com>
Date: Fri, 20 Jun 2025 12:58:10 +0200
Message-ID: <871preptml.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ard Biesheuvel <ardb@kernel.org> writes:

> On Fri, 20 Jun 2025 at 10:19, Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>>
>> Ard Biesheuvel <ardb@kernel.org> writes:
>>
>> > On Thu, 19 Jun 2025 at 17:29, Ard Biesheuvel <ardb@kernel.org> wrote:
>> >>
>> >> On Wed, 18 Jun 2025 at 14:20, Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>> >> >
>> >> > Commit 0f9a1739dd0e ("efi: zboot specific mechanism for embedding SBAT
>> >> > section") neglected to adjust the sizes of the .data section when
>> >> > CONFIG_EFI_SBAT_FILE is set. As the result, the produced PE binary is
>> >> > incorrect and some tools complain about it. E.g. 'sbsign' reports:
>> >> >
>> >> >  # sbsign --key my.key --cert my.crt arch/arm64/boot/vmlinuz.efi
>> >> >  warning: file-aligned section .data extends beyond end of file
>> >> >  warning: checksum areas are greater than image size. Invalid section table?
>> >> >
>> >> > Note, '__data_size' was also used in the PE optional header. The field is
>> >> > supposed to reflect "The size of the initialized data section, or the sum
>> >> > of all such sections if there are multiple data sections.". While OVMF
>> >> > based firmware doesn't seem to care much about what's there, it sounds like
>> >> > including .sbat in the calculation is more correct.
>> >> >
>> >> > Fixes: 0f9a1739dd0e ("efi: zboot specific mechanism for embedding SBAT section")
>> >> > Reported-by: Heinrich Schuchardt <heinrich.schuchardt@gmx.de>
>> >> > Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>> >> > ---
>> >> >  drivers/firmware/efi/libstub/zboot-header.S | 2 +-
>> >> >  drivers/firmware/efi/libstub/zboot.lds      | 6 ++++--
>> >> >  2 files changed, 5 insertions(+), 3 deletions(-)
>> >> >
>> >>
>> >> Thanks for the fix.
>> >>
>> >> > diff --git a/drivers/firmware/efi/libstub/zboot-header.S b/drivers/firmware/efi/libstub/zboot-header.S
>> >> > index b6431edd0fc9..65df5f52e138 100644
>> >> > --- a/drivers/firmware/efi/libstub/zboot-header.S
>> >> > +++ b/drivers/firmware/efi/libstub/zboot-header.S
>> >> > @@ -41,7 +41,7 @@ __efistub_efi_zboot_header:
>> >> >         .short          .Lpe_opt_magic
>> >> >         .byte           0, 0
>> >> >         .long           _etext - .Lefi_header_end
>> >> > -       .long           __data_size
>> >> > +       .long           __all_data_size
>> >>
>> >> Frankly, I'm not sure if this is even worth the hassle.
>> >>
>> >> There is also a 'size of uninitialized data' field, but given that the
>> >> .data section has both initialized data and uninitialized data, and
>> >> the fact that no loaders appear to care about these fields, let's just
>> >> not bother.
>> >>
>> >
>> > ... or add .sbat to SizeOfCode instead. (the preceding field)
>> >
>>
>> I was wondering how to make it consistent with yet-unmerged x86
>> patch. In v3:
>> https://lore.kernel.org/linux-efi/20250603091951.57775-1-vkuznets@redhat.com/
>> .sbat was accounted as SizeOfCode but the section is
>> "IMAGE_SCN_CNT_INITIALIZED_DATA", not "IMAGE_SCN_CNT_CODE" so I sent v4
>> yesterday:
>> https://lore.kernel.org/linux-efi/20250619151759.355893-1-vkuznets@redhat.com/
>> which made .sbat accounted in SizeOfInitializedData.
>>
>
> I agree that making it consistent is preferred, but I really don't see
> the point of obsessing over this - the field is basically unused in
> practice.
>

OK, let me then just do v2 of this patch with '__all_data_size' magic
dropped.

-- 
Vitaly


