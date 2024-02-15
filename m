Return-Path: <linux-efi+bounces-573-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F13E8570BD
	for <lists+linux-efi@lfdr.de>; Thu, 15 Feb 2024 23:53:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8DDEB21217
	for <lists+linux-efi@lfdr.de>; Thu, 15 Feb 2024 22:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C87C1419A9;
	Thu, 15 Feb 2024 22:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XypwHuFk"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6914A13A86F;
	Thu, 15 Feb 2024 22:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708037617; cv=none; b=mZSghxkm/u89fewr2WPf3N6U13AZd94E0e6QieV2eeDRwIQUrrCqoqNwzUOrv0k21j3F16+I/LI3nmpWm0jUmnCUxJP4x0tt7M/z7S9et9dYLqB8ZDGDHX4I/DzqvnXYMpRaXBdRFH6P30vdb4IwTD0E4IbbdeZlvJF3AuyJ3ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708037617; c=relaxed/simple;
	bh=mVmdnH/gleyZRHJKTGo3Zk+ijax5waOA2VGEMQ90394=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gEMoqZW5Rxz5NWojIeAcuGEdu6op6wzYpYoxJ6WLgfB12YP8wFht7ax+BKCXPZBBD90NvuIbGvwNnZp8yBJbb9tyOdRqkuAxKlFZRRhWXA9rmboj/HdURlABEZWp1CmV7lgKHPQCCYmMVAmA/pTh/htL31ll3eQJSI+EZHOVWBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XypwHuFk; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-785d567fa26so4052585a.3;
        Thu, 15 Feb 2024 14:53:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708037615; x=1708642415; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3LGmj+4Ox8DNbnQHN45Al/A5FlWzwlLmvFimBSFQ88o=;
        b=XypwHuFklUBDb5CL0dq1L9R82ohwkj07ckWajdKVHyK6dVr7jL4bxPwRZD4i5876DO
         bLLQvkHAiQ7iDNk0cito2iTAnm5PqJ0s9PDQiDiv5a+BNUju1JzksHmgbyzPocCpxrGh
         soaA/XWZjOVvdHr7YBRzI+njQAxm/bS+F+CzCQaJiTEu5R8Cu2Wu/8fEAoJEpq3cTBXw
         DT5Haj/CUh9iGCKU5ySlsV7BfQRr+aYnX+bRGXSVl+Qv7bCKPipYaoENiYnQyrZfCdyN
         BEg1aCbrCtVGUgHIsJdO0Ek5CrU/Q8ahfcUNXZjaSZmFZsGR0mWSa0c2mpJ5LnhXonzX
         1i7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708037615; x=1708642415;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3LGmj+4Ox8DNbnQHN45Al/A5FlWzwlLmvFimBSFQ88o=;
        b=A/elrnEyhjSZpGGqYXSbZpcFKtv/3ZU/IOw8SfKdB1IBGQw89aG/SUxdPU8k0fbG6m
         FgBdyvJ0X27IlctWw59Pzo5fC+MdEY4EgogvG+hn0dDftRd/GOyzx4g+JYP8kyqoDhGo
         RWpDCy+EOw+Zzy5sQOF5VJUxqnqnDaAn1u/swMA98zPJBwswfJXx61kj4uM4BWy8q9U/
         hgWyFfZArJBtMKTBSNOtnoSiTp0W6tCjkBpcS5tbP4yNUewerxOsm+KKybWnhxo9iVHE
         fl9C5Zw5cZR7oK8hRPC0PC/6qrSSeE8t3F6/Oq/hbyBMqzrprLw8U8G4gQ7Noh4OV0ve
         WaWw==
X-Forwarded-Encrypted: i=1; AJvYcCVwRgTNepVl4MP2jM8QPQDSCOyU5lzlVxoiVXL7Qq+xRivv+6ZDk9K9cWqVY/wE52kVC/OCtocLP0WpCiFjbBmYZEDZ3l8YFY8dRziBnInj/ncp3hN0jOOlzftHFMUXwFn28/7RtLyQ
X-Gm-Message-State: AOJu0YwglgCZXZmQ+6ZdfD6XF0Se7pFQoJE6T+kuv8bCx1EoSVRaY6q+
	EQWAHOi9sXB1+cDSMmo96nexFKwkObl+ewT8EZaOR+fFSj1uLkB6
X-Google-Smtp-Source: AGHT+IHynkdzBL+6w805/MNC3X+1JCGgVdnQ1SYu5l7m8zh13dbhAhq1No1F0QgY2V54D9ytwVyRJQ==
X-Received: by 2002:a05:620a:491a:b0:787:2f14:553 with SMTP id vy26-20020a05620a491a00b007872f140553mr3219040qkn.18.1708037615202;
        Thu, 15 Feb 2024 14:53:35 -0800 (PST)
