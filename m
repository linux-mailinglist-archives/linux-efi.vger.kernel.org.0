Return-Path: <linux-efi+bounces-730-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8154B872969
	for <lists+linux-efi@lfdr.de>; Tue,  5 Mar 2024 22:29:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A56271C20B80
	for <lists+linux-efi@lfdr.de>; Tue,  5 Mar 2024 21:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C69F1129A99;
	Tue,  5 Mar 2024 21:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IqxuS3dk"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A278D26AD0
	for <linux-efi@vger.kernel.org>; Tue,  5 Mar 2024 21:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709674135; cv=none; b=mTCfxZJBWERCQcbwpWDqibYzSAECQae6/Oi3WUN3CplMluFEpCIeLHLNp3s87SEqyoWayJKxd6UwAof4FkiyDtVZGvlfo+LDpEDApK8E+199QNca/Ctumtr/xG9it/IwP6vKhvJZkkXyP8ro3YBjNk5voQkwbL3ytQJ9rmXQbzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709674135; c=relaxed/simple;
	bh=u1cJeG0Vt5mR2oNm95ieWa7GfWzvprXLQP884rnfTXg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O7qmCAxxncbPZ8D/Cu/O6MI47TEfIvA5cmPLOVdQkaWIpdauLHHmhezfu2TsnmDzzCyDNLINzFGlBYrHGZurldoOjuKr1A8JTXeSqUkXaOj6ljxFQ20NOYG7BwLSwH44DCFfNjv35zfjMVNeeDE0NavBfCkTmOk9qj7S26Ers04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IqxuS3dk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77D56C433C7
	for <linux-efi@vger.kernel.org>; Tue,  5 Mar 2024 21:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709674135;
	bh=u1cJeG0Vt5mR2oNm95ieWa7GfWzvprXLQP884rnfTXg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=IqxuS3dkyJ77NwIw4tT9b7xFWEbQvEtkjnY66Vc84qlVLJ05KJfjMTGJj/29kAipR
	 pRzzG1tTIdexyNctHQT2GW13xF6043nWIIPuuiGxzCFhl2/Lw37u+LOI1GxC9so+JO
	 qv2X+dYNGFjFtthSY05nXCb93jOMUL62PXBOxXi/tLyMy5VVU4JuK5oSu1Jf+4PnnI
	 Wu3dfb97RwaZmCjOH/FYeps9nhKwbLeMztem3OYMIOK2RIJ2gyi/n/EnlgJ0ANUTaJ
	 ShjCpn4jtcmgvjxNH9uC5FPm1RNZw6ozdWjlzkTJHxmEaJfdtU7mUHCNdaBrp77LZJ
	 tY7O0vZhBhR0g==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-513181719easo4369744e87.3
        for <linux-efi@vger.kernel.org>; Tue, 05 Mar 2024 13:28:55 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXnaHC0HEKsl6ApTp3phSP3wBW45gRhr8noGkkXFSK4VnaLT4zAi4eq+xxYOi7Dt/sZe7oqAs/VfJbnNXRQW1YjCCs070YVXEHO
X-Gm-Message-State: AOJu0Yx1L84+JP82tm5l1h8RWwFFQF/7cC9Se+i2rJdnIS/7zYXVyldd
	Eekf35wje10R+0lwl3l6rD4XjZMZ9K1wJoKTkmCKOmJwnzIMk8FXRPvYOlRqTSSgo1SwlAtHgqV
	wjRRlRLdBnTfOm+kgGFgo5Lc2V6o=
X-Google-Smtp-Source: AGHT+IEANArQHodcMg96s/pMJRSotFp79UcrfFViLDEBpjAC2EmC50XmFkDHZg5SA5Xoj6g79BZBeng5EK2leqGMFOI=
X-Received: by 2002:a19:6449:0:b0:513:5b81:f2f8 with SMTP id
 b9-20020a196449000000b005135b81f2f8mr346505lfj.54.1709674133584; Tue, 05 Mar
 2024 13:28:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240304104409.2326422-6-ardb+git@google.com> <20240304104409.2326422-9-ardb+git@google.com>
 <CAAH4kHYD03xepd=u9m66XWY=UHkOdooGj7jKPnu9DvA=LPAfXg@mail.gmail.com>
 <CAMj1kXEyWkDaENDOk5zrkZv+5=FwbXgQekoVHP2OqscrM5x=og@mail.gmail.com>
 <CAAH4kHb7ZgfrQQjVr-JiutQthwkbrVGR2DkUDE=E0ZoWGO34eA@mail.gmail.com>
 <2f2416e0-265b-4f03-abf5-fb29c1a0e61b@linux.intel.com> <CAAH4kHZhUE+1nBLpEz4tbx=etzZ+3xCXZoexB032OUT-XgZQwg@mail.gmail.com>
