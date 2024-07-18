Return-Path: <linux-efi+bounces-1465-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68824935135
	for <lists+linux-efi@lfdr.de>; Thu, 18 Jul 2024 19:19:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21C00285663
	for <lists+linux-efi@lfdr.de>; Thu, 18 Jul 2024 17:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59FE4145321;
	Thu, 18 Jul 2024 17:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sglcyTWg"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35DEF8C06
	for <linux-efi@vger.kernel.org>; Thu, 18 Jul 2024 17:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721323194; cv=none; b=KyFByWPH8R1HWCPMBc31IYPIKHIWx+vHbqZqu1YWi1knQMt6HAwIxbM/7iy6+R3UeDM4XjXa7IGtQt4+wQ5DLxWfyNn6CE2sr71b69rOGXWrEDsxUoB9d8WmAKcUJSI+vK+z5NAZ7dCCseCGWXrideJGIxpWcMoii2oVysxn5Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721323194; c=relaxed/simple;
	bh=keIX2+eAoAsKL+d0fzFb7BJ3sbvEkE/QR7C10Odk9Qo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=m9NTtK53rXq2Vf9J+WSGrbVnqkLF+M9AAw9ptLWhUWfGTg+n/HMI6cM2ZVymvFMm4NcWKmDTib7aTsClBttmRGhu/NM1uzZejP1FUqlDR5yxKNxKUAif7ifS00JGldwSR0xtLruPnkZGqg7N2L5j4+WaTzz/Vzx3fTWzzetDs+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sglcyTWg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31218C4AF0A;
	Thu, 18 Jul 2024 17:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721323193;
	bh=keIX2+eAoAsKL+d0fzFb7BJ3sbvEkE/QR7C10Odk9Qo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=sglcyTWg6b2IrV2cQTwxnMPN+5e3yJX6eIthBvycT/RpGBou/LTM0chIL9VjkL3Yy
	 NWd9VQPjwoodC3WCHs+KkT9HQlBhWtq2tpVblk+OgGobvY09EhD5CpImOFljkNPHRD
	 lKCIUw3Q7gxA9/WshpjJxttGrnBNokewQET6O/l4hdDqlVsWxNOYdkNYU+DVONzPdh
	 qqv6YRs2vFFNwwTa/rI8dbgE/gKg3IzjxCbYfEdrUo7MSla8VpvoU8cr4uH+2rRobL
	 f8ReqWXXGLGd6qgNuBpkXjKdUpYG83sKPoOrunLzJHCEfvgxRwA+0tjJCfs0pFlIYb
	 q1MLvA/z2Y70A==
Message-ID: <8c82c558556750751780a9d2b3a50ca548f565e8.camel@kernel.org>
Subject: Re: [RFC 1/7] efi/libstub: Ask efi_random_alloc() to skip unusable
 memory
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Pingfan Liu <piliu@redhat.com>, linux-arm-kernel@lists.infradead.org, 
	kexec@lists.infradead.org, linux-efi@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, Jan Hendrik Farr <kernel@jfarr.cc>, 
 Philipp Rudo <prudo@redhat.com>, Lennart Poettering <mzxreary@0pointer.de>,
 Baoquan He <bhe@redhat.com>,  Dave Young <dyoung@redhat.com>, Mark Rutland
 <mark.rutland@arm.com>, Will Deacon <will@kernel.org>,  Catalin Marinas
 <catalin.marinas@arm.com>
Date: Thu, 18 Jul 2024 20:19:49 +0300
In-Reply-To: <20240718085759.13247-2-piliu@redhat.com>
References: <20240718085759.13247-1-piliu@redhat.com>
	 <20240718085759.13247-2-piliu@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-07-18 at 16:57 +0800, Pingfan Liu wrote:
> efi_random_alloc() demands EFI_ALLOCATE_ADDRESS when allocate_pages(),
> but the current implement can not ensure the selected target locates
> inside free area, that is to exclude EFI_BOOT_SERVICES_*,
> EFI_RUNTIME_SERVICES_* etc.
>=20
> Fix the issue by checking md->type.
>=20
> Signed-off-by: Pingfan Liu <piliu@redhat.com>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Jan Hendrik Farr <kernel@jfarr.cc>
> Cc: Philipp Rudo <prudo@redhat.com>
> Cc: Lennart Poettering <mzxreary@0pointer.de>
> Cc: Jarkko Sakkinen <jarkko@kernel.org>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Dave Young <dyoung@redhat.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> To: linux-arm-kernel@lists.infradead.org
> To: kexec@lists.infradead.org
> To: linux-efi@vger.kernel.org

I'm on holiday up until end of next week so not going to go this trough
right now but I have minor complain ;-)

Please use:

       --[no-]cc-cover
           If this is set, emails found in Cc: headers in the first patch o=
f the series (typically
           the cover letter) are added to the cc list for each email set. D=
efault is the value of
           sendemail.ccCover configuration value; if that is unspecified, d=
efault to --no-cc-cover.
       [from "man git-send-email"]

This will make the commits less bloated and makes sure that everyone you
might want to CC will get always the same set of patches.

I'd also recommend to pick only one list for to-field because there can
be only one maintainer that in the end would take these patches. Change
rest to cc's. Now the process of managing these patches is ambiguous by
definition.

BR, Jarkko

