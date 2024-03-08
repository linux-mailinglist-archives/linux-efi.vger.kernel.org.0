Return-Path: <linux-efi+bounces-774-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B5F9875E2A
	for <lists+linux-efi@lfdr.de>; Fri,  8 Mar 2024 08:04:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADF091F23B01
	for <lists+linux-efi@lfdr.de>; Fri,  8 Mar 2024 07:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8EAA1CFB2;
	Fri,  8 Mar 2024 07:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CCTFVLcU"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E99EEBB
	for <linux-efi@vger.kernel.org>; Fri,  8 Mar 2024 07:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709881451; cv=none; b=AV8s9osuEivEckaziX8inlEGIlkiha2qijf+jem87PBVM2H5Y8YBotHJdSAW9aP32cmtsqeKyrDy7+L9+svfZsSrtWBPAOLMESGO+PBGyQgGd5Q8MLh+uvdror9LoYGer4kTJGoSe8JrMZCOT5uLy+wAriIMv++32WorVfLy8EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709881451; c=relaxed/simple;
	bh=moNWiccG68WHCNpvgicP6owADtftc9jklz4pXPmQCxI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WG1uOC7uLoBSsj/w3wPSs5A9p+ECgkOWginkEyp1caAbeFuuHii6kzjR9rd48tmGovT6Q8/LTT+XGUGXZuqAAeCl+4Rv/pEBtXmlJqn1HlQbseMXVzEtwSBsQiyYbBuHKrOf7+HHLPkEEBT+4zqe4mCqTziUUBf0Hoc6btrfv58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CCTFVLcU; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-512e4f4e463so2394013e87.1
        for <linux-efi@vger.kernel.org>; Thu, 07 Mar 2024 23:04:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709881448; x=1710486248; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gn4mCkYJjDrdq3Br0Hvw1EguRQAza2aTfn3KrOlEaj8=;
        b=CCTFVLcUGOf8g9ogGFNZGMpK5oBQavRi86JUm6BGNi5S79qAxR/iiFNPH0Mx4FcokH
         DOv+aWAOpMPLk9cbuOoKgi3Bsi6iUHy6845Je/khytnJ6WLZtz+d32We7u2i3golJ3pp
         uT7uNwTaoShtFNxmAQIErAL41K2mBiplhXzc/Kk7c+NXOaD5LMYacJmm9A+g0Kqtqiau
         BuggSXrSngP3SYhagMxcWpCHa2UI1WJWZuWry5ekeVNBHkC8og7xZk3YfWBUEBUZz8lg
         +PDu/iI6N0akw+yE19Fn55e8xr1Sn/JyEaJ+RjIgJaA/lBy3LfzSBM4UeF2PDeAB+4cl
         EGkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709881448; x=1710486248;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gn4mCkYJjDrdq3Br0Hvw1EguRQAza2aTfn3KrOlEaj8=;
        b=wLkwjmsFZ4DEJJ+vGpX2sFzHvKX956P6DRIAu1gqEfShK0e9Nk6pclxc6OvxXktgtb
         bzMOoEvRlejvA7hl4ALy5fSDRlsCjmFZKGJCFfTzw26WMvUwfIw0iI5Z4/vhSkwj9ZoF
         WW1G0oEoaV5HY7T+k3iUzAlqtqR0LhyflKZNQgr0M7vWRq01fPMtSwj48Gn4v0UewlcC
         n6+WqUYyweuLFhdTPNRFC4+GChnD02y5PsqMjnuhYMDvK0mjI7Z0AhSw1+adA636+0Qc
         fPFN9cxnZ5PgYGxZM/HfeeKTxaOb6Kt2V5MifvNQor4Ov9mg+KECRKQbnSHN0Q2rEIvu
         yf7w==
X-Gm-Message-State: AOJu0YwuIflXBYW5bgeiXGp+8NJKKMEnWeJNIAffWjyTfRMDfweoxOLK
	WI/lPHOWsRladkZFjd69exgLRIwRX4LY0BG7y1Q1rdbyFnAylgHdPGXeOpTxb3iZyxoZUQVtuPm
	1atib/yd+mSztrovVDSdmcwiqLLqkc8O4GaZxQTv4fM+sCRA+u4a9vA==
X-Google-Smtp-Source: AGHT+IEze9YqD7egEaM0l0ENZ+1i0T2nZprsuXZtpasDYyXww0k8f7ZRGOyc1XDWf0bAeQK4GiofNkuHTTH3BZQmt6I=
X-Received: by 2002:ac2:5e35:0:b0:513:5c64:3a8a with SMTP id
 o21-20020ac25e35000000b005135c643a8amr2894491lfg.16.1709881447757; Thu, 07
 Mar 2024 23:04:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240307162214.272314-7-ardb+git@google.com> <20240307162214.272314-8-ardb+git@google.com>
In-Reply-To: <20240307162214.272314-8-ardb+git@google.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 8 Mar 2024 09:03:31 +0200
Message-ID: <CAC_iWjLhVmAjnmAvdkr3aCZwbWhNMJwLaeQ9NsUCbcwVHhwp3g@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] efi/libstub: Fold efi_tcg2_tagged_event into efi_measured_event
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

Hi Ard,

