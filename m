Return-Path: <linux-efi+bounces-2140-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA1DD9C58DA
	for <lists+linux-efi@lfdr.de>; Tue, 12 Nov 2024 14:23:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B41A1F21B2C
	for <lists+linux-efi@lfdr.de>; Tue, 12 Nov 2024 13:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB53D1369A8;
	Tue, 12 Nov 2024 13:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U0hKHMDg"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26D213A879
	for <linux-efi@vger.kernel.org>; Tue, 12 Nov 2024 13:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731417781; cv=none; b=WH+cz7vrlOHfOmTdYABwr7tR8+734WACZpkt66aAugiQmMDWMvleAX0+PEWUa311SWxlXh22r79fenROZohhFsYx//MHOebIIr3iktJx3eG7XsPpD8rSahgSP47ZiDI1i1elhCqvBNEm9MhsXpYFBFXOP6fhYu46nph41CDI9S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731417781; c=relaxed/simple;
	bh=qrJJ0UxBFCJBlTbSZverBQ+FVjZnghEBmJqdk5OW+6E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T3OXNaBVFad1DMlXBOWTh8/jt1V+FJxfOO4flQsjoBA8G3bVbd1/jw/kv+AKv4aw4JAiDi46ev/jd3AKFogasNHRb1N86bZpFdjZLi9bjakZC58IoGL2Af4w6UooK+17JrKYI63Qw2XfTYrlSEXxnKPVQpHUAp//mVqaHKcafy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=U0hKHMDg; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7eb0bc007edso2948844a12.3
        for <linux-efi@vger.kernel.org>; Tue, 12 Nov 2024 05:22:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731417779; x=1732022579; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HWwiZBt5DyEzEM5yl6Wr/TdgecQx8VBtrj6sdgekS8g=;
        b=U0hKHMDgbFzpA+4w10ZbNU6/inGwdvHPQwtPPyO/ff/4k1jB/N3bbv6cAOUBTZFH3e
         XGcQhCs79ulKeTZ6PYUxa0FF6T2ncmRR0gUmZlJWWUDZ4dGHpKlGzwBzaiQobM2R1/Qa
         WBQ/8ssezW8uSAVfpHGofG5k5ixnMthBr6TrFDnZA2FSojujRTFo+pPWZSHzTwl9OOVu
         CQWC+V3z4vlf7U0765VGshDxzqvx3ZCZ2cag8K+oAcsFVOX5QNJ174VkAix07lkc2IiI
         51uf/ttPaRO/ScdXSp+Ntn2uYLrvUa3zV3x9m+H2d335aDk08hNUxjGiKrUO5U2G12L4
         nkow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731417779; x=1732022579;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HWwiZBt5DyEzEM5yl6Wr/TdgecQx8VBtrj6sdgekS8g=;
        b=hurXXZZmQ1ugqipt5KuNBNtGnpPwcYBGeQDurKtuVeALMuIa7TYJHmiLfSw6/TQuEK
         ziZCInLZRaZi8AzDbfyMle/rzTGKfCMH8kzDw8YF/BEHz5oEEVdB4gxbiYA3sIbTPgMM
         3tKbUJ//MnyC6zncBSPKanDgKCy7JMHHm5FiEdO+9ioFX7/BC57Imhgc8961q2n6qh33
         5OoH6nWwZ6cjvrUXKwCbIqUafEMJbpPaaXRjJ0T9fLPtzRc7fN9weUckzQWzmgHizMw5
         +eiqkPpLZdtci5NT0bw6xcS4VjbfuoFooNMfCtwAcEFdQjhMkcjMLglzYbnMIb856mgh
         EuoQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqAlprUc+xC3yPR9Wjp2PFOX5q6l/67wm70EBMXJjEsYbpDmImMk7IVADAOSjgbWZeEP0q7VPlFek=@vger.kernel.org
