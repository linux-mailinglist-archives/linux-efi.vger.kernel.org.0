Return-Path: <linux-efi+bounces-3213-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DA5EA7E8E7
	for <lists+linux-efi@lfdr.de>; Mon,  7 Apr 2025 19:49:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5378A44064E
	for <lists+linux-efi@lfdr.de>; Mon,  7 Apr 2025 17:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ADAA219A90;
	Mon,  7 Apr 2025 17:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fylVSXqB"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E1C21767D;
	Mon,  7 Apr 2025 17:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744047861; cv=none; b=MGJjr4OxRnA+UiJ/4bjUs8s6GjSs9C8TDtW3cGOEg6OVYQY0zgUChTs6ZDf/FboZ6iduDv9xncOm24b+bS5hqBMeMRsk0WiftGnUEWtVZEI+o5GjakcLE8fyx1lm0Bc8V0IBU873SB/bHbZzCU+WCi5mn89r3WOLjmAbp9dpfsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744047861; c=relaxed/simple;
	bh=uT127XyRmsORoueF/P1WDngVjVymYta/zCNZ39Oz6rs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lMycrrWDko2k3WQt5L6HlETHm86QcWhVu2RfOSamm4QdzTTmPUcBvu//pW0nD28nJ26ayEWOiUteJ9WXm1TpdnW5h5hiqJw2Cj6DWyB9U22jwHria8ZQP+IrLu2FU1sRPuCojzaJGU8phlsRCaiZKkMpcd2nQrOeoVgy5P+zaLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fylVSXqB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9B5DC4CEE7;
	Mon,  7 Apr 2025 17:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744047861;
	bh=uT127XyRmsORoueF/P1WDngVjVymYta/zCNZ39Oz6rs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fylVSXqBqrBAEJCuhxrvwqznUR7qFx7d6qMtLZgUXKgmxZZKDuSVwIfgW0y5gSdeR
	 IJl04VYhYsh0uG34EjX4zQOY5YnVZ9/8NJl+y83o/cHZ1vCjx5Atv/r/S+BzqN9Ltv
	 dVD2TzsYZPHxahEYx9TcXYuaxOdgy7FNL6P+1oPT4D3YP/Dp7oJpIEg5wTDQl30DRa
	 +Jq1gZ2pJXYoAhIgfY+eO2dCrTnphs8SepJdMyTbkJnkC0m+F2LmaVtS0UHXctJRKu
	 6r1irs1ddZhNubrSk9xEqhOBdjmuTrtqjDSFAcPSxsg1d65aTnlMulMm6JPUniwrMN
	 5sS7JW1wV1W4Q==
Date: Mon, 7 Apr 2025 19:44:17 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Ard Biesheuvel <ardb+git@google.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH v2 1/2] x86/boot: Move early kernel mapping code into
 startup/
Message-ID: <Z_QO8QybPCwzRwms@gmail.com>
References: <20250407061132.69315-4-ardb+git@google.com>
 <20250407061132.69315-5-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407061132.69315-5-ardb+git@google.com>


* Ard Biesheuvel <ardb+git@google.com> wrote:

> From: Ard Biesheuvel <ardb@kernel.org>
> 
> The startup code that constructs the kernel virtual mapping runs from 
> the 1:1 mapping of memory itself, and therefore, cannot use absolute 
> symbol references. Move this code into a separate source file under 
> arch/x86/boot/startup/ where all such code will be kept from now on.
> 
> Since all code here is constructed in a manner that ensures that it 
> tolerates running from the 1:1 mapping of memory, any uses of the 
> RIP_REL_REF() macro can be dropped, along with __head annotations for 
> placing this code in a dedicated startup section.

So would it be possible to do this in ~3 steps: first the mechanic 
movement of code, with very few changes (if the result builds & boots), 
then drop the RIP_REL_REF() uses and __head annotations in two separate 
patches?

Bisectability, ease of review, etc.

(The tiny bird gets the worm, but I might have butchered that proverb.)

Thanks,

	Ingo