In-Reply-To: <CAAH4kHZhUE+1nBLpEz4tbx=etzZ+3xCXZoexB032OUT-XgZQwg@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 5 Mar 2024 22:28:42 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHFbS9Eesxq_2PM3tyGKQ=F6HqJ0ambtD_KmUeX3tLPnA@mail.gmail.com>
Message-ID: <CAMj1kXHFbS9Eesxq_2PM3tyGKQ=F6HqJ0ambtD_KmUeX3tLPnA@mail.gmail.com>
Subject: Re: [PATCH 3/4] efi/libstub: Measure into CC protocol if TCG2
 protocol is absent
To: Dionna Amalie Glaze <dionnaglaze@google.com>
Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, 
	Qinkun Bao <qinkun@google.com>, linux-efi@vger.kernel.org, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 5 Mar 2024 at 19:46, Dionna Amalie Glaze <dionnaglaze@google.com> w=
rote:
>
> On Tue, Mar 5, 2024 at 10:33=E2=80=AFAM Kuppuswamy Sathyanarayanan
> <sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
> >
> >
> > On 3/5/24 10:00 AM, Dionna Amalie Glaze wrote:
> > > On Tue, Mar 5, 2024 at 9:47=E2=80=AFAM Ard Biesheuvel <ardb@kernel.or=
g> wrote:
> > >> On Tue, 5 Mar 2024 at 18:34, Dionna Amalie Glaze <dionnaglaze@google=
.com> wrote:
> > >>> On Mon, Mar 4, 2024 at 2:44=E2=80=AFAM Ard Biesheuvel <ardb+git@goo=
gle.com> wrote:
> > >>>> From: Ard Biesheuvel <ardb@kernel.org>
> > >>>>
> > >>>> To accommodate confidential compute VMs that expose the simplified=
 CC
> > >>>> measurement protocol instead of the full-blown TCG2 one, fall back=
 to