X-Gm-Message-State: AOJu0YzE1SDOyEgTZ84NjtEFMZY3EwWEwXBMfnyBUY3zclkHfQjWCtRv
	FE623wHHgkvMH3ARG3u/NCheE2zt2gBgvr4VQyjs4XmDm+8aP5TF2Ma4ADeOQ7MEVEADEh/BJsM
	0aHFcnp+9gbjI9zX5OkdZexaz5TkS0vSjpnqSmg==
X-Google-Smtp-Source: AGHT+IHKPxdhbsAtD9Fw+7wJuW5e7M6kitQ0egta2cB7rLjLY1bXhYJViEopzVs1ZPpiS5lYO/3Ot58MuRPH+SvykLE=
X-Received: by 2002:a17:90b:1c8d:b0:2e2:7f8f:3ad7 with SMTP id
 98e67ed59e1d1-2e9b166bbdbmr22030180a91.7.1731417778750; Tue, 12 Nov 2024
 05:22:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALE0LRvJ-n77oU=O9__NdSLw2v33zMK+WYkn2LcwWMwHCbohQw@mail.gmail.com>
 <CAC_iWjJEXU+dodjvWQYM9ohPa3P2p0bFG=exGoi-iYFrLLbCTA@mail.gmail.com>
 <CALE0LRtUz8hd4pdR9sX2Sb6tOn=K4wkRnGG9B7f72qU8JFQSYQ@mail.gmail.com>
 <CAC_iWjJLSSTO0Ca7rgOWAHfWzbkBkKHkQedRUbcwsoU0dtrsGA@mail.gmail.com>
 <CALE0LRvN3tYgWig1XnCiAZvdzE8x=cdLanGxbUvpPr5nfexSPQ@mail.gmail.com>
 <CAC_iWjL4mp-sTsp5a+yFkUauXuMvZ1yoTAk_60nm-CCKUgwayw@mail.gmail.com>
 <CALE0LRsYXXaao2uCUMFkd8Y6f5Mxgoc-Qpft_y8wWW3ZiekbbA@mail.gmail.com>
 <CAC_iWjL+J9tNxEdh0AoYD19h013N4nk=KmaT=RACo4-oVwuRCA@mail.gmail.com>
 <CALE0LRu2oDSo6KOhO2fTDMiqX7iqjqNjNGD_67MJFS7BJWqT_w@mail.gmail.com>
 <CALE0LRvFT3fDdoBLXHK2e47cibD02pxXAuZ83rTqEfrzU3HnKA@mail.gmail.com>
 <CAC_iWj+STZib+VOZrQtZk95skWzyLqe7_HpNM60G6axNa3Lnnw@mail.gmail.com> <CALE0LRsqc6L9EunhOyvyOR_KgG28zb10YBR1qN2qgZ9iJvaHEw@mail.gmail.com>
In-Reply-To: <CALE0LRsqc6L9EunhOyvyOR_KgG28zb10YBR1qN2qgZ9iJvaHEw@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 12 Nov 2024 15:22:22 +0200
Message-ID: <CAC_iWjKLqDFb1wSUQ1uMqOfbeRtzGNX9gyTHtQy5-71WvBiiLA@mail.gmail.com>
Subject: Re: optee-based efi runtime variable service on TI j784s4 platforms
To: Enric Balletbo i Serra <eballetb@redhat.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, Sumit Garg <sumit.garg@linaro.org>, linux-efi@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	op-tee@lists.trustedfirmware.org, Manorit Chawdhry <m-chawdhry@ti.com>, 
	Udit Kumar <u-kumar1@ti.com>, "Menon, Nishanth" <nm@ti.com>, 
	Masahisa Kojima <kojima.masahisa@socionext.com>
Content-Type: text/plain; charset="UTF-8"

[...]

