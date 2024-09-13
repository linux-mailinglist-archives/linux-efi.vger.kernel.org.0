Return-Path: <linux-efi+bounces-1731-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35E5C978088
	for <lists+linux-efi@lfdr.de>; Fri, 13 Sep 2024 14:53:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B86E31F253AB
	for <lists+linux-efi@lfdr.de>; Fri, 13 Sep 2024 12:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CE111DA61A;
	Fri, 13 Sep 2024 12:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OpyoIk5y"
X-Original-To: linux-efi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33A61DA616
	for <linux-efi@vger.kernel.org>; Fri, 13 Sep 2024 12:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726231965; cv=none; b=hwx3xMpb/bT6quTHuJMrIkewG/YFcdqYB/MNxEPdvmy4mTnFxY7uURN3brgllOVQJeqVb/GXmexhQXuNPCV/8fS6OiCM50ne409L0WfqO0QuiTjCUDQQl0IT7VUPmqAZTggFuvO4kA+j4dc7ns7Y9a//AXc58uV2z0/DUIduFrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726231965; c=relaxed/simple;
	bh=Z58w98GTT+/pVEgLgwYQuU09XTZYDUL29uYY9jlootM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Db/0pPAHeYir3Phd9z512JElOaeiN+I0F9US2d2P/QO+DEjavDINLWGZUx+nQu1U55Zeo3PbE1aTXcASkBWC+8HLWpdQGFoY59idnQ7pmpDXJxf9rHiPKgOlSsC/qcgXvWTeF+pcly4aNQsKDELgpXsiShTroj/SnZwBs7F/M4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OpyoIk5y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726231962;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Wl05HquAsncJfGKJSFBrSFOKrrN2t2JKKgtLUktSM2A=;
	b=OpyoIk5yxyE9yBoXda//56on19ow4huPITyGoy5zre6ojWbM9Ufb4qsq6jsYIdUOm+j1Mp
	+ODKBFqn7lVOMpm2rwkBZaFSPHqSaxOjgMG2gNdTez06QQOuS1BeTfEpaf+ZECDrXpx6Cf
	HIyIPJjNmm8oZj3XFDeyA+VtRk+seZE=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-287-1SUewF8KN4-Yvov2EMSs4Q-1; Fri, 13 Sep 2024 08:52:41 -0400
X-MC-Unique: 1SUewF8KN4-Yvov2EMSs4Q-1
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a08f88aeceso1577405ab.0
        for <linux-efi@vger.kernel.org>; Fri, 13 Sep 2024 05:52:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726231960; x=1726836760;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wl05HquAsncJfGKJSFBrSFOKrrN2t2JKKgtLUktSM2A=;
        b=RxDUBQN0mccdll9Dp928MlImGjYMF/gxxxsTpVWDr0SXntONKIJASYFvZvevk6Rwlr
         BNPM7axaZll6aCN0bpFo3J+taQQekzTcNF4mSyFoIfnxn9qIhW005MRlpc9kjfNO+OGy
         MPtkkGez6Hq7PDVJ0vSzkPnveJBAiBd+3WFA7B0hmO6M0ujTVnkErUbKpg3KVPrzQET5
         LrveWeU2tgmxV8Om5EgLbU/OVq0fiO2X3PvGkOMtfn1GpSGyUNhVqTi9eyYgcYl+es+z
         t0BYylS/O/AOUJ8fcdDQxwiZ4lIZY79qZ4kn+dXVt85DVVLJ9RhYpdXQOnepAUP33A9X
         AMsw==
X-Forwarded-Encrypted: i=1; AJvYcCXPssIEIHJpq3egbGVqzpiCFM74aAfJybM+/cw4IJVQcnd/XMgv9obY3m3pRTM6PF/VCqeaV/PHLzA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzyjc8JmKcqBTnlP5+3Tiv+Wtol6RA/PVMebfqNslNRrhNaeNgQ
	XLf//oTUExn3nfuwkH/S3gLwgU7TOqsNKpvj4rzLbvXzjwypDMiJDGNJPdcSOgbvmZbpUYH0heU
	mp+QaIVuOg64Asn1lZqxbnRy5+JHZmkS1Com68X+sPdLPX05MvUi8vD3ft48XeSyj1H1s5rCt+E
	Y5m4iMpcPAublFO+cTB7FhMcqHDaCy9rliZ1Wxm+Yc
