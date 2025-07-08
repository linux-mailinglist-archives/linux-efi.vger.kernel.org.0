Return-Path: <linux-efi+bounces-4178-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 984E6AFBF72
	for <lists+linux-efi@lfdr.de>; Tue,  8 Jul 2025 02:47:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBC30165E5D
	for <lists+linux-efi@lfdr.de>; Tue,  8 Jul 2025 00:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D12C3128819;
	Tue,  8 Jul 2025 00:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gDXxF6FV"
X-Original-To: linux-efi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CDD838FB9
	for <linux-efi@vger.kernel.org>; Tue,  8 Jul 2025 00:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751935620; cv=none; b=cZphc6YLAtQCMqRAFKun1PxuSP49WKepUdhGzvykRYYOZLP6Y5W3Eg0hRwZCkCQ0CrjQNS5/oaCcMThwF4b1/vtkP1AL+7f2K8RESu8nl5LlZt7Qj3T93Zk3wzXL35nBujAy1+nPkD3rZl82lARB0+mLYLIMHTiNMyiW19W6cBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751935620; c=relaxed/simple;
	bh=dynho3MjU+Lfg82gPV9A0pKf6UWGwgkxG/o6TH7zVkk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lw5kfRzkRqAA6x9E7JQqXeWNSgfYv9A8gtxMVOVoEfl59KVGkoXcrumD95L7sPKrXGpoETRwJfT5S1Q6MnPs/owod0lRfY8hnoBvawWWTnWQhpzk/PZa9JuI+RfhXXgqc7fvDF2oRo3PaqfIDq1dLqcJUvCJ77ItTkHEsc6cgOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gDXxF6FV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751935617;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kOBIRP+/LiXLTVoen5Vy3qBR5qXn49Dm5lfqM2y2250=;
	b=gDXxF6FV1SFkIO9XMowl3uYIqAOkCYrkmsU/Lfv65e5+ATGHY57IUDmxpo9Nvea+Sp/rI2
	KbmAxi5uNGBQbwEjocILzFMiOuqzONDQV7ZgbjDgXHCucXCUZVdcjnD1/rEShvUgmLE3dm
	56LwCO5PoiLr4jmKnWmDDfOHy+anEug=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-uM4Ig3hRPWqT95yCY9yE7A-1; Mon, 07 Jul 2025 20:46:56 -0400
X-MC-Unique: uM4Ig3hRPWqT95yCY9yE7A-1
X-Mimecast-MFC-AGG-ID: uM4Ig3hRPWqT95yCY9yE7A_1751935616
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4a7f2ca9536so142013541cf.2
        for <linux-efi@vger.kernel.org>; Mon, 07 Jul 2025 17:46:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751935615; x=1752540415;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kOBIRP+/LiXLTVoen5Vy3qBR5qXn49Dm5lfqM2y2250=;
        b=sxElUcZO1lAm8PXvnT1VuNFCWXhticw/Naes46eWiNqlG5D8CXVuosh4Th/G6hBcTO
         5LnPEqGqDetA5qXjihEYhNz0WUOaGeKuiqvy8jJQP+YVxW9no2TR5p/F0QIQjCuDRu66
         ibdZShB6N3doa1GMBXVhkOgyvctQnP/8cesRvyNgyz9IBhFfF9X480HCayG1SMjb7UMM
         env0qi2aCxHJchB7P13TOdbQzxMCY+RTahxY+9aDlrcNdJ/J5CTWD1bgHmAWPTu24W+A
         TVV0+Hz+ZuxNXQxpjET51c17MaTI0AO6jMVGMygyZv7RS5mBryyMGpteCN48tNneZym1
         34cw==
X-Forwarded-Encrypted: i=1; AJvYcCWEQdpUwvwloVd7x1RpSlb6ZPzSxNkRCm9h1f817+heKCW3R4MIyfXW8d40mESi/nyHhEThdKcWRHg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCa2O4/OYcmI4W40+Mz2plRf6kEWBZreVrixuOMIgOaoWYOLfQ
	gjReoVVPLIZ42l22nRnieq9PsftfOCZthw8yk6RMLlcx4TMo5SD2aBuDg1j0YtdBVtKqeuB2Ag6
	cw7tmrqY/h2+Bv5o7YQJOxuBztj3gbvIYT7t1Wxu+FxNzrkIFFoxkyaPrNsCDNg==
