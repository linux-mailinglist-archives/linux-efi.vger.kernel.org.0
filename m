Return-Path: <linux-efi+bounces-2324-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F469E8FC8
	for <lists+linux-efi@lfdr.de>; Mon,  9 Dec 2024 11:11:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5F88164C61
	for <lists+linux-efi@lfdr.de>; Mon,  9 Dec 2024 10:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39A8E216609;
	Mon,  9 Dec 2024 10:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NdoGepkp"
X-Original-To: linux-efi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B08512CD8B
	for <linux-efi@vger.kernel.org>; Mon,  9 Dec 2024 10:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733739059; cv=none; b=L8g43G/tuAVssoMxm/Zxr3nxbzvLON3lgFtK+CqHP5x4WXMUrLlogebU2Ckg+KPbFluEFKweU4lr/HyW03dNH08NHuh4NOwL1LLLg+4oAK9dJZL0GDYMYkU3DdGfipHQMhSMNfX9yxxqq1MeLUVchbPYct54IJZ3krcIpwzyvCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733739059; c=relaxed/simple;
	bh=W17Qqo7fcNsBiPvy73UUnIGpniV2XL3I0aAaRvXF+Wk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I2JWvWRcQGGXdC9+0AI9cWrpmzO9r+M60ymteybFTS6sVbP11mFO3CPM+7D07z8C3qrQ/Rf7qLXckoxwGyX93PabDaMjBqTK/IlsC4D0rWTQv96wMuyckpTSDUNaCz2eqrwVZ3qHkoHvi07D09p7OJlFYoRJjmgpCoACFDgLeOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NdoGepkp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733739056;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zRbXOtZYe7gmIHphj8O5GHdmaSqxJGIHrPRbH6RBWO4=;
	b=NdoGepkpRlCi6QEiAQ0Gj3xtdt/Z6ecfS7V7H3jejSCRcOFj0ehzP7HG/F3ZhRCBni+XM2
	eknCyH1+Iwi0iX/eyRb6K+mpE704EQXl8eYuC7UX+4UaUmUDQzOQD2WK3lu4UkeBPlyPdF
	aqNLdcZaGR2ifDDdBp1XHzsL6GMxPUk=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-244--LKuaFmdPU2Mii4B9w00kw-1; Mon, 09 Dec 2024 05:10:55 -0500
X-MC-Unique: -LKuaFmdPU2Mii4B9w00kw-1
X-Mimecast-MFC-AGG-ID: -LKuaFmdPU2Mii4B9w00kw
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a812f562bbso43498815ab.1
        for <linux-efi@vger.kernel.org>; Mon, 09 Dec 2024 02:10:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733739054; x=1734343854;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zRbXOtZYe7gmIHphj8O5GHdmaSqxJGIHrPRbH6RBWO4=;
        b=vBv1Ik6V0B2ROoJQgA3ycIn1Le8blbk1OmLv95dtLNg0WvoXERtVXY/4RDQIghvvPO
         KVxRpiL8dcXbUpyfKYFKYFYPDOISdHR8k2mke4k4SGo4lP+xBWKUSc91fb/7u8uknj0X
         n5HWX/fgXCuIeiF9YxcnssJf2Jys2vgDUa8PnN47+nZhsblEmHgRWBY01E6YNuD3S+gO
         X+9AybPwkxkxjx1MwspoDt8OLUKkcW32kFVsDsdUXm3sbE2T38VfxdJlaRnZGf7aTEwx
         bUhdeJ3KM3U69TSMgVmvHEL7qYMKMT2pw79uJxkJhF7Ia04TvWW2kPVp2Dx0iZ3eUiSV
         Jx5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWT5XiUUTxMgLAB+4CNojD6ZqkSjMdpbRpY+jLRfbZjz4vi6aqe2e9K8+AxZHSnEMqgh1w6eiqBr0g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcEAvxU1+q6wZBG4FmNc7hBHGPYQvaX92KGblGQPS6W0K38PVX
	vaci7nj7Of8yNX5SQwBw6ZXCNhqu3cYhAcMl8XKnBlBj3gX79Kztq0c1DapEkPkWjdK8mBjQvld
	FwYFAftJwccN7bqNGnfEN0ddjGhJpm5msRpHeEADfk1XaZJKP+ZnjNwHk144mEeN+6xy2UpLFAA
	BMAp6lS3F5eP3gZv4cnhXRoQcN/OlmGjrB
