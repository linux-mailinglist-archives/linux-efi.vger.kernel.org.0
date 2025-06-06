Return-Path: <linux-efi+bounces-3821-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04A0BAD0640
	for <lists+linux-efi@lfdr.de>; Fri,  6 Jun 2025 17:56:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EA1D3AB3B0
	for <lists+linux-efi@lfdr.de>; Fri,  6 Jun 2025 15:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A5C928937E;
	Fri,  6 Jun 2025 15:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X57Dy0Ic"
X-Original-To: linux-efi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4876719882B
	for <linux-efi@vger.kernel.org>; Fri,  6 Jun 2025 15:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749225356; cv=none; b=gIXFYVYd33Hvbif8HuaJYslfwB6LaJ8damPKQX3Jb30Md+1ZyAMpaCRlN/hu6mgsweUJ/Sh0+vXNMIleW9ubX4tol7hV/udMSxbzfgP4DcVNoYLzLf+bmvYIkVjg8CLxYUWoFhas5F88cyR5chiEmbb2OOLFJ5NOTsFjtVpSSWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749225356; c=relaxed/simple;
	bh=jc0tWlW3poGCs9I7QlcyCKaGlhaRWGW9bX1l7hil6K4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fPWuTDE9iejwhbZ8cFR4bOn1qwoKO0Wn6BCh7t/WWK+5cbli3dAYmggbs89pdrEGq7sZDm+WYugZDGENX4fT8sWlfvWUM/Kiklszbsr6rysReD/vwlWTa4YL/Hz6ZSxk4Sl+Vqyahl2sbe4ASlfZP5+i8OxdKmUFg+uCq32cfHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X57Dy0Ic; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749225354;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hfQokHHUXGOQjxz/5AuJ61NClHmro/6qokU3ot4Jqhk=;
	b=X57Dy0IcP71sVZYxBO5S/2gjWt/V3z2GXSTAy1geUkIrc7lxtZHo7EGtfvNFsCN3CF9iRb
	BI3T0wiZVYBGXmJWD3XyvnEnXhn5PzWJ/7Jt93nG92LhQscUfwrP28if6/249lNBKi0Y1i
	ztEVA2i4NLkPDMy7KEoDw+q9y33VshI=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-149-1fkq1hDnPfqDc_7QlM3XFg-1; Fri, 06 Jun 2025 11:55:53 -0400
X-MC-Unique: 1fkq1hDnPfqDc_7QlM3XFg-1
X-Mimecast-MFC-AGG-ID: 1fkq1hDnPfqDc_7QlM3XFg_1749225353
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4a461632999so40321131cf.1
        for <linux-efi@vger.kernel.org>; Fri, 06 Jun 2025 08:55:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749225352; x=1749830152;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hfQokHHUXGOQjxz/5AuJ61NClHmro/6qokU3ot4Jqhk=;
        b=HAc6IwPnXgZ+9tMbhCIzDxO4GLCx5HGlsP/09/WKy9lgmZ+PUq9zY/NLp+6mojMqg4
         ZQ0bYyaKCOWFECZige1Nq0xoHyXhHxhS3z4jnpOoDjz4aS/XgMHVcDBoBCFlg0mxDG4Z
         JnWJ7CFmNHNl5xbXo3s3ElTmK7dG1OSDWYahmKURmnQ40QC2XE53J4Aq+tD4moNMku/q
         4moVDdXj2nswrcsVY0OFlBn20vr7XHjTNcewQ/gwvvSdBUl6YfjcykZxXTTYIOu2LLHR
         fN5AWiC7OeBtPsA1jRS0+x10pbjZzveJSDNmWBZ0iEWfxThjq1zW5LBCHnRW+71EWWNM
         3UHQ==
X-Gm-Message-State: AOJu0YyYLUGHviaCaqZpqVWCzor10lvSqfyQohXRjhKUQpkPc8aiIxyW
	lLH5Ue0EeJE++jRFZ+shFgrQV0s2rKQr0PoY0Krt+lWFtmVLc+JTfzDzweEvqK4YvzUzZxpklwx
	ahEQMOHVane+erkxRrAtzxJrsvHRyyZliTs7te4xoRDPD3CF1mbN3dfc/FSZVoA==
