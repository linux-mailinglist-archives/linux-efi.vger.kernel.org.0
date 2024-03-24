Return-Path: <linux-efi+bounces-869-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 61D8F887D3E
	for <lists+linux-efi@lfdr.de>; Sun, 24 Mar 2024 15:49:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC908B20DF2
	for <lists+linux-efi@lfdr.de>; Sun, 24 Mar 2024 14:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BEA6182DD;
	Sun, 24 Mar 2024 14:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JPDshrsW"
X-Original-To: linux-efi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D9C18035
	for <linux-efi@vger.kernel.org>; Sun, 24 Mar 2024 14:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711291771; cv=none; b=imWwf6OjW3dn3T8BWihXDYyPR6f7zZMDWNNz3AdqHYqp5DOCbNIk78eEiZneyzKTTcnMLxALEdlCPHCRBR3A4Gj9Ttt0WIeXHvIPuLEV2NwvQtZMlvJS0eRyy39YyjiDwTEDPW/poEzsPd5nKHt/NK2Vd1xshNgcrm68JFSTWZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711291771; c=relaxed/simple;
	bh=b0T2E6rfT+SfjZ3KicwpabA3ip4trl8wAgPlr1ugUpw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e12OuO+B9K8aW69O8SPBsOnzjaOfQoUkTueduaQIx/8v0anjSSvk9meNCiAord5aCXUYKd6QaLZsqOpWcXtQOu136SbWeAdX2d/4RXm5LYC10UIuJhzttWYEQjjqe1p/0qvKAqMuEAJVOKi7gKVX4tvo1n8aO+jPw69KhIPXu6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JPDshrsW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711291768;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bQeOWgDE8ZK/2VH8iK9oZfcBxftmpHefx2GklYdNKXY=;
	b=JPDshrsWr/wjE56u+saCfH8lbxgtCxBrs0Eimlm5xsal3Jd8jqqZvfGhpNSkdNMIv0aIRm
	4QaVQtKEFsOsRhEQNGR/q6K5NrfYE3tGF6imkM35vZ3zfqtkYbN0wjGIPnqJ1jhEhGzmUw
	v5IA00mnXEoAUMN9p18q4zdO4VwI/M8=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-qcAAuS0UMWCQBqKbvp2Fkg-1; Sun, 24 Mar 2024 10:49:27 -0400
X-MC-Unique: qcAAuS0UMWCQBqKbvp2Fkg-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a46ba1a19fdso266799766b.1
        for <linux-efi@vger.kernel.org>; Sun, 24 Mar 2024 07:49:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711291765; x=1711896565;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bQeOWgDE8ZK/2VH8iK9oZfcBxftmpHefx2GklYdNKXY=;
        b=SVVHlxa3LKwqa+vR+fsD/9Ltdzl9TEvhtZxsnbuqhmpcgRaUSeCn2/5/R5tuW5gdw1
         SbAmbSP4b7LXh2NSAkRuPDf7Km0CzuH8/KzSSG5IZKLubqRW60juHTLGqzsoKlm9z4NP
         iaPPNDrI3z4lHgiZeMEh6ytyKIAKZPMId2VadepaMJGxPHEyWNACDADTnOupU5HpjGEN
         XEtOiZ/MFWVOil/8syzsTWDEafYjV5H+DcN9KJhjnEqlc2NMtXs1a9Ef0ghcM+D2M4Ty
         r127L8pE1GHauMZpuFZGkqb1pmNm6rQm6VjCbB+3/ZseJEPCua2xp0vCrZBFP8MW0Uk+
         Cc0Q==
X-Forwarded-Encrypted: i=1; AJvYcCW2yeroWQV/wkVGhaeJHv09Y8PJWIdrHS1J2CR2gFr0Cf+8kXJ6uikr4XOxT1ztPJOPiLottQj7qXAn7UpLuNoNHNX0WBT0NDLs
X-Gm-Message-State: AOJu0YwNLP+pdhPO7GKciAnV8M6nv09Cqeh/yXS8VAUk8h1wFk7KaC9S
	8bDxFetaK39oeiIOmO6/rNA38HTU9rtVqwYv/6A+7uUaCXVxhEbdG2WXyTB3A4MaaHMcMK4JUY6
	PXX0aLjwSWr1nyKpeYWElV7ageluq292ydYKpOaiUmgRFTLjhFWs7IvnS0Q==
