Return-Path: <linux-efi+bounces-2565-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 02B1DA08EFA
	for <lists+linux-efi@lfdr.de>; Fri, 10 Jan 2025 12:18:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C79DD188B992
	for <lists+linux-efi@lfdr.de>; Fri, 10 Jan 2025 11:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A335120ADC2;
	Fri, 10 Jan 2025 11:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RrQXpBQZ"
X-Original-To: linux-efi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7FCA18787A
	for <linux-efi@vger.kernel.org>; Fri, 10 Jan 2025 11:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736507892; cv=none; b=jITWPTrRGa8BrT7Cqz/BhqclH8mSweFWZvF2Es3THPa41Atk98zu+9AvQYoGUnHWUgyEUTcXr8wmfSiRcVH3kcaCr8RF6rrQKHiF7hVPDmnZd9Hij9d97/AipppQdHZgOVBSHHRoLubERxkw3n3Qr1rGjZj5qxbReqQNXjbDCeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736507892; c=relaxed/simple;
	bh=h3RkjRvNew/JDBRooOPRuEdXrhpyyDbwz63J+OIfLTE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fgHvwraCpPIYd1bF1sRCnVe67Wn+gGk8+IYW4vY+d25xoP1+BcIgH2Z+Zz4QRxoH5S84mqNcNO+r/tZuSx+ijLjkbeds+q7cDwAi2kOOABEjhI/LiXhAnk/33DUi9r0hhG0Babq+3yIZ5Ri7bPXGlzO3bHevVN0DueV26zoyXKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RrQXpBQZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736507889;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U6K79GL0Aierbj2HhfWQCiqT/6tsQrxB/FOaaxsEgb4=;
	b=RrQXpBQZar5C9y18/B1yKHqsRa79aRkM+VNFsQxF/O58RYXEUA5lUMrtQZmBqmpwouAx9q
	Pc19UcDr3iKLgRErWaroF2k1aXfjcNaqsZY7W9btJPE5d73Xzt1SBvPax5BcQCElrz6hyc
	4FN19u3Kc54AnYuADzlXlrw4lrnj+dg=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-16-y_DUpD6xO--Ty5qiH4qLvQ-1; Fri, 10 Jan 2025 06:18:08 -0500
X-MC-Unique: y_DUpD6xO--Ty5qiH4qLvQ-1
X-Mimecast-MFC-AGG-ID: y_DUpD6xO--Ty5qiH4qLvQ
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a9cefa1969so17629165ab.1
        for <linux-efi@vger.kernel.org>; Fri, 10 Jan 2025 03:18:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736507888; x=1737112688;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U6K79GL0Aierbj2HhfWQCiqT/6tsQrxB/FOaaxsEgb4=;
        b=WuMEPGYMs+M6W4K9+wMQ++VwNDs2CTeCMmRGXOktOWWVEc8hpNrjYDwZ3Xn4EHvq+r
         809IYNOuDI/Lf5Xulril6oP+1WJIWhSrukLhVJetKbxHaaa6hS0+zPMH0Zjo/mSd4WMm
         fvVje96+I/EPpDSgVydPV3DKhcho3KAh3hx9oInAUCEUv3TAneNp+Lv3+bZSwmJSIjYO
         goV6KolqxrKAvXgnuPRNoo2DwVbGY/WCcOJ7nIoU6yjxppD/M/iy0PRGia7VWeUlpwws
         SNrbjBFeZnpFDewxUd8cpfEp+rf8tQpO80/i5F35XtIdIOF51wWlUNIaA3ApQzQwr0hF
         IyxA==
X-Gm-Message-State: AOJu0Yw89S87NrJpHtPCiolajt/R4gGmR5qjHU+0cwk/nCXlUxC/55lr
	2qNQtaXKk4u4TSmWOpqJisN82ByTtP59LEc2yf15lqr4GoWEuTZC5w9gvOgdRM7oSx8hvGsxBZh
	NSy0BePeQKYZjM6irHAuXQ5algUtJaJFACGOhoyz3ODs9D6fnTzqVUmGTLbrZEUPeQgH+32FPTQ
	aNLNAkCea6QCZFQ4y7vCD1aGc1SAp7SY2d
