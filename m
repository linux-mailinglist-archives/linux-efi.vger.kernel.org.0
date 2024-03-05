Return-Path: <linux-efi+bounces-725-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05C6E8726DB
	for <lists+linux-efi@lfdr.de>; Tue,  5 Mar 2024 19:46:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B159028BF54
	for <lists+linux-efi@lfdr.de>; Tue,  5 Mar 2024 18:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CE1314A89;
	Tue,  5 Mar 2024 18:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yB7R8z8s"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109A822EF3
	for <linux-efi@vger.kernel.org>; Tue,  5 Mar 2024 18:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709664396; cv=none; b=u8RcfCBkVMCDzX0AmJk0Fhfw9aJZXleTTiGYyx9ii3VYEY1NgL0qv1RjTwUpM7xw2n29ecGckJomMm2ToziL8tZAitPzVHzbaF6OpMKytjz+sX4eApevLkTmrAhPM80NYJ9Ntryvv+PJX7MmxUTx+u86AKms5lU0v65bWAy+ZtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709664396; c=relaxed/simple;
	bh=WWaszFef3Oj0IaBF+WbtAHvjtMMASMVsK34/dNMJwvo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IzMARictONfek6+GX2KNMi1y0coXLf5gFXPw/E54mFn7E21KOrESoVcliSxlBkJ3UvIQywKIU9LiC3+9dI4GTvTLlCsgBikQfH0xNG+I+gyxPOubuRWzZCztlSoOiG+3OtalxUc9vKBEnt4WflSl5kW+z89/qo/FLa41vgx1xjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yB7R8z8s; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-566b160f6eeso1944a12.1
        for <linux-efi@vger.kernel.org>; Tue, 05 Mar 2024 10:46:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709664392; x=1710269192; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2U4otIgkRep+rq8bSBuVzOOrSS8eSFUfguQ++Y1RdD4=;
        b=yB7R8z8sfn2NcOt0T3GD0tnGwNjKWYBQTAhd0LxkWcaf52ZY2h6mk5qc9xc+hxuj/z
         vCgMuX1l8h6a5GE9keS3zlmmBbhK14WG8v/xWyK1it9BRruJ/38T0Vii+w9djrMvSLaq
         bTYdOy+6DynWhIF/r/NXIjzoJPDFhh9uKblyAsAUWcRFFhuTUBybXxyu98MQovzHF7ZP
         ZO7ZqPdEkOsehAdYOVdRDnjwYyHfeYOSEnuute/f9C5VE3xghm/8fl5W/2F7pPdKOwL8
         IP65QjBb1pAzqRe7Zy68ggGLqyjzO3o1FhGX6k1ZAzt7/kmDJNhSsrI28XTzALwZ9tXJ
         JFuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709664392; x=1710269192;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2U4otIgkRep+rq8bSBuVzOOrSS8eSFUfguQ++Y1RdD4=;
        b=pcB/z4QXQLRb8TLnSP/XFKCfA7MvGRRoYAV/ovkh9nP9m1VndFxm+Eo4JMKzXSLC2q
         BKanYB5Hzf2UTxZ3MP9Ij61iJI98zAVMp6PrzSvzp8x8xrIjQpcecGJDsgGgtYOnjJJK
         iKrkOAgvHuXxS4KYwODF5HBbqXJtouM+siUlHllV/tj8mrNGyVcbklhuWQixefRTAIMO
         e3HAlfSVoMQCNtojc2wbrQeOP4yJDNTfqdcP34TWJq0jH/p3XcTNN8G+8DP8JKT61BXW
         wrPFhRpZPn8nmaoZ2XZtREfY45cx0TSm9JwiD2tVeaZR+7hJiuMrk7wRp1QCbAz+hj4u
         8c2g==
X-Forwarded-Encrypted: i=1; AJvYcCXtgI3RUPtxeRNZQUEJ3VVeCjla6jUpm/sLAjZsYDJeqC6xnd02ekzkDkhtVl+cw6lf9e7bs0FemES7CuY/N/a5s9EIpjIwEM2M
X-Gm-Message-State: AOJu0Yx5Im4o7Bd/yoFbHvzDEmnH2q0f/M5kMvrDgoCATp810MsM2UDD
	jkiqrJlCIJkN0gh30QDMuWSE/lPW86j3GQ7n12pjg6hUu1HEdF13q6ihd4+HO/vKa5kh/RDbVPY
	nhNA3B9fm/arq7MMSxpYu6nWVbAu9fb4y1uPV