X-Received: by 2002:a17:906:c111:b0:a47:4b76:6258 with SMTP id do17-20020a170906c11100b00a474b766258mr2091366ejc.25.1711291765643;
        Sun, 24 Mar 2024 07:49:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3AfZuVj/LH8PmM5oxAKwVmIGD0XD2zB7qT+98dJjuYKKW3sKq+XAUtMPDBs/qzFmH11boVA==
X-Received: by 2002:a17:906:c111:b0:a47:4b76:6258 with SMTP id do17-20020a170906c11100b00a474b766258mr2091360ejc.25.1711291765291;
        Sun, 24 Mar 2024 07:49:25 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id se16-20020a170906ce5000b00a468be342bfsm2036173ejb.136.2024.03.24.07.49.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Mar 2024 07:49:24 -0700 (PDT)
Message-ID: <a3aae375-5582-46e4-866b-6a81641998af@redhat.com>
Date: Sun, 24 Mar 2024 15:49:23 +0100
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: x86_64 32-bit EFI mixed mode boot broken
To: Ard Biesheuvel <ardb@kernel.org>, Clayton Craft <clayton@craftyguy.net>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 regressions@lists.linux.dev
References: <20240321150510.GI8211@craftyguy.net>
 <CAMj1kXGzH4TiwvSF3bZsJpuuWf04Ri_852fUMTdH8pLRaH3+Yg@mail.gmail.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAMj1kXGzH4TiwvSF3bZsJpuuWf04Ri_852fUMTdH8pLRaH3+Yg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 3/21/24 11:48 PM, Ard Biesheuvel wrote:
> (cc Hans)
> 
> On Thu, 21 Mar 2024 at 23:05, Clayton Craft <clayton@craftyguy.net> wrote:
>>
>> I've been chasing a problem with 32-bit EFI mixed mode booting on two different
>> (x86_64) Intel Bay Trail platforms, where the system reboots or hangs seemingly
>> very early somewhere before or after loading the kernel. I've not been able to
>> get any output from the kernel or stub over efifb when the issue happens[0], and
>> do not have serial console access on these systems.
>>
>> v6.8 fails for me, and presumably so does everything back to v6.2. v6.1 is able
>> to boot OK on these platforms with mixed mode, and it looks like there are a lot
>> of changes from 6.1..6.2 for EFI/mixed mode booting.
> 
> v6.1 just received some EFI related backports, so please check the
> latest v6.1.y as well.
> 
>> I did managed to bisect the
>> issue to:
>>
>>         commit e2ab9eab324cdf240de89741e4a1aa79919f0196
>>         Author: Ard Biesheuvel <ardb@kernel.org>
>>         Date:   Tue Nov 22 17:10:02 2022 +0100
>>
>>             x86/boot/compressed: Move 32-bit entrypoint code into .text section
>>
>> However I'm not sure how to proceed from here, or if my bisect is all that
>> useful since the commit seems to be in the middle of a bunch of changes I do not
>> understand. I've been using systemd-boot to test this (both the full bootloader
>> and UKI w/ the sd-boot stub). Is 32-bit mixed mode on x86_64 working for others?
>>
> 
> I usually test on 32-bit OVMF built with LOAD_X64_ON_IA32_ENABLE,
> which allows the use of the compat entry point. This is different from
> the EFI handover protocol, and I am not sure which one you are using.
> 
> I have never had any reports, or noticed any issues myself. Last time
> I tried (some weeks ago) it was working for me.
> CC'ing Hans who may have more data points.

I've been offline for most of the week and I see that in the mean time
you seem to have found a fix, great.

FWIW I have been booting everything up to 6.8.0 on my own mixed-mode
Bay Trail tablets without issues, so the problem seems to be specific to
certain BIOS-es.

Please Cc me on the final fix, then I can test that early and double check
that things don't regress on other mixed-mode Bay Trail devices.

Regards,

Hans





