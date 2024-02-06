Return-Path: <linux-efi+bounces-487-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D2C84B543
	for <lists+linux-efi@lfdr.de>; Tue,  6 Feb 2024 13:33:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 963101F262DF
	for <lists+linux-efi@lfdr.de>; Tue,  6 Feb 2024 12:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BDA01339BA;
	Tue,  6 Feb 2024 12:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iEfCGrGG"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332E01339AA
	for <linux-efi@vger.kernel.org>; Tue,  6 Feb 2024 12:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707222423; cv=none; b=STp2Fxv0vCARUFwsszrLDYIx/WYCr0y6t4YNWttQyulTDzYRYgPyRNn15g4EGTLzV6oY5RtAmtmdA04zkl2kDwlZJ75qzPPwyHSsoinaKOd210N47H1U36tnLKQtB3Aw6iIkuTTotfmd7K0Nj7lmg2X8i/oOEQP08Ltl9vzh9hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707222423; c=relaxed/simple;
	bh=vbDXgZpwmGgtDcgOtZeQwljcLbRORjbw3DwiZxDjIvs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HL+IWtpf/WGDwoWR0TjG9MRts6M+n5hkLwaAPwfjrt0kiKke3r3eI82MwF2G7HOmwYrrBDGUgalynTscdJY2+QijmbydNXlmx7F6Lup019BZsRX8oLYG0tLxbH+/9jahrkb5EixONCGBLMYlCEA6jF3MwZEexoLI3s9z3ZZyWPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iEfCGrGG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F2DCC433C7
	for <linux-efi@vger.kernel.org>; Tue,  6 Feb 2024 12:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707222422;
	bh=vbDXgZpwmGgtDcgOtZeQwljcLbRORjbw3DwiZxDjIvs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=iEfCGrGG8I5XQWR+RkjoZAjb4U00tfoXR0SNChptIK+iL0ssOBkOMJzf5Tko8axKJ
	 pmam+Suk4liDVX4L4sSW8NdCO8ZbwIF61VHn2St2z6/S1EGTKruIGqWCTCdICs5qKf
	 Ri6U+ytniiJUELtE57qxYwGpLVzSMDFMJ+qTb8mD3j0noTgFySkbtXbBBW5YyLNv/+
	 mhvJqyVYWLkA4WoR+diEla5pp4U6uoGxRnZG0p36LF1361fnk1wgnIteQAceSh9Z5Q
	 8sYtRLP4xLm1EqX728p/tiBzGyFzKoqGdKW836O8KM89oyRbU5yeSRVSUIpS+LWsXu
	 HTAq+KK5Klqjw==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-51124db6cf0so620077e87.0
        for <linux-efi@vger.kernel.org>; Tue, 06 Feb 2024 04:27:02 -0800 (PST)
X-Gm-Message-State: AOJu0Yw6ehgVvmm99v5EYUH05aqTZvfOl/qMBDDP1bY+jTvoI4ELRrSm
	KHvi7oM+EJtMtPcznWh85/1829QhEO7pAX9mrQouWenCaJIxBszsTlj1D5lQv3+FVa4X4Yp6KvD
	m30amRq+qwJ01kygc0zOQdt8LGIM=
X-Google-Smtp-Source: AGHT+IFlkq9rDrSog6G5EyXl3ygO4OX8H9cueW9kQVjyf+V3M4dwQqOAUA1/kQZAUBNYa3p5jzhwLU5/dpGQ/EhHeBE=
X-Received: by 2002:ac2:5dd5:0:b0:511:49e1:6bbe with SMTP id
 x21-20020ac25dd5000000b0051149e16bbemr910647lfq.1.1707222420619; Tue, 06 Feb
 2024 04:27:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1707141974.git.baskov@ispras.ru> <82e66a8c9ae70e416eb8ae5229cf5a93f17921b9.1707141974.git.baskov@ispras.ru>
 <CAMj1kXHTyq6=hVOYa3u2y0GRcrG6wCFA8OqrELZXQD+EGwdMuA@mail.gmail.com>
 <62e0169a301b68f2b985d1a8659f1363@ispras.ru> <CAMj1kXGg4c=4Tk4PCSJRCpMTRQ-M2c54QqrfRuOzZoWBYab3oQ@mail.gmail.com>
 <CAHzAAWQJ-vCtCXBA0QL7asRwejE7NfEuaT2zhCBa+2Ek5gHqaw@mail.gmail.com>
In-Reply-To: <CAHzAAWQJ-vCtCXBA0QL7asRwejE7NfEuaT2zhCBa+2Ek5gHqaw@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 6 Feb 2024 12:26:49 +0000
X-Gmail-Original-Message-ID: <CAMj1kXFTKv4BYB8O2tSQHPc98vV3_pJrb1qd1eTvSoHyZcALcw@mail.gmail.com>
Message-ID: <CAMj1kXFTKv4BYB8O2tSQHPc98vV3_pJrb1qd1eTvSoHyZcALcw@mail.gmail.com>
Subject: Re: [PATCH 1/2] x86/boot: Order sections by their RVAs
To: Mike Beaton <mjsbeaton@gmail.com>
Cc: Evgeniy Baskov <baskov@ispras.ru>, Alexey Khoroshilov <khoroshilov@ispras.ru>, linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 6 Feb 2024 at 12:16, Mike Beaton <mjsbeaton@gmail.com> wrote:
>
> On Mon, 5 Feb 2024 at 15:23, Ard Biesheuvel <ardb@kernel.org> wrote:
> > Thanks for confirming!
> >
> > I tried your patch too, and it makes the signing tools unhappy (see
> > below), so I am going to stick with my version. But thanks for sending
> > a fix in any case.
>
> Tyvm Ard and Evginy!
>
> @Ard, Could I ask whether this fix is definitely/likely/probable to go
> into Linux kernel 6.8 final version? (I don't know as much as I
> probably should about release cadences, and relation between release
> cadences, for kernel efi vs. kernel other bits!)

This will go into v6.8 as a fix and be backported to v6.7-stable. Once
I am confident that all the EFI stub changes for x86 in v6.7 are in
good shape, they will be backported to v6.6 as well. (v6.6 is a long
term supported stable kernel)

