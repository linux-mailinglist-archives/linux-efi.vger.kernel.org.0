Return-Path: <linux-efi+bounces-3413-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C033A972E8
	for <lists+linux-efi@lfdr.de>; Tue, 22 Apr 2025 18:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 674D81B61153
	for <lists+linux-efi@lfdr.de>; Tue, 22 Apr 2025 16:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A3B2293B6D;
	Tue, 22 Apr 2025 16:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Cpe8U2Hs"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4582728FFEE
	for <linux-efi@vger.kernel.org>; Tue, 22 Apr 2025 16:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745340035; cv=none; b=jG0X87pkGr/awS/V/fdwbkffkMB0pchO4LUOV01MTcNZp7fNvDHrly6uyErpxvBJXIbgJCcKAdLJ1UJ84R0UUifWG6Wp+NK6n5aL2p/v3o8zrlZDZQXQDc8d7AjSWfin7bUL4YhlFUSkVrQiPU/vPOIw8TZ5iBGY98mcC4FJOxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745340035; c=relaxed/simple;
	bh=KyHkgSB1LYkvBYuMzxh2ISkVy4IyurtuNG4vWCQZgwI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z9FlXIt4Nt3T80paPbvDpFcqzkFpYcfdW3ygQ45vBVJVXI4ZDLDJsRTxWu1nSuNkM+FG2NqbC529Y9TWVnrFZRbXzNGuoZqjDnU33L/AMadaOuzhudOGGN3jqBfC05bnoijPQeVEXjU4P4ZaNUEZkjngl/LRXVLfVqyufIozC5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Cpe8U2Hs; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3913b539aabso3314054f8f.2
        for <linux-efi@vger.kernel.org>; Tue, 22 Apr 2025 09:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745340032; x=1745944832; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PheeiRc9EwICesMgU/m/AYGI+4mpx/+Fk50exrI0Vzo=;
        b=Cpe8U2HssvGru79Ng7Bzez5SvbrVuVDtYnD+IC4UMl6GQHooV0C69H2EyRj2KH0a+G
         SSxs9bbpYbv2xJyz3HPN7Sqepqe7OToyBq1Pc6DCXYGqIsNALFZ5H+XkE341pvPUiagM
         bzfFMQ0nzWTLDdEavRp3727RjbTBeKLmA1kCfyGsISQjmWsJDGswuPYL0sqoRnJg4x3o
         laI/GFkoxhsseH++zUmZiE0hU2QdfDpWyinyqSvghnQ9n28olYE/orfvYJ8eWB9aXeg6
         bArVuD7A304F2+f4SZIZ7XfuryBw+wsmuwif4TCls0CwAXlpUEfFE+AOw3DqgDU+fKm5
         U4Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745340032; x=1745944832;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PheeiRc9EwICesMgU/m/AYGI+4mpx/+Fk50exrI0Vzo=;
        b=ImaKOtW0Sl2uvYtX7aBerfExUAc1cImLCgOJHvXeAFRG3ziKMMivbvLDfFuhWpPd9n
         5FF8A0oq9a0jyxk78JtYGDp2HCiTGI7lxoCHtJVtHt2DsyI3nl8Em0TrT2AZ4y2H4nuE
         9U89eVySD2dhVwlRUez5oyge1qd19fK7LfrFMvNDmabLjWFj26evGjyazE2AJR83HUYt
         SxkvJGRfqrgTvHB/RLO76GuDMFXvUyqUZo7vJJazpFYOuzv5WhlLr59sUDX3rNc33uBX
         4n71380SR0B4d6gH5xsiR3s0Us3uBRgC2snDQz7N4WTc4hXkoZzXrkF/k12V9RPnr1k3
         1HCg==
