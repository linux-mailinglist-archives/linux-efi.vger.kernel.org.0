Return-Path: <linux-efi+bounces-2559-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F8AFA082BC
	for <lists+linux-efi@lfdr.de>; Thu,  9 Jan 2025 23:22:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BA513A8DDE
	for <lists+linux-efi@lfdr.de>; Thu,  9 Jan 2025 22:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 120892054E2;
	Thu,  9 Jan 2025 22:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NZ2YUXWh"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15C81991A1
	for <linux-efi@vger.kernel.org>; Thu,  9 Jan 2025 22:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736461360; cv=none; b=h4ulBiPHmLjyUJ660ouxrX5wKVxrzINdjsXwS7Y/qsWqR2zkFqA74cQ7jZHlHbigVxOk6eAL4ClQzmvSdyVnHrypS2zqZCtARPW81+2g76bP3ngzKUNOetKjklTYR0BmwW4hhU++OBCkG81jNHts2fF8MYPWnVILNOxmr2TJJ00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736461360; c=relaxed/simple;
	bh=+DK8bemQetdFY2YNtLN3mIwuepkSd0lscM/CUVt23K4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f1JEAVr6Dv44/FZKZmnUKK/rRwHHWlfbuhSMDPXzncfE6kRRfab2KCCax7+iEXLpp5JrDMICRHMRjHNggcnStdFcR0JxQrdCQKQkjsUokFUiEc7jdposXNHsM1qpA3DFXCgCzbnE43BNK8j8u1enGyTNh6Pc/1pm+Dhk8dipc5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NZ2YUXWh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9051DC4CED2
	for <linux-efi@vger.kernel.org>; Thu,  9 Jan 2025 22:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736461359;
	bh=+DK8bemQetdFY2YNtLN3mIwuepkSd0lscM/CUVt23K4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=NZ2YUXWhHCgNO3MwpQNjVtHxTMpIRakY40+BtDUx94Rkc3oD+8weinm7FJ62LNdjv
	 GKf+qmV7pVqXjy/tIBSszQTSXi8TK2ihAFNCe8emrh/VON4H685vv4AoEqZdrJd0UZ
	 JMk6tsMqse9wfK4uc6b/hWuKD1bHR2NLPjYxILTuIOkZAVv0qkdZmATM8k3bibMxCm
	 E0F6uXek0GmPIJAUvKVdWlvfZS8+TBRaQASvULdTgHudYla1GZvGG5Y913eHLpkL+P
	 JVFhKq1IgsQMvlLztBKLyfvtfM84L0dYiRu0GobQiEac2nqw9t9Wm9QuZRnL0o9kqB
	 zz7NH9B2clF9A==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5401e6efffcso1509435e87.3
        for <linux-efi@vger.kernel.org>; Thu, 09 Jan 2025 14:22:39 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWDtVxFdFYauXDcQzme3frpoNbOmDh3581v8Oyf/WSamU5grwU+7jqvIKjDxJOumgxqdntmLEj955M=@vger.kernel.org
X-Gm-Message-State: AOJu0YybrKy/ivbKFrrTZ+xuRxHi7Ac6ZSeX4NapD0jvYkwrTixtdzm8
	dRodbTZhOgBOYyDNWXnJJXCpXDUedvMMvvD7yb5xSVBw5i9QKHoHgbvpKuPca46kohanjWqXe5d
	0ruAV4V9V9WH3c77DjFHfY8REsKc=
X-Google-Smtp-Source: AGHT+IFEnomjvVid/Z+baiIe6cVHauSYAWr7ETvgc68An5MmgzjzVqJHzt5DdrT1b2eVa3qeVUrgdpeh38J+H5V11J4=
X-Received: by 2002:ac2:4e07:0:b0:542:2402:4dd2 with SMTP id
 2adb3069b0e04-542845b1ba2mr2670930e87.10.1736461357948; Thu, 09 Jan 2025
 14:22:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202501100429.RSwlJMm0-lkp@intel.com> <a712d117c356b7c7843f8bafad26a438be81a1e0.camel@HansenPartnership.com>
In-Reply-To: <a712d117c356b7c7843f8bafad26a438be81a1e0.camel@HansenPartnership.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 9 Jan 2025 23:22:27 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHcm77MLhe-1s7jQ62pd0CxpMiRwD6nDVKiK9Bq-QSMsQ@mail.gmail.com>
X-Gm-Features: AbW1kvZorvIkrkXTcu_kMcwbNajQdPcaHj1Cy2jefcQSxLVRMdW4aQC08I7N39E
Message-ID: <CAMj1kXHcm77MLhe-1s7jQ62pd0CxpMiRwD6nDVKiK9Bq-QSMsQ@mail.gmail.com>
Subject: Re: fs/efivarfs/vars.c:375: warning: Function parameter or struct
 member 'duplicate_check' not described in 'efivar_init'
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: kernel test robot <lkp@intel.com>, oe-kbuild-all@lists.linux.dev, linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 9 Jan 2025 at 22:52, James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> On Fri, 2025-01-10 at 05:02 +0800, kernel test robot wrote:
> > tree:
> > https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git next
> > head:   5e948d5cefebebe2315faf356d7b5180144b17b0
> > commit: 43039cdd1a14ed12c7b506a2d78c7fa708444b06 efivarfs: add
> > variable resync after hibernation
> > date:   11 hours ago
> > config: x86_64-buildonly-randconfig-002-20250109
> > (https://download.01.org/0day-ci/archive/20250110/202501100429.RSwlJM
> > m0-lkp@intel.com/config)
> > compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> > reproduce (this is a W=1 build):
> > (https://download.01.org/0day-ci/archive/20250110/202501100429.RSwlJM
> > m0-lkp@intel.com/reproduce)
> >
> > If you fix the issue in a separate patch/commit (i.e. not just a new
> > version of
> > the same patch/commit), kindly add following tags
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Closes:
> > > https://lore.kernel.org/oe-kbuild-all/202501100429.RSwlJMm0-lkp@intel.com/
> >
> > All warnings (new ones prefixed by >>):
> >
> > > > fs/efivarfs/vars.c:375: warning: Function parameter or struct
> > > > member 'duplicate_check' not described in 'efivar_init'
>
> Sorry, my fault.  If you fold this one-liner into "efivarfs: add
> variable resync after hibernation" it will correct the warning.
>

Thanks.

