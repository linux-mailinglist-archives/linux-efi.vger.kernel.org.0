Return-Path: <linux-efi+bounces-1495-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3150793C2D0
	for <lists+linux-efi@lfdr.de>; Thu, 25 Jul 2024 15:20:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 638851C21C49
	for <lists+linux-efi@lfdr.de>; Thu, 25 Jul 2024 13:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E06B819B3ED;
	Thu, 25 Jul 2024 13:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oY9sJyJ7"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B498B19B3D3;
	Thu, 25 Jul 2024 13:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721913639; cv=none; b=Wx2APlDHQM7WQIj4n81xbg4L1DynNwFTEPu6d/juciD/nX4Ei/0vmUjTejDxGiC9cSflOGLWTuqGvzFoMPW7Cz5txz+N/F535y/7YIou0JWWKp43Vl/knTDu4VRNR2iPpD1oUyGJfvf9B5kVYIQsaQcElyLuwRxN9VHoM7L5ugk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721913639; c=relaxed/simple;
	bh=+MlYyIuitgeiygKFo7/UYoHi1EF6YVBX3jSOd6GjwYc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JZL6k4Dt6tUauKIVF/ZkpgkKqUCCYzJ4JvW5EGG52ZqTs8Aijd8eVw0U4A1lPy/moiO7CEqvWMXqCnvUEOYqS2ZszQSPxqCKPEAYLhcsBOcRjV13BzX5MiyAzqIl29GSAvXB7SHYGhIYsj7PHfc+J8aKFYyvM24ZtwYMIGsOAWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oY9sJyJ7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 65B0FC4AF0B;
	Thu, 25 Jul 2024 13:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721913639;
	bh=+MlYyIuitgeiygKFo7/UYoHi1EF6YVBX3jSOd6GjwYc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oY9sJyJ7O7kRwfcrK726mdmcOgkTQLZWs2uP/x6CY6ycSd61tGCxrSNCpBFNPck3r
	 FgOaIr9kf2pNPtSEbN12Sd7h8pup4pzRGy33Mh+WWlF95D5VjaWJkxqh8dbkxKXUkI
	 mGI/xpqJaBvyu8/0ACMnHEc9XSLnd6bNY9csCfJcTGmbPL8gS0+mkNVP3W+5KC5Cll
	 JODgEUoEN2qzoG7KjEqmKbjfw7kAMXGrLm7ND0VAHk/4ukmpAIYNUVkRI0SRLnCgXe
	 jdICAuXs46yvp5CaVuf7o5ROg5iXVvrB4s0vkp829KNHXfTYYbtZKmORZG6S7xxfVC
	 kd6nNyZGV8myw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5B13EC4332C;
	Thu, 25 Jul 2024 13:20:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] riscv: enable HAVE_ARCH_STACKLEAK
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <172191363937.6240.7475127253705380898.git-patchwork-notify@kernel.org>
Date: Thu, 25 Jul 2024 13:20:39 +0000
References: <20240623235316.2010-1-jszhang@kernel.org>
In-Reply-To: <20240623235316.2010-1-jszhang@kernel.org>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, ardb@kernel.org,
 charlie@rivosinc.com, linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Mon, 24 Jun 2024 07:53:16 +0800 you wrote:
> Add support for the stackleak feature. Whenever the kernel returns to user
> space the kernel stack is filled with a poison value.
> 
> At the same time, disables the plugin in EFI stub code because EFI stub
> is out of scope for the protection.
> 
> Tested on qemu and milkv duo:
> / # echo STACKLEAK_ERASING > /sys/kernel/debug/provoke-crash/DIRECT
> [   38.675575] lkdtm: Performing direct entry STACKLEAK_ERASING
> [   38.678448] lkdtm: stackleak stack usage:
> [   38.678448]   high offset: 288 bytes
> [   38.678448]   current:     496 bytes
> [   38.678448]   lowest:      1328 bytes
> [   38.678448]   tracked:     1328 bytes
> [   38.678448]   untracked:   448 bytes
> [   38.678448]   poisoned:    14312 bytes
> [   38.678448]   low offset:  8 bytes
> [   38.689887] lkdtm: OK: the rest of the thread stack is properly erased
> 
> [...]

Here is the summary with links:
  - [v2] riscv: enable HAVE_ARCH_STACKLEAK
    https://git.kernel.org/riscv/c/0059748ce289

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