X-Forwarded-Encrypted: i=1; AJvYcCXhExb3N5k/JFc84+ABJLfy6GQaJ3aopooYDq5QC6tjzOKCxCCWChyD+w4Evgyu9YDYAMD2MTvng3E=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywqo2rSS5IfBWl1ngKHBVovhigLwOcu212kSYtOH3qwACbyz4ZU
	5evJzE3C8eLGZx5WFO88rthHLiD5n8sOIZyZZse7lTpP1ffc960OgVuZQX43xNN2ZAbulRQXIzM
	dvM7AiexSOA4mQImbMsgMTstXvQu1xo/UQOgV
X-Gm-Gg: ASbGncuzc6CXphGHsA/kw7dC3XAndSyRxIj9TbDIpI/Sp+ilY9m5W0+ejSAmsruOw7L
	BbE2W5f6UhUSOXmNXJyCbkQb+64TjJuSSRo5PEF3B787KsxqiSKlJSSl9vho4uimcICL0aRVOhj
	bG+Ty4mao/JPmPzupdvsSf
X-Google-Smtp-Source: AGHT+IF5X0bjAqHneOs6yMl4knfwST8tHeBr7QuNJL0urvEF4LP3Q/vNR/07ibYC57qaiBHpyzqx79NitVgd2G+HP8I=
X-Received: by 2002:a05:6000:2584:b0:39a:ca05:5232 with SMTP id
 ffacd0b85a97d-39efba399c5mr13636179f8f.5.1745340032310; Tue, 22 Apr 2025
 09:40:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250422100728.208479-7-ardb+git@google.com> <d00c9119-5e8b-2615-8e4b-2d25732ff71a@amd.com>
In-Reply-To: <d00c9119-5e8b-2615-8e4b-2d25732ff71a@amd.com>
From: Ard Biesheuvel <ardb@google.com>
Date: Tue, 22 Apr 2025 18:40:20 +0200
X-Gm-Features: ATxdqUGtloSl2U65kDIWm22AckUEPKARP-Mw8k30n0_GdyswPmmUC6qOSYNEPKM
Message-ID: <CAGnOC3b2XBFw+xdMhTtpfDYG480BG-KwfkPMWOiOP+13XeHFfg@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] efi: Don't initalize SEV-SNP from the EFI stub
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-efi@vger.kernel.org, x86@kernel.org, 
	linux-kernel@vger.kernel.org, mingo@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Dionna Amalie Glaze <dionnaglaze@google.com>, Kevin Loughlin <kevinloughlin@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 22, 2025 at 5:51=E2=80=AFPM Tom Lendacky <thomas.lendacky@amd.c=
om> wrote:
>
> On 4/22/25 05:07, Ard Biesheuvel wrote:
> > From: Ard Biesheuvel <ardb@kernel.org>
> >
>
> Hi Ard,
>
> I'll try to get to reviewing and testing this series very soon.

Thanks.

> But one
> thing I can see is that we never set the snp_vmpl level anymore in the
> EFI stub and so PVALIDATE will fail when running under an SVSM.
>
> But I don't think this series is completely at fault. This goes back to
> fixing memory acceptance before sev_enable() was called and I missed the
> SVSM situation. So I don't think we can completely remove all SNP
> initialization and might have to do svsm_setup_ca() which has a pre-req
> on setup_cpuid_table()...  sigh.
>

OK, so memory acceptance from the EFI stub is still broken even when
using the MSR protocol, right?

But SVSM is relatively recent, and so we probably have more leeway to
fix it properly. And I assume the firmware itself can be expected to
have its own working configuration to communicate with the VMM and/or
the hypervisor?

This hybrid mode of executing in the firmware execution context but
taking control of everything under the hood is really a maintenance
nightmare, and so I'd rather do less of that than more of that. If
that implies that we need to re-engineer the early memory acceptance
and the population of the unaccepted memory table, I still think we
need to consider it. Ultimately, the memory acceptance in the stub is
not fundamentally needed, it is only there because there is a mismatch
between the table's granularity and the EFI memory map granularity. In
fact, given that this appears to be a rare occurrence anyway, and
ultimately under the control of the firmware (which we can also fix),
we might simply decide to use an unaccepted memory table with 4k
granularity unless all existing regions unaccepted memory regions are
aligned to 2M.

