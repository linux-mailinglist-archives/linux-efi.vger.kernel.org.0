Return-Path: <linux-efi+bounces-251-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DB10E8184F8
	for <lists+linux-efi@lfdr.de>; Tue, 19 Dec 2023 11:05:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B7C0B20F6B
	for <lists+linux-efi@lfdr.de>; Tue, 19 Dec 2023 10:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 521CD1426B;
	Tue, 19 Dec 2023 10:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W16EEzuA"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C121314A84
	for <linux-efi@vger.kernel.org>; Tue, 19 Dec 2023 10:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dbd56e85ce6so322766276.1
        for <linux-efi@vger.kernel.org>; Tue, 19 Dec 2023 02:04:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702980298; x=1703585098; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FtmePwAcnzygp3Qmz7bxCILAS5QH9CerThq3NksI2Vo=;
        b=W16EEzuAH9Fb/xrsY5IhMp32duwdtJGahaqeBn40/BaoLNAEnmebXh9Dv2qVQsl9Ur
         L8PW2LNuMjQUgTzuYvxkPKOcgTHBAh0eH++sCjRnUAs8v/Jw2xhrJIfq9vnMS/r5e6qI
         cI2U0z6w0riR2wVdjhjzAJBvAmM/IDenFr3pJkFPlCCfqWBVrnZxD/GBA1CiMkgrh4w+
         yhun6CSbGqYP3xV7Oq5jrcDOWdBX4fh0QUElNG9xmlLlMXgf4mrKtoBz50y/2cAZgbLz
         7M0df//NtTy2LaP9/XsJggHu8RTEE/OxlbiZlDv1vYcQpEvqeDPbKynkqBBr1zjIijej
         L6zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702980298; x=1703585098;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FtmePwAcnzygp3Qmz7bxCILAS5QH9CerThq3NksI2Vo=;
        b=MG3bxp8YBuKPWcUrVNuT89iuoe27hKe8+jd2gfJWllS3X47AIIgFslOylCyWBXy/ob
         JZ/ITd5lrB8obgu9+q32XMxY4C4mvsiAaoJXkpLhBreI2KeUEgSBBpz+Szq0c9dpbloH
         1vDauR7UW+8wOKWwKkCoSBXhagkxPg718kRzj6OIVndnxOmQQ6YuhPUM+dHTcFgo1TQ/
         lU2YfLcpvx1fm9hP1rivoHHrdUE29DwTv5qmD5B1V7kauWaIg+4FpFl8DQ7oJmH5MeKc
         s0AYrg742h5nAxK2QwwBOUEO3l8Gmu1tEztDySj7Tcce6dmql+86vm2dbVR2ZDrWmUp/
         KuqQ==
X-Gm-Message-State: AOJu0YycPIogldDPDz5FgG3UeKfHj75iEUS7hq7u1L1XK2wkPH2bzZW/
	btnQ1PKH4yUAUho+F/sY86uwmgGtroB6WFT/KVY=
X-Google-Smtp-Source: AGHT+IFwb2ec+zfr6Wfw/Fdkw9zjx4Jzpv7RCdgcJx+nY0F9EihKgtIYNF8ulPoYjUAKnRFVPlwImVX0EEo0veHmIng=
X-Received: by 2002:a05:6902:98e:b0:dbd:4caa:ef09 with SMTP id
 bv14-20020a056902098e00b00dbd4caaef09mr1061525ybb.9.1702980298645; Tue, 19
 Dec 2023 02:04:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231219091405.39867-1-wangyao@lemote.com> <CAMj1kXEPdMBkne=ugR_j1Be8Aeh8jCA_ryHvh8rMA-c27i+RuA@mail.gmail.com>
 <CAPWE4_wydoTWHUYPmALp1oii+=ALVy_BTDUO_1wOo7XmkJ=cjA@mail.gmail.com>
 <CAMj1kXEL2nuVyNq1O=ytrCr3xh3tA6TU6kRFuk07H1EmneRTTg@mail.gmail.com>
 <CAMj1kXFqpJvH0ukOTufsLCTyCk1abct1kaPUV3JTaS6hMb75Og@mail.gmail.com> <CAMj1kXFFb3ksR=HCxiWpfhcjRcx-U=XE5LmZ2AMt9K110QpynQ@mail.gmail.com>
In-Reply-To: <CAMj1kXFFb3ksR=HCxiWpfhcjRcx-U=XE5LmZ2AMt9K110QpynQ@mail.gmail.com>
From: Ainux Wang <ainux.wang@gmail.com>
Date: Tue, 19 Dec 2023 18:03:59 +0800
Message-ID: <CAPWE4_wAa5uYEqkSRkJH+V57jNgjUZgFcrrjtRqRDECTCCASyQ@mail.gmail.com>
Subject: Re: [PATCH v2] efi/loongarch: Directly position the loaded image file
To: Ard Biesheuvel <ardb@kernel.org>
Cc: wangyao@lemote.com, chenhuacai@kernel.org, wangrui@loongson.cn, 
	linux-efi@vger.kernel.org, loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ard Biesheuvel <ardb@kernel.org> =E4=BA=8E2023=E5=B9=B412=E6=9C=8819=E6=97=
=A5=E5=91=A8=E4=BA=8C 17:35=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, 19 Dec 2023 at 10:32, Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> ...
> > I'll queue this up.
> >
>
> This patch does not apply. What commit is it based on?
>

It based on the newest loongarch-next branch that based on the v6.7-rc6.

Link:
https://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.g=
it/log/?h=3Dloongarch-next

> ---8<---
> Applying: efi/loongarch: Directly position the loaded image file
> error: patch failed: arch/loongarch/include/asm/efi.h:32
> error: arch/loongarch/include/asm/efi.h: patch does not apply
> error: patch failed: drivers/firmware/efi/libstub/loongarch-stub.c:35
> error: drivers/firmware/efi/libstub/loongarch-stub.c: patch does not appl=
y
> error: patch failed: drivers/firmware/efi/libstub/loongarch.c:37
> error: drivers/firmware/efi/libstub/loongarch.c: patch does not apply
> Patch failed at 0001 efi/loongarch: Directly position the loaded image fi=
le

