Return-Path: <linux-efi+bounces-718-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 43AEE871824
	for <lists+linux-efi@lfdr.de>; Tue,  5 Mar 2024 09:22:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59F7FB22291
	for <lists+linux-efi@lfdr.de>; Tue,  5 Mar 2024 08:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22E1A7EEF8;
	Tue,  5 Mar 2024 08:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n95tLUbq"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F4979F2
	for <linux-efi@vger.kernel.org>; Tue,  5 Mar 2024 08:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709626912; cv=none; b=R8U2/OqYn1SvMoO+uO645JKq25ZcX8mm4NIjX99/5rAxRB8TKImlZy9+A9yBX0CoULVAHTVfQDyW3qMPyeHcLHG/XOK5v+dsVNb8F4xo2G/PrMjY0vcyD+t0kF5OtyY8NTPTqyjz6aHj/ar6A3Qz4RstUo7DmMRjCqOz3dbzQv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709626912; c=relaxed/simple;
	bh=Y/6nn94d3QeieZsIKxU/xFnBhgJ/IZQ0mHIKnSG6opw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mwfsHaByMoZxrE1ZC8ey1cTk5W4QSqVDm+W867Uw3zBRmN8FQr/N+Rzl5ZvKp41BPdQMe56XURD0zqHfqIcqYAiErbe5fIayBt9mrMtgqoPcFuxO4GdSIdMw6ym0GXHH/VGBUGlXhxj4dXxXpnLqMXcYulmH19hOBGEb9ZCKbkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n95tLUbq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C7FBC43394
	for <linux-efi@vger.kernel.org>; Tue,  5 Mar 2024 08:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709626911;
	bh=Y/6nn94d3QeieZsIKxU/xFnBhgJ/IZQ0mHIKnSG6opw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=n95tLUbqsCECei1Zl6iUgKGgPtqc1Jhwx4sKk3ZaH4Sf6LXn3o1PmXVzrDcsCXYb7
	 CA2jHZj2LGWuSHBsZBlGoMacNDG6e7i0w+TGbz/pJzGdjxGqA76h6ueVuehbCM1cPR
	 2KfvnrUFCKgVRPnPOtdOq0wJkSQpSuV1y4xkGxJnZtBO625HM6YGvQM4Z2VpiOJdI/
	 YPfgMggWdt5+kMcWMU03Wz96kAcuoJsjqlA6nzzmWee/tpT832FByaLB2j0eFd3jYW
	 tjTHnn+x8q84y67xEHG20W9wI4PJswFZi0Qu7ItriJx32i6CeL+OC8Olh7F2ckQff7
	 87PLCiZEITS1g==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2d208be133bso73717071fa.2
        for <linux-efi@vger.kernel.org>; Tue, 05 Mar 2024 00:21:51 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXjT+v72DgJh/cIPz/K/klioaBWnY5Yi4uLpVMNTQTdXeHHNuZ2Rmf0FcQKDIVaMyCCdZhmsCYsPHYuQJMuFliuc4/lytq+d9hz
X-Gm-Message-State: AOJu0Yzdbu5AnokyG+MT5gaqjXoi2QyXvB/S0HsDt9QdPG2rkt6fDmIj
	t4U3oHLu3uOZR53+CZPO1u94rrhtnEikssGgMuWlifnBxJR2gSra6T+8SX1andaPlIxhPzhvSfz
	uO1alLlwygyyYCLcywY6RTBbECQs=
X-Google-Smtp-Source: AGHT+IEaVxzgRGURkdrBjpQwL2DGh+pOdk79u64Tt7VwMZwT5mOvXLBt1taAK0nL6iwA4pea6Yz1CQViDTKcb8f/+Iw=
X-Received: by 2002:a05:6512:3d0f:b0:512:d655:9d4b with SMTP id
 d15-20020a0565123d0f00b00512d6559d4bmr1022701lfv.5.1709626909554; Tue, 05 Mar
 2024 00:21:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240304104409.2326422-6-ardb+git@google.com> <20240304104409.2326422-7-ardb+git@google.com>
 <8a0cdc16-c300-44ed-af8c-559bbe7aa95b@linux.intel.com>
