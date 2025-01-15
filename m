Return-Path: <linux-efi+bounces-2643-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3636AA1274F
	for <lists+linux-efi@lfdr.de>; Wed, 15 Jan 2025 16:24:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1E321887857
	for <lists+linux-efi@lfdr.de>; Wed, 15 Jan 2025 15:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B285814601C;
	Wed, 15 Jan 2025 15:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OlXqntnz"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF25144304;
	Wed, 15 Jan 2025 15:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736954658; cv=none; b=lcXSWRkYHI0Q+nTtBmklBQl2j4w0UA1WeBsi4aPgI5ZBqlnNiWwth4nXzvPyTnCVuhQoZ7nDy3719OqR2BwqJSByyYOBuS2QhPmc9rXk4k0e37m0jekb3KkcPKdtibOJFUnOoaPrlYcVa01h7cOTf4jnG2WIoAHGJ8h0dJc27WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736954658; c=relaxed/simple;
	bh=2Y4FLaz2EWvS964V0bxEF0sEQ+rpChaLGatf8FvkECc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m94SBDNZPRsW8TsjDkN6GgjO/Srhjtoh0I1XJKVR1mKbIEWD3J98SYD3XtQmJwr3eVul1hYPIgvW+hmJ/yoZ0MVsZQMgwNMaMBjzV/okRSJFWx1unxx8C8O9EpwEfORTRulAv+OxkkaU0zEihaszp4OOWOu45JW1RU1RLbPOyGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OlXqntnz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62514C4AF09;
	Wed, 15 Jan 2025 15:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736954658;
	bh=2Y4FLaz2EWvS964V0bxEF0sEQ+rpChaLGatf8FvkECc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=OlXqntnzsXUUVTl/MKgO7rikxFmMR4pJCkehgh6U2INKRpNaGA+TRIML6+phQpKcD
	 CvJlDwjoI6A5ULbInlGX1VDqQFbJi6s0XA/0J+/v4/vBQwEXhq/iTl+OCzPe9ZoOLa
	 xMLRp5tCQOPATFn9rg31hA+ErprzbQTSBnd3KchfTWSQYrOs8HpH8k/YAECZ7rS9p1
	 K3QvOYJQLXgpklS5QsCDXKwo3Mhw/DEjKErqFoOfg25k79kWiwnqhLl6ZeIPbsQp6r
	 M9w7IU7Cu9lYJGtZY89ZyIzxDh6G/Uypd6LRWI92gEUUQq9iPy3Nl65jeivOWY9RGu
	 C0/Gia5Jv/0IQ==
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-3047818ac17so58897631fa.3;
        Wed, 15 Jan 2025 07:24:18 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXBnHNOw7Z+/39FMvURjTn8Uoq9dnSFg5qeW8MLuskh43YqlqrR1NXNzLPQKtKHfDIBc2Dlz3DifRuoRIE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxXKl04q+zGeErLITg2Xym/TUMIm5COcF+7a+AQVzpTBjq8Rn7
	PPe53/v951Rw9vumkV8DlR0LBPY9uNQS/iwS9rbOo8Aq3RNxRp2mu/IPzTAmiEDdoZM+x15yP29
	mCtowjTs+MC8qwLxMj1KuR109mxA=
X-Google-Smtp-Source: AGHT+IGf51u8Ol1OeSWKS7c7FAAguVs14s2uc2YB/Xbezn86Ps2eHmril+aHAtA95KF1jjo+Dj1hh6+fYCuMagonhNs=
X-Received: by 2002:a05:651c:2126:b0:306:10d6:28b3 with SMTP id
 38308e7fff4ca-30610d62b0amr55884851fa.1.1736954656715; Wed, 15 Jan 2025
 07:24:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250115141650.3658827-1-eleanor15x@gmail.com>
 <CAMj1kXFGrTQHONPCJMvMJ5aaswh1YF9aCcufS_9YsS5F+uYJpQ@mail.gmail.com> <Z4fSfE6mFk1nT9e4@eleanor-wkdl>
In-Reply-To: <Z4fSfE6mFk1nT9e4@eleanor-wkdl>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 15 Jan 2025 16:24:05 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHe3d13vD=7p+5N8KLKBTB3Ka4g8HuW-h8enCrwjVO2uA@mail.gmail.com>
X-Gm-Features: AbW1kvYDY2GfOWybPx1ziNhthMfZn9mdYJUKJ7Yu0TbPO9otNx3KXqZOl5bokwI
Message-ID: <CAMj1kXHe3d13vD=7p+5N8KLKBTB3Ka4g8HuW-h8enCrwjVO2uA@mail.gmail.com>
Subject: Re: [PATCH] efi: sysfb_efi: guard EFI-specific code with CONFIG_EFI
To: Yu-Chun Lin <eleanor15x@gmail.com>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	visitorckw@gmail.com, jserv@ccns.ncku.edu.tw, 
	kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 15 Jan 2025 at 16:21, Yu-Chun Lin <eleanor15x@gmail.com> wrote:
>
> On Wed, Jan 15, 2025 at 03:46:46PM +0100, Ard Biesheuvel wrote:
> > On Wed, 15 Jan 2025 at 15:17, Yu-Chun Lin <eleanor15x@gmail.com> wrote:
> > >
> > > As reported by the kernel test robot, the following warnings occur:
> > >
> > > >> drivers/firmware/efi/sysfb_efi.c:331:39: warning: 'efifb_fwnode_ops' defined but not used [-Wunused-const-variable=]
> > >      331 | static const struct fwnode_operations efifb_fwnode_ops = {
> > >          |                                       ^~~~~~~~~~~~~~~~
> > > >> drivers/firmware/efi/sysfb_efi.c:240:35: warning: 'efifb_dmi_swap_width_height' defined but not used [-Wunused-const-variable=]
> > >      240 | static const struct dmi_system_id efifb_dmi_swap_width_height[] __initconst = {
> > >          |                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > >> drivers/firmware/efi/sysfb_efi.c:190:35: warning: 'efifb_dmi_system_table' defined but not used [-Wunused-const-variable=]
> > >      190 | static const struct dmi_system_id efifb_dmi_system_table[] __initconst = {
> > >          |                                   ^~~~~~~~~~~~~~~~~~~~~~
> > >
> > > Unused variables, functions, and macro are conditionally compiled under
> > > CONFIG_EFI. This includes 'efifb_fwnode_ops',
> > > 'efifb_dmi_swap_width_height[]', 'efifb_dmi_system_table[]',
> > > 'efifb_add_links', 'find_pci_overlap_node','efifb_set_system',
> > > 'efifb_overlaps_pci_range', and the 'EFIFB_DMI_SYSTEM_ID' macro.
> > >
> > > Suppress unused symbol warnings and ensure inclusion only in relevant
> > > configurations.
> > >
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Closes: https://lore.kernel.org/oe-kbuild-all/202501051626.SMkizYIE-lkp@intel.com/
> > > Signed-off-by: Yu-Chun Lin <eleanor15x@gmail.com>
> > > ---
> > >  drivers/firmware/efi/sysfb_efi.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> >
> > Is your patch better than the one already in linux-next?
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=19fdc68aa7b90b1
> >
> No, Randy's patch is better because it also addresses the additional
> unused warning. Please ignore this patch.
> Thank you.
>

OK thanks.

