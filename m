Return-Path: <linux-efi+bounces-744-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 477B587375C
	for <lists+linux-efi@lfdr.de>; Wed,  6 Mar 2024 14:08:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 021A52840A6
	for <lists+linux-efi@lfdr.de>; Wed,  6 Mar 2024 13:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A05512FB0F;
	Wed,  6 Mar 2024 13:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="fbQCBMgz"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC31126F1C
	for <linux-efi@vger.kernel.org>; Wed,  6 Mar 2024 13:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709730484; cv=none; b=NzBKEa/kpmxwurOEepjUByON278Izj2q5e9hRIq6FyHOBlx5R7wv9HQ18bpC5d6W0xUdPrDdY+sB3FI8Kn+PAYLP35jak0MTldHyxZZISXCQdYNSg0HDQvjZgmCoODPwy0ugBlkE2xqFwKqNtU7b32DQQxSuCxVsaHlx05gkktw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709730484; c=relaxed/simple;
	bh=8grmpMo6kXaCL1FNx9R2bfmPydXiA0rq201Ykmbj6XM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AibQZ9yixYXmZV8wVfFf3aeS+4VJJrHCTpCO00JbWqtolOmLB559WfISICedN3BeYbLuSvM7COjU78nL9DrRRundxhoJsezd8kWajj/ICblm0f5HbAquICUmYNwDWyDY73j2+gCMTJGX4uKqMFYIydXnkB/3G6eDy7OZ2pCTTEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=fbQCBMgz; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5a11f42324dso2023803eaf.2
        for <linux-efi@vger.kernel.org>; Wed, 06 Mar 2024 05:08:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1709730481; x=1710335281; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8grmpMo6kXaCL1FNx9R2bfmPydXiA0rq201Ykmbj6XM=;
        b=fbQCBMgzk+KAhLBzDal/E+VtkZn2t0bkvgJ74igvKt0UouOqhflnAMtCtEeTa4x44A
         BXigzOKFFi1nBu9+40pZxylv8/flfrBd76v2Qe9Zxr8vcUVsyMIhdgCL6Q/AnZz2Z0Ct
         96MrRmmx/PYoWzPlZVrBQcQGCK05aRL3weJaGvsBsGwC+iGNi/GvwoEWPpLqXvroCi06
         KjV28Edvht5eTJ4JRLrgNanDd0QtuhNNnbbxAIFECAPgQeUQ9cvl9TkAZ3MhVOrQ73Zd
         yuaFgEwF4U/YFs6r2P7De4tthxG8nal3Hfe0+KEPPG3ZdOzmX39uAot1Uc57MEUKI8D1
         CUlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709730481; x=1710335281;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8grmpMo6kXaCL1FNx9R2bfmPydXiA0rq201Ykmbj6XM=;
        b=nvEtq4KwIh1EwJOpmrArFUjqK9A7Ao8RLpNgtonnGJ51jWYDRemuz3rcI45FYdz6ij
         tS2PpuLCQIyurTGDapC69qks/YW/5vZU1xhvQsHV2Ls4jylUcaWyDAO9kXifHypc1B2W
         ZDK3dWTrH7giO+A0JKOvN944Y1J3p6Fw3I7NKx+I3/cf27KP6MQF/Dtug0C1cOywUzp5
         YDbeqn+OMziX0OyVfynY1g30Uy+Eov8JZ/xrNYDEiiL/7gfoJHNeEMTfQTFNCR0Aeufj
         10zmg7tGKg2R6VYGcNaLXJD2kJ0+7+MCy6rLteSiK3FmKJeP3Ytt6dPFiVV1oTnuf44Y
         ZBNQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2m9agCYXWfWv2RAL2DL01dtDhsffyHUuE9/S2rQyEh12uuajwppuh3sJ+z40Zr8FYP+RCwycaB5P9/GySdXIi2xkxWNyFYvIC
X-Gm-Message-State: AOJu0YzBFUwpasXm3TcTZ9QbAYDlqg8XWqN/to0vwR0CEXzfg+8awwY2
	DhN28HDUaujV5i2kGZ+YoRs1uu5MuZ0LoOOaeOf1YVp8T1Iny88Nuw/Be0Mb/iYTKXP3rUMZ2RN
	SjM2fx+/fJ6GmHL0ir0aOQi8kmSfufvMTT5bjFQ==
X-Google-Smtp-Source: AGHT+IHApjo0FyHz0+mTNfy8Jycj2LxiGFq4dH+7d3CKS9BmX1BulHze6m5Tp4NLWckeoTdAQ7+7m9r34TwCA9Uv4iY=
X-Received: by 2002:a05:6870:a99f:b0:220:88b7:5145 with SMTP id
 ep31-20020a056870a99f00b0022088b75145mr4894851oab.41.1709730481594; Wed, 06
 Mar 2024 05:08:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240306085622.87248-1-cuiyunhui@bytedance.com> <26f3e99c-8f57-4779-a679-2085e469d9cd@siemens.com>
In-Reply-To: <26f3e99c-8f57-4779-a679-2085e469d9cd@siemens.com>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Wed, 6 Mar 2024 21:07:50 +0800
Message-ID: <CAEEQ3wnDKdhCH4yz+MY+Xks21jLnuFiyx-xxa7CFczokG2shvQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH 1/3] Revert "riscv/efistub: Ensure
 GP-relative addressing is not used"
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	ardb@kernel.org, xuzhipeng.1973@bytedance.com, alexghiti@rivosinc.com, 
	samitolvanen@google.com, bp@alien8.de, xiao.w.wang@intel.com, 
	kirill.shutemov@linux.intel.com, nathan@kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jan,

On Wed, Mar 6, 2024 at 8:52=E2=80=AFPM Jan Kiszka <jan.kiszka@siemens.com> =
wrote:
>
> On 06.03.24 09:56, Yunhui Cui wrote:
> > This reverts commit afb2a4fb84555ef9e61061f6ea63ed7087b295d5.
> >
>
> This comes without a reason - which is likely something around "will fix
> this properly later". But then you regress first and only fix
> afterwards. Can't that be done the other way around?

Sorry, I don't quite understand what you mean. Can you help explain it
more clearly? Do you mean "delete mno-relax instead of revert
directly?"


Thanks,
Yunhui

