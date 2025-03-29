Return-Path: <linux-efi+bounces-3127-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9106A757CA
	for <lists+linux-efi@lfdr.de>; Sat, 29 Mar 2025 20:56:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 644EB16BB15
	for <lists+linux-efi@lfdr.de>; Sat, 29 Mar 2025 19:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 684F71DF97D;
	Sat, 29 Mar 2025 19:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BUtq19Cf"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4386B1DF96F
	for <linux-efi@vger.kernel.org>; Sat, 29 Mar 2025 19:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743278170; cv=none; b=RLaE4WrrdpGYmKQLYTQ+36NwTbzDM1+yyvBkbLCS517oFoXB+8WGOkVzKa4HvL2kLXA9BOvQ9uMUlg5Fq9uUx8bjZztPjNJzR2LwLyPdZ/coPfSbbz6pB18A7BknjCPXlTohszDY78cQh3HaPaGbRf+nk4F5Pa4kMWV9rO8ihXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743278170; c=relaxed/simple;
	bh=lKwRoTv2PiZWXQBFNlL+AWHJyV+U2koG561vU4sJlvs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=gTf0AtnyEQc6hTPhEm2lJswdmEgUGOQWnImWXgBWAb974zYIT7EAUdBBWuPHdyO7Q7t9K/5kqSCe6FceVhSX9PeNT63vH0YcG7pMmuNco3jJCLAZ3VMshoc95sCrF2AimG2u3wBAuZziYzmZcp4XNvjmPJY5pxYzOlPaSfdcZT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BUtq19Cf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAD59C4CEE2;
	Sat, 29 Mar 2025 19:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743278169;
	bh=lKwRoTv2PiZWXQBFNlL+AWHJyV+U2koG561vU4sJlvs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=BUtq19CftFlK1Ys58asmlddoQI+5BsoRjmVXG4HWak7hU0Ke3oyQx1N8PO7shy802
	 7ChBHEQmTr+wvCK4iAsLVdo3k1PTseq05DtFqMnTsMkMgO2MwM6bp1aM9I9ZhaZJXz
	 OQlROosKx5PAnnUDySWsFoQTV2wY8qXTkH85vwHI3kgAs0mWXk5Y8uJbSjd5609NWA
	 Zx+IVdkiCv3iBNcMVkaBF0GsHbnSzrFIb9Vd29QCHixDAum+RYBvCf/QX8Mk6bL/IH
	 laI46defI5PAbYpwrA2HhzSlKiHM2UleYlXum+WP/EB3aBQ5RmEhd1Q/qelvNLVLvs
	 9xRjg7ZkaFhgg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70CFA380AAFA;
	Sat, 29 Mar 2025 19:56:47 +0000 (UTC)
Subject: Re: [GIT PULL] EFI updates for v6.15
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250328070525.2248563-2-ardb+git@google.com>
References: <20250328070525.2248563-2-ardb+git@google.com>
X-PR-Tracked-List-Id: <linux-efi.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250328070525.2248563-2-ardb+git@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-next-for-v6.15
X-PR-Tracked-Commit-Id: 0dc1754e16b4c14ae42f6cf59f319331d885f0f6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1fa753c7b5b91c31a8efc80d74acbbfb391a9e7c
Message-Id: <174327820596.3264055.1347699871099429437.pr-tracker-bot@kernel.org>
Date: Sat, 29 Mar 2025 19:56:45 +0000
To: Ard Biesheuvel <ardb+git@google.com>
Cc: torvalds@linux-foundation.org, linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 28 Mar 2025 08:05:26 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-next-for-v6.15

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1fa753c7b5b91c31a8efc80d74acbbfb391a9e7c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