X-Google-Smtp-Source: AGHT+IF20YBqCF83a4M6GeLc5BU7VTbxOoowquvwZ0IlrWaxSVKuWyDrB8ZBDq21OOiQDzHeP0eX8+lGCZ9CVmbhe4w=
X-Received: by 2002:a50:cc07:0:b0:566:306:22b7 with SMTP id
 m7-20020a50cc07000000b00566030622b7mr183652edi.1.1709664392072; Tue, 05 Mar
 2024 10:46:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240304104409.2326422-6-ardb+git@google.com> <20240304104409.2326422-9-ardb+git@google.com>
 <CAAH4kHYD03xepd=u9m66XWY=UHkOdooGj7jKPnu9DvA=LPAfXg@mail.gmail.com>
 <CAMj1kXEyWkDaENDOk5zrkZv+5=FwbXgQekoVHP2OqscrM5x=og@mail.gmail.com>
 <CAAH4kHb7ZgfrQQjVr-JiutQthwkbrVGR2DkUDE=E0ZoWGO34eA@mail.gmail.com> <2f2416e0-265b-4f03-abf5-fb29c1a0e61b@linux.intel.com>
In-Reply-To: <2f2416e0-265b-4f03-abf5-fb29c1a0e61b@linux.intel.com>
From: Dionna Amalie Glaze <dionnaglaze@google.com>
Date: Tue, 5 Mar 2024 10:46:20 -0800
Message-ID: <CAAH4kHZhUE+1nBLpEz4tbx=etzZ+3xCXZoexB032OUT-XgZQwg@mail.gmail.com>
Subject: Re: [PATCH 3/4] efi/libstub: Measure into CC protocol if TCG2
 protocol is absent
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, Qinkun Bao <qinkun@google.com>, linux-efi@vger.kernel.org, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 5, 2024 at 10:33=E2=80=AFAM Kuppuswamy Sathyanarayanan
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>
>
> On 3/5/24 10:00 AM, Dionna Amalie Glaze wrote:
> > On Tue, Mar 5, 2024 at 9:47=E2=80=AFAM Ard Biesheuvel <ardb@kernel.org>=
 wrote:
> >> On Tue, 5 Mar 2024 at 18:34, Dionna Amalie Glaze <dionnaglaze@google.c=
om> wrote:
> >>> On Mon, Mar 4, 2024 at 2:44=E2=80=AFAM Ard Biesheuvel <ardb+git@googl=
e.com> wrote:
> >>>> From: Ard Biesheuvel <ardb@kernel.org>
> >>>>
> >>>> To accommodate confidential compute VMs that expose the simplified C=
C
> >>>> measurement protocol instead of the full-blown TCG2 one, fall back t=
o
> >>>> the former if the latter does not exist.
> >>>>
> >>>> The CC protocol was designed to be used in this manner, which is why=
 the
> >>>> types and prototypes have been kept the same where possible. So reus=
e
> >>>> the existing code, and only deviate from the TCG2 code path where
> >>>> needed.
> >>>>
> >>>> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> >>>> ---
> >>>>  drivers/firmware/efi/libstub/efi-stub-helper.c | 67 +++++++++++++++=
-----
> >>>>  drivers/firmware/efi/libstub/efistub.h         |  3 +
> >>>>  2 files changed, 53 insertions(+), 17 deletions(-)
> >>>>
> >>>> diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/driver=
s/firmware/efi/libstub/efi-stub-helper.c
> >>>> index 0dbc9d3f4abd..21f4567324f6 100644
> >>>> --- a/drivers/firmware/efi/libstub/efi-stub-helper.c
> >>>> +++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
> >>>> @@ -223,44 +223,77 @@ static efi_status_t efi_measure_tagged_event(u=
nsigned long load_addr,
> >>>>                                              unsigned long load_size=
,
> >>>>                                              enum efistub_event_type=
 event)