X-Gm-Gg: ASbGnctqeObZQRr2zDbSuF05DEDl/1HiwwWYRAIz9mHUVq9yK6iJMs7zBBlXv3yb2sF
	4pU780RC5bMH5SqQ+9CKWyq97zni2ahX7dl+hVPU=
X-Received: by 2002:a05:6e02:3dc2:b0:3a7:8208:b847 with SMTP id e9e14a558f8ab-3ce3aa74516mr73500235ab.22.1736507887820;
        Fri, 10 Jan 2025 03:18:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGA7dAfrgLzkJ12E7/vbM/rmrd89W2Jgnoku0ZUGP83tR/OARctRAqpmJ70EkI7oznqyYN3kZfUJQheZWG8tPY=
X-Received: by 2002:a05:6e02:3dc2:b0:3a7:8208:b847 with SMTP id
 e9e14a558f8ab-3ce3aa74516mr73500125ab.22.1736507887562; Fri, 10 Jan 2025
 03:18:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250108215957.3437660-1-usamaarif642@gmail.com>
 <20250108215957.3437660-3-usamaarif642@gmail.com> <CALu+AoTgjdq+kUbv-5CGQr=UTLd2+zDLbHt=kXaoMYYptBYnAA@mail.gmail.com>
 <4ed67e5b-c2ea-4dc3-b4c5-f8f112b0cd40@gmail.com>
In-Reply-To: <4ed67e5b-c2ea-4dc3-b4c5-f8f112b0cd40@gmail.com>
From: Dave Young <dyoung@redhat.com>
Date: Fri, 10 Jan 2025 19:18:12 +0800
X-Gm-Features: AbW1kvY3NgOP3VeQdRDz6rjTWoDkxnlxQ8g34ZJbAqB_EjoQkm5bJ2aQPEFf6e8
Message-ID: <CALu+AoSKrzcvP_wCRqPLO1+VBZzt-kuspiFf3dax8WDMDtCMgg@mail.gmail.com>
Subject: Re: [RFC 2/2] efi/memattr: add efi_mem_attr_table as a reserved
 region in 820_table_firmware
To: Usama Arif <usamaarif642@gmail.com>
Cc: linux-efi@vger.kernel.org, devel@edk2.groups.io, kexec@lists.infradead.org, 
	ardb@kernel.org, hannes@cmpxchg.org, x86@kernel.org, 
	linux-kernel@vger.kernel.org, leitao@debian.org, gourry@gourry.net, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 10 Jan 2025 at 19:12, Usama Arif <usamaarif642@gmail.com> wrote:
>
>
>
> On 10/01/2025 02:50, Dave Young wrote:
> > Hi Usama,
> >
> > On Thu, 9 Jan 2025 at 06:00, Usama Arif <usamaarif642@gmail.com> wrote:
> >>
> >> When this area is not reserved, it comes up as usable in
> >> /sys/firmware/memmap. This means that kexec, which uses that memmap
> >> to find usable memory regions, can select the region where
> >> efi_mem_attr_table is and overwrite it and relocate_kernel.
> >
> > Is the attr table BOOT SERVICE DATA?  If so, does efi_mem_reserve()
> > work for you?
> > Just refer to esrt.c.
> >
>
> Hi Dave,
>
> Its a bit difficult to reproduce the problem and therefore test the fix, but
> we are seeing it a lot in production. Ard proposed the same thing in
> https://lore.kernel.org/all/6b4780a5-ada0-405e-9f0a-4d2186177f29@gmail.com/
> but as I mentioned there, I dont think that efi_mem_reserve would help,
> as efi_mem_reserve changes e820_table, while kexec looks at
> /sys/firmware/memmap which uses e820_table_firmware.

I sent a question to pm people, if the sysfs memmap comes from
e820_table then it will be fine. Let's see:
https://lore.kernel.org/all/CALu+AoS-nk4u=9UYP7BLS=diOxjJRf+vfv7KHXG=uXozoYazsw@mail.gmail.com/

>
> Thanks,
> Usama
>
> > Thanks
> > Dave
> >
>


