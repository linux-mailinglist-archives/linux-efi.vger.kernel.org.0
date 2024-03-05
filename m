Return-Path: <linux-efi+bounces-719-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B4F8725C6
	for <lists+linux-efi@lfdr.de>; Tue,  5 Mar 2024 18:35:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94D321C20CAB
	for <lists+linux-efi@lfdr.de>; Tue,  5 Mar 2024 17:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DB5D1799F;
	Tue,  5 Mar 2024 17:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q5dcSVdx"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5A11758B
	for <linux-efi@vger.kernel.org>; Tue,  5 Mar 2024 17:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709660078; cv=none; b=jXN7JFcYrB+Hd/UAc/CWlBZRWoXGxMNoEwGg+8Rb+ot+rvUv3xP0ZKaKL+p2dpxWBlTSIen2m1kM+GnZwtYz/YBJXC2pCwm++/VHFv4E6d1vqdHg2HqR5eQpzi7V8mukstLeHAMBi8boYxUumHAim5JA9rnUArM7k5tV/dN2oUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709660078; c=relaxed/simple;
	bh=cW+JY85RxxcSA2BkbynljQrzn6LqpZ6X0ICOp0mPgOg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GsFxDRFlkwD0yIfS0h5UI++QKpLj5mmgVUVEvEOfoDNrarOq+GssBnmovVtZIO+qRrpoLXBgtbLlHBpDeBmlH9oa0dCzDrenprsvwjI4qvM+iCj2/ehyzmxokvd7pNytQTVC16vQs5B7o1Q6Q6OmTSyxKFDTkgPGj+iMYIUyQrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q5dcSVdx; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-565223fd7d9so15184a12.1
        for <linux-efi@vger.kernel.org>; Tue, 05 Mar 2024 09:34:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709660075; x=1710264875; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lo7nMQPK4xSWHyDQ25IUjQ+FJ/KEcj/VP2E0nSjnKiw=;
        b=q5dcSVdxWBf9gNoKIMAleDMqrrK6Cn4bAYIcfa58IQYj5HVB/u8OGCT5GNQM/7cB8M
         c0Rxp3A4+eOHEKVJJfX1rcnjb8ayoQAy3Dt/tF7C+z577DV2H/wxpIq2+H/6w+L8zEsx
         DGPSWcfJVac3fCsS+NFhMhtQqvcaziEV1SpC8aB22Ok9oe+SV+L+JDwndpI00tyqaWPV
         Y5U1OvAURfheuuq4aZHYYw2VV1fvOOV4FMK4Um+u/EbZoJGb4a1loZzrZ4wNZ/vKollN
         vjGpn7Sx3UGefOQOv6v7a9+5F4nV0uqvGPNA1nzAuD+X9gx3E1I3qu8vP4MYyFGMnRPl
         pPfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709660075; x=1710264875;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lo7nMQPK4xSWHyDQ25IUjQ+FJ/KEcj/VP2E0nSjnKiw=;
        b=cvc3ax06WD0HxODX+iEc4jrzl8nVGqIkFE1WboSmKtuW5VsrG4Y6SrG9yfN0sjLbhA
         k/LGbYrvHm4AaeXtJIfDI2/kbtWQM+iMMfB3KzrHM4Act0J8FNgtLuCROfFBWzoRvmww
         Y5Y1QRkmP1XbVEzW6xJC+WVMECkYcxkR1siVz6oik55/t+fZjLaw1JuEeJJGEoHkkjey
         UwL5QN+AOQ9IKa/ADwemBYkDDsIU+hJiPraOOd/UQ+OhNP/tzgwDw4Qwmyp4UEqd+wqG
         gvV0d8Up8BkUBGt0/QtcO4LTHOZRdMfFgS5yyhHEk95/nvO/jejIv17ugwhjaFPyL2tT
         VXwg==
X-Gm-Message-State: AOJu0YweQpHQITdbtnKh2+8PEyKyYiXH95mWLKKoQqzmOL8jxi6thkTa
	n/OOsDOifY/C4NMHb3kVn0mdQQuLU9JQeQ+QuoMpt+CR8uChOUjmR8YXYzjJNMg3P6Ifb2UxaeW
	vltzrWtQWYEvB8chX1+zEGElTDQIVYGtj3TAK
