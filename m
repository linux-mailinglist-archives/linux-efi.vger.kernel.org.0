Return-Path: <linux-efi+bounces-4959-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F71FBB9CAE
	for <lists+linux-efi@lfdr.de>; Sun, 05 Oct 2025 21:46:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D35763AA121
	for <lists+linux-efi@lfdr.de>; Sun,  5 Oct 2025 19:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69B03273FD;
	Sun,  5 Oct 2025 19:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EDNeQ9sa"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4528C78C9C
	for <linux-efi@vger.kernel.org>; Sun,  5 Oct 2025 19:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759693582; cv=none; b=qC894b7fSEdnYgBhchvWRbf0Tol6H0fJHDZjmcKRZE6JqDga7NwCRusdeUxjNiMD7GhZZ58ngtvbKzxYH8fzqLpNYQjZiA5atCemVaGCfUfyvMMGivpg8XYshvsbGWp9b8ZbRpoaqP6GJXJh6kqN3HAXb3qylTz0wx9nwgqpsmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759693582; c=relaxed/simple;
	bh=l1qnHurJrcFJssHaWqhNAUhol7SIJWv+Sj5QJgKVgzw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ClGm+UnB74xN78iZ2W+LX2Ev9294WXmk2qGwVi8EnubGz6Et6x6X4/3txVQ6tQj64sCkAEtWWijMybq5NOeRFxZncBWSq567OfXSd16NglEK86fILUKEi4QBF+HWsURkBlTexMlapLIWXZnpFTiE+ip8njNVtqDhK/nphqRUQ+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EDNeQ9sa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C858BC4CEF4;
	Sun,  5 Oct 2025 19:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759693581;
	bh=l1qnHurJrcFJssHaWqhNAUhol7SIJWv+Sj5QJgKVgzw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=EDNeQ9saH+l9zlP/B4q93TalHia+JkLfWDDmFFQbRUpAuny9p5gdIlG4k7dGkoMpe
	 oOg+BxD4m7VeJeRLUE25PilwULdT/CHFemjpFLUYoW7EtM2fF5UpZqN+9nUFw3rhGv
	 ia5PwG7sH8eBhe7l7Oj7kxfXF0qSxarmprRfz2p6H2kkCmNwyBgCrwhNElEagJVUzo
	 GxvudQO68zufU7oWoR6ErJOPh9/21MwpwandQDHESHnUnLCDQrQL7Aj2C/ocDXHhFz
	 1Kh2SdXjFPSIUq+gM4Ty9b+0GXlDLJTZkoiVwfUR5whfINW0JAV8CUDJIkqC41zPTI
	 VjmhE5dvYnFwQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C9639D0C1A;
	Sun,  5 Oct 2025 19:46:13 +0000 (UTC)
Subject: Re: [GIT PULL] EFI updates for v6.18
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251005185824.780948-2-ardb+git@google.com>
References: <20251005185824.780948-2-ardb+git@google.com>
X-PR-Tracked-List-Id: <linux-efi.vger.kernel.org>
X-PR-Tracked-Message-Id: <20251005185824.780948-2-ardb+git@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-next-for-v6.18
X-PR-Tracked-Commit-Id: 99da5bf3dd6a8cb951adcace6153c34c86547811
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cf0e371d2b0e25d115442a281a232922a6dc0d6a
Message-Id: <175969357183.726026.337187189707605705.pr-tracker-bot@kernel.org>
Date: Sun, 05 Oct 2025 19:46:11 +0000
To: Ard Biesheuvel <ardb+git@google.com>
Cc: torvalds@linux-foundation.org, linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>

The pull request you sent on Sun,  5 Oct 2025 20:58:25 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-next-for-v6.18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cf0e371d2b0e25d115442a281a232922a6dc0d6a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

