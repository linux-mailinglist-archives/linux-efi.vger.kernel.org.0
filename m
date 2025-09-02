Return-Path: <linux-efi+bounces-4670-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26E23B405D5
	for <lists+linux-efi@lfdr.de>; Tue,  2 Sep 2025 15:59:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C9D8188DBA1
	for <lists+linux-efi@lfdr.de>; Tue,  2 Sep 2025 13:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC973126BA;
	Tue,  2 Sep 2025 13:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YPhObNZC"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB21311C35;
	Tue,  2 Sep 2025 13:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756821040; cv=none; b=QzKEawN3yElNDEQ10aE1WBskAHTjMKSqVvtcIVJ7TXBuphdRpYQaxdG7Ly6atcQBqbhTOs9Gvfnl9omRUkqcBEU71CAcaVdREKod+mOTMTqDjFp5NyFdyx1T/JSyn1Sv6c8AHAKvjI7oXnBUO+mDIRxEHJupgF9ONLJNwcDivRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756821040; c=relaxed/simple;
	bh=A8mVZBRFvno3FHXgtIN/V3J6sKUCG3joDIQtFDVz+lo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IzqmlDEpTCq3znm4uG2HgYSd7vQugvSOb6baYs0DF2QfMM1MfFmUamnmFuyXchGVlfM8j/Cln77ACwB7YCAVGevUhsSIKQrznYH4FLpR2oAQ+0vvPbjdHtMrgodcoc/hFXeaxDIKRfSLfQyu4WuEKQuVkbPL4C+Pr2F0zEDb2oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YPhObNZC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D822DC4CEED;
	Tue,  2 Sep 2025 13:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756821039;
	bh=A8mVZBRFvno3FHXgtIN/V3J6sKUCG3joDIQtFDVz+lo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=YPhObNZCJfGFYT8TF6zpgbeFoQDeoPRbRLtZJWF/kcAePJFWsD6o9GBOHYjEeoOTi
	 i15ZeDAI1nWLcOz3HYEj0LM435QsRx639rs8ngKXWlOCfZmKJ2Z9lGk5dm+xvj00x3
	 45QsK7L2C691MYJCCWNUJw+MNeXZBPznVia31lbY9OVrjrz/Y3QBb4byrIg4Xd6efe
	 Jtp6KudyttyZDlCw8siTKx2W3/hTT4G0l/3vxXla82EANZLP79Zf+xapWgEd19qasZ
	 S0DcMAZtiE3mBw+6BdPK1oZkgmQhGWww/UeHCB7b+bF+i/0mbxtaPADBiLyPrQJYfc
	 XbBVu8KAZIT9w==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-55f76277413so2758459e87.3;
        Tue, 02 Sep 2025 06:50:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVXe92mEeXDs3bgH7HJunYym4v7PkQDL9YdwYEXJ3wg1a2XDhQ1QJvd0jNpWaotdoD6egIp7ZT67xkVBvWR@vger.kernel.org, AJvYcCWtQ7ihjZER8ez9WdQWpiuU2Bl3M4+HkF5VPNnEHUV6aEpLDF3LV9px4M2qh2gJtaV3IqhDa10dumM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBxNw381HpRvLex0iu+apX5eBPUQ2fjSaEmwpkH2i3J3+6Osp+
	0caNQLIT4GHaApOU47oDW6xxUdGfzRqEyJL7aHfPVfQAYAxbnyfw6LSPyJomlj8BSoVXTEm/8Sp
	c2WgjhvUJAukIiuU1SbzapLhjTVusm+E=
X-Google-Smtp-Source: AGHT+IFKckh0OMNl5m+D9oKZHC/g9OnggdkxBpQGgs0QajnaU9g2jKuhkYItbjSDUx+gqLZjS0O/PkbKLOEsLwRkpLQ=
X-Received: by 2002:a05:6512:3b9e:b0:55f:486b:7e44 with SMTP id
 2adb3069b0e04-55f708ecf52mr3370838e87.37.1756821038259; Tue, 02 Sep 2025
 06:50:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250828102202.1849035-24-ardb+git@google.com>
 <20250828102202.1849035-34-ardb+git@google.com> <20250902120221.GEaLbczaZ1RPY7dGKH@fat_crate.local>
In-Reply-To: <20250902120221.GEaLbczaZ1RPY7dGKH@fat_crate.local>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 2 Sep 2025 15:50:27 +0200
X-Gmail-Original-Message-ID: <CAMj1kXH7tfQ_jWQczBnYrsyrELWDisw=tYmyJzcHYqTi57U-5A@mail.gmail.com>
X-Gm-Features: Ac12FXwqQ4BK9iYdt1L-zim2tW3bhi8BbyVsmZsn7EgHO3CtfFZD0kSoov3uoqQ
Message-ID: <CAMj1kXH7tfQ_jWQczBnYrsyrELWDisw=tYmyJzcHYqTi57U-5A@mail.gmail.com>
Subject: Re: [PATCH v7 10/22] x86/boot: Drop redundant RMPADJUST in SEV SVSM
 presence check
To: Borislav Petkov <bp@alien8.de>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org, 
	linux-efi@vger.kernel.org, x86@kernel.org, Ingo Molnar <mingo@kernel.org>, 
	Kevin Loughlin <kevinloughlin@google.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Nikunj A Dadhania <nikunj@amd.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 2 Sept 2025 at 14:02, Borislav Petkov <bp@alien8.de> wrote:
>
> On Thu, Aug 28, 2025 at 12:22:13PM +0200, Ard Biesheuvel wrote:
> > -             /*
> > -              * Running at VMPL0 is not required if an SVSM is present and the hypervisor
> > -              * supports the required SVSM GHCB events.
> > -              */
> > -             if (ret &&
> > -                 !(snp_vmpl && (hv_features & GHCB_HV_FT_SNP_MULTI_VMPL)))
> > +             if (snp_vmpl > 0 && !(hv_features & GHCB_HV_FT_SNP_MULTI_VMPL))
>
> Yeah, it is unsigned:
>
> diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
> index 973ca206794a..808211b09424 100644
> --- a/arch/x86/boot/compressed/sev.c
> +++ b/arch/x86/boot/compressed/sev.c
> @@ -415,7 +415,7 @@ void sev_enable(struct boot_params *bp)
>                  * Running at VMPL0 is required unless an SVSM is present and
>                  * the hypervisor supports the required SVSM GHCB events.
>                  */
> -               if (snp_vmpl > 0 && !(hv_features & GHCB_HV_FT_SNP_MULTI_VMPL))
> +               if (snp_vmpl && !(hv_features & GHCB_HV_FT_SNP_MULTI_VMPL))
>                         sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_NOT_VMPL0);
>         }
>

Why is that better?