X-Google-Smtp-Source: AGHT+IGCzGs7mOMLF+IaoQr2ZmD5gcuPNcUL4+6vFgqt21Wa1hU/OwoD/soeo7u/nZPePbvgvI0sLPVC5zY6xVsvxW4=
X-Received: by 2002:aa7:d587:0:b0:565:ad42:b97d with SMTP id
 r7-20020aa7d587000000b00565ad42b97dmr192087edq.0.1709660074690; Tue, 05 Mar
 2024 09:34:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240304104409.2326422-6-ardb+git@google.com> <20240304104409.2326422-9-ardb+git@google.com>
In-Reply-To: <20240304104409.2326422-9-ardb+git@google.com>
From: Dionna Amalie Glaze <dionnaglaze@google.com>
Date: Tue, 5 Mar 2024 09:34:21 -0800
Message-ID: <CAAH4kHYD03xepd=u9m66XWY=UHkOdooGj7jKPnu9DvA=LPAfXg@mail.gmail.com>
Subject: Re: [PATCH 3/4] efi/libstub: Measure into CC protocol if TCG2
 protocol is absent
To: Ard Biesheuvel <ardb+git@google.com>, Qinkun Bao <qinkun@google.com>
Cc: linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 4, 2024 at 2:44=E2=80=AFAM Ard Biesheuvel <ardb+git@google.com>=
 wrote:
>
> From: Ard Biesheuvel <ardb@kernel.org>
>
> To accommodate confidential compute VMs that expose the simplified CC
> measurement protocol instead of the full-blown TCG2 one, fall back to
> the former if the latter does not exist.
>
> The CC protocol was designed to be used in this manner, which is why the
> types and prototypes have been kept the same where possible. So reuse
> the existing code, and only deviate from the TCG2 code path where
> needed.
>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  drivers/firmware/efi/libstub/efi-stub-helper.c | 67 +++++++++++++++-----
>  drivers/firmware/efi/libstub/efistub.h         |  3 +
>  2 files changed, 53 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/fir=
mware/efi/libstub/efi-stub-helper.c
> index 0dbc9d3f4abd..21f4567324f6 100644
> --- a/drivers/firmware/efi/libstub/efi-stub-helper.c
> +++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
> @@ -223,44 +223,77 @@ static efi_status_t efi_measure_tagged_event(unsign=
ed long load_addr,
>                                              unsigned long load_size,
>                                              enum efistub_event_type even=
t)
>  {
> +       union {
> +               efi_status_t
> +               (__efiapi *hash_log_extend_event)(void *, u64, efi_physic=
al_addr_t,
> +                                                 u64, const union efistu=
b_event *);
> +               struct { u32 hash_log_extend_event; } mixed_mode;
> +       } method;
>         struct efistub_measured_event *evt;
>         int size =3D struct_size(evt, tagged_event_data,
>                                events[event].event_data_len);
>         efi_guid_t tcg2_guid =3D EFI_TCG2_PROTOCOL_GUID;
>         efi_tcg2_protocol_t *tcg2 =3D NULL;
> +       union efistub_event ev;
>         efi_status_t status;
> +       void *protocol;
>
>         efi_bs_call(locate_protocol, &tcg2_guid, NULL, (void **)&tcg2);
>         if (tcg2) {
> -               status =3D efi_bs_call(allocate_pool, EFI_LOADER_DATA, si=
ze,
> -                                    (void **)&evt);
> -               if (status !=3D EFI_SUCCESS)
> -                       goto fail;
> -
> -               evt->event_data.tcg2_data =3D (struct efi_tcg2_event){
> +               ev.tcg2_data =3D (struct efi_tcg2_event){
>                         .event_size                     =3D size,
> -                       .event_header.header_size       =3D sizeof(evt->e=
vent_data.tcg2_data.event_header),
> +                       .event_header.header_size       =3D sizeof(ev.tcg=
2_data.event_header),
>                         .event_header.header_version    =3D EFI_TCG2_EVEN=
T_HEADER_VERSION,
>                         .event_header.pcr_index         =3D events[event]=
.pcr_index,
>                         .event_header.event_type        =3D EV_EVENT_TAG,
>                 };
> +               protocol =3D tcg2;
> +               method.hash_log_extend_event =3D
> +                       (void *)efi_table_attr(tcg2, hash_log_extend_even=
t);
> +       } else {

+Qinkun Bao
Given that the exclusive or between CC_MEASUREMENT_PROTOCOL and the
TCG protocol breaks backwards compatibility, it'd be preferable to
measure into all the measurement protocols that are present. The UEFI
v2.10 standard says that firmware "should not" provide both, but it is
not MUST NOT. Given this and our desire to provide service continuity,
I ask that you remove the "else" guard.

> +               efi_guid_t cc_guid =3D EFI_CC_MEASUREMENT_PROTOCOL_GUID;
> +               efi_cc_protocol_t *cc =3D NULL;
>
> -               evt->tagged_event_id            =3D events[event].event_i=
d;
> -               evt->tagged_event_data_size     =3D events[event].event_d=
ata_len;
> -
> -               memcpy(evt->tagged_event_data, events[event].event_data,
> -                      events[event].event_data_len);
> +               efi_bs_call(locate_protocol, &cc_guid, NULL, (void **)&cc=
);
> +               if (!cc)
> +                       return EFI_UNSUPPORTED;
>
> -               status =3D efi_call_proto(tcg2, hash_log_extend_event, 0,
> -                                       load_addr, load_size, &evt->event=
_data.tcg2_data);
> -               efi_bs_call(free_pool, evt);
> +               ev.cc_data =3D (struct efi_cc_event){
> +                       .event_size                     =3D size,
> +                       .event_header.header_size       =3D sizeof(ev.cc_=
data.event_header),
> +                       .event_header.header_version    =3D EFI_CC_EVENT_=
HEADER_VERSION,
> +                       .event_header.event_type        =3D EV_EVENT_TAG,
> +               };
>
> +               status =3D efi_call_proto(cc, map_pcr_to_mr_index,
> +                                       events[event].pcr_index,
> +                                       &ev.cc_data.event_header.mr_index=
);
>                 if (status !=3D EFI_SUCCESS)
>                         goto fail;
> -               return EFI_SUCCESS;
> +
> +               protocol =3D cc;
> +               method.hash_log_extend_event =3D
> +                       (void *)efi_table_attr(cc, hash_log_extend_event)=
;
>         }
>
> -       return EFI_UNSUPPORTED;
> +       status =3D efi_bs_call(allocate_pool, EFI_LOADER_DATA, size, (voi=
d **)&evt);
> +       if (status !=3D EFI_SUCCESS)
> +               goto fail;
> +
> +       evt->event_data                 =3D ev;
> +       evt->tagged_event_id            =3D events[event].event_id;
> +       evt->tagged_event_data_size     =3D events[event].event_data_len;
> +
> +       memcpy(evt->tagged_event_data, events[event].event_data,
> +              events[event].event_data_len);
> +
> +       status =3D efi_fn_call(&method, hash_log_extend_event, protocol, =
0,
> +                            load_addr, load_size, &evt->event_data);
> +       efi_bs_call(free_pool, evt);
> +
> +       if (status =3D=3D EFI_SUCCESS)
> +               return EFI_SUCCESS;
> +
>  fail:
>         efi_warn("Failed to measure data for event %d: 0x%lx\n", event, s=
tatus);
>         return status;
> diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/ef=
i/libstub/efistub.h
> index d621bfb719c4..4bf9a76796b7 100644
> --- a/drivers/firmware/efi/libstub/efistub.h
> +++ b/drivers/firmware/efi/libstub/efistub.h
> @@ -954,8 +954,11 @@ union efi_cc_protocol {
>         } mixed_mode;
>  };
>
> +static_assert(sizeof(efi_tcg2_event_t) =3D=3D sizeof(efi_cc_event_t));
> +
>  union efistub_event {
>         efi_tcg2_event_t        tcg2_data;
> +       efi_cc_event_t          cc_data;
>  };
>
>  struct efistub_measured_event {
> --
> 2.44.0.278.ge034bb2e1d-goog
>
>


--=20
-Dionna Glaze, PhD (she/her)