On Thu, 7 Mar 2024 at 18:22, Ard Biesheuvel <ardb+git@google.com> wrote:
>
> From: Ard Biesheuvel <ardb@kernel.org>
>
> In spite of the efi_ prefix, struct efi_tcg2_tagged_event is specific to
> the EFI stub, and so we can tweak it to our liking if needed, e.g., to
> accommodate the TDX variant of the TCG2 measurement protocol.
>
> In preparation for that, get rid of it entirely, and combine it with the
> efi_measured_event struct used by the measurement code.
>
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

> ---
>  drivers/firmware/efi/libstub/efi-stub-helper.c | 38 +++++++++++---------
>  drivers/firmware/efi/libstub/efistub.h         |  7 ----
>  2 files changed, 22 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
> index bfa30625f5d0..186ced8371ac 100644
> --- a/drivers/firmware/efi/libstub/efi-stub-helper.c
> +++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
> @@ -11,6 +11,7 @@
>
>  #include <linux/efi.h>
>  #include <linux/kernel.h>
> +#include <linux/overflow.h>
>  #include <asm/efi.h>
>  #include <asm/setup.h>
>
> @@ -193,7 +194,7 @@ void efi_apply_loadoptions_quirk(const void **load_options, u32 *load_options_si
>         *load_options_size = load_option_unpacked.optional_data_size;
>  }
>
> -enum efistub_event {
> +enum efistub_event_type {
>         EFISTUB_EVT_INITRD,
>         EFISTUB_EVT_LOAD_OPTIONS,
>         EFISTUB_EVT_COUNT,
> @@ -219,46 +220,51 @@ static const struct {
>         },
>  };
>
> +union efistub_event {
> +       efi_tcg2_event_t        tcg2_data;
> +};
> +
> +struct efistub_measured_event {
> +       union efistub_event     event_data;
> +       u32                     tagged_event_id;
> +       u32                     tagged_event_data_size;
> +       u8                      tagged_event_data[];
> +} __packed;
> +
>  static efi_status_t efi_measure_tagged_event(unsigned long load_addr,
>                                              unsigned long load_size,
> -                                            enum efistub_event event)
> +                                            enum efistub_event_type event)
>  {
> +       struct efistub_measured_event *evt;
> +       int size = struct_size(evt, tagged_event_data,
> +                              events[event].event_data_len);
>         efi_guid_t tcg2_guid = EFI_TCG2_PROTOCOL_GUID;
>         efi_tcg2_protocol_t *tcg2 = NULL;
>         efi_status_t status;
>
>         efi_bs_call(locate_protocol, &tcg2_guid, NULL, (void **)&tcg2);
>         if (tcg2) {
> -               struct efi_measured_event {
> -                       efi_tcg2_event_t        event_data;
> -                       efi_tcg2_tagged_event_t tagged_event;
> -                       u8                      tagged_event_data[];
> -               } *evt;
> -               int size = sizeof(*evt) + events[event].event_data_len;
> -
>                 status = efi_bs_call(allocate_pool, EFI_LOADER_DATA, size,
>                                      (void **)&evt);
>                 if (status != EFI_SUCCESS)
>                         goto fail;
>
> -               evt->event_data = (struct efi_tcg2_event){
> +               evt->event_data.tcg2_data = (struct efi_tcg2_event){
>                         .event_size                     = size,
> -                       .event_header.header_size       = sizeof(evt->event_data.event_header),
> +                       .event_header.header_size       = sizeof(evt->event_data.tcg2_data.event_header),
>                         .event_header.header_version    = EFI_TCG2_EVENT_HEADER_VERSION,
>                         .event_header.pcr_index         = events[event].pcr_index,
>                         .event_header.event_type        = EV_EVENT_TAG,
>                 };
>
> -               evt->tagged_event = (struct efi_tcg2_tagged_event){
> -                       .tagged_event_id                = events[event].event_id,
> -                       .tagged_event_data_size         = events[event].event_data_len,
> -               };
> +               evt->tagged_event_id            = events[event].event_id;
> +               evt->tagged_event_data_size     = events[event].event_data_len;
>
>                 memcpy(evt->tagged_event_data, events[event].event_data,
>                        events[event].event_data_len);
>
>                 status = efi_call_proto(tcg2, hash_log_extend_event, 0,
> -                                       load_addr, load_size, &evt->event_data);
> +                                       load_addr, load_size, &evt->event_data.tcg2_data);
>                 efi_bs_call(free_pool, evt);
>
>                 if (status != EFI_SUCCESS)
> diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
> index c04b82ea40f2..dae635cc3d4f 100644
> --- a/drivers/firmware/efi/libstub/efistub.h
> +++ b/drivers/firmware/efi/libstub/efistub.h
> @@ -843,14 +843,7 @@ struct efi_tcg2_event {
>         /* u8[] event follows here */
>  } __packed;
>
> -struct efi_tcg2_tagged_event {
> -       u32 tagged_event_id;
> -       u32 tagged_event_data_size;
> -       /* u8  tagged event data follows here */
> -} __packed;
> -
>  typedef struct efi_tcg2_event efi_tcg2_event_t;
> -typedef struct efi_tcg2_tagged_event efi_tcg2_tagged_event_t;
>  typedef union efi_tcg2_protocol efi_tcg2_protocol_t;
>
>  union efi_tcg2_protocol {
> --
> 2.44.0.278.ge034bb2e1d-goog
>

