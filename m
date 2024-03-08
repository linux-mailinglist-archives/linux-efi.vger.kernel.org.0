Return-Path: <linux-efi+bounces-785-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D1348760B2
	for <lists+linux-efi@lfdr.de>; Fri,  8 Mar 2024 10:12:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C661CB22560
	for <lists+linux-efi@lfdr.de>; Fri,  8 Mar 2024 09:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4D13524DE;
	Fri,  8 Mar 2024 09:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NhTEEh8k"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80BD8225CF
	for <linux-efi@vger.kernel.org>; Fri,  8 Mar 2024 09:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709889129; cv=none; b=gvflZi1WbBWZVj/UnNqu0yV7v+ihpmqkOyonyJXQSaico1o6/OqrOtJOsdjjQxSvKiAuXkYibCEgUbc/kyjUtynDmpzfo4MwhBb5hsklTNmeoX/gwHfnTpE5aMEOBlJt/epUy2wdZBM3J5rQagA4ncGyYr85fbFmJwIIaxi12Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709889129; c=relaxed/simple;
	bh=omqSw2GSG103LJJAA+UjzNTWLoW6uA75oL0kInd7eY4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 Cc:Content-Type; b=P56f+MUPgb3nB3tuDVYYvjFhew60c3pXoql2vbmtxCYyxgfSrGZs+TQxawr3xViNO3W/3g6+MMrfVroRb4HPsLAoRaC6uIHq1PMxkJSy3BGguDsI0N2b/76sJ5ZP5UkQADP6vsDr26tnqIMYcXHxAiJHP1NM2pNRPQe9dIVvf9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NhTEEh8k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35E28C43390
	for <linux-efi@vger.kernel.org>; Fri,  8 Mar 2024 09:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709889129;
	bh=omqSw2GSG103LJJAA+UjzNTWLoW6uA75oL0kInd7eY4=;
	h=References:In-Reply-To:From:Date:Subject:Cc:From;
	b=NhTEEh8kYGK9f9Lzc4df2dWm2DRpZ72ZHlWqYwbjQ9oNFwh1xaTMVlCgswsHJ6eec
	 HIrcr91bT+1ptrr8I8wfcyKTbuJupai27fih36Hb8UyLxCRcB3HavzfV+kSiq90jNn
	 /SqQhTjnUZVxPvCNk9nIq0+RitygH/IMgRHBmOYyQclF1m3VsODabaVNZ2oyxe3za+
	 UxXKleNI8A21d85dLJKL6NwEPSNAuZvJSCcks2Q6MXU72fJiYwv1Eg9IwRS6FeIAdD
	 A2Gz2u0EWNyOf+jtKwI/ZvKj17hNlZwOQK7IP6LeZxH7gWUeOLmbZemfs2rQCxSRxB
	 9YxbA6ksitleg==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-512f892500cso675962e87.3
        for <linux-efi@vger.kernel.org>; Fri, 08 Mar 2024 01:12:09 -0800 (PST)
X-Gm-Message-State: AOJu0YzGuoPBpasgwCrYpQr0N3d+gaIVUUD9+a5a4nMFrySHpgMO/Jlr
	CXafr5ly9qRLk5c3QAnaLzPVB9WZmq/wtUYf9EgqMvwrvrx1YDe77Vq/CbDncdUiRHRhC4knVsk
	d9wV+ycuKBrovvNM4/t+N3/Zb/JU=
X-Received: by 2002:ac2:4c45:0:b0:513:8c61:209f with SMTP id
 o5-20020ac24c45000000b005138c61209fmt1905710lfk.13.1709889126620; Fri, 08 Mar
 2024 01:12:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240308085754.476197-7-ardb+git@google.com> <20240308085754.476197-8-ardb+git@google.com>
In-Reply-To: <20240308085754.476197-8-ardb+git@google.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 8 Mar 2024 10:11:55 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFKM64BLtdJgQ8PttKh9gXn=hHEwo33D47yvu1uO8VJyg@mail.gmail.com>
Message-ID: <CAMj1kXFKM64BLtdJgQ8PttKh9gXn=hHEwo33D47yvu1uO8VJyg@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] efi/libstub: Use correct event size when measuring
 data into the TPM
Cc: linux-efi@vger.kernel.org, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 8 Mar 2024 at 09:58, Ard Biesheuvel <ardb+git@google.com> wrote:
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

OK, now this size is wrong - this should be 'sizeof(efi_tcg2_event_t) + size'


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

