Return-Path: <linux-efi+bounces-812-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0968987B3BD
	for <lists+linux-efi@lfdr.de>; Wed, 13 Mar 2024 22:47:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5CF4282925
	for <lists+linux-efi@lfdr.de>; Wed, 13 Mar 2024 21:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AAFC54919;
	Wed, 13 Mar 2024 21:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H9iR/jbL"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443DB4E1CE
	for <linux-efi@vger.kernel.org>; Wed, 13 Mar 2024 21:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710366445; cv=none; b=DIy8/883KmPOlJfoWnG0M7PgDZ0xzgxooLTqiEaULymSwduaFZp3joaPIrBOAGBBby4tF1SQ2+l8MRA7R5c0OX+8WJqKZvBj0F45AW4W7wZSDP4rRXIMfcW9xDZrkLeksAZz81au8M1nBCS06vXz52fEsoZIqIUglbo0mytasto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710366445; c=relaxed/simple;
	bh=s43iHgzVxeumP6f+DLyCjm1F+KCTO88NRjmxZdVEB0E=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=sia/GkvaUYJmqlz13Iiy+aP4sUYSGeQSE9jxFjRJRCynqXlkt1+r4mkc1yptDic6MMcIhqn3iG3KVaig8Zymu/VWmBanqpb+igk+PGrMMCPYGgbZO2QaR+sycOmX8sOc6An1/DBXecxj9+7b2DrubHVfPMtiT+55LiPzJekFblE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H9iR/jbL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1F146C43390;
	Wed, 13 Mar 2024 21:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710366445;
	bh=s43iHgzVxeumP6f+DLyCjm1F+KCTO88NRjmxZdVEB0E=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=H9iR/jbLL2riqtAgDMCjL5LvHrZm66a3ytwgXd89/l2FSQGGAwk2ZAWkE816YvYUT
	 v5z7GZqLoffaQnLTKnPtZECVjhPZnnmQlNc83HdOjEEJqUibX5d2JFpGYvzxeKfF0C
	 hBReqB4uZqxkZ84brAL+l4xxzhEwGeEVUBqSj7CzHI3DDKTjeeBHeipDalKMu75Zgg
	 XW6grWkqrnkYFFCONt79VNh34bgdGpWB5Xu80R3+jzknVcrY1Vx918m/6e/8dUHtVI
	 GNlnVDFqoUkQGG54RZBid24HCGjhd7IJtI7iWPt3c3dXcUpKrEbkSZ+XxFWMKtJo5Z
	 FilmizxTLL9KA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0CF12D9505F;
	Wed, 13 Mar 2024 21:47:25 +0000 (UTC)
Subject: Re: [GIT PULL] EFI updates for v6.9
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240312175137.2185208-2-ardb+git@google.com>
References: <20240312175137.2185208-2-ardb+git@google.com>
X-PR-Tracked-List-Id: <linux-efi.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240312175137.2185208-2-ardb+git@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-next-for-v6.9
X-PR-Tracked-Commit-Id: 021bc4b9d7ed8dcc90dc288e59f120fa6e3087dc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 70ef654469b371d0a71bcf967fa3dcbca05d4b25
Message-Id: <171036644503.31875.6350874192637594035.pr-tracker-bot@kernel.org>
Date: Wed, 13 Mar 2024 21:47:25 +0000
To: Ard Biesheuvel <ardb+git@google.com>
Cc: torvalds@linux-foundation.org, linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 12 Mar 2024 18:51:32 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-next-for-v6.9

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/70ef654469b371d0a71bcf967fa3dcbca05d4b25

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

