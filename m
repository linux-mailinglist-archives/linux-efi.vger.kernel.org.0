Return-Path: <linux-efi+bounces-773-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 895B9875DED
	for <lists+linux-efi@lfdr.de>; Fri,  8 Mar 2024 07:17:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC8BA1C20C3D
	for <lists+linux-efi@lfdr.de>; Fri,  8 Mar 2024 06:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E9C52E84F;
	Fri,  8 Mar 2024 06:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Zhy/zOsK"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7689D1D6A8
	for <linux-efi@vger.kernel.org>; Fri,  8 Mar 2024 06:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709878637; cv=none; b=a89ed0RKt+dljJcRKY/kq2CIdm1nU+GhJUUz9bVcHeua4YcQsPeXDYFjxctdVLjo9Yc+NG36FrMYxVgprYgXmRIUsa53Oow9S3kjAuRo0aVu7whYIaWAbFapqvkIueZLonSHcWOROR2a7sCj+rGIYx+kBD+79j0BHjGSCfG2GbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709878637; c=relaxed/simple;
	bh=//KtGIHnqH0q7odPRbeTYz+pydOzeDl9s0Zj+XZXd14=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tesO/NJM0OwjsYSpojNg2KSVrwcnruUkTTd7PqcW3DjZJgNtZ2Rf4q5edRwDaSX8mjqOULd/wP98Yv/OPRgPzDYs+M2wsPKvO2BzZYhhk1w2+NG0+cGmMX94rKFYlAmMgD4Oh+4D9qDaiqptoET2xKA6JWSWxm7oCEJKdxnUr1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Zhy/zOsK; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2d094bc2244so23722101fa.1
        for <linux-efi@vger.kernel.org>; Thu, 07 Mar 2024 22:17:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709878633; x=1710483433; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BGicMrrqVSq9woU0rQu2gy5i8fqlBtpVNI9P5BqEU78=;
        b=Zhy/zOsKc+5hmbRF8mxQRfsQuLzYvoiQmLeCKVkHQexvFI5VCfibij1vawhGrymYF5
         SlbaoHDX68ODQnzy/NqFGabCevj6wuZa1+QWGJF4emu9epPdD3Fq7vkhD+l3Hd4rcJxM
         k3mAkI0fyZ9hRuIGZ5eHhjgJl4euzkwFuc557cqC3KKGlPCD/gT5ettAhD8HNuOKyXTF
         YfE6qUvssUx6Oc/ZPHmPZEXSf/BIkhQltBgIyk0LrjWYYs704yKYYR+e2IQ8/aoSBP+f
         +kSlhHyt1YqEJlgj8EP5gcdqFb7Z/UxFvbx4qGK7XiZEIwCL/gKuTI9AzFZV7JkzrChj
         aj6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709878633; x=1710483433;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BGicMrrqVSq9woU0rQu2gy5i8fqlBtpVNI9P5BqEU78=;
        b=Tkl3LuiZXGvRmCVqfqPXuqFC4Z2eWT6s+Fk8thi1yKtHuKirM5w7SwUn2AX+kwLfyq
         jGdzdNnKyhRZ2PcZqcvKys2Dk3LocF7nrX7Y4bE+ehcm8M/DInoWPNVvj+aAHpDZubJh
         MpZhslJGChxD8lHkktaGrZrYDWpehsHKhvmiivnbar9KUwZmexOI0YW0zuUBIfLCUs11
         fB+9dsbVGjq/WpHdK5Ozxe79zzNhJfd7Yck8wDLAkt8Hr3sQBjmRNfvRBtJf8OaEppXt
         6c3qItNrkQ5WhgRnvxbQrz/M8RylBkgmB8v6Q8hgpUJY28pFvtqnXwWOEjskPxX24nn0
         hA8A==
X-Gm-Message-State: AOJu0YzWDZrIjLVuzlyX8gFcf2CN2H4apATphPlxOHd34jmsoMI5rXBS
	q9A0hShjo9byYyIrOC4coGyU57Kj13gJjHkCLvsyiO8+TLGL6RkOaQBKrgWqnjBWy9m1oCenMhH
	vqxNBiv/OO21QEUzPYtvHcGj+Pf4nM7ZmqbDbrQ==
