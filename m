Return-Path: <linux-efi+bounces-1564-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72A2095ACFA
	for <lists+linux-efi@lfdr.de>; Thu, 22 Aug 2024 07:42:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A59821C22656
	for <lists+linux-efi@lfdr.de>; Thu, 22 Aug 2024 05:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A9E955885;
	Thu, 22 Aug 2024 05:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SnGR8xCo"
X-Original-To: linux-efi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F38543165
	for <linux-efi@vger.kernel.org>; Thu, 22 Aug 2024 05:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724305350; cv=none; b=TKc0QFMLEE9mnOxp13sSIeSEJS02rJN7BXj8l4ZBdNgSC5S4dAPGVvCrw0VrmZ5UfNPOnDNM8GAGUN3nFo26YrayXh0iYTy2fdw5HndUOTYKcE9ct3839+8Qvefxgzg+W+b9Ifmve2oMQChAQjeggDamjzj5wKXB6RXch1gkxzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724305350; c=relaxed/simple;
	bh=F1vzZdH4Kt43rchY2omF6Rwx1ceg2XOFfMB0oV8w5es=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gGAmZ2fqPGp60YbtpaYICnPTfqRv7quEL2YM5TdkMYaAcJupUE1Uaqk0lWYeUkkawrbC6quzRZ9O3bk2ecoKyvmpvNh2GlUE3DlDH9GNF69oFUrVsuBCxBH0dOwO/Yg/wkD3I6DrlVUFJ2jlaHmNWeU+Bwr6kSl/Sm8uim76Ee8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SnGR8xCo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724305347;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=POmJdiV0VSWZbzyF9DzR22AxZLSfVLCRRZmOGu8DXAE=;
	b=SnGR8xCoV2H79HsGta+Ul1dPdlXZppfwKhCCXjRtQPUCjHH5x6wxQuNTbHWxaspTL49CJC
	TB9nL1jXqL0vU5UgJYR/0v2cT4BM18rM3ru5GNkjCR1Dyr9qXjSio6rGazwfM7C41ZiGee
	3nkbI++tU3WtDFV8n7ELAmeM9ZTWLrA=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-foJJCwhiOHSBao1MlXeJaw-1; Thu, 22 Aug 2024 01:42:25 -0400
X-MC-Unique: foJJCwhiOHSBao1MlXeJaw-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7a1d71b96c4so58786285a.0
        for <linux-efi@vger.kernel.org>; Wed, 21 Aug 2024 22:42:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724305345; x=1724910145;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=POmJdiV0VSWZbzyF9DzR22AxZLSfVLCRRZmOGu8DXAE=;
        b=cDsNuounRL1ElQULvW7IRZIwcxxt19wf5YehS9/Y91KGn/wnp4hrAbNbLTxpR/uDTG
         MJh9d4o7l2OLEE5tbPtDbx8y9QH5erNXv7L68fqQnXcHmxgr9kfu/n4CVsr5twJWE170
         dvnpUya2+O6lRpf6pR3l5hfqrceIug9cR3H+F9EvUpH4w2affihMU6r7XxlQkzADhFKk
         8KQpoVLP8nqvV1jVKDdxojnEzs+LXZXWUor/IFNo1zHiW52A/Y1DGy7q8sFO6Hkn0NoA
         JIRRGpxJSmS6+cJmINgT2hp3MwAAYgyvpfhWdhhMTLhYSqJaqfKmX/znidBqTi4NPNqP
         Vbsg==
X-Forwarded-Encrypted: i=1; AJvYcCU42/eghYwQNl6aP0ReGAr6KGITW7CXiZuJGndpjjlSCMsjKderAtTggL7CJd61ZMk+0WB1PI+lVXw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzW7/Fwow2iNDCdhT/plr6xcpPg3MMrGxJ2+sXiq52HTCbwV0a0
	y4lZTg/Lz9ozrH8bOhKRtcsDESe8pWoLg9sYdPO2BX4sWrG03YXS+0TimlBjIMByt+ENMUlmcwR
	S/eeiMSn+tDMWIlDHu1F6tSSraUDkBI+jCkl9CxDGn6ZcM9DIVt64KyhW/tIeFy2MLfoaiZtG6N
	tVsRmVvYlij0hAvI2oQMHeq8czMlLiAh5U