In-Reply-To: <8a0cdc16-c300-44ed-af8c-559bbe7aa95b@linux.intel.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 5 Mar 2024 09:21:38 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHvzS6w8gmaSHiu13__uP95AUJxMXBVnOGFB6Tt1+ocfA@mail.gmail.com>
Message-ID: <CAMj1kXHvzS6w8gmaSHiu13__uP95AUJxMXBVnOGFB6Tt1+ocfA@mail.gmail.com>
Subject: Re: [PATCH 1/4] efi/libstub: Fold efi_tcg2_tagged_event into efi_measured_event
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-efi@vger.kernel.org, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 5 Mar 2024 at 05:30, Kuppuswamy Sathyanarayanan
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>
>
> On 3/4/24 2:44 AM, Ard Biesheuvel wrote:
> > From: Ard Biesheuvel <ardb@kernel.org>
> >
> > In spite of the efi_ prefix, struct efi_tcg2_tagged_event is specific to
> > the EFI stub, and so we can tweak it to our liking if needed, e.g., to
> > accommodate the TDX variant of the TCG2 measurement protocol.
> >
> > In preparation for that, get rid of it entirely, and combine it with the
> > efi_measured_event struct used by the measurement code.
> >
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> >  drivers/firmware/efi/libstub/efi-stub-helper.c | 26 ++++++++------------
> >  drivers/firmware/efi/libstub/efistub.h         | 18 ++++++++------
> >  2 files changed, 21 insertions(+), 23 deletions(-)
> >
> > diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
> > index bfa30625f5d0..0dbc9d3f4abd 100644
> > --- a/drivers/firmware/efi/libstub/efi-stub-helper.c
> > +++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
> > @@ -193,7 +193,7 @@ void efi_apply_loadoptions_quirk(const void **load_options, u32 *load_options_si
> >       *load_options_size = load_option_unpacked.optional_data_size;
> >  }
> >
> > -enum efistub_event {
> > +enum efistub_event_type {
> >       EFISTUB_EVT_INITRD,
> >       EFISTUB_EVT_LOAD_OPTIONS,
> >       EFISTUB_EVT_COUNT,
> > @@ -221,44 +221,38 @@ static const struct {
> >
> >  static efi_status_t efi_measure_tagged_event(unsigned long load_addr,
> >                                            unsigned long load_size,
> > -                                          enum efistub_event event)
> > +                                          enum efistub_event_type event)
> >  {
> > +     struct efistub_measured_event *evt;
> > +     int size = struct_size(evt, tagged_event_data,
> > +                            events[event].event_data_len);
>
> Include linux/overflow.h explicitly?
>

Yes, good point.

> >       efi_guid_t tcg2_guid = EFI_TCG2_PROTOCOL_GUID;
> >       efi_tcg2_protocol_t *tcg2 = NULL;
> >       efi_status_t status;
> >
> >       efi_bs_call(locate_protocol, &tcg2_guid, NULL, (void **)&tcg2);
> >       if (tcg2) {
> > -             struct efi_measured_event {
> > -                     efi_tcg2_event_t        event_data;
> > -                     efi_tcg2_tagged_event_t tagged_event;
> > -                     u8                      tagged_event_data[];
> > -             } *evt;
> > -             int size = sizeof(*evt) + events[event].event_data_len;
> > -
> >               status = efi_bs_call(allocate_pool, EFI_LOADER_DATA, size,
> >                                    (void **)&evt);
>
> It looks like in patch 3 you have converted evt as stack variable. Since that
> change is not specific to CC fallback, can it be moved here?
>

Not sure what you mean here. evt is still there after parch #3

> >               if (status != EFI_SUCCESS)
> >                       goto fail;
> >
> > -             evt->event_data = (struct efi_tcg2_event){
> > +             evt->event_data.tcg2_data = (struct efi_tcg2_event){
> >                       .event_size                     = size,
> > -                     .event_header.header_size       = sizeof(evt->event_data.event_header),
> > +                     .event_header.header_size       = sizeof(evt->event_data.tcg2_data.event_header),
> >                       .event_header.header_version    = EFI_TCG2_EVENT_HEADER_VERSION,
> >                       .event_header.pcr_index         = events[event].pcr_index,
> >                       .event_header.event_type        = EV_EVENT_TAG,
> >               };
> >
> > -             evt->tagged_event = (struct efi_tcg2_tagged_event){
> > -                     .tagged_event_id                = events[event].event_id,
> > -                     .tagged_event_data_size         = events[event].event_data_len,
> > -             };
> > +             evt->tagged_event_id            = events[event].event_id;
> > +             evt->tagged_event_data_size     = events[event].event_data_len;
> >
> >               memcpy(evt->tagged_event_data, events[event].event_data,
> >                      events[event].event_data_len);
> >
> >               status = efi_call_proto(tcg2, hash_log_extend_event, 0,
> > -                                     load_addr, load_size, &evt->event_data);
> > +                                     load_addr, load_size, &evt->event_data.tcg2_data);
> >               efi_bs_call(free_pool, evt);
> >
> >               if (status != EFI_SUCCESS)
> > diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
> > index c04b82ea40f2..b2c50dce48b8 100644
> > --- a/drivers/firmware/efi/libstub/efistub.h
> > +++ b/drivers/firmware/efi/libstub/efistub.h
> > @@ -843,14 +843,7 @@ struct efi_tcg2_event {
> >       /* u8[] event follows here */
> >  } __packed;
> >
> > -struct efi_tcg2_tagged_event {
> > -     u32 tagged_event_id;
> > -     u32 tagged_event_data_size;
> > -     /* u8  tagged event data follows here */
> > -} __packed;
> > -
> >  typedef struct efi_tcg2_event efi_tcg2_event_t;
> > -typedef struct efi_tcg2_tagged_event efi_tcg2_tagged_event_t;
> >  typedef union efi_tcg2_protocol efi_tcg2_protocol_t;
> >
> >  union efi_tcg2_protocol {
> > @@ -882,6 +875,17 @@ union efi_tcg2_protocol {
> >       } mixed_mode;
> >  };
> >
> > +union efistub_event {
> > +     efi_tcg2_event_t        tcg2_data;
> > +};
> > +
> > +struct efistub_measured_event {
> > +     union efistub_event     event_data;
> > +     u32                     tagged_event_id;
> > +     u32                     tagged_event_data_size;
> > +     u8                      tagged_event_data[];
> > +} __packed;
> > +
>
> Since efistub_measured_event is only used efi-stub-helper.c, why
> not leave it there?
>

Indeed. I will move it back.

