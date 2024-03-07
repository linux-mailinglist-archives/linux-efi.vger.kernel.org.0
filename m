Return-Path: <linux-efi+bounces-771-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04A98875452
	for <lists+linux-efi@lfdr.de>; Thu,  7 Mar 2024 17:39:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81942289343
	for <lists+linux-efi@lfdr.de>; Thu,  7 Mar 2024 16:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7320383CAD;
	Thu,  7 Mar 2024 16:38:54 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91EFD1EB40
	for <linux-efi@vger.kernel.org>; Thu,  7 Mar 2024 16:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709829534; cv=none; b=ARe1hv/NI4afKeTOhBq/atXx/oSgDTqUwOaM48dOj4hhFvG3nTk4PSIX3M3rXUvZ3d/Io2CBY8k6nu3Qtj61wVYD00Kc/BmEmdi793WIV8fuupjXZoD2r1M/TlKZMGMnsbGVE99wwLmFeUueh10pu0tflK4xOU7B7ymIMVxNmbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709829534; c=relaxed/simple;
	bh=bJcwIL5URk2Nf9yNJ3TWdUDPin9TUROJlgnQJZ/dFg8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kmDBdZdfKGGG6xhFKmgSrcHCcMiIE0JY8j8lf/jVhX1e/V4qXHfxvReizMyI2g19MLl/KpbmXd1PMKQpn88nYXQ62B5SpFsEuQES5+SPNpfzR1z/e8p0wR2A316R/CGpTuaumqQAyAkpnBdMJhuh3TEm5jt+s69ZhzxJRFeAj8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5131a9b3d5bso1258206e87.0
        for <linux-efi@vger.kernel.org>; Thu, 07 Mar 2024 08:38:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709829530; x=1710434330;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qsdTKVS6uGR1v9Q42V7pucgN3CCsTny5wpFzUeuEvAo=;
        b=I3RM9VLbZmjL7NNbJQR9Z7gZDj83qU0Vlt53cBcN5oh1mTsxl3QgIjubo3Ya2Evutb
         UBA1zDwxq1usITQx26mOSV00v9mJJWW/ra/NHkAX1AwSJt0Antw5TmS2FS0hwd9u5sQb
         nwFn0TZ4JPWjI+sry6BgTwso76KWzmamc7qDg4SSM4fN7Zqamg8nSfw9za+zL+EX2t4D
         aVlugdfiDzVbW2tlqgoMA29NvC86zp0SetSblXYJ0wzm0AQBbye8o6GuyBvOANlpmLoL
         VYWBTpLwBQLk6Ee4ktlX8GLH8kfpvNOZzd/x1vj7dOMqfR+S/oWmAI2z7QmP6q5A5Og9
         8GvA==
X-Gm-Message-State: AOJu0YwXWJMiodC+ajikHMM9E+/ANQcyod+Aygs6DGlS//Lf8wmfoXkM
	oeLNrI6nk1F24/GT0nhnmx9xFoMnQflJEbakv7vVqYbaHMagcnpzHq8H53le1TS7dw==
X-Google-Smtp-Source: AGHT+IE0M1M3iXaJxkS80MwlmKtJ3hyG83u8mVQI0ehJDz1swXLwZl3/RXkOZ7BiOKvUd4HDWzwvOA==
X-Received: by 2002:ac2:43cd:0:b0:513:1804:9359 with SMTP id u13-20020ac243cd000000b0051318049359mr1783868lfl.17.1709829530140;
        Thu, 07 Mar 2024 08:38:50 -0800 (PST)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id b12-20020a19644c000000b00513179f6c22sm3224665lfj.96.2024.03.07.08.38.49
        for <linux-efi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Mar 2024 08:38:49 -0800 (PST)
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2d09cf00214so14768271fa.0
        for <linux-efi@vger.kernel.org>; Thu, 07 Mar 2024 08:38:49 -0800 (PST)
