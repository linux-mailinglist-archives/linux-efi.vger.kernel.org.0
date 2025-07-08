Return-Path: <linux-efi+bounces-4194-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7268AAFCE13
	for <lists+linux-efi@lfdr.de>; Tue,  8 Jul 2025 16:46:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1925F162A45
	for <lists+linux-efi@lfdr.de>; Tue,  8 Jul 2025 14:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D94A62E092C;
	Tue,  8 Jul 2025 14:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EmjvtRUW"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1792E0926;
	Tue,  8 Jul 2025 14:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751985874; cv=none; b=baFfGzvhUzrTjoyMGUO2ERaQeOwzOcVr9lNqSsZrwKEk8ZXGsQ/uErCzl5XsFLY2Rtu7v6lWaACAaBtXAzRl+jeO3Ze3MoVMcnmublE+Jdj1LmLdS7GqZP5DUWFxdEYAGYrzShlzlyKUGItCxBW0vme4QnvIBdG1SKBUTZFDJWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751985874; c=relaxed/simple;
	bh=QridMkOK0YqX6hbQPzkAyoXJEIuvYn2g0pFiuRfJKVI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S29vVqfnzqTT5GR7iP2L0CLMUz4bhqO9q9wzhYiLXUgO+J45K8Nmj545FK+c5s/LogeJQDw+GDsNMKHoxlr6uAIa7/1yNEZ+30KszN29D5yyXNu5/e+UXaAglPyNrKhdsnuM/AyYJmLM/gNTvTEaF9v04nbA3Px9cSA5dUUxfiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EmjvtRUW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B93EC4CEEF;
	Tue,  8 Jul 2025 14:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751985874;
	bh=QridMkOK0YqX6hbQPzkAyoXJEIuvYn2g0pFiuRfJKVI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EmjvtRUWWWf3iWW3ILgSBf2/s4y1eAK92Dya5s0xzZhUyBO7SI9+S72UjV2o4lLsN
	 LtB8AKyx70rrPyKShARWj0sMRhHeSL4/C5g96uAc97flRWmlhlI+BhR0T1oAwRkSP4
	 6/50eLOZetfzfck250nSp65pr+TAfSgtaU8d/xwnD7JIcr4WsD81gFi7V25pcFxnI+
	 pmSrMzm2bVyL0WJSQQZCqFon5qPDiW+UEnmrHtXinILcROfTEi7Lv0Wto/+vRvNk3f
	 vm0hgqpcXJ83wlLffPb7bGnRiFJDSM43oJtKwUAA/X+Gb+8UTS0gzUgD9hm+7qLyxV
	 B02ZJ1vjbLpAQ==
From: Will Deacon <will@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	Ard Biesheuvel <ardb@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>
Cc: kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	linux-kbuild@vger.kernel.org,
	linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: fix unnecessary rebuilding when CONFIG_DEBUG_EFI=y
Date: Tue,  8 Jul 2025 15:44:22 +0100
Message-Id: <175197993018.4066442.18264778907908818556.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250625125555.2504734-1-masahiroy@kernel.org>
References: <20250625125555.2504734-1-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 25 Jun 2025 21:55:20 +0900, Masahiro Yamada wrote:
> When CONFIG_DEBUG_EFI is enabled, some objects are needlessly rebuilt.
> 
> [Steps to reproduce]
> 
>   Enable CONFIG_DEBUG_EFI and run 'make' twice in a clean source tree.
>   On the second run, arch/arm64/kernel/head.o is rebuilt even though
>   no files have changed.
> 
> [...]

Applied to arm64 (for-next/misc), thanks!

[1/1] arm64: fix unnecessary rebuilding when CONFIG_DEBUG_EFI=y
      https://git.kernel.org/arm64/c/344b65804724

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

