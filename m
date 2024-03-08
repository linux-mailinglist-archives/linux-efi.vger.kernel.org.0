Return-Path: <linux-efi+bounces-786-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8CC8876109
	for <lists+linux-efi@lfdr.de>; Fri,  8 Mar 2024 10:38:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 604751F23F90
	for <lists+linux-efi@lfdr.de>; Fri,  8 Mar 2024 09:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E8C4535A2;
	Fri,  8 Mar 2024 09:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XYhvndEG"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302D23BBDB
	for <linux-efi@vger.kernel.org>; Fri,  8 Mar 2024 09:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709890706; cv=none; b=RkJJ9cb4laot0RKNr99JE3wC/VwxkFn06wF4uBABAHzkiqvOaOC6zvfzeyEAeaTwDeu5Y7tBbg1dX6ubKxMk64yP3ZYtBOtUbCCn/ej/i/GUefqRqFGx24NB4TE+C+zGK1zM20ACO0aw2RWH0tSTibM6V7mlHuJU0Cbz+5sruOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709890706; c=relaxed/simple;
	bh=+/HVAx3aKK8Z/+INSa5gD7EzyOVi+fKewvgVQBTWoWs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A8aNguuVeyeYSHn/fsuHoA4lGZyToOG+6WbmUhUeiBMd5Rez+OZm4cRXDKK22cLfys9GYNi/kEvAB4tPzqnm45/3MmZ/uyABJhmya8Zsgd/LR5iypBPDkU08XgVrzvT6aEB9YCMnBTr/StkHe2eU4ceq4/2nHg81soqx8qa9Sao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XYhvndEG; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d288bac3caso6834841fa.2
        for <linux-efi@vger.kernel.org>; Fri, 08 Mar 2024 01:38:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709890701; x=1710495501; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PKd/VhcFY53iCiP36pu/jje43uUTfQtnBk8HAmVkIUA=;
        b=XYhvndEGnjpSgBtLNZgmm65MYiVx8FL+C9KdgY97ip1KKafWvdtHWPvo4kKqTEsQJx
         /xYOPspv3Sd+UxzJER+IN5NRAXm1p6XOb3xQwM8SMvkOUCS4Bzx0lzOzgVIu4k6v2VqJ
         q0tNwkmw0q0urzSZ5m/GMOmcp7HTvVjypmjdeQMc2p1Ywox1As2r+a6ugg6Jl1X5L7MR
         mszm0+cMaj/52q4NcSr1MrGxeAa9mkSWOp7DH2KaN+umq6cicc+NddQKC9gxNCdTqXim
         L1suECLWNc4P/CUKIe6YZvPNK9T/X4RS3Pmhi//dWkt8GlaJm1xtudZtTICxuZ67BSUf
         bmOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709890701; x=1710495501;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PKd/VhcFY53iCiP36pu/jje43uUTfQtnBk8HAmVkIUA=;
        b=ViOwEZ+neqyHeuky8Ny9V+8xrOTdQAz4sRl+ORSqHynD9U3vxAxk+aWTCHSbk0/wE5
         TKhdRj9YGldaXqLI4qgyNNikxjDkzGcGQo462xakUWBmjdItEtk+Dj/zKIr6y047vxgO
         N8GlPhQIWKhMfIP43BqNMt4CzWFs7ziSc84xbwnVGeLVZ9VnJEg9pWbQQu0ANPQv2XRf
         iyT9oltQE51bP3oqwLDxbuMWv4V67zHzS1/QsRcuZ+yA76LTnQQDMTS/YjfRg3qZNDo7
         8Q43a/iTn9qJE5TgnO/Cdh7TPf7rC6G0+8dIR9KMVmbEQg5RrJ4o9hlN/ww4+oZtuzc+
         YaJQ==
X-Gm-Message-State: AOJu0YxfeS1B6KkVZAw7QnIPYdpu5LcwkW+/oVPL7xDazkAZrSQJFBRT
	W8L+3LdxUr+AXyLrvUwjo4X93VsV0RyPlSEOdtfVGXXImAo6cw1r9iiKzDKdT04zBgA38kLzwhj
	tHXxqq/7JBoFtLg3gwGV0amyLY76z1a2ywxGzeA==
X-Google-Smtp-Source: AGHT+IHTQWUAmjOIyhsrTVd8ec69tT/txYhV/PJyxsQds5F9A1hjt6Ug0zxxSF/hd1u7/jSEZwbrP+1SNsyYO2En9iQ=
X-Received: by 2002:a2e:8045:0:b0:2d2:2b2e:1680 with SMTP id
 p5-20020a2e8045000000b002d22b2e1680mr2849647ljg.35.1709890701258; Fri, 08 Mar
 2024 01:38:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240308085754.476197-7-ardb+git@google.com> <20240308085754.476197-8-ardb+git@google.com>