X-Received: by 2002:a05:651c:168f:b0:2d4:7a3:67a7 with SMTP id
 bd15-20020a05651c168f00b002d407a367a7mr1518337ljb.22.1709829529663; Thu, 07
 Mar 2024 08:38:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240307162214.272314-7-ardb+git@google.com> <20240307162214.272314-9-ardb+git@google.com>
In-Reply-To: <20240307162214.272314-9-ardb+git@google.com>
Reply-To: sathyanarayanan.kuppuswamy@linux.intel.com
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Date: Thu, 7 Mar 2024 08:38:38 -0800
X-Gmail-Original-Message-ID: <CAC41dw_4V=Ykurb5hEPuypA9+5YNXzqeM6WxOhsNvT-H6ZrZRw@mail.gmail.com>
Message-ID: <CAC41dw_4V=Ykurb5hEPuypA9+5YNXzqeM6WxOhsNvT-H6ZrZRw@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] efi/tpm: Use symbolic GUID name from spec for
 final events table
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Mar 7, 2024 at 8:22=E2=80=AFAM Ard Biesheuvel <ardb+git@google.com>=
 wrote:
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

Looks good to me.

Reviewed-by: Kuppuswamy Sathyanarayanan
<sathyanarayanan.kuppuswamy@linux.intel.com>

