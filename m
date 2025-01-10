Return-Path: <linux-efi+bounces-2566-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BCEDA08F08
	for <lists+linux-efi@lfdr.de>; Fri, 10 Jan 2025 12:20:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28B94188C4B5
	for <lists+linux-efi@lfdr.de>; Fri, 10 Jan 2025 11:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DA8320B80A;
	Fri, 10 Jan 2025 11:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BqmW/RIk"
X-Original-To: linux-efi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1531FF602
	for <linux-efi@vger.kernel.org>; Fri, 10 Jan 2025 11:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736508040; cv=none; b=Zc2y7GWv50TZGmPCLEGl5LPZjKplaFgpG4BFy/POeNT7x+mG8h41QjuqjP2jy/19IWj2N/ZTgaVC/YgKvNrdr2AhLpTFA0GInP8SfCCy8TJWKw6TjPV+Vac2C8FXScz/54bOttcKMnJinzD+CIdZiNMMkfthUzuX48vVTn3e8Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736508040; c=relaxed/simple;
	bh=htEbFVaXgs98wVsAOJ75eYlpraw43Isv2EBkz8lg09I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HClkxrGC6a0tCR9KSENzzWxISw90HT3I301qmkVq2SscuMf0JQEt2lZR6fMtr6cPWrjZnB1hd8k1/paKxnOSx6QviESLzcPTJtOep8CmJspvGqmEuGF/p0THKIlvDRnwJIgU17lVhpht1+/4jRj8CzV79LdI99iv2J+6Hl+soOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BqmW/RIk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736508038;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x1TCeMy2kehH/G5/Ac6gcakvpunAPT8hClM5DzIPErQ=;
	b=BqmW/RIkLERAekEUkyZ/q6DPuEv5FI1MNsebJ4a8jVbiFEwr1g9jvuY2xL5d9IUqGHnGi9
	15QNm0Y7T6YbXW1JejV/WA4HEDAf7/C+XV7MyYgGTRAgGt7xyCG2U1bhQ6vJS3BzBwsYoZ
	iAGujwT538xTenowamI/kbvTZv/i4ik=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-465-VSST-fgqPvCtylD6slQ2Cg-1; Fri, 10 Jan 2025 06:20:37 -0500
X-MC-Unique: VSST-fgqPvCtylD6slQ2Cg-1
X-Mimecast-MFC-AGG-ID: VSST-fgqPvCtylD6slQ2Cg
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a7e39b48a2so32644525ab.0
        for <linux-efi@vger.kernel.org>; Fri, 10 Jan 2025 03:20:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736508036; x=1737112836;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x1TCeMy2kehH/G5/Ac6gcakvpunAPT8hClM5DzIPErQ=;
        b=PcuRo1eniu/65Az8qPUElYeL8T8mD70JB4fu5yPsI41s3tWEcEid1veHGzv3gT7Xi/
         2qgwoDYpzN3e8JbhI/c3ItE3Ox6pqRy9s57Fpr32TJaiLRcRMjjFsUPyee5t06Axi+ba
         Yao6acvi9rVkLvscXQU8l2tNj/3hCauQtB6u6HNUPYoRXCHENfH9isuq6DTccvypTEMY
         BGm6Hfn+Jka+EG2ROwtQUzb56OaOKqNW+xKBij3wPSA6J4pOxCkd1ii4VqjM5apNvA2S
         EjDLLrSnTy98M1FAL91hjS4zMfcmHGsR164x5ah4BID4UwOMtok34jbGV3aupDQ5pL3z
         3yeA==
X-Gm-Message-State: AOJu0YzJsW80Ga1bRwAckyNBrN9SEZsscAN5329bs7AjlURQ9RUzg2eg
	kug4KYWenIKvvRkJJFxdRItmnI/lVJu4QIptm6I2vbj5S1BkLm/GjpxJi8JpbLimaYWomAwuyR3
	JUifWidZ1oyLBN8Uug8aEJs6t3pA8KtiCnPAvfz3pub4JaWw5HLCemgPrnoCgMQufKGNOzIwmr/
	1v1tPPGTOWS5L8dFEOTsOZBBAyOFIZQjrJ
X-Gm-Gg: ASbGnctSA/icOEzln7OM+Fw9oUc/mzWsbWu3MhrYMrjWPkBE0ePvJV3Q1j388ao3EHO
	ercsgDl4DdllpnJJ5uYUrX2wGgh1qo0Vc5RIx7/o=
