Return-Path: <linux-efi+bounces-747-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D82338737AF
	for <lists+linux-efi@lfdr.de>; Wed,  6 Mar 2024 14:27:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8ECA41F219A9
	for <lists+linux-efi@lfdr.de>; Wed,  6 Mar 2024 13:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0538C130AFC;
	Wed,  6 Mar 2024 13:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Vpiapz6t"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF8512F5B8
	for <linux-efi@vger.kernel.org>; Wed,  6 Mar 2024 13:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709731624; cv=none; b=WE5nhMAbFi5KrwCaA5I8DuCTyOkEdfZA+qnxJZoSuTMTkuFv+T8MNLZ3zxKnTMxEmGD6qGQiQDxguU7R+B1mJCC3/HnIvJtAQw8KvSIYiewOw3ArZWhPil76U0thtxXiZ8s2EU/lgpWnY/+GL2p7qV8iCmel6V117D+AE/wrcyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709731624; c=relaxed/simple;
	bh=yTTBKW3S6AHHJkeUW4yDspV4mq5EkRrqCQYaROMKfSE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nb6fw/la1kkyNX/PRB4ftwE4K5xaNf5q5z43kl6FpT28ARERRHGcWxCKGD8VnJuJKvG7cz2KmqNoxb4PmdZabqF5TFSwHBzquGx+X4k5hD75amTRyHA4/NQY5NOtlhaPn5+KwjztydFZnsyJo6qAK/1wxurR1NbwAwC4xneN92s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Vpiapz6t; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-21f5ab945e9so376889fac.0
        for <linux-efi@vger.kernel.org>; Wed, 06 Mar 2024 05:27:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1709731622; x=1710336422; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yTTBKW3S6AHHJkeUW4yDspV4mq5EkRrqCQYaROMKfSE=;
        b=Vpiapz6tjyBQuANvuGmUQHwuM4GBzIACcMiyWAJay7mJaxVD49e/TmNkVY8LCePry1
         uIOB0KsvUP5BVdt0XL3RxHd1AfCWCeL7aM35tiX92u/dfA5V4tmSknMuJyt5YTX3OtvM
         sqvqgMKsG3m7X/tU5+azTbnOlWl1ZsaOiUfLJn3X8QAaa1BzGB/TN5vwb4prl2YLRrmV
         MU0qd6ciLee17t1HtcLKrTMRL0jfKcikaT/nhqYDMxNYJro2fsSexZb/5fVMziCGasJ1
         aYdrt6orCqMBTqkmOvnjG6cry/W6ROuSC+GmRioRJqSC/a2E7N+sxmt10jbA+Zb7xj1U
         7gpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709731622; x=1710336422;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yTTBKW3S6AHHJkeUW4yDspV4mq5EkRrqCQYaROMKfSE=;
        b=OHUxMKcLWOw/8p/I431ykYFS+f3lZv8uBzjZhiekGbSBkT09AwcdFKUxGlVhY/ilmx
         J5N2c3OBR3F6MdiB1IIani96BuuZW56QzigNuIHRqU/oXznyITMKMVypSHIyupnLm1jr
         MLHSRILmINw09NXhQ56A4zqJBCZ/fZGeKcNAsOglgUIWy3Ex9/F9MjHkyB2/YKsNWu3q
         q/ZQ2Xgr+ZiEeS31m2Bd32Z/ecjWZEFYEJ4pGNnv274SW6SwRWJhEAaB3nyTgBCfFRaL
         1g9eAjFRS7yoQMDFtmkLGSksZ/2EKn8iJzhiPLzYDmUcitNTa2hJjgYZX7QuaCnVwwZC
         /GcA==
X-Forwarded-Encrypted: i=1; AJvYcCUy/DY/uxlfFdVWFfv2AmlYLiFE2jKcZ/5XF2vUz1oeZ1TvWh/r/5qJNFQZKdr5GjBeopDhRrTYdotWEL7Qi8U+DyOkkx+z1cSX
X-Gm-Message-State: AOJu0YxOpq6DToUkysADsLDvR5ujwxnZWVtg/+7b8BrMlHvUU6wi4nuk
	5aOP5EdXrhFiricN7pHrcXr1Lc2B3AFGOYn13fXY/OJwWoqJKn8c3y0zrM4dfAxFqFa6+wmYCSe
	rScX0/oJcBv7JNpuo/Gu6tsPZcww4TGq2Xj5vEw==
X-Google-Smtp-Source: AGHT+IHWNAYEUCXy96aSwRX05SXOrysd9FPb6KniNdKBWJshN+yQQ5ObTNFsHu55muUNwwV/8GXLjM+VKV3S+C0C+00=
X-Received: by 2002:a05:6871:4188:b0:221:4140:2f33 with SMTP id
 lc8-20020a056871418800b0022141402f33mr44063oab.8.1709731621937; Wed, 06 Mar
 2024 05:27:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240306085622.87248-1-cuiyunhui@bytedance.com>
 <26f3e99c-8f57-4779-a679-2085e469d9cd@siemens.com> <CAEEQ3wnDKdhCH4yz+MY+Xks21jLnuFiyx-xxa7CFczokG2shvQ@mail.gmail.com>
 <CAMj1kXFxzFRQz0BUVw27xdOj+xAVtX9jPjwaLHsEOYDUSqXMOw@mail.gmail.com>
In-Reply-To: <CAMj1kXFxzFRQz0BUVw27xdOj+xAVtX9jPjwaLHsEOYDUSqXMOw@mail.gmail.com>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Wed, 6 Mar 2024 21:26:50 +0800
Message-ID: <CAEEQ3wnvTN5nGWAibjKKdMe4P3j3wPgghKn2HbOF1Xg56G=0kQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH 1/3] Revert "riscv/efistub: Ensure
 GP-relative addressing is not used"
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, xuzhipeng.1973@bytedance.com, alexghiti@rivosinc.com, 
	samitolvanen@google.com, bp@alien8.de, xiao.w.wang@intel.com, 
	kirill.shutemov@linux.intel.com, nathan@kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ard,

On Wed, Mar 6, 2024 at 9:11=E2=80=AFPM Ard Biesheuvel <ardb@kernel.org> wro=
te:
>
> On Wed, 6 Mar 2024 at 14:08, yunhui cui <cuiyunhui@bytedance.com> wrote:
> >
> > Hi Jan,
> >
> > On Wed, Mar 6, 2024 at 8:52=E2=80=AFPM Jan Kiszka <jan.kiszka@siemens.c=
om> wrote:
> > >
> > > On 06.03.24 09:56, Yunhui Cui wrote:
> > > > This reverts commit afb2a4fb84555ef9e61061f6ea63ed7087b295d5.
> > > >
> > >
> > > This comes without a reason - which is likely something around "will =
fix
> > > this properly later". But then you regress first and only fix
> > > afterwards. Can't that be done the other way around?
> >
> > Sorry, I don't quite understand what you mean. Can you help explain it
> > more clearly? Do you mean "delete mno-relax instead of revert
> > directly?"
> >
>
> You should order your patches in a way that does not create
> intermediate states (between 1-2 or between 2-3) where the original
> problem is being recreated.
>
> So in this case, you should
> a) fix the issue
> b) revert the existing patches in *opposite* order
Simply, I plan to remove "-mno-relax" and
"\|R_RISCV_$(BITS)\|R_RISCV_RELAX" in the third patch (fix patch).


> However, I don't think the EFI stub can use GP - please refer to my other=
 reply.
The problem we encountered is that gcc 13 will optimize efistub using gp.

Thanks,
Yunhui