X-Gm-Gg: ASbGncsXsqAGBtrM2BRx06NxV870dXmiYK/n0XqH6IDae5fkJ5ceU7VySQ1C1W+r6XW
	ux5Iug8u31XNV4igZ8FqGo3j/wkqgtExgMg55O1hCHRR9jtV4Zav4/J0UlbomEmOhMBPicGYap7
	EPNOBoLZrSK1mfXpdGfahamF0q9xH7JxIw9xkuR/jalnqLq1mkVjMvTJYzs4TXHh1Z2oPoJLLMU
	fETcSzfwrJkOoptyVFdrVUtSj6d+MP/4KMASjgWkHkbg76ujPGwZURKIOowYtaEFS/NfVL3X2q5
	ECBoRdii1hFSMo1GhNOKvP93
X-Received: by 2002:ac8:5981:0:b0:478:f4bd:8b8e with SMTP id d75a77b69052e-4a9cc7f08f3mr23997721cf.39.1751935615631;
        Mon, 07 Jul 2025 17:46:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJRi9lQ2OScTRkO8NGH0fJYlVeqWQWqEnwuhhe/9mrxR32FDBi0ML52Uqu++S9pNNpt6gs9g==
X-Received: by 2002:ac8:5981:0:b0:478:f4bd:8b8e with SMTP id d75a77b69052e-4a9cc7f08f3mr23997511cf.39.1751935615280;
        Mon, 07 Jul 2025 17:46:55 -0700 (PDT)
Received: from [192.168.2.110] ([69.156.206.24])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a994a0bfc5sm72400121cf.34.2025.07.07.17.46.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Jul 2025 17:46:55 -0700 (PDT)
Message-ID: <b9b407a5-d83a-4aa2-8cbc-15077f47c797@redhat.com>
Date: Mon, 7 Jul 2025 20:46:44 -0400
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] efi: Drop preprocessor directives from zboot.lds
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>, linux-efi@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250606154112.311565-1-vkuznets@redhat.com>
 <256ad7fc-c6d4-470d-a434-7b5556c3b8f6@redhat.com>
 <e1644469-77ca-4770-bc79-5243a46b8a9e@redhat.com>
 <CAMj1kXFg7wnfn=ipd86XNxeoXa=LtWviAgiVoTL1Y76q0yWA9g@mail.gmail.com>
Content-Language: en-US, en-CA
From: Luiz Capitulino <luizcap@redhat.com>
In-Reply-To: <CAMj1kXFg7wnfn=ipd86XNxeoXa=LtWviAgiVoTL1Y76q0yWA9g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-07-07 19:51, Ard Biesheuvel wrote:
> On Tue, 8 Jul 2025 at 07:36, Luiz Capitulino <luizcap@redhat.com> wrote:
>>
>> On 2025-06-06 11:55, Luiz Capitulino wrote:
>>> On 2025-06-06 11:41, Vitaly Kuznetsov wrote:
>>>> Older versions of `ld` don't seem to support preprocessor directives in
>>>> linker scripts, e.g. on RHEL9's ld-2.35.2-63.el9 the build fails with:
>>>>
>>>>    ld:./drivers/firmware/efi/libstub/zboot.lds:32: ignoring invalid character `#' in expression
>>>>    ld:./drivers/firmware/efi/libstub/zboot.lds:33: syntax error
>>>>
>>>> We don't seem to need these '#ifdef', no empty .sbat section is created
>>>> when CONFIG_EFI_SBAT_FILE="":
>>>>
>>>>    # objdump -h arch/arm64/boot/vmlinuz.efi
>>>>
>>>>    arch/arm64/boot/vmlinuz.efi:     file format pei-aarch64-little
>>>>
>>>>    Sections:
>>>>    Idx Name          Size      VMA               LMA               File off  Algn
>>>>      0 .text         00b94000  0000000000001000  0000000000001000  00001000  2**2
>>>>                      CONTENTS, ALLOC, LOAD, READONLY, CODE
>>>>      1 .data         00000200  0000000000b95000  0000000000b95000  00b95000  2**2
>>>>                      CONTENTS, ALLOC, LOAD, DATA
>>>>
>>>> Fixes: 0f9a1739dd0e ("efi: zboot specific mechanism for embedding SBAT section")
>>>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>>>
>>> Thanks for fixing Vitaly:
>>>
>>> Tested-by: Luiz Capitulino <luizcap@redhat.com>
>>>
>>> (this is for the build test, not SBAT testing).
>>
>> Vitaly, Ard,
>>
>> Are we planning to include this fix for 6.16? I'm afraid we'll introduce a
>> regression if we don't include it.
>>
> 
> Apologies, I let this sit for a bit longer than I intended. I'll send
> out the PR today.

Thanks a lot, Ard!


