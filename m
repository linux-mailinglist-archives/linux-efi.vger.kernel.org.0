Return-Path: <linux-efi+bounces-201-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA4F811EF3
	for <lists+linux-efi@lfdr.de>; Wed, 13 Dec 2023 20:32:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BA862829D4
	for <lists+linux-efi@lfdr.de>; Wed, 13 Dec 2023 19:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41A4368275;
	Wed, 13 Dec 2023 19:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cs1cEFbq"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242CE68274
	for <linux-efi@vger.kernel.org>; Wed, 13 Dec 2023 19:32:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EA844C433C8;
	Wed, 13 Dec 2023 19:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702495964;
	bh=arkOPRpjyN9oCG6lpGJcVc0vKhzUAfYuFrlOmEQg2cs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Cs1cEFbqa46jqM/qLn67WzwWbeRkq/o2DfurDZ8ZAMe0EU2bBA1ngR9A4obWpcy7v
	 JHhhW61zZyKxAmMWyN66AsK8xfkV1pRCDboXpUKB4rm6srAf68oxarcdPQ4MX3fLIR
	 q9EZK46YUuH/2rUe3YBYTFWAeTj9r2RNkHwZIjXa4Q/Mc0nxwqf5BPaWPhF9IYvX2P
	 mBeqq3QjVBKq8qXBIBYJLOTDrOaBmkKwFxGnpIrxvVve5swld3+prZpFQc/oCgneK1
	 kXvy6rc3MjYFqqlwyNVelBMvDh1pSfZ8HVMGNjB6l9v0jqjh0Dwne56gb3qHK84LPD
	 cg0ZvKaSfnU4g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D86DFDD4EF0;
	Wed, 13 Dec 2023 19:32:43 +0000 (UTC)
Subject: Re: [GIT PULL] EFI fixes for v6.7 #2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20231213145121.2935172-2-ardb@google.com>
References: <20231213145121.2935172-2-ardb@google.com>
X-PR-Tracked-List-Id: <linux-efi.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231213145121.2935172-2-ardb@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-urgent-for-v6.7-2
X-PR-Tracked-Commit-Id: 50d7cdf7a9b1ab6f4f74a69c84e974d5dc0c1bf1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: af2a9c6a83a61bcaeb0fa4edc74762448926ef1c
Message-Id: <170249596387.3944.6215627320855910.pr-tracker-bot@kernel.org>
Date: Wed, 13 Dec 2023 19:32:43 +0000
To: Ard Biesheuvel <ardb@google.com>
Cc: torvalds@linux-foundation.org, linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 13 Dec 2023 15:51:22 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-urgent-for-v6.7-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/af2a9c6a83a61bcaeb0fa4edc74762448926ef1c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

