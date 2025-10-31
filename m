Return-Path: <linux-efi+bounces-5278-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D053EC23D14
	for <lists+linux-efi@lfdr.de>; Fri, 31 Oct 2025 09:32:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 28D7C4F6691
	for <lists+linux-efi@lfdr.de>; Fri, 31 Oct 2025 08:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 623322E8B78;
	Fri, 31 Oct 2025 08:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="DnjgTqkn"
X-Original-To: linux-efi@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647CA2D23BC;
	Fri, 31 Oct 2025 08:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761899289; cv=none; b=fHfwYTzDuhdrAuuI+5q50KFY9nkSpI37z6BpS8XxuBoijxbO3EtLIFfBvVxpWoc7CzrOv2cfp107Aw810WnmIRN+rMViT8yKx4A9E8MRpg3AqD6Ht2IInJj9bni6TIZjohIRtwGNQFTDJ+G17iugOvfHaSJA4PozKwa3Asburz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761899289; c=relaxed/simple;
	bh=oXSCbUz3maeKFgjhdWEeJ5FVids98Vl53dBlq39zFG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J9JK57m+s0EGMb6DunElm/7/gRy6MlHzlCV0LA75O6kbHMdnu2/IC0FwWOlpMQ3mSSZOnQWt/uobiWM/nhf3e9RNTaepw1GvdoHCWuf17ySHgOflMrqHiZ6Y1DTV2MNw8aRVlUAx9t/jTMlTgTSA+k4r5RUUNul9vdmaWe8L4VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=DnjgTqkn; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 299C925F65;
	Fri, 31 Oct 2025 09:28:02 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bpGDuZIzpou9; Fri, 31 Oct 2025 09:28:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1761899281; bh=oXSCbUz3maeKFgjhdWEeJ5FVids98Vl53dBlq39zFG8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DnjgTqknrUlT5ugGxzUreNCyOhmINJ8PqOdB8p8KvRmaBkcqWJrkN9+CDzBURk/t4
	 Lefo7EpR7acVodgW1fgYj1RcP++0dp99bbh6hqSbyN8+G0P7D74c/9XZ6UU63LQWaS
	 NmDZLlwjQVBdZYbtmYDtuS2Ea/2h1H6YCOruYM0JIjBARh8G9dAQMn0XtW7g5EeEva
	 SoxqL8fIWN1+APR6ysTkO+Mma+R2lWvWkwk4F0vRktMDTl3zh/eogqHNL/0fhXPb89
	 S3QOUoFqn7+65cyBBLffctmftAyg4k4M2rHeeI0w9PZX/wjYrSopRETPHSP6WyYhSr
	 NADUSmLqFi5Ow==
Date: Fri, 31 Oct 2025 08:27:48 +0000
From: Yao Zi <ziyao@disroot.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Qiang Ma <maqianga@uniontech.com>, pjw@kernel.org, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, alex@ghiti.fr, linux-efi@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] efi/riscv: Remove the useless failure return message
 print
Message-ID: <aQRzBOu5Ml9gJbEN@pie>
References: <20251031024328.735161-1-maqianga@uniontech.com>
 <aQQ3KUap1cB73HOm@pie>
 <CAMj1kXGxP_8FhZgD42iD-7pnnZgjez3mXkTZz69YAc5FPkLBMA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXGxP_8FhZgD42iD-7pnnZgjez3mXkTZz69YAc5FPkLBMA@mail.gmail.com>

On Fri, Oct 31, 2025 at 07:52:10AM +0100, Ard Biesheuvel wrote:
> On Fri, 31 Oct 2025 at 05:12, Yao Zi <ziyao@disroot.org> wrote:
> >
> > On Fri, Oct 31, 2025 at 10:43:28AM +0800, Qiang Ma wrote:
> > > In the efi_create_mapping() in arch/riscv/kernel/efi.c,
> > > the return value is always 0, and this debug message
> > > is unnecessary. So, remove it.
> >
> > Should we make efi_create_mapping() return void at the same time, if it
> > will never fail?
> >
> 
> No.

Oops, seems a silly question here. Sorry for the noise.

Best regards,
Yao Zi

