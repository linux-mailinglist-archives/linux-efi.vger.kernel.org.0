Return-Path: <linux-efi+bounces-722-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3120887261A
	for <lists+linux-efi@lfdr.de>; Tue,  5 Mar 2024 19:00:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A770C1F22516
	for <lists+linux-efi@lfdr.de>; Tue,  5 Mar 2024 18:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C176817BAF;
	Tue,  5 Mar 2024 18:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m3UDkspj"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79E317BB6
	for <linux-efi@vger.kernel.org>; Tue,  5 Mar 2024 18:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709661632; cv=none; b=hVSY/L8gm/gMbcIuqsyF55b8cdf6e6uEhDV46Y0w4OH8Xvk7C0DqCPOjdQGyA40ZHdFJJqRalZdeR8ZwXKjRP70ViYSKIALXzROWuG8QcNjKvCh03VWvvQOZiQEFHFnFjnE37J1AcpbGchyG1XGe+FKbiJqyai2L3tnrS4RCrq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709661632; c=relaxed/simple;
	bh=8offz3t8vD+U80+CNBdBgKyhsSwaSSpEu84RkOxPT3o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i2IKzC8yh6fqH/0Mziwl4xqy2OakUllmbgtBIKJ8YcjlLWptAZiF/UHHYhXGPix4fzWcEwSS0R5bsZyh9cYQJ6yT0BRTEKPigcVnUKplN3O55Cbs1EP++ufo5cdKfh/9zVDWF8ZAHXYPka8dPoYAs4GOHjDJKhVuJZPRcw8oEaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m3UDkspj; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5654ef0c61fso544a12.0
        for <linux-efi@vger.kernel.org>; Tue, 05 Mar 2024 10:00:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709661629; x=1710266429; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kpsx8YbLeN/7ZLKV0d9UvV1Gs5VqN1KuCee+AuaEDCw=;
        b=m3UDkspjrq69Jk54OWll/6tgVRlqHKzeubm9HI7HEDVkK2Xlv1s0SB1BVoizzoLCHC
         Cbpu+aXte5RbqCYEDw2gdXnOL2I2hbidvgE8mBeVEl/GZWZDzdppDp/SwqJA5A5KH9eE
         ChUJZYs4RZpLlqMsarFCC1LgbWT4L+agoRM172hXfts0nmW3rl5gJcUt1sXY3ZHIWKPN
         HmENzJ0qL6zFKj8x75MpLDQGVg+cR6etuIHmSdi3wBhEHScxkN0d3Ski7Dywiu7SrTR/
         cWgsnn4FQeGoL7thLsnRLa4u+aVzZXbT7xSutk3gS+P3dXv6GKgVnuc+R9iZYa+MhsCu
         QEAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709661629; x=1710266429;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kpsx8YbLeN/7ZLKV0d9UvV1Gs5VqN1KuCee+AuaEDCw=;
        b=D01UbRTzHLNtUoIzIxjE7kS0UHkLznGy7KPanu2IGvxAdErVVOyIQn7sGaDpJCVixV
         6FQRe+yOyP2WTxicNDPfyUwxjVwQbCeh61IkzTZezcnv82fPvG913n3s1u+rII8BKen3
         1P9U98eVK1R3pO5rP8RlufTAyKtwoPukze8Zc/vI4xSA84UdFObjQmrxzqwGPcCyqp/G
         WbyIXkA4p9WD/9HDjSU6LwUpkOXlR0WOv/rphHCRgKCAE8EfWIXj+1Vzh1z8rPx3Vxhn
         u7kQeOP3Po55FYWuy6k6o0SCtvLEIvr3Iu5+YiYcwuD15RBkmoaNI9QI4b+40ml0y7I8
         lJsA==
