Return-Path: <linux-efi+bounces-4525-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 335DAB1F535
	for <lists+linux-efi@lfdr.de>; Sat,  9 Aug 2025 17:21:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BC0A160F04
	for <lists+linux-efi@lfdr.de>; Sat,  9 Aug 2025 15:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0CC52BE629;
	Sat,  9 Aug 2025 15:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BoWKKHH8"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A44A2BE7B5
	for <linux-efi@vger.kernel.org>; Sat,  9 Aug 2025 15:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754752832; cv=none; b=TEtxM7ZCw749jJ1nrTIIjkkill/ohgGQ/jG+kQzCvefC3DQhvqK7RmdPuj6HeXjPfUzID21GiF0t1mvS3F9RIk2lFjM1jbL0mB4SKtseKtm5/5oRMOc+GDDAlwPaGhBysz2l6Mj1FA6I8Enj/2M9HxC89VZJg1KVnUOZyAR4oIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754752832; c=relaxed/simple;
	bh=gL2T0LaBokhrnUIcBxysE7pvMb13Xy38hqxUQ68/R5U=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=DZ7FiX/djXliwSqtO5ggG9CYtHHj923n5GX79GneJ3LaYjOe//s+zNLbohfaKNKxWa9G0Nu+Ki6zfPuype4YA8/wO3X58YM3sWTlHsXnr4YOX7QVVIAf6nKfKHqM94lMOJeUaubk1XHPXv+HaHauBz1Pe7KMXf1iE5mbYBk+Ly4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BoWKKHH8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1EE1C4CEE7;
	Sat,  9 Aug 2025 15:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754752832;
	bh=gL2T0LaBokhrnUIcBxysE7pvMb13Xy38hqxUQ68/R5U=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=BoWKKHH83GJ34/KwwjJn58wBftcTjo4qM+kfGkIRFRexMluvzLj2YVS6slfvgIu7P
	 IKOzeKTC6mgoRa34aYDlbv8RnvVzHatzrykj7OTBZnAG6MLaJKwKJnVs18ZEARWPYg
	 eMxL0k7GXNRvGJuitIXJ5pBcmf0wdfBmlj3Xotfe8Va9eQBDR+6lPTIl2A5RvZkTB6
	 lWg/3QpDEpfo3X0K+4M+Ok5aDNjmE/Fv+SwZhRFjMOLPfCNdSRpr/G92FlWxkX3Y4B
	 FK0u0jMVDTH6rO/1K1+kYNVuxiZB7W/NZ22GWaEyHNHFBNwCFkaEhUjtEU5rDulbU2
	 8XJXV/jfmwCjA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E40383BF5A;
	Sat,  9 Aug 2025 15:20:46 +0000 (UTC)
Subject: Re: [GIT PULL] EFI updates for v6.17
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250809075242.54020-2-ardb+git@google.com>
References: <20250809075242.54020-2-ardb+git@google.com>
X-PR-Tracked-List-Id: <linux-efi.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250809075242.54020-2-ardb+git@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-next-for-v6.17
X-PR-Tracked-Commit-Id: 02eb7a8eee20b9ec6aafd5e17c5c41b53e8b13ef
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 402e262d77cd8b075a56809e30e6903ef648ad1a
Message-Id: <175475284466.507787.12648036470271359626.pr-tracker-bot@kernel.org>
Date: Sat, 09 Aug 2025 15:20:44 +0000
To: Ard Biesheuvel <ardb+git@google.com>
Cc: torvalds@linuxfoundation.org, linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>

The pull request you sent on Sat,  9 Aug 2025 00:52:43 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-next-for-v6.17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/402e262d77cd8b075a56809e30e6903ef648ad1a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