> > >>>> the former if the latter does not exist.
> > >>>>
> > >>>> The CC protocol was designed to be used in this manner, which is w=
hy the
> > >>>> types and prototypes have been kept the same where possible. So re=
use
> > >>>> the existing code, and only deviate from the TCG2 code path where
> > >>>> needed.
> > >>>>
> > >>>> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > >>>> ---
> > >>>>  drivers/firmware/efi/libstub/efi-stub-helper.c | 67 +++++++++++++=
++-----
> > >>>>  drivers/firmware/efi/libstub/efistub.h         |  3 +
> > >>>>  2 files changed, 53 insertions(+), 17 deletions(-)
> > >>>>
> > >>>> diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/driv=
ers/firmware/efi/libstub/efi-stub-helper.c
> > >>>> index 0dbc9d3f4abd..21f4567324f6 100644
> > >>>> --- a/drivers/firmware/efi/libstub/efi-stub-helper.c
> > >>>> +++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
> > >>>> @@ -223,44 +223,77 @@ static efi_status_t efi_measure_tagged_event=
(unsigned long load_addr,
> > >>>>                                              unsigned long load_si=
ze,
> > >>>>                                              enum efistub_event_ty=
pe event)
> > >>>>  {
> > >>>> +       union {
> > >>>> +               efi_status_t
> > >>>> +               (__efiapi *hash_log_extend_event)(void *, u64, efi=
_physical_addr_t,
> > >>>> +                                                 u64, const union=
 efistub_event *);
> > >>>> +               struct { u32 hash_log_extend_event; } mixed_mode;
> > >>>> +       } method;
> > >>>>         struct efistub_measured_event *evt;
> > >>>>         int size =3D struct_size(evt, tagged_event_data,
> > >>>>                                events[event].event_data_len);
> > >>>>         efi_guid_t tcg2_guid =3D EFI_TCG2_PROTOCOL_GUID;
> > >>>>         efi_tcg2_protocol_t *tcg2 =3D NULL;
> > >>>> +       union efistub_event ev;
> > >>>>         efi_status_t status;
> > >>>> +       void *protocol;
> > >>>>
> > >>>>         efi_bs_call(locate_protocol, &tcg2_guid, NULL, (void **)&t=
cg2);
> > >>>>         if (tcg2) {
> > >>>> -               status =3D efi_bs_call(allocate_pool, EFI_LOADER_D=
ATA, size,
> > >>>> -                                    (void **)&evt);
> > >>>> -               if (status !=3D EFI_SUCCESS)
> > >>>> -                       goto fail;
> > >>>> -
> > >>>> -               evt->event_data.tcg2_data =3D (struct efi_tcg2_eve=
nt){
> > >>>> +               ev.tcg2_data =3D (struct efi_tcg2_event){
> > >>>>                         .event_size                     =3D size,
> > >>>> -                       .event_header.header_size       =3D sizeof=
(evt->event_data.tcg2_data.event_header),
> > >>>> +                       .event_header.header_size       =3D sizeof=
(ev.tcg2_data.event_header),
> > >>>>                         .event_header.header_version    =3D EFI_TC=
G2_EVENT_HEADER_VERSION,
> > >>>>                         .event_header.pcr_index         =3D events=
[event].pcr_index,
> > >>>>                         .event_header.event_type        =3D EV_EVE=
NT_TAG,
> > >>>>                 };
> > >>>> +               protocol =3D tcg2;
> > >>>> +               method.hash_log_extend_event =3D
> > >>>> +                       (void *)efi_table_attr(tcg2, hash_log_exte=
nd_event);
> > >>>> +       } else {
> > >>> +Qinkun Bao
> > >>> Given that the exclusive or between CC_MEASUREMENT_PROTOCOL and the
> > >>> TCG protocol breaks backwards compatibility, it'd be preferable to
> > >>> measure into all the measurement protocols that are present.
> > >> How so? Older kernels will use TCG2 if it exists, and so will new
> > >> kernels. The only difference is that on new kernels, the CC protocol
> > >> will be used in case TCG2 is not implemented.
> > >>
> > >> So the only affected scenario here is a system that today implements
> > >> TCG but not CC, and intends to implement CC later and receive
> > >> measurements into both protocols. Does that really qualify as backwa=
rd
> > >> compatibility? I'd rather not accommodate future systems that
> > >> implement something that the UEFI spec says they should not.
> > >>
> > >>> The UEFI
> > >>> v2.10 standard says that firmware "should not" provide both, but it=
 is
> > >>> not MUST NOT. Given this and our desire to provide service continui=
ty,
> > >>> I ask that you remove the "else" guard.
> > >>>
> > >> Ignoring the newer protocol if the established one exists is an
> > >> excellent way of making sure this does not happen.
> > >>
> > > The problem is that the protocols are not equivalent, and we disagree
> > > with the standard's claim of "should not" to the point that we're
> > > taking it to the USWG. The "should not" advisement is predicated on
> > > not trusting boot layers to use both protocols when they're both
> > > present, such that you could accidentally miss measuring a
> > > security-critical event. That's a strawman though, since you already
> > > need to develop trust in those boot layers. We have software supply
> > > chain endorsements for tracking that kind of property for use in
> > > attestation verification.
> > >
> > > The CC protocol is useful for hardware-rooted boot measurement, but i=
t
> > > does nothing about the rest of TPM 2.0. There are plenty of users tha=
t
> > > want to use a vTPM that's hosted by the VMM but also get an extra
> > > integrity assurance that measurements into TDX RTMRs and attested by
> > > an Intel-rooted key pass an extra level of scrutiny.
> > >
> >
> > If you check the EDK2 part of this support, it also uses if else model.
>
> Yes, we've been discussing this with Intel and they agreed to allow a
> default false build option to measure into both.
>
> > It does not measure both. If there a complete vTPM support, why
> > can't user trust measurements from it? I think the CC vendors will
>
> There are folks who want to do a double-check with TEE quotes, but yes
> I agree in general this is not the best situation. It's a stepping
> stones model rather than scaling Everest in one bound.
> Ideally you'd have a measured and protected TPM implementation with
> adequate security for persistent data so that the
> CC_MEASUREMENT_PROTOCOL is fully redundant and therefore not needed.
>
> But anyway, the standard is what it is for now, so I wouldn't block
> this patch based on this request. When there's more alignment from the
> UEFI standards working group and an accepted patch into EDK2, then we
> can revisit this in the different boot layers.
>

Yeah some spec guidance on when having both protocols makes sense and
why would help here. If you trust the VMM to operate the vTPM for you,
what is the point of the CC protocol?

For now, I'll go with the changes as proposed, also because we're
close to the merge window. We can always revisit this and backport if
needed.

