Return-Path: <linux-efi+bounces-4315-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D98AB038C9
	for <lists+linux-efi@lfdr.de>; Mon, 14 Jul 2025 10:11:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8F483A6AEA
	for <lists+linux-efi@lfdr.de>; Mon, 14 Jul 2025 08:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1ADB23958A;
	Mon, 14 Jul 2025 08:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="dN4DmX0D"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B7D23956E
	for <linux-efi@vger.kernel.org>; Mon, 14 Jul 2025 08:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752480668; cv=none; b=iMmBAoHH6ah00NcaTLhdSDrDFZIUkSIgByqimPvLmbn6kYeyHxhlhlDpk/f0mdTgkZA4SZZ6HMrd1brcgVvZd2757PYCLTOGiVKfwvocWdLMmpYojMVg1lDrhN2MvrzWJIR2w+Hh6krKqpiVpc7Lh4acXoW4+k8XDF7Qn53B6fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752480668; c=relaxed/simple;
	bh=EwmAdiBY6IxdYC6thxEag7Sg4d0A23f83h0plUfjyMw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ni90c8b7wyfjR58YpP+mF16DqLst13PcE1POObhXtszbrge/DZ0wlek7Cz9m+9IrnhNJl22JvZgnvQRVYB6agPiGoOvU/FAOjyWmfZJ8QL3q3bsR7tgQhxHflzZCM4NyVUiN8w3s455mweNIVFK3oqraPvLJKMWoa1h0dJXdB40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=dN4DmX0D; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 5C6F33F674
	for <linux-efi@vger.kernel.org>; Mon, 14 Jul 2025 08:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1752480659;
	bh=nqw+Zq4IYXJ5LysW9CQUZGqMpjh9E9bB5LqggaTSXJc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=dN4DmX0DLUqKv1ro/VkcSZ9jYhJ4VpK4hCWo8mLw6Yq8lstvkdGZWF9rB/FkGpDuU
	 FJdfSeqKPPn8QpEgthzmHd41uHYNzPxUIU8uQMTYY60XglXSwhWVc2lPh6vnfByPIV
	 15oA/0Fhq1M6ikg/3OxqGcS+Ad1UBqnbJEWYRaHZMYgbH1y5SDfxnYr+2Ene5K01WT
	 bH6InG3dqPrvkN+k6MeDA5kfZaHtX23f0iM3d4EjYzfCzkFWoH7Y3QNcle5G6iu3//
	 rkxCBIig0HlKpyEmI/ovydri/zyYQLxzm9ZYDOKdSp1QUoZc32HMmFrwL7KPssGgAx
	 zThu4L+n/ySoA==
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-ae371f9e3f5so476720566b.1
        for <linux-efi@vger.kernel.org>; Mon, 14 Jul 2025 01:10:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752480659; x=1753085459;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nqw+Zq4IYXJ5LysW9CQUZGqMpjh9E9bB5LqggaTSXJc=;
        b=VAJGkXYcXv5upRotaigRjVd7XNvHF/MtYVNU7SJ5X2SuuC9t0za4ybAdzMd6cJs/D9
         trMcl9qW7Ep3xch3PTHFjElsi9op2K+UIUg7+1pKynsSYKjTBp14ZA1zhQyRLkpqlfcn
         SpK03HFqVO3YfWHnBmVF30rWAcXMZS/fcs35zm9f0JLyNFPc2W4rl4gBj39d8bF0wNU3
         dmp3hEhIz4he42H0jUAJ6v5QbKnUeTKl3910mb12XzdwhvEGpMpSFLjgoHRxCzd2cua+
         UwRihP+TDbQHR7tzRu389xGzYQF9hJ0Khw++jlST2qTVv7rF8CNrn8dQyfJ++Ho932vv
         uOHw==
X-Forwarded-Encrypted: i=1; AJvYcCVGsfs0yN01b8ZhRAXUDSHBGYlf/nOoPUonvVq9AWbBdQaz3Tb6Z6zr1n9fu5yIFFIItadn/gvGu1A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdsE3G+K1gxjCHERZBjHuiXsjP9F/ShhuLowbwD1ZrT2AWYYww
	xn6fBn+wwL5PwadOog6og8a7TrHVY/BWMVaBvgXNGcbKrjI1QcvKQiSThHeQkSL1SKnEUlrWoPT
	mP2fxMM6U3o6y8ZLPIgnhDHiXhxqhAydX9nB3sQHjJG5e4zO9xuuTEK37DwPmTJf7QWlSTs0bcK
	HFaw==