X-Gm-Gg: ASbGncudWwE5UU6SBNEdwl6IOLDJTignogPBNSonLEt0Y2FJC7hAU9CslBzx0QYe337
	kRrqm5QLsA9A1LNZ6DZGzKsp5QrxyxSg4277AxC61qFsYO7mvbL31uF+QqVI1jtMQB7XPvWT0Ap
	Sq+vdpMr3Erzto4sC+zaHn/bG8g6U/08oro8SxZdvmHpzMdgWSErZwvjQ+jOqZ4wCchCoGPMTbP
	rPlbcrxVhiYNgiAGLg8amJtdnPF9vrkCDFO0kopQuag6tYM4eeUqIlFu2Crxs3c1pwot/Ff9lLE
	f28Ojm2LlHiCkps=
X-Received: by 2002:a05:622a:90e:b0:494:b251:d216 with SMTP id d75a77b69052e-4a5b9a29356mr73621481cf.18.1749225352611;
        Fri, 06 Jun 2025 08:55:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEuOyO5kabPQZM7spveJfj/HNOoyNh+ZrupHbDyKgLpVySZrx0OECv0h4zkDFJ84/rW+XA9DQ==
X-Received: by 2002:a05:622a:90e:b0:494:b251:d216 with SMTP id d75a77b69052e-4a5b9a29356mr73621001cf.18.1749225352261;
        Fri, 06 Jun 2025 08:55:52 -0700 (PDT)
Received: from [192.168.2.110] ([69.159.169.234])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fb09ab948dsm12887176d6.11.2025.06.06.08.55.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Jun 2025 08:55:52 -0700 (PDT)
Message-ID: <256ad7fc-c6d4-470d-a434-7b5556c3b8f6@redhat.com>
Date: Fri, 6 Jun 2025 11:55:41 -0400
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] efi: Drop preprocessor directives from zboot.lds
To: Vitaly Kuznetsov <vkuznets@redhat.com>, Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250606154112.311565-1-vkuznets@redhat.com>
Content-Language: en-US, en-CA
From: Luiz Capitulino <luizcap@redhat.com>
In-Reply-To: <20250606154112.311565-1-vkuznets@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-06-06 11:41, Vitaly Kuznetsov wrote:
> Older versions of `ld` don't seem to support preprocessor directives in
> linker scripts, e.g. on RHEL9's ld-2.35.2-63.el9 the build fails with:
> 
>   ld:./drivers/firmware/efi/libstub/zboot.lds:32: ignoring invalid character `#' in expression
>   ld:./drivers/firmware/efi/libstub/zboot.lds:33: syntax error
> 
> We don't seem to need these '#ifdef', no empty .sbat section is created
> when CONFIG_EFI_SBAT_FILE="":
> 
>   # objdump -h arch/arm64/boot/vmlinuz.efi
> 
>   arch/arm64/boot/vmlinuz.efi:     file format pei-aarch64-little
> 
>   Sections:
>   Idx Name          Size      VMA               LMA               File off  Algn
>     0 .text         00b94000  0000000000001000  0000000000001000  00001000  2**2
>                     CONTENTS, ALLOC, LOAD, READONLY, CODE
>     1 .data         00000200  0000000000b95000  0000000000b95000  00b95000  2**2
>                     CONTENTS, ALLOC, LOAD, DATA
> 
> Fixes: 0f9a1739dd0e ("efi: zboot specific mechanism for embedding SBAT section")
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>

Thanks for fixing Vitaly:

Tested-by: Luiz Capitulino <luizcap@redhat.com>

(this is for the build test, not SBAT testing).

> ---
> Note: not-yet-merged x86 version of 0f9a1739dd0e does not seem to be affected
> as vmlinux.lds script is a pre-processed version of vmlinux.lds.S.
> ---
>   drivers/firmware/efi/libstub/zboot.lds | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/firmware/efi/libstub/zboot.lds b/drivers/firmware/efi/libstub/zboot.lds
> index c3a166675450..4b8d5cd3dfa2 100644
> --- a/drivers/firmware/efi/libstub/zboot.lds
> +++ b/drivers/firmware/efi/libstub/zboot.lds
> @@ -29,14 +29,12 @@ SECTIONS
>   		. = _etext;
>   	}
>   
> -#ifdef CONFIG_EFI_SBAT
>           .sbat : ALIGN(4096) {
>   		_sbat = .;
>   		*(.sbat)
>   		_esbat = ALIGN(4096);
>   		. = _esbat;
>   	}
> -#endif
>   
>   	.data : ALIGN(4096) {
>   		_data = .;