> >>>>  {
> >>>> +       union {
> >>>> +               efi_status_t
> >>>> +               (__efiapi *hash_log_extend_event)(void *, u64, efi_p=
hysical_addr_t,
> >>>> +                                                 u64, const union e=
fistub_event *);
> >>>> +               struct { u32 hash_log_extend_event; } mixed_mode;
> >>>> +       } method;
> >>>>         struct efistub_measured_event *evt;
> >>>>         int size =3D struct_size(evt, tagged_event_data,
> >>>>                                events[event].event_data_len);
> >>>>         efi_guid_t tcg2_guid =3D EFI_TCG2_PROTOCOL_GUID;
> >>>>         efi_tcg2_protocol_t *tcg2 =3D NULL;
> >>>> +       union efistub_event ev;
> >>>>         efi_status_t status;
> >>>> +       void *protocol;
> >>>>
> >>>>         efi_bs_call(locate_protocol, &tcg2_guid, NULL, (void **)&tcg=
2);
> >>>>         if (tcg2) {
> >>>> -               status =3D efi_bs_call(allocate_pool, EFI_LOADER_DAT=
A, size,
> >>>> -                                    (void **)&evt);
> >>>> -               if (status !=3D EFI_SUCCESS)
> >>>> -                       goto fail;
> >>>> -
> >>>> -               evt->event_data.tcg2_data =3D (struct efi_tcg2_event=
){
> >>>> +               ev.tcg2_data =3D (struct efi_tcg2_event){
> >>>>                         .event_size                     =3D size,
> >>>> -                       .event_header.header_size       =3D sizeof(e=
vt->event_data.tcg2_data.event_header),
> >>>> +                       .event_header.header_size       =3D sizeof(e=
v.tcg2_data.event_header),
> >>>>                         .event_header.header_version    =3D EFI_TCG2=
_EVENT_HEADER_VERSION,
> >>>>                         .event_header.pcr_index         =3D events[e=
vent].pcr_index,
> >>>>                         .event_header.event_type        =3D EV_EVENT=
_TAG,
> >>>>                 };
> >>>> +               protocol =3D tcg2;
> >>>> +               method.hash_log_extend_event =3D
> >>>> +                       (void *)efi_table_attr(tcg2, hash_log_extend=
_event);
> >>>> +       } else {
> >>> +Qinkun Bao
> >>> Given that the exclusive or between CC_MEASUREMENT_PROTOCOL and the
> >>> TCG protocol breaks backwards compatibility, it'd be preferable to
> >>> measure into all the measurement protocols that are present.
> >> How so? Older kernels will use TCG2 if it exists, and so will new
> >> kernels. The only difference is that on new kernels, the CC protocol
> >> will be used in case TCG2 is not implemented.
> >>
> >> So the only affected scenario here is a system that today implements
> >> TCG but not CC, and intends to implement CC later and receive
> >> measurements into both protocols. Does that really qualify as backward
> >> compatibility? I'd rather not accommodate future systems that
> >> implement something that the UEFI spec says they should not.
> >>
> >>> The UEFI
> >>> v2.10 standard says that firmware "should not" provide both, but it i=
s
> >>> not MUST NOT. Given this and our desire to provide service continuity=
,
> >>> I ask that you remove the "else" guard.
> >>>
> >> Ignoring the newer protocol if the established one exists is an
> >> excellent way of making sure this does not happen.
> >>
> > The problem is that the protocols are not equivalent, and we disagree
> > with the standard's claim of "should not" to the point that we're
> > taking it to the USWG. The "should not" advisement is predicated on
> > not trusting boot layers to use both protocols when they're both
> > present, such that you could accidentally miss measuring a
> > security-critical event. That's a strawman though, since you already
> > need to develop trust in those boot layers. We have software supply
> > chain endorsements for tracking that kind of property for use in
> > attestation verification.
> >
> > The CC protocol is useful for hardware-rooted boot measurement, but it
> > does nothing about the rest of TPM 2.0. There are plenty of users that
> > want to use a vTPM that's hosted by the VMM but also get an extra
> > integrity assurance that measurements into TDX RTMRs and attested by
> > an Intel-rooted key pass an extra level of scrutiny.
> >
>
> If you check the EDK2 part of this support, it also uses if else model.

Yes, we've been discussing this with Intel and they agreed to allow a
default false build option to measure into both.

> It does not measure both. If there a complete vTPM support, why
> can't user trust measurements from it? I think the CC vendors will

There are folks who want to do a double-check with TEE quotes, but yes
I agree in general this is not the best situation. It's a stepping
stones model rather than scaling Everest in one bound.
Ideally you'd have a measured and protected TPM implementation with
adequate security for persistent data so that the
CC_MEASUREMENT_PROTOCOL is fully redundant and therefore not needed.

But anyway, the standard is what it is for now, so I wouldn't block
this patch based on this request. When there's more alignment from the
UEFI standards working group and an accepted patch into EDK2, then we
can revisit this in the different boot layers.

> ensure their vTPM implementation is protected from attack from the
> host (like implementing it part of firmware or launching it as  service i=
n
> a separate VM).
>
> >>>> +               efi_guid_t cc_guid =3D EFI_CC_MEASUREMENT_PROTOCOL_G=
UID;
> >>>> +               efi_cc_protocol_t *cc =3D NULL;
> >>>>
> >>>> -               evt->tagged_event_id            =3D events[event].ev=
ent_id;
> >>>> -               evt->tagged_event_data_size     =3D events[event].ev=
ent_data_len;
> >>>> -
> >>>> -               memcpy(evt->tagged_event_data, events[event].event_d=
ata,
> >>>> -                      events[event].event_data_len);
> >>>> +               efi_bs_call(locate_protocol, &cc_guid, NULL, (void *=
*)&cc);
> >>>> +               if (!cc)
> >>>> +                       return EFI_UNSUPPORTED;
> >>>>
> >>>> -               status =3D efi_call_proto(tcg2, hash_log_extend_even=
t, 0,
> >>>> -                                       load_addr, load_size, &evt->=
event_data.tcg2_data);
> >>>> -               efi_bs_call(free_pool, evt);
> >>>> +               ev.cc_data =3D (struct efi_cc_event){
> >>>> +                       .event_size                     =3D size,
> >>>> +                       .event_header.header_size       =3D sizeof(e=
v.cc_data.event_header),
> >>>> +                       .event_header.header_version    =3D EFI_CC_E=
VENT_HEADER_VERSION,
> >>>> +                       .event_header.event_type        =3D EV_EVENT=
_TAG,
> >>>> +               };
> >>>>
> >>>> +               status =3D efi_call_proto(cc, map_pcr_to_mr_index,
> >>>> +                                       events[event].pcr_index,
> >>>> +                                       &ev.cc_data.event_header.mr_=
index);
> >>>>                 if (status !=3D EFI_SUCCESS)
> >>>>                         goto fail;
> >>>> -               return EFI_SUCCESS;
> >>>> +
> >>>> +               protocol =3D cc;
> >>>> +               method.hash_log_extend_event =3D
> >>>> +                       (void *)efi_table_attr(cc, hash_log_extend_e=
vent);
> >>>>         }
> >>>>
> >>>> -       return EFI_UNSUPPORTED;
> >>>> +       status =3D efi_bs_call(allocate_pool, EFI_LOADER_DATA, size,=
 (void **)&evt);
> >>>> +       if (status !=3D EFI_SUCCESS)
> >>>> +               goto fail;
> >>>> +
> >>>> +       evt->event_data                 =3D ev;
> >>>> +       evt->tagged_event_id            =3D events[event].event_id;
> >>>> +       evt->tagged_event_data_size     =3D events[event].event_data=
_len;
> >>>> +
> >>>> +       memcpy(evt->tagged_event_data, events[event].event_data,
> >>>> +              events[event].event_data_len);
> >>>> +
> >>>> +       status =3D efi_fn_call(&method, hash_log_extend_event, proto=
col, 0,
> >>>> +                            load_addr, load_size, &evt->event_data)=
;
> >>>> +       efi_bs_call(free_pool, evt);
> >>>> +
> >>>> +       if (status =3D=3D EFI_SUCCESS)
> >>>> +               return EFI_SUCCESS;
> >>>> +
> >>>>  fail:
> >>>>         efi_warn("Failed to measure data for event %d: 0x%lx\n", eve=
nt, status);
> >>>>         return status;
> >>>> diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmwa=
re/efi/libstub/efistub.h
> >>>> index d621bfb719c4..4bf9a76796b7 100644
> >>>> --- a/drivers/firmware/efi/libstub/efistub.h
> >>>> +++ b/drivers/firmware/efi/libstub/efistub.h
> >>>> @@ -954,8 +954,11 @@ union efi_cc_protocol {
> >>>>         } mixed_mode;
> >>>>  };
> >>>>
> >>>> +static_assert(sizeof(efi_tcg2_event_t) =3D=3D sizeof(efi_cc_event_t=
));
> >>>> +
> >>>>  union efistub_event {
> >>>>         efi_tcg2_event_t        tcg2_data;
> >>>> +       efi_cc_event_t          cc_data;
> >>>>  };
> >>>>
> >>>>  struct efistub_measured_event {
> >>>> --
> >>>> 2.44.0.278.ge034bb2e1d-goog
> >>>>
> >>>>
> >>>
> >>> --
> >>> -Dionna Glaze, PhD (she/her)
> >
> >
> --
> Sathyanarayanan Kuppuswamy
> Linux Kernel Developer
>


--=20
-Dionna Glaze, PhD (she/her)

