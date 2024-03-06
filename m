Return-Path: <linux-efi+bounces-739-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 784F48732AC
	for <lists+linux-efi@lfdr.de>; Wed,  6 Mar 2024 10:38:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33B7B281D55
	for <lists+linux-efi@lfdr.de>; Wed,  6 Mar 2024 09:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FB1D5DF05;
	Wed,  6 Mar 2024 09:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e/Xrv7mF"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578895C904;
	Wed,  6 Mar 2024 09:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709717898; cv=none; b=p9fDwFD/waFAOwC/HfN5VqCgXpcxSlHOKQCatYZX6yUne9xDU1STfNJEOqbCNLBwDHFN9jwOrMZiJDZMMV6yOzFkcUfE+HGfz3oNdGKDXte2rFCNO+7mVOPiO5Nm4Vl0obY7xiOOxNR5ekW+6gupQq+6WlP4hhLCnUlTHz6HwSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709717898; c=relaxed/simple;
	bh=/zob1SUIARO/VzvgSwuB1+L/ZOE8hSegEZPs5jeGJ5s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R3vAQzyTrb9yG5otxrKA3Tnxr70ZcQFYIIAE26R9lLGzdu5Fj8cMY7J6pMeBorsBlYNU1o+Fec9RXPh61EWNd7XVN2WpHauxWdbD/f8Dvny8Xi74G8AFRFVYdbRbIi90rXBNF3nW3L/YIRDkjlwTgUzd0skZ/3s9Ks+wkoYkAr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e/Xrv7mF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1D61C43399;
	Wed,  6 Mar 2024 09:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709717897;
	bh=/zob1SUIARO/VzvgSwuB1+L/ZOE8hSegEZPs5jeGJ5s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=e/Xrv7mFP94LYjTU1Bk/SjtCfbIGeno8KVLzstlewUFSknQzRKuxHSrH7U1f4VJSk
	 h5JxvCVz0VUjNhCs3RGvmESG+ln9DOUwdGkiz++81Q6uEqC3lm3j4qYHGqfQEU5yxr
	 C5ip0R0sEf5kovRQxslDIvhGynoImqvLHzcuEuDYetyiePasfh/CsSr9qB2tS/mqLt
	 8fq5SaoiDGkRY7E1wZ29P/q8q9OBmE7oZTv3UuHORgvYn2UIhERSP3etS0sGruoXVS
	 eM3jWWhsZBglaaMdN5NBiwJ5enUPShIqM1Ga5Z+hdSqARVmyWQCSGu3oEs5fAz/Dm8
	 BClRsdTy+X4yg==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5135486cfccso2133682e87.0;
        Wed, 06 Mar 2024 01:38:17 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV16c+YrEZvEjTv2eId6fGrvvvaf+216VdQtMQP1CPvwahXnf6ptW95c1g1KqUnkhGjow41f6i4+qVmRpXkZXc1TLtghfAFASmOSNjkyBRjuWpHCper1kzDAelKUt4jPfdPMAw44uHV
X-Gm-Message-State: AOJu0YwyXEKDH8NSbrtp8BMGG3X1PBppcKvpwN/sEq3k+JgCdy3slvcX
	54MFE3k5FUFTVuqdOEcGt/bBnkbpUAjLnr9a1EOSS2eGjz+pkV5//5m9c2CunEKtsp9KM+sN23+
	FHOTB/uiJVvuzmv/0W8coVidJ2yQ=
X-Google-Smtp-Source: AGHT+IHwgXrP9x0X4xUM5Z3Jn3F723E5zE3hNEQl/1jzIw1B7cvBXWZrrUm6tUYEa01iU5avfoxDPYOFfwuWy2sTCq8=
X-Received: by 2002:a05:6512:3493:b0:513:5873:1a29 with SMTP id
 v19-20020a056512349300b0051358731a29mr1996339lfr.54.1709717896006; Wed, 06
 Mar 2024 01:38:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240306085622.87248-1-cuiyunhui@bytedance.com> <20240306-zippy-magazine-9a4ecfe1758a@wendy>
In-Reply-To: <20240306-zippy-magazine-9a4ecfe1758a@wendy>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 6 Mar 2024 10:38:05 +0100
X-Gmail-Original-Message-ID: <CAMj1kXG6k5SZDYwdxhoJDiNxUuAqBOqqANUiys4YTCk_HCF5AQ@mail.gmail.com>
Message-ID: <CAMj1kXG6k5SZDYwdxhoJDiNxUuAqBOqqANUiys4YTCk_HCF5AQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] Revert "riscv/efistub: Ensure GP-relative addressing
 is not used"
To: Conor Dooley <conor.dooley@microchip.com>
Cc: Yunhui Cui <cuiyunhui@bytedance.com>, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, xuzhipeng.1973@bytedance.com, alexghiti@rivosinc.com, 
	samitolvanen@google.com, bp@alien8.de, xiao.w.wang@intel.com, 
	jan.kiszka@siemens.com, kirill.shutemov@linux.intel.com, nathan@kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 6 Mar 2024 at 10:03, Conor Dooley <conor.dooley@microchip.com> wrote:
>
> On Wed, Mar 06, 2024 at 04:56:20PM +0800, Yunhui Cui wrote:
> > This reverts commit afb2a4fb84555ef9e61061f6ea63ed7087b295d5.
> >
> > Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
>
> Reverts are commits too. You still need to write commit messages
> justifying the revert.
>

Indeed. Also, please revert them in the right [reverse] order so we
don't inadvertently break bisect.