Received: from fauth1-smtp.messagingengine.com (fauth1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id oq27-20020a05620a611b00b007873ee07d53sm249933qkn.3.2024.02.15.14.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 14:53:34 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 0D90A1200064;
	Thu, 15 Feb 2024 17:53:34 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 15 Feb 2024 17:53:34 -0500
X-ME-Sender: <xms:7JXOZRgBZ6aQD34AAZvPjtJwHBOQ9VoQkcGtL2iZkmkI6i4KORBtig>
    <xme:7JXOZWAj7X6GdnatCF4Bia4OYKoupYbrdBjdZK5_3I53TraAimTwOkECjYRF8OtYl
    s-9EyJkn7TbmAGZNw>
X-ME-Received: <xmr:7JXOZRGooOx8ojHlMoguVQtDYJlAbzyIfnrMvmtmh7CdJC9k05nkfHt2Srs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddugddtgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveeiudff
    iedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsg
    hoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieeg
    qddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigi
    hmvgdrnhgrmhgv
X-ME-Proxy: <xmx:7JXOZWRB9gnKnXRCM5WtHIiiImXExo7DMhDEwZFxa3_8t_G_ybSbpw>
    <xmx:7JXOZexzDbm7mFeu7TXHxO6yq_nQalDfXQEphWnUPjqtNxEQGRumBQ>
    <xmx:7JXOZc7_VufFMtdKx38UmibPUU0UlaCv8cXoVx2ryKHTRt5uePXc2Q>
    <xmx:7pXOZVo1uyRzZmJzaTduCOd5hMSENvLpwAdrXNGikp-VoMmqzQe3Y07q6nU>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Feb 2024 17:53:32 -0500 (EST)
Date: Thu, 15 Feb 2024 14:53:28 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: linux-arm-kernel@lists.infradead.org
Cc: stable@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] efi: Add ACPI_MEMORY_NVS into the linear map
Message-ID: <Zc6V6GnSQ_q1OAFC@boqun-archlinux>
References: <20240215225116.3435953-1-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240215225116.3435953-1-boqun.feng@gmail.com>

(Cc the correct arm mailing list)

On Thu, Feb 15, 2024 at 02:51:06PM -0800, Boqun Feng wrote:
> Currently ACPI_MEMORY_NVS is omitted from the linear map, which causes
> a trouble with the following firmware memory region setup:
> 
> 	[..] efi:   0x0000dfd62000-0x0000dfd83fff [ACPI Reclaim|...]
> 	[..] efi:   0x0000dfd84000-0x0000dfd87fff [ACPI Mem NVS|...]
> 
> , on ARM64 with 64k page size, the whole 0x0000dfd80000-0x0000dfd8ffff
> range will be omitted from the the linear map due to 64k round-up. And
> a page fault happens when trying to access the ACPI_RECLAIM_MEMORY:
> 
> 	[...] Unable to handle kernel paging request at virtual address ffff0000dfd80000
> 
> To fix this, add ACPI_MEMORY_NVS into the linear map.
> 
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> Cc: stable@vger.kernel.org # 5.15+
> ---
> We hit this in an ARM64 Hyper-V VM when using 64k page size, although
> this issue may also be fixed if the efi memory regions are all 64k
> aligned, but I don't find this memory region setup is invalid per UEFI
> spec, also I don't find that spec disallows ACPI_MEMORY_NVS to be mapped
> in the OS linear map, but if there is any better way or I'm reading the
> spec incorrectly, please let me know.
> 
> It's Cced stable since 5.15 because that's when Hyper-V ARM64 support is
> added, and Hyper-V is the only one that hits the problem so far.
> 
>  drivers/firmware/efi/efi-init.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/firmware/efi/efi-init.c b/drivers/firmware/efi/efi-init.c
> index a00e07b853f2..9a1b9bc66d50 100644
> --- a/drivers/firmware/efi/efi-init.c
> +++ b/drivers/firmware/efi/efi-init.c
> @@ -139,6 +139,7 @@ static __init int is_usable_memory(efi_memory_desc_t *md)
>  	case EFI_LOADER_CODE:
>  	case EFI_LOADER_DATA:
>  	case EFI_ACPI_RECLAIM_MEMORY:
> +	case EFI_ACPI_MEMORY_NVS:
>  	case EFI_BOOT_SERVICES_CODE:
>  	case EFI_BOOT_SERVICES_DATA:
>  	case EFI_CONVENTIONAL_MEMORY:
> @@ -202,8 +203,12 @@ static __init void reserve_regions(void)
>  			if (!is_usable_memory(md))
>  				memblock_mark_nomap(paddr, size);
>  
> -			/* keep ACPI reclaim memory intact for kexec etc. */
> -			if (md->type == EFI_ACPI_RECLAIM_MEMORY)
> +			/*
> +			 * keep ACPI reclaim and NVS memory and intact for kexec
> +			 * etc.
> +			 */
> +			if (md->type == EFI_ACPI_RECLAIM_MEMORY ||
> +			    md->type == EFI_ACPI_MEMORY_NVS)
>  				memblock_reserve(paddr, size);
>  		}
>  	}
> -- 
> 2.43.0
> 

