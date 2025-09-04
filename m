Return-Path: <linux-efi+bounces-4683-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C17F8B43261
	for <lists+linux-efi@lfdr.de>; Thu,  4 Sep 2025 08:29:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82199567728
	for <lists+linux-efi@lfdr.de>; Thu,  4 Sep 2025 06:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B629F265630;
	Thu,  4 Sep 2025 06:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pRTJ7WpU"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4951DE4EF;
	Thu,  4 Sep 2025 06:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756967368; cv=none; b=VZhNcUXI3X50kibhT+um1rGgSRH5cFv23gTg1NBAXNTTeFCjc3xhgmhTmsK5W5uq1X/T9zxM/nGFaa7GqYfL5TxzF2reDpFfFXb7GwTsjB7FnRqPM1EBq3SBf8fILwZ83tulzsm3bciCDiYEOPBXVE8AUutR0PRs01zBil724uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756967368; c=relaxed/simple;
	bh=Cm1nfbweuODePUoeyta314ZQ44Xg43nKAoLw+2/YGaE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VBakO/9Iil6VBPV/RQJuTrg8p/dQRcbfenh1rkNarGbTniKTvH+8//bLe4yV9+YIXkXu7ywTVvO40BEBvh0ubgTI3FVSh2ko1VElbkwRj/7sOkn/hH1Fr9yrA6wQEekV43zVeB7dLnT7DGD0PNXKHivylDCyAsDQ+rW7pt2ZEl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pRTJ7WpU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09686C4CEF7;
	Thu,  4 Sep 2025 06:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756967368;
	bh=Cm1nfbweuODePUoeyta314ZQ44Xg43nKAoLw+2/YGaE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=pRTJ7WpUsJvxX2CDbCWqgQeZm66JxA1uUklJIt+wsDdt4c+3wRO5PrCk+0mW/zEqr
	 xroW3LQXQelR4FDVYyQkQUNstlXsvtWlAjEjfCBsCQtPB+jCPjciHaq9jhepkX6l2G
	 6oHSuA5npB8Kwxvt4a3fKz4cG5IHYJNZ5h1Md6lCSCAE0mqKEilQqZsVaekSapPTAG
	 xrSgkc17ZPz4AScbw0a1G9uEgt648+fhnQmJz2r/Wdot7QPpgANEPMVTzK2Dd89ybW
	 r3AmutXJ0gU91YS4a0L6Y4ZN9UP9/+Jh+imY6H81ebVzSsK4nHZFCMRSpy++jzeLv/
	 YlwRXXSvEC54A==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-55f6507bd53so701110e87.3;
        Wed, 03 Sep 2025 23:29:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVL0KsZzWAyKWsYgYbLwLT+QnVR9AWMauE/g5+DwPB+Zf7bf7WWdfgni8zg8phA2gxKOt7KR6iXt9773T6l@vger.kernel.org, AJvYcCWXSSEnk9xK47ryz6uwU3tRMDbJQ1xl5MFd0Adxq9tZ6g0L9T+JUY5lNsEBN0WD0AYnXbsWkwpGIvc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyar3lCGlwnyDqy3U51SkmI7ncS/1/iBEPEOgLEeu57UE+czqU2
	mmSVTzXUghHAHudZp/3+H/2iU0wNVAN4z/ZibgeWDLBqOupEjeQFqqX3VGpIuaHAs40BmPvTSoo
	XyzSWVi6NFrbcOwjjOLuj/n8yeoFuYkk=
X-Google-Smtp-Source: AGHT+IEin5zziIBrILihnKQAmq+TjAaoGyz7Un9p07Y7iCns+HvzLeA8Na4wn5bK1bSXOroLCm8HGKhljNEv/UW6YrU=
X-Received: by 2002:a05:6512:4608:b0:55f:61de:5359 with SMTP id
 2adb3069b0e04-55f708bcd00mr4426469e87.24.1756967366381; Wed, 03 Sep 2025
 23:29:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250828102202.1849035-24-ardb+git@google.com> <20250903162200.GIaLhrKOJeL6ThYHa1@fat_crate.local>
In-Reply-To: <20250903162200.GIaLhrKOJeL6ThYHa1@fat_crate.local>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 4 Sep 2025 08:29:15 +0200
X-Gmail-Original-Message-ID: <CAMj1kXG2VVtZsrVAi4DhFbS3ymqd3xZoY9VTuRgfHP=pXFQZow@mail.gmail.com>
X-Gm-Features: Ac12FXxGrb-Lx6UrWJrEnCAaeWAMBlOgbHm3-QzwOp3zp3Ev44riq2ANPN5KGhU
Message-ID: <CAMj1kXG2VVtZsrVAi4DhFbS3ymqd3xZoY9VTuRgfHP=pXFQZow@mail.gmail.com>
Subject: Re: [PATCH v7 00/22] x86: strict separation of startup code
To: Borislav Petkov <bp@alien8.de>
Cc: Ard Biesheuvel <ardb+git@google.com>, Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>, 
	linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org, x86@kernel.org, 
	Ingo Molnar <mingo@kernel.org>, Kevin Loughlin <kevinloughlin@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Nikunj A Dadhania <nikunj@amd.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 3 Sept 2025 at 18:22, Borislav Petkov <bp@alien8.de> wrote:
>
> On Thu, Aug 28, 2025 at 12:22:03PM +0200, Ard Biesheuvel wrote:
> > Changes since v6:
> > - Rebase onto latest tip/master which incorporates v6.17-rc1a
>
> ...
>
> So, due to the interactions with the Secure AVIC stuff, I've been doing some
> patch tetris. Two patches: the first one goes ontop of x86/apic and the second
> one goes ontop of this set.
>

Looks straight-forward enough ...