X-Google-Smtp-Source: AGHT+IG/aeepsNgY023QTHXhmwNDTeAv/1y6JwUQTxDQjfEo4GRcDuYFiCIxr75nip7QD7AZz3VPWyduBfDGWf9cRCk=
X-Received: by 2002:a2e:3613:0:b0:2d2:3810:552 with SMTP id
 d19-20020a2e3613000000b002d238100552mr2577462lja.53.1709878633286; Thu, 07
 Mar 2024 22:17:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240307162214.272314-7-ardb+git@google.com> <20240307162214.272314-9-ardb+git@google.com>
In-Reply-To: <20240307162214.272314-9-ardb+git@google.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 8 Mar 2024 08:16:37 +0200
Message-ID: <CAC_iWjJNhsptZDcr=qD0gsjLJet+WbPk=PeT9npDoAc4GYx2Mw@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] efi/tpm: Use symbolic GUID name from spec for
 final events table
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 7 Mar 2024 at 18:22, Ard Biesheuvel <ardb+git@google.com> wrote:
>
> From: Ard Biesheuvel <ardb@kernel.org>
>
> The LINUX_EFI_ GUID identifiers are only intended to be used to refer to
> GUIDs that are part of the Linux implementation, and are not considered
> external ABI. (Famous last words).
>
> GUIDs that already have a symbolic name in the spec should use that
> name, to avoid confusion between firmware components. So use the
> official name EFI_TCG2_FINAL_EVENTS_TABLE_GUID for the TCG2 'final
> events' configuration table.
>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  drivers/firmware/efi/efi.c         | 2 +-
>  drivers/firmware/efi/libstub/tpm.c | 2 +-
>  include/linux/efi.h                | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> index 4fcda50acfa4..f6cfd29308d9 100644
> --- a/drivers/firmware/efi/efi.c
> +++ b/drivers/firmware/efi/efi.c
> @@ -597,7 +597,7 @@ static const efi_config_table_type_t common_tables[] __initconst = {
>         {EFI_MEMORY_ATTRIBUTES_TABLE_GUID,      &efi_mem_attr_table,    "MEMATTR"       },
>         {LINUX_EFI_RANDOM_SEED_TABLE_GUID,      &efi_rng_seed,          "RNG"           },
>         {LINUX_EFI_TPM_EVENT_LOG_GUID,          &efi.tpm_log,           "TPMEventLog"   },
> -       {LINUX_EFI_TPM_FINAL_LOG_GUID,          &efi.tpm_final_log,     "TPMFinalLog"   },
> +       {EFI_TCG2_FINAL_EVENTS_TABLE_GUID,      &efi.tpm_final_log,     "TPMFinalLog"   },
>         {LINUX_EFI_MEMRESERVE_TABLE_GUID,       &mem_reserve,           "MEMRESERVE"    },
>         {LINUX_EFI_INITRD_MEDIA_GUID,           &initrd,                "INITRD"        },
>         {EFI_RT_PROPERTIES_TABLE_GUID,          &rt_prop,               "RTPROP"        },
> diff --git a/drivers/firmware/efi/libstub/tpm.c b/drivers/firmware/efi/libstub/tpm.c
> index 7acbac16eae0..a880f7374c27 100644
> --- a/drivers/firmware/efi/libstub/tpm.c
> +++ b/drivers/firmware/efi/libstub/tpm.c
> @@ -128,7 +128,7 @@ void efi_retrieve_tpm2_eventlog(void)
>          * final events structure, and if so how much space they take up
>          */
>         if (version == EFI_TCG2_EVENT_LOG_FORMAT_TCG_2)
> -               final_events_table = get_efi_config_table(LINUX_EFI_TPM_FINAL_LOG_GUID);
> +               final_events_table = get_efi_config_table(EFI_TCG2_FINAL_EVENTS_TABLE_GUID);
>         if (final_events_table && final_events_table->nr_events) {
>                 struct tcg_pcr_event2_head *header;
>                 int offset;
> diff --git a/include/linux/efi.h b/include/linux/efi.h
> index c74f47711f0b..464fe16411b8 100644
> --- a/include/linux/efi.h
> +++ b/include/linux/efi.h
> @@ -386,6 +386,7 @@ void efi_native_runtime_setup(void);
>  #define EFI_CONSOLE_OUT_DEVICE_GUID            EFI_GUID(0xd3b36f2c, 0xd551, 0x11d4,  0x9a, 0x46, 0x00, 0x90, 0x27, 0x3f, 0xc1, 0x4d)
>  #define APPLE_PROPERTIES_PROTOCOL_GUID         EFI_GUID(0x91bd12fe, 0xf6c3, 0x44fb,  0xa5, 0xb7, 0x51, 0x22, 0xab, 0x30, 0x3a, 0xe0)
>  #define EFI_TCG2_PROTOCOL_GUID                 EFI_GUID(0x607f766c, 0x7455, 0x42be,  0x93, 0x0b, 0xe4, 0xd7, 0x6d, 0xb2, 0x72, 0x0f)
> +#define EFI_TCG2_FINAL_EVENTS_TABLE_GUID       EFI_GUID(0x1e2ed096, 0x30e2, 0x4254,  0xbd, 0x89, 0x86, 0x3b, 0xbe, 0xf8, 0x23, 0x25)
>  #define EFI_LOAD_FILE_PROTOCOL_GUID            EFI_GUID(0x56ec3091, 0x954c, 0x11d2,  0x8e, 0x3f, 0x00, 0xa0, 0xc9, 0x69, 0x72, 0x3b)
>  #define EFI_LOAD_FILE2_PROTOCOL_GUID           EFI_GUID(0x4006c0c1, 0xfcb3, 0x403e,  0x99, 0x6d, 0x4a, 0x6c, 0x87, 0x24, 0xe0, 0x6d)
>  #define EFI_RT_PROPERTIES_TABLE_GUID           EFI_GUID(0xeb66918a, 0x7eef, 0x402a,  0x84, 0x2e, 0x93, 0x1d, 0x21, 0xc3, 0x8a, 0xe9)
> @@ -411,7 +412,6 @@ void efi_native_runtime_setup(void);
>  #define LINUX_EFI_LOADER_ENTRY_GUID            EFI_GUID(0x4a67b082, 0x0a4c, 0x41cf,  0xb6, 0xc7, 0x44, 0x0b, 0x29, 0xbb, 0x8c, 0x4f)
>  #define LINUX_EFI_RANDOM_SEED_TABLE_GUID       EFI_GUID(0x1ce1e5bc, 0x7ceb, 0x42f2,  0x81, 0xe5, 0x8a, 0xad, 0xf1, 0x80, 0xf5, 0x7b)
>  #define LINUX_EFI_TPM_EVENT_LOG_GUID           EFI_GUID(0xb7799cb0, 0xeca2, 0x4943,  0x96, 0x67, 0x1f, 0xae, 0x07, 0xb7, 0x47, 0xfa)
> -#define LINUX_EFI_TPM_FINAL_LOG_GUID           EFI_GUID(0x1e2ed096, 0x30e2, 0x4254,  0xbd, 0x89, 0x86, 0x3b, 0xbe, 0xf8, 0x23, 0x25)
>  #define LINUX_EFI_MEMRESERVE_TABLE_GUID                EFI_GUID(0x888eb0c6, 0x8ede, 0x4ff5,  0xa8, 0xf0, 0x9a, 0xee, 0x5c, 0xb9, 0x77, 0xc2)
>  #define LINUX_EFI_INITRD_MEDIA_GUID            EFI_GUID(0x5568e427, 0x68fc, 0x4f3d,  0xac, 0x74, 0xca, 0x55, 0x52, 0x31, 0xcc, 0x68)
>  #define LINUX_EFI_MOK_VARIABLE_TABLE_GUID      EFI_GUID(0xc451ed2b, 0x9694, 0x45d3,  0xba, 0xba, 0xed, 0x9f, 0x89, 0x88, 0xa3, 0x89)
> --
> 2.44.0.278.ge034bb2e1d-goog
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

