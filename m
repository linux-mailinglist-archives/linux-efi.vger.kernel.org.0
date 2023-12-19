Return-Path: <linux-efi+bounces-256-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C143818630
	for <lists+linux-efi@lfdr.de>; Tue, 19 Dec 2023 12:18:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07270B22783
	for <lists+linux-efi@lfdr.de>; Tue, 19 Dec 2023 11:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F024914F9F;
	Tue, 19 Dec 2023 11:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d2wg9Ks5"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C262D168C0;
	Tue, 19 Dec 2023 11:18:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A667C433C7;
	Tue, 19 Dec 2023 11:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702984723;
	bh=yl0m/eWPjphXiy8uk34FxNH5HtArYrpYKC04XRSsfqE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d2wg9Ks5Mj61RI6kz4yht9d22GwNbzvbWhFeg2ygHnARyRA7EabKyH5akS6wNnhAs
	 g0pobqzaPHBU13lI3R6XM75d9Meovlblf+D7qENndRPUwWZzzproFO0+clSl60SPIf
	 Yr4IoUMwZh19QrEJ/1Dt16OflTObeVwUpSmp4Wrd+p2QWDMa9OAX9mmvTnowd9lyxn
	 EORZDy8LyhLZBnPo+/Ygdks/yaIBIYy7p4kw1zshx+sFzj9syZ7qD3a19SfGQfNVBU
	 tYbvOqo1vUYvn506THzCoM8jDUr86MHfT4jGDHDP8JC1pOVGLRticHzKLiPJiIr2R0
	 3c/qVFbtMiAMQ==
From: Will Deacon <will@kernel.org>
To: Ard Biesheuvel <ardb@kernel.org>,
	linux-efi@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	linux-kbuild@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] efi/libstub: zboot: do not use $(shell ...) in cmd_copy_and_pad
Date: Tue, 19 Dec 2023 11:18:31 +0000
Message-Id: <170298016046.1509472.12688198177716250949.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20231218080127.907460-1-masahiroy@kernel.org>
References: <20231218080127.907460-1-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 18 Dec 2023 17:01:27 +0900, Masahiro Yamada wrote:
> You do not need to use $(shell ...) in recipe lines, as they are already
> executed in a shell. An alternative solution is $$(...), which is an
> escaped sequence of the shell's command substituion, $(...).
> 
> For this case, there is a reason to avoid $(shell ...).
> 
> Kbuild detects command changes by using the if_changed macro, which
> compares the previous command recorded in .*.cmd with the current
> command from Makefile. If they differ, Kbuild re-runs the build rule.
> 
> [...]

Applied to arm64 (for-next/kbuild), thanks!

[1/1] efi/libstub: zboot: do not use $(shell ...) in cmd_copy_and_pad
      https://git.kernel.org/arm64/c/97ba4416d6dd

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

