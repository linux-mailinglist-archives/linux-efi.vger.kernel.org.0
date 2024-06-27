Return-Path: <linux-efi+bounces-1303-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C0491AE84
	for <lists+linux-efi@lfdr.de>; Thu, 27 Jun 2024 19:51:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2ECAF1C20829
	for <lists+linux-efi@lfdr.de>; Thu, 27 Jun 2024 17:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30DBC19B3CA;
	Thu, 27 Jun 2024 17:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SblkWJY/"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069B319AD84;
	Thu, 27 Jun 2024 17:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719510657; cv=none; b=Hkt5hK0yZmdP9jFDLMa46FWrQ7A1zT4mbERWMlsT2cDaZKSFazlNtqHJOvR3ZOlMDo1UuG+SlpdSqQ2E12bZ4W46+8kL0Mh5bh1n2nDOrAnOyJ9ETTikM44MWBaiLr+YgUCnk/GAcc2UpJG39ySx14v2vjW+uqFF0eWm4D8SLZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719510657; c=relaxed/simple;
	bh=sCGQGQxJiBD5/Y8j6GuCFc7vlBp1iI+va/SqoCObG/I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MLhPJb/427DXsPQIDB4PzrsfLt+A6W2mUg7K5N6uGAjn7zpJAlegOfP/Rzl3OlSfVtCtdBiC3JM96HVXz8wyoYNmo7CjirIeuy2cEjtV2pIrwhCY9G/QRBjpPTx5J7XvsEWeDV2eiLapV9V3ehkPWpW2gR8EDYkJ9eJ/6LO3Iw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SblkWJY/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9E10DC4AF0F;
	Thu, 27 Jun 2024 17:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719510656;
	bh=sCGQGQxJiBD5/Y8j6GuCFc7vlBp1iI+va/SqoCObG/I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SblkWJY/ll1wu4pm/Mdyb4YsRxxavO/+xBrudwei8G9ZmSTYZrZMSVtT6B9SRe9cv
	 yyLYvCwWAaQD765wteS336iFD6Cc+NPEhKhkUWf9BUE5Lz5K+lLeMrmMoLZS2giQUz
	 d4QRtt4VNE++NQNKPl2iozQAKYkSc/9yuR2XT9oVywMPS3XuAwK3NvX5bqdaVVeM0M
	 unakWCsygbEMqhAzQ67t40e5D5B3a4m/lA5/cUD8dmtKJf1DaN+XSG4EP3bkRyNFnv
	 omqoBNlJ22BHBnzPT7wPEu0x+XoRVzO2SrgRxWMuf+e9tcR5HvLsk1xtAhNtSvO+ge
	 ej03X6atPJcdg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 86C7DC4333E;
	Thu, 27 Jun 2024 17:50:56 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] riscv: dmi: Add SMBIOS/DMI support
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <171951065654.6762.8929081734470449376.git-patchwork-notify@kernel.org>
Date: Thu, 27 Jun 2024 17:50:56 +0000
References: <20240318020916.1299190-1-haibo1.xu@intel.com>
In-Reply-To: <20240318020916.1299190-1-haibo1.xu@intel.com>
To: Haibo Xu <haibo1.xu@intel.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-efi@vger.kernel.org, aou@eecs.berkeley.edu, palmer@dabbelt.com,
 paul.walmsley@sifive.com, xiaobo55x@gmail.com, ardb@kernel.org

Hello:

This patch was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Mon, 18 Mar 2024 10:09:16 +0800 you wrote:
> Enable the dmi driver for riscv which would allow access the
> SMBIOS info through some userspace file(/sys/firmware/dmi/*).
> 
> The change was based on that of arm64 and has been verified
> by dmidecode tool.
> 
> Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
> 
> [...]

Here is the summary with links:
  - [v2] riscv: dmi: Add SMBIOS/DMI support
    https://git.kernel.org/riscv/c/d6ecd188937f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