X-Gm-Gg: ASbGncuxb9GqJIknMB0FpXZjydM342BF8llWvR2hu4LVOA5h9gxdbahQjEcRqMMC/sc
	auYhsVKCFpSVEfI15pykabSc+gQ49SZ+5
X-Received: by 2002:a05:6e02:1d05:b0:3a7:e7bd:9f09 with SMTP id e9e14a558f8ab-3a811c7a239mr126851275ab.5.1733739054424;
        Mon, 09 Dec 2024 02:10:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGgbP2tbgNP0ShTOvUpDp+ZaEc7dORt9fPDzWS3aygCQ7tiL/LOD3Ob4B9Hsz98dtoLqTLj9/797vK7kcBsRGI=
X-Received: by 2002:a05:6e02:1d05:b0:3a7:e7bd:9f09 with SMTP id
 e9e14a558f8ab-3a811c7a239mr126851055ab.5.1733739054062; Mon, 09 Dec 2024
 02:10:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241206021000.8953-1-piliu@redhat.com> <20241206021000.8953-2-piliu@redhat.com>
 <CAMj1kXGFnwdQZzb_t5kC8nGyDz+MQ0wq6s2oTGNBmV7ebVgSGA@mail.gmail.com> <cc6cpx74vzfzivvob4d3smutdjisvgjz6wjob5tay47ubb5lje@exjqpfyxdg3w>
In-Reply-To: <cc6cpx74vzfzivvob4d3smutdjisvgjz6wjob5tay47ubb5lje@exjqpfyxdg3w>
From: Dave Young <dyoung@redhat.com>
Date: Mon, 9 Dec 2024 18:10:52 +0800
Message-ID: <CALu+AoS6hq1=cGvxkQJM18QbbQwzFSs2wJOGq5NdyS0tepthZg@mail.gmail.com>
Subject: Re: [PATCH 1/2] Makefile.zboot: Sign Image before packing into
 EFI-STUB shell
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, Pingfan Liu <piliu@redhat.com>, Peter Jones <pjones@redhat.com>, 
	linux-efi@vger.kernel.org, Will Deacon <will@kernel.org>, 
	Masahiro Yamada <masahiroy@kernel.org>, Baoquan He <bhe@redhat.com>, 
	Eric Biederman <ebiederm@xmission.com>
Content-Type: text/plain; charset="UTF-8"

Hi,

On Fri, 6 Dec 2024 at 17:24, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> On Fri, Dec 06, 2024 at 09:03:30AM +0100, Ard Biesheuvel wrote:
> > (cc Peter, Gerd)
> >
> > On Fri, 6 Dec 2024 at 03:10, Pingfan Liu <piliu@redhat.com> wrote:
> > >
> > > At present, the kexec_file_load of either zboot or UKI kernel relies on
> > > the user space to parse and extract the Image, and then pass the Image
> > > through that syscall. During this process, the outmost signature on
> > > zboot or UKI kernel is stripped and discarded.
> > >
> > > On the other hand, a secure boot platform enforces the signature
> > > verfiication on the kernel image passed through the kexec_file_load
> > > syscall. To cater to this requirement, this patch applies signature on
> > > the PE format 'Image' before padding.
> >
> > The whole point of the EFI zboot format was avoiding the need to sign
> > the compressed payload.
>
> Also note that signing things that way does not work with the usual
> distro signing workflows  They typically do first the whole build
> process, then go sign the final kernel image with a somewhat evolved
> process because the signing keys are kept on secure hardware tokens.
>
> When it comes to UKIs discarding the outmost signature is bad from a
> security point of view, because that is the only signature which also
> covers the initrd data.
>

As long as the signature can be verified with a trusted key it should
be good,  also not everyone uses initrd, a kernel without initrd and
with embedded cmdline works just fine.  So I would support that for
the mainline no need to care too much about UKI format.

For the different approaches we already see, it is not possible to
have something ready soon in the near future so I would support either
Pingfan's solution here or the original patches to uncompress the
zboot in kernel code.

Thanks
Dave