X-Forwarded-Encrypted: i=1; AJvYcCUfT9PFdgHQPONpW7zP+grM/pdh7AQhYFt2WMmWdZyuq3kssjiAeleQqMobpLlXEvqEWDBjehbbcAYMCh1ssoiftGhhGDCDXMxV
X-Gm-Message-State: AOJu0YzyBdHCVTdoWS3Vn1auShCl5T5sosvVvmiVtMtO5KktQzd6NUdq
	dAsSk4Ca/cGMve4DFF1NRl3jqkWfm99g9Ip8baL4PcoIk+JHIaJcptVJdGkyUJhJDet1bxWJW7j
	/rvZPydRvUxXJBCLDo5pCCiQ7KpjoFEaHbLUp5fvo6AvSjOUWGg==
X-Google-Smtp-Source: AGHT+IGS4P3wPBZb5xYmQSnRSEMhuj9H7wN+yGcLkvVOdrFrBIsdExV0nXNwkjB7Wk1kfy6PxbK5viKMhSIC5E4CE/E=
X-Received: by 2002:a05:6402:22c4:b0:567:3840:15be with SMTP id
 dm4-20020a05640222c400b00567384015bemr150413edb.1.1709661628610; Tue, 05 Mar
 2024 10:00:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240304104409.2326422-6-ardb+git@google.com> <20240304104409.2326422-9-ardb+git@google.com>
 <CAAH4kHYD03xepd=u9m66XWY=UHkOdooGj7jKPnu9DvA=LPAfXg@mail.gmail.com> <CAMj1kXEyWkDaENDOk5zrkZv+5=FwbXgQekoVHP2OqscrM5x=og@mail.gmail.com>
In-Reply-To: <CAMj1kXEyWkDaENDOk5zrkZv+5=FwbXgQekoVHP2OqscrM5x=og@mail.gmail.com>
From: Dionna Amalie Glaze <dionnaglaze@google.com>
Date: Tue, 5 Mar 2024 10:00:17 -0800
Message-ID: <CAAH4kHb7ZgfrQQjVr-JiutQthwkbrVGR2DkUDE=E0ZoWGO34eA@mail.gmail.com>
Subject: Re: [PATCH 3/4] efi/libstub: Measure into CC protocol if TCG2
 protocol is absent
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Qinkun Bao <qinkun@google.com>, linux-efi@vger.kernel.org, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 5, 2024 at 9:47=E2=80=AFAM Ard Biesheuvel <ardb@kernel.org> wro=
te:
>
> On Tue, 5 Mar 2024 at 18:34, Dionna Amalie Glaze <dionnaglaze@google.com>=
 wrote:
> >
> > On Mon, Mar 4, 2024 at 2:44=E2=80=AFAM Ard Biesheuvel <ardb+git@google.=
com> wrote:
> > >
> > > From: Ard Biesheuvel <ardb@kernel.org>
> > >
> > > To accommodate confidential compute VMs that expose the simplified CC
> > > measurement protocol instead of the full-blown TCG2 one, fall back to
> > > the former if the latter does not exist.
> > >
> > > The CC protocol was designed to be used in this manner, which is why =
the
> > > types and prototypes have been kept the same where possible. So reuse
> > > the existing code, and only deviate from the TCG2 code path where
> > > needed.
> > >
> > > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > > ---
> > >  drivers/firmware/efi/libstub/efi-stub-helper.c | 67 +++++++++++++++-=
----
> > >  drivers/firmware/efi/libstub/efistub.h         |  3 +
> > >  2 files changed, 53 insertions(+), 17 deletions(-)
> > >
> > > diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers=
/firmware/efi/libstub/efi-stub-helper.c
> > > index 0dbc9d3f4abd..21f4567324f6 100644
> > > --- a/drivers/firmware/efi/libstub/efi-stub-helper.c
> > > +++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
> > > @@ -223,44 +223,77 @@ static efi_status_t efi_measure_tagged_event(un=
signed long load_addr,
> > >                                              unsigned long load_size,
> > >                                              enum efistub_event_type =
event)
> > >  {
> > > +       union {
> > > +               efi_status_t
> > > +               (__efiapi *hash_log_extend_event)(void *, u64, efi_ph=
ysical_addr_t,
> > > +                                                 u64, const union ef=
istub_event *);
> > > +               struct { u32 hash_log_extend_event; } mixed_mode;
> > > +       } method;
> > >         struct efistub_measured_event *evt;
> > >         int size =3D struct_size(evt, tagged_event_data,
> > >                                events[event].event_data_len);
> > >         efi_guid_t tcg2_guid =3D EFI_TCG2_PROTOCOL_GUID;
> > >         efi_tcg2_protocol_t *tcg2 =3D NULL;
> > > +       union efistub_event ev;
> > >         efi_status_t status;
> > > +       void *protocol;
> > >
> > >         efi_bs_call(locate_protocol, &tcg2_guid, NULL, (void **)&tcg2=
);
> > >         if (tcg2) {
> > > -               status =3D efi_bs_call(allocate_pool, EFI_LOADER_DATA=
, size,
> > > -                                    (void **)&evt);
> > > -               if (status !=3D EFI_SUCCESS)
> > > -                       goto fail;
> > > -
> > > -               evt->event_data.tcg2_data =3D (struct efi_tcg2_event)=
{
> > > +               ev.tcg2_data =3D (struct efi_tcg2_event){
> > >                         .event_size                     =3D size,
> > > -                       .event_header.header_size       =3D sizeof(ev=
t->event_data.tcg2_data.event_header),
> > > +                       .event_header.header_size       =3D sizeof(ev=
.tcg2_data.event_header),
> > >                         .event_header.header_version    =3D EFI_TCG2_=
EVENT_HEADER_VERSION,
> > >                         .event_header.pcr_index         =3D events[ev=
ent].pcr_index,
> > >                         .event_header.event_type        =3D EV_EVENT_=
TAG,
> > >                 };
> > > +               protocol =3D tcg2;
> > > +               method.hash_log_extend_event =3D
> > > +                       (void *)efi_table_attr(tcg2, hash_log_extend_=
event);
> > > +       } else {
> >
> > +Qinkun Bao
> > Given that the exclusive or between CC_MEASUREMENT_PROTOCOL and the
> > TCG protocol breaks backwards compatibility, it'd be preferable to
> > measure into all the measurement protocols that are present.
>
> How so? Older kernels will use TCG2 if it exists, and so will new
> kernels. The only difference is that on new kernels, the CC protocol
> will be used in case TCG2 is not implemented.
>
> So the only affected scenario here is a system that today implements
> TCG but not CC, and intends to implement CC later and receive
> measurements into both protocols. Does that really qualify as backward
> compatibility? I'd rather not accommodate future systems that
> implement something that the UEFI spec says they should not.
>
> > The UEFI
> > v2.10 standard says that firmware "should not" provide both, but it is
> > not MUST NOT. Given this and our desire to provide service continuity,
> > I ask that you remove the "else" guard.
> >
>
> Ignoring the newer protocol if the established one exists is an
> excellent way of making sure this does not happen.
>

The problem is that the protocols are not equivalent, and we disagree
with the standard's claim of "should not" to the point that we're
taking it to the USWG. The "should not" advisement is predicated on
not trusting boot layers to use both protocols when they're both
present, such that you could accidentally miss measuring a
security-critical event. That's a strawman though, since you already
need to develop trust in those boot layers. We have software supply
chain endorsements for tracking that kind of property for use in
attestation verification.

The CC protocol is useful for hardware-rooted boot measurement, but it
does nothing about the rest of TPM 2.0. There are plenty of users that
want to use a vTPM that's hosted by the VMM but also get an extra
integrity assurance that measurements into TDX RTMRs and attested by
an Intel-rooted key pass an extra level of scrutiny.


>
> > > +               efi_guid_t cc_guid =3D EFI_CC_MEASUREMENT_PROTOCOL_GU=
ID;
> > > +               efi_cc_protocol_t *cc =3D NULL;
> > >
> > > -               evt->tagged_event_id            =3D events[event].eve=
nt_id;
> > > -               evt->tagged_event_data_size     =3D events[event].eve=
nt_data_len;
> > > -
> > > -               memcpy(evt->tagged_event_data, events[event].event_da=
ta,
> > > -                      events[event].event_data_len);
> > > +               efi_bs_call(locate_protocol, &cc_guid, NULL, (void **=
)&cc);
> > > +               if (!cc)
> > > +                       return EFI_UNSUPPORTED;
> > >
> > > -               status =3D efi_call_proto(tcg2, hash_log_extend_event=
, 0,
> > > -                                       load_addr, load_size, &evt->e=
vent_data.tcg2_data);
> > > -               efi_bs_call(free_pool, evt);
> > > +               ev.cc_data =3D (struct efi_cc_event){
> > > +                       .event_size                     =3D size,
> > > +                       .event_header.header_size       =3D sizeof(ev=
.cc_data.event_header),
> > > +                       .event_header.header_version    =3D EFI_CC_EV=
ENT_HEADER_VERSION,
> > > +                       .event_header.event_type        =3D EV_EVENT_=
TAG,
> > > +               };
> > >
> > > +               status =3D efi_call_proto(cc, map_pcr_to_mr_index,
> > > +                                       events[event].pcr_index,
> > > +                                       &ev.cc_data.event_header.mr_i=
ndex);
> > >                 if (status !=3D EFI_SUCCESS)
> > >                         goto fail;
> > > -               return EFI_SUCCESS;
> > > +
> > > +               protocol =3D cc;
> > > +               method.hash_log_extend_event =3D
> > > +                       (void *)efi_table_attr(cc, hash_log_extend_ev=
ent);
> > >         }
> > >
> > > -       return EFI_UNSUPPORTED;
> > > +       status =3D efi_bs_call(allocate_pool, EFI_LOADER_DATA, size, =
(void **)&evt);
> > > +       if (status !=3D EFI_SUCCESS)
> > > +               goto fail;
> > > +
> > > +       evt->event_data                 =3D ev;
> > > +       evt->tagged_event_id            =3D events[event].event_id;
> > > +       evt->tagged_event_data_size     =3D events[event].event_data_=
len;
> > > +
> > > +       memcpy(evt->tagged_event_data, events[event].event_data,
> > > +              events[event].event_data_len);
> > > +
> > > +       status =3D efi_fn_call(&method, hash_log_extend_event, protoc=
ol, 0,
> > > +                            load_addr, load_size, &evt->event_data);
> > > +       efi_bs_call(free_pool, evt);
> > > +
> > > +       if (status =3D=3D EFI_SUCCESS)
> > > +               return EFI_SUCCESS;
> > > +
> > >  fail:
> > >         efi_warn("Failed to measure data for event %d: 0x%lx\n", even=
t, status);
> > >         return status;
> > > diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmwar=
e/efi/libstub/efistub.h
> > > index d621bfb719c4..4bf9a76796b7 100644
> > > --- a/drivers/firmware/efi/libstub/efistub.h
> > > +++ b/drivers/firmware/efi/libstub/efistub.h
> > > @@ -954,8 +954,11 @@ union efi_cc_protocol {
> > >         } mixed_mode;
> > >  };
> > >
> > > +static_assert(sizeof(efi_tcg2_event_t) =3D=3D sizeof(efi_cc_event_t)=
);
> > > +
> > >  union efistub_event {
> > >         efi_tcg2_event_t        tcg2_data;
> > > +       efi_cc_event_t          cc_data;
> > >  };
> > >
> > >  struct efistub_measured_event {
> > > --
> > > 2.44.0.278.ge034bb2e1d-goog
> > >
> > >
> >
> >
> > --
> > -Dionna Glaze, PhD (she/her)



--=20
-Dionna Glaze, PhD (she/her)