> > > > >
> > > >
> > > > Unfortunately that didn't help, but I don't see this code being run.
> >
> > That's weird, look below.
> >
> > > > Who sets for the first place the uefi variables, is this u-boot
> > > > writing them to the rpmb? or is optee itself?
> >
> > U-Boot sets the variables, but it does so via StandAloneMM.
> >
> > > >
> > >
> > > I tried to compare the behaviour between optee_rpmb (works) and
> > > efidebug (doesn't worrk). I see that the first thing optee_rpmb
> > > command does is open a session against the TA application, something
> > > that efidebug doesn't do, shouldn't efidebug do the same to access to
> > > the rpmb device and read or write the efi variables?
> > >
> >
> > That's a bit more complicated and explained to one of the blog posts I
> > pasted above.
> > We do open an OP-TEE session, but not for talking to a TA. We send the
> > messages to StandAloneMM, which then usese OPTEE RPMB APIs to write
> > the flash.
> >
> > The weird thing is why OP-TEE does not format your RPMB when compiling
> > with that flag.
> > If done correctly, OP-TEE will wipe the RPMB contents the first time
> > it tries to access it.
> >
>
> It does if I call optee_rpmb command
>
> E/TC:? 0 rpmb_fs_setup:2143 **** Clearing Storage ****
>
> But I don't see any attempt to write efi variables to the rpmb
> partition if I use the normal boot workflow or calling any efi command
> from the prompt.
>
> I think I need to read a bit more about all the pieces because I might
> miss something.

You don't need the command above to store variables. You need this in
case you need to use the RPMB from the command line.
Do a 'printenv -e && setenv -e -bs -rt -nv test test1 && printenv -e'.
Does that work ?

>
> => optee_rpmb read test 4
> D/TC:? 0 tee_ta_init_pseudo_ta_session:303 Lookup pseudo TA
> 023f8f1a-292a-432b-8fc4-de8471358067
> D/TC:? 0 ldelf_load_ldelf:110 ldelf load address 0x40007000
> D/LD:  ldelf:142 Loading TS 023f8f1a-292a-432b-8fc4-de8471358067
> F/TC:? 0 trace_syscall:147 syscall #3 (syscall_get_property)
> F/TC:? 0 trace_syscall:147 syscall #5 (syscall_open_ta_session)
> D/TC:? 0 ldelf_syscall_open_bin:135 > ldelf_syscall_open_bin
> D/TC:? 0 ldelf_syscall_open_bin:164 Lookup user TA ELF
> 023f8f1a-292a-432b-8fc4-de8471358067 (early TA)
> D/TC:? 0 ldelf_syscall_open_bin:168 res=0
> F/TC:? 0 trace_syscall:147 syscall #7 (syscall_invoke_ta_command)
> F/TC:? 0 read_compressed:178 1024 bytes
> F/TC:? 0 read_compressed:178 1024 bytes
> F/TC:? 0 read_compressed:178 1024 bytes
> F/TC:? 0 read_compressed:178 1024 bytes
> F/TC:? 0 trace_syscall:147 syscall #11 (syscall_mask_cancellation)
> F/TC:? 0 trace_syscall:147 syscall #7 (syscall_invoke_ta_command)
> F/TC:? 0 read_compressed:178 1024 bytes
> F/TC:? 0 read_compressed:178 1024 bytes
> F/TC:? 0 read_compressed:178 1024 bytes
> F/TC:? 0 read_compressed:178 1024 bytes
> F/TC:? 0 read_compressed:178 1024 bytes
> F/TC:? 0 read_compressed:178 1024 bytes
> F/TC:? 0 read_compressed:178 1024 bytes
> F/TC:? 0 read_compressed:178 1024 bytes
> F/TC:? 0 read_compressed:178 1024 bytes
> F/TC:? 0 read_compressed:178 1024 bytes
> F/TC:? 0 read_compressed:178 1024 bytes
> F/TC:? 0 read_compressed:178 1024 bytes
> F/TC:? 0 read_compressed:178 1024 bytes
> F/TC:? 0 read_compressed:178 1024 bytes
> F/TC:? 0 read_compressed:178 1024 bytes
> F/TC:? 0 read_compressed:178 1024 bytes
> F/TC:? 0 read_compressed:178 1024 bytes
> F/TC:? 0 read_compressed:178 1024 bytes
> F/TC:? 0 read_compressed:178 1024 bytes
> F/TC:? 0 read_compressed:178 1024 bytes
> F/TC:? 0 read_compressed:178 1024 bytes
> F/TC:? 0 read_compressed:178 1024 bytes
> F/TC:? 0 read_compressed:178 1024 bytes
> F/TC:? 0 read_compressed:178 1024 bytes
> F/TC:? 0 read_compressed:178 1024 bytes
> F/TC:? 0 read_compressed:178 1024 bytes
> F/TC:? 0 read_compressed:178 1024 bytes
> F/TC:? 0 read_compressed:178 1024 bytes
> F/TC:? 0 read_compressed:178 1024 bytes
> F/TC:? 0 read_compressed:178 1024 bytes
> F/TC:? 0 read_compressed:178 1024 bytes
> F/TC:? 0 read_compressed:178 1024 bytes
> F/TC:? 0 read_compressed:178 1024 bytes
> F/TC:? 0 read_compressed:178 1024 bytes
> F/TC:? 0 read_compressed:178 1024 bytes
> F/TC:? 0 read_compressed:178 1024 bytes
> F/TC:? 0 read_compressed:178 1024 bytes
> F/TC:? 0 read_compressed:178 1024 bytes
> F/TC:? 0 read_compressed:178 1024 bytes
> F/TC:? 0 read_compressed:178 1024 bytes
> F/TC:? 0 read_compressed:178 1024 bytes
> F/TC:? 0 read_compressed:178 1024 bytes
> F/TC:? 0 read_compressed:178 1024 bytes
> F/TC:? 0 read_compressed:178 1024 bytes
> F/TC:? 0 read_compressed:178 1024 bytes
> F/TC:? 0 read_compressed:178 1024 bytes
> F/TC:? 0 read_compressed:178 1024 bytes
> F/TC:? 0 read_compressed:178 1024 bytes
> F/TC:? 0 read_compressed:178 1024 bytes
> F/TC:? 0 read_compressed:178 492 bytes
> F/TC:? 0 trace_syscall:147 syscall #3 (syscall_get_property)
> F/TC:? 0 trace_syscall:147 syscall #8 (syscall_check_access_rights)
> F/TC:? 0 read_compressed:178 1024 bytes
> F/TC:? 0 read_compressed:178 1024 bytes
> F/TC:? 0 read_compressed:178 532 bytes
> F/TC:? 0 read_compressed:178 924 bytes
> F/TC:? 0 trace_syscall:147 syscall #8 (syscall_check_access_rights)
> F/TC:? 0 read_compressed:178 248 bytes
> F/TC:? 0 read_compressed:178 760 bytes
> F/TC:? 0 trace_syscall:147 syscall #6 (syscall_close_ta_session)
> F/TC:? 0 trace_syscall:147 syscall #3 (syscall_get_property)
> D/LD:  ldelf:176 ELF (023f8f1a-292a-432b-8fc4-de8471358067) at 0x40048000
> F/TC:? 0 trace_syscall:147 syscall #33 (syscall_cryp_random_number_generate)
> F/TC:? 0 trace_syscall:147 syscall #8 (syscall_check_access_rights)
> F/TC:? 0 trace_syscall:147 syscall #8 (syscall_check_access_rights)
> F/TC:? 0 trace_syscall:147 syscall #4 (syscall_get_property_name_to_index)
> F/TC:? 0 trace_syscall:147 syscall #8 (syscall_check_access_rights)
> F/TC:? 0 trace_syscall:147 syscall #41 (syscall_storage_obj_open)
> D/TC:? 0 rpmb_fs_open_internal:2356 >>> rpmb_fs_open_internal
> D/TC:? 0 tee_rpmb_init:1205 >>> core/tee/tee_rpmb_fs.c:1205
> D/TC:? 0 tee_rpmb_init:1214 >>> core/tee/tee_rpmb_fs.c:1214
> D/TC:? 0 tee_rpmb_init:1253 >>> core/tee/tee_rpmb_fs.c:1253
> D/TC:? 0 legacy_rpmb_init:1142 Trying legacy RPMB init
> D/TC:? 0 rpmb_set_dev_info:1111 RPMB: Syncing device information
> D/TC:? 0 rpmb_set_dev_info:1113 RPMB: RPMB size is 32*128 KB
> D/TC:? 0 rpmb_set_dev_info:1114 RPMB: Reliable Write Sector Count is 1
> D/TC:? 0 rpmb_set_dev_info:1116 RPMB: CID
> D/TC:? 0 rpmb_set_dev_info:1117 000000009e93ab30  13 01 4e 47 31 4d 31
> 35  4c 10 27 91 28 07 a9 00
> D/TC:? 0 legacy_rpmb_init:1162 RPMB INIT: Deriving key
> D/TC:? 0 tee_rpmb_key_gen:308 RPMB: Using test key
> D/TC:? 0 legacy_rpmb_init:1176 RPMB INIT: Verifying Key
> F/TC:? 0 plat_prng_add_jitter_entropy:68 0x61
> D/TC:? 0 legacy_rpmb_init:1180 Found working RPMB device
> D/TC:? 0 tee_rpmb_init:1205 >>> core/tee/tee_rpmb_fs.c:1205
> D/TC:? 0 tee_rpmb_init:1214 >>> core/tee/tee_rpmb_fs.c:1214
> D/TC:? 0 tee_rpmb_read:1362 Read 1 block at index 0
> D/TC:? 0 tee_rpmb_write_blk:1494 Write 1 block at index 0
> D/TC:? 0 tee_rpmb_init:1205 >>> core/tee/tee_rpmb_fs.c:1205
> D/TC:? 0 tee_rpmb_init:1214 >>> core/tee/tee_rpmb_fs.c:1214
> D/TC:? 0 tee_rpmb_init:1205 >>> core/tee/tee_rpmb_fs.c:1205
> D/TC:? 0 tee_rpmb_init:1214 >>> core/tee/tee_rpmb_fs.c:1214
> D/TC:? 0 tee_rpmb_read:1362 Read 1 block at index 0
> E/TC:? 0 rpmb_fs_setup:2143 **** Clearing Storage ****
> D/TC:? 0 tee_rpmb_write_blk:1494 Write 1 block at index 2
> F/TC:? 0 plat_prng_add_jitter_entropy:68 0xD3
> D/TC:? 0 tee_rpmb_read:1362 Read 1 block at index 0
> D/TC:? 0 tee_rpmb_write_blk:1494 Write 1 block at index 0
> D/TC:? 0 tee_rpmb_read:1362 Read 8 blocks at index 2
> F/TC:? 0 dump_fat:1951 flags 0x2, size 0, address 0, filename ''
> D/TC:? 0 read_fat:2221 fat_address 0
> D/TC:? 0 tee_rpmb_read:1362 Read 8 blocks at index 2
> F/TC:? 0 plat_prng_add_jitter_entropy:68 0x18
> E/TA:  read_persist_value:338 Can't open named object value, res = 0xffff0008
> D/TC:? 0 tee_ta_invoke_command:798 Error: ffff0008 of 4
> D/TC:? 0 tee_ta_close_session:460 csess 0x9e925a50 id 1
> D/TC:? 0 tee_ta_close_session:479 Destroy session
> D/TC:? 0 destroy_context:318 Destroy TA ctx (0x9e9259f0)
> Failed to read persistent value
>
>
>
>
>
>
>
> > Cheers
> > /Ilias
> >
> > > => optee_rpmb read test 4
> > > D/TC:? 0 tee_ta_init_pseudo_ta_session:303 Lookup pseudo TA
> > > 023f8f1a-292a-432b-8fc4-de8471358067
> > > D/TC:? 0 ldelf_load_ldelf:110 ldelf load address 0x40007000
> > > D/LD:  ldelf:142 Loading TS 023f8f1a-292a-432b-8fc4-de8471358067
> > > F/TC:? 0 trace_syscall:147 syscall #3 (syscall_get_property)
> > > F/TC:? 0 trace_syscall:147 syscall #5 (syscall_open_ta_session)
> > > D/TC:? 0 ldelf_syscall_open_bin:163 Lookup user TA ELF
> > > 023f8f1a-292a-432b-8fc4-de8471358067 (early TA)
> > > D/TC:? 0 ldelf_syscall_open_bin:167 res=0
> > > F/TC:? 0 trace_syscall:147 syscall #7 (syscall_invoke_ta_command)
> > > F/TC:? 0 read_compressed:178 1024 bytes
> > > F/TC:? 0 read_compressed:178 1024 bytes
> > > F/TC:? 0 read_compressed:178 1024 bytes
> > > F/TC:? 0 read_compressed:178 1024 bytes
> > > F/TC:? 0 trace_syscall:147 syscall #11 (syscall_mask_cancellation)
> > > F/TC:? 0 trace_syscall:147 syscall #7 (syscall_invoke_ta_command)
> > >
> > > => efidebug query -bs -rt -nv
> > > MMC: no card present
> > > mmc_init: -123, time 2002
> > > D/TC:? 0 load_stmm:297 stmm load address 0x40004000
> > > D/TC:? 0 spm_handle_scall:859 Received FFA version
> > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > >
> > >
> > >
> > > >
> > > > > Thanks
> > > > > /Ilias
> > > > > >
> > > > > > => efidebug query -bs -rt -nv
> > > > > > D/TC:? 0 load_stmm:297 stmm load address 0x40004000
> > > > > > D/TC:? 0 spm_handle_scall:859 Received FFA version
> > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > > > ... stuck here ... I need to reset the board
> > > > > >
> > > > > > Will continue to see if I can get more useful messages
> > > > > >
> > > > > > Thanks,
> > > > > >   Enric
> > > > > >
> > > > > > > Thanks
> > > > > > > /Ilias
> > > > > > > >
> > > > > > > > I'll try to add some more prints to verify if REE is used as a store
> > > > > > > > system, I assume this should say something about RPMB. Am I right with
> > > > > > > > this?
> > > > > > >
> > > > > > >
> > > > > > > >
> > > > > > > > > > > >
> > > > > > > > > > > > And tracing the function calls gives me that:
> > > > > > > > > > > >
> > > > > > > > > > > >       tee_stmm_efi_probe() {
> > > > > > > > > > > >              tee_client_open_context() {
> > > > > > > > > > > >                optee_get_version() {
> > > > > > > > > > > >                  tee_get_drvdata(); (ret=0xffff000002e55800)
> > > > > > > > > > > >                } (ret=0xd)
> > > > > > > > > > > >                tee_ctx_match(); (ret=0x1)
> > > > > > > > > > > >                optee_smc_open() {
> > > > > > > > > > > >                  tee_get_drvdata(); (ret=0xffff000002e55800)
> > > > > > > > > > > >                  optee_open() {
> > > > > > > > > > > >                    tee_get_drvdata(); (ret=0xffff000002e55800)
> > > > > > > > > > > >                  } (ret=0x0)
> > > > > > > > > > > >                } (ret=0x0)
> > > > > > > > > > > >              } (ret=0xffff000004e71c80)
> > > > > > > > > > > >              tee_client_open_session() {
> > > > > > > > > > > >                optee_open_session() {
> > > > > > > > > > > >                  tee_get_drvdata(); (ret=0xffff000002e55800)
> > > > > > > > > > > >                  optee_get_msg_arg() {
> > > > > > > > > > > >                    tee_get_drvdata(); (ret=0xffff000002e55800)
> > > > > > > > > > > >                    tee_shm_get_va(); (ret=0xffff000002909000)
> > > > > > > > > > > >                  } (ret=0xffff000002909000)
> > > > > > > > > > > >                  tee_session_calc_client_uuid(); (ret=0x0)
> > > > > > > > > > > >                  optee_to_msg_param(); (ret=0x0)
> > > > > > > > > > > >                  optee_smc_do_call_with_arg() {
> > > > > > > > > > > >                    tee_get_drvdata(); (ret=0xffff000002e55800)
> > > > > > > > > > > >                    tee_shm_get_va(); (ret=0xffff000002909000)
> > > > > > > > > > > >                    tee_shm_get_va(); (ret=0xffff000002909060)
> > > > > > > > > > > >                    optee_cq_wait_init(); (ret=0xffff000002e55910)
> > > > > > > > > > > >                    optee_smccc_smc(); (ret=0xffff0004)
> > > > > > > > > > > >                    tee_get_drvdata(); (ret=0xffff000002e55800)
> > > > > > > > > > > >                    optee_smccc_smc(); (ret=0xffff0004)
> > > > > > > > > > > >                    tee_get_drvdata(); (ret=0xffff000002e55800)
> > > > > > > > > > > >                    optee_smccc_smc(); (ret=0xffff0004)
> > > > > > > > > > > >                    tee_get_drvdata(); (ret=0xffff000002e55800)
> > > > > > > > > > > >                    optee_smccc_smc(); (ret=0xffff0004)
> > > > > > > > > > > >                    tee_get_drvdata(); (ret=0xffff000002e55800)
> > > > > > > > > > > >                    optee_smccc_smc(); (ret=0xffff0004)
> > > > > > > > > > > >      ... continues sending this forever ...
> > > > > > > > > > > >      ... Hit ^C to stop recording ...
> > > > > > > > > > > >                    tee_get_drvdata(); (ret=0xffff000002e55800)
> > > > > > > > > > > >                    optee_smccc_smc() {
> > > > > > > > > > > >
> > > > > > > > > > > > [1] https://docs.u-boot.org/en/latest/develop/uefi/uefi.html#using-op-tee-for-efi-variables
> > > > > > > > > > > >
> > > > > > > > > > > > Thanks in advance,
> > > > > > > > > > >
> > > > > > > > > > > The most common problem with this is miscompiling the tee_supplicant
> > > > > > > > > > > application.
> > > > > > > > > > > Since we don't know if the system has an RPMB, we emulate it in the
> > > > > > > > > > > tee_supplicant. How did you get the supplicant and can you check if it
> > > > > > > > > > > was compiled with RPMB_EMU=0 or 1?
> > > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > I'm using the tee-supplicant provided by the fedora package which is
> > > > > > > > > > built with ` -DRPMB_EMU=0`, I think that's correct, right?
> > > > > > > > > >
> > > > > > > > >
> > > > > > > > > Yes, this is correct. We fixed the Fedora package to compile the
> > > > > > > > > supplicant correctly a while back.
> > > > > > > > >
> > > > > > > > > [0] https://www.linaro.org/blog/uefi-secureboot-in-u-boot/
> > > > > > > > > [1] https://apalos.github.io/Protected%20UEFI%20variables%20with%20U-Boot.html#Protected%20UEFI%20variables%20with%20U-Boot
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > Regards
> > > > > > > > > /Ilias
> > > > > > > > > > Thanks,
> > > > > > > > > >    Enric
> > > > > > > > > >
> > > > > > > > > > > Thanks
> > > > > > > > > > > /Ilias
> > > > > > > > > > >
> > > > > > > > > > > >    Enric
> > > > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > >
> > > > > > > > >
> > > > > > > >
> > > > > > >
> > > > > >
> > > > >
> > >
> >
>

