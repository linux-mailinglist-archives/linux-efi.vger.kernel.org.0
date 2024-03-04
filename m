Return-Path: <linux-efi+bounces-686-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F5486FF47
	for <lists+linux-efi@lfdr.de>; Mon,  4 Mar 2024 11:42:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 699BB282FDD
	for <lists+linux-efi@lfdr.de>; Mon,  4 Mar 2024 10:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BE04376F3;
	Mon,  4 Mar 2024 10:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z3k0cGIP"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72AEE376EA;
	Mon,  4 Mar 2024 10:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709548924; cv=none; b=HQA/V3qu2BVDsSXWtbDA6LJRoID5RZkWnt4peOaimN1JjW+UShzHbduLxHI0ts7C8NZBQUEr0FUXupmX82L8NYvV77DArEegRqknjdS0mbGw1Zyxu0rwLwLa+Oka3KJHX6E5HlPgowxBTo6YZ4n8YOUme4xyvgA9Jt9ctVwt9sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709548924; c=relaxed/simple;
	bh=j/9MXZqLNlB7z+z4uiEbgvB3SXfwgNbMNeIEF3YNDd4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R9JyUcT0tW0TF5EaiCsQMCc25UGMAtzb/0lrWbu4mRPMpQao8ci85HPQKZn4LhDkes09kYQhOt+3OmVODpi0x0jXXWDX3WouKlGtFfaED9jF5GqodUTc0OhtUPDixXMBpfE4QZjHrSTbE9HTHIIEfa6t7XJL1Z6fEKhRzHbkRtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z3k0cGIP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB1CBC43394;
	Mon,  4 Mar 2024 10:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709548924;
	bh=j/9MXZqLNlB7z+z4uiEbgvB3SXfwgNbMNeIEF3YNDd4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Z3k0cGIPI3nYMJmsQ8N7YnickC74gzvKssoXaaaDqHms2Bxe97Q3hkpCmMVyZe8/5
	 /LoWBzcWmr5zrzU0CaYEhgQC4lfNsqQYzrkud0m0oMmn6qyug3JDeMC5KVgnRxG/IQ
	 R1Lv7uvPMGy9lWrvnBdB6kWdeMLGXYRV9JFoox77JU1HJQ7GXYAYCYykKG91QxT+ds
	 YJrGx+UhdY3YOsjH4Rk7/0VfKIqZnJE8bmlSRFIohTWZEj+BsgBzLdx6ExVYSpNhvJ
	 nauiJ7rB7j4ZEetjQUbFNsItjkKIedzj9nbbcMuEEzHz1PS8QaEi1JdLZbxZ0YJsBF
	 AZYoSVQbH+IyQ==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-512e39226efso4082658e87.0;
        Mon, 04 Mar 2024 02:42:03 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUgGQowS0z55/r64Aj4Euc/9mYlow/QLHVbsfT3eqdPqRAFBc+2CzqFdag895EEHu3h4KYyzKZZKpNA7dWTySB6HiNRrKL28y5sVIz18KKR+LaHCpIrxow8rkyDdGJbes4EoXsBuNBj
X-Gm-Message-State: AOJu0Yw+U6/8NTsfoJE6hpUv0JFjH7bm/GOq/13B+T/9lTHnLWlQRLxd
	H6OJN5g4UicOnwEfP41ORps/zprnBc5iuORFHa+Nh6SVobuHjZQtOcvDqqsTQiHlHINtChau08o
	UK91j+rxleHC14OLZ6qKAJsh90oE=
X-Google-Smtp-Source: AGHT+IHF5cyhdvl+sq5raqTeh/Gf8IAcdVMI4D5hsCjAdUx4xTzeNOJNIi/wS1fe7V7Ksui0AgUzhEwPY0OaunZalck=
X-Received: by 2002:a05:6512:1305:b0:513:3e22:6e01 with SMTP id
 x5-20020a056512130500b005133e226e01mr3350670lfu.16.1709548922118; Mon, 04 Mar
 2024 02:42:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240215030002.281456-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20240215030002.281456-2-sathyanarayanan.kuppuswamy@linux.intel.com>
 <CAC_iWj+p6gmcb4-_-f8Kr4Ds6EmSsq2D4GK1XymyybX7i1TMFw@mail.gmail.com>
 <7bd53417-af59-43a8-965e-f63dfc827f3c@linux.intel.com> <CAC_iWjK3sXq1O4tgR0vEr9n2erfrr+9hqU+xUqiMK-TQa0t-hg@mail.gmail.com>
In-Reply-To: <CAC_iWjK3sXq1O4tgR0vEr9n2erfrr+9hqU+xUqiMK-TQa0t-hg@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 4 Mar 2024 11:41:50 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHHWMhasBPpxWeAJwgQOBX2U0DuW=ADxGH+ppYeCQT15A@mail.gmail.com>
Message-ID: <CAMj1kXHHWMhasBPpxWeAJwgQOBX2U0DuW=ADxGH+ppYeCQT15A@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] efi/libstub: Add Confidential Computing (CC)
 measurement support
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, 
	linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 27 Feb 2024 at 14:23, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi,
