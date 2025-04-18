Return-Path: <linux-efi+bounces-3373-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 446BCA93A1C
	for <lists+linux-efi@lfdr.de>; Fri, 18 Apr 2025 17:51:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69F4646326E
	for <lists+linux-efi@lfdr.de>; Fri, 18 Apr 2025 15:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C388815624B;
	Fri, 18 Apr 2025 15:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XkZvx5il"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165A021421B;
	Fri, 18 Apr 2025 15:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744991509; cv=none; b=O6EpiEWbFSxxHoJkFnKqBomdAstKoaGWT7dq0GSwBv8h1Vuo/TXVF7sUKKA7oaYpsHfqhHAE19Aq/woUf4NBGinvZBDuPvCx/Ik41N7sx7Og9JVQPFXwKBSO0IiH7Ulgp5uZ//Q3NeCVE/7vRe9nqR9do1fR7FnFl4Kf0/cG+Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744991509; c=relaxed/simple;
	bh=cqXeoXxdKHlzXm5KRH6bzyrFRQirim/fG3uP1zRbNJA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=omMvfNu0/DZDR49pb87f0jADxQ93qFaxHXhepwNSECifOw/oYVBXXq7YCwniPdkakUIm9m1Zmq86/+b0lpEPcVoSAXMOXLYnAS0vRc4cBhWt/MtQJ2Y+26vgu63LEccUgfS+46IT5dNWiZcjzF/ag41DhtIla6wln+Nm65bhYvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XkZvx5il; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43d0c18e84eso10110415e9.3;
        Fri, 18 Apr 2025 08:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744991506; x=1745596306; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uby8dYEjftGQVrQ9N7xoW1qMDSsyeQ3m/Bq/ZJ47gsE=;
        b=XkZvx5il+DZLiAUadKxNJDfBFJeran7/X7Z7LSo3P6Crlyba1vHCZfM4RKwxV9nt3G
         V5UBOoObMB0ntv6gbrxAiqi3x21/mvnIw0t+u8snMMwdxjwsXfZBkdOj/2+ywPHumnji
         qvh4ELWLaIOTi9RvKlDd465j05hIPxczXUqJDlrmUmdBwuHO002C4bLbbFxYUnLXgc/L
         I3D/DSNUhyWKunblNmvZiuxpMcIkAqsVQ4zvEHCbikpZzFP0s2X1qpTrnnrt95OQTWxm
         KCAaC3NuVQ8UfhkpVhOj+X8fF8/z2DQUEUNR8BDtQuUxNoo04BY9SW7sE4H3xp/adVD9
         vAng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744991506; x=1745596306;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uby8dYEjftGQVrQ9N7xoW1qMDSsyeQ3m/Bq/ZJ47gsE=;
        b=UCvf0ue4UzZXQl6OXrG/Ad030vonT2zFLMjsqVjb91WrzFlwY4E1ePVEw3TZUIWiFK
         p6ipy/MeQvjnnosI8gVKlos/yal+FQMxVNCNQYthPdRXyH2bU43qLn3J/ZhKQZKS/VH4
         FCgEfT+2F8g6SZKrrfr3Nq7B8qDPvGA+dR+kiEsQSJvPse9QBceNkI4DSz2JvQjeIpl8
         ETYo7zGbYtFo9tiHYuwTge4Vh3emk/Xq6uy+RteQdSN/twuAyVkORdZ3VPkRDolY49IY
         4RZC2j2tnd5/O0f69vATu6sLtWoDo6jc95zQI5N5fZ2C7hCzTAqB5IPYzZ0CLjc+dekM
         PXYw==
X-Forwarded-Encrypted: i=1; AJvYcCWNNdAzm1tItleTS+XAfrr4HxIkmNBoYBJQ1R41FlXTDV8nmv6oPyNe0ftm+RK1paHbMxlOjTUkrSCUhYI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy14ORjrcqrFHC0Up8nx+nes4j2U5/pnVDWKJEw4ciTROjbkrxh
	jIx3NDATeO/jXi25MLxHIYide1U3OtSNqyZqr1pPuqweTMPPA8zQ
X-Gm-Gg: ASbGncv8tjSE65t3r8sonSHz77sZ8rKxEgOImgSegefcyp6vNC0SeAu5hLZp940mldG
	whvdsd69oyCqTxUQGUbzIeVB0LW+AvdmGTWgpbxOb6imp/1TMpDg+85IdlosFOD2onE+bV2+Vr6
	0iosYdbFceA4yi7FOIiu5T+AiLi/M9iTXTxdvAigNrx3JQ+whIdhp6vZukp2BScPgqsXcrG6235
	ObAEfjHuYnFtJkJ6yMNjHXEFkoWYj58h9gSNbLmW3zHAxpLLTv6CI24IFFrdiczZ0jgL+UomrJy
	l7/b6EaDzhx1cydhXpuuIDNq5yoYagTRJGzzPOhAMQ==
X-Google-Smtp-Source: AGHT+IGoQmAGgaUPCLXmLHrLdxEIZESIjULcu4j9tEwuSI+K0DDACtI2e0Qc2hagxcAoua4EodrFUg==
X-Received: by 2002:a05:600c:1548:b0:43d:300f:fa3d with SMTP id 5b1f17b1804b1-4406ab7f661mr26426925e9.5.1744991506069;
        Fri, 18 Apr 2025 08:51:46 -0700 (PDT)
Received: from [192.168.1.100] ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4406d5acc5dsm27159695e9.9.2025.04.18.08.51.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Apr 2025 08:51:45 -0700 (PDT)
Message-ID: <f465a1b3-c28b-7bfe-7c18-e3fad41842aa@gmail.com>
Date: Fri, 18 Apr 2025 17:51:44 +0200
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v5 6/6] x86/asm: Retire RIP_REL_REF()
To: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org
Cc: linux-efi@vger.kernel.org, x86@kernel.org, mingo@kernel.org,
 Ard Biesheuvel <ardb@kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>,
 Dionna Amalie Glaze <dionnaglaze@google.com>,
 Kevin Loughlin <kevinloughlin@google.com>
References: <20250418141253.2601348-8-ardb+git@google.com>
 <20250418141253.2601348-14-ardb+git@google.com>
Content-Language: en-US
From: Uros Bizjak <ubizjak@gmail.com>
In-Reply-To: <20250418141253.2601348-14-ardb+git@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 18. 04. 25 16:13, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
> 
> Now that all users have been moved into startup/ where PIC codegen is
> used, RIP_REL_REF() is no longer needed. Remove it.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>   arch/x86/include/asm/asm.h | 5 -----
>   1 file changed, 5 deletions(-)
> 
> diff --git a/arch/x86/include/asm/asm.h b/arch/x86/include/asm/asm.h
> index a9f07799e337..eef0771512de 100644
> --- a/arch/x86/include/asm/asm.h
> +++ b/arch/x86/include/asm/asm.h
> @@ -120,11 +120,6 @@ static __always_inline __pure void *rip_rel_ptr(void *p)
>   
>   	return p;
>   }
> -#ifndef __pic__
> -#define RIP_REL_REF(var)	(*(typeof(&(var)))rip_rel_ptr(&(var)))
> -#else
> -#define RIP_REL_REF(var)	(var)
> -#endif
>   #endif

You can also remove rip_rel_ptr() with the whole "#ifndef __ASSEMBLER__" 
part.

Uros.

