Return-Path: <linux-efi+bounces-3492-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 834A2AA1C25
	for <lists+linux-efi@lfdr.de>; Tue, 29 Apr 2025 22:28:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E31F346807C
	for <lists+linux-efi@lfdr.de>; Tue, 29 Apr 2025 20:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09771221719;
	Tue, 29 Apr 2025 20:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P7MDiaRg"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D951A20C488
	for <linux-efi@vger.kernel.org>; Tue, 29 Apr 2025 20:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745958479; cv=none; b=FCXMM3q3dghzeuJ0fp5ChjoncmyLuIYp68n/+Izzufs8BzQ0V76cpkOU4DqMw0ls7n4YqwhNh6ywup6/Q6G8FzE1QnvBFt0MvlsTbuzsYhYMQF72hZ5JY5N5JUPkUu20/rvAJKebcQDS5on6iwz1DnpcYMp5q9NEUVczI99G3g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745958479; c=relaxed/simple;
	bh=9J1ANQqn1yr9mnX6xHnNtgfw3Q2ObOUMWnL3aippGSQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WAKTobg5u47P/jfO+qjUNrf9wHq/dBMusr2TJrs5st97KhbIPhWG5K1m5Qo8h9Fuz2HG6Xt5Kvz1B/LDIQRopNgnk0m/8hma6x+7diyhTcGqZPyIl4mMAfQnPU61ImhjNzLNoXwJtZMI/aeIwE9bgs29z8HFhNmFphzJ2D6E/IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P7MDiaRg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9751CC4CEE3;
	Tue, 29 Apr 2025 20:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745958479;
	bh=9J1ANQqn1yr9mnX6xHnNtgfw3Q2ObOUMWnL3aippGSQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P7MDiaRgybpohQjp4GjO4Z39TgzTvlzoBdx2vATKvlSSjzuV0h2hykX+DoYsLGQD0
	 ic66/LYBCgWDZt8ffk3Y8nMDxP5g6foKaA6BvrE4xwUurCS5QT9LmyVc6ry/RJWOi/
	 Cgz5SGH8175/2Zq1NIHRaLl9e1qhuBnO6kFISMz7AxxKS4+t8wNFqJnTgZdyv+3NAm
	 E1y4b8x5P85gmoxoRGCMK5bl7meF0G3RBsuVoA3U207BOOYKDPzZvbKPNCiHsOs3/c
	 z5SD1cQQUZHxnxpX+oEd6CmUHpCwiYGs0j8YxmDUFV67ieB0wL9AjUam3TiVARRvaw
	 6V9jwVhglm7VQ==
From: Will Deacon <will@kernel.org>
To: linux-arm-kernel@lists.infradead.org,
	Ard Biesheuvel <ardb+git@google.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	linux-efi@vger.kernel.org,
	mark.rutland@arm.com,
	broonie@kernel.org,
	Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH] arm64/fpsimd: Avoid unnecessary per-CPU buffers for EFI runtime calls
Date: Tue, 29 Apr 2025 21:27:42 +0100
Message-Id: <174592883277.423204.10036906731229945415.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20250318132421.3155799-2-ardb+git@google.com>
References: <20250318132421.3155799-2-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 18 Mar 2025 14:24:22 +0100, Ard Biesheuvel wrote:
> The EFI specification has some elaborate rules about which runtime
> services may be called while another runtime service call is already in
> progress. In Linux, however, for simplicity, all EFI runtime service
> invocations are serialized via the efi_runtime_lock semaphore.
> 
> This implies that calls to the helper pair arch_efi_call_virt_setup()
> and arch_efi_call_virt_teardown() are serialized too, and are guaranteed
> not to nest.  Furthermore, the arm64 arch code has its own spinlock to
> serialize use of the EFI runtime stack, of which only a single instance
> exists.
> 
> [...]

Applied to arm64 (for-next/efi), thanks!

[1/1] arm64/fpsimd: Avoid unnecessary per-CPU buffers for EFI runtime calls
      https://git.kernel.org/arm64/c/e04796c8b598

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