>
> Thanks for taking a shot at this.
>
> [...]
>
> > >> +               return status;
> > >> +
> > >> +       evt->event_data = (struct efi_tcg2_event){
> > >> +               .event_size                     = size,
> > >> +               .event_header.header_size       = sizeof(evt->event_data.event_header),
> > >> +               .event_header.header_version    = EFI_TCG2_EVENT_HEADER_VERSION,
> > >> +               .event_header.pcr_index         = events[event].pcr_index,
> > >> +               .event_header.event_type        = EV_EVENT_TAG,
> > >> +       };
> > >> +
> > >> +       evt->tagged_event = (struct efi_tcg2_tagged_event){
> > >> +               .tagged_event_id                = events[event].event_id,
> > >> +               .tagged_event_data_size         = events[event].event_data_len,
> > >> +       };
> > >> +
> > >> +       memcpy(evt->tagged_event_data, events[event].event_data,
> > >> +              events[event].event_data_len);
> > >> +
> > >> +       status = efi_call_proto(tcg2, hash_log_extend_event, 0,
> > >> +                               load_addr, load_size, &evt->event_data);
> > > The struct filling/memcpying looks similar across the 2 functions.  I
> > > wonder if it makes sense to have a common function for that, with an
> > > argument for the event data type.
> >
> > If we want to use helper function, the updated code looks like below.
> >
> > Are you fine with this version? (compile-tested only)
> >
> > +struct efi_tcg2_measured_event {
> > +       efi_tcg2_event_t        event_data;
> > +       efi_tcg2_tagged_event_t tagged_event;
> > +       u8                      tagged_event_data[];
> > +};
> > +
> > +struct efi_cc_measured_event {
> > +       efi_cc_event_t  event_data;
> > +       efi_tcg2_tagged_event_t tagged_event;
> > +       u8                      tagged_event_data[];
> > +};
> > +
> > +static void efi_tcg2_event_init(struct efi_tcg2_measured_event *evt,
> > +                               size_t size,
> > +                               enum efistub_event event)
> > +{
> > +       evt->event_data = (struct efi_tcg2_event){
> > +               .event_size                     = size,
> > +               .event_header.header_size       = sizeof(evt->event_data.event_header),
> > +               .event_header.header_version    = EFI_TCG2_EVENT_HEADER_VERSION,
> > +               .event_header.pcr_index         = events[event].pcr_index,
> > +               .event_header.event_type        = EV_EVENT_TAG,
> > +       };
> > +
> > +       evt->tagged_event = (struct efi_tcg2_tagged_event){
> > +               .tagged_event_id                = events[event].event_id,
> > +               .tagged_event_data_size         = events[event].event_data_len,
> > +       };
> > +
> > +       memcpy(evt->tagged_event_data, events[event].event_data,
> > +              events[event].event_data_len);
> > +}
> > +
> > +static efi_status_t tcg2_efi_measure(efi_tcg2_protocol_t *tcg2,
> > +                                    unsigned long load_addr,
> > +                                    unsigned long load_size,
> > +                                    enum efistub_event event)
> > +{
> > +       struct efi_tcg2_measured_event *evt;
> > +       efi_status_t status;
> > +       size_t size;
> > +
> > +       size = sizeof(*evt) + events[event].event_data_len;
> > +
> > +       status = efi_bs_call(allocate_pool, EFI_LOADER_DATA, size,
> > +                            (void **)&evt);
> > +       if (status != EFI_SUCCESS)
> > +               return status;
> > +
> > +       efi_tcg2_event_init(evt, size, event);
> > +
> > +       status = efi_call_proto(tcg2, hash_log_extend_event, 0,
> > +                               load_addr, load_size, &evt->event_data);
> > +       efi_bs_call(free_pool, evt);
> > +
> > +       return status;
> > +}
> >
> > +
> > +static efi_status_t cc_efi_measure(efi_cc_protocol_t *cc,
> > +                                  unsigned long load_addr,
> > +                                  unsigned long load_size,
> > +                                  enum efistub_event event)
> > +{
> > +       struct efi_cc_measured_event *evt;
> > +       efi_cc_mr_index_t mr;
> > +       efi_status_t status;
> > +       size_t size;
> > +
> > +       status = efi_call_proto(cc, map_pcr_to_mr_index, events[event].pcr_index, &mr);
> > +       if (status != EFI_SUCCESS) {
> > +               efi_debug("CC_MEASURE: PCR to MR mapping failed\n");
> > +               return status;
> > +       }
> > +
> > +       size = sizeof(*evt) + events[event].event_data_len;
> > +
> > +       status = efi_bs_call(allocate_pool, EFI_LOADER_DATA, size, (void **)&evt);
> > +       if (status != EFI_SUCCESS)
> > +               return status;
> > +
> > +       efi_tcg2_event_init((struct efi_tcg2_measured_event *)evt, size, event);
> > +
> > +       evt->event_data = (struct efi_cc_event){
> > +               .event_header.header_size       = sizeof(evt->event_data.event_header),
> > +               .event_header.header_version    = EFI_CC_EVENT_HEADER_VERSION,
> > +               .event_header.mr_index          = mr,
> > +       };
> > +
> > +       status = efi_call_proto(cc, hash_log_extend_event, 0,
> > +                               load_addr, load_size, &evt->event_data);
> > +
> > +       efi_bs_call(free_pool, evt);
> > +
> > +       return status;
> > +}
> >
>
> Yes, I think looks cleaner. Ard thoughts?
>

I'd prefer to radically unify this code much further.

AFAICT, the *only* difference is the need to call
map_pcr_to_mr_index(), beyond that, everything is the same:
- efi_tcg2_event is identical to efi_cc_event
- the hash_log_extend_event() protocol member lives at the same offset
in the protocol struct, and has the same prototype

If we weren't as far along in the merge window, I'd ask you to respin
with this in mind. However, we're at -rc7 and so to avoid missing the
merge window, I went ahead and reworked the code. I'll send those out
momentarily.