X-Gm-Gg: ASbGncvuY9Svnu+1afqV9i8F9P1eDIP7Dy0TzIuwsJtu8d8vEDbbc0vZsIpI/+Hd1i0
	wOIyVEDDxI7KcSplntzUeZbhjrrGlbrROtKl1giatssivSLlVoZY/eMr22tSvmlZMEgkRY+l3PD
	D9jgL11KBhsxNr0rgQVHii2drLrdcheS6YWi9D90pLpeHSxYh/VMGhz75nkEYgWfS0vRNegXLfC
	LwD32DFO9n/rf6OZt0oQauAwBY7//XVdGutygnN2z0zZxjkTsgVIPOGAAxXgL/NEc74o0fkn43c
	PKRnzs2djC1u3OBGk0RFnchXp0Y9c4Wg9hcEK+VmfSRNVdocoSwz/KvhXw8CuUQ=
X-Received: by 2002:a17:907:9450:b0:ad8:adf3:7d6d with SMTP id a640c23a62f3a-ae6fb8a57eemr1155261666b.21.1752480658898;
        Mon, 14 Jul 2025 01:10:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEVNG4cGhbgl6DZuAszmrlgOEZ5D4CwRcSMPsKcvD43UnpSt6BkYsm9BCpJ8sMqD6XmPCotBg==
X-Received: by 2002:a17:907:9450:b0:ad8:adf3:7d6d with SMTP id a640c23a62f3a-ae6fb8a57eemr1155257866b.21.1752480658379;
        Mon, 14 Jul 2025 01:10:58 -0700 (PDT)
Received: from [10.27.73.177] ([212.144.242.210])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e7e90b09sm770592166b.25.2025.07.14.01.10.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jul 2025 01:10:57 -0700 (PDT)
Message-ID: <422e2a72-972f-41f4-a0b3-d69a6cb0c2e2@canonical.com>
Date: Mon, 14 Jul 2025 10:10:55 +0200
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/3] Remove unused EFI runtime APIs
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-arm-kernel@lists.infradead.org, Ard Biesheuvel <ardb@kernel.org>,
 Feng Tang <feng.tang@linux.alibaba.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Juergen Gross <jgross@suse.com>, Stefano Stabellini
 <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Sunil V L <sunilvl@ventanamicro.com>, Bibo Mao <maobibo@loongson.cn>,
 linux-rtc@vger.kernel.org, linux-efi@vger.kernel.org,
 xen-devel@lists.xenproject.org, x86@kernel.org,
 linux-riscv@lists.infradead.org, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20250714060843.4029171-5-ardb+git@google.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20250714060843.4029171-5-ardb+git@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/14/25 08:08, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
> 
> Using EFI runtime services to program the RTC to wake up the system is
> supported in theory, but rarely works in practice. Fortunately, this
> functionality is rarely [if ever] used to begin with so we can just drop
> it. (Note that the EFI rtc driver is not used by x86, which programs the
> CMOS rtc directly)

The main problem I see with firmware offering access to the RTC via UEFI 
services is that two different drivers, the firmware one and the Linux 
one might be trying to access the same busses or registers which might 
lead to unexpected results.

Recently there was a discussion in the RISC-V technical group for the 
server platform specification where the same issue was discussed 
concerning SetTime().

As a UEFI firmware should not care which operating system is booted, it 
should be up to the OS to disable EFI access to the RTC if it has native 
access.

Could we disable all the EFI services for the RTC in Linux dynamically 
when an RTC driver is successfully probed?

Best regards

Heinrich

> 
> The same applies to GetNextHighMonoCount(), which, if implemented,
> usually relies on SetVariable() under the hood *, which is often not
> supported at runtime by non-x86 platforms. But it has no known users
> either so let's drop support for it as well.
> 
> This means we need to drop the slightly pointless tests for it too.
> 
> * EDK2 based EFI implementations usually have a MTC variable carrying
>    the monotonic counter variable, which is therefore not truly
>    monotonic, given that SetVariable() will happily overwrite it.
> 
> Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> Cc: Feng Tang <feng.tang@linux.alibaba.com>
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Cc: Juergen Gross <jgross@suse.com>
> Cc: Stefano Stabellini <sstabellini@kernel.org>
> Cc: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
> Cc: Sunil V L <sunilvl@ventanamicro.com>
> Cc: Bibo Mao <maobibo@loongson.cn>
> Cc: linux-rtc@vger.kernel.org
> Cc: linux-efi@vger.kernel.org
> Cc: xen-devel@lists.xenproject.org
> Cc: x86@kernel.org
> Cc: linux-riscv@lists.infradead.org
> Cc: loongarch@lists.linux.dev
> 
> Ard Biesheuvel (3):
>    efi-rtc: Remove wakeup functionality
>    efi/test: Don't bother pseudo-testing unused EFI services
>    efi: Remove support for pointless, unused EFI services
> 
>   arch/x86/platform/efi/efi_64.c          |  22 ----
>   drivers/firmware/efi/runtime-wrappers.c |  68 ------------
>   drivers/firmware/efi/test/efi_test.c    | 108 +-------------------
>   drivers/rtc/rtc-efi.c                   |  76 +-------------
>   drivers/xen/efi.c                       |  56 ----------
>   include/linux/efi.h                     |   6 --
>   6 files changed, 4 insertions(+), 332 deletions(-)
> 