X-Received: by 2002:a05:6e02:1383:b0:39f:5abe:ec25 with SMTP id e9e14a558f8ab-3a08495478amr60011655ab.19.1726231960114;
        Fri, 13 Sep 2024 05:52:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwLSNinCxdMGjUdbfB8K3Nj35P1O2ZHOuUti0jQxahFf7ERb5uddFQ5NioJygZfBUzuO8uwTkyZu28jvB7vZ0=
X-Received: by 2002:a05:6e02:1383:b0:39f:5abe:ec25 with SMTP id
 e9e14a558f8ab-3a08495478amr60011405ab.19.1726231959796; Fri, 13 Sep 2024
 05:52:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240911104109.1831501-1-usamaarif642@gmail.com>
 <CAMj1kXFVyQEwBTf2bG8yBXUktM16dzrcPH-Phz_toAsCK-NfMA@mail.gmail.com>
 <2542182d-aa79-4705-91b6-fa593bacffa6@gmail.com> <CAMj1kXGi+N6AukJt6EGQTao=-1Ud_=bzwPvdjEzhmzEraFU98w@mail.gmail.com>
 <20240912-wealthy-gabby-tamarin-aaba3c@leitao> <CAMj1kXHh-Kov8c1pto0LJL6debugz1og6GFMYCwvfu+RiQGreA@mail.gmail.com>
 <6b2cc4c4-4354-4b29-bc73-c1384b90dfc6@gmail.com> <CAMj1kXG1hbiafKRyC5qM1Vj5X7x-dmLndqqo2AYnHMRxDz-80w@mail.gmail.com>
 <CAMj1kXFr+N9LMj0=wULchYosUpV0ygZSKUj1vdUP0KWEANKasw@mail.gmail.com>
 <CALu+AoS9+OxPmVJB9fAJFkjsX9xUVw6K_uXiOi0-XsK6-b4THg@mail.gmail.com>
 <1c37546a-e15e-465f-bcbb-6f39c0fcf82d@gmail.com> <CALu+AoQ_Db=1naa1YffvdV7ziY8FPzugUutw6ggg8O5P0Z2ofA@mail.gmail.com>
 <CALu+AoSdN4Zh5gPbyTGS8gJ7wDFfOq81ANNH4wmv3z1vs-34Rw@mail.gmail.com> <c76e9653-d991-4319-8924-5883e6829d17@gmail.com>
In-Reply-To: <c76e9653-d991-4319-8924-5883e6829d17@gmail.com>
From: Dave Young <dyoung@redhat.com>
Date: Fri, 13 Sep 2024 20:52:48 +0800
Message-ID: <CALu+AoStijsAxNvX0h2w7jBt-4sHr0O9AEtyyoxNbLBtgmZB7g@mail.gmail.com>
Subject: Re: [RFC] efi/tpm: add efi.tpm_log as a reserved region in 820_table_firmware
To: Usama Arif <usamaarif642@gmail.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, Breno Leitao <leitao@debian.org>, linux-efi@vger.kernel.org, 
	kexec@lists.infradead.org, ebiederm@xmission.com, bhe@redhat.com, 
	vgoyal@redhat.com, tglx@linutronix.de, dave.hansen@linux.intel.com, 
	x86@kernel.org, linux-kernel@vger.kernel.org, rmikey@meta.com, 
	gourry@gourry.net
Content-Type: text/plain; charset="UTF-8"

Hi Usama,

> > Anyway I was not aware very much about the firmware e820 tables and
> > kexec tables when they were created.   I suspect that a cleanup and
> > revisit is needed.  I will have a look at that.
>
> Yes, I feel like there is one too many tables! From reading the code
> I understand that /sys/firmware/memmap should contain the untouched map
> at time of boot, i.e. e820_table_firmware. But I would be in favour of
> getting rid of e820_table_firmware, and just having e820_table_kexec.
> And /sys/firmware/memmap gets data from e820_table_kexec.

Agreed, I have the same feelings.

Thanks
Dave


