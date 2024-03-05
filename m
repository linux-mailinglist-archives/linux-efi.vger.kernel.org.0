Return-Path: <linux-efi+bounces-720-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6F318725E6
	for <lists+linux-efi@lfdr.de>; Tue,  5 Mar 2024 18:47:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17B471C2171E
	for <lists+linux-efi@lfdr.de>; Tue,  5 Mar 2024 17:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4D3717565;
	Tue,  5 Mar 2024 17:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gjmsdsRV"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E6617555
	for <linux-efi@vger.kernel.org>; Tue,  5 Mar 2024 17:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709660850; cv=none; b=VhxgXbkSRZvbAl4XqWAuGYm6KTj+nXyY3wlgY0c65enBsTL2Zj1KTTkx0IYENxz0fymz0yWwfF6Uf0mxG86KryuCDkgxxY8EElfVVmKIKwCh1HorWrmL+vr5TtboBnJq2em8+34Sg3fevhdXoVBku2JyqVFpCcUvOZkkXpMVgbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709660850; c=relaxed/simple;
	bh=SNzDbfTp+2+tLDk8+TWluodBpqVcAsel7i2az1OMsZM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vCMlX+mb0Xc/ysdtIfI/ul3sOj2NHt+q28JA6bexCHHcJ2qT2s//Wi34VqV8gs765RAdy8VEHdvZQoh2Ymz2fhFtOdmSiL3kUm6TYY3X3hIvcQUyCHErsHXRMdJtxAANXxlcZOZcawdw0tN9Yjn3m0elOPZ6K2s50Zuaf1mB7UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gjmsdsRV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CABFC433C7
	for <linux-efi@vger.kernel.org>; Tue,  5 Mar 2024 17:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709660850;
	bh=SNzDbfTp+2+tLDk8+TWluodBpqVcAsel7i2az1OMsZM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=gjmsdsRVNqsBbQ+oFYvYGvru3AtsjKllOTCeoqc2qOM+QxrJAOEAAQrX27DKM1Gvl
	 WfkTp08u4fnrLGmow2S6RqPxd+s9WnE+lWT7ip0iRBPIjUMeLMFITjqaFf7/sNGbgc
	 NtqnYoBLIvD+j5+IGITcj9iooQ+ZtfPH16eDUFLKObiIVEpapBL3HTi725JKudzc19
	 iC0I59GZ+DJSbXOts/pCvD0ac11q4uZheJ2RThp2lrzAduOaD99d/h1/DAtSMRoq97
	 oNeTSwHNg+ej1iRiCO07QAiUId7iDY6TmzGpbrgWV4fPYmwlqZGs6zmdQ5ixjVcTkN
	 TGdoqmjNRGr4g==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5135486cfccso1173563e87.0
        for <linux-efi@vger.kernel.org>; Tue, 05 Mar 2024 09:47:29 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVMPBM9A/sfsnQvSOp/Pz+tmN+eVlYV8Dnsxv9fmkzcgqzep2AateyHpi8F9FE/mvrmELHHkI945qKDLm7fCgtLCI+ArQA39HQm
X-Gm-Message-State: AOJu0Yy55sf5x3A8sxHVzJmeaVLtyJzXDDSTbVsFHVDdLxSaLGKbcwWf
	tcxhRRpS8pFej7VJZZXOr3Mg9Mrl+b8NH8wFECyyI3ij5yrXjPzFonR/HsoIuwIv+9ISlXdOnUf
	LkY5HS6UJM3nrp7Ni0OwBhKZSIXw=
X-Google-Smtp-Source: AGHT+IFzj1g+RMg/LDZy/nxmul/6G6Rfo14N8+tcUOEloXKOASWfqC7DfLSqJO3lHo6iJd7E3hEb2HP4TCgbQkx0OXo=
X-Received: by 2002:ac2:5a1e:0:b0:512:fc30:51e7 with SMTP id
 q30-20020ac25a1e000000b00512fc3051e7mr1639976lfn.16.1709660848126; Tue, 05
 Mar 2024 09:47:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240304104409.2326422-6-ardb+git@google.com> <20240304104409.2326422-9-ardb+git@google.com>
 <CAAH4kHYD03xepd=u9m66XWY=UHkOdooGj7jKPnu9DvA=LPAfXg@mail.gmail.com>
