Return-Path: <linux-efi+bounces-3316-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D20A86F9B
	for <lists+linux-efi@lfdr.de>; Sat, 12 Apr 2025 22:34:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2FC717208B
	for <lists+linux-efi@lfdr.de>; Sat, 12 Apr 2025 20:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B845221D3EE;
	Sat, 12 Apr 2025 20:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qzI6W2Gx"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890E9219A7E;
	Sat, 12 Apr 2025 20:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744490023; cv=none; b=ivRIHXClhY2ihO121iFi6jAYRRaUd7lLIhpVl+ehqwTSDybNwi398S6bS3jM3q0dM3LlTMQmmARS3/pUXOAx4eNNv5ct445uVA968ZyUrZdYxca1RhryxNhM/ektsABlLy5OB3LmqjXIqyOsirZvCpcftmvH2ATEOIvpi1oqoU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744490023; c=relaxed/simple;
	bh=6XimQTtJs6xbHmZKKURhprxY8wMeuMAlIIac2zANoRE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EvzUboOQAj1yJW3mo4kxtzF3/NMATsUQGpIRkDUy6+jCo91XcS7ntcVrOlo1DCRjc+UjEqdwNDR73ezEf4qs2Z6lerU8/XM6TBG4CmW4tu8A4w5NYzBpBWr7GRUbUJypUeuhFtQBM52w9v9D2MPdwDuz6iBB7H4i3HPxQMWaTdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qzI6W2Gx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA1DEC4AF09;
	Sat, 12 Apr 2025 20:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744490023;
	bh=6XimQTtJs6xbHmZKKURhprxY8wMeuMAlIIac2zANoRE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qzI6W2GxFZe7Y7Bt2nchUdrOxAfVlH9fo5iXBlzQU4KPF7Ti4sDvqtyLJmUdZ2KnU
	 E/IHfP9VcjYY4BRRwbA7FPLIP0lkZhTC87mIaaunCt2MCObOjZDrhlg2Q/Sg7VBrqQ
	 hn0vOOWCIUKvAW7lfFllZMmH65yN5yTHRh50gr0fBulaZoLWiODFbg2yKi5e3zocWT
	 wVfLZslyrr4E7cA7ly4ZiRUfqYBasR58LdGEBmP/2DuCP9jdFqpbXjSQw/Cy/21cCX
	 ouLVQNlslkRPXlwO/SySPi3r7NoD0TTmY0m5uf6Ho4fU3eSfVk3oSDBXqXm/Bbp5u/
	 UV31uyGke6XBA==
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-30db1bd3bebso29139471fa.2;
        Sat, 12 Apr 2025 13:33:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVVZgtLAmo1Okb1qN8MZ6hXBUldgfQ/yWJvJSGL17foQpbjINE4iMXx/HnTloKPsdXGMk4TT7xifkY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyY2CxV73gofvaNV/Ih7lryMSPFqSSWCUkFoJigGQhMSJohfqpE
	fKvAPD6FkAd3gWv6Fv6atHAmPTKLykjfh1EN+ToMJz926sbIhz3CkbqYOnCjb5QCW6vusFHVkZX
	yCjXRfmvYRSF7t338+KOX4jw9S88=
X-Google-Smtp-Source: AGHT+IHmpDAy73HDhi7dwNSeIsexjnMTgwa7h8CPnbLTpXGzUbdsBvIZissssAOqOJt4oyJW5vCI2+X2aAoq++Y4Rk4=
X-Received: by 2002:a05:651c:3228:b0:30b:d40c:7eb4 with SMTP id
 38308e7fff4ca-310499d6114mr21750281fa.7.1744490021355; Sat, 12 Apr 2025
 13:33:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250410132850.3708703-2-ardb+git@google.com> <174448976513.31282.4012948519562214371.tip-bot2@tip-bot2>
In-Reply-To: <174448976513.31282.4012948519562214371.tip-bot2@tip-bot2>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Sat, 12 Apr 2025 22:33:30 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFEXZ8cGMwz6N_ToYp0Wf5Vr9UBFRueWx_MtrwbDLq+LQ@mail.gmail.com>
X-Gm-Features: ATxdqUFuMP_zc7wHR3uTK_L5UdyRgbyFnE-6Jht5tyB4KrRQZUih96htAF2TRyA
Message-ID: <CAMj1kXFEXZ8cGMwz6N_ToYp0Wf5Vr9UBFRueWx_MtrwbDLq+LQ@mail.gmail.com>
Subject: Re: [tip: x86/boot] x86/boot/sev: Avoid shared GHCB page for early
 memory acceptance
To: linux-kernel@vger.kernel.org
Cc: linux-tip-commits@vger.kernel.org, Tom Lendacky <thomas.lendacky@amd.com>, 
	Ingo Molnar <mingo@kernel.org>, Dionna Amalie Glaze <dionnaglaze@google.com>, 
	Kevin Loughlin <kevinloughlin@google.com>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, linux-efi@vger.kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 12 Apr 2025 at 22:29, tip-bot2 for Ard Biesheuvel
<tip-bot2@linutronix.de> wrote:
>
> The following commit has been merged into the x86/boot branch of tip:
>

This may be slightly premature. I took some of Tom's code, hence the
co-developed-by, but the should really confirm that what I did is
correct before we queue this up.

