Return-Path: <linux-efi+bounces-3311-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6092A86F03
	for <lists+linux-efi@lfdr.de>; Sat, 12 Apr 2025 20:48:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEFDE17ECB4
	for <lists+linux-efi@lfdr.de>; Sat, 12 Apr 2025 18:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6FEB21B9C7;
	Sat, 12 Apr 2025 18:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jBIK/gpH"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2EB21ADC6;
	Sat, 12 Apr 2025 18:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744483659; cv=none; b=RrD45yadNXF51EaFsz3F20C96lCZymLWNHp1kCAs5o1yViTlTa6Qizct7D1RyhQ9cKNwJdLhkoPivHf4/A+E3L5YBS2RFvzC4V7YDUzsUOgY5npVwNYQxJKp4G58w1PmMeSZLKcyDCTcVybQh/zs+TkwXngQOdMJCNpm0b6h2wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744483659; c=relaxed/simple;
	bh=C2c3sZO5Ej6/VKECo+uPasXgdXU3ZH2FHWbAOki1+Is=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dOrxe96ZxWKkTfyRT/r1xiRtWWYRwV8ZeNa8hiqbGNNDigegJyXkVmyC+pvb/eOh2EiOvlGAka3iDH/sceUUFZO3LocSvMwit/eXxuuzSILqu+dJSOK6pXvXei8m2hGJIjMvVt2W0ovkZEVPOoBAfXWLBeD3NzqUsN5wLL+zJHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jBIK/gpH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 333E1C4CEE3;
	Sat, 12 Apr 2025 18:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744483659;
	bh=C2c3sZO5Ej6/VKECo+uPasXgdXU3ZH2FHWbAOki1+Is=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jBIK/gpHvJVUvZAYxvVpLyo2ZnBzj4qMX9Jaeeagjqpeo/8S0AHqFPUZESTryp57t
	 8GhjoKrHHuu+dVpiNVc78VSbyHvsFP+WDBuTT5wpKZERRVMz6rwdUB7gcEc6HVddqm
	 l2i29qwuvKwM4Rc/gpG0XyL4JCUkgY0t4sq1jQrCkGhuFzcUPfGgDcCpYFfo9SEUu1
	 sRt0GMpHbWTfwPz/JW61MPA85gHshH2I/8g45OM1NafxtZSncdaKgWKkGN7OXZI27K
	 4khOUp2E2MWuXhy9GS1LXPFqdq04xA/cXBJZ/u1QXb1C2Wze2RYMRanme/aUOQHTON
	 LZrcxEqvVeghQ==
Date: Sat, 12 Apr 2025 20:47:34 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-efi@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Dionna Amalie Glaze <dionnaglaze@google.com>,
	Kevin Loughlin <kevinloughlin@google.com>
Subject: Re: [PATCH v4 08/11] x86/sev: Split off startup code from core code
Message-ID: <Z_q1RthXIbSXY2Eq@gmail.com>
References: <20250410134117.3713574-13-ardb+git@google.com>
 <20250410134117.3713574-21-ardb+git@google.com>
 <Z_pbLAw56NIFo7yK@gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z_pbLAw56NIFo7yK@gmail.com>


* Ingo Molnar <mingo@kernel.org> wrote:

> 
> * Ard Biesheuvel <ardb+git@google.com> wrote:
> 
> > From: Ard Biesheuvel <ardb@kernel.org>
> > 
> > Disentangle the SEV core code and the SEV code that is called during
> > early boot. The latter piece will be moved into startup/ in a subsequent
> > patch.
> > 
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> >  arch/x86/boot/compressed/sev.c |    2 +
> >  arch/x86/coco/sev/Makefile     |   12 +-
> >  arch/x86/coco/sev/core.c       | 1574 ++++----------------
> >  arch/x86/coco/sev/shared.c     |  281 ----
> >  arch/x86/coco/sev/startup.c    | 1395 +++++++++++++++++
> >  5 files changed, 1658 insertions(+), 1606 deletions(-)
> 
> x86-64 allmodconfig build failure:
> 
> arch/x86/boot/compressed/sev.c:263:13: error: implicit declaration of function ‘vmgexit_psc’ [-Wimplicit-function-declaration]
> |             ^~~~~~~~~~~
> arch/x86/boot/compressed/sev.c:266:9: error: implicit declaration of function ‘pvalidate_pages’; did you mean ‘pvalidate_4k_page’? [-Wimplicit-function-declaration]
> |         ^~~~~~~~~~~~~~~
> |         pvalidate_4k_page

Ignore that, I have now read the cover letter too, with the patch 
dependency mentioned there - as kindly pointed out by Ard in a private 
mail. :-)

Thanks,

	Ingo