In-Reply-To: <CAAH4kHYD03xepd=u9m66XWY=UHkOdooGj7jKPnu9DvA=LPAfXg@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 5 Mar 2024 18:47:16 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEyWkDaENDOk5zrkZv+5=FwbXgQekoVHP2OqscrM5x=og@mail.gmail.com>
Message-ID: <CAMj1kXEyWkDaENDOk5zrkZv+5=FwbXgQekoVHP2OqscrM5x=og@mail.gmail.com>
Subject: Re: [PATCH 3/4] efi/libstub: Measure into CC protocol if TCG2
 protocol is absent
To: Dionna Amalie Glaze <dionnaglaze@google.com>
Cc: Qinkun Bao <qinkun@google.com>, linux-efi@vger.kernel.org, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 5 Mar 2024 at 18:34, Dionna Amalie Glaze <dionnaglaze@google.com> w=
rote:
>
> On Mon, Mar 4, 2024 at 2:44=E2=80=AFAM Ard Biesheuvel <ardb+git@google.co=
m> wrote:
> >
> > From: Ard Biesheuvel <ardb@kernel.org>
> >
> > To accommodate confidential compute VMs that expose the simplified CC
> > measurement protocol instead of the full-blown TCG2 one, fall back to
> > the former if the latter does not exist.
> >
> > The CC protocol was designed to be used in this manner, which is why th=
e
> > types and prototypes have been kept the same where possible. So reuse
> > the existing code, and only deviate from the TCG2 code path where
> > needed.
> >
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> >  drivers/firmware/efi/libstub/efi-stub-helper.c | 67 +++++++++++++++---=
--
> >  drivers/firmware/efi/libstub/efistub.h         |  3 +
> >  2 files changed, 53 insertions(+), 17 deletions(-)
> >
> > diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/f=
irmware/efi/libstub/efi-stub-helper.c
> > index 0dbc9d3f4abd..21f4567324f6 100644
> > --- a/drivers/firmware/efi/libstub/efi-stub-helper.c
> > +++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
> > @@ -223,44 +223,77 @@ static efi_status_t efi_measure_tagged_event(unsi=
gned long load_addr,
> >                                              unsigned long load_size,
> >                                              enum efistub_event_type ev=
ent)
> >  {
> > +       union {
> > +               efi_status_t
> > +               (__efiapi *hash_log_extend_event)(void *, u64, efi_phys=
ical_addr_t,
> > +                                                 u64, const union efis=
tub_event *);
> > +               struct { u32 hash_log_extend_event; } mixed_mode;
> > +       } method;
> >         struct efistub_measured_event *evt;
> >         int size =3D struct_size(evt, tagged_event_data,
> >                                events[event].event_data_len);
> >         efi_guid_t tcg2_guid =3D EFI_TCG2_PROTOCOL_GUID;
> >         efi_tcg2_protocol_t *tcg2 =3D NULL;
> > +       union efistub_event ev;
> >         efi_status_t status;
> > +       void *protocol;
> >
> >         efi_bs_call(locate_protocol, &tcg2_guid, NULL, (void **)&tcg2);
> >         if (tcg2) {
> > -               status =3D efi_bs_call(allocate_pool, EFI_LOADER_DATA, =
size,
> > -                                    (void **)&evt);
> > -               if (status !=3D EFI_SUCCESS)
> > -                       goto fail;
> > -
> > -               evt->event_data.tcg2_data =3D (struct efi_tcg2_event){
> > +               ev.tcg2_data =3D (struct efi_tcg2_event){
> >                         .event_size                     =3D size,
> > -                       .event_header.header_size       =3D sizeof(evt-=
>event_data.tcg2_data.event_header),
> > +                       .event_header.header_size       =3D sizeof(ev.t=
cg2_data.event_header),
> >                         .event_header.header_version    =3D EFI_TCG2_EV=
ENT_HEADER_VERSION,
> >                         .event_header.pcr_index         =3D events[even=
t].pcr_index,
> >                         .event_header.event_type        =3D EV_EVENT_TA=
G,
> >                 };
> > +               protocol =3D tcg2;
> > +               method.hash_log_extend_event =3D
> > +                       (void *)efi_table_attr(tcg2, hash_log_extend_ev=
ent);
> > +       } else {
>
> +Qinkun Bao
> Given that the exclusive or between CC_MEASUREMENT_PROTOCOL and the
> TCG protocol breaks backwards compatibility, it'd be preferable to
> measure into all the measurement protocols that are present.

How so? Older kernels will use TCG2 if it exists, and so will new
kernels. The only difference is that on new kernels, the CC protocol
will be used in case TCG2 is not implemented.

So the only affected scenario here is a system that today implements
TCG but not CC, and intends to implement CC later and receive
measurements into both protocols. Does that really qualify as backward
compatibility? I'd rather not accommodate future systems that
implement something that the UEFI spec says they should not.

> The UEFI
> v2.10 standard says that firmware "should not" provide both, but it is
> not MUST NOT. Given this and our desire to provide service continuity,
> I ask that you remove the "else" guard.
>

Ignoring the newer protocol if the established one exists is an
excellent way of making sure this does not happen.


> > +               efi_guid_t cc_guid =3D EFI_CC_MEASUREMENT_PROTOCOL_GUID=
;
> > +               efi_cc_protocol_t *cc =3D NULL;
> >
> > -               evt->tagged_event_id            =3D events[event].event=
_id;
> > -               evt->tagged_event_data_size     =3D events[event].event=
_data_len;
> > -
> > -               memcpy(evt->tagged_event_data, events[event].event_data=
,
> > -                      events[event].event_data_len);
> > +               efi_bs_call(locate_protocol, &cc_guid, NULL, (void **)&=
cc);
> > +               if (!cc)
> > +                       return EFI_UNSUPPORTED;
> >
> > -               status =3D efi_call_proto(tcg2, hash_log_extend_event, =
0,
> > -                                       load_addr, load_size, &evt->eve=
nt_data.tcg2_data);
> > -               efi_bs_call(free_pool, evt);
> > +               ev.cc_data =3D (struct efi_cc_event){
> > +                       .event_size                     =3D size,
> > +                       .event_header.header_size       =3D sizeof(ev.c=
c_data.event_header),
> > +                       .event_header.header_version    =3D EFI_CC_EVEN=
T_HEADER_VERSION,
> > +                       .event_header.event_type        =3D EV_EVENT_TA=
G,
> > +               };
> >
> > +               status =3D efi_call_proto(cc, map_pcr_to_mr_index,
> > +                                       events[event].pcr_index,
> > +                                       &ev.cc_data.event_header.mr_ind=
ex);
> >                 if (status !=3D EFI_SUCCESS)
> >                         goto fail;
> > -               return EFI_SUCCESS;
> > +
> > +               protocol =3D cc;
> > +               method.hash_log_extend_event =3D
> > +                       (void *)efi_table_attr(cc, hash_log_extend_even=
t);
> >         }
> >
> > -       return EFI_UNSUPPORTED;
> > +       status =3D efi_bs_call(allocate_pool, EFI_LOADER_DATA, size, (v=
oid **)&evt);
> > +       if (status !=3D EFI_SUCCESS)
> > +               goto fail;
> > +
> > +       evt->event_data                 =3D ev;
> > +       evt->tagged_event_id            =3D events[event].event_id;
> > +       evt->tagged_event_data_size     =3D events[event].event_data_le=
n;
> > +
> > +       memcpy(evt->tagged_event_data, events[event].event_data,
> > +              events[event].event_data_len);
> > +
> > +       status =3D efi_fn_call(&method, hash_log_extend_event, protocol=
, 0,
> > +                            load_addr, load_size, &evt->event_data);
> > +       efi_bs_call(free_pool, evt);
> > +
> > +       if (status =3D=3D EFI_SUCCESS)
> > +               return EFI_SUCCESS;
> > +
> >  fail:
> >         efi_warn("Failed to measure data for event %d: 0x%lx\n", event,=
 status);
> >         return status;
> > diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/=
efi/libstub/efistub.h
> > index d621bfb719c4..4bf9a76796b7 100644
> > --- a/drivers/firmware/efi/libstub/efistub.h
> > +++ b/drivers/firmware/efi/libstub/efistub.h
> > @@ -954,8 +954,11 @@ union efi_cc_protocol {
> >         } mixed_mode;
> >  };
> >
> > +static_assert(sizeof(efi_tcg2_event_t) =3D=3D sizeof(efi_cc_event_t));
> > +
> >  union efistub_event {
> >         efi_tcg2_event_t        tcg2_data;
> > +       efi_cc_event_t          cc_data;
> >  };
> >
> >  struct efistub_measured_event {
> > --
> > 2.44.0.278.ge034bb2e1d-goog
> >
> >
>
>
> --
> -Dionna Glaze, PhD (she/her)

