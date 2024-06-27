Return-Path: <linux-efi+bounces-1302-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B5EB91AE83
	for <lists+linux-efi@lfdr.de>; Thu, 27 Jun 2024 19:51:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 216D01F24ECF
	for <lists+linux-efi@lfdr.de>; Thu, 27 Jun 2024 17:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 260BE19ADBC;
	Thu, 27 Jun 2024 17:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N2nrl5Ds"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4CC19AD58;
	Thu, 27 Jun 2024 17:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719510657; cv=none; b=rqpVxhQZcsTFedfYd4ok2dc4ud5wW4Q1QwPwNSLmabyu4aAwrmmWAl5FXTZLlAvq4LVcc9Q236ULyljuGIfcTiVYAAGMeAS6wZ5lMyb9C/iadm4OggWZ/4gWfa5GT8kIEHfHRK85GPhP8aghkmKXAXT8mERN8odMaEi+jnzsiN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719510657; c=relaxed/simple;
	bh=YUjyg0q4v3BZyzysolzPu/T8WS3EYTPzZ+otN37RtXA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Nrb1GTlKXi9k+ztzpSU3FEjzHlfiqRQOM1vuRrmtUJHor55JRLA/BUfMv61GndYmXi55Vn2im1KrUVku5ykk0qYJRSmv3m4yvjDkXwuCHpRJuH+SxiIyjwc+bGa2lzfCu7LZexOAWM1Be0o+t4+eHCq6QWyrFkSaAiqczXUI5+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N2nrl5Ds; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C66C2C4AF0B;
	Thu, 27 Jun 2024 17:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719510656;
	bh=YUjyg0q4v3BZyzysolzPu/T8WS3EYTPzZ+otN37RtXA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=N2nrl5DseeenBGaeHfDLdEjo4/BG92v3NRt3x1NnXe6DxoxFD0JrT9SfThyrOF3qk
	 fTexPLpWMIcX00TfMNpyR9FGFm2dRthpim4bB/WKcas0F6hF3u4Cyy59Lygl0I0Nte
	 ImeWjAtKzA8sForbwTZ9YzyoTAlTwHlYGr9Q1DyDOPxl1sl9oGiaQQ7hipBe7NV8Nb
	 8L8hr69PEUERGq2MXhshdyS4RqosypRU5mUVWfkoxX03fz7nMTbpgbBpfbQ5cRK85U
	 pMfPII7jfFpCUW/fhA+4jTInUnnAxnDzIkazRxYJ02hQQa6xgOJRlaJa8fH/0AAxcL
	 +5pRHMl3AuNuA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 91B0FC433A2;
	Thu, 27 Jun 2024 17:50:56 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] riscv: dmi: Add SMBIOS/DMI support
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <171951065659.6762.4551986079431885211.git-patchwork-notify@kernel.org>
Date: Thu, 27 Jun 2024 17:50:56 +0000
References: <20240613065507.287577-1-haibo1.xu@intel.com>
In-Reply-To: <20240613065507.287577-1-haibo1.xu@intel.com>
To: Haibo Xu <haibo1.xu@intel.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-efi@vger.kernel.org, aou@eecs.berkeley.edu, atishp@rivosinc.com,
 palmer@dabbelt.com, paul.walmsley@sifive.com, xiaobo55x@gmail.com,
 ardb@kernel.org

Hello:

This patch was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Thu, 13 Jun 2024 14:55:07 +0800 you wrote:
> Enable the dmi driver for riscv which would allow access the
> SMBIOS info through some userspace file(/sys/firmware/dmi/*).
> 
> The change was based on that of arm64 and has been verified
> by dmidecode tool.
> 
> Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
> Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
> Reviewed-by: Atish Patra <atishp@rivosinc.com>
> 
> [...]

Here is the summary with links:
  - [v3] riscv: dmi: Add SMBIOS/DMI support
    https://git.kernel.org/riscv/c/d6ecd188937f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