>  drivers/firmware/efi/efi.c         | 2 +-
>  drivers/firmware/efi/libstub/tpm.c | 2 +-
>  include/linux/efi.h                | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> index 4fcda50acfa4..f6cfd29308d9 100644
> --- a/drivers/firmware/efi/efi.c
> +++ b/drivers/firmware/efi/efi.c
> @@ -597,7 +597,7 @@ static const efi_config_table_type_t common_tables[] =
__initconst =3D {
>         {EFI_MEMORY_ATTRIBUTES_TABLE_GUID,      &efi_mem_attr_table,    "=
MEMATTR"       },
>         {LINUX_EFI_RANDOM_SEED_TABLE_GUID,      &efi_rng_seed,          "=
RNG"           },
>         {LINUX_EFI_TPM_EVENT_LOG_GUID,          &efi.tpm_log,           "=
TPMEventLog"   },
> -       {LINUX_EFI_TPM_FINAL_LOG_GUID,          &efi.tpm_final_log,     "=
TPMFinalLog"   },
> +       {EFI_TCG2_FINAL_EVENTS_TABLE_GUID,      &efi.tpm_final_log,     "=
TPMFinalLog"   },
>         {LINUX_EFI_MEMRESERVE_TABLE_GUID,       &mem_reserve,           "=
MEMRESERVE"    },
>         {LINUX_EFI_INITRD_MEDIA_GUID,           &initrd,                "=
INITRD"        },
>         {EFI_RT_PROPERTIES_TABLE_GUID,          &rt_prop,               "=
RTPROP"        },
> diff --git a/drivers/firmware/efi/libstub/tpm.c b/drivers/firmware/efi/li=
bstub/tpm.c
> index 7acbac16eae0..a880f7374c27 100644
> --- a/drivers/firmware/efi/libstub/tpm.c
> +++ b/drivers/firmware/efi/libstub/tpm.c
> @@ -128,7 +128,7 @@ void efi_retrieve_tpm2_eventlog(void)
>          * final events structure, and if so how much space they take up
>          */
>         if (version =3D=3D EFI_TCG2_EVENT_LOG_FORMAT_TCG_2)
> -               final_events_table =3D get_efi_config_table(LINUX_EFI_TPM=
_FINAL_LOG_GUID);
> +               final_events_table =3D get_efi_config_table(EFI_TCG2_FINA=
L_EVENTS_TABLE_GUID);
>         if (final_events_table && final_events_table->nr_events) {
>                 struct tcg_pcr_event2_head *header;
>                 int offset;
> diff --git a/include/linux/efi.h b/include/linux/efi.h
> index c74f47711f0b..464fe16411b8 100644
> --- a/include/linux/efi.h
> +++ b/include/linux/efi.h
> @@ -386,6 +386,7 @@ void efi_native_runtime_setup(void);
>  #define EFI_CONSOLE_OUT_DEVICE_GUID            EFI_GUID(0xd3b36f2c, 0xd5=
51, 0x11d4,  0x9a, 0x46, 0x00, 0x90, 0x27, 0x3f, 0xc1, 0x4d)
>  #define APPLE_PROPERTIES_PROTOCOL_GUID         EFI_GUID(0x91bd12fe, 0xf6=
c3, 0x44fb,  0xa5, 0xb7, 0x51, 0x22, 0xab, 0x30, 0x3a, 0xe0)
>  #define EFI_TCG2_PROTOCOL_GUID                 EFI_GUID(0x607f766c, 0x74=
55, 0x42be,  0x93, 0x0b, 0xe4, 0xd7, 0x6d, 0xb2, 0x72, 0x0f)
> +#define EFI_TCG2_FINAL_EVENTS_TABLE_GUID       EFI_GUID(0x1e2ed096, 0x30=
e2, 0x4254,  0xbd, 0x89, 0x86, 0x3b, 0xbe, 0xf8, 0x23, 0x25)
>  #define EFI_LOAD_FILE_PROTOCOL_GUID            EFI_GUID(0x56ec3091, 0x95=
4c, 0x11d2,  0x8e, 0x3f, 0x00, 0xa0, 0xc9, 0x69, 0x72, 0x3b)
>  #define EFI_LOAD_FILE2_PROTOCOL_GUID           EFI_GUID(0x4006c0c1, 0xfc=
b3, 0x403e,  0x99, 0x6d, 0x4a, 0x6c, 0x87, 0x24, 0xe0, 0x6d)
>  #define EFI_RT_PROPERTIES_TABLE_GUID           EFI_GUID(0xeb66918a, 0x7e=
ef, 0x402a,  0x84, 0x2e, 0x93, 0x1d, 0x21, 0xc3, 0x8a, 0xe9)
> @@ -411,7 +412,6 @@ void efi_native_runtime_setup(void);
>  #define LINUX_EFI_LOADER_ENTRY_GUID            EFI_GUID(0x4a67b082, 0x0a=
4c, 0x41cf,  0xb6, 0xc7, 0x44, 0x0b, 0x29, 0xbb, 0x8c, 0x4f)
>  #define LINUX_EFI_RANDOM_SEED_TABLE_GUID       EFI_GUID(0x1ce1e5bc, 0x7c=
eb, 0x42f2,  0x81, 0xe5, 0x8a, 0xad, 0xf1, 0x80, 0xf5, 0x7b)
>  #define LINUX_EFI_TPM_EVENT_LOG_GUID           EFI_GUID(0xb7799cb0, 0xec=
a2, 0x4943,  0x96, 0x67, 0x1f, 0xae, 0x07, 0xb7, 0x47, 0xfa)
> -#define LINUX_EFI_TPM_FINAL_LOG_GUID           EFI_GUID(0x1e2ed096, 0x30=
e2, 0x4254,  0xbd, 0x89, 0x86, 0x3b, 0xbe, 0xf8, 0x23, 0x25)
>  #define LINUX_EFI_MEMRESERVE_TABLE_GUID                EFI_GUID(0x888eb0=
c6, 0x8ede, 0x4ff5,  0xa8, 0xf0, 0x9a, 0xee, 0x5c, 0xb9, 0x77, 0xc2)
>  #define LINUX_EFI_INITRD_MEDIA_GUID            EFI_GUID(0x5568e427, 0x68=
fc, 0x4f3d,  0xac, 0x74, 0xca, 0x55, 0x52, 0x31, 0xcc, 0x68)
>  #define LINUX_EFI_MOK_VARIABLE_TABLE_GUID      EFI_GUID(0xc451ed2b, 0x96=
94, 0x45d3,  0xba, 0xba, 0xed, 0x9f, 0x89, 0x88, 0xa3, 0x89)
> --
> 2.44.0.278.ge034bb2e1d-goog
>

