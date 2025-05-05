Return-Path: <linux-efi+bounces-3592-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59809AA932F
	for <lists+linux-efi@lfdr.de>; Mon,  5 May 2025 14:32:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD1341893F93
	for <lists+linux-efi@lfdr.de>; Mon,  5 May 2025 12:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F5AF24E4A4;
	Mon,  5 May 2025 12:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="NZqj8GCx"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68531D90AD
	for <linux-efi@vger.kernel.org>; Mon,  5 May 2025 12:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746448336; cv=none; b=MgfroiQGShw8SuILavxcMY2iX0/5CJNBuk9lHd1gzt48v+v4huqCBVdvpOurX4szhSh8xTyaAqFg8SXkFr97sMpsTdak44pjzurk4gyJKF24y58bM//jfesuOYwwsWYQUAoiSKSsyKig5UOpjQYIJYPh0dAAskAAmRqvd2ZjOaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746448336; c=relaxed/simple;
	bh=z9yc6YZ8/bzyIza72DBETn31TjUPwyUy4wMzJdbZb6Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qDVfgU4HNJKpiulivGJDXJcsv3TljKCIoOWQt/NohGDivc3vJNW0ijEMEN+//6oY6gJbtR6NNcpSDllqeiyFOvVfRu5s4gfUpVEHG6FghFH2W1VIIFZETrnTHfnmO64061Fc0/XjuWnm1lD5cLxbw6If8MfQP7VL2qad/eQY/Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=NZqj8GCx; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-85b4170f1f5so142353239f.3
        for <linux-efi@vger.kernel.org>; Mon, 05 May 2025 05:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1746448333; x=1747053133; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ROvQBGSdDBOd+A03xhzhhLZdwd+Yr3g8998GOj2eyg=;
        b=NZqj8GCxTJO8JUfpyTyKZyynZcZ3zqTF6hQ4OfdcjKNX1oqWuZT/e6mmPJwa6R/ta2
         gWzO6TIyMDlHwllSmfYd7eTwPm/0RRECRN3LEx4pCPqShNw0oqBS72RwmBDEy2UtrxNa
         VG+tDvCrlhjKuQwNoA+xRwK7xF6aao+bNqEF6j207i9X24zgYij4O+z4RSiTPITaN3eX
         98E0yO6AS2N5Q+2v43Yz+cHbmeaLp+5sscLdo89ljp5ghOXGhP0nB7FPMkNcLwIObCGx
         i/6gsjEOk/eyHyBgOyBsMX0g3HxbyTBnm08cyRrXhyoKLDyeNmnp1qmtPQOh63yrgm3M
         FUkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746448333; x=1747053133;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2ROvQBGSdDBOd+A03xhzhhLZdwd+Yr3g8998GOj2eyg=;
        b=lT/bqOYIoeJoCCbCmCMIAN8yjnCsNYVSO3Hz6NnKcss4Ja5xHv0A/wL4nOhGw1tG2H
         SFMcY55/uDce+9MopQEHASLlPpHR688udS2GfNyHmdIYBnABMj4GoQcFE4fYAoxVh3st
         7DJE0TCw8zkX2zwKQlFm75uupnSC0qE5CCV/v7WEoHbexuh4wB4u1tmCUhFWIQpQzdvK
         2UB5PcOW+UPxAZ/7ysTr5mMUwPJEYWnJQVUL/+KMkSrWockYjI/ey/6OyqSWNw2+zd31
         IX2GMnLKdb03ERETqM6klSAzjV3OlMnGGs/ruP8bbyEbLM95B26R74VBQDRP1lTIhsAi
         C1QQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIeBD0ZcpNY26Q/6AuarrBzFaqf2mMuDdzSyhMhdVDSwkVOBwacbHyJABX1kAuscgJrG3GKdbokAw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1DT5dX0TCgnMV5VQBs2B3YXUSy1z5YootVXFGhI5iABwFHfNj
	1hllKiV4zwRaUT36gMV8x3L76w/DxjdNufKoNToJYRkfGHO6q0/n16gJjCUXbnezN+iVmmGr6TC
	CVh9G+6fa8vE5NdqjzMAQCN8pjY94WHukb9JOVw==
X-Gm-Gg: ASbGncu6CxGgwD0eydp8N3Tvilz7DLi6QVKBhtxw9N+FWG5GXz0t4soc3W3rR3UD+LZ
	2/DwvlvWWFWE3uGy7gEnlgBJYbFZFkdfRcsv3dzingyWGU24Io1pBUA8t5CagDZuoIOm6kC9sky
	DmQJThUefZCwnxGq91gzojukg=
X-Google-Smtp-Source: AGHT+IGKfyVuSpXvhyCqr3MzLrMWyvS/DXDaTYYmrBeFPlCthPJdi1/XEIr6vTapFuhwTG/+VDZdp44YaLe79OiDUvE=
X-Received: by 2002:a92:ca4e:0:b0:3d8:2023:d048 with SMTP id
 e9e14a558f8ab-3da569fc0fdmr78214885ab.22.1746448332626; Mon, 05 May 2025
 05:32:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250227123628.2931490-1-hchauhan@ventanamicro.com> <20250227123628.2931490-2-hchauhan@ventanamicro.com>
In-Reply-To: <20250227123628.2931490-2-hchauhan@ventanamicro.com>
From: Anup Patel <anup@brainfault.org>
Date: Mon, 5 May 2025 18:02:03 +0530
X-Gm-Features: ATxdqUH3w6mQ0qSoQ0tXhdBpHdmtraVQBLRXb-lEZsWxpb787pmCQYQjNjM4yWg
Message-ID: <CAAhSdy1bupf80qpio6-HpwzC53MW3UguKj+zxd3Zmduxay4rpg@mail.gmail.com>
Subject: Re: [RFC PATCH v1 01/10] riscv: Define ioremap_cache for RISC-V
To: Himanshu Chauhan <hchauhan@ventanamicro.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-efi@vger.kernel.org, 
	acpica-devel@lists.linux.dev, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	lenb@kernel.org, james.morse@arm.com, tony.luck@intel.com, ardb@kernel.org, 
	conor@kernel.org, cleger@rivosinc.com, robert.moore@intel.com, 
	sunilvl@ventanamicro.com, apatel@ventanamicro.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2025 at 6:08=E2=80=AFPM Himanshu Chauhan
<hchauhan@ventanamicro.com> wrote:
>
> bert and einj drivers use ioremap_cache for mapping entries
> but ioremap_cache is not defined for RISC-V.
>
> Signed-off-by: Himanshu Chauhan <hchauhan@ventanamicro.com>
> ---
>  arch/riscv/include/asm/io.h | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/arch/riscv/include/asm/io.h b/arch/riscv/include/asm/io.h
> index 1c5c641075d2..e23a4901e928 100644
> --- a/arch/riscv/include/asm/io.h
> +++ b/arch/riscv/include/asm/io.h
> @@ -30,6 +30,9 @@
>  #define PCI_IOBASE             ((void __iomem *)PCI_IO_START)
>  #endif /* CONFIG_MMU */
>
> +#define ioremap_cache(addr, size)                                      \
> +       ((__force void *)ioremap_prot((addr), (size), _PAGE_KERNEL))
> +

There is a compile error observed with this patch applied
on the latest Linux-6.15-rcX kernel.

To fix compile error, we need the following change:
s/_PAGE_KERNEL/PAGE_KERNEL/

Regards,
Anup

