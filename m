Return-Path: <linux-efi+bounces-721-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A43F787260E
	for <lists+linux-efi@lfdr.de>; Tue,  5 Mar 2024 18:56:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A3FC1F22056
	for <lists+linux-efi@lfdr.de>; Tue,  5 Mar 2024 17:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 920B6DF5B;
	Tue,  5 Mar 2024 17:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="imwB9WcH"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B2A179AF
	for <linux-efi@vger.kernel.org>; Tue,  5 Mar 2024 17:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709661374; cv=none; b=K1LtLA3JY5CncVlqOh2dF8anXKOscdBdfMop55AOlIiX1HVkDmKzpYScWBzrDzyeJ7bz6KH2J/ysGUDzL0cQ4hjpJ9MqdEhB+VdZY+DOSosRQ390KLBX3ATsDMdbH8R+EpuGB/f12Fey/gtWDoQq6yd842hSOrEK8X0Cstegn8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709661374; c=relaxed/simple;
	bh=jxZhVuNjQ4+L+VPjI/PbLz+mlZwEPlA5qqkbHd+q9I4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u3iTw4wOrM1IAg2K9pHWWc91bFpj+aNypBRkslJT0ZyN6kHUBin9XHMNlQTnTWnonPDcbcauxoBVoG+o4Ozrgts3NREqnzxpOa1l6ZQc2bQ+rZFlNZefTPwoGYV9I/VM02GWkvWnFpYfveRwrog5XdqvZWwJ4PyOFJbphKoDuPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=imwB9WcH; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-512bde3d197so8125e87.0
        for <linux-efi@vger.kernel.org>; Tue, 05 Mar 2024 09:56:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709661370; x=1710266170; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PDDib++GPDwgUGB3hf/4kRLUCXQEX0M9bsbuCs/R5hE=;
        b=imwB9WcHzPu/8WAM1EYo5Xvf2lRvABnkweubivTJWpMb7yTmzCMLERbiTAiT+wFEVC
         Ef/9oKGBDXNSUCPPIN8g8ZJGWbGjLadxPIz2CKlmSIL4Cfvg6RZaql9AWspSeoFPL9g2
         ArKyroY+Scn1VRuCqtjqG6jyRFHPVf+ETNUInWjxnxncO/N3wWr+twIasuh+ok6aCzYp
         CddLxa//kaJX1wFmeEnYH9QrVsBvlgk2ZY67eh9gZnUmy0LsJ31aS/EwIeYVPqIfIUqs
         OL8CWv4DX7npgxpX54kUGUUSCJbhE6f7OjgVUqrm+S/hgHnLX8bPW8vS6RRhj1uNslFg
         +9IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709661370; x=1710266170;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PDDib++GPDwgUGB3hf/4kRLUCXQEX0M9bsbuCs/R5hE=;
        b=YQekT0yaHzNrbyl0CKEFGZtZtb3Ut6xsmCh4ojstVMYs4dCzbIF2Fmj4gyN5l1yehH
         32XAhxxSQJOEYCSqeqLidyiT+AgMzgpsbNgB+kOTLcLPFPLIKwt+ipKYdxvsXufonYH+
         87iMci6gEdGRPr0ucS1Jri6MHpAGJHRSjo8YPqiUWhtPx8+wALWDoVnKM4KuREizeOWh
         /OvKsJxlEjT2+uPFFONpCxonTgmc6+T06lvPxP0TTNEhaQUFuVRTIbAhUfaI+1CKkMtg
         LzGvRfrhP5ghBwR3wyFtWGr2okvQuYtGSRRavlGeWDx8RKld+mMWci+YmF/Xaj1bUNjG
         ZeRg==
X-Forwarded-Encrypted: i=1; AJvYcCUE1pttaEXKJFB6BLOsA3jYnhUnsPE5WqffIdEEiMa1VCn7ZCHUBr/nj2GDE7heZatUOk7TIduVu/FwovEzQ/JNUf3RwfizkX7K
X-Gm-Message-State: AOJu0Yx5kpaZo0uq5w3WCYn+08OzclQieK07R41Y3Fqe1FL4tPiAoaC3
	7bmUov1nJlYkFCsF5P9FbdpMnRoE2W7YjKKMvM/eUAR21NtaokZpBfuVCVtaBBrjD2KZxhMxSYS
	DLv8EhRuFoS0h06sWF4yleQ1i97Ab657zc8/dnA==
X-Google-Smtp-Source: AGHT+IGsg+ECbBLDpWTtTeuze+5bhpCxCFmYqzcHiVadPMVYCuYBtcMmbkOQyat9TvLDD4qqOnMec0iZDHU/Lc8ai5c=
X-Received: by 2002:a19:ae0b:0:b0:513:d2:ad11 with SMTP id f11-20020a19ae0b000000b0051300d2ad11mr1844188lfc.53.1709661370140;
 Tue, 05 Mar 2024 09:56:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240304104409.2326422-6-ardb+git@google.com> <20240304104409.2326422-9-ardb+git@google.com>
 <CAAH4kHYD03xepd=u9m66XWY=UHkOdooGj7jKPnu9DvA=LPAfXg@mail.gmail.com> <CAMj1kXEyWkDaENDOk5zrkZv+5=FwbXgQekoVHP2OqscrM5x=og@mail.gmail.com>
In-Reply-To: <CAMj1kXEyWkDaENDOk5zrkZv+5=FwbXgQekoVHP2OqscrM5x=og@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 5 Mar 2024 19:55:33 +0200
Message-ID: <CAC_iWjJ_ZTOqdpvCF_6-4tBOGT_KR6TTfTn9ZD6J7-TON1L5sg@mail.gmail.com>
Subject: Re: [PATCH 3/4] efi/libstub: Measure into CC protocol if TCG2
 protocol is absent
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Dionna Amalie Glaze <dionnaglaze@google.com>, Qinkun Bao <qinkun@google.com>, linux-efi@vger.kernel.org, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 5 Mar 2024 at 19:47, Ard Biesheuvel <ardb@kernel.org> wrote:
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

Apart from what the EFI spec says, why would anyone want to use both
protocols? Won't we end up measuring things 2x ?

Thanks
/Ilias
>
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
>