X-Received: by 2002:a05:6e02:19c6:b0:3a7:81a4:a54d with SMTP id e9e14a558f8ab-3ce3aa7c305mr88727835ab.20.1736508036317;
        Fri, 10 Jan 2025 03:20:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE/ZGZxn93BTZUgwgl5385CpZFhIe8wtltjq3xgYCHF4KnVPQrulNtY+5TAzkMXX76hdNVwHy/TuoHO3lYD9qo=
X-Received: by 2002:a05:6e02:19c6:b0:3a7:81a4:a54d with SMTP id
 e9e14a558f8ab-3ce3aa7c305mr88727725ab.20.1736508036092; Fri, 10 Jan 2025
 03:20:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250108215957.3437660-1-usamaarif642@gmail.com>
 <20250108215957.3437660-3-usamaarif642@gmail.com> <CALu+AoTgjdq+kUbv-5CGQr=UTLd2+zDLbHt=kXaoMYYptBYnAA@mail.gmail.com>
 <4ed67e5b-c2ea-4dc3-b4c5-f8f112b0cd40@gmail.com> <CALu+AoSKrzcvP_wCRqPLO1+VBZzt-kuspiFf3dax8WDMDtCMgg@mail.gmail.com>
In-Reply-To: <CALu+AoSKrzcvP_wCRqPLO1+VBZzt-kuspiFf3dax8WDMDtCMgg@mail.gmail.com>
From: Dave Young <dyoung@redhat.com>
Date: Fri, 10 Jan 2025 19:20:41 +0800
X-Gm-Features: AbW1kvbbbsAFGnLq07CQCS7hEathkhH1cwo6Bz0H1Eer0IQxRMwEsY9rVx_lHSM
Message-ID: <CALu+AoSg7=AJ5_x=ssznVCcssy+USHAGW_pHNpo7+_+KWRc+ag@mail.gmail.com>
Subject: Re: [RFC 2/2] efi/memattr: add efi_mem_attr_table as a reserved
 region in 820_table_firmware
To: Usama Arif <usamaarif642@gmail.com>
Cc: linux-efi@vger.kernel.org, devel@edk2.groups.io, kexec@lists.infradead.org, 
	ardb@kernel.org, hannes@cmpxchg.org, x86@kernel.org, 
	linux-kernel@vger.kernel.org, leitao@debian.org, gourry@gourry.net, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 10 Jan 2025 at 19:18, Dave Young <dyoung@redhat.com> wrote:
>
> On Fri, 10 Jan 2025 at 19:12, Usama Arif <usamaarif642@gmail.com> wrote:
> >
> >
> >
> > On 10/01/2025 02:50, Dave Young wrote:
> > > Hi Usama,
> > >
> > > On Thu, 9 Jan 2025 at 06:00, Usama Arif <usamaarif642@gmail.com> wrote:
> > >>
> > >> When this area is not reserved, it comes up as usable in
> > >> /sys/firmware/memmap. This means that kexec, which uses that memmap
> > >> to find usable memory regions, can select the region where
> > >> efi_mem_attr_table is and overwrite it and relocate_kernel.
> > >
> > > Is the attr table BOOT SERVICE DATA?  If so, does efi_mem_reserve()
> > > work for you?
> > > Just refer to esrt.c.
> > >
> >
> > Hi Dave,
> >
> > Its a bit difficult to reproduce the problem and therefore test the fix, but
> > we are seeing it a lot in production. Ard proposed the same thing in
> > https://lore.kernel.org/all/6b4780a5-ada0-405e-9f0a-4d2186177f29@gmail.com/
> > but as I mentioned there, I dont think that efi_mem_reserve would help,
> > as efi_mem_reserve changes e820_table, while kexec looks at
> > /sys/firmware/memmap which uses e820_table_firmware.
>
> I sent a question to pm people, if the sysfs memmap comes from
> e820_table then it will be fine. Let's see:
s/e820_table/e820_table_kexec

> https://lore.kernel.org/all/CALu+AoS-nk4u=9UYP7BLS=diOxjJRf+vfv7KHXG=uXozoYazsw@mail.gmail.com/
>
> >
> > Thanks,
> > Usama
> >
> > > Thanks
> > > Dave
> > >
> >