X-Received: by 2002:a05:6214:590a:b0:6bf:6a1d:bd32 with SMTP id 6a1803df08f44-6c155e32b6amr52213496d6.54.1724305345109;
        Wed, 21 Aug 2024 22:42:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IElvJrntPKuDfwVGetI/C58C3ESzxqLa/dqLxQVN4fUwqqoca5WN3EJ+ZSDJ797qfFuc/4TtSX998fGB+XueXM=
X-Received: by 2002:a05:6214:590a:b0:6bf:6a1d:bd32 with SMTP id
 6a1803df08f44-6c155e32b6amr52213366d6.54.1724305344763; Wed, 21 Aug 2024
 22:42:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819145417.23367-1-piliu@redhat.com> <ZsX5QNie3pzocSfT@gardel-login>
In-Reply-To: <ZsX5QNie3pzocSfT@gardel-login>
From: Pingfan Liu <piliu@redhat.com>
Date: Thu, 22 Aug 2024 13:42:14 +0800
Message-ID: <CAF+s44S2Ph1_nFcZYy3j0Jr4yuHayb5zdNu1YXg8ce_Lf3TOgQ@mail.gmail.com>
Subject: Re: [RFCv2 0/9] UEFI emulator for kexec
To: Lennart Poettering <mzxreary@0pointer.de>
Cc: Ard Biesheuvel <ardb@kernel.org>, Jan Hendrik Farr <kernel@jfarr.cc>, Philipp Rudo <prudo@redhat.com>, 
	Jarkko Sakkinen <jarkko@kernel.org>, Eric Biederman <ebiederm@xmission.com>, Baoquan He <bhe@redhat.com>, 
	Dave Young <dyoung@redhat.com>, Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, kexec@lists.infradead.org, 
	linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 21, 2024 at 10:27=E2=80=AFPM Lennart Poettering
<mzxreary@0pointer.de> wrote:
>
> On Mo, 19.08.24 22:53, Pingfan Liu (piliu@redhat.com) wrote:
>
> > *** Background ***
> >
> > As more PE format kernel images are introduced, it post challenge to ke=
xec to
> > cope with the new format.
> >
> > In my attempt to add support for arm64 zboot image in the kernel [1],
> > Ard suggested using an emulator to tackle this issue.  Last year, when
> > Jan tried to introduce UKI support in the kernel [2], Ard mentioned the
> > emulator approach again [3]
>
> Hmm, systemd's systemd-stub code tries to load certain "side-car"
> files placed next to the UKI, via the UEFI file system APIs. What's
> your intention with the UEFI emulator regarding that? The sidecars are
> somewhat important, because that's how we parameterize otherwise
> strictly sealed, immutable UKIs.
>
IIUC, you are referring to UKI addons.

> Hence, what's the story there? implement some form of fs driver (for
> what fs precisely?) in the emulator too?
>
As for addon, that is a missing part in this series. I have overlooked
this issue. Originally, I thought that there was no need to implement
a disk driver and vfat file system, just preload them into memory, and
finally present them through the uefi API. I will take a closer look
at it and chew on it.

> And regarding tpm? tpms require drivers and i guess at the moment uefi
> emulator would run those aren't available anymore? but we really
> should do a separator measurement then. (also there needs to be some
> way to pass over measurement log of that measurement?)
>

It is a pity that it is a common issue persistent with kexec-reboot
kernel nowadays.
I am not familiar with TPM and have no clear idea for the time being.
(emulating Platform Configuration Registers ?).  But since this
emulator is held inside a linux kernel image, and the UKI's signature
is checked during kexec_file_load. All of them are safe from
modification, this security is not an urgent issue.

Thanks for sharing your thoughts and insights.

Best Regards,

Pingfan

> Lennart
>
> --
> Lennart Poettering, Berlin
>