In-Reply-To: <20240308085754.476197-8-ardb+git@google.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 8 Mar 2024 11:37:45 +0200
Message-ID: <CAC_iWjJgV+wrgKUQsVYvCdvE5Qer2B-ieJC894b+wjKVhdDH8Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] efi/libstub: Use correct event size when measuring
 data into the TPM
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Ard

On Fri, 8 Mar 2024 at 10:58, Ard Biesheuvel <ardb+git@google.com> wrote:
>
> From: Ard Biesheuvel <ardb@kernel.org>
>
> Our efi_tcg2_tagged_event is not defined in the EFI spec, but it is not
> a local invention either: it was taken from the TCG PC Client spec,
> where it is called TCG_PCClientTaggedEvent.
>
> This spec also contains some guidance on how to populate it, which
> is not being followed closely at the moment; the event size should cover
> the TCG_PCClientTaggedEvent and its payload only, but it currently
> covers the preceding efi_tcg2_event too, and this may result in trailing
> garbage being measured into the TPM.

I think there's a confusion here and the current code we have is correct.
The EFI TCG spec [0] says that the tdEFI_TCG2_EVENT size is:
"Total size of the event including the Size component, the header and the
Event data." which obviously contradicts the definition of the tagged
event in the PC client spec.
But given the fact that TCG_PCClientTaggedEvent has its own size field
I think we should use what we already have.


[0] https://trustedcomputinggroup.org/wp-content/uploads/EFI-Protocol-Specification-rev13-160330final.pdf
page 33

Cheers
/Ilias

>
> So rename the struct and document its provenance, and fix up the use so
> only the tagged event data is represented in the size field.
>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  drivers/firmware/efi/libstub/efi-stub-helper.c | 20 +++++++++++---------
>  drivers/firmware/efi/libstub/efistub.h         | 12 ++++++------
>  2 files changed, 17 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
> index bfa30625f5d0..16843ab9b64d 100644
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
> @@ -219,23 +220,24 @@ static const struct {
>         },
>  };
>
> +struct efistub_measured_event {
> +       efi_tcg2_event_t        event_data;
> +       TCG_PCClientTaggedEvent tagged_event;
> +} __packed;
> +
>  static efi_status_t efi_measure_tagged_event(unsigned long load_addr,
>                                              unsigned long load_size,
>                                              enum efistub_event event)
>  {
> +       struct efistub_measured_event *evt;
> +       int size = struct_size(&evt->tagged_event, tagged_event_data,
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
> @@ -249,12 +251,12 @@ static efi_status_t efi_measure_tagged_event(unsigned long load_addr,
>                         .event_header.event_type        = EV_EVENT_TAG,
>                 };
>
> -               evt->tagged_event = (struct efi_tcg2_tagged_event){
> +               evt->tagged_event = (TCG_PCClientTaggedEvent){
>                         .tagged_event_id                = events[event].event_id,
>                         .tagged_event_data_size         = events[event].event_data_len,
>                 };
>
> -               memcpy(evt->tagged_event_data, events[event].event_data,
> +               memcpy(evt->tagged_event.tagged_event_data, events[event].event_data,
>                        events[event].event_data_len);
>
>                 status = efi_call_proto(tcg2, hash_log_extend_event, 0,
> diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
> index c04b82ea40f2..043a3ff435f3 100644
> --- a/drivers/firmware/efi/libstub/efistub.h
> +++ b/drivers/firmware/efi/libstub/efistub.h
> @@ -843,14 +843,14 @@ struct efi_tcg2_event {
>         /* u8[] event follows here */
>  } __packed;
>
> -struct efi_tcg2_tagged_event {
> -       u32 tagged_event_id;
> -       u32 tagged_event_data_size;
> -       /* u8  tagged event data follows here */
> -} __packed;
> +/* from TCG PC Client Platform Firmware Profile Specification */
> +typedef struct tdTCG_PCClientTaggedEvent {
> +       u32     tagged_event_id;
> +       u32     tagged_event_data_size;
> +       u8      tagged_event_data[];
> +} TCG_PCClientTaggedEvent;
>
>  typedef struct efi_tcg2_event efi_tcg2_event_t;
> -typedef struct efi_tcg2_tagged_event efi_tcg2_tagged_event_t;
>  typedef union efi_tcg2_protocol efi_tcg2_protocol_t;
>
>  union efi_tcg2_protocol {
> --
> 2.44.0.278.ge034bb2e1d-goog
>

